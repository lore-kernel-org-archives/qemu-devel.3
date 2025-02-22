Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF96CC021B5
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2025 15:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlrHk-0004a3-Ch; Sat, 22 Feb 2025 10:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1tlplA-0000LR-LO
 for qemu-devel@nongnu.org; Sat, 22 Feb 2025 08:41:36 -0500
Received: from mail-koreacentralazolkn19012060.outbound.protection.outlook.com
 ([52.103.74.60] helo=SEVP216CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1tlpl8-0005th-Te
 for qemu-devel@nongnu.org; Sat, 22 Feb 2025 08:41:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/I+mzxxHlybIyqXdBlfZYaLX8ZDlDes1F1ajk/ZaBs46aJdqiZBS/3sAbdGsNUucL+oqZQ/ZVhx8kp8JoT23hTKuGQSK9t6EblMxRHfNF0m0TA/UZTGZW24upqw7E4H/Ypya5IL5+CNnyQf1Jrf5PdMI9vsti8H0cU56Mlf4yvCvrawtVPymt640ILqTR4pXIYHc7WxUShZxJVwfZH090vcaMJgGcs39lHUiwAA8dab3/Shabm9e+RnNXLnjNQPo2VqArKvov2buTHRcoVWL1kuXXX4BAvRnY9EZLZoxZ4ZGRb3MYmMJcEji+Skqfb8BK+sfo9Vsg0hbtAZbSJMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6S7kinX4k7ewhbJMbpv1tRDYqD57rmGqMDSX3beIlM=;
 b=QOM/fKeIxN/4cQ9uVkW16lhboiQ2cPlrdMNAuBJco0uCry/VggbPCKaMuoEVc90kSLqmybho3jJOZiv6vrHPahZTsUMdtjyHrWNUwjfZtZIv0TBQePcTl/9xCscuyFRxlnpWJcBLl5ywjaAs9B1H3zMw8lWvkgGBteeUibmRnQmA4j9ChKitfNYsd+HHjE04LhMH+g07b+KDA15yvJtpZGiRoRzZB1zhCoEf+b030hnE1Sfp/9hZWBcaEtkfPdVDr3YLI9j7fgM3PFUDxVZXZ1SFUTESYmHmkSO8gWpZAljGy4LxsKMvL4pztrwmDQDh5ju/z8lpzyoItmQ/ligZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6S7kinX4k7ewhbJMbpv1tRDYqD57rmGqMDSX3beIlM=;
 b=AaNmEhFcp4IoaY95rjszPw3hixJY5U6DflnHdSB6+Vh+IvvGlCkuUVwLmX+CbPqjQKm5aMHwWlmpDKvI2luxL5DROrSrEBYuuUMKykmaXglYJGS3tjiZRtb1sW2c7cysNVtZL/sAzYAGsZ5M42iMG5ASn15+l+Y6LnnnnjaVaEnNkYbO/x/dXl0u5QnlgFoGkbk1J6kxaO2kR5ayCkJtWSY5tVRJYq54kFzprd2Mcq2ee9o8LAtcf6CfvBTpjlWdH/YiGdU9NLjadjTRQF39GIdwPkqtVohRhtpVA66oN9W04i7M6NLSs4zfYB6aEogSh0OSIYe3pJqi88tVRBph2A==
Received: from PS2P216MB1388.KORP216.PROD.OUTLOOK.COM (2603:1096:301:99::6) by
 PU4P216MB1519.KORP216.PROD.OUTLOOK.COM (2603:1096:301:ce::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.18; Sat, 22 Feb 2025 13:36:27 +0000
Received: from PS2P216MB1388.KORP216.PROD.OUTLOOK.COM
 ([fe80::cf60:86f0:7ddd:c026]) by PS2P216MB1388.KORP216.PROD.OUTLOOK.COM
 ([fe80::cf60:86f0:7ddd:c026%2]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 13:36:27 +0000
From: Saanjh Sengupta <saanjhsengupta@outlook.com>
To: "amir.gonnen@neuroblade.ai" <amir.gonnen@neuroblade.ai>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Building QEMU as a Shared Library
Thread-Topic: Building QEMU as a Shared Library
Thread-Index: AQHbhS5hC6j1H6b7H06DOFGvD/EU6w==
Date: Sat, 22 Feb 2025 13:36:27 +0000
Message-ID: <PS2P216MB1388380FEF72AF5916FD9B59CCC62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2P216MB1388:EE_|PU4P216MB1519:EE_
x-ms-office365-filtering-correlation-id: 26f4cbc4-6fc5-4a01-71a2-08dd5345e855
x-microsoft-antispam: BCL:0;
 ARA:14566002|461199028|15080799006|7092599003|8060799006|8062599003|19110799003|14030799003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info: =?us-ascii?Q?6c2VYFNiTyH8NGlaxK4dIGmeFWZ+Oibu8Qg5ExDx8ISrhNit86g+IDQxmb+J?=
 =?us-ascii?Q?FjcghLacCXUQoiWHL63CAfHYIhX9JDVZdSMljuc0KPBQts9ImGVy7Cyia3cT?=
 =?us-ascii?Q?bUII1FiikD1m/DGkeXcgbHSiufcXmmySo/2e/0FMSiYn0o9IbiVFuEEhPek6?=
 =?us-ascii?Q?/Bp3teO4H3cx9UgACxmFgBp98jhuOn4TLVOGq66K3aZIQMdoVBIhnSmBBn+J?=
 =?us-ascii?Q?MRieZEfewrZwlUaJJXb6UNPrnd559E3q3l5pEBlQe25HeRlmI9WLW+Ipe8U7?=
 =?us-ascii?Q?GxZoKoHCax5FyL9H4VNe167WQZXwwO2NNRDT74QP+CMZaK0Uufb5XEgVEMWo?=
 =?us-ascii?Q?6YaxzXvGq/rcdvXOifXM/o6PEszy1OAHFi+//ndpMwPzgC7Funzm8TW4a1SR?=
 =?us-ascii?Q?YCZ3lybAOokZBII85zkO3r3Lp4VYWOqSt8zzzd7ZGqOVWjzYUTGGjcyIqArs?=
 =?us-ascii?Q?K3wCQk0GlMTe7rsjFaKBHinESPbFPOAG91/ynAkGJ+ojUYj3V1JyFfM4tIJq?=
 =?us-ascii?Q?TNFRvLJBOF93E3ejxKUioKSwysUFHn2a6eCv31skh+lwbVr+LCQBNJqHpFs7?=
 =?us-ascii?Q?RYEeFnfZSP8LSANlDly1TXoSAI2clIcFGDaHmEiCux/TOJZ1xqmCcd/fR9MM?=
 =?us-ascii?Q?pYJCZAoXHHCMLQcG6mXVW3nbY3fuu9ofLidRZcMSoHRyKtMaoyr1j1NvnnkJ?=
 =?us-ascii?Q?jtFZXrJjxqDvtqw151k0avb6TxIjPgnKj6TTXvn0glm8Pscw5MRobCUhaFCB?=
 =?us-ascii?Q?V0Ry/sidMC0sByMd3tge9vxjGhnagC8N+p63IS0ZWIdIvyiNaJzJnNymcS9E?=
 =?us-ascii?Q?ClN0jmD6u0jlc33zNqU0cdHYRtP+FcU7Sj5gYLgaExSX4Ng2sPjU7L7dysTa?=
 =?us-ascii?Q?t7jd59YDH5EDr5HSL+28NzyauSR3n7E7YrTiMG4KfTjOUbZn+mnj8K5Q9U8N?=
 =?us-ascii?Q?DFvWldKyaIJqNJjNyLJlsfTTi7usWgyvOuE3a6qXlKkd14f8qo1POroGwdye?=
 =?us-ascii?Q?W+5Mug6tCOuu5z5KHPDavLEDpSXv7NJ6qk527cRWoOsapEY2eaK81jmM2VJL?=
 =?us-ascii?Q?/X8tK0ld25KUxvejDkODM0+2ceGvJwkhvGbLumDubRz4nUckpsU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sobs9e+OY/NQhLocazgF+heXZ5W7FKtqnZglDdF8Mka8O7r3qu5sZYHAoCP/?=
 =?us-ascii?Q?OenhZ8PbT/n3v0CG7z4XU+GO/RH2eOC4SoJipOElYm5D6oUOx/0KdUXGr2la?=
 =?us-ascii?Q?1O7Ysc4Ut3DEsq7R+1OFTWhoiTZrdzIbfRSqRdGynQoZG6gYCEMtc88KoZLN?=
 =?us-ascii?Q?IFoyY+69tka/gamCZwLtWaUurUC6o4+gafgDswijvIaZczAcVYWG1H35OCy7?=
 =?us-ascii?Q?GLV7lbckzA/zt7J97nXoRERL6AtA3Zrcy8XrOr3s7m2xmCmjDC0YapgVYn/w?=
 =?us-ascii?Q?15WeQCl/GsXqsRduUgf84hZ3B8MV8m7rKbHLvZfhDKND7tg13CG1K6CEgw9t?=
 =?us-ascii?Q?wWKUN7iqAw4bxAxulwFgKGvIeDXRXiAwM9phdXWf3lL/p/MYMxUQ5nP3HZ6y?=
 =?us-ascii?Q?jyNDIglHnMXMq0Vau2aSawcgSOkEbF+I9cm7cZUsiOtV/P/gCYnGfVEonXru?=
 =?us-ascii?Q?UsyvnU9ZVQeH5XUPEH4va2Vt48fhWETyxyRVsaNnbCicdrEOF++6L4FgdH6M?=
 =?us-ascii?Q?fbXdJUYF9N4ISXuu8YvCwbdOHTKQSxEqsyqaKE4yB2mSdJWOIqVwG7ofMJ/6?=
 =?us-ascii?Q?x87JUOI8NjOqOfBg/VQ35i/s88Q8tGfrWiuz0tIlmGAghbcE7A7r04ZP6jpJ?=
 =?us-ascii?Q?y7Zdb431X2J6xi4k88e84RoqgGs6qnugVzqV7nAgDtCy4I4mASPp5r20kZVI?=
 =?us-ascii?Q?Ko/r5ndzUkdw/5mCP/4OOk/wcUpw0OXD6QC4G/nIH19ksEvd1LHKP2As9i6k?=
 =?us-ascii?Q?5N7xH32vuIsmnFl2F7r9EGU7k3lEjUhGFWC546+NtSHgDQ2TQRilIxvBbNyx?=
 =?us-ascii?Q?sonLzM1Ab7l9PGekGinXlF3azLzGa3p9lQL7kghfmrYAZr7n5Xkvk4T8QNJ+?=
 =?us-ascii?Q?aVHA66LYE067EDXvHjeLbj6BL60/p40+MkdrbKb6f6uNn12JHd7ufO1LHdW6?=
 =?us-ascii?Q?ZW8e2ohghwUFhJhC8fQhgmKohIEeXYDawYO/Sc1t3YJ1YLUjiMnKDhtU7xGQ?=
 =?us-ascii?Q?ZPbfhD4r5UW9x+Srq1CKy6cm+/LK6ILca3z2wXIVjYXma1o8nCQPNuCgayZX?=
 =?us-ascii?Q?qJ9USTLMSK7886JEuanwrqrEl55utKj95MyMPjOGkKr+ojsHZNHJveVcrZsE?=
 =?us-ascii?Q?xQVeVgEZ8alW+tfxORHzUOsoKNlfYBLxLt+LXdD75ECG6NHm+4u6seFo2s1S?=
 =?us-ascii?Q?2m0bY0b1T8wyGfV7eQ2i3xhfm8m8SA5duyeQPHsdAklXMszmYzL/OJK9FYO9?=
 =?us-ascii?Q?0tn+s3UAS98kGkLaB//rSyHfcM5g3NAjPTWK+B/TsQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PS2P216MB1388380FEF72AF5916FD9B59CCC62PS2P216MB1388KORP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2P216MB1388.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f4cbc4-6fc5-4a01-71a2-08dd5345e855
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 13:36:27.1873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1519
Received-SPF: pass client-ip=52.103.74.60;
 envelope-from=saanjhsengupta@outlook.com;
 helo=SEVP216CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 22 Feb 2025 10:19:12 -0500
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

--_000_PS2P216MB1388380FEF72AF5916FD9B59CCC62PS2P216MB1388KORP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I referred to your mailing chains on suggesting QEMU to be built as a share=
d library.

Change meson.build to build QEMU as a shared library (with PIC enabled for =
static libraries)

Could you please suggest what exactly has to be enabled in the meson.build?

I am confused on that front.

Regards
Saanjh Sengupta

--_000_PS2P216MB1388380FEF72AF5916FD9B59CCC62PS2P216MB1388KORP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto">Hi,</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">I referred to your mailing chains on suggesting QEMU to b=
e built as a shared library.&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto"><b>Change meson.build to build QEMU as a shared library (=
with PIC enabled for static libraries)</b></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto"><b><br>
</b></div>
<div dir=3D"auto">Could you please suggest what exactly has to be enabled i=
n the meson.build?&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">I am confused on that front.&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards</div>
<div dir=3D"auto">Saanjh Sengupta&nbsp;</div>
</div>
</body>
</html>

--_000_PS2P216MB1388380FEF72AF5916FD9B59CCC62PS2P216MB1388KORP_--

