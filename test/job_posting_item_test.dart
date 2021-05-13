import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wazeefa/job.dart';
import 'package:wazeefa/job_posting_item.dart';

void main() {
  final Job jobTest = Job(
      jobID: "b71dd36c-3852-41bb-ab13-bfa09fff643d",
      type: "Full Time",
      jobURL:
          "https://jobs.github.com/positions/b71dd36c-3852-41bb-ab13-bfa09fff643d",
      createTime: "Wed May 12 13:56:16 UTC 2021",
      companyName: "expertlead",
      companyURL: "https://www.expertlead.com",
      location: "Berlin",
      title: "Senior Software Engineer (f/m/x)",
      description:
          "\u003cp\u003e\u003cstrong\u003eYour mission:\u003c/strong\u003e\u003c/p\u003e\n\u003cp\u003eWe are looking for a dedicated Sr. Software Engineer with both frontend and backend knowledge to contribute to our core platform. If you are passionate about building strong services that utilize computer science and engineering skills like high-performance services, high availability, distributed systems, and machine learning to build a state-of-the-art system, we would love to talk to you!\u003c/p\u003e\n\u003cul\u003e\n\u003cli\u003eHelp to deliver product features with cross-collaboration teams\u003c/li\u003e\n\u003cli\u003eSupport designing major components in softwares, systems, and features by analyzing, designing, developing, testing, delivering \u0026amp; maintaining deliverables\u003c/li\u003e\n\u003cli\u003eEnhance \u0026amp; support software code\u003c/li\u003e\n\u003cli\u003eMaintain project priorities \u0026amp; deadlines\u003c/li\u003e\n\u003cli\u003eMentor \u0026amp; guide other team members\u003c/li\u003e\n\u003cli\u003eParticipate in growing a healthy collaborative culture in line with the company's vision and values\u003c/li\u003e\n\u003c/ul\u003e\n\u003cp\u003e\u003cstrong\u003eYour skill set:\u003c/strong\u003e\u003c/p\u003e\n\u003cul\u003e\n\u003cli\u003eBachelors/Masters degree in Computer Science or Engineering or any related field\u003c/li\u003e\n\u003cli\u003eSoftware development experience in ReactJS, NodeJS, and GoLang\u003c/li\u003e\n\u003cli\u003eExperience with PostgreSQL\u003c/li\u003e\n\u003cli\u003eComfortable using CI/CD, preferable knowledge in git\u003c/li\u003e\n\u003cli\u003eFamiliar with Elasticsearch\u003c/li\u003e\n\u003cli\u003eKnowledge in Python and machine learning is a plus\u003c/li\u003e\n\u003cli\u003eExperience working in Agile (Scrum, Kanban) environments\u003c/li\u003e\n\u003cli\u003eSelf-motivated, proactive, desire to work in a diverse, collaborative and multi-national team\u003c/li\u003e\n\u003cli\u003eFluency in English\u003c/li\u003e\n\u003c/ul\u003e\n\u003cp\u003e\u003cstrong\u003eWhy expertlead:\u003c/strong\u003e\u003c/p\u003e\n\u003cul\u003e\n\u003cli\u003e\n\u003cstrong\u003eLearn and develop:\u003c/strong\u003e Full ownership \u0026amp; responsibility from day one and regular feedback sessions and career development support to further build on your strengths, complemented by a personal development budget of at least 500€ per year for each team member.\u003c/li\u003e\n\u003cli\u003e\n\u003cstrong\u003eWork from anywhere:\u003c/strong\u003e We believe in a “hybrid office”, granting you full flexibility to work from any country in the world or from our brand new office in Berlin Tiergarten/ Schöneberg. Our top floor office is right in the city centre and comes with a beautiful balcony for some after-work beers.\u003c/li\u003e\n\u003cli\u003e\n\u003cstrong\u003eHave fun:\u003c/strong\u003e We are a group of very ambitious, but equally down-to-earth girls \u0026amp; guys. Teamwork matters most to us and we organize regular team events - on- and offline- to stay connected.\u003c/li\u003e\n\u003cli\u003e\n\u003cstrong\u003eBe who you are:\u003c/strong\u003e It’s not about gender, race, religion, age, sexual orientation, colour, disability, or place of origin. We live diversity and cherish our multinational team. At expertlead we consider ourselves as equals and create a space everybody feels comfortable and happy to work in.\u003c/li\u003e\n\u003cli\u003eAnd yes, we have the obligatory foosball table, a Playstation and a fridge that is always full - at least until Friday afternoon ;)\u003c/li\u003e\n\u003cli\u003eP.S.: Our communication style is pretty much based on memes - so feel free to bring in your repertoire ;).\u003c/li\u003e\n\u003c/ul\u003e\n",
      howToApply:
          "\u003cp\u003e\u003ca href=\"https://expertlead.join.com/jobs/2250016-senior-software-engineer-f-m-x?pid=357a3b4531918760973f\u0026amp;oid=16477bf5-a9f0-4a1b-8799-42316be321b9\u0026amp;utm_source=github_jobs\u0026amp;utm_medium=paid\u0026amp;utm_campaign=single%2Bposting\u0026amp;utm_content=senior%2Bsoftware%2Bengineer%2Bf%2Bm%2Bx\"\u003ehttps://expertlead.join.com/jobs/2250016-senior-software-engineer-f-m-x?pid=357a3b4531918760973f\u0026amp;oid=16477bf5-a9f0-4a1b-8799-42316be321b9\u0026amp;utm_source=github_jobs\u0026amp;utm_medium=paid\u0026amp;utm_campaign=single%2Bposting\u0026amp;utm_content=senior%2Bsoftware%2Bengineer%2Bf%2Bm%2Bx\u003c/a\u003e\u003c/p\u003e\n",
      companyLogoURL:
          "https://jobs.github.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBdCtpIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--2cbf49949e459d03e9a32108855fc371c735f43f/expertlead.gif");
  testWidgets('Job posting items tests', (tester) async {
    await tester.pumpWidget(MaterialApp(home: JobPostingItem(job: jobTest)));

    final titleFinder = find.text(jobTest.title);
    final timeFinder = find.text(jobTest.createTime);

    expect(titleFinder, findsOneWidget);
    expect(timeFinder, findsOneWidget);
  });
}
