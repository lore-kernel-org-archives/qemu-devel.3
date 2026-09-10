Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43327C88E40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Tqb-0005Jy-8y; Wed, 09 Sep 2026 21:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4Tqa-0005Ij-02; Wed, 09 Sep 2026 21:45:04 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4TqX-0004BU-Ca; Wed, 09 Sep 2026 21:45:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3CJMMD8jOSE822W5UoR/XpAJ++5stqumbTeq5O+zGXX5kHRG69Vb2nX00yD9bvfYlYb4ZzFscq7YXUay5ySgExFNiziOjfk67gRFy0nlw/gBoie3l9wMj8OSw/qVKaczLVarlJrQGWS3rFv3A3ZvO9iQ1V2jqT/9a77VnySakMPJhxeIbtp9pAs1GZ4Jq7sTP04JCllDIKxJ1A7DThvfzzAoKyWtBM3mq/bTxCvE1aRYjv8ACwbUC3Ev3K7BgodMnbJ2UkgEMx0GL6OVS0gE+/cIoLtBr/qqiNmhfwFNNsOgtO781M79CW/ssVGvi81vGmyH/kwSZoQFx76j0quzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28SsRoigo1/hKF0GTp/2m9fz3vocQYhZJx3K6JtgnB0=;
 b=TDNW7s7ZCyK6vulTodxOHe8DV6q/NQBz8bU80lpCv62Nu+N2JsHu8qI4zYQb0Z0J8wWNvmJeR1URBa7TEnyxCtdGRV3lfXj6dGC21aqHWpiZvPLGXpZmdOTxNiEVEWYFEmiknvswBEYAtN0LByKM/V3xtvdWpsxk6tlW1+Jcc4owJrArKwrgBuvJlvu2gwTsIDKKx+CxaGc3QBvUnYAqi6G5GifE9jJOGJeRCMh7+8URUMc5F+tc+t58mKURnkAGPYaPGWZYiiYDuZ9eYSXFpN5IhjX5aFNJemsDMZAONLEqjPzLDv1V1cC/smp+fyYOE8O/AmAlMauD6hnWYOpCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28SsRoigo1/hKF0GTp/2m9fz3vocQYhZJx3K6JtgnB0=;
 b=gjWz7ra8B7/4bj3PARbjwmr9TE0b3SA5LaPVDuX2+S31m6YvTRJT6YT5E3pqg8ERJ7bXkiUzuLfEECc/+Dc3ODX+KPxoTyMAr+L9c9lR0MdRRU7X2Fj3nYiNSJXoTyavxF8PwgqjXP3HR5V7Az+yqlAIRVb9yHoNfS8FTa+aNSoo5cGhSEdjf9G1Qm5kFYj+2kr4wqgg+L9B85l5mLh2i5L2+SKQEqCk8CwvVnnbNPhkTSl4QywifWJfPww6vKjE5xx7exzhkABAWdW7Y+O/UfvxaT2Q/d6iOHheMUhQUzKz6obFjKyxzTPf/irN0eEGpFfz0JgZ89JH3AJTCU5rJg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB6829.apcprd06.prod.outlook.com (2603:1096:101:1a7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 01:44:50 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 01:44:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 2/6] hw/display/vga: Move VGA_HPEL_NEUTRAL to vga_int.h
Thread-Topic: [PATCH v2 2/6] hw/display/vga: Move VGA_HPEL_NEUTRAL to vga_int.h
Thread-Index: AQHdQMX3IQj4yt+On0uXD80QkDRTPw==
Date: Thu, 10 Sep 2026 01:44:50 +0000
Message-ID: <20260910014447.4110781-3-jamin_lin@aspeedtech.com>
References: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB6829:EE_
x-ms-office365-filtering-correlation-id: e869b722-7d12-4456-dd2f-08df0edd1a5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 2jbNtJSjWP1gYHC7TPsFE71AOVT4wUnCgnxXN0TiQTxVhJPIV+M2e6aJIpilezdO7qUnDcwWsn9rdXVZxmE9jhRm9miKxEaDRqwMCNY+6TFDdtQaQjWOn29j6dptYvvEF9yF6DeVQr/5UDZWx3xAx34IGTKEwwWbI4lU15x98Z4JhI/WuS+tW986vyfy7VrU6dn6xWy7k7jsgd+/qYZUXHYP3Yp/Vr8TFKkFkPFoxy4L0ZPAvpb5kKwnR02bFH24eGHqCuzxbGy4FkRWFZ2cuJPhLiIvW+ou0DkfgRACgBV/bW6cvW6AYARMTqv/vz0QbWcTUg7uKh98yaLkqVrJpGGkQ8H0JM/RZnYGRRrySE8SJjIVCTo6gsGbexcb2vWFY59XmE2y/eOFNDeMYOA2oqA8p0HaWnuOf15BdGHnNU+Z09MQoUc8hd+RuikFNxGyzS0XdH0lGNxCKMARHy1zdAEXkV/PzWITwwrxUMlHRs1Tgep6VJu+zeCtnurow3fd5yQxD8RFS11O2iXIqzfVtVmcLw8AiJzMwpsfhlb5gvPJIRIAtQBlwCgmN86/kzF2pF1Rfo6fMDmCwB1vhvmgYvY/9HWP07asj3LrdrxvKM9set1UKNG1EbC4jCqJrSn9zSKlDcZwMYUi69olGCdqAJFvlK6kbIjtwkH0IxUrbClBimhUOkKlQwk2JcVq0fyf3yl6f5mstToKsyKdsGhrI3vxejQRmQIytLSWXo9/W0NqLu2JTZbCJoFjTqTNFos0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/lqK/CezkhtEITjf1JhqTyTVX4uOr8EEmv1Vb9k95FFWaXGlwQow/ywCVo?=
 =?iso-8859-1?Q?Y6oJQ3ChyJcFeRK6OamOQZh6XpEvgWUQ/WqBtkUUy0eTxSONjVZkncVUch?=
 =?iso-8859-1?Q?S6NRrEEkzVs6YgHri8W3IHLmvFA0i3uhcoPkvvoOQZ80SU3OcPEXoKIpUf?=
 =?iso-8859-1?Q?LY4kyjVXHJIPbYJrJag3jg8vS+6ZocCDUv5RH7ct23cyPTZoAU5ZWB3Ff7?=
 =?iso-8859-1?Q?RIb65vTEvEVEGxVM8BPXkGUwEKEzeoHl0ldhZwSB+X15H/dJgN8hF2KtEf?=
 =?iso-8859-1?Q?k4GBWxnSJPV4tsNGDs1m5HPLpSVBkprX6/V6RQgWPPQq62GV+8eLLVJN0J?=
 =?iso-8859-1?Q?B3s8i3il24zjHXdumb482qV3vUH+ddQYyaIOteWbaw7yhJpNaWNPUOrjAV?=
 =?iso-8859-1?Q?y0cnIvvjilVxRxYViEGAnprV2O0nsTlzCh9a98pEMoMkaEdy8lceWSQLtq?=
 =?iso-8859-1?Q?dybkBv7AF1+O/lIqIiH/TTCfBfnmU/VOLLplIj+tYCyEDpjtRc3yBw7Emg?=
 =?iso-8859-1?Q?ZOUez/xPrMlHgrlvvg1ev4BCNPn3OKQRl40wLwnH7B4cqLtcKTDVfFGRg1?=
 =?iso-8859-1?Q?BcoTRgrYC26IfwJzxTcr46Ztg4ffnnKzwC5aF3YMTy5Ct0I+AiAv4ELZIw?=
 =?iso-8859-1?Q?KnKEQCC9RwiswoLy72wnwLxRsFHgxBeawnEeduzSArrTjGGuutZQ/gDdNr?=
 =?iso-8859-1?Q?NIEsNoHNd1N/rJKoQlZi+hxD0oA9Jx5X4JhOUb2CGPsOPbvfBNJZ3D7YkG?=
 =?iso-8859-1?Q?aggg1U7JjEtH0qjPKi1iqFitadtpxrhVROtGOO0ELUa3I/4usJSz1uv2hR?=
 =?iso-8859-1?Q?MsRRpqxiwXSJeks77DUtuvUwXM+wJLNI4BJe3MqhatVy+IlykwTEfFMpij?=
 =?iso-8859-1?Q?xDFlHPSvyLuepUs7mD1eiUNNNB92V1+MqrAfpiiDy0EPtKOVOS2ve8AAsH?=
 =?iso-8859-1?Q?ix0tplY92COcpFNWRsmckuxdbMLaVNIOxR6TYrQbsdm+ksSITlUDrXdjZP?=
 =?iso-8859-1?Q?OrOcVekzUfjQDr81pS16mNjD1gqYlVeqnlc0OAxP13Px2oedXvdv0L3ORl?=
 =?iso-8859-1?Q?RUs6TCU2AkE6M47ZiY4ELtuqHfs4PyhkDf+6awlpXl+hV78wXKUAXKbjqn?=
 =?iso-8859-1?Q?z1yH0MCH7maZQnZnz1e2htgZjLPkpsPXf0bVZnQeEFFxCJfACCeL0eTb0F?=
 =?iso-8859-1?Q?V9Xv2MPn+2hfuRPcQUJZSJZhapla78CM6/sTeC3/eshAklFZJeQ7PGAn4U?=
 =?iso-8859-1?Q?0bLxgoYzUPhwDGDb+QFggzclUSK1rQAC4tp0yeW29lGsdtcSMSjJggmtGI?=
 =?iso-8859-1?Q?3Z3FpcYCWIxhRmZw1hbXwQFdaSj581xtK0MIe3KbWyLwvZsk+vtd631mzV?=
 =?iso-8859-1?Q?zvNFlGXBKYtFvURw3TC0FV6dZOn8VazOZCcm/LRWHiHiTmH2Y2o41gT26Q?=
 =?iso-8859-1?Q?WhoTtD1jeJC/82V5E3LepDeC0KAz/n1yp2SsU3eg56g1RB39UXdiiYZ+8V?=
 =?iso-8859-1?Q?bZPDoVV6pF3A8gtUhKT+7MOA71jhdhx1W6LQQvzg7EVobi7dyzvN4V7mmb?=
 =?iso-8859-1?Q?Kfa/ba0j0/2bTIBL1D5URhG+9w7r/qpuNMiQIdMVAbzNdQEGpRMvyWmPdG?=
 =?iso-8859-1?Q?MbCa4uY8T3YgDo4d43glVRpeyi+KdtQXWNsLsdQiAZQ4YNVi80QpxDsiXB?=
 =?iso-8859-1?Q?NQi5cUmoNmFVvshEwaS7L2bZge4/aM8a6n9JdsD5wfLZ3fmCbGXGRNUnkO?=
 =?iso-8859-1?Q?bpgPpGba7s6UDEdxMYEkkylm3yPib/A1HHsbA6Hxo1eetTuXUS6O2pGCg/?=
 =?iso-8859-1?Q?9qyt7693eQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3GepKgRRFpbaiEmY4dfP0gLc73Cjy+V10p7VcurB8qTGpKHOApAbFfGUDdgD5BfCmJ28kqxX3/dVefrjNcSJugT5V6KpTMjFGHqeef0PRogmP94LYvnEBEZdwMbLBEkPy0SCWJc8/mAnFk+GOwRwJn4xxJPcENdpPUs5ZEDb5HoMacotJEV9Pdp9fxtA2legUB01x97YOTDiTO/Y8WmQamDNISJRH0oxWWPzQzmeFC45j3Y1vmC3r3gOzx2hQbEAs/nNomALWwqwhbOQHRt1ER1J79Rt6yFpwsZpWlGVFTeA5fahBLlwuZnA8uiuMAOAGcGsWAldFY0ciN+Ri3Ubcw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e869b722-7d12-4456-dd2f-08df0edd1a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 01:44:50.2257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJoD5VE56Yr49h+5iH9ABxjH0SKS/5b8ZgNTZFvhiGZ39We0KEsaPH+UONClZcSUxddVNHmjdJLp0GZkVppVtyhhGcaegDwIFGc/4SR+RQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6829
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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

VGA_HPEL_NEUTRAL is the pel panning value that means no shift. Move it=0A=
to the header so that other VGA devices can use it.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/display/vga_int.h | 8 ++++++++=0A=
 hw/display/vga.c     | 7 -------=0A=
 2 files changed, 8 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h=0A=
index a017ab7a99..806baa427a 100644=0A=
--- a/hw/display/vga_int.h=0A=
+++ b/hw/display/vga_int.h=0A=
@@ -38,6 +38,14 @@=0A=
 #define CH_ATTR_SIZE (160 * 100)=0A=
 #define VGA_MAX_HEIGHT 2048=0A=
 =0A=
+/*=0A=
+ * This value corresponds to a shift of zero pixels=0A=
+ * in 9-dot text mode.  In other modes, bit 3 is undefined;=0A=
+ * we just ignore it, so that 8 corresponds to zero pixels=0A=
+ * in all modes.=0A=
+ */=0A=
+#define VGA_HPEL_NEUTRAL 8=0A=
+=0A=
 struct vga_precise_retrace {=0A=
     int64_t ticks_per_char;=0A=
     int64_t total_chars;=0A=
diff --git a/hw/display/vga.c b/hw/display/vga.c=0A=
index 1d96308060..ab06fb3c13 100644=0A=
--- a/hw/display/vga.c=0A=
+++ b/hw/display/vga.c=0A=
@@ -53,13 +53,6 @@ bool have_vga =3D true;=0A=
 /* Address mask for non-VESA modes.  */=0A=
 #define VGA_VRAM_SIZE                   (256 * KiB)=0A=
 =0A=
-/* This value corresponds to a shift of zero pixels=0A=
- * in 9-dot text mode.  In other modes, bit 3 is undefined;=0A=
- * we just ignore it, so that 8 corresponds to zero pixels=0A=
- * in all modes.=0A=
- */=0A=
-#define VGA_HPEL_NEUTRAL		8=0A=
-=0A=
 /*=0A=
  * Video Graphics Array (VGA)=0A=
  *=0A=
-- =0A=
2.53.0=0A=

