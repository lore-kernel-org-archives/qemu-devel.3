Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A79606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=MqIv4OG0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjVE-00040a-1K; Tue, 24 Nov 2026 00:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUy-0003v6-4G; Tue, 24 Nov 2026 00:55:27 -0500
Received: from mail-japanwestazon11022129.outbound.protection.outlook.com
 ([40.107.75.129] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUv-0002KT-AQ; Tue, 24 Nov 2026 00:55:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQutiYL95hoQjlUT7Vqyxue4uap8HIzmBF6fPuZ9B3KSBx4puG9aMvW9FOHq4XAVmozFscSFn2/jMvBiDwEQHBMmDuE4oTg7hpK+4hegtnnJv1SweBZO1pTSjDlUnuTvno/tieJDwm/iWO8cEhhArUzvpDTERMm0yEqdB5leBgv73EocD1a2ldgReV/Vxg7ygs3rmbHA1cdgzZRXeVI/ws2GEmTqbgE90TQD+PmU3eiH3iiETq37wDot+O2VUuR0poIhTKJuABmmdM1/7wXNw137SCimQ7bXgUX0RYzhb7U8/oknrO+YeQ/rMA4uO/tWLyD/3Hw4YChDuvb4LZAQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN4BM6igmySuXsBvGyxUVhzxVswWIrJEZZoDnS4m55I=;
 b=Rm8rdFLrfNY9jzgWyKNOtdhbSQ+441p6eP4XKBn70gx5OaVUGi/W3w7UTZUFKjnPaLJWai4zxlBx9Pu4dsQmrXG9WCQTsOmWL97IJAW+Mv2SQuuUc1PmkbbUqX4uteOZSkrBw1byWLVeZT99e2Js4imSsUXDTrb5qNsgHdPjLd/sSNGtAvcvQpyiPtpC/fRR4M7OE8ZSZ5MVJbM4T7g+Dhq1/yOOWXW7GSNN7zVIC2AhW3hfJ7KxhVemQ/v1Zdgv/vB1bw9Xm1odrzrspxvQ9Z7FASCBY1Ow/wECT5K8UrOtoXfaIRSHnR6UqxRIeSwjYZ2r8p2vFxyGrgjALYIIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN4BM6igmySuXsBvGyxUVhzxVswWIrJEZZoDnS4m55I=;
 b=MqIv4OG0OiJHFxE2ACJb+tTW4bZ3DcrK/3CmumZJuig4ZZcz1uhNhHdMwsk+Iq35kIupSUQIzyj/Knfru3YK4HjFuXddnHWuCUIDTPE+XecK+zBdwvtgQj1PwJZT4YSEwG1M1qGx51VU4VIV65vrhRjZ8omUYV2vyr/Lyc3yTfVCMOIiNGF/R1d91nUWHue37Ed68k6qWaiRyhRZfgaJ4NS6hMpXADW+ZDwADu1zVg+6Hx4BLEe4IV979KFjpTBssAS3ZUBuqhYlmnQRqiD1fPtoIq7bj+Xa6Ed09cpDhJHOOHmgU6s2c40e+soJDafVkfOyoG5BqS98heAHZeIfMg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYUPR06MB6270.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 05:51:59 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 05:51:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 07/11] hw/misc/aspeed_scu: Implement TSP reset and power-on
 control via SCU registers
Thread-Topic: [PATCH v7 07/11] hw/misc/aspeed_scu: Implement TSP reset and
 power-on control via SCU registers
Thread-Index: AQHde9fruofOlYjisUSnIsqFGdp/yQ==
Date: Tue, 24 Nov 2026 05:51:58 +0000
Message-ID: <20261124055150.1328856-8-jamin_lin@aspeedtech.com>
References: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYUPR06MB6270:EE_
x-ms-publictraffictype: Email
client-request-id: d7f0ed6f-416c-437d-a6b1-2eff883b7232
request-id: 6261b741-b8e6-4881-aabc-08df49ef0ddc
x-ms-office365-filtering-correlation-id: 6261b741-b8e6-4881-aabc-08df49ef0ddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|261009221227099003|261009220027099003|261009221727099003|261009223327099003|261009223027099003|10067099003|5023799004|56012099006|261021121427099003|261022075727099003|261021123027099003|38070700021|261102123227099003;
x-microsoft-antispam-message-info: dZBmT/Fgx7YWVQX7BW6c0qhfqs15PuqrqmeW5kXjharm8HPFvN0/FGt6xcmd4IXRlFOcvmv0E/nUmqd2fUQaZ7S9zmQ8oByuQyYLy5Eve7XGBUtqwvGaiqwwj2mRvkRgPBxBbsezJE7HQDybEDpxa4ZtI++PuNFA5sHuOd38RZFJvkVhPHLu3+1CPfSIAUKWKEAbWaIiebftvYhabMBPNHq1YPj3zlW199+kLndz+P4pdRrFPnTs/noEB6DogiLM/ErMBaJ3WAtJR67bUwZYVAZ3nPclcbHPQOmpLn9ZTGshhAFA+st0TXPN+GdEZgxTXzptjy7fvDcm7/WUmLddJtkCdNNnT22SlXHQgdOQj4m1G1uTalKPqFTOe92sJG5uKQoTgxYoF+FkHLiFwCC4NFbJdZO4rKHDG/NiG7K+jkSGssJJJUXi6JiXpI6rHV8n6C3s2UP7AVQb708x0JCr0IYX84+b9gLcYOiWAJ/8LCCkUWDadgRRQwTNL6CLL9ttkOyazdCPRt1Ui1JDhLq61PfGtzuBK7+zqFWzrBq1Jy/Vfu1NzYhbsgpLEzQulIaacFvxDIwkMN2HkU1RKMz9iP74bik4d66EhR4ytX5PNXJCFq6wFEJI/5OJByd1aJYh/16vsD3O6Mfx5NgCLElPY9O9ulXpBC3MR43EFpY9c7/xqhBlBhWCZx5r6DIerERaCaEsxNnlZtDsgL3tzUD/DA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223327099003)(261009223027099003)(10067099003)(5023799004)(56012099006)(261021121427099003)(261022075727099003)(261021123027099003)(38070700021)(261102123227099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aIzhjCzVuACIprSF7khVtwTAU6PALWqy7xWCOI8FHGY3bQZJQNZJ2ZMzgf?=
 =?iso-8859-1?Q?A6ThYVGYQWAcybCTqx+1yqnsxNo/EztKintcEayzXKGFHXKTZFgnRa9Wq3?=
 =?iso-8859-1?Q?E3Mbc2LewX7PEpj6WESDafaCoTculr5juer4CuKNA/O+xbT2SnxsS3slh8?=
 =?iso-8859-1?Q?642lP1m7HBYwgXqUFw/tRVg0UY7dP25Kx5ztpldsvJDL601ENvwsUAUfKs?=
 =?iso-8859-1?Q?uKa39pz2fMxKSqyDyh9I0RI5BUjb3F9qwJTOn6GKZ+5794fUWgn5nfA1ki?=
 =?iso-8859-1?Q?J4SR4CAXix78n/b4FfqytA4cjI0DLPyRaAqlacxK0giiNohXrij3mRwU3F?=
 =?iso-8859-1?Q?QPv1H2WWzpDQV0+wK5mtSyvpLH76YJlg3Elbuz0byIzC7Y3aPziUDr5Q7P?=
 =?iso-8859-1?Q?xTUdjHNby4Np1672mF6UFMHFeByUXBHFC6VCrM55jhJmPb30kaENynRZEE?=
 =?iso-8859-1?Q?sE+AVAvA1k0kRnmv2X1G8ni5/aKRX3Lg7fctSgiceS611RKsiVpRx7Gajz?=
 =?iso-8859-1?Q?l8drkToHaXWdG+6CjhXC3Hs3INcTGTYcmrPWheX4Mt25ToI5RkJb7GR+VC?=
 =?iso-8859-1?Q?ZAArOK2UxHdalVOviRH/YKH/0Zd39zmmsCNSw7HwtAL+Z4kMvmY6f2nY/w?=
 =?iso-8859-1?Q?mmo3kXjaIP/J30fxYq/n3FasksX598uglajaDggu49ghMWVlGtOSQjF+NE?=
 =?iso-8859-1?Q?wnHEQD6pME0NaktpjKGpafyr1VhCJxHQIfAMyS+HrzwNQe+/duH4x3GhOv?=
 =?iso-8859-1?Q?jqbCjwW9mUZXtEB5cxjRfstH1mq7ofR/GH1C7mSarxPTjYnogUEqRJOJo7?=
 =?iso-8859-1?Q?vvPS3Ylp1S/zpgBe6I+k5cbH2cOG938IYgFJBS4zahFpMXMla+UKqwqaFB?=
 =?iso-8859-1?Q?IcMviem7KKlK4X07mj2SzbSlhI3BE6ghPJ/PO0qxJZYIDcLEbup8tDs3xT?=
 =?iso-8859-1?Q?y7v/ZYRB3JFYt7iZ2GiRPQoENo/QMwEWjHWV2PHih0yTlRn/UfzvOeX8Cr?=
 =?iso-8859-1?Q?csriUhQ7+APFh3eKRXTHEKXxXU2K96WHPbZePogy3UtIwzjIOgs+U4oN0Q?=
 =?iso-8859-1?Q?dr+MotvfY/Ywty59ZcRGTECHZ5Rnatu2GbKrq5oC3JrUBWbVSr1dj1Q4G1?=
 =?iso-8859-1?Q?SUKR4/LDGmGnleYaO95ZHBO0n5cqHMRhQHS10AmSLA1+HH5TJoBal4XZ1/?=
 =?iso-8859-1?Q?PQlrVoTKChZQ2Dm5E6OIfWTlm3GX99mQos8X+dKjqzEqRpspO6goquGqar?=
 =?iso-8859-1?Q?X6oHQfB900DfUTV4JwAvAU54pACUIj3+YCkp9erej/iM5W9g9R4Os3qiyb?=
 =?iso-8859-1?Q?c/ZYgfFHlybr8CTwiUjeFDhzs7ByVOwUtQbTAYnspUjLpy8ahC8D0VVoQk?=
 =?iso-8859-1?Q?rmHpE9XKNr5SJx7cKsmHP3LWbRorgC1QeY3ggAKAiP9pV4xjaOq9W12mX+?=
 =?iso-8859-1?Q?rckNx4XYLS24UP8Cv2w7rzFABYg+2njsuMdGTM8xAfPa/1NCDipu1yJyfQ?=
 =?iso-8859-1?Q?QgXWd+LmJCaYRAxqbY5QaVSyRmrbb7DKRaPRz+VzKRixHTdWp5BlNvI7Xr?=
 =?iso-8859-1?Q?oByNrEm6AWIpHuVB37cbDc6FZ6xJWkRsSdr3hcu/nbXsBhkcaKMJ8ZPkd+?=
 =?iso-8859-1?Q?UtcPsDq5SuzO2q5iwUWmfLAXkqOHOblx0n/0ybTMmS4Xb++W8MRIBFX73l?=
 =?iso-8859-1?Q?tsc2jhDuoKUSPTi+Uae/qzaoM2S/8R2sHVCSdU89kQ9kcrf2TyhfoiqBEQ?=
 =?iso-8859-1?Q?j03A4nPD+yxEbafE41McVJNexXIIojseJ1MRL4m5LWoSEo/p7pyjmnKYLB?=
 =?iso-8859-1?Q?4f0trhO73Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6261b741-b8e6-4881-aabc-08df49ef0ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:51:58.8005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hp0lov/hu89KpSWxsSHaOVLhnJNucLIhJqDe9Pwmqirs6s+Q8daIYpkS2juOGQLdtt0ywOaRiF/rl6IQgwMVB+cANxUpZ/KnIX1TjjPe+dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6270
Received-SPF: pass client-ip=40.107.75.129;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch implements TSP reset and power control logic in the SCU module=
=0A=
for AST2700. It introduces support for the following behavior:=0A=
=0A=
1. TSP Reset Trigger (via SCU 0x220):=0A=
=0A=
   - TSP reset is triggered by writing 1 to bit 9 (RW1S) of SYS_RESET_CTRL_=
2.=0A=
=0A=
2. TSP Reset State and Source Hold (via SCU 0x160):=0A=
=0A=
   - Upon reset, bit 8 (RST_RB) is set to indicate the TSP is in reset.=0A=
   - Bit 10 (RST_SRC_RB) is set to indicate the reset was triggered by an e=
xternal source.=0A=
   - Bit 1 (RST) is a software-controlled bit used to request holding TSP i=
n reset.=0A=
   - If an external reset source is present and bit 1 is set, bit 9 (RST_HO=
LD_RB)=0A=
     will also be asserted to indicate the TSP is being held in reset.=0A=
   - If bit 1 is cleared, RST_HOLD_RB will be deasserted accordingly.=0A=
=0A=
3. Hold Release and Power-on:=0A=
=0A=
   - If RST_HOLD_RB is clear (0), TSP is powered on immediately after reset=
 is deasserted.=0A=
   - If RST_HOLD_RB is set (1), the user must write ENABLE (bit 0) to TSP_C=
TRL_0 to release=0A=
     the hold and power on TSP explicitly.=0A=
   - Writing ENABLE (bit 0) is a one-shot operation and will auto-clear aft=
er execution.=0A=
=0A=
4. Reset Status Clear (via SCU 0x224):=0A=
=0A=
   - The reset status can be cleared by writing 1 to bit 9 (RW1C) of SYS_RS=
T_CLR_2,=0A=
     which will deassert RST_SRC_RB and potentially trigger power-on if no =
hold is active.=0A=
=0A=
5. TSP Power Control Logic:=0A=
=0A=
   - handle_ssp_tsp_on() clears RST_SRC_RB and RST_RB (if not held), and in=
vokes=0A=
     arm_set_cpu_on_and_reset(cpuid) to power on the TSP core (CPUID 5).=0A=
   - handle_ssp_tsp_off() sets RST_RB and RST_SRC_RB; if RST is active, als=
o asserts=0A=
     RST_HOLD_RB and invokes arm_set_cpu_off(cpuid).=0A=
=0A=
The default values are based on EVB (evaluation board) register dump observ=
ations.=0A=
TSP reset control shares the same helper functions and register bit layout =
as SSP,=0A=
with logic selected by cpuid and distinct external reset sources.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 37 ++++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 36 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index b687f9d44d..f8935b3412 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -150,6 +150,7 @@=0A=
 =0A=
 /* SSP TSP */=0A=
 #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)=0A=
 #define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
 #define AST2700_SSP_TSP_RST             BIT(1)=0A=
 #define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
@@ -158,6 +159,9 @@=0A=
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
+#define AST2700_SCU_SYS_RST_CTRL_2      TO_REG(0x220)=0A=
+#define AST2700_SCU_SYS_RST_CLR_2       TO_REG(0x224)=0A=
+#define AST2700_SCU_SYS_RST_TSP         BIT(9)=0A=
 =0A=
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)=0A=
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)=0A=
@@ -939,7 +943,10 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
ddr offset,=0A=
 =0A=
     switch (reg) {=0A=
     case AST2700_SCU_SSP_CTRL_0:=0A=
-        cpuid =3D a->ssp_cpuid;=0A=
+    case AST2700_SCU_TSP_CTRL_0:=0A=
+        cpuid =3D (reg =3D=3D AST2700_SCU_SSP_CTRL_0) ?=0A=
+                a->ssp_cpuid : a->tsp_cpuid;=0A=
+=0A=
         if (cpuid < 0) {=0A=
             return;=0A=
         }=0A=
@@ -995,6 +1002,28 @@ static void aspeed_ast2700_scu_write(void *opaque, hw=
addr offset,=0A=
         }=0A=
         s->regs[AST2700_SCU_SYS_RST_CTRL_1] &=3D ~active;=0A=
         return;=0A=
+    case AST2700_SCU_SYS_RST_CTRL_2:=0A=
+        if (a->tsp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x00001fff;=0A=
+        if (data & AST2700_SCU_SYS_RST_TSP) {=0A=
+            handle_2700_ssp_tsp_off(s, a->tsp_cpuid, AST2700_SCU_TSP_CTRL_=
0);=0A=
+        }=0A=
+        s->regs[reg] |=3D data;=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CLR_2:=0A=
+        if (a->tsp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x00001fff;=0A=
+        oldval =3D s->regs[AST2700_SCU_SYS_RST_CTRL_2];=0A=
+        active =3D data & oldval;=0A=
+        if (active & AST2700_SCU_SYS_RST_TSP) {=0A=
+            handle_2700_ssp_tsp_on(s, a->tsp_cpuid, AST2700_SCU_TSP_CTRL_0=
);=0A=
+        }=0A=
+        s->regs[AST2700_SCU_SYS_RST_CTRL_2] &=3D ~active;=0A=
+        return;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n"=
,=0A=
@@ -1023,7 +1052,9 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST270=
0_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
     [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
+    [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
     [AST2700_SCU_HPLL_EXT_PARAM]    =3D 0x8000004f,=0A=
     [AST2700_SCU_DPLL_PARAM]        =3D 0x0080009f,=0A=
@@ -1054,6 +1085,10 @@ static void aspeed_ast2700_scu_reset_hold(Object *ob=
j, ResetType type)=0A=
     if (a->ssp_cpuid >=3D 0) {=0A=
         arm_set_cpu_off(a->ssp_cpuid);=0A=
     }=0A=
+=0A=
+    if (a->tsp_cpuid >=3D 0) {=0A=
+        arm_set_cpu_off(a->tsp_cpuid);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_2700_scu_instance_init(Object *obj)=0A=
-- =0A=
2.53.0=0A=

