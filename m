Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B1ACD4F48
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 03:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJNdS-0007hC-F7; Wed, 12 Nov 2025 22:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vJNcy-0007bB-6z
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:04:07 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vJNcv-0002Du-NN
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:04:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqwV+xxjSqU+GyOgH3BoqzZmYNZxIGwrbws3mpDxRImU3Ywm1ngVwVqYT7fMUKqd0X1AuJksBDjUZj5zargg/JDYksDMlBPt1Gtw0JK5lHcn5l78KlTxF23uCDKv/y6SyV1D770EbqfWu0y0jXt1OTAeISBY/lyUDvyowkc4DCUfz84QTj0vFU9UIQHW07TQtomDFDgs1homOK4o56pANYJtGPldnKSbrpAvPjQT+Nbo+QaWvrzlrCjY+EoU1hHjV38Pg7q0iwb5iqwjnKDsjBxCIYl9uKT3KZRyyYN7k/fXib/hRlOPWjfR8SHigoUso5pR07yvarAngzxBl2vkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vfct/9o2/jpXtLJoG65SlHfcQ0LrI6A5mhB3th02O5o=;
 b=C4mh9Ku2xClxJlFAideR2hcVTPnK4Ini4my9n0lAfDG2Wp4ypZYWN2jP+3oQWGn5TVa0ogPVXzv6QawWiyAYr08UxHohqSG9bKSeHWvJXsANmgCCVRaHCsagNzZCB9I/9jlkY/mbADpC3OhzBYWJqHCL5X2gXTmdrQ/A5ssuxI7K8Co1CTfHTy1wiecVTWF9FhkOIMQB7o4mKvUoMATxHznBoN0yW25iOELyn53t2EporcYEbytjSI4p7g5hJYXzIIClUdiVc8G9R6OxgUQ7NSO3Jd0gTLbKMhVdCs9wHTwOpFW/k4X8RcS1vf64C+82dpxK02FMdODTDK2g8nyCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vfct/9o2/jpXtLJoG65SlHfcQ0LrI6A5mhB3th02O5o=;
 b=cHHrII6+YupqtRPewZHbg0yvtdPm7ms4AOxvR3IaJedZc5yNgh6Kq6E2l5c1TOU67vkW/LnQjUSngJ8UkJ8xXBWAHFH1SEHIifkd53o3IcEvPabwXb1I8PSTTiNUzC5G1hAjsbX6FlUbuh2G2uOrDlSGCCX+f/U+sel2EfmBNypmUOuBxPDJtGYZd00WJXSPguHnwYV7WKC2XmuiI+BXwf0GOxPAAFiYa9F6X1K8fdn1GWbv8WldzaB+EPgnfxt8AcU0HQL4Ox71R2yGMQVyNLlWZFtECU+TU/X6Q7pw33jnuDnzDsx3s8wwh08tJ9HDsfny7wCrEMC6TPyjUIY6aQ==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by GVXPR04MB10023.eurprd04.prod.outlook.com (2603:10a6:150:118::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 03:03:56 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9298.015; Thu, 13 Nov 2025
 03:03:56 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional
 testing of iMX8MM emulation
Thread-Topic: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional
 testing of iMX8MM emulation
Thread-Index: AQHcUjR4IKJSoyibD0aCjGOoNfN43rTuH2WAgAB2bjCAAAqRsIAAQSGQgAC1rQCAAFfOQA==
Date: Thu, 13 Nov 2025 03:03:55 +0000
Message-ID: <AM9PR04MB84876B6AE4DA9618F80E272F87CDA@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-14-gaurav.sharma_7@nxp.com>
 <61242433-9D75-47F8-BC44-FD35748F055C@gmail.com>
 <AM9PR04MB8487682307D0672DA3F5345B87CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <AM9PR04MB84874E537D542ED6CD0216F387CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <AM9PR04MB8487096A518874924AC17DEB87CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <D361607E-6F67-4FEC-BC68-A71BB1823B9C@gmail.com>
In-Reply-To: <D361607E-6F67-4FEC-BC68-A71BB1823B9C@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|GVXPR04MB10023:EE_
x-ms-office365-filtering-correlation-id: d6b44cf4-99d0-4727-a6b3-08de226148bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tLnG41SQvpiavFBOJwjNgeG2J43u2EVeUPE4ky/shQWKkNqtdp3kmaxgWa8M?=
 =?us-ascii?Q?kZ5eLOcER5x2XNBNGhgXfNN5OS3B9FcrMqbKW58Y8Pqxr7y1MwIvDj2xzPRh?=
 =?us-ascii?Q?SWKQhRNBwzkS0mN0ZTK1SwUkoUMmk/r/REdEtN/oVl7RizpvzaxKjd+fPBLe?=
 =?us-ascii?Q?ug9zwYGAUpAlxlTufrnJHpOFgVz/x5TRqkQx1OBCheb47iOJaZ1peXk9Vztm?=
 =?us-ascii?Q?ra8uawMLR69hq7V1Zq2vFXcoyfY7rH0riLt1PFtOWusX/Vi5bRNBCYgDHNlt?=
 =?us-ascii?Q?gpGYI9rthZUPWmbgmK5xZh3MMJVE8DFSfHSiFn15XLzylVj3PKcfPG3L+YHq?=
 =?us-ascii?Q?KykhK5v8na0C4Ux07Mf5okCFXAVupuILvEEEkpZEJSQXKQeQ2d5qRFfoi/WX?=
 =?us-ascii?Q?3hUZaO/bTdESHPjvR+xyiojPiGL6I8fQrFWZUocaCEDRtd2CdsNRt6Ki7WwQ?=
 =?us-ascii?Q?v6c3ru2gGcaF0DvPMaZ3znii3ZKhBYzWPicrpsgv6bgXy2xMS+rorBwX5t5m?=
 =?us-ascii?Q?G4AaognwSqMHa841iYXECRdo0abnRdCPnMjLJzHHU2YbQ128rq9bRyn6nk4f?=
 =?us-ascii?Q?0lryOIQo5dq0jErcz/qIAiy8skxuTcfrfmFJ/1l75tzavxu+WbipGMt8B21r?=
 =?us-ascii?Q?BHwkpZnwTtIQCc86stQybQ24H4u2l/HWjKhwQ/yWOu8wW3nGm8azw37b64pX?=
 =?us-ascii?Q?Qryv4U9ZmAvWx0ZMZS0iYqU54Vbx8Lmpe+7+YCK3nUrar4kAPk/eHqprGXBe?=
 =?us-ascii?Q?m/9d/4Bdorg8xrIqlORogbD8/jQ8LiahCN/O0jJhGG2uQ8gAlmmdKxZTJFGP?=
 =?us-ascii?Q?l6M7W8SxDtSDNFr+KYVpgbGTEGhxeIHmQtPf+1IRwzn3AxyvErzoz9rFs80P?=
 =?us-ascii?Q?l6ENYiG8fvFGpjS2DpRY7yTcoJT9eofyojSxFYYNtybL8IHd6KWPOA82kI76?=
 =?us-ascii?Q?Ecc9iCFqy/NZze2qtNMVODynbq9ivsQyFigebxEKN8ik4PHHFzTTwktm6iPq?=
 =?us-ascii?Q?MpXcWtZoy1ic7ds0AYNQDiJLEj5iYyM5s62xA+hxx8pSvDJ/mHO+zu3ce5lB?=
 =?us-ascii?Q?f38JSfwNw130gcbxdlpVV5IxxoX4agIP8dqWuJ1I4F1qRMtEEul0h0b0mXIj?=
 =?us-ascii?Q?8AOozUo80+XWW997UEV5QsV6Iaf8GDeS+knmnYLyB58Uv7Ubfx9gi4beWBKx?=
 =?us-ascii?Q?b7YHJxyi9ja23wTCdx5E2CtBccYFhN+rPJbhiQZF9EFQ/AQAT5KoFzSP7ihX?=
 =?us-ascii?Q?nFByHRWvwJKsPU1d53LMyRYp9ybBKcAFBlkdTOS7ddgKeBldg14x0u+ZGhxr?=
 =?us-ascii?Q?O/LI09S9SRd+4l5LZ39rZpM867JIRtoDuqRji/Fj5EHMPkGGj/jBQZYvVoi4?=
 =?us-ascii?Q?sBRD9KfnP7egS6MNFBKnEZvcyip2gllRrSaqER4SQKstFqALdDHCU4FaMlJj?=
 =?us-ascii?Q?egU+jBGIDxpE1wjgs/432l8oyYWydfyQTv4eC9SGtVJe7WV9x9VQwhXEofvd?=
 =?us-ascii?Q?sBRXPGuIhp5L7E1CuTyzs9zRJBy8gkse02RW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jRSQo7qF5O0fMEE0wenxhtvc2N+VeTSoD5i0lOvnj4+jLBdeoH3v0e0ewURg?=
 =?us-ascii?Q?HwbfFJADxRq1LID4VrYsTjQyJJipMJdyAYWma0vbDli0Nf1e7dz2RV/2quEJ?=
 =?us-ascii?Q?CJ+SkfRnqhz82+Lv8DuUh8H0sGNqt+Vv1nbzUA6bqaRrRlMSO2BIr/aQkSXC?=
 =?us-ascii?Q?afTyvdBtk2/mqjAgH1AJItc9nFxhiL9BFN70MdltZSQHxg75P2mUUn5faflD?=
 =?us-ascii?Q?1gvroWIM1UQYTKiQhdnE2xskXmoyZ9OBwCwmQcfcBDr2qtKO60Rm3rI8kZK2?=
 =?us-ascii?Q?DRvRBchGBw2lV1R24Jf8PGxczBHmORMvgOKxnevXB7cXnJxggRgQQTdEYtem?=
 =?us-ascii?Q?VnBtMsvsnXCCXasEjlNpO48cuGTJa73XH8diQLIsFxr8UDmYK1qtEzNt77gE?=
 =?us-ascii?Q?XTxzx/ULkjfI2pOVWkJxj4lXldJYq+8pSXYtUbaQxuwzsQ3m3e5tixGUCVfg?=
 =?us-ascii?Q?r8or6Ryo4vEgUU0FzeWdkzOz+Woktgr00o1tcNGA7wOXRuROsS2sZrWULPyU?=
 =?us-ascii?Q?FwnMBSKerc+ua4OQFalmE1S4fZ+X8zCt0wrLapp/Gc6SdzXcshatESJqfau+?=
 =?us-ascii?Q?hK1Sgu9TlNSQYTCmPszuXTsk+wYSnSqtTaqwgpjV2BUR3XJRZi9HtD6h6ily?=
 =?us-ascii?Q?q2YVD8zXPc52QFEy/Vo9HWpKKq6IfxFdDUPrekR0P18a/I7FyQzI2EbepHC3?=
 =?us-ascii?Q?XnMLHbIIsg4N0fvlM60E5DTZMRU+WmUyWNcwIMtHfplDKs6MchwvPE/oUnbc?=
 =?us-ascii?Q?6Pz/DIHxMjp20cFjrKNz2j4VJuXT2hM6+tZoKM94mSBO7Ho2eGCn2OntMJFi?=
 =?us-ascii?Q?8ykkgZLCHoS9q5Ae3f9Sl6JcqIlZ+N7XbFqR0xvG3hZoHpQjdqu23WqG7Kiu?=
 =?us-ascii?Q?yvPJf3ttc74/hGgNCOf8Bn6hvUj9upV1B7qhKjToZq04ej4uraoq4dLNAqbV?=
 =?us-ascii?Q?f5O+YHrRe1ZFAO/lG9wQSamCifwlF/1zknGK7lMd2xAqxWz5j57WnIthlP6Y?=
 =?us-ascii?Q?aUJeGXlaar3aIx8ERMMixdh0HuCeFy0GHUSj1p2EHK+8J1h5tSS5jIHO4tdJ?=
 =?us-ascii?Q?CRKza32RIBiSV9jQdXAOpXew4OJzDg5TcFB+pTeXaU8YziDBMqSdOlfkTTzv?=
 =?us-ascii?Q?X6NAewAPcfFUDgS1N9+bbIWvQJmsMktkjp9YAN7cJhsitEyXqXVZOjECTrfh?=
 =?us-ascii?Q?27deDJLmpFW5TBQ1mZ7f5188CO4SViyubRyMoKt5gZ1FhG7vF5spbOvUjcf/?=
 =?us-ascii?Q?JsH1iF01jmwd6s0ACJD+ZIyrMWZi86u46xw2CCfHBK0ATvDmS1OYzFv3OpsM?=
 =?us-ascii?Q?1f0nPjGS1DV7NBEwthCi4i3YhLSnh3DIuMlObwQWcK2585DcHl2SDehxn3NG?=
 =?us-ascii?Q?K/QQba9gAHzmjt+XsJYTISbF0uTuShQOmaXaRwFtK+mdjZ2d1SRVHUKhz3y1?=
 =?us-ascii?Q?1LhDgTMh+kvo4ISAS3nVaAIMcNYUbLG02z8Wa/U6w21XE/hYDIi5v+0m8hIo?=
 =?us-ascii?Q?pC42EaK6j500lGo9/leL3vrIOQsqEp2zXIjCAYn0PEWibyVp2OvJuLAAZF1X?=
 =?us-ascii?Q?6/aSb9da6baBm3pot2XvxT4dH0Ppj6jpojjVprT8bSBQI+sva58A8qkdeONX?=
 =?us-ascii?Q?CltnDYxpCX9XlDIAQL5eNi2t11wZdHyc36J+XO+IzPn7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b44cf4-99d0-4727-a6b3-08de226148bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 03:03:56.0280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rY6Ppkdpih6jmbaX/BOO6GhFYgUWDiXVZufAy1t+d8fCtW3j+znhSb8NF4GE+7muqnrdxjQ3z59iEpePvvdkxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10023
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

Noted. Yes, sounds good. I will make this change in v2 patch.

-----Original Message-----
From: Bernhard Beschow <shentey@gmail.com>
Sent: 13 November 2025 03:17
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>; qemu-devel@nongnu.org
Cc: pbonzini@redhat.com; peter.maydell@linaro.org
Subject: RE: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional t=
esting of iMX8MM emulation

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


Am 12. November 2025 11:02:13 UTC schrieb Gaurav Sharma <gaurav.sharma_7@nx=
p.com>:
>@'Bernhard Beschow' looks like I was referring to the hex dump of a differ=
ent Debian disk image. I have got the offset for iMX8MM now. I have tested =
it as well. The console looks good. Now the only question remains:- shall w=
e continue using offset based method to extract dtb or download it from the=
 cloud instead?

Nice! I'd slightly prefer extracring the DTB from the image for consistency=
 and to have only one URL that could break in the future. Does this work fo=
r you?

>
>-----Original Message-----
>From: Gaurav Sharma
>Sent: 12 November 2025 12:35
>To: 'Bernhard Beschow' <shentey@gmail.com>; 'qemu-devel@nongnu.org'
><qemu-devel@nongnu.org>
>Cc: 'pbonzini@redhat.com' <pbonzini@redhat.com>;
>'peter.maydell@linaro.org' <peter.maydell@linaro.org>
>Subject: RE: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding
>functional testing of iMX8MM emulation
>
>Sorry The correct xxd dump for dtb offset 0x64F51000:- xxd -s 0x64F51000 -=
l 4 disk.raw
>64f51000: e103 16aa                                ....
>
>
>-----Original Message-----
>From: Gaurav Sharma
>Sent: 12 November 2025 12:28
>To: 'Bernhard Beschow' <shentey@gmail.com>; qemu-devel@nongnu.org
>Cc: pbonzini@redhat.com; peter.maydell@linaro.org
>Subject: RE: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding
>functional testing of iMX8MM emulation
>
>Thank you for reviewing Bernhard. Yes, iMX8MM is very close to iMX8MP that=
's why I chose to stick to that structure.
>
>" Looks like these lists are sorted alphabetically. Shall we preserve that=
?"
>
>-- yes "tests_aarch64_system_thorough" should be sorted alphabetically
>preserving the original order - - will modify it in v2 patch
>
>"This DTB offset is the one for the imx8mp-evk, and in fact the console lo=
g confirms it. Both machines seem to be so similar that the test passes any=
way"
>
>-- yes, I just found out in the console log. The test was giving a
>false positive. Thank you for the heads up!  I have now modified it to
>fetch the dtb from the Debian stable repository. Verified it's working
>correctly via console log
>
>What you need is the offset in the "disk.raw" image that gets extracted fr=
om above file. Open "disk.raw" in a hex editor and search for "imx8mm-evk",=
 then determine the offset of the preceeding "d00df00d" DTB magic. That is =
your offset.
>
>-- do you mean the DTB magic "d00dfeed" instead of "d00df00d"? Also,
>while I was analysing the DTB offset of the mainlined imx8mp functional
>testing 'disk.raw' which has debian-12-generic-arm64-20231210-1590. The
>script mentions the DTB_OFFSET at 0x64F51000. Dumping this offset using
>xxd[also verified it via hex editor]:- # xxd -s 0x51000000 -l 4
>disk.raw
>51000000: 6cff 0060
>It doesn't mention the DTB magic number at this offset. Please let me know=
 if I am missing anything here .
>Can we choose not to rely on the hardcoded offset and instead download the=
 dtb from the Debian stable repository itself? This way the same functional=
 test can be used easily for the future imx board porting as well.
>Looking forward to your guidance.
>
>
>
>-----Original Message-----
>From: Bernhard Beschow <shentey@gmail.com>
>Sent: 12 November 2025 04:51
>To: qemu-devel@nongnu.org; Gaurav Sharma <gaurav.sharma_7@nxp.com>
>Cc: pbonzini@redhat.com; peter.maydell@linaro.org
>Subject: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional
>testing of iMX8MM emulation
>
>[You don't often get email from shentey@gmail.com. Learn why this is
>important at https://aka.ms/LearnAboutSenderIdentification ]
>
>Caution: This is an external email. Please take care when clicking
>links or opening attachments. When in doubt, report the message using
>the 'Report this email' button
>
>
>Am 10. November 2025 11:22:57 UTC schrieb Gaurav Sharma <gaurav.sharma_7@n=
xp.com>:
>>Added script that would validate the iMX8MM emulation by checking the
>>linux console log. If it succeeds, it will return:-
>>
>>ok 1 test_imx8mm_evk.Imx8mmEvkMachine.test_aarch64_imx8mm_evk_usdhc
>>
>>Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
>
>>Hi Gaurav!
>
>>Nice to see another imx8 machine being contributed! I'm impressed how clo=
se you stick to the imx8mp, both in terms of structuring this series as wel=
l as the code.
>
>>I've built your series and ran the functional test. Comments below.
>
>
>
>
>--
>
>>---
>> tests/functional/aarch64/meson.build        |  2 +
>> tests/functional/aarch64/test_imx8mm_evk.py | 67
>>+++++++++++++++++++++
>> 2 files changed, 69 insertions(+)
>> create mode 100755 tests/functional/aarch64/test_imx8mm_evk.py
>>
>>diff --git a/tests/functional/aarch64/meson.build
>>b/tests/functional/aarch64/meson.build
>>index 5ad52f93e1..31ecedbf6f 100644
>>--- a/tests/functional/aarch64/meson.build
>>+++ b/tests/functional/aarch64/meson.build
>>@@ -5,6 +5,7 @@ test_aarch64_timeouts =3D {
>>   'aspeed_ast2700fc' : 600,
>>   'device_passthrough' : 720,
>>   'imx8mp_evk' : 240,
>>+  'imx8mm_evk' : 240,
>>   'raspi4' : 480,
>>   'reverse_debug' : 180,
>>   'rme_virt' : 1200,
>>@@ -28,6 +29,7 @@ tests_aarch64_system_thorough =3D [
>>   'device_passthrough',
>>   'hotplug_pci',
>>   'imx8mp_evk',
>>+  'imx8mm_evk',
>
>Looks like these lists are sorted alphabetically. Shall we preserve that?
>
>>   'kvm',
>>   'multiprocess',
>>   'raspi3',
>>diff --git a/tests/functional/aarch64/test_imx8mm_evk.py
>>b/tests/functional/aarch64/test_imx8mm_evk.py
>>new file mode 100755
>>index 0000000000..d5eb43afc6
>>--- /dev/null
>>+++ b/tests/functional/aarch64/test_imx8mm_evk.py
>>@@ -0,0 +1,67 @@
>>+#!/usr/bin/env python3
>>+#
>>+# Functional test that boots a Linux kernel and checks the console #
>>+#
>>+SPDX-License-Identifier: GPL-2.0-or-later
>>+
>>+from qemu_test import LinuxKernelTest, Asset
>>+
>>+class Imx8mmEvkMachine(LinuxKernelTest):
>>+
>>+    ASSET_IMAGE =3D Asset(
>>+        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
>>+         'debian-12-generic-arm64-20231210-1590.tar.xz'),
>>+
>>+ '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b359')
>>+
>>+    KERNEL_OFFSET =3D 0x51000000
>>+    KERNEL_SIZE =3D 32622528
>>+    INITRD_OFFSET =3D 0x76000000
>>+    INITRD_SIZE =3D 30987766
>>+    DTB_OFFSET =3D 0x64F51000
>
>This DTB offset is the one for the imx8mp-evk, and in fact the console log=
 confirms it. Both machines seem to be so similar that the test passes anyw=
ay.
>
>What you need is the offset in the "disk.raw" image that gets extracted fr=
om above file. Open "disk.raw" in a hex editor and search for "imx8mm-evk",=
 then determine the offset of the preceeding "d00df00d" DTB magic. That is =
your offset.
>
>Best regards,
>Bernhard
>
>>+    DTB_SIZE =3D 45 * 1024
>>+
>>+    def extract(self, in_path, out_path, offset, size):
>>+        try:
>>+            with open(in_path, "rb") as source:
>>+                source.seek(offset)
>>+                data =3D source.read(size)
>>+            with open(out_path, "wb") as target:
>>+                target.write(data)
>>+        except (IOError, ValueError) as e:
>>+            self.log.error(f"Failed to extract {out_path}: {e}")
>>+            raise
>>+
>>+    def setUp(self):
>>+        super().setUp()
>>+
>>+        self.image_path =3D self.scratch_file("disk.raw")
>>+        self.kernel_path =3D self.scratch_file("linux")
>>+        self.initrd_path =3D self.scratch_file("initrd.zstd")
>>+        self.dtb_path =3D self.scratch_file("imx8mm-evk.dtb")
>>+
>>+        self.archive_extract(self.ASSET_IMAGE)
>>+        self.extract(self.image_path, self.kernel_path,
>>+                     self.KERNEL_OFFSET, self.KERNEL_SIZE)
>>+        self.extract(self.image_path, self.initrd_path,
>>+                     self.INITRD_OFFSET, self.INITRD_SIZE)
>>+        self.extract(self.image_path, self.dtb_path,
>>+                     self.DTB_OFFSET, self.DTB_SIZE)
>>+
>>+    def test_aarch64_imx8mm_evk_usdhc(self):
>>+        self.require_accelerator("tcg")
>>+        self.set_machine('imx8mm-evk')
>>+        self.vm.set_console(console_index=3D1)
>>+        self.vm.add_args('-m', '2G',
>>+                         '-smp', '4',
>>+                         '-kernel', self.kernel_path,
>>+                         '-initrd', self.initrd_path,
>>+                         '-dtb', self.dtb_path,
>>+                         '-append', 'root=3D/dev/mmcblk2p1',
>>+                         '-drive', f'file=3D{self.image_path},if=3Dsd,bu=
s=3D2,'
>>+
>>+ 'format=3Draw,id=3Dmmcblk2,snapshot=3Don')
>>+
>>+        self.vm.launch()
>>+        self.wait_for_console_pattern('Welcome to ')
>>+
>>+if __name__ =3D=3D '__main__':
>>+    LinuxKernelTest.main()

