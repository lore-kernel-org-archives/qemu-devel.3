Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0239F45A1C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 05:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCWG0-0001nL-6X; Tue, 14 Apr 2026 01:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCWFx-0001mz-7t
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 01:24:13 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCWFu-0001Rq-Ga
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 01:24:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VK77d31yOjcN527lgJGoA9RNC+HgvK4s1c36MukwPwWWFE1MWVcrmmtEU07t+zhVxf8I6VCb1e0XxEdMYKnYC8E59Pwn/ebb0Ww1RqiNci2mhqSUB5ygQrotSeYwTm5QclZ+F6J/S013aVJ1MwMD32sU4x83n6fB7KF2nI3I353gPLaNpeRhSRqmTmN/dyrRAz8Hot3bSNb99Zlu5Vlij0DOzulm7bVxNi23RX0h7F/xxLPhUnaDkoxsD6Aa5Q8V4EbULqi5JiwVhu/WGnL49wmB90+kjjVClhXmbWgmxXqnZzf6/bdoqFd1z8rfkyMPGCNrXaiPYBF3V+IrM/CmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBLHDtggFhOqAsPrccedcLpA4fJcN+deUuwwmgsLoD0=;
 b=ApXOFEZF3m/YKHgKEyxbUBtMBEZpD2aZBVULa3V9Er3iNr3Lpsd+EoKpnL8MifvkmyfbwmNLEkPFgTLPO4h/7p7lyY5JUfcBBf/WXkSGmat6VkWZDQiWQhthuPldrc5w1uUQs3rk8QnrjXJZ1b2CETnzWwIWTn344xokv6u/4Vc8wGq8aONuhkPXbbkkLwighjxe+NO7UhJYAsuV+yPfm21Fah3Rx0s1CDTcqN0MRfbv81/faMODe9kEOfPIROlOIqzTLq8BCR6UFkAYrgQKiFMemedbPJY30QzMkCVkRF6RWvCFh8nj9fQCwCwFxg6ZgE1VGqy2tzXSdeSA8ICJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBLHDtggFhOqAsPrccedcLpA4fJcN+deUuwwmgsLoD0=;
 b=Shp9PU5KJdPfl7wQb66/NlsUB6Slv3dwpqAqc+WdleKhArqGFNOMECIrt/Tdz3XLqIqWZRw4M7PPiI6R4bJrU6iumhD3ETSlG2LRa/ky0frGOnoEHrDSNbaD3LWp0zPdDt+eYPpLojM6HT5r5QzpfcGW9mSAGXzaTmcC5GbMIw/b+xVWuH+0nIWzGL8S/I4x+pT2hMab9qFAPTKX4dSlklz1mSS/z/uitkJVDO8f+ICzVv3sz8vAj6k4an9bBFuye16WRCnhlQZv7rDuSgmZR7IjvYwOl5k5MGQHMc65wi3BsiUVkFYb6qVn8HOA2SvG6rnLwKWs3usFJrF7Y4NXmw==
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com (2603:10a6:208:6e::32)
 by AM8PR04MB7410.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 05:24:05 +0000
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b]) by AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b%6]) with mapi id 15.20.9745.035; Tue, 14 Apr 2026
 05:24:05 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Topic: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Index: AQHcyxhq2POQGlihkUmOWoImS6Nbv7Xc/V4AgABboCCAAAaFAIAAGGWAgACNCZCAAAJywA==
Date: Tue, 14 Apr 2026 05:24:05 +0000
Message-ID: <AM0PR04MB43702D5422ED420F6566895E87252@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20260413073737.986219-1-gaurav.sharma_7@nxp.com>
 <9BF9D1F9-DA94-41AE-8C81-2226B17E096A@gmail.com>
 <AM0PR04MB43700A10A6F9E20DE479701887242@AM0PR04MB4370.eurprd04.prod.outlook.com>
 <AM0PR04MB4370028D6C330307CADBF81D87242@AM0PR04MB4370.eurprd04.prod.outlook.com>
 <AE626996-1262-42ED-8400-9684DA86F871@gmail.com>
 <AM0PR04MB437078A384825E22C9B6B28287252@AM0PR04MB4370.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB437078A384825E22C9B6B28287252@AM0PR04MB4370.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4370:EE_|AM8PR04MB7410:EE_
x-ms-office365-filtering-correlation-id: 5db59018-bb18-4028-9f4c-08de99e60c06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 6AlmqoF6T3GY3o/JqBw5HknPyqw0e/XAlOSXGjwo3krxalHUvF7C5pAnBdHQQyQc2tl0foc7vqs2SNggC0T2sQvN29rK/FCFbz3RjOmeh+ePN/CXoekWobMdpXIkngGw8QdwfK52IWQj68FpdkXV/6nXDNuuJSm8imQG3x/t1Ytf1bsQ3hAOHRk8u4l041ZgwCrkDLAS4JMSQxDnxy5Pd9u9OtopKmIukax///IrKG2P26sRFEBQravKdUh2A4PPK5QBRm5+K7R9EtpppzAArpjxL6m0wQr3n5xt/G3/CJOyGlftCOHWZ8uhYtEHEWuo4OAXdN1QH3yHqdLB2Tfyng7ya2HvVt4LMy1Ut+kTrviy6hrDndNaymYZA1w1jNdfYw1M1TtVTFgenVKzBFjeS6smREuw7lz9FMMMG4BnTB6QyxTh2dFxDtZ2baTlqIsVBPJKhd4qn4anphtvGT2IPdUyfM0r9yqkfayjP6mHI5TmZXavk2ojcpOy2zIhs6ejm96Y/hPWYNT1tjoOohsKV4IRbqj3K8NC+CElraY7RwrJiwAJ+iNt9KgKlH2nXUnyPDBaYVAU5cpAuOoR1mdojicq2BuSf0hNTgfpZj8g33i6GWaezHu6bC6p1czL+y5ntKcdlauIPW9E1qUAMcfNtFjL8M2Pw7x5OPN39emPxkKEIfNuZGT+wg2VVbhBEoSQKLosJUrfM0+ynsRbHVJjifDTiw21KfLgonLq+LGyGlLmOztd8/84ORoaNnb66Hyl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4370.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xTTeCOeCo7f8M6ugVwM1XoiwiZymkfOLWeSbe0m7brAGYwcKpfE2RJuPdi6Y?=
 =?us-ascii?Q?lVdXSKDZQCoofV0YLVIX25q0ew6pp0F66Al+VFUQ3Tdh2HgjxXxSpA5wBEOv?=
 =?us-ascii?Q?0acx6aM92wDAeBH9UGv2IKRqMMPMt6S4Zyht9jx2tUz9MA7Gu6Tbod2ssQu6?=
 =?us-ascii?Q?19WfS79vYR5QkXlO94mao+9yxvhZ2MDx36QgF+k59EIN049UCZq7S16Kxu90?=
 =?us-ascii?Q?FRtbGEeCJ/vE00wTwjEhlih8j/NmTguo7kueutXqo0ePCZuRN9qgYSzxEKUh?=
 =?us-ascii?Q?OB+YV07KZQHXVJSgIxicKFO4v3td2gQjUIH8Hg56TBlSBBFFE/5J88mgnKgL?=
 =?us-ascii?Q?XeO/TpzDCWMStBwg4aCBantlReS2Ub4awallToyK8oAr3LlFoKD0ZJ83LKgZ?=
 =?us-ascii?Q?nKh+vzSeLtWKH4gRmnj7n9MTLS4bqQG4I3aEvvRTuOyAO/CyyYB3aJhV7z+U?=
 =?us-ascii?Q?ZxIPltoMa6IZUMhu69NH+291z36eidbRqNozxgUdrfuLEbnNG2wsu5UGO763?=
 =?us-ascii?Q?DxxTR6a943Zpj1K/Va6L0GJhK3P9yNHlnoNjAMgVZrIqQ03UkXSjWv1YF9P0?=
 =?us-ascii?Q?NSn4ev0+t5x+7mKvmMIrKQ6fYJtMf8sm/f30QtQuZ5KBgtZzy2Tsz2A8lUxR?=
 =?us-ascii?Q?X/YfbdWqwBHmkNYSsaasYtAsqoigxJv+02+r0Uuoz+BqOknhooWQIIIVWH0m?=
 =?us-ascii?Q?thBX553dsV5boiRXEDm7FNkkkKbCg9l3oWAvxR8TPiv0oZH+GOQyRlEl4ZfD?=
 =?us-ascii?Q?BIz7jSpYZYLhY8I8QxmzYYLiGBNzrzyKrNRw/6gFyhTLfecyifNTOWB8Vimb?=
 =?us-ascii?Q?ToakMMeftli5ROda+zH1OiNCWvRyjwD8LoXoGKe3bSjUuu7GAMufGSxLSGAQ?=
 =?us-ascii?Q?fKKI8lyUbF3Z6vN6oHgoNtNAKQXYt3XdCJuQPfEk4QwCSOXgc/WIDBu4Oo+u?=
 =?us-ascii?Q?1DNSeIpChZw2cqbn9wQ1adkITZQuaMpwU2yzXpafVqOkld8jztzhHPUeTBXv?=
 =?us-ascii?Q?1jrTXI0UQKLu4PZbV6KDr8BUFV1PWF5/hbeQ+l4AdtMorPrIru1OPnDWJJyL?=
 =?us-ascii?Q?DmR9+bBrGmAy1vj65V4u4iwZgOvbpvjnT/oju3y1Wum6KpU33HNAD4nB3xYM?=
 =?us-ascii?Q?vzzOa4ZER2uf6JwRficpvjsBwEyxv367BytDbUn/VcrRD9VQSMv/1j0DxQue?=
 =?us-ascii?Q?hxflYjstd4xu2HB02AB9gsibB77gaBua65Of4u7VbQ2q3VSNL5DiNkIzaH3d?=
 =?us-ascii?Q?mYHlzw7U2xHDrfrdAOQhnJFbAQczKKqUFF+8mj1T1pR3M4zUgTD94Gm0eN2t?=
 =?us-ascii?Q?rlEFHTAjm15GYetWr2zZG1Elu80NqI/xK/y3+6gazsbYFt+7iMmELLXOATU7?=
 =?us-ascii?Q?IQiydWUde8s9njyyQJxSF5FE7DVAMyb6p18gdVHpp5AEGDp4re1Vix/nsFvW?=
 =?us-ascii?Q?8cI3eq2uxwh8yvvhJIXIqcl8TUVMJ76hftReWq9ek/p5xlpKEyk1NxuMj+P9?=
 =?us-ascii?Q?byn8Uq7nNieQDWmsHT4XjPm1UbBniLThQACEBlrUVxtiPMFnNjMtzsg4H8Yu?=
 =?us-ascii?Q?mfHMx7uTJyWorbBcgB1ne1Z+vBN9fYte9FT2RLV4TGTc7Ej4hg0PNWjJ+ydN?=
 =?us-ascii?Q?fLD1XUNL58q824VfsyoCZZN7VCrxO8adO3d+eNSF7pwOwlspA3lYaBgJxaWE?=
 =?us-ascii?Q?e10CL3pmsA7a7osZ/7ZGQx7rbjSdpzSUePg+frTmeSNDOJpUfggtgby0GNXJ?=
 =?us-ascii?Q?GWPTASlF9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4370.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db59018-bb18-4028-9f4c-08de99e60c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 05:24:05.5345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXZSyJjPGpHsfvAhPF7ya/q9rl2toiTScpBTyRnq1kqmRkBCM1sVLwX1W2D/PZzyLLzTnsjushDGYFsP+O4pgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7410
Received-SPF: permerror client-ip=2a01:111:f403:c201::6;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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



> -----Original Message-----
> From: Gaurav Sharma
> Sent: 14 April 2026 10:47
> To: Bernhard Beschow <shentey@gmail.com>; qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> Subject: RE: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
> i.MX8MM EVK board
>=20
>=20
> > -----Original Message-----
> > From: Bernhard Beschow <shentey@gmail.com>
> > Sent: 14 April 2026 02:20
> > To: Gaurav Sharma <gaurav.sharma_7@nxp.com>; qemu-
> devel@nongnu.org
> > Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> > Subject: RE: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support
> > for i.MX8MM EVK board
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using
> > the 'Report this email' button
> >
> >
> > Am 13. April 2026 19:54:29 UTC schrieb Gaurav Sharma
> > <gaurav.sharma_7@nxp.com>:
> > >@'Bernhard Beschow', after I rebased to master and build the changes,
> > >so far I have observed build errors like:-
> > >
> > >1. 2 of those attributed to qdev-properties.h header file moved from
> > >hw/ to hw/core/ 2. 2 errors attributed to boards.h header file moved
> > >from hw/ to hw/core/ 3. One attributed to smmu :-
> > >
> > >In file included from ../hw/arm/smmuv3.c:37:
> > >../hw/arm/smmuv3-accel.h:17:10: error: #include expects "FILENAME" or
> > <FILENAME>
> > >   17 | #include CONFIG_DEVICES
> > >      |          ^~~~~~~~~~~~~~
> > >../hw/arm/smmuv3-accel.h:44:8: error: attempt to use poisoned
> > "CONFIG_ARM_SMMUV3_ACCEL"
> > >   44 | #ifdef CONFIG_ARM_SMMUV3_ACCEL
> > >      |        ^
> > >../hw/arm/smmuv3.c: In function 'smmu_validate_property':
> > >../hw/arm/smmuv3.c:1968:9: error: attempt to use poisoned
> > "CONFIG_ARM_SMMUV3_ACCEL"
> > > 1968 | #ifndef CONFIG_ARM_SMMUV3_ACCEL
> > >      |         ^
> > >
> > >Build command used:-
> > >
> > >../configure --target-list=3Daarch64-softmmu make -j$(nproc)
> > >
> > >are these expected ?
> >
> > Certainly not, since we're close to a release. The only advice I can
> > give for now is to double check against imx8mp...
> >
>=20
> Got it. Build is fine with the changes now. Sending in the v6 shortly.
>=20
Correction - I would be resending as v5

> > >
> > >
> > >
> > >> -----Original Message-----
> > >> From: Gaurav Sharma
> > >> Sent: 14 April 2026 00:30
> > >> To: 'Bernhard Beschow' <shentey@gmail.com>; qemu-
> devel@nongnu.org
> > >> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> > >> Subject: RE: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support
> > >> for i.MX8MM EVK board
> > >>
> > >>
> > >>
> > >> > -----Original Message-----
> > >> > From: Bernhard Beschow <shentey@gmail.com>
> > >> > Sent: 13 April 2026 19:01
> > >> > To: qemu-devel@nongnu.org; Gaurav Sharma
> > >> <gaurav.sharma_7@nxp.com>
> > >> > Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> > >> > Subject: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support
> > >> > for i.MX8MM EVK board
> > >> >
> > >> > Caution: This is an external email. Please take care when
> > >> > clicking links or opening attachments. When in doubt, report the
> > >> > message using the 'Report this email' button
> > >> >
> > >> >
> > >> > Am 13. April 2026 07:37:22 UTC schrieb Gaurav Sharma
> > >> > <gaurav.sharma_7@nxp.com>:
> > >> >
> > >> > Hi Gurav,
> > >> >
> > >> > >Changes in v5:
> > >> > >- Fixed SoC object reference counting by using
> > >> > >object_new_with_props()
> > >> > >  instead of object_new() + object_property_add_child()
> > >> > >- Merged imx8mm-evk.rst documentation into imx8mp-evk.rst to
> > >> > >avoid
> > >> > >  duplication and updated the title accordingly
> > >> > >- Added on-chip RAM (OCRAM) support to match iMX8MP dev
> > >> >
> > >> > I tried to apply v5 but I'm hitting the same issues as Patchew:
> > >> > <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%
> > >> > 2F
> > >> >
> >
> pat%2F&data=3D05%7C02%7Cgaurav.sharma_7%40nxp.com%7Caa935d96ff2e4
> > 05ac
> > >> >
> >
> 8cd08de999e31c1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> > 9117
> > >> >
> >
> 101899885925%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydW
> > UsIlYiOi
> > >> >
> >
> IwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C
> > 0%
> > >> >
> >
> 7C%7C%7C&sdata=3DJAaw56sBFbwFFHt4bHO1Zt51fDkADIqVN7kPV9Tkt%2BI%3
> > D&res
> > >> > erved=3D0
> > >> > ch
> > >> > ew.org%2FQEMU%2F20260413073737.986219-1-
> > >> >
> > >>
> >
> gaurav.sharma._5F7%40nxp.com%2F&data=3D05%7C02%7Cgaurav.sharma_7%4
> > >> >
> > >>
> >
> 0nxp.com%7Cfbdcd381f0014ebd086a08de9960ed16%7C686ea1d3bc2b4c6fa
> > >> >
> > >>
> >
> 92cd99c5c301635%7C0%7C0%7C639116838724991885%7CUnknown%7CTWF
> > >> >
> > >>
> >
> pbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> > >> >
> > >>
> >
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DnyynvYO
> > >> > v87nTkxEFkU8k3eSt4r%2Fa17rQkr9STABgaaA%3D&reserved=3D0> Mind
> > >> resending a
> > >> > version rebased onto master?
> > >> >
> > >> > Moreover, you may keep my R-b tags which I've given during v4.
> > >> >
> > >> > Best regards,
> > >> > Bernhard
> > >> >
> > >>
> > >> Hey Bernhard,
> > >> yes, looks like I need to rebase and create patches again. Lemme do
> > >> that and send over as v6.
> > >>
> > >> > >
> > >> > >Changes in v4:
> > >> > >- Update Maintainers file
> > >> > >- Re-used iMX8MP CCM and Analog IP for iMX8MM by introducing a
> > >> > >variant
> > >> > >  specific property
> > >> > >- Split up the patch that enabled CCM and Analog in the previous
> > >> > >  revision. Now we have 3 patches to enable CCM and Analog in
> > >> > >iMX8MM
> > >> > >- Updated copyrights
> > >> > >- Removed '|| KVM' from hw/arm/Kconfig to prevent 'make check'
> > >> > >failures
> > >> > >
> > >> > >Changes in v3:
> > >> > >- Minor documentation change - Added KVM Acceleration section in
> > >> > >docs/system/arm/imx8mm-evk.rst
> > >> > >
> > >> > >Changes in v2:
> > >> > >- Fixed the DTB offset in functional testing script
> > >> > >test_imx8mm_evk.py
> > >> > >  and preserved alphabetical order of machine names in
> > >> > >tests/functional/aarch64/meson.build
> > >> > >- Fixed a typo and updated the documentation
> > >> > >- Modified structures type to static const in fsl-imx8mm.c
> > >> > >wherever
> > >> > >  applicable.
> > >> > >- Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-
> > evk.c.
> > >> > >This
> > >> > >  is needed because the default DTB in the iMX LF BSP images
> > >> > >have CSI
> > >> > >  and DSI enabled. Developers/Hobbyists using these BSP images
> > >> > >will
> > >> > >  observe CSI and DSI crash logs on the console since these are
> > >> > unimplemented.
> > >> > >  With this change, both debian and iMX LF images will boot up
> > >> > > without any
> > >> > issues.
> > >> > >
> > >> > >Changes in v1:
> > >> > >
> > >> > >This patch series adds support for the NXP i.MX8MM EVK
> > >> > >(Evaluation
> > >> > >Kit) board to QEMU, enabling emulation of this ARM Cortex-A53
> > >> > >based development platform.
> > >> > >
> > >> > >The series includes:
> > >> > >
> > >> > >1. Core peripheral support (CCM clock controller, Analog module) =
2.
> > >> > >GPT(General Purpose Timer) and WDT(Watchdog Timer) Emulation
> > >> support
> > >> > 3.
> > >> > >GPIO,I2C,SPI,USDHC and USB Emulation support 4. PCIe and ENET
> > >> > >Controller Emulation support 5. Documentation and functional
> > >> > >test included
> > >> > >
> > >> > >Key features ported:
> > >> > >- Basic boot support with Linux
> > >> > >- UART console for serial communication
> > >> > >- Interrupt handling
> > >> > >- Clock and power management infrastructure
> > >> > >
> > >> > >Testing:
> > >> > >- Linux kernel boots to console
> > >> > >
> > >> > >Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > >> > >
> > >> > >Gaurav Sharma (15):
> > >> > >  hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
> > >> > >  hw/misc/imx8mp_analog: Add property to analog device
> > >> > >  hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
> > >> > >  hw/arm/fsl-imx8mm: Add Clock Control Module IP to iMX8MM
> > >> > >  hw/arm/fsl-imx8mm: Implemented support for SNVS
> > >> > >  hw/arm/fsl-imx8mm: Adding support for USDHC storage
> > >> > >controllers
> > >> > >  hw/arm/fsl-imx8mm: Add PCIe support
> > >> > >  hw/arm/fsl-imx8mm: Add GPIO controllers
> > >> > >  hw/arm/fsl-imx8mm: Adding support for I2C emulation
> > >> > >  hw/arm/fsl-imx8mm: Adding support for SPI controller
> > >> > >  hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
> > >> > >  hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
> > >> > >  hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
> > >> > >  hw/arm/fsl-imx8mm: Adding support for USB controller
> > >> > >  hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM
> > >> > >emulation
> > >> > >
> > >> > > MAINTAINERS                                 |  10 +
> > >> > > docs/system/arm/imx8mp-evk.rst              |  33 +-
> > >> > > docs/system/target-arm.rst                  |   1 +
> > >> > > hw/arm/Kconfig                              |  24 +
> > >> > > hw/arm/fsl-imx8mm.c                         | 704 ++++++++++++++=
++++++
> > >> > > hw/arm/imx8mm-evk.c                         | 130 ++++
> > >> > > hw/arm/meson.build                          |   2 +
> > >> > > hw/misc/imx8mp_analog.c                     |  12 +-
> > >> > > hw/timer/imx_gpt.c                          |  26 +
> > >> > > include/hw/arm/fsl-imx8mm.h                 | 242 +++++++
> > >> > > include/hw/misc/imx8mp_analog.h             |   3 +
> > >> > > include/hw/timer/imx_gpt.h                  |   2 +
> > >> > > tests/functional/aarch64/meson.build        |   2 +
> > >> > > tests/functional/aarch64/test_imx8mm_evk.py |  67 ++
> > >> > > 14 files changed, 1251 insertions(+), 7 deletions(-) create
> > >> > > mode
> > >> > > 100644 hw/arm/fsl-imx8mm.c create mode 100644
> hw/arm/imx8mm-
> > >> evk.c
> > >> > > create mode 100644 include/hw/arm/fsl-imx8mm.h create mode
> > 100755
> > >> > > tests/functional/aarch64/test_imx8mm_evk.py
> > >> > >

