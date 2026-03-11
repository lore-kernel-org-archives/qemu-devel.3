Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A506FD0648
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Dxo-00031I-23; Wed, 11 Mar 2026 03:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxh-0002ye-1C; Wed, 11 Mar 2026 03:26:34 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxe-00052x-MY; Wed, 11 Mar 2026 03:26:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCn72zGoMTQTJ5XlsiGOXbxxUfzCBlOTzcufbcf4Prsqh7+k3mXuolJvVtASQNssXQStE+HoTJWFQcQRckCsYU5+PtteO+ijFvNrW+q1HShlNhJodXKATx86S7UcBaTklIe2wXZcX5f3y64CZmdvIimewArOYLIE4CyMJjIgSt9Jfaf8Mi6+Bqk6SSNfHu2H9AyYaN1+1EL9nKfsLpCZdxSjikx2XXV2rDFyR+YoFiffbVWQQS3YeAK9pFSU3+/rkJWYYv+gvypgHrr2bbvs2XpcUE32Ts8wFewy1kuWWycU390ubdcMX0TLE+7dCnJzZAzfxpsHMTpwT+SavGsSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzuNxlXpK7egm9C3kqoDfA7vSEUNHuUtUm12GbVMeu4=;
 b=gPSH/kb4vFKNsaic4FkiuL2d9ZrcJGjkRrzAvgdrBJVy+hwPvzekkQdsvZ1JRyeaKgBpezMnTw2ptLzz8jyd4iMIZyAkYK+t7cYPCBaLOxq8h2lIpPK1r3dDE+/TJ/WsVKVNomFXJ4pUfF+x8GOz0013nf7jmtsEnroaWxW425cP2sPuwT358Ip/cpkdfYgoQewI/22xK/xecMB9k9xNOPrbnHJ7HPhQPKqrlA5XJVha+rBfLnHZ0fAXT2p/C25o4rgSQq2Z906B6nD9xvdcwBNibWdg7E5TVF0ZupDWfGDS3I3pzcNvSp4A03HAtg4SCJAMWm7uddwTtJ0DuZx3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzuNxlXpK7egm9C3kqoDfA7vSEUNHuUtUm12GbVMeu4=;
 b=R4SGYTINHhY4gdxHZtS8CV/kJbRVfqyFEOo0fMUworHqK+fX/8U5+eegUsTb5LwT6bhQ6j7sXzQPLGtIssPhPlUulnOnrKkRDJmb8s0q5vdrFo+KZ8NlqOaC2HlRFi/PgNmqNNUxE6xLoB6ZVb9BxpTs6XMub9QsR9PUuXPxH24BoC4blZ0bzQUiYa40ougiNOt6OBovgjhbgkTj8ltJpCaf9nndJSpfnv3vFt4JGTmFDAA4krzjNDawovVUauOFaZuO99v7x27YK3Fd0ItWnsT8WJKoj0eDjbcmRIxqeT5KEvXIcWtG8R0lHe+n3VV3ygUx1rokdoAwnGvXl+hWbQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE2PPFD6A65AC07.apcprd06.prod.outlook.com (2603:1096:108:1::7ee)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Wed, 11 Mar
 2026 07:26:17 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 01/13] hw/usb/hcd-ehci.h: Fix coding style issues reported
 by checkpatch
Thread-Topic: [PATCH v1 01/13] hw/usb/hcd-ehci.h: Fix coding style issues
 reported by checkpatch
Thread-Index: AQHcsShZVfaF3zHIYUW09f4rE3nREg==
Date: Wed, 11 Mar 2026 07:26:17 +0000
Message-ID: <20260311072614.1095587-2-jamin_lin@aspeedtech.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE2PPFD6A65AC07:EE_
x-ms-office365-filtering-correlation-id: a8b80a7b-eb7e-4cae-5c62-08de7f3f7bfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 9fKDyFdIA9IAXDSHiW6tpdJOhs0Y0kK8kRd/skte5Y8/QiPi9R+gjdp7Na9tYwFkpHFOJZcdw0UlQK+IJQqNcws0l+kxO/n/3yfCRScr2svWmDk6jSVj9W0rutKXdJjoWt3MS5wxU4Y16rb5iCz8tYJ8Q3HJs1dDcJ2EMuAn0GyNPP36Av9zzepgXJqs1bAyykvNtVkKZK0AnyPDStsGTwLOajf4qq6L+2JdE2dNGT5+Fkn1znoa/bCZI3VpU//FEJIYaLcWeniD+J4yg9d578v16GjMZeFsc2O7UqpU0IrK8LQmRAOhdjmyv7foUErkyb8gdE4nJGi3kyqA5i7pNaIcWyYAsCC9fnH/NNmP7tpjbqIoVIekEGNUQ6JbUVGguyP1wjSw/AYpByRjIicV0L7/9RgCAF7rydPTcIfPIcexER6uBUnZs5wMRWyJzFdkOuHrahhA6RYL2QSqkAgbYpl23St69/g9/ppvrWHyAqxgC6FV1+Tklzv+e6CKzD4eCJGfjmPxX/JTuQjLKI4XJt2YilLWgUtM407K0QuK/FgboGpLjM3VN6xUtQzmRI1o9q3A8s82e1J0MlevCqNS7DHOSoQGOCHa+/4KtMRyyY6mXLzVGoBR94VdHGvYdSiVS5J4JIjycrb0fxohVU0g3UHeTuN+268BOitxk+z9OPIFMPd8XkGB8hAn/eFN3vf1V7UbCMOypDnskNmhoJo4bI6RB0Y4KLvWQTf2IDbzlzR63JBE+DmqLJ/4TGncl2L2le8k6ChX6qJl3bd2u1+QTFSzHkaWmNGpeZQH+zjzFfU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tDqM1hPMv6xEF2xsIsaRYH+VSOZFap+jwKN67gn6ZEsst/llF8rYxIpGMO?=
 =?iso-8859-1?Q?irxu5Cl3bZYkfAEELH7FEsO+2SzEFrAa33PNi9swns2edNiX/rqUhw2O1n?=
 =?iso-8859-1?Q?2arkwhnyU+IGtj1pqpMZe2+LLwu731Wbv0B2JsIGrdUb2eCmNp0RSlR+tx?=
 =?iso-8859-1?Q?72IiFfBvuucUs+ucQLbyG8uYSRHO3SpwS/ah2rgsQFdpAbeAA5l+NQg2ro?=
 =?iso-8859-1?Q?YGDqho5H7acCdeP9glxD55w1iEn0PfZh6fS0kDcwtDwnqPWuBFhhGPfpV0?=
 =?iso-8859-1?Q?ZXcL6EWriLLhHtCZRiqEgVYMhRESkQTnaBoU6mcYJiyzOqEN7QEYlz08Rp?=
 =?iso-8859-1?Q?ALdqka69MASCfjyaWq+tmARpkb51aK3g/kTGHqzZLv7bwgY8hi9WsW/D2t?=
 =?iso-8859-1?Q?YM2itx6WMp/SDF4BrLxfkoQtOHHgig150YW+smSMMyMHuDIGKVRcGzN235?=
 =?iso-8859-1?Q?L9hXr+oM1fDJEBxG6byk+SxlA0/nBRUc4uI4tvpI1vdegSF4Lw0qcwTv3e?=
 =?iso-8859-1?Q?S7DGGxR62sFdFxkCye8bIU5qVybXK3vEJSnNZXpcs3Q7KVBYXrBf4kRTU2?=
 =?iso-8859-1?Q?/vFcuOYv72xS0S6pXWmMiQ57bKLbfjitshuwxNHYRzyWZthiCTOjrEkAz/?=
 =?iso-8859-1?Q?mWWXC7JJ2NbHwcX5TERfEYVsWY2S0OHUXhhJF4DtYA8e5mQrKRR4ss2lE9?=
 =?iso-8859-1?Q?6KrsBGE9k0crWejRakjDFBeLP6orn5Nj3QnT/Ih1IVQOkK6kw9Ci/SJMdO?=
 =?iso-8859-1?Q?fiFKu9fIU/Q6a/EDgXzbm00RsJudC9NHHTxnuA7hOPWoy1iP9zJRfE9X/w?=
 =?iso-8859-1?Q?Z19mHGC+QEqHxFS7yQREXPHcZZY+pKvJ5wllb3/d0HSdxB2UdSub2cQe1B?=
 =?iso-8859-1?Q?FDVRKGHXpN6Snrg9ihmYWIZLfhsrtJoPqycAhXc+a1RjwoEzdY4S0XhrMa?=
 =?iso-8859-1?Q?XoP19sizmHl6LnBR6xq5kSUxQt8GitvS2qv2Oic4IQfaxwAPQUUpGRvd8Z?=
 =?iso-8859-1?Q?NVA0vLqGhnA/ci1XzSYbsU3p304LlYYlastS+kGDxG0IC/A1SB+yByJDx7?=
 =?iso-8859-1?Q?hV+eGA3VORda92Fnhn4G8+iltKDWXclvPAhfe9A/VvhyL7+Wr4V3N8VkE9?=
 =?iso-8859-1?Q?FSiJvFyyfqf1AbwC8x6gqYpJuJZNYM8KcvkCpicW60xfNjpv7NncpS/Kdw?=
 =?iso-8859-1?Q?wLhg23EoisQBeEL0PlDp+Cqn53WksaauTgkFovkuKS5t2v9XAdYrppfxdz?=
 =?iso-8859-1?Q?NNHtGyKeNucmSsIR7UewDVROUk9shg6eHZSxjgBJflVyUzS7rYvKlfRYFJ?=
 =?iso-8859-1?Q?Tz2IvR00URJKlqrtdIC9ODaUnGURMNKHx3GFjQZH3l3yXnAxQdGa5B4qqr?=
 =?iso-8859-1?Q?siS7PhvfnDr7Av1lhvLTGD5fc5kyT9RB5XS9gxga4wCaHQ/e89a4niJCaO?=
 =?iso-8859-1?Q?qpvabDriT4wW+62l6griI5qHe481FTV9Sm3jWPpo/DnT4Yv5sT+Kx9RNof?=
 =?iso-8859-1?Q?aje8NDyTA+gNX06O+DTADCgAQ154M08gP2UufI9/cDg6iAPunFfr+/jKDP?=
 =?iso-8859-1?Q?w62RogckdplhR2DDpI3mdv8up2F2oiuC6E1LPjSN5hfFnSUW9FFGhmvzFP?=
 =?iso-8859-1?Q?QPHgh7/NmU6s32K52jPlLe3de7NARC+XKV9+AejmLMtHUR0v5xZU3v6wp1?=
 =?iso-8859-1?Q?t+lywosxE4kPxvnByhJq0mhw0n5hhcU/V0s28W8Wy2fOlImzGucMG0pJLM?=
 =?iso-8859-1?Q?TvDQQAEkfkeqcgkQaCry337SULVbGDjL5BiNCiu4mm8cBpHWs9jwLtPCiI?=
 =?iso-8859-1?Q?UsxqceIPnA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gUKrmbswI/vl1LJLKrRfkUbVdunb4Mpe8VWaCoBnkwRf+qxq/0xyuOCXyaQkVm9rtuwZPIk9oKlRcpgysqABBA5Fmi9rKgwRyRglrzah9mkUc+G0hVPREA1yzB0LPFG58cfvcOsUKlkkJqQt91jMcm2kSIWR7tO3Fn5xlujcI3mKe9+9DzQrLGv2UqYZaRDUOZz0Qj81UzUzSS0qLyPwzia8kPZ0xFzstsTr98LaOikFv0bt7InxR7R50PTqg3ZT/bYocME3GMl1z5rW5OGgf2z+yCje9oW3FznOuHm3YBLeAm8l6o5HETwhHmj87/12QBn6ZYq1Ha/culCMCrCBMQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b80a7b-eb7e-4cae-5c62-08de7f3f7bfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:17.2656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YgF0l848ncSng296AYGq0BY3ERJsDuLmHfYGYD3mr8DPltGDdAkAr4JP67VQZRYtZVn41nnmFt0te4sKWPItQJVn/OIpLSSaB1hpqCFfy7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD6A65AC07
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 20 +++++++++++++-------=0A=
 1 file changed, 13 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 0ae8c06331..ed44935302 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -43,7 +43,8 @@ typedef struct EHCIPacket EHCIPacket;=0A=
 typedef struct EHCIQueue EHCIQueue;=0A=
 typedef struct EHCIState EHCIState;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.3=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.3=0A=
  */=0A=
 typedef struct EHCIitd {=0A=
     uint32_t next;=0A=
@@ -74,7 +75,8 @@ typedef struct EHCIitd {=0A=
 #define ITD_BUFPTR_MULT_SH       0=0A=
 } EHCIitd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.4=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.4=0A=
  */=0A=
 typedef struct EHCIsitd {=0A=
     uint32_t next;                  /* Standard next link pointer */=0A=
@@ -118,7 +120,8 @@ typedef struct EHCIsitd {=0A=
     uint32_t backptr;                 /* Standard next link pointer */=0A=
 } EHCIsitd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.5=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.5=0A=
  */=0A=
 typedef struct EHCIqtd {=0A=
     uint32_t next;                    /* Standard next link pointer */=0A=
@@ -148,7 +151,8 @@ typedef struct EHCIqtd {=0A=
 #define QTD_BUFPTR_SH                 12=0A=
 } EHCIqtd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.6=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.6=0A=
  */=0A=
 typedef struct EHCIqh {=0A=
     uint32_t next;                    /* Standard next link pointer */=0A=
@@ -202,7 +206,8 @@ typedef struct EHCIqh {=0A=
 #define BUFPTR_SBYTES_SH              5=0A=
 } EHCIqh;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.7=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.7=0A=
  */=0A=
 typedef struct EHCIfstn {=0A=
     uint32_t next;                    /* Standard next link pointer */=0A=
@@ -237,7 +242,8 @@ struct EHCIQueue {=0A=
     int async;=0A=
     int transact_ctr;=0A=
 =0A=
-    /* cached data from guest - needs to be flushed=0A=
+    /*=0A=
+     * cached data from guest - needs to be flushed=0A=
      * when guest removes an entry (doorbell, handshake sequence)=0A=
      */=0A=
     EHCIqh qh;             /* copy of current QH (being worked on) */=0A=
@@ -275,7 +281,7 @@ struct EHCIState {=0A=
      */=0A=
     uint8_t caps[CAPA_SIZE];=0A=
     union {=0A=
-        uint32_t opreg[0x44/sizeof(uint32_t)];=0A=
+        uint32_t opreg[0x44 / sizeof(uint32_t)];=0A=
         struct {=0A=
             uint32_t usbcmd;=0A=
             uint32_t usbsts;=0A=
-- =0A=
2.43.0=0A=

