Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47981CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 13:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKG0h-0004r6-Ap; Tue, 05 May 2026 09:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vo068@csusm.edu>) id 1wK9Kk-0006kA-Cj
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:32:42 -0400
Received: from mail-northcentralusazon11013026.outbound.protection.outlook.com
 ([40.107.201.26] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vo068@csusm.edu>) id 1wK9Kf-0004c0-3G
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:32:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUP3GEpolKSR358xqLuxYmXEgsGPIdAL+8Tl7VP5dT6tHWyKkQ7ODD8dHchc0K9huuf6aGqBYlPDiHRhUqfxHt5uWPAlvsdGxLZgtIeboFP8ZfEdG61K7hngzar90MDvoaJ17P6HXcjfGJboNy17ShjANftRcwVZSNgibNSsoBAGTehQVJIW3f9s1SWGyLLaGL2M9rENIJaEgnVuTRjtAdcaOr2H1RKPRLuoK+bIYEftb50md6Q5mtKtMBKsfDDZVuEIfDnidZQnqahXXihq8yNA9xMlw56y5taSQYqJOuCLiaNI6OgNhAxACGIBikQiZ2ZqMZyf+sUVHbNLfoKNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23YEGzS45nS8GMp2FFdV3Hqolt+Q47/H3ue75wWyAp0=;
 b=rn8FrfWmuqQ2io1QZVS8xDmu5m8O1WGu4hpoxCVIfJrikMOpFf9YyZjlgf8uwd264s+IESf8OPBYkctBP1JMMfVaafGmGp0/RXskZ/JWmaP+QA5Wnzaa4v34b3znwpYRbgsRHCJd/fCZ7MFk4aA1zF7qqBI5Cedq5psWeDRgMx/yiivlPqOd1/0GeCqZW50e3zciLtERto4IjJwPhmHP+qjp1NCkORD2u2HDlAen2fR3gCsPEPBK9XMuBASf2Jxv5zUoNvCQmiAuRcsmqCIZJLhJbt6A4zA/wAqAxteq5ccaxiXf6w403by266vcIZostur7gSOh3JeXFbMqNnY7pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csusm.edu; dmarc=pass action=none header.from=csusm.edu;
 dkim=pass header.d=csusm.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csusm.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23YEGzS45nS8GMp2FFdV3Hqolt+Q47/H3ue75wWyAp0=;
 b=erJPA/dr0j940cwz17qofspC+cklRqZL2/vuuAi+0YrOw1D40CMqNSUFLyzm5LWkOgofRUS0VtrRr2MpJeqF3T/lwq7ML0Q5Fnd9AgBdrG91bODAXMJ6URb9BD9YGOsXtISzoiDNzNKvX1ZWVTMbXzcmcUovX54+HntL4eDRFk8=
Received: from BYAPR05MB6295.namprd05.prod.outlook.com (2603:10b6:a03:cb::16)
 by PH0PR05MB8414.namprd05.prod.outlook.com (2603:10b6:510:c9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 5 May
 2026 06:27:31 +0000
Received: from BYAPR05MB6295.namprd05.prod.outlook.com
 ([fe80::3693:f1e:6449:8644]) by BYAPR05MB6295.namprd05.prod.outlook.com
 ([fe80::3693:f1e:6449:8644%7]) with mapi id 15.20.9891.008; Tue, 5 May 2026
 06:27:31 +0000
From: Tyler Vo <vo068@csusm.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Implementation of AI policy listed in code provenance
Thread-Topic: Implementation of AI policy listed in code provenance
Thread-Index: AQHc3FXHuarwwO1o9EWSUI1hrLMFNg==
Date: Tue, 5 May 2026 06:27:31 +0000
Message-ID: <BYAPR05MB629521B4B070F968020109D1FC3E2@BYAPR05MB6295.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csusm.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB6295:EE_|PH0PR05MB8414:EE_
x-ms-office365-filtering-correlation-id: a9e32684-5374-48f6-d500-08deaa6f6310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|786006|376014|38070700021|8096899003|18002099003|56012099003;
x-microsoft-antispam-message-info: RTQ9G6ERUrfejZe+ttpIlRnbgd7fye5acCa00GYz3aH9vLAVt23f/FBt9ZaujLmSF21uepmP0Rt3SzISKBRcx6t0FF2iK47TVblVCEDmYgYJRR2Nwmhe7j70MoRh8PsWP/11T2k4ojcUMccv0nLSwrtuDEgifRJDXaP4FtsfSPjbjv32qEtlNK2lWF99AyWKWYNIAVSrDRt8ttLJluDND9NqL6MKUhQxQhLQ9qrY5e6uyiEpQzNiSIQrlps7gsxKFlYVTUh+c70WPq8L64QgqObXEdKhaSwr47hcrnafeycx9YWGwXwzrqBlLznFJYp0mCOjw2LuGfJCit7v9RmCyYlhhOzShBAsOtywcbr34ktxc84pI2S1zDGeBbCdRAIRUqK9ZO3Lz9t+E+k7j1TPOeMHCdQs8qrGo0BmEq9DEUymx7bX4Sj+IPRkM8u3ljBip1Szgv4lLkGg2H7dqDdYFCaJo353yd2lZ/5gstwwL5lzTd4Jd7NCiATS6+rGm+Hvf8fmzFogrof+V0AqQ1QUiRr3Q8T81q+oq1DStImvDq2F47hptT45O4P+iGUPXIZNSd+ZKEFBrGrF4wTdFwucOcW5Kij3R5nmv4jrmvKxO6elV3PFhrSnaIsWTwykg/RPrcj35Zsl+yvK/aqjYtXf17Cw6oMP9EUS/Ey8iNWnj3feECaoKTUrquvgyteV7ezd1vefn3Ljmf8O6hIq1C1uKaDaqRCrZt4aOx0PkIAD4TSA/pfuDrMpXS8qe2eFu0ct
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB6295.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(786006)(376014)(38070700021)(8096899003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xElc3BQVFIj7qiJdCRUbQhH+hCJxMG5fMzwpWqF8HgZ0Ew1KS14u45GJo1?=
 =?iso-8859-1?Q?/mEtzUyOIP58WmEZny2ZvVmoM4M2C5uxpV1uDuIH7O/yU53XZSvMMdBujW?=
 =?iso-8859-1?Q?hg3E+vPtSmw1O/a1cf4rmvEHJAACaYb7vwrixEgWdE8TwLcj5Q1YFHq88y?=
 =?iso-8859-1?Q?AooZPO4rQ0doUJxPmxkbMWx2l3ifJk124EbhH7ne4sq6sznX+BsdtD44rE?=
 =?iso-8859-1?Q?mwxHBDbfDihBuPKGLTuBuCfGBnnDDXbMNc7ycRdlDpD0hVLdbXs0gEJnPZ?=
 =?iso-8859-1?Q?O5L80xxwcjdK1n9SeE/Ba85I2fW4gcj+OG43t72vo2jepl4lB/z1GVXxxJ?=
 =?iso-8859-1?Q?XopboQ/Cp/mJ60ob4Ncas9C1rGAW007CdrFLdT8LfFyv+1yo9Nnu035uwS?=
 =?iso-8859-1?Q?PUPEkZKsjxljv+M5+qLyeuTfGlxiDx+w2AfHPgNXNEvP77uWr+tjuxDKJu?=
 =?iso-8859-1?Q?2eIxwP0i9wf5dx0ZOJbDE0FGxXWnwK5WFUs9BLZKwaW6Qk2YK7o1kYscac?=
 =?iso-8859-1?Q?EF2QwUQmv3mLte8kqq/BT1t+JfZidB2sLh5psTYgxh1UpjRMhQri8M1i8T?=
 =?iso-8859-1?Q?C+heHElho3l8hN3yOecZD4yYr3l2UvL7mNBL2L/29tAC/gEkr8BLS9TMZB?=
 =?iso-8859-1?Q?PR9TneuJARm3dD8bMY0m73KqY/niLQ7BLwG7qwAhwujGiwGwLMXJ2GVuKU?=
 =?iso-8859-1?Q?G4GYsdhwCEyNIpPDZZFBL15XUM4+XcdajzbkCTnpTX7tY7NQ6GW8/AHw2F?=
 =?iso-8859-1?Q?W6T/5T+0WI/gjLwhLIfm7t7sb06UfKMHGCu6WhGtE6jgqEeTuK9dKVUMiw?=
 =?iso-8859-1?Q?r3gKmfv/PDsQF6qSCPg3EeLJfqG9e95aTID5s+CgXICvVSCOgjWLNW7YUs?=
 =?iso-8859-1?Q?PVLH+r5RTp4hg+AvSiIM0bQ9VFGgu/v2TEKE6w6Q4v3IKJPT+uTdmxN3dt?=
 =?iso-8859-1?Q?l8ENAnmQDXxxQvJkaNsd94Hy34Mk4u2EqAE2k3f93fnIim/ir9UBlT0Tca?=
 =?iso-8859-1?Q?zvKj3isPCbcp2uI7no4DHkejhOZfEKqw7TH5yOXOAfB24uA+2LjfsESgBQ?=
 =?iso-8859-1?Q?u++krjTgLGddlePfxvwH6ik1L3MYlZWhcUwxlmir++R0GtCpHfzD515BZ+?=
 =?iso-8859-1?Q?uM5RwXMwZE9xPXkaJZkccVFESIVzwv/zP7+aLeDpBfs3ca5JJkdOmUhtX+?=
 =?iso-8859-1?Q?B7OhXgU1ZWb/fOYPBgrORuQ4y0IsOcZtXjYRosz4c04opbYHLKINBW3KKv?=
 =?iso-8859-1?Q?IgpeY/bCD7nctPJdxNYpBNwqtFs7tvAXm8uhS+tICRozFYhr1oURD7oE7h?=
 =?iso-8859-1?Q?Sbw6530KCB+taTdMBq6Mbd2YXnec4Pys18fzQ/UGdRES0gRLJMw8AzUi+1?=
 =?iso-8859-1?Q?n6MDVYR2oEmV8ywtdcmx++xUvAfaY/OWpk0kJhhAR7OH0vOFdSAl7Oxz8s?=
 =?iso-8859-1?Q?y0pr4MqGvrAvDbxB1Gi1MdYJBL+L+AFVMhbVHA3mXziLNUD5OjGHxyeKFz?=
 =?iso-8859-1?Q?DIiy7Sb9gpvQZXtf8QnyMXZy2jB/PhazTPcbMCr5eDvA3M7VawrRkytizC?=
 =?iso-8859-1?Q?2feKEyC6AxRAYawAg2Fq2lk56vgm1s6rIyWsu+3Sg7s/juVkvV4ZUYOLcV?=
 =?iso-8859-1?Q?k3jS3lxHJJJyAJD1Yp9mQvv3fOZ7inbjx6CaTIxaM7HhwGnlDSvaPpmxkw?=
 =?iso-8859-1?Q?Uil6MfEk9LAEEEGRWyISg81fWQO2fyXXG0qX/eOErs5U7x3uWSXg4KZxzc?=
 =?iso-8859-1?Q?vTvIGIBh1YdBvo9tYpRuintNN7ofQyfZb2mkhy2awz0GsIPF9837VLTp9y?=
 =?iso-8859-1?Q?JupwWhPElNAilDWR39exQ409SswGrpCBpe5x2zpFDFyRoO3fD7hk?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR05MB629521B4B070F968020109D1FC3E2BYAPR05MB6295namp_"
MIME-Version: 1.0
X-OriginatorOrg: csusm.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB6295.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e32684-5374-48f6-d500-08deaa6f6310
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 06:27:31.3213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 128753ab-cb28-4f82-9733-2b9b91d2aca9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 802UdBjMa43JvQ9CMiUQQ9sNROYXEq0Xj5HvxOoMEq/M9wL8n2yvLe4SrYq9s9PR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8414
Received-SPF: pass client-ip=40.107.201.26; envelope-from=vo068@csusm.edu;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 05 May 2026 09:40:23 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_BYAPR05MB629521B4B070F968020109D1FC3E2BYAPR05MB6295namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

To whom it may concern,

My name is Tyler Vo, a master's student at California State University, San=
 Marcos. As part of my thesis, I am researching the effects of AI/LLM usage=
 on open-source software on racial/social/gender bias. I came across the Qe=
mu project as I was trying to find an open-source repository that rejects A=
I-generated contributions. However, although the code provenance section of=
 the documentation does state that AI-generated content is not allowed in c=
ontributions to Qemu, I would like to know how AI-generated content is dete=
cted in pull requests and the like.

Thank you,
Tyler Vo

--_000_BYAPR05MB629521B4B070F968020109D1FC3E2BYAPR05MB6295namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
To whom it may concern,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
My name is Tyler Vo, a master's student at California State University, San=
 Marcos. As part of my thesis, I am researching the effects of AI/LLM usage=
 on open-source software on racial/social/gender bias. I came across the Qe=
mu project as I was trying to find
 an open-source repository that rejects AI-generated contributions. However=
, although the code provenance section of the documentation does state that=
 AI-generated content is not allowed in contributions to Qemu, I would like=
 to know how AI-generated content
 is detected in pull requests and the like.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thank you,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Tyler Vo</div>
</body>
</html>

--_000_BYAPR05MB629521B4B070F968020109D1FC3E2BYAPR05MB6295namp_--

