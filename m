Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66744E83EE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8v-0005yu-CY; Wed, 04 Feb 2026 02:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZR-0004jB-IY; Wed, 04 Feb 2026 01:41:01 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZP-0004KA-Mx; Wed, 04 Feb 2026 01:41:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHlfxoqzgtPtkcPJ0BhkoalkcEAp14CD5/PP8UnUmGK8LhE5Hy7tppnuhKh8FBP+CplS3tCe8TWYUybVkAqSLVQ7QzavbtJeDwQVEjkNf9OSd7/I8i8d9MRkUzrG4Ss+kf8CpANdZzm3AD3xecfa+DwouM0Vx7pkvsY63muuRrOmF7SikKp9d0u6povJdpCjMfsFDt579Yh4aoX9cjpgmaK2nKKKcT2pgFLXyeYShE0I0ouyGG6A+hhs8SkpqLiZAYe8Z6E38emu+J2Lh0ZAFswwYEyXY1+I3UomUum7+je3PkmHSit7AGSx2Q4+twyVtBEbpcsEucHJwgfqcHWCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps8oZPjTYQ2Nk4xegqe7IJ8sm+7B3EvcYQLSrPHUwx0=;
 b=nS3bZu1wJ8mKvk8kcK2i4acdxuDMla/LeL/V5kfhm1L7MsxZc6s5DlMRjL9vHsFcLIDZ6r/4Lw9tsoqrcmJSfb24/WZ5EwHOLjVCTK4l1nGV/nBXWZA+JH6LuxN4p8PDnBESnWeUE7v55kGsgCjkyDRW3PKAc1UUDlpx4j5ccDQqrzJRwiSMBIa83EGkL1pFuObyfzttwBI5zwllL+10EAzHx7GG2QfAlOb0ze4jRTTOpYvO6Y7EDjZzBfhqI0KvTSfHO8+hJliI9C5Bpcu+6YhcYTsS7NMYyersT40hdBiTdOisH9TrvOu9B2y6PrLRYKIGxV/iKvf5lKci/IADaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps8oZPjTYQ2Nk4xegqe7IJ8sm+7B3EvcYQLSrPHUwx0=;
 b=Hnv9P5q1AIqaGhZ3IOR6aAp50p8jPBB0+FDJk+8x7WlVWwT/Dn8EdY4dKBebk5mF9x1lgFp12a+pteZCYrfxdJaGaKqOeNtTVrhB57DlvgtkC+Ce0i6XeEgCHkvYvMM0FuyC7XuhcV3Rk4aRmPfNBUFRPFoVb7dMjLoQprtotoAxKn0duvftYHNQckKlJQvb0kFyxOKbJpcIDx8t1KDQCNlH4LE6IkgsQUB4gK0cavFWD23NeO9iWVPd7QAK55YZNxgvZcVJn2ePESQI/SCSQg47Eip2qMhrlqvB/mCXL825rHOFALD6e5TBX7JHTsfKJzS+catYRkIdt8mJxmbgng==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:45 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:45 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v6 20/22] tests/functional/aarch64: Parameterize I2C bus ID in
 AST2700 test
Thread-Topic: [PATCH v6 20/22] tests/functional/aarch64: Parameterize I2C bus
 ID in AST2700 test
Thread-Index: AQHclaEwBnTJGPOjmUmbed6AxykLaQ==
Date: Wed, 4 Feb 2026 06:40:44 +0000
Message-ID: <20260204064016.3515639-21-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: e562c5e9-fd5c-4b08-3658-08de63b852f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?UavKuzjpGC6OSx01WeQ3SrymoY0V11nfy6owxfuSkOcsoiaju5CixM+t1n?=
 =?iso-8859-1?Q?Ny5Xc9yaCUmk4m1rTqbbItMXs3Nh0A6HzORSFkaaEeikdxu67GTmGPfXbH?=
 =?iso-8859-1?Q?PBDO853582raVbGspKQVvFhCl+ugVWRwFutb7FkwRftATQMM+LOjXY4U/q?=
 =?iso-8859-1?Q?i9IadPMkKg3qp8VzPmRa8wYABFACNm3POoWMoMBMo0smlP2t4JNUfqVHOc?=
 =?iso-8859-1?Q?FkFY5YaF+TfosBjvZvZJyKzzZxjxJ/o3/2yzTVVehv4DpDYi+UA2WxqKVn?=
 =?iso-8859-1?Q?JZKBKpmNtaDblosSZkSKamL5e6K5pgNeYv36fi1VUU9iqUochcPe9ZsCC2?=
 =?iso-8859-1?Q?8EcKkU8d5MValz2hgrmOcX1fsrI4xv9Ga3I2Sm5wLdcoYfAUljKtieIo73?=
 =?iso-8859-1?Q?GaGiIH1E7LZuLYhKhgqhvrwKBY1VtEn4x3qmWe0CIPTYju1gQYa7x84Z7L?=
 =?iso-8859-1?Q?bor6aU6HYfzJ64j4o4sCZ4ncNHEgTWTBg7MUp5wxHCbDA4Vvf+stHZBQSr?=
 =?iso-8859-1?Q?O2vKHuzaF/v1QuM13xff+FJlqpSDvIZfeixFCdJsfgx5aGDpRxbF/ek8RJ?=
 =?iso-8859-1?Q?nM6RKoK3byhs5XhteJRw+3RaU8J9F3nG8C39TwqiTEtbXzhxo9xcCEOvCK?=
 =?iso-8859-1?Q?1uJ2Xv6am6FD/7zvJ5LhewjBTnY2LldFbl6QLyJnZLj+jU0JXhXo4cBn+n?=
 =?iso-8859-1?Q?e5KSRrCtvrDxU6PjYyDW96WUprwm2Lv0wDjXwry6ACZmDUDI0UfPcpLLtb?=
 =?iso-8859-1?Q?PMmMwu1Bn0In6cPIyd5yPvrTFEzUG7b8/NnYL4tKfrpHa0Q8vKTb0uygHj?=
 =?iso-8859-1?Q?/KAoMlQzR/rFp2PUHkSYEhSeUbx1icR2jx3efPQIWiimvlUVrLNpdDxSqe?=
 =?iso-8859-1?Q?6HHoxsBqmwYLpAu/wIzFQ1Qo/sEzuK2HUPXJYmTxQGLvKwnkVOl3d/MClg?=
 =?iso-8859-1?Q?eCgDSCYc5QloTyJVJrAHF6CEhrxF9LPpuROyxpYTh1Worqn9q+CeSytbwO?=
 =?iso-8859-1?Q?H9tKA4GMVDnHSJnL1A3G/X3+hHPSNvoEkTaO+gVJKo7lgXzINkRUa7Q1ml?=
 =?iso-8859-1?Q?Z+NkHzJ/bZh70fqvARqLyF3CSGoQWUziCJfcsNCNUwYvlqy0yoQ4ybBZu0?=
 =?iso-8859-1?Q?c4p5IbLrp8e2Rv+CODaS5v5z7adl3/n/Y2QhY/BbbvvJMBSNH4IGGAkEdx?=
 =?iso-8859-1?Q?tatGSHHQSqNgLinR68yAcXrx3+Yaaoy32ComZRVBxP9TILWDnTRp/nYE2S?=
 =?iso-8859-1?Q?6NkqbOdVAckwU0iXgblAfTvcv4nFf7euyNozeKNyLmU34rCOls4eNU4h1p?=
 =?iso-8859-1?Q?WEvZ7Bz8bpwR6ljAAuw4KP5BeB9ntquQN89LyIyU24YpHZLsDGg0m/3gNa?=
 =?iso-8859-1?Q?hkAWGrbaMtdXUhY8IGpTEXcoZEp8ZAhceTSvfVFUUJshUlQdXNpUdwP69r?=
 =?iso-8859-1?Q?Hj/vFI+9C7Uz12OCh9LBu46cXNLQwe+rMKsBCUGSomWnjSy1h/gC7GV6Eq?=
 =?iso-8859-1?Q?lWeItkLhO7bU+4mQppbLvO4IOk9qfn+oua6NctwMGjz9dQU6U8DFqbmqNX?=
 =?iso-8859-1?Q?m14cbpcAKI9MwRC055nBpW+p3dApAMGcsTbNMLTe0AHG0blphT1GF+99wP?=
 =?iso-8859-1?Q?67AnBfAhM2+lpM2e9fGESgj7aAplDynHD0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xuZnqVyriAhXT+QXBbAUzNW21wfcZDP7aBxgpeGBrddpEYUQ/MkeGsBnRK?=
 =?iso-8859-1?Q?FK9SPAhP5WDXQM+XnP+KRLie5hTxMbNFTplv4UZZxtwkhisuEcI85B3ddh?=
 =?iso-8859-1?Q?6jHcEyWnSR7xq1gDQ1fh0PxCWfgrzFcVnCVtVskEJnN/hlUXD7NEtaUDMD?=
 =?iso-8859-1?Q?c585c7OwskET6N1kBf+0ZW2EEvbvuk60gqKqH2y/vo3E5b+wo4PNkHNz9b?=
 =?iso-8859-1?Q?ak585QQJU7BDkewSWiBZQ4AR+Py9RTRgl70cK4PwYvJhLqUD/RvrvCFJ9x?=
 =?iso-8859-1?Q?eb/0wheIpThU6xfxbAYkWGiIl32JHLutxxHT0J2B0OYoGzNZ3A3SA20SVb?=
 =?iso-8859-1?Q?a0AheeLhNctN270yvdr1ttzQytwWTy3kR5Zh9CMc8PlhS9W0DoI3IDgytI?=
 =?iso-8859-1?Q?sdkDegC900PP/MlYuv7HFLrlsKMzgWImubJ71P+vAZZTPX/F/imvBBf5/S?=
 =?iso-8859-1?Q?vRR6gMI1wzlgc/dI5+lDC+XSfJFjBWxmU8ZTUtIK9TIay9W4g2TJobnlvM?=
 =?iso-8859-1?Q?7U2ftwJF7IbRKeR6syDdcfz4phGtuGHHUPO3r3jFn416nR5qUpe1WBjZNJ?=
 =?iso-8859-1?Q?cTT+tv3shYh+CK/lJmm8LMsg7cHIUCyTWYMgntstIDV61HBECOROD3m9Hw?=
 =?iso-8859-1?Q?v+3cZ9krJpNU6r8EoPcWcWyV8SXMVvLRUvKiVDYkP847L2tAmX6/GG/Dv5?=
 =?iso-8859-1?Q?LdTDxsrZcwbiIyjQNxJCBqNj4is2Yc93QmhJ9rmyhc6kdQYtQYPJHmIhqZ?=
 =?iso-8859-1?Q?pl+2nBtELG2n7iGeJvxJy6YmSUSD4KIGMDy9yZ6JZbyMxtZVxWnPW+zQOc?=
 =?iso-8859-1?Q?ZbIC8ksioj6alkTDv0Iu6BZuQn71/9foe/l1+DRenOT/FdGMacJmCLXaUS?=
 =?iso-8859-1?Q?afeWr1ExkdbnNYOVzegybbnfqcxQP5YtwuVwYqBb4S/BlFCVlG16K4B4lg?=
 =?iso-8859-1?Q?OLMcdW+AjwfW8BG9GejZ2XuutsgkwflJPgbw1f5rCY4f1daiO4E7YHyqbr?=
 =?iso-8859-1?Q?p4nThmuB/jfaXVb8uKVtMvrOZoj43pgPyFv3FRZ+G5P7zd2Zr7lme43tp/?=
 =?iso-8859-1?Q?ay6BLFvaAPXEId1t0cCVzgNQv80goj9v0DBY4bmZVjnlXNL66WVLCECa3F?=
 =?iso-8859-1?Q?nKNLRbB3XUMOxJK58cVivjT52EK8QOYFgIBrrK+5/dWaydY2d6prDesxlP?=
 =?iso-8859-1?Q?MP6yqaIJ8fENYjwCNTHrBu0X6kRDcBHVl25s0OsiDqBa5sh9PH7idjk+Vh?=
 =?iso-8859-1?Q?yZDCbfe0mR8Ky/i/AMC9mp7ST73Sxx9Ldr4NoyTCLTEX2Svkf1DfAUO/No?=
 =?iso-8859-1?Q?XyTCdazYPUzY+XooFGb8+BFs0LH6+IyVhOjhAAJnT/ozkoBTfW4dLcQ5Jg?=
 =?iso-8859-1?Q?XdPDgunzdHFxnUxCFRPTv2woG1i71pFXV/GgF4tcx8w0tI4G90akbAdEVH?=
 =?iso-8859-1?Q?mhoYBCcYu+x2+s1rkzlgXXk8goKz8YYR5EFVzvg7QYXIREIaHu3MfAND9W?=
 =?iso-8859-1?Q?lOrJjDIAV9PgvYugkZ6TukNqiL5u831rDTzXrtv1ZTDQ1axALV5YCRior4?=
 =?iso-8859-1?Q?1SDQ5JGB517VdvOhFBnIHL8MBmMPfO5+GgyC+UZkQlhyl/DIVMXTbwvOmL?=
 =?iso-8859-1?Q?BlIJBL9FgKwqRcWDTwwhnK9js6uwXe/moO3RgOe4y8nzKzqiXft703xCui?=
 =?iso-8859-1?Q?t4/aEOAyF6DwY76G4ZTgprKv9o611h9jEt304lpWecbEpBCSgpQ4dIm+Sg?=
 =?iso-8859-1?Q?5laUfVXQm75PQ6fvgwcGET9HoP+BJ3+ufPSvvTuimwJLHovO9rXC/vtE6Z?=
 =?iso-8859-1?Q?ek+ox9qRow=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e562c5e9-fd5c-4b08-3658-08de63b852f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:44.9126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGpxNwlR5tSWsC8IhIlDtDkg9igYl88ZGEeM0O+Loey6frA3vE6m6djhysJ+RWEGzoQYlymxEsPZsfIwENL5LoUHeAvZiykuMA6keUVqa28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:22 -0500
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

The current Aspeed AST2700 functional test case strictly uses I2C bus=0A=
1 for its sensor tests. This hard-coded approach prevents the test=0A=
logic from being reused for other machine types or configurations=0A=
where I2C bus 1 might be disabled or where a different bus needs to=0A=
be verified (e.g., I2C expanders).=0A=
=0A=
This refactoring allows the same I2C verification logic to be shared=0A=
across different test scenarios by simply passing the target bus=0A=
number.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 .../functional/aarch64/test_aspeed_ast2700.py | 39 +++++++++++--------=0A=
 1 file changed, 23 insertions(+), 16 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700.py=0A=
index 828ea1ca53..d7eeab9c23 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
@@ -15,11 +15,17 @@=0A=
 =0A=
 class AST2x00MachineSDK(QemuSystemTest):=0A=
 =0A=
-    def do_test_aarch64_aspeed_sdk_start(self, image):=0A=
+    def do_test_aarch64_aspeed_sdk_start(self, image, bus_id):=0A=
+        bus_str =3D str(bus_id)=0A=
         self.require_netdev('user')=0A=
         self.vm.set_console()=0A=
-        self.vm.add_args('-device',=0A=
-                         'tmp105,bus=3Daspeed.i2c.bus.1,address=3D0x4d,id=
=3Dtmp-test')=0A=
+        self.vm.add_args(=0A=
+            '-device',=0A=
+            f'tmp105,'=0A=
+            f'bus=3Daspeed.i2c.bus.{bus_str},'=0A=
+            f'address=3D0x4d,'=0A=
+            f'id=3Dtmp-test-{bus_str}'=0A=
+        )=0A=
         self.vm.add_args('-drive', 'file=3D' + image + ',if=3Dmtd,format=
=3Draw',=0A=
                          '-net', 'nic', '-net', 'user', '-snapshot')=0A=
 =0A=
@@ -75,16 +81,17 @@ def verify_openbmc_boot_and_login(self, name):=0A=
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
             'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
 =0A=
-    def do_ast2700_i2c_test(self):=0A=
+    def do_ast2700_i2c_test(self, bus_id):=0A=
+        bus_str =3D str(bus_id)=0A=
         exec_command_and_wait_for_pattern(self,=0A=
-            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device '=
,=0A=
-            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d')=0A=
+            f'echo lm75 0x4d > /sys/class/i2c-dev/i2c-{bus_str}/device/new=
_device ',=0A=
+            f'i2c i2c-{bus_str}: new_device: Instantiated device lm75 at 0=
x4d')=0A=
         exec_command_and_wait_for_pattern(self,=0A=
-            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0=
')=0A=
-        self.vm.cmd('qom-set', path=3D'/machine/peripheral/tmp-test',=0A=
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_i=
nput', '0')=0A=
+        self.vm.cmd('qom-set', path=3Df'/machine/peripheral/tmp-test-{bus_=
str}',=0A=
                     property=3D'temperature', value=3D18000)=0A=
         exec_command_and_wait_for_pattern(self,=0A=
-            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '1=
8000')=0A=
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_i=
nput', '18000')=0A=
 =0A=
     def do_ast2700_pcie_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -99,7 +106,7 @@ def do_ast2700_pcie_test(self):=0A=
             'ip addr show dev eth2',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
-    def start_ast2700_test(self, name):=0A=
+    def start_ast2700_test(self, name, bus_id):=0A=
         num_cpu =3D 4=0A=
         load_images_list =3D [=0A=
             {=0A=
@@ -128,12 +135,12 @@ def start_ast2700_test(self, name):=0A=
 =0A=
         self.vm.add_args('-smp', str(num_cpu))=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
-            self.scratch_file(name, 'image-bmc'))=0A=
+            self.scratch_file(name, 'image-bmc'), bus_id)=0A=
 =0A=
-    def start_ast2700_test_vbootrom(self, name):=0A=
+    def start_ast2700_test_vbootrom(self, name, bus_id):=0A=
         self.vm.add_args('-bios', 'ast27x0_bootrom.bin')=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
-                self.scratch_file(name, 'image-bmc'))=0A=
+                self.scratch_file(name, 'image-bmc'), bus_id)=0A=
 =0A=
     def test_aarch64_ast2700a1_evb_sdk_v11_00(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
@@ -142,9 +149,9 @@ def test_aarch64_ast2700a1_evb_sdk_v11_00(self):=0A=
         self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test('ast2700-a1')=0A=
+        self.start_ast2700_test('ast2700-a1', 1)=0A=
         self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
-        self.do_ast2700_i2c_test()=0A=
+        self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
 =0A=
     def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):=0A=
@@ -154,7 +161,7 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self=
):=0A=
         self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test_vbootrom('ast2700-a1')=0A=
+        self.start_ast2700_test_vbootrom('ast2700-a1', 1)=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
-- =0A=
2.43.0=0A=

