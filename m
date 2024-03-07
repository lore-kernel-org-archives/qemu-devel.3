Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3A0C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 17:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riHmt-0000tJ-19; Thu, 07 Mar 2024 12:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riHmU-0000fW-1q
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:43:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riHmS-00041C-2t
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709833423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPmJU6DLj8tZZCP7Akw3R7cWOpL9VFTanRI+1Y8sK/w=;
 b=GpUdsAMBJjYlWv4Zv17dJZ0X9iwpX1vFVepW3XuKkGGcriXBO49mwrXsRqbILVAWec9C8p
 6chDBMahxfALUldl3jR5EUvLfLxaIcouLMG0OQaZumjOdZN41DMhLLWQPx9H7K/5C4uURo
 xYdqdbA6cKel3HESjZLW3SN5WCCtrEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-TCip_INrPeOj-ivF9PiuIQ-1; Thu, 07 Mar 2024 12:43:41 -0500
X-MC-Unique: TCip_INrPeOj-ivF9PiuIQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 041C48F8F64;
 Thu,  7 Mar 2024 17:43:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 487F4492BDC;
 Thu,  7 Mar 2024 17:43:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/5] target/sparc/cpu: Avoid spaces by default in the CPU names
Date: Thu,  7 Mar 2024 18:43:31 +0100
Message-ID: <20240307174334.130407-3-thuth@redhat.com>
In-Reply-To: <20240307174334.130407-1-thuth@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The output of "-cpu help" is currently rather confusing to the users:
It is not clear which part of the output defines the CPU names since
the CPU names contain white spaces (which we later have to convert
into dashes internally) For example:

Sparc TI UltraSparc II IU 0017001120000000 FPU 00000000 MMU 00000000 NWINS 8

At a first glance, should the name for -cpu be "Sparc TI Ultrasparc II"
or "TI UltraSparc II IU" here? Both would be wrong, the right guess is
"TI UltraSparc II" only. Let's start cleaning up this mess by using
dashes instead of white spaces for the CPU names, like we're doing it
internally later (and like we're doing it in most other targets of QEMU).
Note that it is still possible to pass the CPU names with spaces to the
"-cpu" option, since sparc_cpu_type_name() still translates those to "-".

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2141
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/sparc/cpu.c | 56 +++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 651e49bfeb..ae30cded22 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -208,7 +208,7 @@ void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu)
 static const sparc_def_t sparc_defs[] = {
 #ifdef TARGET_SPARC64
     {
-        .name = "Fujitsu Sparc64",
+        .name = "Fujitsu-Sparc64",
         .iu_version = ((0x04ULL << 48) | (0x02ULL << 32) | (0ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -217,7 +217,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Fujitsu Sparc64 III",
+        .name = "Fujitsu-Sparc64-III",
         .iu_version = ((0x04ULL << 48) | (0x03ULL << 32) | (0ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -226,7 +226,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Fujitsu Sparc64 IV",
+        .name = "Fujitsu-Sparc64-IV",
         .iu_version = ((0x04ULL << 48) | (0x04ULL << 32) | (0ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -235,7 +235,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Fujitsu Sparc64 V",
+        .name = "Fujitsu-Sparc64-V",
         .iu_version = ((0x04ULL << 48) | (0x05ULL << 32) | (0x51ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -244,7 +244,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI UltraSparc I",
+        .name = "TI-UltraSparc-I",
         .iu_version = ((0x17ULL << 48) | (0x10ULL << 32) | (0x40ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -253,7 +253,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI UltraSparc II",
+        .name = "TI-UltraSparc-II",
         .iu_version = ((0x17ULL << 48) | (0x11ULL << 32) | (0x20ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -262,7 +262,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI UltraSparc IIi",
+        .name = "TI-UltraSparc-IIi",
         .iu_version = ((0x17ULL << 48) | (0x12ULL << 32) | (0x91ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -271,7 +271,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI UltraSparc IIe",
+        .name = "TI-UltraSparc-IIe",
         .iu_version = ((0x17ULL << 48) | (0x13ULL << 32) | (0x14ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -280,7 +280,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc III",
+        .name = "Sun-UltraSparc-III",
         .iu_version = ((0x3eULL << 48) | (0x14ULL << 32) | (0x34ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -289,7 +289,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc III Cu",
+        .name = "Sun-UltraSparc-III-Cu",
         .iu_version = ((0x3eULL << 48) | (0x15ULL << 32) | (0x41ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_3,
@@ -298,7 +298,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc IIIi",
+        .name = "Sun-UltraSparc-IIIi",
         .iu_version = ((0x3eULL << 48) | (0x16ULL << 32) | (0x34ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -307,7 +307,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc IV",
+        .name = "Sun-UltraSparc-IV",
         .iu_version = ((0x3eULL << 48) | (0x18ULL << 32) | (0x31ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_4,
@@ -316,7 +316,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc IVp",
+        .name = "Sun-UltraSparc-IVp",
         .iu_version = ((0x3eULL << 48) | (0x19ULL << 32) | (0x22ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -325,7 +325,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES | CPU_FEATURE_CMT,
     },
     {
-        .name = "Sun UltraSparc IIIip",
+        .name = "Sun-UltraSparc-IIIip",
         .iu_version = ((0x3eULL << 48) | (0x22ULL << 32) | (0ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_3,
@@ -334,7 +334,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc T1",
+        .name = "Sun-UltraSparc-T1",
         /* defined in sparc_ifu_fdp.v and ctu.h */
         .iu_version = ((0x3eULL << 48) | (0x23ULL << 32) | (0x02ULL << 24)),
         .fpu_version = 0x00000000,
@@ -345,7 +345,7 @@ static const sparc_def_t sparc_defs[] = {
         | CPU_FEATURE_GL,
     },
     {
-        .name = "Sun UltraSparc T2",
+        .name = "Sun-UltraSparc-T2",
         /* defined in tlu_asi_ctl.v and n2_revid_cust.v */
         .iu_version = ((0x3eULL << 48) | (0x24ULL << 32) | (0x02ULL << 24)),
         .fpu_version = 0x00000000,
@@ -356,7 +356,7 @@ static const sparc_def_t sparc_defs[] = {
         | CPU_FEATURE_GL,
     },
     {
-        .name = "NEC UltraSparc I",
+        .name = "NEC-UltraSparc-I",
         .iu_version = ((0x22ULL << 48) | (0x10ULL << 32) | (0x40ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -366,7 +366,7 @@ static const sparc_def_t sparc_defs[] = {
     },
 #else
     {
-        .name = "Fujitsu MB86904",
+        .name = "Fujitsu-MB86904",
         .iu_version = 0x04 << 24, /* Impl 0, ver 4 */
         .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
         .mmu_version = 0x04 << 24, /* Impl 0, ver 4 */
@@ -379,7 +379,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Fujitsu MB86907",
+        .name = "Fujitsu-MB86907",
         .iu_version = 0x05 << 24, /* Impl 0, ver 5 */
         .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
         .mmu_version = 0x05 << 24, /* Impl 0, ver 5 */
@@ -392,7 +392,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI MicroSparc I",
+        .name = "TI-MicroSparc-I",
         .iu_version = 0x41000000,
         .fpu_version = 4 << FSR_VER_SHIFT,
         .mmu_version = 0x41000000,
@@ -405,7 +405,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_FEATURE_MUL | CPU_FEATURE_DIV,
     },
     {
-        .name = "TI MicroSparc II",
+        .name = "TI-MicroSparc-II",
         .iu_version = 0x42000000,
         .fpu_version = 4 << FSR_VER_SHIFT,
         .mmu_version = 0x02000000,
@@ -418,7 +418,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI MicroSparc IIep",
+        .name = "TI-MicroSparc-IIep",
         .iu_version = 0x42000000,
         .fpu_version = 4 << FSR_VER_SHIFT,
         .mmu_version = 0x04000000,
@@ -431,7 +431,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI SuperSparc 40", /* STP1020NPGA */
+        .name = "TI-SuperSparc-40", /* STP1020NPGA */
         .iu_version = 0x41000000, /* SuperSPARC 2.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x00000800, /* SuperSPARC 2.x, no MXCC */
@@ -444,7 +444,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI SuperSparc 50", /* STP1020PGA */
+        .name = "TI-SuperSparc-50", /* STP1020PGA */
         .iu_version = 0x40000000, /* SuperSPARC 3.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000800, /* SuperSPARC 3.x, no MXCC */
@@ -457,7 +457,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI SuperSparc 51",
+        .name = "TI-SuperSparc-51",
         .iu_version = 0x40000000, /* SuperSPARC 3.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000000, /* SuperSPARC 3.x, MXCC */
@@ -471,7 +471,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI SuperSparc 60", /* STP1020APGA */
+        .name = "TI-SuperSparc-60", /* STP1020APGA */
         .iu_version = 0x40000000, /* SuperSPARC 3.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000800, /* SuperSPARC 3.x, no MXCC */
@@ -484,7 +484,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI SuperSparc 61",
+        .name = "TI-SuperSparc-61",
         .iu_version = 0x44000000, /* SuperSPARC 3.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000000, /* SuperSPARC 3.x, MXCC */
@@ -498,7 +498,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "TI SuperSparc II",
+        .name = "TI-SuperSparc-II",
         .iu_version = 0x40000000, /* SuperSPARC II 1.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x08000000, /* SuperSPARC II 1.x, MXCC */
-- 
2.44.0


