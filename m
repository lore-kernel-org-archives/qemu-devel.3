Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD03606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g1iYYANh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU6ZY-0007HP-Fi; Thu, 19 Nov 2026 13:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xU6ZV-0007Fk-WC
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:09:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xU6ZT-0002g8-Vd
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795111756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jkIlbtmZVumTJJBY5ABYx0TdF26cp657auFpnsOuiRk=;
 b=g1iYYANhhLrFEuByIBa0oSzF1r2B5JHPMRiHp5YGz9KrqAyxFkBEYVtezPI+jZeu/x4mRS
 h7sYeUKXz7scRG44U5dROwRhhk7lk8Zu6Vu877IhsbiXM/jT83uPFUW332fN5tpbeqRY/H
 vU+J9jWQKxKVTpXJKXUFEhPBBBnp3vc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-x9NM4C08O_ORDXCuauK3yQ-1; Thu,
 19 Nov 2026 13:09:09 -0500
X-MC-Unique: x9NM4C08O_ORDXCuauK3yQ-1
X-Mimecast-MFC-AGG-ID: x9NM4C08O_ORDXCuauK3yQ_1795111748
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FD681800546; Thu, 19 Nov 2026 18:09:08 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E593430000D3; Thu, 19 Nov 2026 18:09:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH] i386/cpu: mark CPU properties as const
Date: Thu, 19 Nov 2026 13:08:59 -0500
Message-ID: <20261119180859.1044425-1-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, these large property tables are loaded in the read-write
`.data` segment; by marking them as const they can be loaded as part
of `.rodata` instead, where these tables can be shared between multiple
instances of QEMU as RssFile memory instead of RssAnon memory.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 target/i386/cpu-internal.h |  2 +-
 target/i386/cpu-system.c   |  2 +-
 target/i386/cpu.c          | 30 +++++++++++++++---------------
 target/i386/kvm/tdx.c      |  2 +-
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 7f234cfd1b7..fbe767ca906 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -53,7 +53,7 @@ typedef struct FeatureWordInfo {
     uint64_t no_autoenable_flags;
 } FeatureWordInfo;
 
-extern FeatureWordInfo feature_word_info[];
+extern const FeatureWordInfo feature_word_info[];
 
 void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
 
diff --git a/target/i386/cpu-system.c b/target/i386/cpu-system.c
index c03cece7bd8..50de1170447 100644
--- a/target/i386/cpu-system.c
+++ b/target/i386/cpu-system.c
@@ -62,7 +62,7 @@ static QDict *x86_cpu_static_props(void)
     }
 
     for (w = 0; w < FEATURE_WORDS; w++) {
-        FeatureWordInfo *fi = &feature_word_info[w];
+        const FeatureWordInfo *fi = &feature_word_info[w];
         int bit;
         for (bit = 0; bit < 64; bit++) {
             if (!fi->feat_names[bit]) {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eab0d5a4d4a..988193207f8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -78,7 +78,7 @@ struct CPUID2CacheDescriptorInfo {
  * TLB, prefetch and sectored cache related descriptors are not included.
  * From Intel SDM Volume 2A, CPUID instruction
  */
-struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
+const struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
     [0x06] = { .level = 1, .type = INSTRUCTION_CACHE, .size =   8 * KiB,
                .associativity = 4,  .line_size = 32, },
     [0x08] = { .level = 1, .type = INSTRUCTION_CACHE, .size =  16 * KiB,
@@ -241,7 +241,7 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache, bool *unmacthed)
     assert(cache->line_size > 0);
     assert(cache->associativity > 0);
     for (i = 0; i < ARRAY_SIZE(cpuid2_cache_descriptors); i++) {
-        struct CPUID2CacheDescriptorInfo *d = &cpuid2_cache_descriptors[i];
+        const struct CPUID2CacheDescriptorInfo *d = &cpuid2_cache_descriptors[i];
         if (d->level == cache->level && d->type == cache->type &&
             d->size == cache->size && d->line_size == cache->line_size &&
             d->associativity == cache->associativity) {
@@ -1047,7 +1047,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
             CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE | \
             CPUID_8000_0021_EAX_KERNEL_FEATURES)
 
-FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
+const FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -1879,7 +1879,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
 
 bool is_feature_word_cpuid(uint32_t feature, uint32_t index, int reg)
 {
-    FeatureWordInfo *wi;
+    const FeatureWordInfo *wi;
     FeatureWord w;
 
     for (w = 0; w < FEATURE_WORDS; w++) {
@@ -2223,7 +2223,7 @@ static inline uint64_t x86_cpu_xsave_xss_components(X86CPU *cpu)
  */
 static uint64_t x86_cpu_get_migratable_flags(X86CPU *cpu, FeatureWord w)
 {
-    FeatureWordInfo *wi = &feature_word_info[w];
+    const FeatureWordInfo *wi = &feature_word_info[w];
     CPUX86State *env = &cpu->env;
     uint64_t r = 0;
     int i;
@@ -2458,7 +2458,7 @@ static const CPUCaches epyc_cache_info = {
     },
 };
 
-static CPUCaches epyc_v4_cache_info = {
+static const CPUCaches epyc_v4_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
         .level = 1,
@@ -2512,7 +2512,7 @@ static CPUCaches epyc_v4_cache_info = {
     },
 };
 
-static CPUCaches epyc_v5_cache_info = {
+static const CPUCaches epyc_v5_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
         .level = 1,
@@ -7422,7 +7422,7 @@ static const TypeInfo max_x86_cpu_type_info = {
     .class_init = max_x86_cpu_class_init,
 };
 
-static char *feature_word_description(FeatureWordInfo *f)
+static char *feature_word_description(const FeatureWordInfo *f)
 {
     assert(f->type == CPUID_FEATURE_WORD || f->type == MSR_FEATURE_WORD);
 
@@ -7463,7 +7463,7 @@ void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
                                const char *verbose_prefix)
 {
     CPUX86State *env = &cpu->env;
-    FeatureWordInfo *f = &feature_word_info[w];
+    const FeatureWordInfo *f = &feature_word_info[w];
     int i;
     g_autofree char *feat_word_str = feature_word_description(f);
 
@@ -7491,7 +7491,7 @@ void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
                              const char *verbose_prefix)
 {
     CPUX86State *env = &cpu->env;
-    FeatureWordInfo *f = &feature_word_info[w];
+    const FeatureWordInfo *f = &feature_word_info[w];
     int i;
 
     if (!cpu->force_features) {
@@ -7794,7 +7794,7 @@ static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
     X86CPUFeatureWordInfoList *list = NULL;
 
     for (w = 0; w < FEATURE_WORDS; w++) {
-        FeatureWordInfo *wi = &feature_word_info[w];
+        const FeatureWordInfo *wi = &feature_word_info[w];
         /*
                 * We didn't have MSR features when "feature-words" was
                 *  introduced. Therefore skipped other type entries.
@@ -8111,7 +8111,7 @@ static void x86_cpu_list(void)
 
     names = NULL;
     for (i = 0; i < ARRAY_SIZE(feature_word_info); i++) {
-        FeatureWordInfo *fw = &feature_word_info[i];
+        const FeatureWordInfo *fw = &feature_word_info[i];
         for (j = 0; j < 64; j++) {
             if (fw->feat_names[j]) {
                 names = g_list_append(names, (gpointer)fw->feat_names[j]);
@@ -8214,7 +8214,7 @@ static uint8_t x86_cpu_get_host_avx10_version(void)
 
 uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 {
-    FeatureWordInfo *wi = &feature_word_info[w];
+    const FeatureWordInfo *wi = &feature_word_info[w];
     uint64_t r = 0;
     uint64_t unavail = 0;
 
@@ -9617,7 +9617,7 @@ static void x86_cpu_adjust_level(X86CPU *cpu, uint32_t *min, uint32_t value)
 static void x86_cpu_adjust_feat_level(X86CPU *cpu, FeatureWord w)
 {
     CPUX86State *env = &cpu->env;
-    FeatureWordInfo *fi = &feature_word_info[w];
+    const FeatureWordInfo *fi = &feature_word_info[w];
     uint32_t eax = fi->cpuid.eax;
     uint32_t region = eax & 0xF0000000;
 
@@ -10497,7 +10497,7 @@ static void x86_cpu_register_feature_bit_props(X86CPUClass *xcc,
                                                FeatureWord w,
                                                int bitnr)
 {
-    FeatureWordInfo *fi = &feature_word_info[w];
+    const FeatureWordInfo *fi = &feature_word_info[w];
     const char *name = fi->feat_names[bitnr];
 
     if (!name) {
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 52bb2ec6ced..ec38e3625a6 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -885,7 +885,7 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
     struct kvm_cpuid_entry2 *entry;
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
-    FeatureWordInfo *wi;
+    const FeatureWordInfo *wi;
     FeatureWord w;
     bool mismatch = false;
     int r = -1;
-- 
2.56.1


