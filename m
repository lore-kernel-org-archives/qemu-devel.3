Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF65CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0eI-0004Yq-NI; Mon, 18 May 2026 12:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torbjorn.svensson@foss.st.com>)
 id 1wP0dp-0004Ht-T2; Mon, 18 May 2026 12:16:39 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torbjorn.svensson@foss.st.com>)
 id 1wP0do-0004aM-4q; Mon, 18 May 2026 12:16:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqeMVxOIWeEP4ApFAhDpFQIIIfyrV7PJ55RV3L8XJXDZViYMMje9T1hjbMd+u57277nJx49pTXix40/z2jiMfxPUNTfIdeKP0Xr1E6+7bbwAMwUMmQqfocUB2CmUDo7mTOPCIOOkC+K+XmA+M20S2iTqv9QYf57jApbwPCJpJfS8RM3bFZmFduizJwufVgM2dMOhcNd4LxMl9cUwk46X9i+UeGu0YZgKW/SH7DoWcTj1TiAT/Eg2oLveP7aUpx1yG6jemZFtbONcU26VuxZBuNQEc4vA6d8LTn/0nc9gpqqhaD9svHH2oPuhAXhPko1RrfMyE2rET0bNmgp5nU1pcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sBrf9tfSTic6B9MKDePQCZpmydbauzHAxqLb6NtU0Y=;
 b=eljuBcAcClRqVBgDZb/ph0IoqHtixzoPXdB8pd2xot2RfRWEleoA8RFsE/4sH2Lj40ulpt3CXTrYM66w0GKnrFcR+jPYKgxnSSW0qCoPaSxqAZSBBt5nGQ5RIb/iCzOd3gAIe/15+ZZWNvq9o2eQh6Hurszj4sUkQNsA49sV5c0DSRKpOwOWQJbyjtUag7ZEuEKSzYzB1kWWF/2+kw17ra2NGfl6zFZAsEXL/HgA17I005aomN609VImdkQTpoVUstBcWZeCGG8m8O1x9+Z6xj45dyrKLaRFTon4ayub2RjmkVIGmEeaLZltvv4sPqnXC44jMcDqe0JuGfdflnEmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=nongnu.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sBrf9tfSTic6B9MKDePQCZpmydbauzHAxqLb6NtU0Y=;
 b=WcY8AujX32MIIQkMo/Y8Jxc+OyrQNjUvyj/I0bAiii85W6Xk63bkh5IR4+tKh0CvKbbaFjj/+Pl+D43RTjYgiRw5FcSxPoMVZARduiVzMo/gUDKI5vlAmY8HZ2wGaK/k9Kv8/HmIAigRenOJBLoUZih4+CXYmB/3KwtIDJ2hGPDkqt3Uwek5NcA22fWY8yGrXbm6l2JIeCVGJ4XBw5QMTO24mYuY+LdXuX9fnJEopuQcAU4Plyx9RweriM259kjK5zlRRF6FoAnAuLv46j/BxYtuT+zNwi2oeiCsNS7XX6TUaLzvi2amLbe/mNIIDxXkI8cH8lg+Kz3jTyudLSbYNQ==
Received: from AS4P190CA0032.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::9)
 by AMBPR10MB9753.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:76c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:16:17 +0000
Received: from AM2PEPF0001C712.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::3b) by AS4P190CA0032.outlook.office365.com
 (2603:10a6:20b:5d1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 16:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C712.mail.protection.outlook.com (10.167.16.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 16:16:17 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 18 May
 2026 18:19:46 +0200
Received: from jkgcxl0012.jkg.st.com (10.74.22.122) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 18 May
 2026 18:16:17 +0200
From: =?utf-8?q?Torbj=C3=B6rn_SVENSSON?= <torbjorn.svensson@foss.st.com>
Date: Mon, 18 May 2026 18:14:00 +0200
Subject: [PATCH 2/3] target/arm/tcg: add PAC related instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260518-pr-pacbti-v1-2-8932a885b03d@foss.st.com>
References: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
In-Reply-To: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>,
 =?utf-8?q?Torbj=C3=B6rn_SVENSSON?= <torbjorn.svensson@foss.st.com>
X-Mailer: b4 0.13.0
X-Originating-IP: [10.74.22.122]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C712:EE_|AMBPR10MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: a52b9b95-73bd-4d8f-124b-08deb4f8caac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|82310400026|376014|36860700016|1800799024|11063799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: jtlM25X/QvUhxAX6SkzwS4aVo1yXG6otZwEepm9Sb6GYyY1u8kKPHlyTlqiwGFIrsTNoDBELyzsuJ0otXO9yqGTcVYgYfx0kHGI2189z377UjJByv96ZpKB7Ntbd5/u7y2YkC8e85Bk26iwXSReEmjozaOrB7qpLFilhfqUNglLhCwc99JYNj9Y1Tb+gpmW2WB33x61mmTyw7NMswZxHeVnoAksESeOvEQ0HutT6n9f/gIz0J+uzy9Sfy0mda+IraX94nRrMWVpKoYk+wgFJobwpoCSMblTNOK+I6ic+GBLPJQT3YVU4N5mhOvDFBIhElYsAfSRh3vFtFJHuSUJcuM+ho0KPrl33nnWQ9+rooX+Q20BOp2iRTeFDmDu/LcVJ9dyaWLsOVPL5Kc+Ty/cFTwkCHmEDprodgtOozhcVVuTl+cAMHBiZcrlU9DtY3wl5q1aS1nFfKd8fbYT+fOAJlnlW7178VVZXlaLpM7f5SqNgop7edC0aF1s8Li4MVybXq6+vQ+JxhYxeouHB3xwUba1rHxVm/nmsl5/QfECC7HJezFv43gO80wIi+VjQm1eCoX2daiSXLr/vSCFpv99pVdmpKq93p4rILkbZGbGt6DIjqqj1ko5L7TxB4MEcXbuRltytbOi9qB3CZL3KkBlDr0tsNMhkUiwcVojqQYZCNmIHndPz9IAdCz4naH7lIFhVdOukeLpDJMmvQt8conSpiqbe/pFqUGqpqzQ0Y9eoE/Y=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(82310400026)(376014)(36860700016)(1800799024)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NAT3zO2iDbPHGAWVDkZQqGscfAY4gpDSF9a6Um3DK2oA+nHkIm7SaiNmvvkwvfT6v2EMH0ubzI4O+6z9J2J7NJhm2MUHKFQx/rv5mr5P9S3qoCT3+X5tk8NOKRBrWB37ws5KgGsGz58+Zk6FJPXiSK6S0gpx2zS+oLsY42Wsyjnt/Zc0nmh3/fyT5XhCCgeI//dra8/0ex3fBZF4EH3tgZQXQV/MGCqgRDsSO0hiK5mXdmuADQzzzSBuHOhgl6CcLOW+f4fRa977aOuHCmLVCCzOBL+U/hCGHsQkHOFTjYtpVGZ4eR6dU5zozeYDq7apZwPAZ2laAsTnJYwFV4PGnDsYluw+cmA30Yff5tWOXyBbmZ27I6pACfhZNI7/1XVh3QL3g9/mgSNhr1fQJigBhXiJStjfm2RYdmneHoiVdnh0YpopJT+wzTvF+8/+v8Me
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:16:17.7465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a52b9b95-73bd-4d8f-124b-08deb4f8caac
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9753
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=torbjorn.svensson@foss.st.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit adds the pointer authentication instructions from the Arm
v8.1-m PACBTI extension.
While the instructions are properly recognized, they are all NOPs.

Signed-off-by: Torbjörn SVENSSON <torbjorn.svensson@foss.st.com>
---
 target/arm/tcg/t32.decode  | 21 +++++++++++++---
 target/arm/tcg/translate.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
index 49b8d0037e..a885eed101 100644
--- a/target/arm/tcg/t32.decode
+++ b/target/arm/tcg/t32.decode
@@ -263,6 +263,7 @@ BFCI             1111 0011 011 0 .... 0 ... .... ..0.....     @bfi
 @s0_rnadm        .... .... .... rn:4 ra:4 rd:4 .... rm:4      &s_rrrr s=0
 @s0_rn0dm        .... .... .... rn:4 .... rd:4 .... rm:4      &s_rrrr ra=0 s=0
 @rnadm           .... .... .... rn:4 ra:4 rd:4 .... rm:4      &rrrr
+@rna0m           .... .... .... rn:4 ra:4 .... .... rm:4      &rrrr rd=0
 @rn0dm           .... .... .... rn:4 .... rd:4 .... rm:4      &rrrr ra=0
 @rndm            .... .... .... rn:4 .... rd:4 .... rm:4      &rrr
 @rdm             .... .... .... .... .... rd:4 .... rm:4      &rr
@@ -319,9 +320,18 @@ SMLALDX          1111 1011 1100 .... .... .... 1101 ....      @rnadm
 SMLSLD           1111 1011 1101 .... .... .... 1100 ....      @rnadm
 SMLSLDX          1111 1011 1101 .... .... .... 1101 ....      @rnadm
 
-SMMLA            1111 1011 0101 .... .... .... 0000 ....      @rnadm
-SMMLAR           1111 1011 0101 .... .... .... 0001 ....      @rnadm
-SMMLS            1111 1011 0110 .... .... .... 0000 ....      @rnadm
+{
+  AUTG           1111 1011 0101 .... .... 1111 0000 ....      @rna0m
+  SMMLA          1111 1011 0101 .... .... .... 0000 ....      @rnadm
+}
+{
+  BXAUT          1111 1011 0101 .... .... 1111 0001 ....      @rna0m
+  SMMLAR         1111 1011 0101 .... .... .... 0001 ....      @rnadm
+}
+{
+  PACG           1111 1011 0110 .... 1111 .... 0000 ....      @rndm
+  SMMLS          1111 1011 0110 .... .... .... 0000 ....      @rnadm
+}
 SMMLSR           1111 1011 0110 .... .... .... 0001 ....      @rnadm
 
 SDIV             1111 1011 1001 .... 1111 .... 1111 ....      @rndm
@@ -375,6 +385,11 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
         # SEVL   1111 0011 1010 1111 1000 0000 0000 0101
 
         ESB      1111 0011 1010 1111 1000 0000 0001 0000
+
+        # v8.1-m PACBTI extention
+        AUT      1111 0011 1010 1111 1000 0000 0010 1101
+        PAC      1111 0011 1010 1111 1000 0000 0001 1101
+        PACBTI   1111 0011 1010 1111 1000 0000 0000 1101
       ]
 
       # The canonical nop ends in 0000 0000, but the whole rest
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c744b16345..ae1351ef03 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5012,6 +5012,68 @@ static bool trans_SMMLSR(DisasContext *s, arg_rrrr *a)
     return op_smmla(s, a, true, true);
 }
 
+static bool trans_PAC(DisasContext *s, arg_empty *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
+        return false;
+    }
+
+    /* Handle as if PACBTI is disabled. */
+    return true;
+}
+
+static bool trans_PACBTI(DisasContext *s, arg_empty *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
+        return false;
+    }
+
+    /* todo: reset EPSR.B to 0 */
+
+    /* Handle as if PACBTI is disabled. */
+    return true;
+}
+
+static bool trans_PACG(DisasContext *s, arg_rrr *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
+        return false;
+    }
+
+    /* Handle as if PACBTI is disabled. */
+    return true;
+}
+
+static bool trans_BXAUT(DisasContext *s, arg_rrrr *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
+        return false;
+    }
+
+    /* Handle as if PACBTI is disabled. */
+    return true;
+}
+
+static bool trans_AUT(DisasContext *s, arg_empty *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
+        return false;
+    }
+
+    /* Handle as if PACBTI is disabled. */
+    return true;
+}
+
+static bool trans_AUTG(DisasContext *s, arg_rrrr *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
+        return false;
+    }
+
+    /* Handle as if PACBTI is disabled. */
+    return true;
+}
+
 static bool op_div(DisasContext *s, arg_rrr *a, bool u)
 {
     TCGv_i32 t1, t2;

-- 
2.43.0


