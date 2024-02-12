Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB30C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 16:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZYjz-0001GS-LL; Mon, 12 Feb 2024 11:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haghera@nvidia.com>)
 id 1rZY0z-0002XO-28
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 10:14:37 -0500
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com
 ([40.107.237.49] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haghera@nvidia.com>)
 id 1rZY0u-0006pc-KH
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 10:14:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PD9tKYJuUjwBmu9KU9/Tyq4azJc/zGgU14tbl7f/XM3n/XF02b6lbrIVGuABtt/WKEP8EqAcnlRoXPYn9yiMhSc6YV7v5tGlISDHtRn8xWENgtLtj6Bj36bpKMGmMC6L80I6XrdFPht50AhsB5q6rT/xWJHhioES/nle+JSMqMDv+9zeXT9y94S+yMAwcEx1ikAeps7/Tf3IGQpAUISd5UwoVu830ZBe8q7m6go1ke0f89Mp4Bowgn0YQYuin7DxyAqg93Rjx/4Gj9p1pWhAq+klZ2JdfV+Mkz2uZhJHSAbs8PwHi3H+9CUqYK6H/42W3wdmZoar+V6OwaA+zJ3kCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++PU2CUbU17jhAgt1SW/XnZqGE4ZWevzkHBa9aSzYxM=;
 b=EsKQGJiDstR5GWY5e3wMb2FAJvvoVm37jErqZxbJhxNYvaqc2W4NFC8b3YPQ9ukyr3BY24p/VlBEljcysw2e9tgxZvLuBjsDunMV3/BRZk4hOz+Z2e2ZHLdq5n/MjeBMTzg58T7zim/YXi4YBIfSIWoyP5CQDCMnhApD9Cx41cOzhJ0h0kWJU+X3W983+uDEJVxNv1gJmYXhH5LqPGKCMgpv7nYfvTepcqiPVsCwo4Lb4Kqc+gRBZPZYUAuokvb7B5lUIqlgHEM0pPH/EoQl7Gzncf/Qq2bCbW+Cu7YrIJRSRGYl1+Q45Ndodr7zzpZg8uXV84kC9SweK9B99KxhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++PU2CUbU17jhAgt1SW/XnZqGE4ZWevzkHBa9aSzYxM=;
 b=hdOHrAIU6k5dGkRU5O2mSeDHadXKHoe7jl42F4oMWgO1LPIVfmzPeFYkcaIElnNMSkk0Y5nyQxqfjTqskgdI7/hgFIPSmWJGi11Ao5/XGkmsoO4HImvNIKHASOAFK/dn7yuUGYe3jRdfssnbQoFvQJSTxYm606rVBQ1bO/Zq0163l5ahOz/xoxAH+SEo+CIFW6/lr8lZO4xjuuu20YQ3tv/1vhff1bQMqmpPZJH+zpsyO9zBLRFY8cRYVczgWRHX1w3YKJP3SFKBKXvvZi0notITKxphSPcWswFBYfzblmF8ummv/fHqhGqiSAyhKLElxXPpAK2QPCnLeUu6OyiP2A==
Received: from LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 15:09:25 +0000
Received: from LV2PR12MB5989.namprd12.prod.outlook.com
 ([fe80::302b:17a4:d0c4:699f]) by LV2PR12MB5989.namprd12.prod.outlook.com
 ([fe80::302b:17a4:d0c4:699f%3]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 15:09:24 +0000
From: Harshit Aghera <haghera@nvidia.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Shakeeb Pasha <spasha@nvidia.com>, Arun D Patil <arundp@nvidia.com>,
 Raghul Rajakumar <rrajakumar@nvidia.com>
Subject: Requesting suggestions on how to access I2C Bus of the Guest OS
Thread-Topic: Requesting suggestions on how to access I2C Bus of the Guest OS
Thread-Index: AdpdxM9YTUMTZcefREyaZCJFYeDAWg==
Date: Mon, 12 Feb 2024 15:09:24 +0000
Message-ID: <LV2PR12MB598943FA3FC5605955DCF2A0D8482@LV2PR12MB5989.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5989:EE_|DM4PR12MB7597:EE_
x-ms-office365-filtering-correlation-id: 2304358e-45a2-4e2c-0c7f-08dc2bdc998c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zoa0pLJolWiJczb+fcCDedGlG2b8nJ9oPaqCgj14mFbJohoUsPVW5BtF44MIJri4BZ/Mir1KUNVlxgfDSUjjeYaNGiZn7UZyr9g7yZgpCMfidW8N40qxoUjo/OBp6KE+jCORFfFdj05sG9X2Gs5X9p7CMMqQdz3OOTM/4sxIIWEKGNKKgdsbftSz139yjk7kzxaIONMtZqvJVeY2r7T6IEoP/7I3I7lhk88sb9w8NzAlP+pKF/Zq2Ld8XPfukXBwOf4G1VZ0jZPB0g6mDw7YsLOMAv6vtz+gmYmhmH/uBWsQ6bebxuDNKru1R1SacaHDjbjmziriuath8VWtljoMudRXy2DMH3Oka3G/3pzOcYmJbTcZEv3NDE4CB0kQSrJLADdOdf+yxzsxlPZgIwQDumtOvX9fqYCTbRTg/PI4hrYvIbf2XTAUnxkL1mvudH6KW1b6J59fgbwsSl6UijLmlEYaSaAuaLRYa3+IXNtrfTa5e8mUFUP9nT8L5kiJztB9AI6KJvoxClmijEiKL3ORC+6d8wBrExwTUp60Xvd8ZMcDH7Va6u4mfSlwCkpc83i2dOrDOQcGeWoaWQgyVwuBoGskdR3oMkvHiX9FmGBZwaA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5989.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38070700009)(55016003)(41300700001)(76116006)(66946007)(316002)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(86362001)(52536014)(5660300002)(4326008)(8676002)(8936002)(166002)(71200400001)(6506007)(478600001)(4744005)(2906002)(7696005)(122000001)(38100700002)(21615005)(33656002)(83380400001)(26005)(107886003)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?InFZ0s0fBjcHqtVnFTHgh4cpFWUj3BTck8yxPUZTAwfaNVYNaKCNYwAw9b1m?=
 =?us-ascii?Q?zv6b9kDd7897IMK6o5RB532qU51TtOlvS5E9G1pg4w5RTDHDdB3i+ObTTJkw?=
 =?us-ascii?Q?/DTn+222gKD1D3lfHsAv1b4SyRm9fmUbe3eVIwHzqO5GDPKjEm2dNxc39Dxt?=
 =?us-ascii?Q?7gOd924R48ks4LIv09xzc81WCCeIRe+rXAitLUg2xVNFGMXMCj4LN79fZXYI?=
 =?us-ascii?Q?JVoEf7Oap7wxYO171Icfv6mqz9zylxADP7IUQbeiv9Pc8cSMQ/0vovvnNetQ?=
 =?us-ascii?Q?HwSErvRuUnPcN1uxYzxRv82GNxjb3tSoHPaT8UBTxSnzJr5ggqJ7XApsSS/8?=
 =?us-ascii?Q?TXp/uIgIhKwFwEyUaXJSka7zH76LNmEAIZaTGOHuWbOYpNB+DJGz3FduaTG1?=
 =?us-ascii?Q?npoDWVyVUBLelVukEnG9D6OZZPoJ4jvXMQGPDLn0hvZDYpPEIFIvu/ieurR9?=
 =?us-ascii?Q?JB16VzJE36cdjmZ2p8XkWGgXEm/73SX/CRFKZOosW5zIQUUWzH2sk8iZ3dUr?=
 =?us-ascii?Q?7OTh0OO6pWaGAGN2u/OCXBtlvBBjaNwlRHGJuxodNFBHcZ+ip0IYVtnlYnV9?=
 =?us-ascii?Q?hLg+xbo2xsEfaTJ13+zT3A5YF6GHk8SA/IuiFYgHI/Z8g0uPrpP+qvtsAGXy?=
 =?us-ascii?Q?J3bYyFO841hCS2Bp1NGGuIb0Gfg08VThYR58BINz+tR+0KCSY+8/LJIlbX0h?=
 =?us-ascii?Q?i4X7x2ePNIC5vTs9Va8opAK00Vlk+qwJj8Ly5EzYK+AXiIbfqomM5i00pRRq?=
 =?us-ascii?Q?tUe2N0wly88t7R6/eOposLISlwzqtv5TkzJRZ4aoSNiXf8jD9YFbG2zP2k5F?=
 =?us-ascii?Q?9alB1MfrIUkNBPSGbNOOGKIi28D5iOTwwe/CK3MINX8WjA+ezgOKnrF1jRFu?=
 =?us-ascii?Q?o5zPMkWU2v8+ZSxakIca5AQyIoG6nZNgRmIGyiD3vx1mkOFxNYCvpl6WKvbZ?=
 =?us-ascii?Q?rEXqe1G+hdPE17ufGwPFRXqrul1uQJqC6qYFNZTbimL4SuyVx1NPFGLbfICW?=
 =?us-ascii?Q?VIuODJCreHQGGozDvw2pbUWvMxv7X7agyqURPG8V9fPTVrtAaY345FRaFcmc?=
 =?us-ascii?Q?tUuFHO3mp1k85mxOLxU2kt+BIcGJEc5sTb2PrmdQ1P9kNtQCX/2InSsoyms7?=
 =?us-ascii?Q?UYo/0lBJh9uHyw5zIZ0nWjzSxPriiKFVl+FD6mQGp83zStrzVOnu0JdX5GJK?=
 =?us-ascii?Q?V8dVFNhlMo50WSVkOxtyrk8IgaREBZNEHuvo4DYOk7/x25hX8jEXebU1qaR7?=
 =?us-ascii?Q?8Zascjp9w0NLaZdM0/aaGsjoBfUgZoGcV0aetoSd7lNt6Zz+OF4WBcdOOjgO?=
 =?us-ascii?Q?sLmigYmPjFZ2Ao1FwMhq1e82fucjr99AMjDHw6wd+lUffsJMFNqLomaZVAvC?=
 =?us-ascii?Q?Y+BkkQzK/SeU86u88sGPAYOzVWtA9BnHHrFZsTB6AWWMEw8NmMAfA2CxKaAG?=
 =?us-ascii?Q?bfzdm9AKgn9M/RA6NxGHNUkTr0cNnexJVNkGj2mZrjLkULDt2yTCLeaS7C7l?=
 =?us-ascii?Q?DOXMrwjhHLtaC/d1bM4BYEplRADMaFUuY2YfIvV3ba0/L4k+Fbesboi5LIgq?=
 =?us-ascii?Q?uusUSL3kfSakZ9irkbQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR12MB598943FA3FC5605955DCF2A0D8482LV2PR12MB5989namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5989.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2304358e-45a2-4e2c-0c7f-08dc2bdc998c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 15:09:24.8607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUEVPUvsNazfdByYLyE3hMIMnRQCp4CwhcQEvsKcrdlK9Miq/5d6cfOtlnAxmTKSRGit7AaxjT0fZtQn0Kk4fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597
Received-SPF: softfail client-ip=40.107.237.49;
 envelope-from=haghera@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Feb 2024 11:01:04 -0500
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

--_000_LV2PR12MB598943FA3FC5605955DCF2A0D8482LV2PR12MB5989namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We have a Linux image targeted for architecture Cortex A7, that we are runn=
ing inside QEMU on x86 machine.

Our Linux image has I2C slave with EEPROM backend, instantiated from user-s=
pace. Reference - Linux I2C slave EEPROM backend - The Linux Kernel documen=
tation<https://docs.kernel.org/i2c/slave-eeprom-backend.html>.
Commands used from user-space to instantiate these I2C slaves -

echo slave-24c512ro 0x1054 > /sys/bus/i2c/devices/i2c-0/new_device

echo slave-24c02 0x1054 > /sys/bus/i2c/devices/i2c-1/new_device

Is there a way to send I2C messages to these I2C buses (bus 0 and bus 1) on=
 the Guest OS, as a I2C Master from the Host OS?
Is there a way to send I2C messages to these I2C buses from a separate QEMU=
 Instance's Guest OS acting as a I2C Master?


Thanks,
Harshit.

--_000_LV2PR12MB598943FA3FC5605955DCF2A0D8482LV2PR12MB5989namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
code
	{mso-style-priority:99;
	font-family:"Courier New";}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";
	mso-ligatures:none;
	mso-fareast-language:EN-IN;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">We have a Linux image targeted for architecture Cort=
ex A7, that we are running inside QEMU on x86 machine.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Our Linux image has I2C slave with EEPROM backend, i=
nstantiated from user-space. Reference -
<a href=3D"https://docs.kernel.org/i2c/slave-eeprom-backend.html">Linux I2C=
 slave EEPROM backend &#8212; The Linux Kernel documentation</a>.<o:p></o:p=
></p>
<p class=3D"MsoNormal">Commands used from user-space to instantiate these I=
2C slaves &#8211;<o:p></o:p></p>
<pre>echo slave-24c512ro 0x1054 &gt; <code>/sys/bus/i2c/devices/i2c-0/new_d=
evice<o:p></o:p></code></pre>
<pre>echo slave-24c02 0x1054 &gt; <code>/sys/bus/i2c/devices/i2c-1/new_devi=
ce<o:p></o:p></code></pre>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Is there a way to send I2C messages to these I2C bus=
es (bus 0 and bus 1) on the Guest OS, as a I2C Master from the Host OS?
<o:p></o:p></p>
<p class=3D"MsoNormal">Is there a way to send I2C messages to these I2C bus=
es from a separate QEMU Instance&#8217;s Guest OS acting as a I2C Master?<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Harshit.<o:p></o:p></p>
</div>
</body>
</html>

--_000_LV2PR12MB598943FA3FC5605955DCF2A0D8482LV2PR12MB5989namp_--

