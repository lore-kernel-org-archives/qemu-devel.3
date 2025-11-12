Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA4BCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 07:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ4uP-00054n-G3; Wed, 12 Nov 2025 02:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vJ4uG-0004xn-70
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:04:41 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vJ4uC-00042z-CK
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:04:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsCZIYMiTPwHx+Ccj8N++OOnMl/icUuGWO+HBdyEDqAsx0fDzN5cg73WxB9iZJJBnOAYInhcKGqRTWIFdcxKkKHkmqc3PgwH0jLUm4BkwmwSZ/L3t/xs4UWfKo+EftvtGbS6fCBIOjDg+ay6H1ciEkIwBeI3ptRcQR7m1jdNAOs+0pluwzkRqR7GuH3hiVh7GiHSaq0OrUQHv9PUwlszckc/qjA0w9QAul1oCRidnyzZmbuEMlNt8w83usYS+e41h8kJcVWpICnwsRRLSuGbaqELvlOl7Y7tD7T+vjH3ctQpZ2ASjWRUsnLWCtr5Ylt2EhjCfUN0N9deSGazDwGVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbCdmlWdFKkagLt5h9gxV/kuEBgsX97TFMO/Al1dHxE=;
 b=Vm1XcurQS31EeehOs4FORApucN7GZTAKvoBIIX8YK2nJgpeCNZHkhM1bDG02b9qYKkwSjoV6kN1Y5t+wsYCNFd4oKbMGYU+s3D5FRoh0phit2uGGxfLIZADfTwdMvUL+V+nTcgvlBYpuS6YzHWdZqCnoSntRTxXdF5/eHpbjdwe8LcC2PlMW1xIkwBHtUUzMUb11wrpze/5MXPhLvu82oLCMG/dKe7/1i6kQCsEPiGvvK4T3rYB1ldOadCIRHzlRa1PQQHb1J5mc99XS77QjkYqtgNlSat/KVDnespVv8ktkn6/23Ga92oEeGYqFdVCwXamPvu4g12H1KqlWnVxTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbCdmlWdFKkagLt5h9gxV/kuEBgsX97TFMO/Al1dHxE=;
 b=LyiUpLc/yarCYIsxMP88qsnB4wc99FLmdsK6jVRRdFj3axYvMThK1AKOV0fZm2IWvpLseS4d6mgPCfv8Ca8/4DR/MKaprJeHGQOb1PF3Lh3ztBBUUbuvuILnCpKaJYg63gXRe233SVT5bX35OZEZZ0BB0JuquVDgFoKbu/mWJ8OJn7CVoDJVVml90yGvehiqsMPiGrYcpsRxW5AerOQsySoYLgZy9isQnutiP8zAroCVO25Y3bsnmSmoUyItN3AR3h5ZveQBuG3grN5m70t3m7qVGq0h+jRNay+T9sXt5FCw/+pAIFZegMaOEFOTr4CfLAGhlW9YNDH/oUCLbzOHqA==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by PA4PR04MB9437.eurprd04.prod.outlook.com (2603:10a6:102:2a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 06:58:04 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 06:58:04 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional
 testing of iMX8MM emulation
Thread-Topic: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional
 testing of iMX8MM emulation
Thread-Index: AQHcUjR4IKJSoyibD0aCjGOoNfN43rTuH2WAgAB2bjA=
Date: Wed, 12 Nov 2025 06:58:04 +0000
Message-ID: <AM9PR04MB8487682307D0672DA3F5345B87CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-14-gaurav.sharma_7@nxp.com>
 <61242433-9D75-47F8-BC44-FD35748F055C@gmail.com>
In-Reply-To: <61242433-9D75-47F8-BC44-FD35748F055C@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|PA4PR04MB9437:EE_
x-ms-office365-filtering-correlation-id: fc84a118-062f-4cab-b37e-08de21b8d39f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Nv9tyoh5XNk+1uBDzGnVSFmO5WN+yYFcl/133hXXA09Zu+7G1lNFf6HOgN21?=
 =?us-ascii?Q?ZmX1ZU7ZUvxHrEBT9cHxXSbZ0Fxc1EsTdd3BwKq1EHOeccAqfO9H61qCIzzr?=
 =?us-ascii?Q?f3CS600dacG2IaYelZ45a3Dux+4hGwJd1FPQ6UjrH1uxeIHdlE9J/yMBbW5K?=
 =?us-ascii?Q?D7O3Jq2UyNjkWXl/wrlIYXY1qQwfIoLd++kTwuNIrT5hDIYSwudvih5rDQqP?=
 =?us-ascii?Q?I4MMlP9Tou7YIO97rORFwXIxRpL+wHXgux3ttLTF486b47UtIcIzPiB7azeT?=
 =?us-ascii?Q?Fw8Hg6LJ9J3uwTtZRHDH+9fGlkONaPmIdK+D2X1JIF1rAPNPrn3FvItXt9iu?=
 =?us-ascii?Q?Tg31NJHSMxJPmnV95oAzyMB30RmFtHsrhkwIZqdCQOSJHOzaIHmAwz772MB5?=
 =?us-ascii?Q?Ebso2J9VK/Ga0YHjS/wqDevxgksO75bVIgJdmGW5flTMwYWfhKyWFn1G+2fP?=
 =?us-ascii?Q?jwz8aZYTeoCRqg3oztpL2vmoGZFq8k3UjAqXTA/siDBcCX07kzpBZJeGIHS7?=
 =?us-ascii?Q?DqxrFCJpTgxprdowxvDIeZt+9Fn/c9kcQez1uO3iOoSz0qXDtcR9FtFpCbF+?=
 =?us-ascii?Q?DoEFRdZcY3oEoPWuVR32luscYKZGYY+VKrpfJsu0eYpMBdTUCbLg+JcFTLVP?=
 =?us-ascii?Q?ql/sptq00ZiqNTb5QVcuZ3MykeD/XEyXuhDX9k1zhK5bcPTsl0lUO4Cwn1Gb?=
 =?us-ascii?Q?ze+BcP/1DyEdzV1B76e4WjeoKPK7bPhM+VuBv7wKMXGjfTt4jRcNa3Lbv5SL?=
 =?us-ascii?Q?hc9874KMKmbjXQWZwtuyusidX+6li+mS9AbTkRqxEwoJM7JlHcN1Ya06W8Vf?=
 =?us-ascii?Q?eCm2yyGHli/r9P8aq3lFmCp1i/9B3Izck5r76jls4zPirghyYGoGlvhEPdTZ?=
 =?us-ascii?Q?vcKHS0NQ9ahd2dMeJDCH+dxw2MVU74MzCMUQQmWyA39jcgWP/leon20RE8BH?=
 =?us-ascii?Q?qSIrsC5QDRpnJn5C7ipY1Bk5wcneLtvTip1NVFmESc/m9FW/gTbBAce+P1F2?=
 =?us-ascii?Q?T4SGCSJ+T/MBRrZaHM+wNqmxgLkw8vDP1nbPRGv044NK7+8SB9U5HlgnWbcd?=
 =?us-ascii?Q?e7bJJf9OBDi66PvNaXBIg8Yxfl2adu8hm8wituOUurIWO73rM1vPUy7Nt32i?=
 =?us-ascii?Q?Gn5yF5o6RWbnjtNyRxRdQPHwAp8erICScbSfLoJ5Aa3s7KDg2JNhcfO5TCbz?=
 =?us-ascii?Q?cStkozyHp9LeSbLVcb/wS+lHHmyxefAkGJv1n7BVTECHNouPnm7hmb/QaSd9?=
 =?us-ascii?Q?hrlhLpXBs3CmyPaINax6px9WI7YTHYb3zJXOZ6iL13T6kMGymteY4c9UHWHN?=
 =?us-ascii?Q?H9s77x+ekq5DtLsTRyQllZR3BetQmSpqhpZAQZRblWUl3eL2SdN6iqS62ptQ?=
 =?us-ascii?Q?nqVPbuUlMAs1jDdUAdPc3uTvImKlbF9TTtG4AFaoK2/tn2Jyxd08rJc3kPu3?=
 =?us-ascii?Q?4H9YIXOiwgpdk6jc9o4UBP9D9eLg3LHF6GHxNSzS2O9Yq9buEcwG3KrjJ1TB?=
 =?us-ascii?Q?6EfkoITWeUqE9EeAl7SwM6Phsdho+yd3Z2Pp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZdhAtuvGP4++k6AddOFeTfxIXf8PImKHmx87RVffa8fTnEg2t7gElXJqvhOY?=
 =?us-ascii?Q?HPK2APL1zIPFxBgWVe70oHFLjE6xCxLwDCw11fOZvw84yHbd9gjbit2rHgal?=
 =?us-ascii?Q?oSw24IREVynIkl8s8Of8riCJZunZYWfpjGa3sSHhoO19sSpUPohSND9fwyF8?=
 =?us-ascii?Q?UVMiUCZ6Pu5THLQBeo5nwskxCC9yS/ZUhE+rMy+ibe3hc8CjcYl+d92GFjrM?=
 =?us-ascii?Q?cbK0fp+CYdfjTOyJDC6TT4Xl15ylE9zeIQyJRPPYOOFBxSzkFKe4QlAg9Npw?=
 =?us-ascii?Q?bmPA2nRqzYgYvMHjiVg/zl+vUBKuDPLpN419ynKoBQEJBuZdlnADQeKqzzU7?=
 =?us-ascii?Q?13FtlkdtP8/kG0MHZ1rAbOTjWYcyBeTAokLxnp2YIfxWdvDurr2iDPaeGOM2?=
 =?us-ascii?Q?zOOzDZ2yL+/Rw8QyxHwTuUiA8h2JvybyemZlbm87AghYDSE17WQT/pgFoufK?=
 =?us-ascii?Q?pdVhb0yrz57EvUAfYrmFXasELs89U5Atx6+KyxyVQxW+XXZ21QWXD0Kyz6Vr?=
 =?us-ascii?Q?DygThThdb+GCvQyXtYpeKGio8hGfINT6DZYfZtBCNc5Q1k+XtOgouqQ5gVYa?=
 =?us-ascii?Q?Z0X+OVaXi+cRgHi5pbqcQe7uHbYkUuUm/UvN24UQ1e0gdmizBz4Cq3aTcMYJ?=
 =?us-ascii?Q?ZokzCltmPGIMXjCtewwrazoEXFGywFF7bnz3CL7EdF73J64HT+moWYImyjK9?=
 =?us-ascii?Q?gD9oL9MZjVZzJocNcOWlWwaLj9UtGCqJ/g6V54qTEy6Pbmchup35pXpAR54F?=
 =?us-ascii?Q?BKDs3HdrII0b63Kw65zhCDBmEYYyMPxiz9PaYd888Fqppk3uRTotiJWZpzcK?=
 =?us-ascii?Q?GvfWq6BKuMhEHLIDFFE2onUfzexMHp9yam3SlTDEGpEF61yqvvZGyym2OBU9?=
 =?us-ascii?Q?HvLBSr43dmUUUuuagYTagpPkN8rPVPb6AUFG3FJeUVCJ1XG/frDxyMSLFH44?=
 =?us-ascii?Q?8OfECM5EmPXqow+14k+hUzvUVO3CZii8p5qYLEgg7dpFURQuC6qMpa8ewdgs?=
 =?us-ascii?Q?aN/D6CoP+QWnJ+VskXAosLr2Os2871s9vQNeCynNlYGCatcyG5jqtRVg8/9Q?=
 =?us-ascii?Q?1vYbTBj5Z3LFeF/NDyfZM34yW4OgDGKzysFJJgHbOmUGgKfM9ZX81befvccQ?=
 =?us-ascii?Q?yJK58JwuC6G+krYGpvraHnwgzWOVy4WbdO44AWERFIUGLCyQ7LK1DyuXj1w4?=
 =?us-ascii?Q?irDatHl9Lcv1Je6qnPfJJHTRU/GdDQQLJG3uV1NeUoKOi5vP8E9NEq8ISTRf?=
 =?us-ascii?Q?Y1xfx6uji+V3/WBEWFE/dxmySKDj3hnbt6ruCWTZRBeiEaKOsPT2nsvlT3oR?=
 =?us-ascii?Q?h+3Y7dQQTkkvNYDmBNJumEnLUF8zIYCPkXjVWLxwUZZ4wV4V5fJGTmmAhwtn?=
 =?us-ascii?Q?HJMtLFPglS7h94Z2bFuHrMZumuExBmjd0k8yE0Db1PkiBAARfTzSiZL/jLER?=
 =?us-ascii?Q?s1Zc8ZCfCAThQpDDwDIBZoC0Ec9fYmDYM+v2/mwguJOzz/AOLVOSWolD+huf?=
 =?us-ascii?Q?kQQVTD+gMat8ZW00mTPRyG47IpQ9MSSUENMcit4jKhBvV2xT94nkTRoUKqWX?=
 =?us-ascii?Q?yytSZSqpZA70HdD9qOw1uyr508QyHAjRTqa3TStf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc84a118-062f-4cab-b37e-08de21b8d39f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 06:58:04.1218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UFe49Fnml9MWEcEy2/a3xZiuUX9A4ifTFDiRv8UfHRLxJa9AE7YfkeTWqsFb3K3/fzZRlXur+prYMkcvZEAEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9437
Received-SPF: permerror client-ip=2a01:111:f403:c20f::7;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
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

Thank you for reviewing Bernhard. Yes, iMX8MM is very close to iMX8MP that'=
s why I chose to stick to that structure.

" Looks like these lists are sorted alphabetically. Shall we preserve that?=
"

-- yes "tests_aarch64_system_thorough" should be sorted alphabetically pres=
erving the original order - - will modify it in v2 patch

"This DTB offset is the one for the imx8mp-evk, and in fact the console log=
 confirms it. Both machines seem to be so similar that the test passes anyw=
ay"

-- yes, I just found out in the console log. The test was giving a false po=
sitive. Thank you for the heads up!  I have now modified it to fetch the dt=
b from the Debian stable repository. Verified it's working correctly via co=
nsole log

What you need is the offset in the "disk.raw" image that gets extracted fro=
m above file. Open "disk.raw" in a hex editor and search for "imx8mm-evk", =
then determine the offset of the preceeding "d00df00d" DTB magic. That is y=
our offset.

-- do you mean the DTB magic "d00dfeed" instead of "d00df00d"? Also, while =
I was analysing the DTB offset of the mainlined imx8mp functional testing '=
disk.raw' which has debian-12-generic-arm64-20231210-1590. The script menti=
ons the DTB_OFFSET at 0x64F51000. Dumping this offset using xxd[also verifi=
ed it via hex editor]:-
# xxd -s 0x51000000 -l 4 disk.raw
51000000: 6cff 0060
It doesn't mention the DTB magic number at this offset. Please let me know =
if I am missing anything here .
Can we choose not to rely on the hardcoded offset and instead download the =
dtb from the Debian stable repository itself? This way the same functional =
test can be used easily for the future imx board porting as well.
Looking forward to your guidance.



-----Original Message-----
From: Bernhard Beschow <shentey@gmail.com>
Sent: 12 November 2025 04:51
To: qemu-devel@nongnu.org; Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: pbonzini@redhat.com; peter.maydell@linaro.org
Subject: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional testi=
ng of iMX8MM emulation

[You don't often get email from shentey@gmail.com. Learn why this is import=
ant at https://aka.ms/LearnAboutSenderIdentification ]

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


Am 10. November 2025 11:22:57 UTC schrieb Gaurav Sharma <gaurav.sharma_7@nx=
p.com>:
>Added script that would validate the iMX8MM emulation by checking the
>linux console log. If it succeeds, it will return:-
>
>ok 1 test_imx8mm_evk.Imx8mmEvkMachine.test_aarch64_imx8mm_evk_usdhc
>
>Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

>Hi Gaurav!

>Nice to see another imx8 machine being contributed! I'm impressed how clos=
e you stick to the imx8mp, both in terms of structuring this series as well=
 as the code.

>I've built your series and ran the functional test. Comments below.




--

>---
> tests/functional/aarch64/meson.build        |  2 +
> tests/functional/aarch64/test_imx8mm_evk.py | 67 +++++++++++++++++++++
> 2 files changed, 69 insertions(+)
> create mode 100755 tests/functional/aarch64/test_imx8mm_evk.py
>
>diff --git a/tests/functional/aarch64/meson.build
>b/tests/functional/aarch64/meson.build
>index 5ad52f93e1..31ecedbf6f 100644
>--- a/tests/functional/aarch64/meson.build
>+++ b/tests/functional/aarch64/meson.build
>@@ -5,6 +5,7 @@ test_aarch64_timeouts =3D {
>   'aspeed_ast2700fc' : 600,
>   'device_passthrough' : 720,
>   'imx8mp_evk' : 240,
>+  'imx8mm_evk' : 240,
>   'raspi4' : 480,
>   'reverse_debug' : 180,
>   'rme_virt' : 1200,
>@@ -28,6 +29,7 @@ tests_aarch64_system_thorough =3D [
>   'device_passthrough',
>   'hotplug_pci',
>   'imx8mp_evk',
>+  'imx8mm_evk',

Looks like these lists are sorted alphabetically. Shall we preserve that?

>   'kvm',
>   'multiprocess',
>   'raspi3',
>diff --git a/tests/functional/aarch64/test_imx8mm_evk.py
>b/tests/functional/aarch64/test_imx8mm_evk.py
>new file mode 100755
>index 0000000000..d5eb43afc6
>--- /dev/null
>+++ b/tests/functional/aarch64/test_imx8mm_evk.py
>@@ -0,0 +1,67 @@
>+#!/usr/bin/env python3
>+#
>+# Functional test that boots a Linux kernel and checks the console # #
>+SPDX-License-Identifier: GPL-2.0-or-later
>+
>+from qemu_test import LinuxKernelTest, Asset
>+
>+class Imx8mmEvkMachine(LinuxKernelTest):
>+
>+    ASSET_IMAGE =3D Asset(
>+        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
>+         'debian-12-generic-arm64-20231210-1590.tar.xz'),
>+
>+ '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b359')
>+
>+    KERNEL_OFFSET =3D 0x51000000
>+    KERNEL_SIZE =3D 32622528
>+    INITRD_OFFSET =3D 0x76000000
>+    INITRD_SIZE =3D 30987766
>+    DTB_OFFSET =3D 0x64F51000

This DTB offset is the one for the imx8mp-evk, and in fact the console log =
confirms it. Both machines seem to be so similar that the test passes anywa=
y.

What you need is the offset in the "disk.raw" image that gets extracted fro=
m above file. Open "disk.raw" in a hex editor and search for "imx8mm-evk", =
then determine the offset of the preceeding "d00df00d" DTB magic. That is y=
our offset.

Best regards,
Bernhard

>+    DTB_SIZE =3D 45 * 1024
>+
>+    def extract(self, in_path, out_path, offset, size):
>+        try:
>+            with open(in_path, "rb") as source:
>+                source.seek(offset)
>+                data =3D source.read(size)
>+            with open(out_path, "wb") as target:
>+                target.write(data)
>+        except (IOError, ValueError) as e:
>+            self.log.error(f"Failed to extract {out_path}: {e}")
>+            raise
>+
>+    def setUp(self):
>+        super().setUp()
>+
>+        self.image_path =3D self.scratch_file("disk.raw")
>+        self.kernel_path =3D self.scratch_file("linux")
>+        self.initrd_path =3D self.scratch_file("initrd.zstd")
>+        self.dtb_path =3D self.scratch_file("imx8mm-evk.dtb")
>+
>+        self.archive_extract(self.ASSET_IMAGE)
>+        self.extract(self.image_path, self.kernel_path,
>+                     self.KERNEL_OFFSET, self.KERNEL_SIZE)
>+        self.extract(self.image_path, self.initrd_path,
>+                     self.INITRD_OFFSET, self.INITRD_SIZE)
>+        self.extract(self.image_path, self.dtb_path,
>+                     self.DTB_OFFSET, self.DTB_SIZE)
>+
>+    def test_aarch64_imx8mm_evk_usdhc(self):
>+        self.require_accelerator("tcg")
>+        self.set_machine('imx8mm-evk')
>+        self.vm.set_console(console_index=3D1)
>+        self.vm.add_args('-m', '2G',
>+                         '-smp', '4',
>+                         '-kernel', self.kernel_path,
>+                         '-initrd', self.initrd_path,
>+                         '-dtb', self.dtb_path,
>+                         '-append', 'root=3D/dev/mmcblk2p1',
>+                         '-drive', f'file=3D{self.image_path},if=3Dsd,bus=
=3D2,'
>+
>+ 'format=3Draw,id=3Dmmcblk2,snapshot=3Don')
>+
>+        self.vm.launch()
>+        self.wait_for_console_pattern('Welcome to ')
>+
>+if __name__ =3D=3D '__main__':
>+    LinuxKernelTest.main()

