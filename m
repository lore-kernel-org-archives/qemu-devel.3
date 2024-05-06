Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBBAC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wmi-0001qu-BB; Mon, 06 May 2024 07:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmT-0001pN-1R
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmP-0001uF-9W
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DGPjem5TZdj3yuftXLL952yPWb/T1vMCWKCniZPKVMw=; b=N04jyO8lBiEj5rBY75154LdtLv
 o1BvRNoIueien5XKHlbv7c7vc+mKwpqzkcFYiAhNT3HxtreDbFelXSOHvimjXxKC7Bu6Jc+nx32NZ
 2mfT5frf8t0ePPg9BaVJ42KZ9+aG1fcTzI45SX58Su9h8kNvGwfQSUVMqHWosiWqbt7O2VhtIPaiL
 97xU7+xr5+8t7SNt0q9GWEDrpJ9gcufWv9WbnSgDpTdX8zO1B2pjL5S+lF+b8OYvzSsJj8N6dioCw
 cuBfKNDel6vztRDdxCpv0xhYflCbVVGK3iaxkRgyEn1rHBxX3BN3vimiUw3KK628gN41FiBznmq67
 AmTXlw1Iw8F87JPOyMkspInIgCkgwm8OD4ZMjv4mFM1UPMx7RLdOZ+PsdfZForVF3SMdH008cQXV2
 EhhsBHYVlH9zYryEzaDjOsilCN4F99xVgoK8pq9QTP+GHeELIbKuhGuDNZQSG7i0MzjsnoLsBwcJh
 +bogOPg9ZOlSA9CXcbeybqR41H46R2fbLfgtqDYg0LRhHFqpJH8SJGC/LXk5hdFGVOyvXYFGOa0li
 oETw0bhkfwu8YNMmEBWP8MdwUoxqnZ4aJps9iUjNkYoZ/REYInih1ajwTz/xktjNeLdMElIaS5DsZ
 4Dhz8NzWVnQk2oJB1453GDB1N8TldP8NgkzMsjue8=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wlG-0005pA-CI; Mon, 06 May 2024 12:44:06 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:41 +0100
Message-Id: <20240506114451.331311-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 02/12] target/sparc/cpu: Avoid spaces by default in the CPU
 names
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

The output of "-cpu help" is currently rather confusing to the users:
It might not be fully clear which part of the output defines the CPU
names since the CPU names contain white spaces (which we later have to
convert into dashes internally). At best it's at least a nuisance since
the users might need to specify the CPU names with quoting on the command
line if they are not aware of the fact that the CPU names could be written
with dashes instead. So let's finally clean up this mess by using dashes
instead of white spaces for the CPU names, like we're doing it internally
later (and like we're doing it in most other targets of QEMU).
Note that it is still possible to pass the CPU names with spaces to the
"-cpu" option, since sparc_cpu_type_name() still translates those to "-".

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2141
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240419084812.504779-3-thuth@redhat.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/cpu.c | 56 +++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 7487ae034d..c2be4a00b6 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -206,7 +206,7 @@ void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu)
 static const sparc_def_t sparc_defs[] = {
 #ifdef TARGET_SPARC64
     {
-        .name = "Fujitsu Sparc64",
+        .name = "Fujitsu-Sparc64",
         .iu_version = ((0x04ULL << 48) | (0x02ULL << 32) | (0ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -215,7 +215,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Fujitsu Sparc64 III",
+        .name = "Fujitsu-Sparc64-III",
         .iu_version = ((0x04ULL << 48) | (0x03ULL << 32) | (0ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -224,7 +224,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Fujitsu Sparc64 IV",
+        .name = "Fujitsu-Sparc64-IV",
         .iu_version = ((0x04ULL << 48) | (0x04ULL << 32) | (0ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -233,7 +233,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Fujitsu Sparc64 V",
+        .name = "Fujitsu-Sparc64-V",
         .iu_version = ((0x04ULL << 48) | (0x05ULL << 32) | (0x51ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -242,7 +242,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI UltraSparc I",
+        .name = "TI-UltraSparc-I",
         .iu_version = ((0x17ULL << 48) | (0x10ULL << 32) | (0x40ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -251,7 +251,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI UltraSparc II",
+        .name = "TI-UltraSparc-II",
         .iu_version = ((0x17ULL << 48) | (0x11ULL << 32) | (0x20ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -260,7 +260,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI UltraSparc IIi",
+        .name = "TI-UltraSparc-IIi",
         .iu_version = ((0x17ULL << 48) | (0x12ULL << 32) | (0x91ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -269,7 +269,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI UltraSparc IIe",
+        .name = "TI-UltraSparc-IIe",
         .iu_version = ((0x17ULL << 48) | (0x13ULL << 32) | (0x14ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -278,7 +278,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc III",
+        .name = "Sun-UltraSparc-III",
         .iu_version = ((0x3eULL << 48) | (0x14ULL << 32) | (0x34ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -287,7 +287,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc III Cu",
+        .name = "Sun-UltraSparc-III-Cu",
         .iu_version = ((0x3eULL << 48) | (0x15ULL << 32) | (0x41ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_3,
@@ -296,7 +296,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc IIIi",
+        .name = "Sun-UltraSparc-IIIi",
         .iu_version = ((0x3eULL << 48) | (0x16ULL << 32) | (0x34ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -305,7 +305,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc IV",
+        .name = "Sun-UltraSparc-IV",
         .iu_version = ((0x3eULL << 48) | (0x18ULL << 32) | (0x31ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_4,
@@ -314,7 +314,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc IV plus",
+        .name = "Sun-UltraSparc-IV-plus",
         .iu_version = ((0x3eULL << 48) | (0x19ULL << 32) | (0x22ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -323,7 +323,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES | CPU_FEATURE_CMT,
     },
     {
-        .name = "Sun UltraSparc IIIi plus",
+        .name = "Sun-UltraSparc-IIIi-plus",
         .iu_version = ((0x3eULL << 48) | (0x22ULL << 32) | (0ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_3,
@@ -332,7 +332,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc T1",
+        .name = "Sun-UltraSparc-T1",
         /* defined in sparc_ifu_fdp.v and ctu.h */
         .iu_version = ((0x3eULL << 48) | (0x23ULL << 32) | (0x02ULL << 24)),
         .fpu_version = 0x00000000,
@@ -343,7 +343,7 @@ static const sparc_def_t sparc_defs[] = {
         | CPU_FEATURE_GL,
     },
     {
-        .name = "Sun UltraSparc T2",
+        .name = "Sun-UltraSparc-T2",
         /* defined in tlu_asi_ctl.v and n2_revid_cust.v */
         .iu_version = ((0x3eULL << 48) | (0x24ULL << 32) | (0x02ULL << 24)),
         .fpu_version = 0x00000000,
@@ -354,7 +354,7 @@ static const sparc_def_t sparc_defs[] = {
         | CPU_FEATURE_GL,
     },
     {
-        .name = "NEC UltraSparc I",
+        .name = "NEC-UltraSparc-I",
         .iu_version = ((0x22ULL << 48) | (0x10ULL << 32) | (0x40ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -364,7 +364,7 @@ static const sparc_def_t sparc_defs[] = {
     },
 #else
     {
-        .name = "Fujitsu MB86904",
+        .name = "Fujitsu-MB86904",
         .iu_version = 0x04 << 24, /* Impl 0, ver 4 */
         .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
         .mmu_version = 0x04 << 24, /* Impl 0, ver 4 */
@@ -377,7 +377,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Fujitsu MB86907",
+        .name = "Fujitsu-MB86907",
         .iu_version = 0x05 << 24, /* Impl 0, ver 5 */
         .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
         .mmu_version = 0x05 << 24, /* Impl 0, ver 5 */
@@ -390,7 +390,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI MicroSparc I",
+        .name = "TI-MicroSparc-I",
         .iu_version = 0x41000000,
         .fpu_version = 4 << FSR_VER_SHIFT,
         .mmu_version = 0x41000000,
@@ -403,7 +403,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_FEATURE_MUL | CPU_FEATURE_DIV,
     },
     {
-        .name = "TI MicroSparc II",
+        .name = "TI-MicroSparc-II",
         .iu_version = 0x42000000,
         .fpu_version = 4 << FSR_VER_SHIFT,
         .mmu_version = 0x02000000,
@@ -416,7 +416,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI MicroSparc IIep",
+        .name = "TI-MicroSparc-IIep",
         .iu_version = 0x42000000,
         .fpu_version = 4 << FSR_VER_SHIFT,
         .mmu_version = 0x04000000,
@@ -429,7 +429,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI SuperSparc 40", /* STP1020NPGA */
+        .name = "TI-SuperSparc-40", /* STP1020NPGA */
         .iu_version = 0x41000000, /* SuperSPARC 2.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x00000800, /* SuperSPARC 2.x, no MXCC */
@@ -442,7 +442,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI SuperSparc 50", /* STP1020PGA */
+        .name = "TI-SuperSparc-50", /* STP1020PGA */
         .iu_version = 0x40000000, /* SuperSPARC 3.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000800, /* SuperSPARC 3.x, no MXCC */
@@ -455,7 +455,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI SuperSparc 51",
+        .name = "TI-SuperSparc-51",
         .iu_version = 0x40000000, /* SuperSPARC 3.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000000, /* SuperSPARC 3.x, MXCC */
@@ -469,7 +469,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI SuperSparc 60", /* STP1020APGA */
+        .name = "TI-SuperSparc-60", /* STP1020APGA */
         .iu_version = 0x40000000, /* SuperSPARC 3.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000800, /* SuperSPARC 3.x, no MXCC */
@@ -482,7 +482,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI SuperSparc 61",
+        .name = "TI-SuperSparc-61",
         .iu_version = 0x44000000, /* SuperSPARC 3.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000000, /* SuperSPARC 3.x, MXCC */
@@ -496,7 +496,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI SuperSparc II",
+        .name = "TI-SuperSparc-II",
         .iu_version = 0x40000000, /* SuperSPARC II 1.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x08000000, /* SuperSPARC II 1.x, MXCC */
-- 
2.39.2


