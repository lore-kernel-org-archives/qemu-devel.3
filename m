Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27625C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7SU8-0006jg-2m; Fri, 18 Sep 2026 02:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x7STz-0006hD-7M; Fri, 18 Sep 2026 02:54:03 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x7STx-0002rT-GN; Fri, 18 Sep 2026 02:54:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHxaeTwVqHi/NivJASHQyHKkluDaeQsd4hbykLbHLhmrCr0Se57o/4IrJX0OcoyJ9j8QL/w+TpOgFyu9FBceDub1dmT02ZfdrfAJow/T9kkNGKXyCcFTBZ7L8G0/LypfF7icY2p8yxxH/XUMSxtqTJJ8bItLeYIZTXNI0eQLU8KlF2nyIMl4YFJXvX5lFVLCd4DiTe9GXQCliQH+X5rs38Mfwc9jYFPny9Hgj/WgdFvAeNkvjGdFyjpbLciVp40YN3nQq1kPawZjdqy0UulBdwvnAz741CcoNNT7uQMNyaWqzP+ZKJiCDivbK4mDWfWEDv6vwfC/f7a0z9JUk+M3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VffH2c0eSwdtlVA1x/tN3Xl4to32NdBJxgEoVJnPbI=;
 b=RYdqgcy18Fhz4GflI4sV6ZBkC5sBvJPLbuZWz8rJ4IOLHJs35om9tnbYrWsAbmQ21wMOee2VSUCkfJ11W1T7bDRyWH08FD2za/NchEJENCxIfhoXyEO0WmJn0MSDpONvnqNeO0LwLS8ZMHsjLWWzYpjgER7v2xacb/0gwJQqaZ/4ozth5s+80y7RBGQD1tTBjj5Rib6y+Gja6C7P48wbRPkIL+YFPLDVWn+9LgcJ9KOnhVglaYkdxigQT2YSd7ZGlxBCZZs9LPx7G1hD20ks1SCeVvk0COru09qEDNh03b9xXeNX5eQqAu+VMl1YtnXs2xs+II+y1mzgv51kzxcmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VffH2c0eSwdtlVA1x/tN3Xl4to32NdBJxgEoVJnPbI=;
 b=q/GWz09Yr0IA0xZ4zfazPnUaD/eJXybkwOKag/smFkyGtgJNFL4JmXH2Jl+eh8fWgsBBlBXjsexyXpibUSVHXxxTmoC/6ocpNtGhvsLXu2nEPI4/9XfoRRMczGLVMRQN5a3x3TERkXDKJ0kr9nJPzE2Hautlg1Ss0yiO1PA68G218BgpLNQioqj4UjA7WbEuXUXUTu5OncblhM+85bNMG5WYSgL4TaEUJFF6PMB2hApEau2FDOTGtuOm6ch3bzqm3VSmo+4BIH2LpTbwEYyzDqbABSqbiw7fp5b6n58yafLUNSMedjW7d8nwGs3lGqnfDJ1KLJ7O9qVNPfmVqFCdhQ==
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com (2603:1096:101:249::5)
 by SEZPR06MB8814.apcprd06.prod.outlook.com (2603:1096:101:33d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 06:53:49 +0000
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6]) by SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 06:53:49 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 1/3] hw/nvram/aspeed_otp, hw/misc/aspeed_sbc: Consolidate
 OTP layout definitions
Thread-Topic: [PATCH v2 1/3] hw/nvram/aspeed_otp, hw/misc/aspeed_sbc:
 Consolidate OTP layout definitions
Thread-Index: AQHdRzp1dJ4DFpiGzUqAzADjE6BpcQ==
Date: Fri, 18 Sep 2026 06:53:49 +0000
Message-ID: <20260918065347.3713868-2-kane_chen@aspeedtech.com>
References: <20260918065347.3713868-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260918065347.3713868-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7619:EE_|SEZPR06MB8814:EE_
x-ms-office365-filtering-correlation-id: 075114c8-8e24-41c3-0b88-08df155197b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|6133799003|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 9ld24R7eZEFJE9is8oZliA4dIcGmuxn7TtdMEtqJY3KXn7zAfc5TjPpj53IbLgEMLbsLptG32ONC2rp6zeUEijXo6Kf//ki7/EGm4g7yyF/m6bXPuf787uQ150mUUx7bHbMs1kUWfhekai2X2dttGZDvHpCNGK2bVw3vh2aA54T7idhOeDdZx53zuCkwypncS0xXntadahs0mouzS6zQxIq/eTLn2HuXc18ZV/iM4Y3V2lE7oQl8au2pUeKMlK0mv+4MPRAT952dpgNAiGY0FsytouaXGOnu5hhfn6XwSKvfcd4a+RzcPPZb6lEtgYo3Y9fbcHAR4696ILt1RgI4gV9ICMaEzUBFQlnZFo9xUrI6irzfHz0qhDdKubk/ESW3Ev/a6h+B+ubNPjM9AzwlgiZBew8RRtRhjmxAnLG2GzSswIzBSCq8kiQ/Ru8NZBxs9UTavPAupWC/uFJl9gBsoccad5r9HLp6+Sm2rlNlPVEuJOSonGAMGXIhNwlED5JoakqqUU7BFT+MMFBm/y5COSTRitn9xsYR22yyhozJty1tvFiMq4alWu5peFefJPXJIQlzbTgqH0mkGk+TQtWnG2ryKHc+89G+fEoVTvo4MHFkvh1q5pfPCn9TksZfQEGhSAH3k2i2mKdtogWRkkconha4kThLx3XO5aIFyUKvZZHq8zcw/XIxr7LF12q8TJxcblLZdSkcBxZsy5ikyqzWPREjK/13AgID+kz09cObE+s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7619.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3gg8V4HAlAi2sbwJ1tRRZbwys09uPTWOhsQXKW5v8wuGAkSRZ3p0uO0CWV?=
 =?iso-8859-1?Q?LCit3t8tXh3Tx1t2MyC9jK2Juz/lQpcVUFwS4f+m0707Pbuv4XcHmMJKve?=
 =?iso-8859-1?Q?moKM8xcqZS/relWG+iSjD3gFul9mrIAi3yulslknBQppMoT7d8AT6EHpF8?=
 =?iso-8859-1?Q?HsjR1khm0LBYL1jW0OOC+ruCQ1FHZgQruUsdk7QhEnt6lO759+4j3/N8j/?=
 =?iso-8859-1?Q?FqrETRyOKvBvZMTHSBhpWn/Lsc/aZu4zj3TcjGtRxM6MPrpUvjVCIUC89t?=
 =?iso-8859-1?Q?awBxblqhRLIRYKU/FRV/bd02Kh0OFKOCmc5L+P0MMbNDq2KpN+x1sFFPjP?=
 =?iso-8859-1?Q?XFkaw1/xQLMOe7DKwktJObCGKQHB7dlqIlfxhFTpgS+mRXdiEQjsQqet1N?=
 =?iso-8859-1?Q?vbLo9obURCpS/CQGwFe6FCpF/gH65iAX8Ow2e0KuS8CPOuqZt42bNWBfWV?=
 =?iso-8859-1?Q?eeMB8gRiyW+wIqiVV+tJksYsHi6zUGm0T9B5xw/0uh/4XNWq5ktfhFkGeg?=
 =?iso-8859-1?Q?afLd3rZVHD8Fxob0rajvHWyaSwtyy9kk17+VWd/j1tdOBouQ3WqekKxDgW?=
 =?iso-8859-1?Q?dl24NvhLAsRt03bBgNrwUf2RYTJWMnI0OfG+k9N6zi0QL8r5zn3JgsJpjc?=
 =?iso-8859-1?Q?IXSDKZ8iyyjfZ2JAV6ChiePxB22av7OQzcu/5eQf1OEVVkJPOmWKvIttlK?=
 =?iso-8859-1?Q?hJ8ieCbu98BdlzT4EJNfi7me469DwRVe55EKlbqPteK92+QY7w8EwH7Nmf?=
 =?iso-8859-1?Q?xcR/3iBxbN/SHxye2K2Vyq4juqNQTbbACvsz4oIjlF+QlSeM8Ln8HJfRcP?=
 =?iso-8859-1?Q?6yEcgCSJuPddgG07dtCQOdCzw3RIZnfD7cHrBpTE562eMbDPhY8WXwTkAy?=
 =?iso-8859-1?Q?fUN4dbQSD5vS7+apwGFcK2633Q9HQQi62s3SRksB9Qh9EwFne3iu5ZwJnc?=
 =?iso-8859-1?Q?7jc6bGa9VJF+CI+4rXj0+MrxVjzlF9CaGvILnrdpITWpeZpE9brrAibCyY?=
 =?iso-8859-1?Q?UcaLTMTlm3YRPZsTouhqr8fjK3hXQv5Ua5fI7PITCazOhgwuNPmbX4oa/z?=
 =?iso-8859-1?Q?wKg1mqFxdrJQhojsOiz+qRgNMZ+5QGGDdwpRbGvSi7BSICYNkyCFXDY04J?=
 =?iso-8859-1?Q?ynYfd8Fy43kxwMjsMG0keZjCi/WyzTpy6wL+0X2qyMQzYPZrwm2dqskXOB?=
 =?iso-8859-1?Q?NPTBYKm7td6VWxE8VTGk1rOT8hi1wohyQMkuuRwWtvczmhNb1fgtupFxqA?=
 =?iso-8859-1?Q?7z1GMVOCsnxsevTnYJrOfJzE1v4Icth2t0cplTZgN3mIVnbqPkbVyNh0FA?=
 =?iso-8859-1?Q?oU9jt8uQbXAjSIQGI2puCfvu6LRSfTKJ+HJksSuJAB1/QVTlkJbZ90gNTL?=
 =?iso-8859-1?Q?78SNtcbSNKUsrHrwORQHhyYIY57OKGGeiH4RaeDnKb2g61LKTOUhUUhbvb?=
 =?iso-8859-1?Q?Qn2JdkjQojQK/0ZrKmh3q88ofAKIUKsZKQSZBKYbgpPGMfBrBL7HefThLr?=
 =?iso-8859-1?Q?a8MZC6DAMbxQW7t7V1jQMwFbKGON28h9K04v1dh/Qw3irkjBP67gFAX+NT?=
 =?iso-8859-1?Q?7VELk4uOow/UlwoJeCanTESsSmFMcmFagMLhHSL/Zl1ZIFtWGgPERm9egx?=
 =?iso-8859-1?Q?tzljO6wX4qWKbjVM3vMUpw+rj5fOE9Yduy9OKrBvIl21Xgi/Aj85Au6DKU?=
 =?iso-8859-1?Q?RdFmOCYvW/I95dJKvNtUeFPQMxxhx7CJoXSwrFrCkqRbS9QjvUE+xSsuFu?=
 =?iso-8859-1?Q?5krq0SBXvXG0+9ILBkS4xFAWWyBCxM+8/XcFhsaFCiOKasLOIKbjklXxah?=
 =?iso-8859-1?Q?qylaYojZDg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xxthxSt0ldo3tYQsYJDWl3LaRcG8nrlfysSYBymdy8XWqBU9ASEA9vVB/F2dFF59cb7aMgTSmRfvOAENvKEvru9J4YHOacMcxW1yFSsr4quuBjEuNTzAw3urcB+wv/jdmAysnQTxuyTmfscVcsu4wAwmBuFSeGxZCGf0ZZ0ooY0MsilpHYOqKnkdqyZUnGx5ACMjVYN1aPgSSMiGRTbnbSLMe45eKfLSbUQMx8SLVgdaiYbjsYO8uvaxHTDEX+4FK9utLf98IDnMB0qtYlsnk+qUohPSMAxiK+6RkGHp7WCXqvLk4ZDvBiPyzlZyi4vHIp602/Tk+MQEphghs6rVHA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7619.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075114c8-8e24-41c3-0b88-08df155197b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:53:49.1195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YZ1ffw6rCsytL9JcS/YGFbd7FfnLNoRD9TiHIWSY3JapkXS+JQpZw/rU90/EK4By2qtIRnBClwzincjxuG0t3hUzbp0SvS/cxqgNct5nvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8814
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the OTP address-space layout definitions from aspeed_sbc.c to=0A=
aspeed_otp.h, as they describe the OTP device layout.=0A=
=0A=
Add an aspeed_otp_read() helper to reduce duplicated OTP read code.=0A=
=0A=
Remove the redundant OTP address bounds checks, as invalid accesses=0A=
are already handled by the OTP address space.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/nvram/aspeed_otp.h | 13 +++++++++=0A=
 hw/misc/aspeed_sbc.c          | 52 +++++++++++------------------------=0A=
 2 files changed, 29 insertions(+), 36 deletions(-)=0A=
=0A=
diff --git a/include/hw/nvram/aspeed_otp.h b/include/hw/nvram/aspeed_otp.h=
=0A=
index 3752353860..2b6c2eaaa3 100644=0A=
--- a/include/hw/nvram/aspeed_otp.h=0A=
+++ b/include/hw/nvram/aspeed_otp.h=0A=
@@ -16,6 +16,19 @@=0A=
 #define TYPE_ASPEED_OTP "aspeed-otp"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedOTPState, ASPEED_OTP)=0A=
 =0A=
+#define OTP_MEMORY_SIZE                 0x4000=0A=
+=0A=
+/*=0A=
+ * The OTP address space is indexed by dword address and is split into=0A=
+ * two regions:=0A=
+ *=0A=
+ *  - [0, OTP_DATA_DWORD_COUNT]: the data region. Each address contains=0A=
+ *    64 bits of data.=0A=
+ *  - [OTP_DATA_DWORD_COUNT, OTP_MEMORY_SIZE / 4]: the configuration=0A=
+ *    region. Each address contains 32 bits of data.=0A=
+ */=0A=
+#define OTP_DATA_DWORD_COUNT            (0x800)=0A=
+=0A=
 typedef struct AspeedOTPState {=0A=
     DeviceState parent_obj;=0A=
 =0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index 5c193d9086..3402cef5c3 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -66,15 +66,11 @@=0A=
 #define QSR_RSA_MASK           (0x3 << 12)=0A=
 #define QSR_HASH_MASK          (0x3 << 10)=0A=
 =0A=
-#define OTP_MEMORY_SIZE 0x4000=0A=
 /* OTP command */=0A=
 #define SBC_OTP_CMD_READ 0x23b1e361=0A=
 #define SBC_OTP_CMD_WRITE 0x23b1e362=0A=
 #define SBC_OTP_CMD_PROG 0x23b1e364=0A=
 =0A=
-#define OTP_DATA_DWORD_COUNT        (0x800)=0A=
-#define OTP_TOTAL_DWORD_COUNT       (0x1000)=0A=
-=0A=
 /* Voltage mode */=0A=
 #define MODE_REGISTER               (0x1000)=0A=
 #define MODE_REGISTER_A             (0x3000)=0A=
@@ -96,43 +92,34 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr ad=
dr, unsigned int size)=0A=
     return s->regs[addr];=0A=
 }=0A=
 =0A=
-static bool aspeed_sbc_otp_read(AspeedSBCState *s,=0A=
-                                   uint32_t otp_addr)=0A=
+static bool aspeed_otp_read(AspeedSBCState *s, uint32_t otp_addr,=0A=
+                             uint32_t *value)=0A=
 {=0A=
-    MemTxResult ret;=0A=
-    AspeedOTPState *otp =3D &s->otp;=0A=
-    uint32_t value, otp_offset;=0A=
-    bool is_data =3D false;=0A=
-=0A=
-    if (otp_addr < OTP_DATA_DWORD_COUNT) {=0A=
-        is_data =3D true;=0A=
-    } else if (otp_addr >=3D OTP_TOTAL_DWORD_COUNT) {=0A=
+    if (address_space_read(&s->otp.as, otp_addr << 2, MEMTXATTRS_UNSPECIFI=
ED,=0A=
+                            value, sizeof(*value)) !=3D MEMTX_OK) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "Invalid OTP addr 0x%x\n",=0A=
+                      "Failed to read OTP memory, addr =3D %x\n",=0A=
                       otp_addr);=0A=
         return false;=0A=
     }=0A=
 =0A=
-    otp_offset =3D otp_addr << 2;=0A=
-    ret =3D address_space_read(&otp->as, otp_offset, MEMTXATTRS_UNSPECIFIE=
D,=0A=
-                             &value, sizeof(value));=0A=
-    if (ret !=3D MEMTX_OK) {=0A=
-        qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "Failed to read OTP memory, addr =3D %x\n",=0A=
-                      otp_addr);=0A=
+    return true;=0A=
+}=0A=
+=0A=
+static bool aspeed_sbc_otp_read(AspeedSBCState *s,=0A=
+                                   uint32_t otp_addr)=0A=
+{=0A=
+    uint32_t value;=0A=
+    bool is_data =3D otp_addr < OTP_DATA_DWORD_COUNT;=0A=
+=0A=
+    if (!aspeed_otp_read(s, otp_addr, &value)) {=0A=
         return false;=0A=
     }=0A=
     s->regs[R_CAMP1] =3D value;=0A=
     trace_aspeed_sbc_otp_read(otp_addr, value);=0A=
 =0A=
     if (is_data) {=0A=
-        ret =3D address_space_read(&otp->as, otp_offset + 4,=0A=
-                                 MEMTXATTRS_UNSPECIFIED,=0A=
-                                 &value, sizeof(value));=0A=
-        if (ret !=3D MEMTX_OK) {=0A=
-            qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                          "Failed to read OTP memory, addr =3D %x\n",=0A=
-                          otp_addr);=0A=
+        if (!aspeed_otp_read(s, otp_addr + 1, &value)) {=0A=
             return false;=0A=
         }=0A=
         s->regs[R_CAMP2] =3D value;=0A=
@@ -181,13 +168,6 @@ static bool aspeed_sbc_otp_prog(AspeedSBCState *s,=0A=
     uint32_t value =3D s->regs[R_CAMP1];=0A=
     uint32_t otp_offset =3D otp_addr << 2;=0A=
 =0A=
-    if (otp_addr >=3D OTP_TOTAL_DWORD_COUNT) {=0A=
-        qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "Invalid OTP addr 0x%x\n",=0A=
-                      otp_addr);=0A=
-        return false;=0A=
-    }=0A=
-=0A=
     ret =3D address_space_write(&otp->as, otp_offset, MEMTXATTRS_UNSPECIFI=
ED,=0A=
                               &value, sizeof(value));=0A=
     if (ret !=3D MEMTX_OK) {=0A=
-- =0A=
2.43.0=0A=

