Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE7EC4450B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNP-00037O-Qz; Tue, 14 Jul 2026 23:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqND-00035R-QA; Tue, 14 Jul 2026 23:33:30 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNB-0000oW-P9; Tue, 14 Jul 2026 23:33:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rztpcfRgVkfiNoAxSlNkuirOCdkWZ1rqS1/LSrWOIywvYMDufAc1qe8SrrXiMMuZKCgvZibodzOKa4+tC/0Ig57cr4oaSXvNGbom9GbPqR2Gh9cYd2M1z0bfOfVF6dYON+jz9fs0+xXzBhW7dGXLkcW5cAOKQVUO2Jgsgh0/zHKH7rrU5jMo7K1gpqnQ67HioDW+UzCwZevNyDNCcXy3/PuUXIIyTCi6ZXCMwG7A10BI60sevGrYEfVPyn/YTETjbUkj80alJVhtnLlxVoFopBrjLI3nRN7z1x5uaZG0rm7bmxs5XljdvshCYS3vc/UINthZlvJzB0DGo1vouN67/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfVut8DhBqhTxVFkkwDFLiB3qrYeFJYvzvXuePTgfdY=;
 b=fXJ//F5JkmW5Mb5seVqqEPoFLOxRca7EKfW1kGsPVcfoHRukutUE0uMnVlL09BV5i8dN8AtRaFIzypRchtQ2JAJkdHPV6FCabDEtwlSBLdv0X39TROOoV28zem4VvIqH8mRJSfKJcpKEXZTDpW0NdB2VbGR313hhqKxiwoZieAytT1QztY5N6QCStjrL1ACjr/b6e6Ylp7JXOpsIt25FNYCfPC0S5jhAvhtBPgOalyFDdqodYKXGAbmr+UzSMnbe7K4mJR+hTMO8ivAjw2w2YadOwxJUyfdD2qCPSQyjgu/I+NhB+zx87QMtg116Jj35pYWSb4ldpWBda2Q1IcOgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfVut8DhBqhTxVFkkwDFLiB3qrYeFJYvzvXuePTgfdY=;
 b=a19gXHKctLyKGo4TDKBaRkjnW3ENIDHG/FtO2nh0PGTVrnNhPvzeTWPzv6t9WZYjTUy0r6+TC/tXginZIMH66Hs0zhU3uw5TcT6XZ5RWshgHU58GdV0seuLsQ6T9OPdoBFUEnFMK9QiOZOCl+DWvyXnYug6aQSqs2FmhnxueZvIdd42A10EPqj+OR5vS20arVBGzCnLgxmojdTszEm5i06/MNa39Ujs72GZp3zW249Ck4Dx7lG89XEddP7qGWVPaOcIcB+k8VPrRZTtrq27O4FOpeQ2FtWB+9F++uTiO5CoOfXicvBkHMt+i5rPQNlVzJvOE0/kKiiCY5TJzmP/gHg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:14 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 01/17] hw/misc/aspeed_hace: Support the crypto command in
 direct access mode
Thread-Topic: [PATCH v2 01/17] hw/misc/aspeed_hace: Support the crypto command
 in direct access mode
Thread-Index: AQHdFAqrltXLJE5RlUerH8FfKXx9/w==
Date: Wed, 15 Jul 2026 03:33:14 +0000
Message-ID: <20260715033311.1648424-2-jamin_lin@aspeedtech.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY0PR06MB5258:EE_
x-ms-office365-filtering-correlation-id: 56a814b5-6db9-4708-6144-08dee221cdd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|6133799003|22082099003|18002099003|3023799007|38070700021|921020;
x-microsoft-antispam-message-info: 2blyJ45woRO39i43sb5LEg13d60Y7Dh6U1VSib4Doyvqu+Oeym5FU3mij6DMvx+qbfw2Q4UmQQgIBDBzNTisV14fk2110v93ne811XPVEnBg4HhZj6a+chfGfLelOWAazEwUDfufkhI/zwVYerSgbVD4dJSrA7eLGyHxca5Q20zCY2WzEZf5igscUtzTxhDQuy8bkbNCTPQ7yMPPnMu9yILSMLSnJGkRuGNcTsFbke5EAvgGkLLwJdq8Y4YWxbm7Y6qMzDk1AZyeBuJE+KRuQWIPBSiazQ9t5XI/uhjiD2ze7GLHfxx8JSvGOz9GoOxvumh6vBBlSbi+2+X1gZhOo7d7K3ngyGPC3SV9Uh3F/CcxSP6fnSfLoQcsx4GvaJ6dYsG06u+j5x8aTHEnb8gqoBIVQQd46k7ho1BQ4xED6IhEp9Q9yiBK56kOHUcHy4Yq/wGeINlLNzlrXYPFSS1It0fCahB1evjTFJyRaK7x64bn7/jJ7zJcVTd5AOPSdaYKPsBvk4O70XRfrI0kUaADxacEd7Ga0miBKFw0C69/oOOtM99NuQzH08eSoA/3eRDdxlnFwqn3r7fm4kQ/TU1dVdeoLGEc4/OoSLciNWNEWkk0z1T5+Onj/y49VDq2B/YlGyDaHjbjNvGqTyHj50JVIP5+TVoH5QfOIGsgvJYYO3ZSFK9kl5yOQiztqnILFJtptrUYziBwuF9XWInnffOVbV6y5lLhVGqUaB6ecsR5m27nUMPJg429Wg9kRtaY0eN5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FG+nXCQ3Fzss88a7eeJSIySw8vDI0fIj9Ek64iX3zmx/zRGfnMc6LkClcV?=
 =?iso-8859-1?Q?DrrK5A95uk2cry2pp6GMI5JTKWY8v8zS98ejE2I1sGt6wJrUNblhkj93ZE?=
 =?iso-8859-1?Q?dbecTFB/l4Jhnk7CgZoJYAP7Ia3ufjjDiqKVa60l/fYi+sJ5n691a9BbyM?=
 =?iso-8859-1?Q?lHAw6/2EpXPhI9WpN1bu9o9Gf6zYVMf+nK5hu3oS6+Sy1/Ciooh/VAyB5k?=
 =?iso-8859-1?Q?QEGROap4FRTDu0ahO846Q2EjJQaEQ1XOSMU9WaBPLQgmeqW1mzDO65kcCQ?=
 =?iso-8859-1?Q?EZqpzxALAgkRRnvuqOmaz3+08fVV+Tnvmq/1mdlFpZfiwAMRmsyeNx78eG?=
 =?iso-8859-1?Q?D55ENwn5v/Zgh1WXB/CHT1J4WsdO+PM/xMF5Ve4SupJk7ikehMxMhMOU8i?=
 =?iso-8859-1?Q?VeSkbjxf58AGw/iYDQEq6jWk1ojaeIQwwWrgzG4spGpM3huYwuUpxOslbP?=
 =?iso-8859-1?Q?rc4ESEHtOlJRdX0JOu0qcmtU8LxUoqzNCECQvE5ZwCYXpiZwv1u08uRpqM?=
 =?iso-8859-1?Q?4c//xRlhdLJi/MnW3KRhg5VHaXVchBVJiIfgqnxIXHxw/ys2KSK07PjoXO?=
 =?iso-8859-1?Q?hS0DBe3s/vO/N6AJrO8fO0mPqibf3Z45CjwQpy9cfghlT5PdmH26lDLxT9?=
 =?iso-8859-1?Q?xzSmYA9p5CO2r+OFMPYwhvaVdpW094XOPIoAbhJ9843GNlJqlrDIiAzDzH?=
 =?iso-8859-1?Q?VLzKvoi9grszLjt99KSCtEFvEXi2i9HFql3I1urr6UVCXTAQaEE6L5uGLL?=
 =?iso-8859-1?Q?eJEaldsE3tcxPhqdIj7VUz/f4/Iwl/Q3HEhwZ5ysnnutVZjqCxFbLud8Dj?=
 =?iso-8859-1?Q?1Pq51wFMAx6NSFZqIUXU25iZj9vMTilivuLBNv4+gkxrL2cbJeHDTYLvZU?=
 =?iso-8859-1?Q?UGCBV8KJym1UZTMkrX7prQTs4YMQ7EX/CVwqwtMijHcw6OPTuvB/ZTAc8d?=
 =?iso-8859-1?Q?4AVanzh3c+mQoS+sOmUjnOw3et6CPA+EbSqMWvtkQgAt0MVhHfV1YyAvkX?=
 =?iso-8859-1?Q?T4/UCDlXBsD+lJ9IIwV+3fuj4En3cp7ABZ1E2rrqHWIY9IZlU/YY6J7QbR?=
 =?iso-8859-1?Q?bkzi7d2R/v90PjH71o5tInFK9bvInOiargcvzFOkL1Ah5vJ00JvnorZD0B?=
 =?iso-8859-1?Q?7lTl/DGR+NmlEAGYFpXLgdtmBXQ1pIssnLQc4ChB6RVK34PV1j50OZskl1?=
 =?iso-8859-1?Q?ssXXss5S9VtCCpOb8VsVvG54UYLRBWSp6MkNtZSqsDBgkXakhVA1VqEYEE?=
 =?iso-8859-1?Q?X1gQenjDxD1EyCzmKqOgh+rTkxiKQhVqWE6+7N8uuGOF+M+DaVAd2k/m5j?=
 =?iso-8859-1?Q?NedarvezL6zFfCBf2ShldRMxJ7XmlI2drKS12Z282E/R142Nmt4o63g+Wo?=
 =?iso-8859-1?Q?GQNsfNyI3QWLVohjoLFIPh4F0OptKJHingivoCFIeBPDespdRcVErlfOHz?=
 =?iso-8859-1?Q?APXGHJpKCy7GvWeJDuf/m2xNJMdxesdLt+AEQMkc36pNW7No0FHC9ubnFI?=
 =?iso-8859-1?Q?c2GBRwdTtnGUCFXQLYS1Nwf/QNu1O1ipuQnsnzDu9fJRx/qhIPSCZPEG78?=
 =?iso-8859-1?Q?A1mDVmziFNfZG/joPB9RkN+TyZEiRISef3X68q4BRetpUgLA4G3lLSUSe6?=
 =?iso-8859-1?Q?fbHyZQjWD7ktPKKstc5QMXgTZvqaWbI7SKBCfcNF3uZmpbV93FxAChPFaJ?=
 =?iso-8859-1?Q?rIezwh7RBaeYB5uAaBIjIiaIA1YaxbDVS/DNvy8w+6hvpBuXD9Zc4wiejE?=
 =?iso-8859-1?Q?/8xfN+3gIsUhn6T8x5Hv37a5qKdJyq4ng7pvDO55JVhhC4Lng07KYCaEza?=
 =?iso-8859-1?Q?hwTRe7ZM9g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RjxZLkE7fldfoM1mVcLXKFbJ0vbph0HxLmWHuFYWDS6kiE788cDC6XjXi6PEOKOoyNNLrfpFp3+SSDzrOvJPNCpdxAccukqINbSuwIYq31DV8AE9OyoKbxpFzf1LeSdP5eOHHzerOl66Nz/h4q2Oz40nt3WDIyiSfBj0/wGqMtu0BCevTknQxuS5WPXi8kT9qtJGP2/D5kEDhdlfQs4VO+1I+e2RCkm7o5daQdNJJxNx2cLsnMdrmQFRqjPepl7czi8mau4lZou6CMMLuq6PlvoZxU6zPiq8d9ouxhUqLAX+/7Ndqrt69Aur/gnNQP9ljoKepON8SjFPmk2EdOfc2g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a814b5-6db9-4708-6144-08dee221cdd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:14.8005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trZjG1n0cOZlaOwJeN6oPE75WNqq0Tj/XTHfvNqYVci3ivHPhr4GnvW0GlQNAIIDvCBzOSmErH4LD9h0BGDzRm+ll/TQE0m9taSUuxLNYX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5258
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

The crypt command register was previously stubbed out. Implement it for=0A=
the direct access mode, where HACE00/HACE04 point directly at contiguous=0A=
source and destination buffers. AES-128/192/256, DES and 3DES are=0A=
supported in ECB and CBC modes via the qcrypto cipher API; the IV and=0A=
key are read from the context buffer (HACE08) and, for CBC, the=0A=
resulting chaining IV is written back to the context.=0A=
=0A=
The completion interrupt is now raised for every HACE variant as the=0A=
hardware does, which fixes the crypt command hang on the AST2500, AST2600=
=0A=
and AST1030. The AST2700 crypto engine still needs 64-bit DMA and=0A=
AES-GCM, which are added later, so it keeps its temporary interrupt-only=0A=
workaround until then.=0A=
=0A=
For debugging, the context, source and destination buffers are dumped=0A=
through the existing aspeed_hace_hexdump trace event (disabled by=0A=
default). CTR mode, scatter-gather mode and AES-GCM are added separately.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 283 +++++++++++++++++++++++++++++++++++++++---=0A=
 1 file changed, 269 insertions(+), 14 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index c61efe50c4..de4399f322 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -18,11 +18,44 @@=0A=
 #include "qapi/error.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "crypto/hash.h"=0A=
+#include "crypto/cipher.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/core/irq.h"=0A=
 #include "trace.h"=0A=
 =0A=
-#define R_CRYPT_CMD     (0x10 / 4)=0A=
+/* Crypto engine registers */=0A=
+#define R_CRYPT_SRC         (0x00 / 4)=0A=
+#define R_CRYPT_DEST        (0x04 / 4)=0A=
+#define R_CRYPT_CONTEXT     (0x08 / 4)=0A=
+#define R_CRYPT_DATA_LEN    (0x0c / 4)=0A=
+/* HACE0C[27:0] holds the crypto data length */=0A=
+#define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF=0A=
+#define R_CRYPT_CMD         (0x10 / 4)=0A=
+/* Crypto engine command register (HACE10) bits */=0A=
+#define  CRYPT_CMD_ENCRYPT          BIT(7)=0A=
+#define  CRYPT_CMD_ISR_EN           BIT(12)=0A=
+#define  CRYPT_CMD_DES_SELECT       BIT(16)=0A=
+#define  CRYPT_CMD_TRIPLE_DES       BIT(17)=0A=
+#define  CRYPT_CMD_SRC_SG_CTRL      BIT(18)=0A=
+#define  CRYPT_CMD_DST_SG_CTRL      BIT(19)=0A=
+/* Operation mode HACE10[6:4] */=0A=
+#define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)=0A=
+#define  CRYPT_CMD_ECB              (0x0 << 4)=0A=
+#define  CRYPT_CMD_CBC              (0x1 << 4)=0A=
+/* AES key length HACE10[3:2] */=0A=
+#define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)=0A=
+#define  CRYPT_CMD_AES256           (0x2 << 2)=0A=
+#define  CRYPT_CMD_AES192           (0x1 << 2)=0A=
+#define  CRYPT_CMD_AES128           (0x0 << 2)=0A=
+=0A=
+/*=0A=
+ * Crypto context buffer layout (HACE08). The IV is at the start of the bu=
ffer=0A=
+ * (DES places its 8 byte IV at offset 8) and the cipher key at offset 0x1=
0.=0A=
+ */=0A=
+#define CRYPT_CTX_IV_OFFSET         0x00=0A=
+#define CRYPT_CTX_DES_IV_OFFSET     0x08=0A=
+#define CRYPT_CTX_KEY_OFFSET        0x10=0A=
+#define CRYPT_CTX_SIZE              0x30=0A=
 =0A=
 #define R_STATUS        (0x1c / 4)=0A=
 #define HASH_IRQ        BIT(9)=0A=
@@ -501,6 +534,216 @@ static void do_hash_operation(AspeedHACEState *s, int=
 algo, bool sg_mode,=0A=
     }=0A=
 }=0A=
 =0A=
+static bool crypt_aes_alg(uint32_t cmd, QCryptoCipherAlgo *alg, size_t *ke=
ylen)=0A=
+{=0A=
+    switch (cmd & CRYPT_CMD_AES_KEY_LEN_MASK) {=0A=
+    case CRYPT_CMD_AES128:=0A=
+        *alg =3D QCRYPTO_CIPHER_ALGO_AES_128;=0A=
+        *keylen =3D 16;=0A=
+        break;=0A=
+    case CRYPT_CMD_AES192:=0A=
+        *alg =3D QCRYPTO_CIPHER_ALGO_AES_192;=0A=
+        *keylen =3D 24;=0A=
+        break;=0A=
+    case CRYPT_CMD_AES256:=0A=
+        *alg =3D QCRYPTO_CIPHER_ALGO_AES_256;=0A=
+        *keylen =3D 32;=0A=
+        break;=0A=
+    default:=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Decode the crypto command register into a libqcrypto algorithm/mode pai=
r=0A=
+ * and the block/IV geometry. Returns false for unsupported selections.=0A=
+ */=0A=
+static bool crypt_decode_cmd(uint32_t cmd, QCryptoCipherAlgo *alg,=0A=
+                             QCryptoCipherMode *mode, size_t *keylen,=0A=
+                             size_t *blocklen, size_t *iv_offset)=0A=
+{=0A=
+    if (cmd & CRYPT_CMD_DES_SELECT) {=0A=
+        *blocklen =3D 8;=0A=
+        *iv_offset =3D CRYPT_CTX_DES_IV_OFFSET;=0A=
+        if (cmd & CRYPT_CMD_TRIPLE_DES) {=0A=
+            *alg =3D QCRYPTO_CIPHER_ALGO_3DES;=0A=
+            *keylen =3D 24;=0A=
+        } else {=0A=
+            *alg =3D QCRYPTO_CIPHER_ALGO_DES;=0A=
+            *keylen =3D 8;=0A=
+        }=0A=
+    } else {=0A=
+        *blocklen =3D 16;=0A=
+        *iv_offset =3D CRYPT_CTX_IV_OFFSET;=0A=
+        if (!crypt_aes_alg(cmd, alg, keylen)) {=0A=
+            return false;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    switch (cmd & CRYPT_CMD_OP_MODE_MASK) {=0A=
+    case CRYPT_CMD_ECB:=0A=
+        *mode =3D QCRYPTO_CIPHER_MODE_ECB;=0A=
+        break;=0A=
+    case CRYPT_CMD_CBC:=0A=
+        *mode =3D QCRYPTO_CIPHER_MODE_CBC;=0A=
+        break;=0A=
+    default:=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Direct access mode: the source/destination register (HACE00/HACE04) poi=
nts=0A=
+ * at a single contiguous buffer in DRAM. Copy @len bytes between it and t=
he=0A=
+ * bounce buffer @buf; when @to_dram is true @buf is written out, otherwis=
e it=0A=
+ * is read in. Returns true on success.=0A=
+ */=0A=
+static bool crypt_prepare_direct(AspeedHACEState *s, uint64_t addr,=0A=
+                                 uint8_t *buf, uint32_t len, bool to_dram)=
=0A=
+{=0A=
+    return !address_space_rw(&s->dram_as, addr, MEMTXATTRS_UNSPECIFIED,=0A=
+                             buf, len, to_dram);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Perform an AES/DES/3DES ECB/CBC operation in direct access mode: the so=
urce=0A=
+ * and destination are single contiguous buffers (HACE00/HACE04) and the I=
V/key=0A=
+ * come from the context buffer (HACE08). For CBC the resulting chaining I=
V is=0A=
+ * written back to the context buffer so the driver can continue the chain=
.=0A=
+ */=0A=
+static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)=0A=
+{=0A=
+    uint32_t len =3D s->regs[R_CRYPT_DATA_LEN];=0A=
+    bool encrypt =3D cmd & CRYPT_CMD_ENCRYPT;=0A=
+    g_autoptr(QCryptoCipher) cipher =3D NULL;=0A=
+    g_autofree uint8_t *src_buf =3D NULL;=0A=
+    g_autofree uint8_t *dst_buf =3D NULL;=0A=
+    uint8_t ctx[CRYPT_CTX_SIZE];=0A=
+    Error *local_err =3D NULL;=0A=
+    QCryptoCipherMode mode;=0A=
+    QCryptoCipherAlgo alg;=0A=
+    const uint8_t *next_iv;=0A=
+    uint64_t ctx_addr;=0A=
+    uint64_t src_addr;=0A=
+    uint64_t dst_addr;=0A=
+    size_t iv_offset;=0A=
+    size_t blocklen;=0A=
+    size_t keylen;=0A=
+=0A=
+    if (len =3D=3D 0) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (!crypt_decode_cmd(cmd, &alg, &mode, &keylen, &blocklen, &iv_offset=
)) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                      "%s: Unsupported crypt command 0x%x\n", __func__, cm=
d);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (!qcrypto_cipher_supports(alg, mode)) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                      "%s: cipher mode not supported by the crypto backend=
\n",=0A=
+                      __func__);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* Fetch the IV and key from the context buffer in DRAM. */=0A=
+    ctx_addr =3D s->regs[R_CRYPT_CONTEXT];=0A=
+    if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
+                           ctx, sizeof(ctx))) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to read context, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
+                      __func__, ctx_addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {=0A=
+        hace_hexdump("context", (char *)ctx, sizeof(ctx));=0A=
+    }=0A=
+=0A=
+    cipher =3D qcrypto_cipher_new(alg, mode, ctx + CRYPT_CTX_KEY_OFFSET, k=
eylen,=0A=
+                                &local_err);=0A=
+    if (cipher =3D=3D NULL) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher new failed: %s\=
n",=0A=
+                      __func__, error_get_pretty(local_err));=0A=
+        error_free(local_err);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (mode !=3D QCRYPTO_CIPHER_MODE_ECB &&=0A=
+        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,=0A=
+                             &local_err) < 0) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv failed: %=
s\n",=0A=
+                      __func__, error_get_pretty(local_err));=0A=
+        error_free(local_err);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    src_buf =3D g_malloc0(len);=0A=
+    dst_buf =3D g_malloc0(len);=0A=
+=0A=
+    src_addr =3D s->regs[R_CRYPT_SRC];=0A=
+    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to read src, addr=3D0x%" HWADDR_PRIx "\n=
",=0A=
+                      __func__, src_addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {=0A=
+        hace_hexdump("src", (char *)src_buf, len);=0A=
+    }=0A=
+=0A=
+    if (encrypt) {=0A=
+        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,=0A=
+                                   &local_err) < 0) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed: %s\n",=0A=
+                          __func__, error_get_pretty(local_err));=0A=
+            error_free(local_err);=0A=
+            return;=0A=
+        }=0A=
+    } else {=0A=
+        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,=0A=
+                                   &local_err) < 0) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed: %s\n",=0A=
+                          __func__, error_get_pretty(local_err));=0A=
+            error_free(local_err);=0A=
+            return;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    dst_addr =3D s->regs[R_CRYPT_DEST];=0A=
+    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to write dst, addr=3D0x%" HWADDR_PRIx "\=
n",=0A=
+                      __func__, dst_addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {=0A=
+        hace_hexdump("dst", (char *)dst_buf, len);=0A=
+    }=0A=
+=0A=
+    if (mode =3D=3D QCRYPTO_CIPHER_MODE_CBC) {=0A=
+        /*=0A=
+         * CBC chains on the last ciphertext block: the final block of the=
=0A=
+         * output when encrypting, or of the input when decrypting. Write =
it=0A=
+         * back as the IV for the next request.=0A=
+         */=0A=
+        next_iv =3D (encrypt ? dst_buf : src_buf) + len - blocklen;=0A=
+        if (address_space_write(&s->dram_as, ctx_addr + iv_offset,=0A=
+                                MEMTXATTRS_UNSPECIFIED, next_iv, blocklen)=
) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: Failed to write IV, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
+                          __func__, ctx_addr + iv_offset);=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned int s=
ize)=0A=
 {=0A=
     AspeedHACEState *s =3D ASPEED_HACE(opaque);=0A=
@@ -531,16 +774,22 @@ static void aspeed_hace_write(void *opaque, hwaddr ad=
dr, uint64_t data,=0A=
                 qemu_irq_lower(s->irq);=0A=
             }=0A=
         }=0A=
-        if (ahc->raise_crypt_interrupt_workaround) {=0A=
-            if (data & CRYPT_IRQ) {=0A=
-                data &=3D ~CRYPT_IRQ;=0A=
+        if (data & CRYPT_IRQ) {=0A=
+            data &=3D ~CRYPT_IRQ;=0A=
 =0A=
-                if (s->regs[addr] & CRYPT_IRQ) {=0A=
-                    qemu_irq_lower(s->irq);=0A=
-                }=0A=
+            if (s->regs[addr] & CRYPT_IRQ) {=0A=
+                qemu_irq_lower(s->irq);=0A=
             }=0A=
         }=0A=
         break;=0A=
+    case R_CRYPT_SRC:=0A=
+    case R_CRYPT_DEST:=0A=
+    case R_CRYPT_CONTEXT:=0A=
+        data &=3D ahc->src_mask;=0A=
+        break;=0A=
+    case R_CRYPT_DATA_LEN:=0A=
+        data &=3D CRYPT_DATA_LEN_MASK;=0A=
+        break;=0A=
     case R_HASH_SRC:=0A=
         data &=3D ahc->src_mask;=0A=
         break;=0A=
@@ -589,13 +838,19 @@ static void aspeed_hace_write(void *opaque, hwaddr ad=
dr, uint64_t data,=0A=
         break;=0A=
     }=0A=
     case R_CRYPT_CMD:=0A=
-        qemu_log_mask(LOG_UNIMP, "%s: Crypt commands not implemented\n",=
=0A=
-                       __func__);=0A=
-        if (ahc->raise_crypt_interrupt_workaround) {=0A=
-            s->regs[R_STATUS] |=3D CRYPT_IRQ;=0A=
-            if (data & CRYPT_IRQ_EN) {=0A=
-                qemu_irq_raise(s->irq);=0A=
-            }=0A=
+        /*=0A=
+         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM, which a=
re=0A=
+         * added later; until then it keeps the temporary workaround of on=
ly=0A=
+         * raising the completion interrupt without running the command.=
=0A=
+         */=0A=
+        if (!ahc->raise_crypt_interrupt_workaround) {=0A=
+            do_crypt_operation(s, data);=0A=
+        }=0A=
+=0A=
+        /* Hardware raises the crypt interrupt once the command finishes. =
*/=0A=
+        s->regs[R_STATUS] |=3D CRYPT_IRQ;=0A=
+        if (data & CRYPT_CMD_ISR_EN) {=0A=
+            qemu_irq_raise(s->irq);=0A=
         }=0A=
         break;=0A=
     case R_HASH_SRC_HI:=0A=
-- =0A=
2.43.0=0A=

