Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E949C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgbrt-0003Ou-A5; Mon, 06 Jul 2026 01:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgbrW-0003HY-5X; Mon, 06 Jul 2026 01:27:26 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgbrU-0007PL-IL; Mon, 06 Jul 2026 01:27:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAF53VlGyYZwurEJVt6RfzDAjlr4mTsqBu9sNTTy/6RYc0l7M+5qZnKR7mAxS/YwTEoGpmYIKVhJILFKol7oTMXryyo0iZV0d5h2B5EZrzSyCr7Ry+vnBBD84Mg2S4FM8hA2BZkIw1sRhqAh3fYZB0A130imAIYS7ztYjk+oBaZCbG/lQei1lcqaRmnuwLwyRjF7dycaimJMNrfN50CuQBDJnSIdc6qDLmzeSXo/n9AAe58MMSOkWG/XYUKw9kRoqWN7UlBMwQp/S//bqmaLPexjOSgPeTTq++ZO0k1GD2r3D2iCWw1bTTc8wdsvHG4jio44KvZs5rWftKBPuLYRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQbY2GFnbVMqQ546zPufmZI+2vohwCd8QA0ZsWHyw/Y=;
 b=uqrxcqYx3Lb2ZIEDq3zVSrrNUofrlCPFGzI7UeU+lVyG1pqtXJGIlOxBd/2coksfog+qKemXa3ClLubHPZ9wO0XZheGB9o4a0DtKrZaYnyo3RKZ9ax40c0ul9PdzLwzId3X11LNGiaFF55nfNuPDXeQ+JE0SVry5U3WHFD9OTvNxUMqH1bpRmQewT+SlDLHGNg1LAUn7D8Id2/xmzNrf9+rGn49VsrSbrDCNaaG1sI/uMHh/PBM6qVQdwCxteDyXv7hp7hy5yhpfgWrlsmTeBHv5KRufe4HhXyQzmuL9uPW2F0Q0fKGJnDHX4TpKVFMP6t9HfHF/Ok8xCn8+Xpbvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQbY2GFnbVMqQ546zPufmZI+2vohwCd8QA0ZsWHyw/Y=;
 b=ESFj5rgg4O7RwcYgrirUFTGsCGKCV7GvI9rlk6S5fPHHLVUB8bjNuoULo0XU+gUvxCzx2OYCyeZe0JbXe4gfxsmvBetGuuw2g1M2af/7D5BasnH7wKtzJpJhMS/0Ziu+VLjp0PvaK4FUlYzoyseDqgW7o++rueKMv2Y8ef9GVlynKL5Ls8Qm+b8yQeUHRWDddylVhxR8idBgLfhwpf5AOmmhQ8nC8Tj97gSpWOX58fLCBsKahUpwLciGxRI1EvXeBBXB5RcBbXkDElZnjYnN64l4G4Fz/61MXiTFl3NfiWw3kAjxvfZsIojynxxa6TaJNUbduViXLiYDO1gfBwuo7w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 05:27:07 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 05:27:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 3/5] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and
 data registers
Thread-Topic: [PATCH v2 3/5] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control
 and data registers
Thread-Index: AQHdDQgWym5/OQ31s0qQLscMf3YSYg==
Date: Mon, 6 Jul 2026 05:27:07 +0000
Message-ID: <20260706052701.1141740-4-jamin_lin@aspeedtech.com>
References: <20260706052701.1141740-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260706052701.1141740-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB5897:EE_
x-ms-office365-filtering-correlation-id: f9304bc9-ffc7-47bc-3830-08dedb1f38ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: tVuOi7WL2RL5Z3FK+iNQn2vtRkHBhvcCfYiOeFu/jg/3tSF9LJa2pojWlK39TmArEm+n5NN8Yx11pA9Zqr+qVU5m5xyffQ5TXH2/+pTZnlWaR1Z7lsSMM1KDyT024uJHKVspm9aeNsZz2sAyc4ovb8B+T82l36JTOvqntmDnlRL6EkwkLOct8VcM7O6vnI1vdQ7kIhmsHLPrGsu+zZj0y2qm+1OPpONxm3H1WhmXMUjPFhdxf2yD5QOvwCCUcg2Sg35UP+4CYODcpO8bi6o0V8HInn5FJqNlwV3NJB6N5yG+hYmq7xmFtS1Os8MBnyLIK8kpnop0YYbIKuFF2BrjEbo+RTP2FoEBm1sgjYmlvF7U2yQLLk46L+NyJIc+JwTA3lqV/P6HE3LuZeMml1R2IefgwPryQ6cIhDM7NLHe2Hw4fDqPKfyoy6TCCwZaKudyRtK2y6RN1Iv6XvVU5ZGIOaUfCLRaRpx5IgPV1HaW1Y8mXbJHpOb1de87uvNwUFX0BDOHThsh6cvcGVzZPdAjDvEOV748bFq1sqV+buhdkHhKYGbCljx/VdEiy+gZZSgoV65QmhED2rjARe+u9hJZON794+kRNsIQh9Lni23GHbI12mjVPc7PjeYvJfMGppu3moaOSAk7E5Vrc1hhQ/4gYMOV+xlIPCQRdmuonVEhtjAQOLm/sT8mhz/7SVAg8v3svs2WtJ/7ocI9LRWs1PUmKmIbWoKFzwP+qiLZdg5AYe4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MsjwfwFLQOTDVlVwu8Ojr7+E9AYowo/6LwstzFosJLnf83CcuikgqBtL6z?=
 =?iso-8859-1?Q?fuMWatXRbzaVOjQvIE+lLD8z37oK1s5wmxfgDL23Jy8Vc7d7Pv1k7FfBqU?=
 =?iso-8859-1?Q?wow+jSfvRTvUrRn9t33UsRfM0l0Gqc2EhTdZmb90IEbV3uerlxMFVPHKeR?=
 =?iso-8859-1?Q?+NOqEkeHcd4hc1ypPJzjpytDvUz9dpLSTigN8vjRLKIbIne4V32GpCo9sd?=
 =?iso-8859-1?Q?JuZThEVqI60FffrqGBue7jhZFJHhLP3UQKca+jBdbi21iO0mITM1F7M9YA?=
 =?iso-8859-1?Q?+twneG17YxjdA73USVpbs1hrmbkGOxDSaZKVRk5ccJGgAH89oO4PB8ix2W?=
 =?iso-8859-1?Q?RCAEJDTTBYJum7OLPoLwpWHAnM3mg/JXZV5RYA76ASACzWLKXIJtD66320?=
 =?iso-8859-1?Q?LMArK3YwNS5GfL5zf/EalwWMLhrFWGPp88aS/HRGQHYfY0tAqnffvsPKbt?=
 =?iso-8859-1?Q?hHEKYQVkNxYusFho54cwrXff8b5y9iS6AIQvVQBDAt491geqIpfqfZebpA?=
 =?iso-8859-1?Q?5pAKrTt/b2aC32IYz0WzaeHmq0uE0Wp91r/Z3viJxc6vVFID7Gz4ZFJ/o1?=
 =?iso-8859-1?Q?u6vCXMUqbWZPP1m7Vy6hAbROxmVwEk2MVPJiKWyUfCvzCwK6V83M/9EAwg?=
 =?iso-8859-1?Q?UD75S+iip05vCqCzgzsSWIxXv1L/xk0+CM+U1vIN5XugbIqGdOp+HKI7dw?=
 =?iso-8859-1?Q?1JhYNZkWRyze58lsvoPNBPQtYN7SxXXusoxrOJk/GXOYKJ4eqGn1z3Gk3R?=
 =?iso-8859-1?Q?t79ht+jL3X2E1TMj+nfhbFesMiXk3wUBLuicBzb+dpy3s4zCbAWF9Yyu7f?=
 =?iso-8859-1?Q?AEsP8AXqZ5uOIyZojfDeoMYcw3XT3pAt6m5pY2pPLeDJLWa0TRWuoO2Dti?=
 =?iso-8859-1?Q?zmXrdUPu1lI9WIyeLYBlveCAvP/KV1BdS0PbWV21bi+1p0NNKh/ZZ7uWac?=
 =?iso-8859-1?Q?ecT6Zn2hts99QtZHzkQNyUAr+DRGu5MikbqnqIXEyKF4LeAGQo8VLPL0ZC?=
 =?iso-8859-1?Q?M30wA3YDqeI11lfEZTitIQzD4jD1xAprhAwIcfWqX92NvfvwTJC3FneYbJ?=
 =?iso-8859-1?Q?v+XWuAXqBAz/nT98Ey3oSWzoRxIQgxAgUOcF5kHrPCoQK45V7ivf+ASZM+?=
 =?iso-8859-1?Q?e8v8X/t7OcjM6Cr9rrrG94DzH5hSkDH+Lawe3q2QlSJ4Iy6JwTixQo/c3L?=
 =?iso-8859-1?Q?JUe8/j7aLhW5YZXDuxjsmv65tOPjG6/+Apv6ZvMbNuC5lyce7ueNAorOST?=
 =?iso-8859-1?Q?mPj0U1T5TNt/mD1maGPIR3BOsl/6l0NJL+1N/+P36V9LmxWWPNqr5TOnm8?=
 =?iso-8859-1?Q?PtV9NRFoL+3QtTkxQDYhZmoJp/3zU9J1RU1vsWPnRe0VUeH9AeoUZDaMqo?=
 =?iso-8859-1?Q?ywP+iC/R7/TR5xQOh1DwyUVa6Lr87ZstIOL4LrAccNMAcufcBDFKhiuGrE?=
 =?iso-8859-1?Q?lxh2cvSR2g+GZEu56t+kkbKfw+EYJqm52+a2Nqw9Ykm7eWoxU4qrrh55iJ?=
 =?iso-8859-1?Q?sv7reGy9TPuO6uA4XzZXU+jo1oBVZUWzK7NfpUqtV2ZXOjdqmBMc4XfH1I?=
 =?iso-8859-1?Q?uTaLCtlzp0zLLUQN6hHf/2/vuxH+p7ZTg4liBWQuQVhSX2S9tA8QsXVVEV?=
 =?iso-8859-1?Q?ZvMh32DTqRFfxN8Uaeg5/iuOtbBWiaX+rbr0xoJQ680nsmRqXiP+mkIZjv?=
 =?iso-8859-1?Q?/p0W10suhx/LhCZSgNasRlgXY/D4Nj0mq6/JcrJXYXRM7s6WXcZM0gfRzT?=
 =?iso-8859-1?Q?xqsbCF0c7LMrpTU53IsATo3Go2Qqw9pgHDG6qhaPlPTdSDmcN41JA5O2x8?=
 =?iso-8859-1?Q?+ise7qm30g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QN6iRXmlNPU0YRzRTggFtI85WjCNGXRpE4QvMB+1ll8GQDJky5SM/4bnk8ihxGNItjYiT/0XcraCVFWhWI/3+42FJR82Qrt2iRSQY+mFfKsads5X9Iu/9xoycFQzo1g0ZmLlhZQsHQBS8kfn4DuXcSOXQfX9EtsiVwbXK2EOXhfXI4J9Uk7P82HsCOzibJkUEUvjMD5YnKsjTSj707Vdb4iTMsTFWoXHtysTz70jli6zR7BpkjCkMI2Y7yUv6iL2x9PhztUea7gjNzkkJjEdTqYMjPKwCBTHZ7mKSdNotL3wJq/ChYA0AK4vA7K5jioKZFSIqDL8hpkoTM15MgJx+g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9304bc9-ffc7-47bc-3830-08dedb1f38ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 05:27:07.5191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SslFDfL9M7aBRIfjiYjC14YaJo66WJb3In4dCTzX1ebTv4P5mn4tHzCjStz8h/Z0lRMPi164G9I3K0KWVnKMw8IYIY/uWl83hlhqPPk7DOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5897
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Implement basic behavior for RNG_CTRL and RNG_DATA:=0A=
=0A=
- RNG_CTRL allows guest to enable/disable the RNG via the DIS bit.=0A=
  Only bits [0:3] and bit 5 are writable; other bits are masked.=0A=
- The VLD bit (bit 31) is updated by the model to reflect the RNG=0A=
  enable state, and is not writable by the guest.=0A=
- When RNG is enabled, reads from RNG_DATA return a newly generated=0A=
  random value.=0A=
- When RNG is disabled, RNG_DATA return 0.=0A=
=0A=
This provides a minimal functional model of the RNG sufficient for=0A=
software that expects readable random data without modeling full=0A=
hardware behavior.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 25 +++++++++++++++++++++++++=0A=
 1 file changed, 25 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index ed7f5e648d..5dbf81c0ce 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -160,6 +160,11 @@=0A=
 #define AST2700_SCU_CPU_SCRATCH_1   TO_REG(0x784)=0A=
 #define AST2700_SCU_VGA_SCRATCH_0   TO_REG(0x900)=0A=
 =0A=
+#define AST2700_SCUIO_RNG_CTRL          TO_REG(0xF0)=0A=
+#define AST2700_SCUIO_RNG_CTRL_MASK     0x2F=0A=
+#define AST2700_SCUIO_RNG_CTRL_DIS      BIT(0)=0A=
+#define AST2700_SCUIO_RNG_CTRL_VLD      BIT(31)=0A=
+#define AST2700_SCUIO_RNG_DATA          TO_REG(0xF4)=0A=
 #define AST2700_SCUIO_CLK_STOP_CTL_1    TO_REG(0x240)=0A=
 #define AST2700_SCUIO_CLK_STOP_CLR_1    TO_REG(0x244)=0A=
 #define AST2700_SCUIO_CLK_STOP_CTL_2    TO_REG(0x260)=0A=
@@ -954,6 +959,14 @@ static uint64_t aspeed_ast2700_scuio_read(void *opaque=
, hwaddr offset,=0A=
         return 0;=0A=
     }=0A=
 =0A=
+    switch (reg) {=0A=
+    case AST2700_SCUIO_RNG_DATA:=0A=
+        if (!(s->regs[AST2700_SCUIO_RNG_CTRL] & AST2700_SCUIO_RNG_CTRL_DIS=
)) {=0A=
+            s->regs[AST2700_SCUIO_RNG_DATA] =3D aspeed_scu_get_random();=
=0A=
+        }=0A=
+        break;=0A=
+    }=0A=
+=0A=
     trace_aspeed_ast2700_scuio_read(offset, size, s->regs[reg]);=0A=
     return s->regs[reg];=0A=
 }=0A=
@@ -977,6 +990,18 @@ static void aspeed_ast2700_scuio_write(void *opaque, h=
waddr offset,=0A=
     trace_aspeed_ast2700_scuio_write(offset, size, data);=0A=
 =0A=
     switch (reg) {=0A=
+    case AST2700_SCUIO_RNG_CTRL:=0A=
+        data &=3D AST2700_SCUIO_RNG_CTRL_MASK;=0A=
+        if (data & AST2700_SCUIO_RNG_CTRL_DIS) {=0A=
+            data &=3D ~AST2700_SCUIO_RNG_CTRL_VLD;=0A=
+            s->regs[AST2700_SCUIO_RNG_DATA] =3D 0;=0A=
+        } else {=0A=
+            s->regs[AST2700_SCUIO_RNG_DATA] =3D aspeed_scu_get_random();=
=0A=
+            data |=3D AST2700_SCUIO_RNG_CTRL_VLD;=0A=
+        }=0A=
+        s->regs[reg] =3D data;=0A=
+        updated =3D true;=0A=
+        break;=0A=
     case AST2700_SCUIO_CLK_STOP_CTL_1:=0A=
     case AST2700_SCUIO_CLK_STOP_CTL_2:=0A=
         s->regs[reg] |=3D data;=0A=
-- =0A=
2.43.0=0A=

