Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0103C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 17:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnKp4-00018M-Db; Wed, 26 Feb 2025 12:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tnKp2-00017y-JP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:03:48 -0500
Received: from mail-vi1eur05on2071e.outbound.protection.outlook.com
 ([2a01:111:f403:2613::71e]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tnKox-0005r6-OX
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:03:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQSsSUcLWhFCqlb1mweEomT86f5XNE4M9b26RXO0JrAnynF/PTTCFNcfcR9AttZHcBm5HwZCetCUJUeO4pKxeeBP6DKyHoGc4qouHPAe9R4GmRe0MHZSvIloleS0tWtpVXNqY6eo3dCC93On2nsNSL/VzDW7Tknu6FJgLyVBcLyIax1Hd3eJxwVFUAQXHO+O638uhvLGWT//XgZKVMOcwm3cvQDS+0MO64gmsAUuyQ53geDY8zm9dSUYlhHW/0OON1isYR0meRkeeJGi1PKnR3/V2TMHD0UY2eBh3RtSHPe5bkLo5bk+jsYFvsdJna3c8B9t/Xt3JLNertytRDisFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GfvWu2mmzqzttf1FFSsG9yvPo2ojKw+5mftz+ydN1I=;
 b=XNAzE/dfB2Bi/WkRz7JAluPnE1I7oQU949iHlEGFagnSSeC/EOD3iXEJfuzCfP1yy5n3ZZ2mCNwKSbNNFnRY8W+0QYPlgfiWM8rEB9EMKmGpsqw4GHaIuLdaFovo37yxiuniIjDyNKqs5RcaV9kHd73eq2aJSSbY2iK5bcIxjQF+HAjX3ySnfLZGrzF2L/fvvK5zfvd1qxnfNd0gCvkyIp+JPy/KldF9hvimukSBU3SLtS/6Gwm52U8ZtKRuaQDRhq74DlnfR2/hy5FceOcFv17INP3AiLpJ2BK+luScWXI1xQCVKVuOKwC7Y35sQtcE+eaXuxS0nXC6VXfs4ag/DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GfvWu2mmzqzttf1FFSsG9yvPo2ojKw+5mftz+ydN1I=;
 b=m5d7RRcFf7ulZxWPl3gtid7i8IVqRZY2KQysfNFPFzQWUjYt2utGTaRYrOZ6JPvlqTCl0JiWbwYHN391gni52EF5zrII2ptHksG0LY2jGXpEkvM2mjYumP8CgUY09noKlhhCDyQ1epW4KshCA1jx3vDAs231/2XKcG2xmmGXT0w4MICwR3M2dBJqxgxr0GYx3HaFDb9EV5luSRwHgOZxTtF/GFVlB35s/QIDP+BdWIX70RP5SWHk2SOzLdN3s9/ZwkzKMU+OzkcvuYO5XlZnE+Y+RgwRoUsrE4futHtS8l3ELS0xn15o8CPY6Hj0hybWk2xiL8LCMrzLmlqC7K5vxQ==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by VI0PR09MB7419.eurprd09.prod.outlook.com (2603:10a6:800:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 26 Feb
 2025 17:03:04 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 17:03:04 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Aleksandar Rakic
 <aleksandar.rakic@htecgroup.com>, Yongbok Kim <yongbok.kim@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Subject: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Index: AQHbiHBMKhjxNs/1dk+vCUF69yvpRg==
Date: Wed, 26 Feb 2025 17:03:04 +0000
Message-ID: <20250226170246.1971355-3-aleksandar.rakic@htecgroup.com>
References: <20250226170246.1971355-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250226170246.1971355-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|VI0PR09MB7419:EE_
x-ms-office365-filtering-correlation-id: 3b7446a8-3b9f-4f79-39f6-08dd56876f2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AHFFbcdMcq3QK+78Jv0j20kfF9S8ryV9l0V6YMIAPHIzB12u3cplwAAwBB?=
 =?iso-8859-1?Q?xegaKlGXBvAw/diUUlrv3k/lLukit/zU3W+V1Jf7yz3RxqU6JjzjLTmBzg?=
 =?iso-8859-1?Q?ioEi/H4/WZsceqDcnK6a2C3X1TKxIsprDf1Ga8appiUMwZXRlhxpGifH6u?=
 =?iso-8859-1?Q?HZJgh6gMSTraBK5Ko8JrtvPs+/7Ii997gXIZm91rxRPysnd60TK/cv7Ik3?=
 =?iso-8859-1?Q?7DyLM5Aqo5aKNGfotoJQYxMcQeXbmzxzKRHWviud2NSLNum4BBucN9919y?=
 =?iso-8859-1?Q?mdypdfIijIRvxt+qKJC+gKyags66VDIOKn3qF3TU40v3+AGB9cbegSEp5j?=
 =?iso-8859-1?Q?Kxp6b+MfhA22QjeiDD5xEowoOt7yF8wiDp76EU1pLR1Qp6djy4dFNidbML?=
 =?iso-8859-1?Q?uRRxyW6NQUrwJRh6UtllPCg9pa3t7aXFXterjmpmGmq7r5gfLeJ1YSTxh3?=
 =?iso-8859-1?Q?HiwZiG+9sfqT4Vkfql1WhXE9L8UomH094b33XPEDIQusl7udH1GOTmwsEY?=
 =?iso-8859-1?Q?FPp91QDB67pgHwX60zL1a3/VQM8Ev++5RRl0bBGng79mV0vUqIyIul7ZHQ?=
 =?iso-8859-1?Q?Fpq5DOmUQFccDogkwfCGfTxFlLGrC6hrmXH487gUhteGev6knAhybVjRFu?=
 =?iso-8859-1?Q?LY246qr9Y1yomJTpoZHi1eShBHJU1mHxz4dcxmQNgIMJAUBa3X7f0FqpYP?=
 =?iso-8859-1?Q?pJ+AqrNfw0WwL3n+pY1euZt7DBti0O015uMdoMmW0jxdDERE9eKW0ON1kv?=
 =?iso-8859-1?Q?cHquw+jS43/psy0i/LGC1uEaiKVRcT82Bqnr91YRv9mYShmzUPsBFwWmU2?=
 =?iso-8859-1?Q?w9nabkpusxLChGW2j3PIEQ90Ix5HeMpX00UHHnf1dQiWXE6l9YUSmXOqgV?=
 =?iso-8859-1?Q?9tEKTaZwVPlw2AhhSvZiwXNinflKoKUr4XFTWCRvv+0oCtEUJhO0Wu4B/P?=
 =?iso-8859-1?Q?IYuPex3vWW+CMiiK4CXoqYhlETOvqoT/hzxCqJhRgx6VEgPIVQt+W8z4ix?=
 =?iso-8859-1?Q?06V1up+Fla9qkqoyIHz3DzanGu/erRXcq8opQf2k/yQptRAdcaBu5T1c4x?=
 =?iso-8859-1?Q?mljJ0XP/wmMMctp69ocyBEdOLJ300LhQaDP8mSXg433N5nS5EgO9ZnQ6qt?=
 =?iso-8859-1?Q?IC6kJkPPl6+HzCGN7pRtP5sKUEgjy9slmQKcxnTTKzhSFxNqsWHB4CrAL7?=
 =?iso-8859-1?Q?KGH1y72nm82duTHe5Of7Q3RaGYeBff7xm/OD4nT/L8sPIEuewF17bIGav+?=
 =?iso-8859-1?Q?VmFLCPFShq6m4ZBgvkcXDv7FEtJi43J54OWhOmqGaAFe09LS59j1CEGmMk?=
 =?iso-8859-1?Q?/e+ZzlANQx47HYUOZxj4xcNAZ4Vq7p0EB3/DG0ztgJql/5tmZmazE9nZSi?=
 =?iso-8859-1?Q?lALaOuWdc1R2e4nwga3daVzldLAHVIdL7JH9+hCf3cvoG4Jjpgyq+Il0MW?=
 =?iso-8859-1?Q?bBp36UGACcb/mUQ6jFtVNiKrwBJTOAuUKhzwNw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PiyGQhoZlWTeYYkj9PpkReqeHqtoZ1GOir74W11n2W7S9qryHqgN1SFIM+?=
 =?iso-8859-1?Q?M1KVbSL1WidRB59YovXtfZB2lOKpnHDNNNkMXdad3vPKNg02AZYcKOBPQV?=
 =?iso-8859-1?Q?G479/HaEDu1kxdC3mPM1iWhPN1NA8Fxv3O5TxBICffGu5vZ3JeGKZhfZQL?=
 =?iso-8859-1?Q?HEH/Q3AEW3b43oXhy3PWeCQB6J/j0zxSjxanquGjgcjXCWQZe77PHk1yW/?=
 =?iso-8859-1?Q?Y5RpFxsI+6WvpYeD4nHwiP7A1UkSH5M+QJtlLLAfTroUdRqWxb7qKNvKig?=
 =?iso-8859-1?Q?w7ocvjXZdDbAcrAgkGmfBiznoGX/v2ev8QRYEpaGDtdQidLRsBnmhNgnJ/?=
 =?iso-8859-1?Q?ni52C7M+kXkhGiNuGPonwERg600tV7KtXqhfQNEyA/9QqJif2LVF5Se+AM?=
 =?iso-8859-1?Q?2qd7VOwt390ZvomH0OCbE2WXLPPy0dI5qk/esernNVtNZZVB4lgIixWSwF?=
 =?iso-8859-1?Q?RipBUjvdktt/tZJEpvezXa6rvI7X2UVTRe95ObYoqRk2SRoTirrR3QmP1K?=
 =?iso-8859-1?Q?TXpMpeB0T1CgSeQqUJD3HJWHb1uOx0d0quDcQMoVz76C2KVx6ClaQ00ZhL?=
 =?iso-8859-1?Q?2AnoSoBj5zjpoCHTslsDoQNRvR8K+nOJ/JxVp7dMW5GP7Tn3EOlgFFFnHp?=
 =?iso-8859-1?Q?txPzzmX+ngcGenW5qERTmLVAsfM+ipBklzZ+Z1iOte7U9+RxkQOAsBm+Pr?=
 =?iso-8859-1?Q?5Y1Y+jRGMhJQ+bZl97nVabZ+kyqyrb5rOPaJfhJcXs/Tw87GEmRNq2QAre?=
 =?iso-8859-1?Q?BvUR7WG3kRhcbCmVoSzdGRjMP9QB5sk8jYh6M07NOwefStoi+dd1L3W6q6?=
 =?iso-8859-1?Q?NUF4fnt5a/lNnJHkH2FhB/BLOHZpjpWhPLvzoRozohjYx2I6Ltg5lkLqsL?=
 =?iso-8859-1?Q?OQxlu2Of10IzwwqQ0qPMYtt/9ZIEx1I0TINHqLH6RrbeYD9pzhFI0MzHha?=
 =?iso-8859-1?Q?Jry8qggx0f2v0NDxMT0vDt3r+WaJe8yqe48p4diWhIjgdkmyhuV4Ixd5sA?=
 =?iso-8859-1?Q?ehAkKpQyRvA1UgZ4kh9P6SQ3m2+TfrnXsv4o5R9iH2fmK46uNa1va9cB7r?=
 =?iso-8859-1?Q?tmQqjFlkQGOSF/AxEasfXyv1bJMzgT26cNlrmcxGEQ3gllQBOpmeefbxWt?=
 =?iso-8859-1?Q?Olii0yZJPTZmDMsW6UC2cUgfFxOk61St1fKV4JL8rOSNfrmcP/v8K+uFyU?=
 =?iso-8859-1?Q?55bs085rE0aigVA6dImeXCiL9GZugXqwmd52qRfuf1wzIOJ/Dw9AQgJ7aK?=
 =?iso-8859-1?Q?NxEF+aW2k9sJuOPKa5vvsM2o+nvds7Togw/qkYor4R6lsDOB9cip/b/Gl4?=
 =?iso-8859-1?Q?bwSa5lAfzHnvom01Y88j7ARhIFYwvLwInmQH/rUQMPY93hWqPkYFkovltW?=
 =?iso-8859-1?Q?HBXCyxGzUTz66mfKSquXv8kXJPNu7+eI66e3i7Z+eCUsEx75WE49mv9Jsu?=
 =?iso-8859-1?Q?iaWi09Y2wiHwkSLtvozFtWTI+d7Z3d2NyR6znFyju6YtodaAvy/YMxCONY?=
 =?iso-8859-1?Q?FAMcwMg2lvQ/YP357oXlv5ZyCq+/UKa7bn3Y6Z4rFbtx90yKGXDJbod3yj?=
 =?iso-8859-1?Q?90JDPQMcMFDwvMs2JTBipLKcZNw8sMvaV20fz0WTP4DFRnL8ELL7J/Z8T1?=
 =?iso-8859-1?Q?dTWbJt8qdkClmwXX229Bn3mSX+bTlnij/smaGd7iWaCg9TZjmobFg3/KZ7?=
 =?iso-8859-1?Q?sBmewaa510mvPvKVeHY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7446a8-3b9f-4f79-39f6-08dd56876f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:03:04.1824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MczGUn70FXzAWC7JyWRqQcYo8v5ffL53O/gdL6c8ksy/Gbs1JltNvYnsXMbWCkiKBHsGTywbsJQMqZowTyKMMp8IDL0dUlhbqcKqFEm+iqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7419
Received-SPF: pass client-ip=2a01:111:f403:2613::71e;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
Reuse zlib crc32() and Linux crc32c().

Enable CRC for mips64r6.

Cherry-picked 4cc974938aee1588f852590509004e340c072940
from https://github.com/MIPS/gnutools-qemu

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
---
 target/mips/cpu-defs.c.inc                    |  10 +-
 target/mips/helper.h                          |   2 +
 target/mips/meson.build                       |   1 +
 target/mips/tcg/op_helper.c                   |  27 +++
 target/mips/tcg/translate.c                   |  37 +++++
 target/mips/tcg/translate.h                   |   1 +
 tests/tcg/mips/include/wrappers_mips64r6.h    |  35 ++++
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  34 ++++
 .../isa/mips64r6/crc/test_mips64r6_crc32b.c   | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cb.c  | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cd.c  | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32ch.c  | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cw.c  | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32d.c   | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32h.c   | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32w.c   | 154 ++++++++++++++++++
 16 files changed, 1375 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2b.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cb.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cd.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2ch.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cw.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2d.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2h.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2w.c

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 922fc39138..d93b9d341a 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -756,8 +756,9 @@ const mips_def_t mips_defs[] =3D
                        (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_V=
Int),
         .CP0_Config4 =3D MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) =
|
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
-        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP)=
 |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_G=
I),
+        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_CRCP) | (1 << CP0C5_XN=
P) |
+                       (1 << CP0C5_VP) | (1 << CP0C5_LLB) | (1 << CP0C5_MR=
P) |
+                       (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask =3D (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI)=
 |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask =3D 0,
@@ -796,8 +797,9 @@ const mips_def_t mips_defs[] =3D
                        (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_V=
Int),
         .CP0_Config4 =3D MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) =
|
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
-        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP)=
 |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_G=
I),
+        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_CRCP) | (1 << CP0C5_XN=
P) |
+                       (1 << CP0C5_VP) | (1 << CP0C5_LLB) | (1 << CP0C5_MR=
P) |
+                       (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask =3D (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI)=
 |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask =3D 0,
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 0f8462febb..752748d5e6 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -21,6 +21,8 @@ DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 #endif
=20
+DEF_HELPER_3(crc32, tl, tl, tl, i32)
+DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
=20
 /* microMIPS functions */
diff --git a/target/mips/meson.build b/target/mips/meson.build
index a26d1e1f79..d2d686fc0c 100644
--- a/target/mips/meson.build
+++ b/target/mips/meson.build
@@ -7,6 +7,7 @@ mips_ss.add(files(
   'gdbstub.c',
   'msa.c',
 ))
+mips_ss.add(zlib)
=20
 if have_system
   subdir('sysemu')
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 65403f1a87..5fe9cf1360 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -25,6 +25,8 @@
 #include "exec/exec-all.h"
 #include "exec/memop.h"
 #include "fpu_helper.h"
+#include "qemu/crc32c.h"
+#include <zlib.h>
=20
 static inline target_ulong bitswap(target_ulong v)
 {
@@ -143,6 +145,31 @@ target_ulong helper_rotx(target_ulong rs, uint32_t shi=
ft, uint32_t shiftx,
     return (int64_t)(int32_t)(uint32_t)tmp5;
 }
=20
+/* these crc32 functions are based on target/arm/helper-a64.c */
+target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
+{
+    uint8_t buf[8];
+    target_ulong mask =3D ((sz * 8) =3D=3D 64) ?
+                        (target_ulong) -1ULL :
+                        ((1ULL << (sz * 8)) - 1);
+
+    m &=3D mask;
+    stq_le_p(buf, m);
+    return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff);
+}
+
+target_ulong helper_crc32c(target_ulong val, target_ulong m, uint32_t sz)
+{
+    uint8_t buf[8];
+    target_ulong mask =3D ((sz * 8) =3D=3D 64) ?
+                        (target_ulong) -1ULL :
+                        ((1ULL << (sz * 8)) - 1);
+
+    m &=3D mask;
+    stq_le_p(buf, m);
+    return (int32_t) (crc32c(val, buf, sz) ^ 0xffffffff);
+}
+
 void helper_fork(target_ulong arg1, target_ulong arg2)
 {
     /*
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index de7045874d..086bc3871f 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -401,6 +401,7 @@ enum {
     OPC_LWE            =3D 0x2F | OPC_SPECIAL3,
=20
     /* R6 */
+    OPC_CRC32          =3D 0x0F | OPC_SPECIAL3,
     R6_OPC_PREF        =3D 0x35 | OPC_SPECIAL3,
     R6_OPC_CACHE       =3D 0x25 | OPC_SPECIAL3,
     R6_OPC_LL          =3D 0x36 | OPC_SPECIAL3,
@@ -13448,6 +13449,30 @@ static void decode_opc_special2_legacy(CPUMIPSStat=
e *env, DisasContext *ctx)
     }
 }
=20
+static void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz,
+                      int crc32c)
+{
+    TCGv t0;
+    TCGv t1;
+    TCGv_i32 tsz =3D tcg_constant_i32(1 << sz);
+    if (rd =3D=3D 0) {
+        /* Treat as NOP. */
+        return;
+    }
+    t0 =3D tcg_temp_new();
+    t1 =3D tcg_temp_new();
+
+    gen_load_gpr(t0, rt);
+    gen_load_gpr(t1, rs);
+
+    if (crc32c) {
+        gen_helper_crc32c(cpu_gpr[rd], t0, t1, tsz);
+    } else {
+        gen_helper_crc32(cpu_gpr[rd], t0, t1, tsz);
+    }
+
+}
+
 static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
@@ -13462,6 +13487,17 @@ static void decode_opc_special3_r6(CPUMIPSState *e=
nv, DisasContext *ctx)
=20
     op1 =3D MASK_SPECIAL3(ctx->opcode);
     switch (op1) {
+    case OPC_CRC32:
+        if (unlikely(!ctx->crcp) ||
+            unlikely((extract32(ctx->opcode, 6, 2) =3D=3D 3) &&
+                     (!(ctx->hflags & MIPS_HFLAG_64))) ||
+            unlikely((extract32(ctx->opcode, 8, 3) >=3D 2))) {
+            gen_reserved_instruction(ctx);
+        }
+        gen_crc32(ctx, rt, rs, rt,
+                  extract32(ctx->opcode, 6, 2),
+                  extract32(ctx->opcode, 8, 3));
+        break;
     case R6_OPC_PREF:
         if (rt >=3D 24) {
             /* hint codes 24-31 are reserved and signal RI */
@@ -15094,6 +15130,7 @@ static void mips_tr_init_disas_context(DisasContext=
Base *dcbase, CPUState *cs)
     ctx->abs2008 =3D (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
     ctx->mi =3D (env->CP0_Config5 >> CP0C5_MI) & 1;
     ctx->gi =3D (env->CP0_Config5 >> CP0C5_GI) & 3;
+    ctx->crcp =3D (env->CP0_Config5 >> CP0C5_CRCP) & 1;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx =3D MIPS_HFLAG_UM;
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 1bf153d183..64175f2060 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -51,6 +51,7 @@ typedef struct DisasContext {
     bool abs2008;
     bool mi;
     int gi;
+    bool crcp;
 } DisasContext;
=20
 #define DISAS_STOP       DISAS_TARGET_0
diff --git a/tests/tcg/mips/include/wrappers_mips64r6.h b/tests/tcg/mips/in=
clude/wrappers_mips64r6.h
index d1e5edb632..31f8054d5e 100644
--- a/tests/tcg/mips/include/wrappers_mips64r6.h
+++ b/tests/tcg/mips/include/wrappers_mips64r6.h
@@ -23,6 +23,8 @@
 #ifndef WRAPPERS_MIPS64R6_H
 #define WRAPPERS_MIPS64R6_H
=20
+#include <string.h>
+
=20
 #define DO_MIPS64R6__RD__RS(suffix, mnemonic)                          \
 static inline void do_mips64r6_##suffix(const void *input,             \
@@ -80,4 +82,37 @@ DO_MIPS64R6__RD__RS_RT(DMULU, dmulu)
 DO_MIPS64R6__RD__RS_RT(DMUHU, dmuhu)
=20
=20
+#define DO_MIPS64R6__RT__RS_RT(suffix, mnemonic)                       \
+static inline void do_mips64r6_##suffix(const void *input1,            \
+                                        const void *input2,            \
+                                        void *output)                  \
+{                                                                      \
+    if (strncmp(#mnemonic, "crc32", 5) =3D=3D 0)                          =
 \
+        __asm__ volatile (                                             \
+           ".set crc\n\t"                                              \
+        );                                                             \
+                                                                       \
+   __asm__ volatile (                                                  \
+      "ld $t1, 0(%0)\n\t"                                              \
+      "ld $t2, 0(%1)\n\t"                                              \
+      #mnemonic " $t2, $t1, $t2\n\t"                                   \
+      "sd $t2, 0(%2)\n\t"                                              \
+      :                                                                \
+      : "r" (input1), "r" (input2), "r" (output)                       \
+      : "t0", "t1", "t2", "memory"                                     \
+   );                                                                  \
+}
+
+DO_MIPS64R6__RT__RS_RT(CRC32B, crc32b)
+DO_MIPS64R6__RT__RS_RT(CRC32H, crc32h)
+DO_MIPS64R6__RT__RS_RT(CRC32W, crc32w)
+DO_MIPS64R6__RT__RS_RT(CRC32D, crc32d)
+
+DO_MIPS64R6__RT__RS_RT(CRC32CB, crc32cb)
+DO_MIPS64R6__RT__RS_RT(CRC32CH, crc32ch)
+DO_MIPS64R6__RT__RS_RT(CRC32CW, crc32cw)
+DO_MIPS64R6__RT__RS_RT(CRC32CD, crc32cd)
+
+
+
 #endif
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/Makefile b/tests/tcg/mips=
/user/isa/mips64r6/crc/Makefile
new file mode 100644
index 0000000000..85fe5347f8
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
@@ -0,0 +1,34 @@
+ifndef PREFIX
+  $(error "PREFIX not set, please export GNU Toolchain install directory."=
)
+endif
+
+ifndef SYSROOT
+  $(error "SYSROOT not set, please export GNU Toolchain system root direct=
ory.")
+endif
+
+SIM =3D ../../../../../../../build/qemu-mips64
+SIM_FLAGS =3D -L $(SYSROOT)
+
+CC      =3D  $(PREFIX)/bin/mips64-r6-linux-gnu-gcc
+
+TESTCASES  =3D test_mips64r6_crc32b.tst
+TESTCASES +=3D test_mips64r6_crc32h.tst
+TESTCASES +=3D test_mips64r6_crc32w.tst
+TESTCASES +=3D test_mips64r6_crc32d.tst
+TESTCASES +=3D test_mips64r6_crc32cb.tst
+TESTCASES +=3D test_mips64r6_crc32ch.tst
+TESTCASES +=3D test_mips64r6_crc32cw.tst
+TESTCASES +=3D test_mips64r6_crc32cd.tst
+
+all: $(TESTCASES)
+	@for case in $(TESTCASES); do \
+            echo $(SIM) $(SIM_FLAGS) ./$$case; \
+            $(SIM) $(SIM_FLAGS) ./$$case; \
+            echo $(RM) -rf ./$$case; \
+            $(RM) -rf ./$$case; \
+	done
+
+%.tst: %.c
+	$(CC) $< -o $@
+
+
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c b/=
tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
new file mode 100644
index 0000000000..8832d4e274
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
@@ -0,0 +1,154 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32B
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =3D   "CRC32B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x0000000000ffffffULL,                    /*   0  */
+        0x000000002d02ef8dULL,
+        0x000000001bab0fd1ULL,
+        0x0000000036561fa3ULL,
+        0xffffffffbf1caddaULL,
+        0xffffffff92e1bda8ULL,
+        0x00000000278c7949ULL,
+        0x000000000a71693bULL,
+        0x000000002dfd1072ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000036a9e05cULL,
+        0x000000001b54f02eULL,
+        0xffffffff921e4257ULL,
+        0xffffffffbfe35225ULL,
+        0x000000000a8e96c4ULL,
+        0x00000000277386b6ULL,
+        0x000000001bfe5a84ULL,                    /*  16  */
+        0x0000000036034af6ULL,
+        0x0000000000aaaaaaULL,
+        0x000000002d57bad8ULL,
+        0xffffffffa41d08a1ULL,
+        0xffffffff89e018d3ULL,
+        0x000000003c8ddc32ULL,
+        0x000000001170cc40ULL,
+        0x0000000036fcb509ULL,                    /*  24  */
+        0x000000001b01a57bULL,
+        0x000000002da84527ULL,
+        0x0000000000555555ULL,
+        0xffffffff891fe72cULL,
+        0xffffffffa4e2f75eULL,
+        0x00000000118f33bfULL,
+        0x000000003c7223cdULL,
+        0xffffffffbf2f9ee9ULL,                    /*  32  */
+        0xffffffff92d28e9bULL,
+        0xffffffffa47b6ec7ULL,
+        0xffffffff89867eb5ULL,
+        0x0000000000ccccccULL,
+        0x000000002d31dcbeULL,
+        0xffffffff985c185fULL,
+        0xffffffffb5a1082dULL,
+        0xffffffff922d7164ULL,                    /*  40  */
+        0xffffffffbfd06116ULL,
+        0xffffffff8979814aULL,
+        0xffffffffa4849138ULL,
+        0x000000002dce2341ULL,
+        0x0000000000333333ULL,
+        0xffffffffb55ef7d2ULL,
+        0xffffffff98a3e7a0ULL,
+        0x0000000027fdbe55ULL,                    /*  48  */
+        0x000000000a00ae27ULL,
+        0x000000003ca94e7bULL,
+        0x0000000011545e09ULL,
+        0xffffffff981eec70ULL,
+        0xffffffffb5e3fc02ULL,
+        0x00000000008e38e3ULL,
+        0x000000002d732891ULL,
+        0x000000000aff51d8ULL,                    /*  56  */
+        0x00000000270241aaULL,
+        0x0000000011aba1f6ULL,
+        0x000000003c56b184ULL,
+        0xffffffffb51c03fdULL,
+        0xffffffff98e1138fULL,
+        0x000000002d8cd76eULL,
+        0x000000000071c71cULL,
+        0x0000000000286255ULL,                    /*  64  */
+        0x00000000784a5a65ULL,
+        0xffffffff9bdd0d3bULL,
+        0xffffffffe7e61ce5ULL,
+        0x00000000782fabf7ULL,
+        0x00000000004d93c7ULL,
+        0xffffffffe3dac499ULL,
+        0xffffffff9fe1d547ULL,
+        0xffffffff9b4ca0e5ULL,                    /*  72  */
+        0xffffffffe32e98d5ULL,
+        0x0000000000b9cf8bULL,
+        0x000000007c82de55ULL,
+        0xffffffffe7904f52ULL,
+        0xffffffff9ff27762ULL,
+        0x000000007c65203cULL,
+        0x00000000005e31e2ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32B(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32B(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c b=
/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
new file mode 100644
index 0000000000..fe7b2b5b9a
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
@@ -0,0 +1,154 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CB
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =3D   "CRC32CB";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x0000000000ffffffULL,                    /*   0  */
+        0xffffffffad7d5351ULL,
+        0x00000000647e6465ULL,
+        0xffffffffc9fcc8cbULL,
+        0x00000000237f7689ULL,
+        0xffffffff8efdda27ULL,
+        0xffffffff837defedULL,
+        0x000000002eff4343ULL,
+        0xffffffffad82acaeULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0xffffffffc9033734ULL,
+        0x0000000064819b9aULL,
+        0xffffffff8e0225d8ULL,
+        0x0000000023808976ULL,
+        0x000000002e00bcbcULL,
+        0xffffffff83821012ULL,
+        0x00000000642b3130ULL,                    /*  16  */
+        0xffffffffc9a99d9eULL,
+        0x0000000000aaaaaaULL,
+        0xffffffffad280604ULL,
+        0x0000000047abb846ULL,
+        0xffffffffea2914e8ULL,
+        0xffffffffe7a92122ULL,
+        0x000000004a2b8d8cULL,
+        0xffffffffc9566261ULL,                    /*  24  */
+        0x0000000064d4cecfULL,
+        0xffffffffadd7f9fbULL,
+        0x0000000000555555ULL,
+        0xffffffffead6eb17ULL,
+        0x00000000475447b9ULL,
+        0x000000004ad47273ULL,
+        0xffffffffe756deddULL,
+        0x00000000234c45baULL,                    /*  32  */
+        0xffffffff8ecee914ULL,
+        0x0000000047cdde20ULL,
+        0xffffffffea4f728eULL,
+        0x0000000000ccccccULL,
+        0xffffffffad4e6062ULL,
+        0xffffffffa0ce55a8ULL,
+        0x000000000d4cf906ULL,
+        0xffffffff8e3116ebULL,                    /*  40  */
+        0x0000000023b3ba45ULL,
+        0xffffffffeab08d71ULL,
+        0x00000000473221dfULL,
+        0xffffffffadb19f9dULL,
+        0x0000000000333333ULL,
+        0x000000000db306f9ULL,
+        0xffffffffa031aa57ULL,
+        0xffffffff830c28f1ULL,                    /*  48  */
+        0x000000002e8e845fULL,
+        0xffffffffe78db36bULL,
+        0x000000004a0f1fc5ULL,
+        0xffffffffa08ca187ULL,
+        0x000000000d0e0d29ULL,
+        0x00000000008e38e3ULL,
+        0xffffffffad0c944dULL,
+        0x000000002e717ba0ULL,                    /*  56  */
+        0xffffffff83f3d70eULL,
+        0x000000004af0e03aULL,
+        0xffffffffe7724c94ULL,
+        0x000000000df1f2d6ULL,
+        0xffffffffa0735e78ULL,
+        0xffffffffadf36bb2ULL,
+        0x000000000071c71cULL,
+        0x0000000000286255ULL,                    /*  64  */
+        0xffffffffcbefd6b4ULL,
+        0xffffffffc334e94fULL,
+        0xffffffffac268ec5ULL,
+        0xffffffffcb8a2726ULL,
+        0x00000000004d93c7ULL,
+        0x000000000896ac3cULL,
+        0x000000006784cbb6ULL,
+        0xffffffffc3a54491ULL,                    /*  72  */
+        0x000000000862f070ULL,
+        0x0000000000b9cf8bULL,
+        0x000000006faba801ULL,
+        0xffffffffac50dd72ULL,
+        0x0000000067976993ULL,
+        0x000000006f4c5668ULL,
+        0x00000000005e31e2ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CB(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CB(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c b=
/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
new file mode 100644
index 0000000000..53b8b41e7e
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
@@ -0,0 +1,154 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CD
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =3D   "CRC32CD";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0xffffffffb798b438ULL,                    /*   0  */
+        0xffffffffc44ff94dULL,
+        0xffffffff992a70ebULL,
+        0xffffffffeafd3d9eULL,
+        0x000000005152da26ULL,
+        0x0000000022859753ULL,
+        0x0000000015cb6d32ULL,
+        0x00000000661c2047ULL,
+        0x0000000073d74d75ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x000000005d6589a6ULL,
+        0x000000002eb2c4d3ULL,
+        0xffffffff951d236bULL,
+        0xffffffffe6ca6e1eULL,
+        0xffffffffd184947fULL,
+        0xffffffffa253d90aULL,
+        0x0000000008f9ceacULL,                    /*  16  */
+        0x000000007b2e83d9ULL,
+        0x00000000264b0a7fULL,
+        0x00000000559c470aULL,
+        0xffffffffee33a0b2ULL,
+        0xffffffff9de4edc7ULL,
+        0xffffffffaaaa17a6ULL,
+        0xffffffffd97d5ad3ULL,
+        0xffffffffccb637e1ULL,                    /*  24  */
+        0xffffffffbf617a94ULL,
+        0xffffffffe204f332ULL,
+        0xffffffff91d3be47ULL,
+        0x000000002a7c59ffULL,
+        0x0000000059ab148aULL,
+        0x000000006ee5eeebULL,
+        0x000000001d32a39eULL,
+        0x0000000021e3b01bULL,                    /*  32  */
+        0x000000005234fd6eULL,
+        0x000000000f5174c8ULL,
+        0x000000007c8639bdULL,
+        0xffffffffc729de05ULL,
+        0xffffffffb4fe9370ULL,
+        0xffffffff83b06911ULL,
+        0xfffffffff0672464ULL,
+        0xffffffffe5ac4956ULL,                    /*  40  */
+        0xffffffff967b0423ULL,
+        0xffffffffcb1e8d85ULL,
+        0xffffffffb8c9c0f0ULL,
+        0x0000000003662748ULL,
+        0x0000000070b16a3dULL,
+        0x0000000047ff905cULL,
+        0x000000003428dd29ULL,
+        0xffffffffb89d59a6ULL,                    /*  48  */
+        0xffffffffcb4a14d3ULL,
+        0xffffffff962f9d75ULL,
+        0xffffffffe5f8d000ULL,
+        0x000000005e5737b8ULL,
+        0x000000002d807acdULL,
+        0x000000001ace80acULL,
+        0x000000006919cdd9ULL,
+        0x000000007cd2a0ebULL,                    /*  56  */
+        0x000000000f05ed9eULL,
+        0x0000000052606438ULL,
+        0x0000000021b7294dULL,
+        0xffffffff9a18cef5ULL,
+        0xffffffffe9cf8380ULL,
+        0xffffffffde8179e1ULL,
+        0xffffffffad563494ULL,
+        0x000000003a358bb3ULL,                    /*  64  */
+        0xffffffff975446ebULL,
+        0x0000000041d37ad6ULL,
+        0x000000004be84fe1ULL,
+        0xffffffff9671b1b3ULL,
+        0x000000003b107cebULL,
+        0xffffffffed9740d6ULL,
+        0xffffffffe7ac75e1ULL,
+        0xffffffffa1489696ULL,                    /*  72  */
+        0x000000000c295bceULL,
+        0xffffffffdaae67f3ULL,
+        0xffffffffd09552c4ULL,
+        0x0000000042bd7071ULL,
+        0xffffffffefdcbd29ULL,
+        0x00000000395b8114ULL,
+        0x000000003360b423ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CD(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CD(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c b=
/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
new file mode 100644
index 0000000000..0a951c6b4c
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
@@ -0,0 +1,154 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CH
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =3D   "CRC32CH";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x000000000000ffffULL,                    /*   0  */
+        0x000000000e9e77d2ULL,
+        0xfffffffff92eaa4bULL,
+        0xfffffffff7b02266ULL,
+        0x00000000571acc93ULL,
+        0x00000000598444beULL,
+        0xfffffffff1e6ca77ULL,
+        0xffffffffff78425aULL,
+        0x000000000e9e882dULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0xfffffffff7b0dd99ULL,
+        0xfffffffff92e55b4ULL,
+        0x000000005984bb41ULL,
+        0x00000000571a336cULL,
+        0xffffffffff78bda5ULL,
+        0xfffffffff1e63588ULL,
+        0xfffffffff92eff1eULL,                    /*  16  */
+        0xfffffffff7b07733ULL,
+        0x000000000000aaaaULL,
+        0x000000000e9e2287ULL,
+        0xffffffffae34cc72ULL,
+        0xffffffffa0aa445fULL,
+        0x0000000008c8ca96ULL,
+        0x00000000065642bbULL,
+        0xfffffffff7b088ccULL,                    /*  24  */
+        0xfffffffff92e00e1ULL,
+        0x000000000e9edd78ULL,
+        0x0000000000005555ULL,
+        0xffffffffa0aabba0ULL,
+        0xffffffffae34338dULL,
+        0x000000000656bd44ULL,
+        0x0000000008c83569ULL,
+        0x00000000571affa0ULL,                    /*  32  */
+        0x000000005984778dULL,
+        0xffffffffae34aa14ULL,
+        0xffffffffa0aa2239ULL,
+        0x000000000000ccccULL,
+        0x000000000e9e44e1ULL,
+        0xffffffffa6fcca28ULL,
+        0xffffffffa8624205ULL,
+        0x0000000059848872ULL,                    /*  40  */
+        0x00000000571a005fULL,
+        0xffffffffa0aaddc6ULL,
+        0xffffffffae3455ebULL,
+        0x000000000e9ebb1eULL,
+        0x0000000000003333ULL,
+        0xffffffffa862bdfaULL,
+        0xffffffffa6fc35d7ULL,
+        0xfffffffff1e6bbb0ULL,                    /*  48  */
+        0xffffffffff78339dULL,
+        0x0000000008c8ee04ULL,
+        0x0000000006566629ULL,
+        0xffffffffa6fc88dcULL,
+        0xffffffffa86200f1ULL,
+        0x0000000000008e38ULL,
+        0x000000000e9e0615ULL,
+        0xffffffffff78cc62ULL,                    /*  56  */
+        0xfffffffff1e6444fULL,
+        0x00000000065699d6ULL,
+        0x0000000008c811fbULL,
+        0xffffffffa862ff0eULL,
+        0xffffffffa6fc7723ULL,
+        0x000000000e9ef9eaULL,
+        0x00000000000071c7ULL,
+        0x0000000000002862ULL,                    /*  64  */
+        0x000000001190c4cfULL,
+        0x000000007b7fdbbeULL,
+        0xffffffff9204da99ULL,
+        0x000000001190a13eULL,
+        0x0000000000004d93ULL,
+        0x000000006aef52e2ULL,
+        0xffffffff839453c5ULL,
+        0x000000007b7f4a13ULL,                    /*  72  */
+        0x000000006aefa6beULL,
+        0x000000000000b9cfULL,
+        0xffffffffe97bb8e8ULL,
+        0xffffffff9204accaULL,
+        0xffffffff83944067ULL,
+        0xffffffffe97b5f16ULL,
+        0x0000000000005e31ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CH(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CH(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c b=
/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
new file mode 100644
index 0000000000..6f33839544
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
@@ -0,0 +1,154 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CW
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =3D   "CRC32CW";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x0000000000000000ULL,                    /*   0  */
+        0xffffffffb798b438ULL,
+        0xffffffff91d3be47ULL,
+        0x00000000264b0a7fULL,
+        0x0000000070b16a3dULL,
+        0xffffffffc729de05ULL,
+        0x0000000063c5950aULL,
+        0xffffffffd45d2132ULL,
+        0xffffffffb798b438ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x00000000264b0a7fULL,
+        0xffffffff91d3be47ULL,
+        0xffffffffc729de05ULL,
+        0x0000000070b16a3dULL,
+        0xffffffffd45d2132ULL,
+        0x0000000063c5950aULL,
+        0xffffffff91d3be47ULL,                    /*  16  */
+        0x00000000264b0a7fULL,
+        0x0000000000000000ULL,
+        0xffffffffb798b438ULL,
+        0xffffffffe162d47aULL,
+        0x0000000056fa6042ULL,
+        0xfffffffff2162b4dULL,
+        0x00000000458e9f75ULL,
+        0x00000000264b0a7fULL,                    /*  24  */
+        0xffffffff91d3be47ULL,
+        0xffffffffb798b438ULL,
+        0x0000000000000000ULL,
+        0x0000000056fa6042ULL,
+        0xffffffffe162d47aULL,
+        0x00000000458e9f75ULL,
+        0xfffffffff2162b4dULL,
+        0x0000000070b16a3dULL,                    /*  32  */
+        0xffffffffc729de05ULL,
+        0xffffffffe162d47aULL,
+        0x0000000056fa6042ULL,
+        0x0000000000000000ULL,
+        0xffffffffb798b438ULL,
+        0x000000001374ff37ULL,
+        0xffffffffa4ec4b0fULL,
+        0xffffffffc729de05ULL,                    /*  40  */
+        0x0000000070b16a3dULL,
+        0x0000000056fa6042ULL,
+        0xffffffffe162d47aULL,
+        0xffffffffb798b438ULL,
+        0x0000000000000000ULL,
+        0xffffffffa4ec4b0fULL,
+        0x000000001374ff37ULL,
+        0x0000000063c5950aULL,                    /*  48  */
+        0xffffffffd45d2132ULL,
+        0xfffffffff2162b4dULL,
+        0x00000000458e9f75ULL,
+        0x000000001374ff37ULL,
+        0xffffffffa4ec4b0fULL,
+        0x0000000000000000ULL,
+        0xffffffffb798b438ULL,
+        0xffffffffd45d2132ULL,                    /*  56  */
+        0x0000000063c5950aULL,
+        0x00000000458e9f75ULL,
+        0xfffffffff2162b4dULL,
+        0xffffffffa4ec4b0fULL,
+        0x000000001374ff37ULL,
+        0xffffffffb798b438ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,                    /*  64  */
+        0xffffffffea0755b2ULL,
+        0x0000000008b188e6ULL,
+        0xffffffffff3cc8d9ULL,
+        0xffffffffea0755b2ULL,
+        0x0000000000000000ULL,
+        0xffffffffe2b6dd54ULL,
+        0x00000000153b9d6bULL,
+        0x0000000008b188e6ULL,                    /*  72  */
+        0xffffffffe2b6dd54ULL,
+        0x0000000000000000ULL,
+        0xfffffffff78d403fULL,
+        0xffffffffff3cc8d9ULL,
+        0x00000000153b9d6bULL,
+        0xfffffffff78d403fULL,
+        0x0000000000000000ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CW(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CW(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c b/=
tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
new file mode 100644
index 0000000000..9eca9a6de1
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
@@ -0,0 +1,154 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32D
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =3D   "CRC32D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0xffffffffdebb20e3ULL,                    /*   0  */
+        0x0000000044660075ULL,
+        0x000000001e20c2aeULL,
+        0xffffffff84fde238ULL,
+        0x00000000281d7ce7ULL,
+        0xffffffffb2c05c71ULL,
+        0xffffffffd660a024ULL,
+        0x000000004cbd80b2ULL,
+        0xffffffff9add2096ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x000000005a46c2dbULL,
+        0xffffffffc09be24dULL,
+        0x000000006c7b7c92ULL,
+        0xfffffffff6a65c04ULL,
+        0xffffffff9206a051ULL,
+        0x0000000008db80c7ULL,
+        0x000000005449dd0fULL,                    /*  16  */
+        0xffffffffce94fd99ULL,
+        0xffffffff94d23f42ULL,
+        0x000000000e0f1fd4ULL,
+        0xffffffffa2ef810bULL,
+        0x000000003832a19dULL,
+        0x000000005c925dc8ULL,
+        0xffffffffc64f7d5eULL,
+        0x00000000102fdd7aULL,                    /*  24  */
+        0xffffffff8af2fdecULL,
+        0xffffffffd0b43f37ULL,
+        0x000000004a691fa1ULL,
+        0xffffffffe689817eULL,
+        0x000000007c54a1e8ULL,
+        0x0000000018f45dbdULL,
+        0xffffffff82297d2bULL,
+        0xffffffffa7157447ULL,                    /*  32  */
+        0x000000003dc854d1ULL,
+        0x00000000678e960aULL,
+        0xfffffffffd53b69cULL,
+        0x0000000051b32843ULL,
+        0xffffffffcb6e08d5ULL,
+        0xffffffffafcef480ULL,
+        0x000000003513d416ULL,
+        0xffffffffe3737432ULL,                    /*  40  */
+        0x0000000079ae54a4ULL,
+        0x0000000023e8967fULL,
+        0xffffffffb935b6e9ULL,
+        0x0000000015d52836ULL,
+        0xffffffff8f0808a0ULL,
+        0xffffffffeba8f4f5ULL,
+        0x000000007175d463ULL,
+        0x000000007a6adc3eULL,                    /*  48  */
+        0xffffffffe0b7fca8ULL,
+        0xffffffffbaf13e73ULL,
+        0x00000000202c1ee5ULL,
+        0xffffffff8ccc803aULL,
+        0x000000001611a0acULL,
+        0x0000000072b15cf9ULL,
+        0xffffffffe86c7c6fULL,
+        0x000000003e0cdc4bULL,                    /*  56  */
+        0xffffffffa4d1fcddULL,
+        0xfffffffffe973e06ULL,
+        0x00000000644a1e90ULL,
+        0xffffffffc8aa804fULL,
+        0x000000005277a0d9ULL,
+        0x0000000036d75c8cULL,
+        0xffffffffac0a7c1aULL,
+        0xffffffffed857593ULL,                    /*  64  */
+        0xffffffffe0b6f95fULL,
+        0x00000000253b462cULL,
+        0xffffffffe15579b9ULL,
+        0x0000000074897c83ULL,
+        0x0000000079baf04fULL,
+        0xffffffffbc374f3cULL,
+        0x00000000785970a9ULL,
+        0xffffffffa6bae0a9ULL,                    /*  72  */
+        0xffffffffab896c65ULL,
+        0x000000006e04d316ULL,
+        0xffffffffaa6aec83ULL,
+        0x000000005ae171feULL,
+        0x0000000057d2fd32ULL,
+        0xffffffff925f4241ULL,
+        0x0000000056317dd4ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32D(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32D(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c b/=
tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
new file mode 100644
index 0000000000..6123d221a7
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
@@ -0,0 +1,154 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32H
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =3D   "CRC32H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x000000000000ffffULL,                    /*   0  */
+        0xffffffffbe2612ffULL,
+        0xffffffffdccda6c0ULL,
+        0x0000000062eb4bc0ULL,
+        0x000000004bbbc8eaULL,
+        0xfffffffff59d25eaULL,
+        0x0000000022259ac0ULL,
+        0xffffffff9c0377c0ULL,
+        0xffffffffbe26ed00ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000062ebb43fULL,
+        0xffffffffdccd593fULL,
+        0xfffffffff59dda15ULL,
+        0x000000004bbb3715ULL,
+        0xffffffff9c03883fULL,
+        0x000000002225653fULL,
+        0xffffffffdccdf395ULL,                    /*  16  */
+        0x0000000062eb1e95ULL,
+        0x000000000000aaaaULL,
+        0xffffffffbe2647aaULL,
+        0xffffffff9776c480ULL,
+        0x0000000029502980ULL,
+        0xfffffffffee896aaULL,
+        0x0000000040ce7baaULL,
+        0x0000000062ebe16aULL,                    /*  24  */
+        0xffffffffdccd0c6aULL,
+        0xffffffffbe26b855ULL,
+        0x0000000000005555ULL,
+        0x000000002950d67fULL,
+        0xffffffff97763b7fULL,
+        0x0000000040ce8455ULL,
+        0xfffffffffee86955ULL,
+        0x000000004bbbfbd9ULL,                    /*  32  */
+        0xfffffffff59d16d9ULL,
+        0xffffffff9776a2e6ULL,
+        0x0000000029504fe6ULL,
+        0x000000000000ccccULL,
+        0xffffffffbe2621ccULL,
+        0x00000000699e9ee6ULL,
+        0xffffffffd7b873e6ULL,
+        0xfffffffff59de926ULL,                    /*  40  */
+        0x000000004bbb0426ULL,
+        0x000000002950b019ULL,
+        0xffffffff97765d19ULL,
+        0xffffffffbe26de33ULL,
+        0x0000000000003333ULL,
+        0xffffffffd7b88c19ULL,
+        0x00000000699e6119ULL,
+        0x000000002225eb07ULL,                    /*  48  */
+        0xffffffff9c030607ULL,
+        0xfffffffffee8b238ULL,
+        0x0000000040ce5f38ULL,
+        0x00000000699edc12ULL,
+        0xffffffffd7b83112ULL,
+        0x0000000000008e38ULL,
+        0xffffffffbe266338ULL,
+        0xffffffff9c03f9f8ULL,                    /*  56  */
+        0x00000000222514f8ULL,
+        0x0000000040cea0c7ULL,
+        0xfffffffffee84dc7ULL,
+        0xffffffffd7b8ceedULL,
+        0x00000000699e23edULL,
+        0xffffffffbe269cc7ULL,
+        0x00000000000071c7ULL,
+        0x0000000000002862ULL,                    /*  64  */
+        0x0000000026a17af6ULL,
+        0xffffffffaa919152ULL,
+        0xffffffffcb865590ULL,
+        0x0000000026a11f07ULL,
+        0x0000000000004d93ULL,
+        0xffffffff8c30a637ULL,
+        0xffffffffed2762f5ULL,
+        0xffffffffaa9100ffULL,                    /*  72  */
+        0xffffffff8c30526bULL,
+        0x000000000000b9cfULL,
+        0x0000000061177d0dULL,
+        0xffffffffcb8623c3ULL,
+        0xffffffffed277157ULL,
+        0x0000000061179af3ULL,
+        0x0000000000005e31ULL
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32H(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32H(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c b/=
tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
new file mode 100644
index 0000000000..b0b3ff92d2
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
@@ -0,0 +1,154 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32W
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =3D   "CRC32W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x0000000000000000ULL,                    /*   0  */
+        0xffffffffdebb20e3ULL,
+        0x000000004a691fa1ULL,
+        0xffffffff94d23f42ULL,
+        0xffffffff8f0808a0ULL,
+        0x0000000051b32843ULL,
+        0x0000000065069dceULL,
+        0xffffffffbbbdbd2dULL,
+        0xffffffffdebb20e3ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0xffffffff94d23f42ULL,
+        0x000000004a691fa1ULL,
+        0x0000000051b32843ULL,
+        0xffffffff8f0808a0ULL,
+        0xffffffffbbbdbd2dULL,
+        0x0000000065069dceULL,
+        0x000000004a691fa1ULL,                    /*  16  */
+        0xffffffff94d23f42ULL,
+        0x0000000000000000ULL,
+        0xffffffffdebb20e3ULL,
+        0xffffffffc5611701ULL,
+        0x000000001bda37e2ULL,
+        0x000000002f6f826fULL,
+        0xfffffffff1d4a28cULL,
+        0xffffffff94d23f42ULL,                    /*  24  */
+        0x000000004a691fa1ULL,
+        0xffffffffdebb20e3ULL,
+        0x0000000000000000ULL,
+        0x000000001bda37e2ULL,
+        0xffffffffc5611701ULL,
+        0xfffffffff1d4a28cULL,
+        0x000000002f6f826fULL,
+        0xffffffff8f0808a0ULL,                    /*  32  */
+        0x0000000051b32843ULL,
+        0xffffffffc5611701ULL,
+        0x000000001bda37e2ULL,
+        0x0000000000000000ULL,
+        0xffffffffdebb20e3ULL,
+        0xffffffffea0e956eULL,
+        0x0000000034b5b58dULL,
+        0x0000000051b32843ULL,                    /*  40  */
+        0xffffffff8f0808a0ULL,
+        0x000000001bda37e2ULL,
+        0xffffffffc5611701ULL,
+        0xffffffffdebb20e3ULL,
+        0x0000000000000000ULL,
+        0x0000000034b5b58dULL,
+        0xffffffffea0e956eULL,
+        0x0000000065069dceULL,                    /*  48  */
+        0xffffffffbbbdbd2dULL,
+        0x000000002f6f826fULL,
+        0xfffffffff1d4a28cULL,
+        0xffffffffea0e956eULL,
+        0x0000000034b5b58dULL,
+        0x0000000000000000ULL,
+        0xffffffffdebb20e3ULL,
+        0xffffffffbbbdbd2dULL,                    /*  56  */
+        0x0000000065069dceULL,
+        0xfffffffff1d4a28cULL,
+        0x000000002f6f826fULL,
+        0x0000000034b5b58dULL,
+        0xffffffffea0e956eULL,
+        0xffffffffdebb20e3ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,                    /*  64  */
+        0xffffffff90485967ULL,
+        0x000000006dfb974aULL,
+        0x00000000083e4538ULL,
+        0xffffffff90485967ULL,
+        0x0000000000000000ULL,
+        0xfffffffffdb3ce2dULL,
+        0xffffffff98761c5fULL,
+        0x000000006dfb974aULL,                    /*  72  */
+        0xfffffffffdb3ce2dULL,
+        0x0000000000000000ULL,
+        0x0000000065c5d272ULL,
+        0x00000000083e4538ULL,
+        0xffffffff98761c5fULL,
+        0x0000000065c5d272ULL,
+        0x0000000000000000ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32W(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32W(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
--=20
2.34.1

