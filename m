Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47B4C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tppq6-0000zD-UW; Wed, 05 Mar 2025 09:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <benjamin.charlton@avanti.space>)
 id 1tpkHT-0007NM-VF
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:39:08 -0500
Received: from eu-smtp-delivery-113.mimecast.com ([185.58.86.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <benjamin.charlton@avanti.space>)
 id 1tpkHQ-0000cA-G9
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avanti.space;
 s=mimecast; t=1741163940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=mRkXNqxRjPdbJBQiKiXsIAcWzgWaya3RYRpgBkO1yY4=;
 b=A+PqbDOJfyAMQpbTt+kVDkEg5wGioBNfY0qIZwNDB5w0kTjyH2PPdj6sVZM9ey5l9+3nO0
 jktUke6uL2qrZHifprv1G1wiALGAKa9qhNTda9URgIw19uAxwNIj1btXazjJLnEiyU0QPT
 jUTEHJM6VfPubImqCgkeGnVc8kCjf8jlWmK6HWXA3mKged8lnzybzkv2ic3Ga8Q1W3oDRL
 10PAs5TzbEoumMBhyu66tf1p/tzmlDsqOljZNM/+HFaj1xk49Yb/dOs2gf0JPt4nT+CAOC
 fAFuBdsdylEOxvVARtC/yBZ12YtSVzV2Hz9BAK4oJOxy9NI+IPiq00p+Ka0urQ==
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazlp17010000.outbound.protection.outlook.com [40.93.68.0]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-171-zMn5oNiJMLuf2erBgBx0Lg-1; Wed,
 05 Mar 2025 08:37:19 +0000
X-MC-Unique: zMn5oNiJMLuf2erBgBx0Lg-1
X-Mimecast-MFC-AGG-ID: zMn5oNiJMLuf2erBgBx0Lg_1741163839
Received: from CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ab::5)
 by LO4P265MB7284.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 08:37:18 +0000
Received: from CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4ce0:4462:93f1:c448]) by CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4ce0:4462:93f1:c448%3]) with mapi id 15.20.8511.012; Wed, 5 Mar 2025
 08:37:18 +0000
From: Benjamin Charlton <Benjamin.Charlton@avanti.space>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: QEMU and ia64
Thread-Topic: QEMU and ia64
Thread-Index: AduNqQoHF9c3rKgrRlW1uncurdpCow==
Date: Wed, 5 Mar 2025 08:37:18 +0000
Message-ID: <CWXP265MB56711557D89741FDF97E192592CB2@CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP265MB5671:EE_|LO4P265MB7284:EE_
x-ms-office365-filtering-correlation-id: 5ee717dc-926c-46bb-5d7c-08dd5bc0f05d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|4053099003|13003099007|8096899003|38070700018
x-microsoft-antispam-message-info: =?us-ascii?Q?QdzjXF7xaMWxF9WHvnGReBvGrRTc7VBPiac19r7IWNjp+51ItPj19Nf5tWM8?=
 =?us-ascii?Q?ByDrsWV4czGL/S3HrinUDplUI2zQ94Sx1bkKNbHKWP6GVt+5ZTrHmSa0A3Lj?=
 =?us-ascii?Q?pSYJ58gMnN8yY65c4fokoE9l2BdDhpIDRBv12ZTt0HdAcWUF2x5eHgY3pzam?=
 =?us-ascii?Q?mw7S4Lc1Ct4rNLxOPqvLBbn+pE9KfDcCGgS5Qca1girTOjKMH3A7fRLaWb2a?=
 =?us-ascii?Q?YVbLnDa2auuu2AgzIie4joJPeLgSNwgrSuoFOMdSWKHK2/6ykSkC0JeHNSpA?=
 =?us-ascii?Q?Cexgna4bfPLOhayjQDTOgqin8hle9nC1e0Wm7bTD5dsDAv3xHA0QgMcbnkrF?=
 =?us-ascii?Q?vSC98ftLmgmG07+aYSedKciyE3MpBPxn5dEoUU/0cIYtM7Gr6z8Mq2/rCYNn?=
 =?us-ascii?Q?tru7u4ZnBzdqRu7kifaDBH0GhL1r2cxW96tB9zBSPTmglqgQ29wpqQRbwQnW?=
 =?us-ascii?Q?hLejR2r3fpPYmdSqUARYHoU3Dz9Qm2GLQw29CxFGK7a/14p3i13QQ6xIxcDg?=
 =?us-ascii?Q?FGgpa8X0Ox3hQ7/E3Jk14fL/bDxOZi+MdCI8jyd2IROxg8J4F5IJ8IObmssq?=
 =?us-ascii?Q?D3UWfeGsyA9hQODjF7PpvBRzMA4K/MoQHg0LXbHJKYAwztA+X60TbAPu+Pp0?=
 =?us-ascii?Q?WTn3i8NAZkogObV7luwgHzKNCfxmUm4wGESBXGqXkpNF1/q7egdptfW3vJV8?=
 =?us-ascii?Q?M3nY2kWCXoOuCDVqNB/ZKR9WeaNva5BWdn8FlRSD0RDyZIDVYrViaqazx5d5?=
 =?us-ascii?Q?advNC8WxODGTO8xnw/B3yRVP6LHFBxQT8eGXQu3oQgRVcMj40AMGi1arJsSf?=
 =?us-ascii?Q?7tt0DOaJ71ZAM9QnoDVSfUgpIJ5Ph21ZLPR+DwxY0wi3DMADcQz7EBn6pDqw?=
 =?us-ascii?Q?D1utpb9YjXJsSj3I9AG7bwFa4htXsgAsSTFVy/u4lsgLjqCxs+aYfumQQnMJ?=
 =?us-ascii?Q?54qm5ab7dbCMaKr4rA8Ko4BxZPIHcXZm/OgRhKSh9zlS0jPhGIDGjKq3Ax76?=
 =?us-ascii?Q?LKprqefTEehnRD0XQRxb0uaQkmtLZL5oImMtCheqk0y+HHoU8c+lIbh5XoIh?=
 =?us-ascii?Q?FqpzfYv8FyMrzX4z9UMNBxoCEzwoXMCLrfcz1ywdKwwC80FS1MyBOWBEsIfu?=
 =?us-ascii?Q?LsLHFacyEhJ11sYpnPqNK+k5IGgxQuWukf7QkGBd6tNGWlX+uwpq6PsC5/Ao?=
 =?us-ascii?Q?1iwoVWMvJMhs7MJfsf1yAG/8FNwUe8lIQAdHICY+hU2m7jAcwyNyiG/Sijgc?=
 =?us-ascii?Q?2CLivu+vy2XhtqhbESdzdzLoTz/+Ho8swZPEsbY7ZCRQVQddE2UlZSK4+nX4?=
 =?us-ascii?Q?kIUO511R+mYknIasM7v3yziH94DICnI+NKgtMDJK2erj3jWSwHukdO3kCXK/?=
 =?us-ascii?Q?6M6m3DLlXdN3EEx/0RQXKlTvkBmf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(13003099007)(8096899003)(38070700018);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NHi2+mJXY1soDU364JGtHjFWJ/DLwu7IwO1nS9/pc2sEUHfnCY81aMd36YBk?=
 =?us-ascii?Q?MKgfVPfxRHDbSCXUe9fRKj3HfugClSrTygkRTNrdAXt7yu+q9YwtTE8N52IA?=
 =?us-ascii?Q?sqf3zO51YYMZreRWJYq5YEhLXKqnhGbz13oDFRtd7kPr3EA7bhAeNEHXYA7S?=
 =?us-ascii?Q?J7yNaL/wQ/vprbO4FAN9f8K93BWwf39IQgf0wC4hO4mo8wmUVDAWWZzXnNAV?=
 =?us-ascii?Q?W996z+t4IxXDon9ZZvgQyGWDMAZRxAqG2gkIP809jYtVk24hBca08SGRSHkg?=
 =?us-ascii?Q?fKfLNWXzaT/tFVPFVUbviwVq2M91cDtI1SQHGDiW3Z+UpoKRJD+dtvLGejlv?=
 =?us-ascii?Q?1cBrouxtmnh6yso8TchjGdAMSbKJM0uWSMm5QZve8iHDzVXPA7uqDw0FZbor?=
 =?us-ascii?Q?OQk6lDemnuPliu3Wsj4C8CvnWv2EWQTEh27I8Fx5FHxXlFufvbyuyJTXdDfI?=
 =?us-ascii?Q?lM6w6T76/7Gv3c170KJC2rYFnlYt1/nfzmPpEenwQvoNuMWqJMfux9/M5Z5M?=
 =?us-ascii?Q?36DfS3TRTNryGIZUjuxFEj0uciyzPHLW8iNkSKtEp55ZHLMvl2mMkm4EWuNr?=
 =?us-ascii?Q?dJa5FfYTrTckfyfgtXbL/ekLzWqCH55CU4ofteL3u9fRP9+l/+LnwHzQ4yCh?=
 =?us-ascii?Q?2SaEkRlncLawjANFqHU6Fp/CXhkUomodeMzSh4LtB2DH4am0mE8y3bp+oHgQ?=
 =?us-ascii?Q?/H6yttI/9BqylcvI9LFw5skNuKowgb60yiSItyCx4Q/fzn1tNcQEoPExoDk0?=
 =?us-ascii?Q?cLCp1dMyb17UkDKDOtntRYTzGvh7RsgIJhJBBmy9NzWohz6H/oEgv+QNLeEe?=
 =?us-ascii?Q?BR7PQdvf4oYDWbXXPhijd17PpW55Pyj9eU+56UGT4RZ/7/89dzOtEQqcf4EE?=
 =?us-ascii?Q?X7D63rWDwaL4OaLgEHM5Dblah4mXGUxGrwbzuyYopUGzuOL7gsw0fAbjixdM?=
 =?us-ascii?Q?HlhJ8ePTuMqCsKMV8foXXRG/GNV0b34Gl/pJmgKINZWN/8V07J/S4QoHgyAC?=
 =?us-ascii?Q?qLhTARIoVN8gDYs/B4lSGF0SD/jWZQGcwqpouEByyl9TiC+itNipJudNs1m8?=
 =?us-ascii?Q?lH9JZ8ulePgNDSARVHscvrM+Txe1fjmPJGK8nRQIeKlq0Ug9L7g3u2ZGx0An?=
 =?us-ascii?Q?r+sYFa7wUKCCUKMULX9YXlg8ZX1p/vzA6ul2Th2YaqJwVpEgR0CVYKmqvPQx?=
 =?us-ascii?Q?4Ko3orUlaCdnXFS0vZPCA8ZM2wfz28gvwzsl00qT7votMtXlfcCTZBM3uGhH?=
 =?us-ascii?Q?wdgKWoL3UMxQT7fbR2hPMj6ROG3fSTuVxtZJJrPGTIIiS2rxvYim1x62uqem?=
 =?us-ascii?Q?ZUVtMf3uGRWeuXlH4KhfD1v2BVyNraNf7A0KJwY1p6GGN3hW0wUTT1HUbrKF?=
 =?us-ascii?Q?9gxlOqq2L1J+9doTUJAHND/sOucXwdoE8RPO2KVmhOOA57fpBZmoioY8aFp4?=
 =?us-ascii?Q?jLEWmHA7+evpfTZ1IrPL5shQel5zvE2m2ZqMYpmkcpfTU6KISqa+wVrfztRf?=
 =?us-ascii?Q?BgMsCOjzeoiNOwF08SAazUaPLRJfzj8sQqtnVVMJWWfwEldKseR19bqWFuzQ?=
 =?us-ascii?Q?DeJwpSkJ9ovWbWlsjpzQg+w/mV9XZCDGXZsT/TtVtpSs8jqWCjB4gLUVSWdS?=
 =?us-ascii?Q?eg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: avanti.space
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee717dc-926c-46bb-5d7c-08dd5bc0f05d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 08:37:18.0743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 65459471-455c-42b0-b4e2-298d6f2c5992
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ah7KhkYLL92+dbaQXzHOIO6JaSiGWD5jsST30YoaSkIRZjs4X4BRNapHtJJLOIWjPpgUnAoqw6KequrqmGxcyAfu+VZsa64JzaMCYwwu1Yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7284
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IdoMAgp9l6wJ5d6QgUcWB9hEqgbtJQRHHbGMU4eDSdE_1741163839
X-Mimecast-Originator: avanti.space
Content-Language: en-GB
Content-Type: multipart/related;
 boundary="_004_CWXP265MB56711557D89741FDF97E192592CB2CWXP265MB5671GBRP_";
 type="multipart/alternative"
Received-SPF: pass client-ip=185.58.86.113;
 envelope-from=benjamin.charlton@avanti.space;
 helo=eu-smtp-delivery-113.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 05 Mar 2025 09:35:12 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_004_CWXP265MB56711557D89741FDF97E192592CB2CWXP265MB5671GBRP_
Content-Type: multipart/alternative;
	boundary="_000_CWXP265MB56711557D89741FDF97E192592CB2CWXP265MB5671GBRP_"

--_000_CWXP265MB56711557D89741FDF97E192592CB2CWXP265MB5671GBRP_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello.

Sorry to bother you, I am very new to all of this and but I am looking for =
a ia64 emulator, sadly it has to be this to run a piece of old software. GP=
T suggested I clone your project and emulate this processor. However I am r=
eceiving an error

bcharlton@UK4072:~/Emulation/qemu$ ./configure --target-list=3Dia64-softmmu
Using './build' as the directory for build output
python determined to be '/usr/bin/python3'
python version: Python 3.10.12
mkvenv: Creating non-isolated virtual environment at 'pyvenv'
mkvenv: checking for meson>=3D1.5.0
mkvenv: checking for pycotap>=3D1.1.0
mkvenv: installing meson=3D=3D1.5.0, pycotap=3D=3D1.3.1
mkvenv: checking for sphinx>=3D3.4.3
mkvenv: checking for sphinx_rtd_theme>=3D0.5

'sphinx_rtd_theme=3D=3D1.1.1' not found:
* Python package 'sphinx_rtd_theme' was not found nor installed.
* mkvenv was configured to operate offline and did not check PyPI.


Sphinx not found/usable, disabling docs.

ERROR: Unknown target name 'ia64-softmmu'

Are you able to help?

Thank you

Best regards,

[cid:image001.png@01DB8DA9.7C7937F0]
Be More.
Benjamin Charlton
Ground Control Systems Engineer
Avanti Communications
Goonhilly Satellite Earth Station, Goonhilly Downs, Goonhilly, Helston, Cor=
nwall, TR12 6LQ
t: +442077491600
w: www.avanti.space<http://www.avanti.space/>

--_000_CWXP265MB56711557D89741FDF97E192592CB2CWXP265MB5671GBRP_
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09font-size:12.0pt;
=09font-family:"Aptos",sans-serif;
=09mso-ligatures:standardcontextual;
=09mso-fareast-language:EN-US;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Aptos",sans-serif;
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09mso-fareast-language:EN-US;}
@page WordSection1
=09{size:612.0pt 792.0pt;
=09margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
=09{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head><body lang=3D"EN-GB" link=3D"#467886" vlink=3D"#96607D" style=3D"wor=
d-wrap:break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello.<br>
<br>
Sorry to bother you, I am very new to all of this and but I am looking for =
a ia64 emulator, sadly it has to be this to run a piece of old software. GP=
T suggested I clone your project and emulate this processor. However I am r=
eceiving an error
<br>
<br>
bcharlton@UK4072:~/Emulation/qemu$ ./configure --target-list=3Dia64-softmmu=
<o:p></o:p></p>
<p class=3D"MsoNormal">Using './build' as the directory for build output<o:=
p></o:p></p>
<p class=3D"MsoNormal">python determined to be '/usr/bin/python3'<o:p></o:p=
></p>
<p class=3D"MsoNormal">python version: Python 3.10.12<o:p></o:p></p>
<p class=3D"MsoNormal">mkvenv: Creating non-isolated virtual environment at=
 'pyvenv'<o:p></o:p></p>
<p class=3D"MsoNormal">mkvenv: checking for meson&gt;=3D1.5.0<o:p></o:p></p=
>
<p class=3D"MsoNormal">mkvenv: checking for pycotap&gt;=3D1.1.0<o:p></o:p><=
/p>
<p class=3D"MsoNormal">mkvenv: installing meson=3D=3D1.5.0, pycotap=3D=3D1.=
3.1<o:p></o:p></p>
<p class=3D"MsoNormal">mkvenv: checking for sphinx&gt;=3D3.4.3<o:p></o:p></=
p>
<p class=3D"MsoNormal">mkvenv: checking for sphinx_rtd_theme&gt;=3D0.5<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">'sphinx_rtd_theme=3D=3D1.1.1' not found:<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&#8226; Python package 'sphinx_rtd_theme' was not fo=
und nor installed.<o:p></o:p></p>
<p class=3D"MsoNormal">&#8226; mkvenv was configured to operate offline and=
 did not check PyPI.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sphinx not found/usable, disabling docs.<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">ERROR: Unknown target name 'ia64-softmmu'<br>
<br>
Are you able to help?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards,<span style=3D"font-size:11.0pt;mso-lig=
atures:none"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-GB"><o:p>&nbs=
p;</o:p></span></p>
<table class=3D"MsoNormalTable" border=3D"0" cellpadding=3D"0">
<tbody>
<tr>
<td style=3D"padding:.75pt .75pt .75pt .75pt">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-GB"><img widt=
h=3D"80" height=3D"80" style=3D"width:.8333in;height:.8333in" id=3D"Picture=
_x0020_11" src=3D"cid:image001.png@01DB8DA9.7C7937F0"><o:p></o:p></span></p=
>
<p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span s=
tyle=3D"color:#4AC4B5;mso-fareast-language:EN-GB">Be More.</span><span styl=
e=3D"mso-fareast-language:EN-GB"><o:p></o:p></span></p>
</td>
<td style=3D"padding:.75pt .75pt .75pt .75pt">
<p class=3D"MsoNormal"><b><span style=3D"color:gray;mso-fareast-language:EN=
-GB">Benjamin Charlton</span></b><span style=3D"mso-fareast-language:EN-GB"=
><br>
<span style=3D"color:#4AC4B5">Ground&nbsp;Control&nbsp;Systems&nbsp;Enginee=
r</span><br>
<b><span style=3D"color:gray">Avanti Communications</span></b><br>
<span style=3D"color:gray">Goonhilly Satellite Earth Station, Goonhilly Dow=
ns, Goonhilly, Helston, Cornwall, TR12 6LQ</span><br>
<span style=3D"color:#4AC4B5">t:</span><span style=3D"color:gray"> +4420774=
91600</span><span style=3D"color:#4AC4B5"><br>
w:</span><span style=3D"color:gray"> <a href=3D"http://www.avanti.space/"><=
span style=3D"color:#0563C1">www.avanti.space</span></a></span><o:p></o:p><=
/span></p>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:none;m=
so-fareast-language:EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>



    <br>
    <br>
    <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tr><td><a href=
=3D"https://www.avanti.space"><IMG border=3D"0" src=3D"https://eu-api.mimec=
ast.com/s/store/8tiInYxF340R6JeVLWUTdpmCh441t-hlPzFwDArFFMEOVhst0cFFOumhi_4=
e_kI2pZtyA0bTWpmB0jcfK820H6RtaCm5BjcFcGscsTZHotvVi-9NqQbhIKfhy8n0FciGysn5mC=
YJZkfoTze2RGCzrr8hgYDuECFDg0r2EoSnyoqy_YbcNejDFyHZK_DKqCdG" ></A></td></tr>=
</table>
    <br>
    <br> =20
DISCLAIMER: This email including any attachments is intended only for the p=
erson(s) ("the intended recipient(s)") to whom it is addressed and it may c=
ontain confidential or privileged information. The contents of this email m=
ust not be disclosed to anyone else. If you are not the intended recipient =
please notify the sender immediately. Avanti Hylas 2 Limited (=E2=80=9Cthe =
Company=E2=80=9D), any subsidiary or holding company of the Company or any =
of its or their subsidiaries (each a =E2=80=9CGroup Member=E2=80=9D) will n=
ot be liable for any error in transmission. You should carry out your own v=
irus checks before opening any attachments. Opinions, conclusions and other=
 information that do not relate to the official business of the Company or =
any Group Member are neither given nor endorsed by it/them. Registered in E=
ngland No. 7072502 Registered Office: One Ariel Way, White City, London  W1=
2 7SL, United Kingdom

</body></html>

--_000_CWXP265MB56711557D89741FDF97E192592CB2CWXP265MB5671GBRP_--

--_004_CWXP265MB56711557D89741FDF97E192592CB2CWXP265MB5671GBRP_
Content-Type: image/png; name="image001.png"
Content-Description: image001.png
Content-Disposition: inline; filename="image001.png"; size=14831;
	creation-date="Wed, 05 Mar 2025 08:37:17 GMT";
	modification-date="Wed, 05 Mar 2025 08:37:17 GMT"
Content-ID: <image001.png@01DB8DA9.7C7937F0>
Content-Transfer-Encoding: base64

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
PSJYTVAgQ29yZSA0LjQuMC1FeGl2MiI+CiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cu
dzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogIDxyZGY6RGVzY3JpcHRpb24gcmRm
OmFib3V0PSIiCiAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21t
LyIKICAgIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVz
b3VyY2VFdmVudCMiCiAgICB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEu
MS8iCiAgICB4bWxuczpHSU1QPSJodHRwOi8vd3d3LmdpbXAub3JnL3htcC8iCiAgICB4bWxuczp0
aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgIHhtbG5zOnhtcD0iaHR0cDov
L25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgeG1wTU06RG9jdW1lbnRJRD0iZ2ltcDpkb2NpZDpn
aW1wOmVhZDhlMzhmLTcwMDEtNGQxZS05MTNhLThkNTQ3MjgxNWZlOCIKICAgeG1wTU06SW5zdGFu
Y2VJRD0ieG1wLmlpZDozMzk4ZDA3Mi1kMmMyLTQzNDQtOGMzYy1mYmMyZWFhNWQ0MjUiCiAgIHht
cE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDoyMGUzNWU2Ni0wMzRjLTQwOWUtOWE1OS05
NmU2OWIwZmVhNTciCiAgIGRjOkZvcm1hdD0iaW1hZ2UvcG5nIgogICBHSU1QOkFQST0iMi4wIgog
ICBHSU1QOlBsYXRmb3JtPSJXaW5kb3dzIgogICBHSU1QOlRpbWVTdGFtcD0iMTY1MjM2MDEyMzE0
MzE2MSIKICAgR0lNUDpWZXJzaW9uPSIyLjEwLjMwIgogICB0aWZmOk9yaWVudGF0aW9uPSIxIgog
ICB4bXA6Q3JlYXRvclRvb2w9IkdJTVAgMi4xMCI+CiAgIDx4bXBNTTpIaXN0b3J5PgogICAgPHJk
ZjpTZXE+CiAgICAgPHJkZjpsaQogICAgICBzdEV2dDphY3Rpb249InNhdmVkIgogICAgICBzdEV2
dDpjaGFuZ2VkPSIvIgogICAgICBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjJmNGFhNDY2LTk0
OWMtNGVhZi1iNDU0LWVhODVhZGYwYjQ2NSIKICAgICAgc3RFdnQ6c29mdHdhcmVBZ2VudD0iR2lt
cCAyLjEwIChXaW5kb3dzKSIKICAgICAgc3RFdnQ6d2hlbj0iMjAyMi0wNS0xMlQxMzo1NToyMyIv
PgogICAgPC9yZGY6U2VxPgogICA8L3htcE1NOkhpc3Rvcnk+CiAgPC9yZGY6RGVzY3JpcHRpb24+
CiA8L3JkZjpSREY+CjwveDp4bXBtZXRhPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgCjw/eHBhY2tldCBlbmQ9InciPz43VyerAAAABmJLR0QAAAAA
AAD5Q7t/AAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH5gUMDDcXlDG+YAAACVhJREFUeNrt
nH+wVVUVxz/3Pn7IM/xBEiiYCEaklaGoKFvMVxnuTfgywvgVkYBDQgIpWagpo5NTwDD8kIGxMEQQ
pAR178cgMRNsi4lmooxSEV5C0g8pjV8DAu/2x1ln7ul6z+Wex7u8X3fN3Dl373POPnt/z9pnrb3W
2gvKVKbGpFRT6oz29lygD/AJoAvQHTgr0s8MUAf8G9gL7AF2OmXeaJUAam+7A4OAm4H+QM96NnUY
2AZsATalYItV5mSLBFB7exEwGrgD6Btz2THgDeAA8A/giHBfW+B8oDPQDegac/+7wDpgeTqV2vTS
AJ1p9gBqbwcCU4EhQDpy6iiwGXhFuOhVp8zfimyzPfBJeRE3CCf3yLlsN7AAeNIpc7DZAai9rQIe
Ba6PVB8E1gKrgY1OmaMN+LyPA18BRgBXRE69B8wG5jplDjV5ALW3vYG5wK2R6j8B84EVDTmIAn24
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
AAAASUVORK5CYII=
--_004_CWXP265MB56711557D89741FDF97E192592CB2CWXP265MB5671GBRP_--


