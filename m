Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E58DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 08:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxjye-0005xz-HC; Fri, 19 Apr 2024 04:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxjyb-0005xV-8X
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxjyY-0008Gf-W8
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713516726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEurQWwIj1ae0zpFiHYFzGSS3+PXFjNqJBQ/9xpNOOI=;
 b=cN5agRlkrKrc1+rvocQ0YLKrgr7BpWfTYgbTQ1mTou46WpBDGSseAfBQhyvSusa1YUI4LY
 I1Ye4qqy3++5cDSiuYv7lPYHDQ0HGy25Jl8NiMCK43zX6GLhHfSl43Go8V4geQz+/CIQhm
 jHASWlqm8C6GYWiGKCBBQF9G5eQoT9A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-eiDEitBkMke1VTFcydvbtA-1; Fri, 19 Apr 2024 04:48:21 -0400
X-MC-Unique: eiDEitBkMke1VTFcydvbtA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9467180D730;
 Fri, 19 Apr 2024 08:48:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 922591121306;
 Fri, 19 Apr 2024 08:48:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 2/4] target/sparc/cpu: Avoid spaces by default in the CPU
 names
Date: Fri, 19 Apr 2024 10:48:10 +0200
Message-ID: <20240419084812.504779-3-thuth@redhat.com>
In-Reply-To: <20240419084812.504779-1-thuth@redhat.com>
References: <20240419084812.504779-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 target/sparc/cpu.c | 56 +++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 774e234e09..593c8d6867 100644
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
2.44.0


