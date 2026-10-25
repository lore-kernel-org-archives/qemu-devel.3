Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93D606A322
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=UI8RDcj5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsRj-00056F-8o; Sun, 25 Oct 2026 03:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xKsRg-00055k-2Z; Sun, 25 Oct 2026 03:15:08 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xKsRd-0003Bi-Az; Sun, 25 Oct 2026 03:15:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBUnsiM0TEni9hkQ2Zp6xT2kZ0VEP0H0snU6XFuy8fvS9b4le8YnCVeZMRpLPO8xeZGcyXX/txUghl6kdSxuSf9Lw1KrFHRk5+/LvdGKv2vIt1Vbc6fexYL59tLMyaPXx5iGjNqXJWBhXcBEmPfAYPurt0FPaIpOllwOjIeCWiPDSLtVYA0/RUu65d2/OfjYgrYEvSZepndBRuMwamVaCkhA7kdCS5QOyylF9jSlz9kBJiFejbE1ylAXuUVK6JBupyrQyXkx+6EJHULOE59XurhzPYBdO+zjJ/reRzRzEg+3ZC8wRopVlsVCpMfTjcMsEocsnO2F9CjHbqCBnxBftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWhHTMMxv9BIk+R1Fv2rCr5gvM7Pp6onSKTOLQXcH2w=;
 b=e/QKQKXvj60rlkEmrm5vgpnVnymM/BFs3wIaEG4GuoQXRT0xHJgAeWFqLDWMhdjfMn8peuRLKy0kmGXlbUze4O+0mLjMj5RjnsY9MeA8FhmHi5KLyKDgbDJGBeJa3896QALBQhaZxibOJK8/R35RkofzrQOyyLnjsCpvhkQyuFhBzQIk3qjnmFWepQM6t470479yGIKzr5WLsye1a3SzUhkZVvNPsxjZ+BjKIlfVzTcJWJ3+c5NRuv7aAml1Jc4ThO+pC/AMa4q18Lxc/irgAlvBgThVZq3GAUZXIKuuwna7m5JQIdocXQs/pDDKI+FRhdrGp6QzZGNSbwDWv0vlig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWhHTMMxv9BIk+R1Fv2rCr5gvM7Pp6onSKTOLQXcH2w=;
 b=UI8RDcj5w1cR1YJlvKLB2IBPOY8THC2dNGf8flde715q4YuzXBcbVYNOqCfOEmtzoJKqPujt0C43nXOv5jfCKLXaFZYlXcr913B1ozAGXM4pWnnZMEaRMV/Zfl54ppsr9xgV67rsiem+wIImoReTQZWxlQV5iTIIZO2czCNASK9ESLsO0pcHBkuOkJkps8f1w2v51heu5EXAwv0CvJIHwdquyVOM3Dch65gYd9MBhWIx1jnpn8zs700828ypHu1G8yZXV77t9RiQbYC6cofGGwgQ7PzjuioCCYiXNeBk/O7bM73yq17l2/0yzTvZkbwdpUUObZjBmExCOk4rDgbAkg==
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23)
 by GV1PR04MB10968.eurprd04.prod.outlook.com (2603:10a6:150:20c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 07:14:57 +0000
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2]) by DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2%4]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 07:14:56 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: QEMU <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: [RFC] target/arm: Correct MPIDR.MT handling for i.MX95 Cortex-A55
 Aff1 topology
Thread-Topic: [RFC] target/arm: Correct MPIDR.MT handling for i.MX95
 Cortex-A55 Aff1 topology
Thread-Index: Ad1kUFII4MKnDgaKRE22YiQ/acy/Sw==
Date: Sun, 25 Oct 2026 07:14:56 +0000
Message-ID: <DB8PR04MB7177C8ED1A20409414A573EF87622@DB8PR04MB7177.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Enabled=True;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SetDate=2026-10-25T07:02:45.0000000Z;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Name=NXP
 Public; MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_ContentBits=3;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR04MB7177:EE_|GV1PR04MB10968:EE_
x-ms-office365-filtering-correlation-id: 8663f9b2-e4fc-4b66-71e2-08df3267ac9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|1800799024|376014|261022115727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|10067099003|56012099006|6133799003|18002099003|11063799006|5023799004|38070700021;
x-microsoft-antispam-message-info: uwuf7I4zNPzjXf64kjne0MxIrE2CG/P/sAityPLPfMAysbOHpyz5Tpuau2QyogN36OWkFPsokiTxsI6sg/1ofAehbKdyGJa0DvSWewE4n4A4JMPU+TFjOVE76PGFIVhfJG3m2vxTwQ0SrkwRNo00Ka8ycwq77koFUJPRczhCtg34MEKGxqK70YmiQW/VL6Uomritix13Q94OsyBEEkoHtunbvIM6+1NQjpdQh/caFEyqHjvCYn85N1mL58u6xifbj8bKwt65WRB6u8gFJSFBmvXvJfFfLp4cxqeubbzhldpwS+ieuxOLAaxiw6g0BerqRjYsCGTNyW4Xk3cg8FQXiA/XvIMT9ZOUyl00ViDp3hvqXuoxiR1MZ4niM2q6e0hXSF6Ly6EY2H1bxSMm6fMTsHLXS+IfVT2q/PspH4BtoYKtkqupnR3v6xe7yK0bUUMhOzxIaO+66CWLPp4S0dHUNHD0S7UjG/T4TnDmUw9UrWt9VuIyurrgaHuURrADpTAZU7+FwJLOAm8p0i5rRlQokxmKK4rVmXAv4OwfDnoifaRsXKFaywKCGTDx/3MLMlwLGKFS9o8h4xmynb6+vVmPA88BCFpD3j8Fk6G+II6h/b8CHJjPmPZbWvv16Rk7XdOb48eks9Y7F4souzDeNbeNJv5Cu5zEVfUoXJzrGPYuIQPlvo4S1e00RAFMkBAwpYsVWEQcZtzZPufOCk5klNH/mBWTzq7EmC7JHVOq7xwRB20=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB7177.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(261022115727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(6133799003)(18002099003)(11063799006)(5023799004)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Xluj+EsoxZftS/MhPIAjuc6uVMZAaJChZ2hg9awYZetlnaP98lH9r2LrdPC?=
 =?us-ascii?Q?x17N6rdjO54ZRAlpGUpEFicTp72xwNIuSwVcyQqnXjfr/FyMoOimE6XhW6+b?=
 =?us-ascii?Q?C57LSnzzRLL8eSCs9WizIOW1fOt4IJCrnZfu+V1pfSkPPVh1wa0NSBAIgirm?=
 =?us-ascii?Q?FcngXjjqesIEcnBwwH/h6+kfpn3QDGBc5KDLrIIQ331CuMysVCFtuRmAxBo/?=
 =?us-ascii?Q?Xk3tVNMo43NZt+mum2Cv7evGfAvMUnr7kFKRyX9ZWxEfQwYx7Obl6SajDXV3?=
 =?us-ascii?Q?ba9k9OOGBxnH8xDbbGwuReZqGpP7xQd4/yXfs4OF3bGym+mTEAVWErsQecxl?=
 =?us-ascii?Q?TQ0A+ULqsOv5Q5ac8pVBDALLYtzwmlHgpuBDHsBvpDaq6ReYYLO46lL40caP?=
 =?us-ascii?Q?fLSDufIipH5TdR7sy2Rj1XTBHLGjIhMIkzCSJF8D6ueBSo1+B3s1YvAl7DvQ?=
 =?us-ascii?Q?WKUBtZEq8U9G5Lh7zVw5GQMYG8YWJWOlvozsxFlyWR42hVguRgxzRZSNBRYb?=
 =?us-ascii?Q?pCUkeFVpUILMRRbBluKDDT2XJIdwsQj/EawBvfI8Vx1AMkRxuQ5u+pkJvCdm?=
 =?us-ascii?Q?dxfGo1wuaPoYgUszRJo0ZrgznUc/CUVDP6CiWA7XCy446COpcQviKvP5yY4o?=
 =?us-ascii?Q?DhDlBMaPHqAk6Igqh4nsgYl8rpBZf6Bqc5/9DNjwkdhgeSmzXauQcLL45zVu?=
 =?us-ascii?Q?0il7E8EsCpexVXsRrYp6pmIeYsei/6NP7WFG1iC1dsOPfGAitqbuCWlHaxoV?=
 =?us-ascii?Q?oxTieLtG08y/7NEDVmXQWVBDRnoatCKMBkJl3pwz3AKLnGAchMB0hq8vtj+/?=
 =?us-ascii?Q?ulAT3+WYVPoWAWCh1aLFUMGJNUhHcflXiNeuKfI5KQ/M44wXQAqEzQkdbBCf?=
 =?us-ascii?Q?QXBePFuYOz/SsJzR4QGyOLS2G45WZUInb4qVwt2JGq9NFNI7DykaSLbY9YlW?=
 =?us-ascii?Q?OFQ6EKjP+GPTpN/eEmWg8DvRraB+rhiGkpeqQlzX6v43KktxttrpG0PfYWhZ?=
 =?us-ascii?Q?tQ1XgTzUCRlcozEaucXmFIRKmOPLYpZfvpJx+v5v98vc1sKAZDhgqBPOvTwK?=
 =?us-ascii?Q?5l6e/XZTN7wMxlDqf8t156kZAlPNYqfUpUTh627e93lqvO3uRUrYdxltN147?=
 =?us-ascii?Q?ZB87WRu9M9RNW5IJ7cmcI07buuuPTWlyeR3r7NSRJUs5HZtEoCHvSAbBj/7S?=
 =?us-ascii?Q?a60TjD+WOalAwE/HOcAR2G52/dXLoptbLHNl/OUcCin9iMDmU+/DTcQkJ5kE?=
 =?us-ascii?Q?Nh3zaoy36kgXgvdJuuQQAqC3PilNinu1wSHZDSBzZezL/iY1meJiMWMj7cPs?=
 =?us-ascii?Q?dBx9lU1MowQAnOIzrGTQJK/y5F6gY9I9IfAA1WRxp95WvtvdODJlRa4s2QTs?=
 =?us-ascii?Q?17v00TaCan6hy3f6JbWZsu8ZxSKMa9SeRrqUOuIkFa20/F813agLIT8KQKV/?=
 =?us-ascii?Q?QKtVfmpJgbZ8sJM7Aid8+yi3tLzMr0DpicnX4Wo5u8rnSWxqlVOmtOS1bRkw?=
 =?us-ascii?Q?K4zn36TicD1MQA8njMWeTwBMlGIVWOiUiOPWm7qyf+31Uo7314GYXNMIoIe8?=
 =?us-ascii?Q?2P/fd9svr9iS/0Bk6xb10EVt/lpiJtnQOM7kb4jtSesWRB/2eywqxkmG98k0?=
 =?us-ascii?Q?67nWlt0Yhc3wjwkaBThrwIQHL3d/tMUeoaq3EX9QR2JCIwGAiIPVv3UThGh3?=
 =?us-ascii?Q?d2mCyGbHWEP6U6JbCnJ1a5uVGkwbh3+oXI7btQXVCBcLH6EX7/JTFxOStbks?=
 =?us-ascii?Q?J7cLS7X6LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8663f9b2-e4fc-4b66-71e2-08df3267ac9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2026 07:14:56.7924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKtu1Xu9HchEAR/6X7YuPN3Gbz0kBoAgOZ6oVSj6RuypvaNFJ4r+uHV9kavtbB/uLOFOcoynyokEaavbd4HgIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10968
Received-SPF: permerror client-ip=2a01:111:f403:c20a::7;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,

I am looking for guidance on the appropriate scope for correcting Cortex-A5=
5 MPIDR topology in QEMU.
I have enabled and tested i.MX95 machine model that boots the complete NXP =
firmware/software stack from the emulated boot ROM:

  Boot ROM
    -> System Manager firmware (SCP) running on Cortex-M33
    -> A55 SPL
    -> TF-A / BL31
    -> U-Boot
    -> Linux

For testing, I am using the Yocto-generated WIC image from NXP's official i=
.MX95 Yocto BSP as the emulated SD-card image.
i.MX95 represents its Cortex-A55 CPUs using Aff1 as the core identifier, wi=
th Aff0 fixed at zero.

Current QEMU returns these Aff1-based affinity values through MPIDR_EL1 wit=
h MT clear. It is not sufficient for the i.MX95
firmware and Linux secondary-CPU startup path.

With MPIDR_EL1.MT clear:

  - The complete ROM-to-Linux boot chain reaches Linux.
  - Linux begins bringing up its secondary CPUs.
  - CPU1 reaches Linux secondary initialization.
  - CPU2 through CPU4 time out and fail to come online.

With MPIDR_EL1.MT set while retaining the same Aff1 affinity values, the sa=
me complete boot chain succeeds and all secondary CPUs presented
to Linux come online.

I found QEMU issue #1608 and the previous qemu-devel discussion about Corte=
x-A55 using MT=3D1 with the core index in Aff1. The discussion suggests
that this should eventually be a generic CPU-model correction.

If there is already a planned patch for resolving this, I would prefer to a=
lign the i.MX95 work with it.

Otherwise, would a generic 'mpidr_core_in_aff1' like property, initially us=
ed by the i.MX95 machine and later extended to the other affected CPU
models, be a reasonable direction?

I plan to start posting the i.MX95 machine-model patch series soon, and wou=
ld like to align the CPU-topology changes in that series with the
preferred solution for this MPIDR behaviour.


Thanks,
Gaurav Sharma

NXP Public

