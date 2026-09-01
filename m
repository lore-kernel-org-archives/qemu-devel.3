Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19589C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KEy-0003tb-7C; Tue, 01 Sep 2026 04:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEw-0003t8-Fa; Tue, 01 Sep 2026 04:53:10 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEs-0007J9-60; Tue, 01 Sep 2026 04:53:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWCBbZZ+worZRmfYC/nygrtZdhNDjF2q80cVuC/iLI0I0Yokw+Cw0usj4u1UJTXRYpjSW+4YtqCAvZb0wdtoiCyBRvLZQEeV/5Zo1sKYwL2KjdWfWfK+Ric6/Hs/MkNMQUlZUeDFGMs/CIDh5z/bWqRcFtnpA6jxEON8EADgMkvJYsVvh83ORlFEDERzcuofPsie/mMsGh3D+YW3tlFce4uB3gBpELkWT+Qi5YJ3ngwOLHgXZLUIsYZRQ/dYIjHbbxhHVbH7x7tnR3iOSRzDBKxCaxM72sR7sKUuUoF23XG88vqD/uGr0IdDpTStBVTsP6RjxAcrLl9SNpdS7E0CWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozfcMn7TOFuqzQiNTIW/sVbaQWqOPGO2jeyIjfFiKh4=;
 b=OpNXivVugydDGXYJGTuL8/bcyzYkrXenBKNU2/6v0gxgP6Jp9/tSf7DJEBYBHnsVKjx4nnSMbeyGh2htbGcH7cvaK3c/IRLje9RMJ3ypFY82KAN/mtQ3tR1+nn9DoZWgYxsoE2Cok1Kx1FKhwPRbBZnHm3QGyUA5andeMOaeFAmabqytGJ+j1a72C2Ql8gOFtBrpSCLBzcwlLe3DoMu6og7ow3E1lZxUHyqGyC5BCIlvPtBJKwHO7nBR3T+gl718dZL3qBuZnLF0xLVJKL18RLoz3LNwnbqczaly0RIj2Tu+voG8fRd3gGt6lL7ou64He/9CKW2vI1XD2zM/UCdFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozfcMn7TOFuqzQiNTIW/sVbaQWqOPGO2jeyIjfFiKh4=;
 b=kuinqR1U2onbYEmm76kBJ6X4V/bhEcN+SDtGTjEPJEwuRgThqmKAWmOqWTQHhLn93qQO/85idJz6VB7I0yK604b/avkoC6ry+NrYgC6hSVdJxc/lNRKdoLVHhrpq0eC9pktby8Puvb66tqMBEMX5RMTeQYnAZ/TizGtRTUNzh31EQkFfRlaIt+eOTN32epP4UorQ0IyDtdib8qrTEaBoUniFk3VJ3SNM44YgjxWrH7kin3T0WcQmNyniCBLwuvgEQ9FUIl3YT/gSGWXI/AEvKCEcZZ0bzNuTucjdsHT2z4pXxIt38I/2zBPOPb84zBAUB62bHBhvfGlppsG1OUZ+HA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU2PPF557D403C2.apcprd06.prod.outlook.com (2603:1096:d18::495)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Tue, 1 Sep
 2026 08:52:49 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:52:48 +0000
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
Subject: [PATCH v4 8/9] hw/misc/aspeed_sbc: Support the ECDSA verify command
Thread-Topic: [PATCH v4 8/9] hw/misc/aspeed_sbc: Support the ECDSA verify
 command
Thread-Index: AQHdOe9Dnx2Wl1OVLk2ZRp85jdWqMQ==
Date: Tue, 1 Sep 2026 08:52:48 +0000
Message-ID: <20260901085238.995968-9-jamin_lin@aspeedtech.com>
References: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU2PPF557D403C2:EE_
x-ms-office365-filtering-correlation-id: 9971b3bc-4388-4c49-4f07-08df0806664e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|921020|38070700021|6133799003|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: fpz4YO3XfEvo7zaWwuRb55kP2uYGxtXC1pDiGCk88cvaM+VMqZNlgC4ZZX7uzMW6A4s8iT5MM+yejJ8dqIV1zRh8nh6xUEL4mHWDpt/rpZj/qzrlLIhij3+6DbQ2Anb1eiQKciO2YBk+AWvSfr4Nnj3/NYT4aqH8zMdWB4/6n9Ypp/0uZBVXgHb98I5N/xPue/o9lPh4oEp3tNA/D1c0mqCbDhTxSvZlXr+5NnzvbIY6oY/yoWHpEEnw0aY5A21bmR0NiWGPcRlvuJfiudS0toY4Elyd8CBCZA/T5qV/Ud6rdOwsZQTwvyKxQAkaU+X8LaDgzO8Myn+79q7vD3aMwpvGE9Rt5EaymktrLLY2pqhZzadQULn9PsyjZs4/OuHBKmIMnhln3EHGcNGaktZ5RqxD36gjcmHSiC2OkN1Df2ODRguhjDxJNxKuBaEHwmt9sY1Nh6PWGynfih+r8oIPsrWaxqWsW1v/I2Yc/IR+lCmSMPUnR/In6G3h5D/sqBqmwHqQ9qc6OPbPFIhBBNnyPJLGmuibjkfjBZWh1NsNrjUMJFcdvg3uLyhMi3Zd6+qj9otVjCv/6irs8PkKZW/FcBqihDoxJZnl31TSb5xSPFqdN4tNPZ/sIH5m/xZbrzE2ZqPrE4Zx1wGVBMZLOXJKs+Gpv4V6fgFV+TN6kDHtV2LRhfg0iWCvAU20IsfmIYBep9mm2cY2TbGjOrMiLSxVVQhIIOhKZh7DrWjPURssE16NbCBRaiO6M5lZ51gSK9Vl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(921020)(38070700021)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vJbDDDsC8YfZG/qR7Y9nelXRHTEOSYU4wS4qPxpyLN0gsCB3mEPGLz9XbT?=
 =?iso-8859-1?Q?ELfBjgwL1QEAmQRf4DHYcwwz5a+uQ69P9r14ac+xnmMebW0G4x0UJaN5RV?=
 =?iso-8859-1?Q?wRnFAfuCVpHgIweMqH86XYqPLNU4W8H1DbKgM8I0c+eelHL9gU19Lx52fa?=
 =?iso-8859-1?Q?oep69LbhhyBdxgPUwDcgPyS/3psVrVWs7+iqcSoZtLxzFIA2aoaJOQXYXo?=
 =?iso-8859-1?Q?JZ6xdbPhxOJanY5G0mg8kzrZL7mO6FW7ckVY4IOY26ehhfQyz+ikyU13bE?=
 =?iso-8859-1?Q?JVi79CM/iy1eNAM1DZrNhEaVgA6l6g6GG0qhOexFp2z5bf+nuEvBhtIW2T?=
 =?iso-8859-1?Q?Ri+cu/h4amPJ6MoA6GVqq+0nJLTFyQHoTxLfWiYAEJ7y0ZlHVImCHux4Kr?=
 =?iso-8859-1?Q?u+ri1jMli4VSCAKoYw0zn/C7OM/n6KFonAiXdO1tOTY5xSzdeZBv8uMQUa?=
 =?iso-8859-1?Q?w6K/V8h7yMyizFGG3sb3MkvEcEtRk5xTs071/eupBuj4/DeVyyO2zVMUFj?=
 =?iso-8859-1?Q?gJ7WSvUcxLR/XKKdH/0BrTz47vTu7xpIwPx3Y1Hjb3FArqmQ9V8rNinvhA?=
 =?iso-8859-1?Q?tqMkyvnQNOvo7aPUYv1+JvwrVL8Ym/iLxcfEgd3vlopTHcKql6AYHtYh4j?=
 =?iso-8859-1?Q?xlQnajDy9XWb0y9u1c2iyQsRhnPatxH1UhhmrFIwcyLgxzdPUlP32+qoJA?=
 =?iso-8859-1?Q?B4boEwdINGzh1fUVGN+51SykKdGx7NBccBhgwScGT2X5jVJKXofRXnQYIu?=
 =?iso-8859-1?Q?xRfJnujD/iIZ84Xel30G2kbezKhhAtNCIvrp5GeP5GNJ+EsI2Yuxi1GtLu?=
 =?iso-8859-1?Q?2GK1I/cWM94P0cyszcQ6VI5QVrGHWDexeFIxwYbGikMeYy+IrY7JGHP3/a?=
 =?iso-8859-1?Q?OICrJDKok5mUehCueflbT/u7zSIU2sR+2TUbQvo+Z0Jq0NAOBTNM5Ac4dd?=
 =?iso-8859-1?Q?qe8E5DxB8BKtmMDqfipZU09ixtchfLZp6BtyyQwOxC4tQ0VdxS0V2cgRUN?=
 =?iso-8859-1?Q?qSyHvSO1EbTbCoHl6TYEzfF6LtT9B9hF762hV6Je5WabJbnx2628k9rndA?=
 =?iso-8859-1?Q?FBjER9hbPo5MV1Yl6eBkZWCrgMyycKWtJEmRoYoYUirLqmEJ0GfCVn+pLS?=
 =?iso-8859-1?Q?1Zomq1Wh21u8OkWQgyUKWvqK3GiL3AdqX/c81D7x1Y9piy4/CsJ55/Lr8t?=
 =?iso-8859-1?Q?1YNhQUlpsrJa4iWeBhzoGl/lrpA3krujH8Y+ZHUTGgnnH0w1PKILJoOv6P?=
 =?iso-8859-1?Q?VJQ+3GLQjbCg1XoLQ3buScTHovFPt+l5alS8BFQSFHuHIF8qIzAENXBrRZ?=
 =?iso-8859-1?Q?2BOPIiI2K0CQTkUQKtk5GPwmZQwXl2eNJDUb6Pdq6WFFsWX4J7SB7dCw7d?=
 =?iso-8859-1?Q?LcvQxLYz99e+mrPZKnqcPDzSeqecLpV1QTeaClBDakOUmmB4P6r/SZxzn/?=
 =?iso-8859-1?Q?cih2i4bgMJkKuv9YJt4YQbIsX53wlIYrqFNi82gnz/6Nb2OE5sUPyL1jKV?=
 =?iso-8859-1?Q?ZGX/C0OZ3zSchIzefdHVSOy3BZpzzmzl6S3lw8h1sW0yig3d1P1xh9Q5us?=
 =?iso-8859-1?Q?zVPRNaT2fgqTiMgtg9JTePnZQUonnL0iKWqwuKIoQ2iJ/d/QxNrDp+Q+Qs?=
 =?iso-8859-1?Q?a1SfS7oGG2Dnk1XuwXgI+FRqsi5mVjrGbhKBWIk6QaSshb4Yrsfb7e8DYR?=
 =?iso-8859-1?Q?+4tYgCNe2NOs5UIwRl9+Wc3sRKsSspbxyOeTxkZveaRbQK/+mElvLR1h/2?=
 =?iso-8859-1?Q?AicO03w08g5EoAz9rHPYNSa5zqPHpxbCe+huhKYCAdzqd72OXyf1V/FUW/?=
 =?iso-8859-1?Q?D9N4tkToQQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: edU2dtk0Uz5fH1oM3FOvr000e4iujqf20eVcJVRWi2lFIspneosAQEbZpx4vDLYrNtOj9u0kpSysL93xN6WwFAKDVIQoKWu/pVkQ49ZYweP0JW8aUcA181yKNseSBUTJGUfseqNpFik+hReb+iEauT2H1LTp8j8IyWJQ9q3ncnnvPPtJ5jyJNsO9KuG9LKE4Pn0YOu2ZKiDwJB++ckKMOAb96rZQMQXIoDxk5IN6TlhxVhNe9w6/y10bK2X/T1QJSplZqbVWwxatnCsap4f5RfvVLM7wZ8+x8ubfPZrETiYZnSbo2jiyzGL9pb2bCVzWGIP1dkIkEgQhHUU99h77nw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9971b3bc-4388-4c49-4f07-08df0806664e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:52:48.8884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pinv4xCFAulqNw06W5X76BnlGHewhoyJMe+r9vxuHKbkBTTd34UqC6i8bNgP0aaTENY33J7rcPhgOHBeLvqt/Mxbnq84hwDxu0RaIT5UyWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF557D403C2
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

The AST10x0 secure boot controller register block also hosts an ECDSA=0A=
engine. Emulate its secp384r1 "verify" command: on a trigger write to=0A=
the command register, read the public key, signature and SHA-384 digest=0A=
that the firmware staged in the SEC SRAM and defer the verification to the=
=0A=
crypto akcipher backend, reporting the result through the status=0A=
register.=0A=
=0A=
The model reads its operands from the SEC SRAM through a dedicated=0A=
address space, using a 'sram' link. The SEC SRAM is mapped at offset 0=0A=
of that address space, so the engine addresses each operand directly=0A=
with its SRAM-relative offset.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_sbc.c | 141 +++++++++++++++++++++++++++++++++++++++++++=0A=
 hw/misc/trace-events |   2 +=0A=
 2 files changed, 143 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index f10f7ac578..5c193d9086 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -10,11 +10,13 @@=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
 #include "qemu/log.h"=0A=
+#include "qemu/cutils.h"=0A=
 #include "qemu/error-report.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/misc/aspeed_sbc.h"=0A=
 #include "qapi/error.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "crypto/akcipher.h"=0A=
 #include "trace.h"=0A=
 =0A=
 #define R_PROT          (0x000 / 4)=0A=
@@ -24,8 +26,22 @@=0A=
 #define R_CAMP1         (0x020 / 4)=0A=
 #define R_CAMP2         (0x024 / 4)=0A=
 #define R_QSR           (0x040 / 4)=0A=
+#define R_SEC_TRIGGER   (0x0bc / 4)=0A=
+=0A=
+/*=0A=
+ * SEC SRAM layout for a secp384r1 ECDSA verify operation. All operands ar=
e=0A=
+ * 48-byte big-endian values.=0A=
+ */=0A=
+#define ECDSA_SRAM_QX   0x2080=0A=
+#define ECDSA_SRAM_QY   0x20c0=0A=
+#define ECDSA_SRAM_R    0x21c0=0A=
+#define ECDSA_SRAM_S    0x2200=0A=
+#define ECDSA_SRAM_M    0x2240=0A=
+#define ECDSA_P384_COORD_LEN    48=0A=
 =0A=
 /* R_STATUS */=0A=
+#define ECDSA_VERIFY_PASS       BIT(21)=0A=
+#define ECDSA_VERIFY_DONE       BIT(20)=0A=
 #define ABR_EN                  BIT(14) /* Mirrors SCU510[11] */=0A=
 #define ABR_IMAGE_SOURCE        BIT(13)=0A=
 #define SPI_ABR_IMAGE_SOURCE    BIT(12)=0A=
@@ -42,6 +58,10 @@=0A=
 #define OTP_MEM_IDLE            BIT(1)=0A=
 #define OTP_COMPARE_STATUS      BIT(0)=0A=
 =0A=
+/* R_SEC_TRIGGER */=0A=
+#define ECDSA_CMD_TRIGGER BIT(1)=0A=
+#define RSA_CMD_TRIGGER   BIT(0)=0A=
+=0A=
 /* QSR */=0A=
 #define QSR_RSA_MASK           (0x3 << 12)=0A=
 #define QSR_HASH_MASK          (0x3 << 10)=0A=
@@ -220,10 +240,111 @@ static void aspeed_sbc_handle_command(void *opaque, =
uint32_t cmd)=0A=
     s->regs[R_STATUS] |=3D (OTP_MEM_IDLE | OTP_IDLE);=0A=
 }=0A=
 =0A=
+static void sbc_ecdsa_hexdump(const char *desc, const char *buf, size_t si=
ze)=0A=
+{=0A=
+    g_autoptr(GString) str =3D g_string_sized_new(64);=0A=
+    size_t len;=0A=
+    size_t i;=0A=
+=0A=
+    for (i =3D 0; i < size; i +=3D len) {=0A=
+        len =3D MIN(16, size - i);=0A=
+        g_string_truncate(str, 0);=0A=
+        qemu_hexdump_line(str, buf + i, len, 1, 4);=0A=
+        trace_aspeed_sbc_ecdsa_hexdump(desc, i, str->str);=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The hardware only supports ECDSA secp384r1 (NIST P-384). The firmware h=
as=0A=
+ * already staged the public key, signature and digest in the SEC SRAM; re=
ad=0A=
+ * them out and defer the actual verification to the crypto backend.=0A=
+ */=0A=
+static bool aspeed_sbc_ecdsa_verify(AspeedSBCState *s)=0A=
+{=0A=
+    QCryptoAkCipherOptions opts =3D {=0A=
+        .alg =3D QCRYPTO_AK_CIPHER_ALGO_ECDSA,=0A=
+        .u.ecdsa.curve_id =3D QCRYPTO_CURVE_ID_SECP384R1,=0A=
+    };=0A=
+    g_autoptr(QCryptoAkCipher) akcipher =3D NULL;=0A=
+    uint8_t pubkey[ECDSA_P384_COORD_LEN * 2];=0A=
+    uint8_t sig[ECDSA_P384_COORD_LEN * 2];=0A=
+    uint8_t dgst[ECDSA_P384_COORD_LEN];=0A=
+    Error *err =3D NULL;=0A=
+=0A=
+    if (!qcrypto_akcipher_supports(&opts)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: ECDSA secp384r1 is not supported by the crypto =
"=0A=
+                      "backend\n", __func__);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_QX,=0A=
+                           MEMTXATTRS_UNSPECIFIED, pubkey,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA QX from SEC SRAM\n", __fun=
c__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_QY,=0A=
+                           MEMTXATTRS_UNSPECIFIED,=0A=
+                           pubkey + ECDSA_P384_COORD_LEN,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA QY from SEC SRAM\n", __fun=
c__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_R,=0A=
+                           MEMTXATTRS_UNSPECIFIED, sig,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA R from SEC SRAM\n", __func=
__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_S,=0A=
+                           MEMTXATTRS_UNSPECIFIED, sig + ECDSA_P384_COORD_=
LEN,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA S from SEC SRAM\n", __func=
__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_M,=0A=
+                           MEMTXATTRS_UNSPECIFIED, dgst,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA M from SEC SRAM\n",=0A=
+                      __func__);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_SBC_ECDSA_HEXDUMP)) {=
=0A=
+        sbc_ecdsa_hexdump("pubkey", (char *)pubkey, sizeof(pubkey));=0A=
+        sbc_ecdsa_hexdump("signature", (char *)sig, sizeof(sig));=0A=
+        sbc_ecdsa_hexdump("digest", (char *)dgst, sizeof(dgst));=0A=
+    }=0A=
+=0A=
+    akcipher =3D qcrypto_akcipher_new(&opts, QCRYPTO_AK_CIPHER_KEY_TYPE_PU=
BLIC,=0A=
+                                    pubkey, sizeof(pubkey), &err);=0A=
+    if (!akcipher) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s\n", __func__,=0A=
+                      error_get_pretty(err));=0A=
+        error_free(err);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (qcrypto_akcipher_verify(akcipher, sig, sizeof(sig),=0A=
+                                dgst, sizeof(dgst), &err) !=3D 0) {=0A=
+        error_free(err);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
 static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,=0A=
                               unsigned int size)=0A=
 {=0A=
     AspeedSBCState *s =3D ASPEED_SBC(opaque);=0A=
+    AspeedSBCClass *sc =3D ASPEED_SBC_GET_CLASS(s);=0A=
 =0A=
     addr >>=3D 2;=0A=
 =0A=
@@ -244,6 +365,26 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr=
, uint64_t data,=0A=
     case R_CMD:=0A=
         aspeed_sbc_handle_command(opaque, data);=0A=
         return;=0A=
+    case R_SEC_TRIGGER:=0A=
+        if (data & RSA_CMD_TRIGGER) {=0A=
+            qemu_log_mask(LOG_UNIMP,=0A=
+                          "%s: RSA is not supported\n", __func__);=0A=
+        }=0A=
+        if (data & ECDSA_CMD_TRIGGER) {=0A=
+            if (!sc->has_ecdsa) {=0A=
+                qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                              "%s: ECDSA is not supported\n", __func__);=
=0A=
+                return;=0A=
+            }=0A=
+            s->regs[R_STATUS] &=3D ~(ECDSA_VERIFY_DONE | ECDSA_VERIFY_PASS=
);=0A=
+            if (aspeed_sbc_ecdsa_verify(s)) {=0A=
+                s->regs[R_STATUS] |=3D ECDSA_VERIFY_PASS;=0A=
+            }=0A=
+            s->regs[R_STATUS] |=3D ECDSA_VERIFY_DONE;=0A=
+            trace_aspeed_sbc_ecdsa_verify(=0A=
+                (s->regs[R_STATUS] & ECDSA_VERIFY_PASS) ? "pass" : "fail")=
;=0A=
+        }=0A=
+        return;=0A=
     default:=0A=
         break;=0A=
     }=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index bbec0d2178..735d11d447 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -95,6 +95,8 @@ aspeed_sbc_ignore_cmd(uint32_t cmd) "Ignoring command 0x%=
" PRIx32=0A=
 aspeed_sbc_handle_cmd(uint32_t cmd, uint32_t addr, bool ret) "Handling com=
mand 0x%" PRIx32 " for OTP addr 0x%" PRIx32 " Result: %d"=0A=
 aspeed_sbc_otp_read(uint32_t addr, uint32_t value) "OTP Memory read: addr =
0x%" PRIx32 " value 0x%" PRIx32=0A=
 aspeed_sbc_otp_prog(uint32_t addr, uint32_t value) "OTP Memory write: addr=
 0x%" PRIx32 " value 0x%" PRIx32=0A=
+aspeed_sbc_ecdsa_verify(const char *result) "ECDSA verify done: %s"=0A=
+aspeed_sbc_ecdsa_hexdump(const char *desc, uint32_t offset, const char *s)=
 "%s: 0x%08x: %s"=0A=
 =0A=
 # aspeed_scu.c=0A=
 aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" P=
RIx64 " of size %u: 0x%" PRIx32=0A=
-- =0A=
2.53.0=0A=

