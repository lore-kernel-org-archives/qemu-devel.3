Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0110606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=YfExP27V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKMTx-0001n7-Hm; Fri, 23 Oct 2026 17:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xKMTc-0001kT-A8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 17:07:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xKMTZ-0003PV-PK
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 17:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=5/q/nH1afZWulhGxW6NQdix7niyIK1ymcnCfL9nqn0E=; b=YfExP27VV1dZZrqo8tiYLvfozU
 saA34hL6fxeWsqjy7eZWzMIFxKp/nGbY2N2XKgol0onPUtUBcMOZHUw/YJKkiQ2lheAlowsb73aRJ
 h5FVbuNzaCuNj1i2YwGiZnR25zLqWYlHkc5BaKfI650PxmxNwBjOhS3R/eo+NQmNWHc85uLN5JDmI
 pcvatIic6LN75O5Q5n85mU5OlW3HixZRTArjuB3btJKoA4BtFGeuVm5uBQesuk2EBSBCfn2V4Zk0N
 ao+Is8yCXoM/wXn3dCOuuruRMRx/2RelSRgkojxYgo2lgG7raepVKYzIxy5Ivf5vIrK058LiueHIV
 AEMNOxzHQsR4Wuo12Sde3NeG698MkM73cn6DshqkuRO+oUFdStRX+Gu0zMI08Z+2Hf8Qbzgn9ut4V
 j20N52KO9TVjFBJXnA6wZRvQa8atGtry/sUGr1v4gQbHRWE7AzQfKIzEPjJy1hYQwMIAo/evS2Bs2
 DqdZhPZAXImzzQE0CjBPeG5qe8qiHjmqMEW94z+O1b2fJ08527AGmdgtJvZxBqgKIci4S6s6bA3H1
 cqn9IkXVSobjCdgA3XOqlwWKIu6j8o/LdGDuHiSg1VVm6JWWXxnB88Rfx3Ozs6UzoE/sqd0DLy9Et
 ThTZLEkmZb3xlrj7+pfJqzrKv/TBI3dbHTYBSMoCc=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xKMSp-003QXg-Jd
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:06:12 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Fri, 23 Oct 2026 22:06:31 +0100
Message-ID: <20261023210650.559141-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023210650.559141-1-mark.cave-ayland@ilande.co.uk>
References: <20261023210650.559141-1-mark.cave-ayland@ilande.co.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 1/6] target/sparc: Add crypto feature
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stian Halseth <stian@itx.no>

Add a "crypto" feature bit gating the OSA 2011 cryptographic
instructions (AES, SHA-1/256/512, CRC32C, CFR in ASR 26).
Off by default; no CPU model enables it yet; can be set
explicitly with "-cpu ...,+crypto". SPARC64 only.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Stian Halseth <stian@itx.no>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20261022070059.3861291-2-stian@itx.no>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/cpu-feature.h.inc | 1 +
 target/sparc/cpu.c             | 3 +++
 target/sparc/translate.c       | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
index be810052376..4a32f49de46 100644
--- a/target/sparc/cpu-feature.h.inc
+++ b/target/sparc/cpu-feature.h.inc
@@ -16,3 +16,4 @@ FEATURE(FMAF)
 FEATURE(VIS3)
 FEATURE(IMA)
 FEATURE(VIS4)
+FEATURE(CRYPTO)
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ae9bdca9df8..528a9d2bd83 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -560,6 +560,7 @@ static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_VIS3] = "vis3",
     [CPU_FEATURE_BIT_IMA] = "ima",
     [CPU_FEATURE_BIT_VIS4] = "vis4",
+    [CPU_FEATURE_BIT_CRYPTO] = "crypto",
 #else
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
@@ -977,6 +978,8 @@ static const Property sparc_cpu_properties[] = {
                     CPU_FEATURE_BIT_IMA, false),
     DEFINE_PROP_BIT("vis4",     SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_VIS4, false),
+    DEFINE_PROP_BIT("crypto",   SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_CRYPTO, false),
 #else
     DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_MUL, false),
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3156be6a94c..b93feb074b2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2507,6 +2507,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_VIS3(C)    ((C)->def->features & CPU_FEATURE_VIS3)
 # define avail_VIS3B(C)   avail_VIS3(C)
 # define avail_VIS4(C)    ((C)->def->features & CPU_FEATURE_VIS4)
+# define avail_CRYPTO(C)  ((C)->def->features & CPU_FEATURE_CRYPTO)
 #else
 # define avail_32(C)      true
 # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
@@ -2524,6 +2525,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_VIS3(C)    false
 # define avail_VIS3B(C)   false
 # define avail_VIS4(C)    false
+# define avail_CRYPTO(C)  false
 #endif
 
 /*
-- 
2.47.3


