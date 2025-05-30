Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A357C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtzv-0007xr-6H; Fri, 30 May 2025 03:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxw-0004ZB-8j
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxr-0007GB-Mt
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCTF0rSz88DU0JnX/EsayPiOfrvZ86xmcyCxYqYPhI8=;
 b=FLD9ITnIKpHTT1sX1HLWGuxqMflW6CB/YmDMBuNum2KCzhMdFoXbHdwkwz8ZXkG4kke+NY
 GtIB1+GMWBQ8Dbr7X0R+7XjuxGhCrz8Jq5uHZKFsPJfeR4MuI/8Se0DaryhueF5b/bGbXw
 E5jH2FU/RO/0V6M0no9STIDqtR1V/OE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-4z9GSlxJPdSsWJNDCsM_bg-1; Fri, 30 May 2025 03:15:37 -0400
X-MC-Unique: 4z9GSlxJPdSsWJNDCsM_bg-1
X-Mimecast-MFC-AGG-ID: 4z9GSlxJPdSsWJNDCsM_bg_1748589336
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad8a0eef39bso111586766b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589336; x=1749194136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cCTF0rSz88DU0JnX/EsayPiOfrvZ86xmcyCxYqYPhI8=;
 b=gVJRgqdlb6ddaE3EulzvvoXNvVB5FdeHOUxjyhhsbcqtapgQaHVDmj68eevPpDIFIP
 6J1ep6d5hfoQ1sNaszgYORb6Ik3YVhd73qU3Dd1Fp5FkWcMAy+Fb98WjVY4tlIjGUNlG
 IVb92dwFIujiSLiSQN/75fKDZmvk4EIdlls58DGHjfMaZ8dj2/G4FeMRegrSeG6ZjdIr
 CYbw7rfG5FMoaVZXTC+lS1T1W/2mikEOJF21U+5SZgCbOq2UWXGLdDGYKp+SVaPaysln
 c3rT9AYbRhvqxjKzQACbmOOopdZQ+GuOTqvGQMgdrezK8GPBiDEDzURlY+xuXxW13Q6A
 apgw==
X-Gm-Message-State: AOJu0YxVTWEnEfu0VHlIU68pDi16BYQHaYll1oItYDdAf8YKvdBPdmQ+
 3bRWDYKYCY9JBo7UM8ULut4PAa8lPU2KHQoq6lW6Mbmfrb3whBawrikA7niY4Cexhod4PsR67QT
 OM/nT5wGhvDpwksbdwtie7VlG4H1pKNitL+OP/252Pm5fny4a2N4seyDkchbG3uQNZpG8MtB3gF
 zHl8q2Pi8tOfwjT+if3zEz9BaIKWC1aYTOLYdWE4+B
X-Gm-Gg: ASbGncuViOJzqT9Ujp2v7O/7BZBgkQTHryjyecT2CfnP1Uu5vFI3DcNxzp0+/ilu4ql
 Vd2Q4vWoaiUSxS+xa6kPUR52Pk3dNsSsRVUlWxJvhFzTT7+sSw/fV9TPbx7HSPXT5mxq62Bg9Fc
 bWY7ttXhEpkYQA/A18P9a64Lmr95rh0IYYEGOtY2t4+JmgsUsLo08d0gqKHL2564oNUjDZAsGH/
 vzpzJOCeGGqc6LvU4b/9a58zyEnsERyXim0//ELd3T20/GDH4eA6nXBMt73WiZ2GtwVM1LAdUyt
 YGPlMd1IDzBcgg==
X-Received: by 2002:a17:907:2d0c:b0:ad8:87a1:4da8 with SMTP id
 a640c23a62f3a-adb322d89bamr206067066b.14.1748589335570; 
 Fri, 30 May 2025 00:15:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwYFWquMQc8l5q0meWH/yqtHI4DbpORaJ6kExBdvX04dab3S/+ZjasxVQy8hp8e382wQXYUQ==
X-Received: by 2002:a17:907:2d0c:b0:ad8:87a1:4da8 with SMTP id
 a640c23a62f3a-adb322d89bamr206063366b.14.1748589334970; 
 Fri, 30 May 2025 00:15:34 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7ff25dsm277250566b.23.2025.05.30.00.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 65/77] i386/tdx: Fetch and validate CPUID of TD guest
Date: Fri, 30 May 2025 09:12:35 +0200
Message-ID: <20250530071250.2050910-66-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Use KVM_TDX_GET_CPUID to get the CPUIDs that are managed and enfored
by TDX module for TD guest. Check QEMU's configuration against the
fetched data.

Print wanring  message when 1. a feature is not supported but requested
by QEMU or 2. QEMU doesn't want to expose a feature while it is enforced
enabled.

- If cpu->enforced_cpuid is not set, prints the warning message of both
1) and 2) and tweak QEMU's configuration.

- If cpu->enforced_cpuid is set, quit if any case of 1) or 2).

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-52-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |   7 +++
 target/i386/cpu.c     |  33 +++++++++++++-
 target/i386/kvm/tdx.c | 101 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8a4b4217d02..22e82444aec 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2215,6 +2215,9 @@ struct ArchCPU {
     /* Features that were filtered out because of missing host capabilities */
     FeatureWordArray filtered_features;
 
+    /* Features that are forced enabled by underlying hypervisor, e.g., TDX */
+    FeatureWordArray forced_on_features;
+
     /* Enable PMU CPUID bits. This can't be enabled by default yet because
      * it doesn't have ABI stability guarantees, as it passes all PMU CPUID
      * bits returned by GET_SUPPORTED_CPUID (that depend on host CPU and kernel
@@ -2526,6 +2529,10 @@ void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 bool cpu_has_x2apic_feature(CPUX86State *env);
 bool is_feature_word_cpuid(uint32_t feature, uint32_t index, int reg);
+void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                               const char *verbose_prefix);
+void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                             const char *verbose_prefix);
 
 static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index be3812973f6..34364cf96ae 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5808,8 +5808,8 @@ static bool x86_cpu_have_filtered_features(X86CPU *cpu)
     return false;
 }
 
-static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
-                                      const char *verbose_prefix)
+void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                               const char *verbose_prefix)
 {
     CPUX86State *env = &cpu->env;
     FeatureWordInfo *f = &feature_word_info[w];
@@ -5836,6 +5836,35 @@ static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
     }
 }
 
+void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                             const char *verbose_prefix)
+{
+    CPUX86State *env = &cpu->env;
+    FeatureWordInfo *f = &feature_word_info[w];
+    int i;
+
+    if (!cpu->force_features) {
+        env->features[w] |= mask;
+    }
+
+    cpu->forced_on_features[w] |= mask;
+
+    if (!verbose_prefix) {
+        return;
+    }
+
+    for (i = 0; i < 64; ++i) {
+        if ((1ULL << i) & mask) {
+            g_autofree char *feat_word_str = feature_word_description(f);
+            warn_report("%s: %s%s%s [bit %d]",
+                        verbose_prefix,
+                        feat_word_str,
+                        f->feat_names[i] ? "." : "",
+                        f->feat_names[i] ? f->feat_names[i] : "", i);
+        }
+    }
+}
+
 static void x86_cpuid_version_get_family(Object *obj, Visitor *v,
                                          const char *name, void *opaque,
                                          Error **errp)
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index e35983ad9bd..e474abf3a60 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -766,6 +766,106 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
     return value;
 }
 
+static struct kvm_cpuid2 *tdx_fetch_cpuid(CPUState *cpu, int *ret)
+{
+    struct kvm_cpuid2 *fetch_cpuid;
+    int size = KVM_MAX_CPUID_ENTRIES;
+    Error *local_err = NULL;
+    int r;
+
+    do {
+        error_free(local_err);
+        local_err = NULL;
+
+        fetch_cpuid = g_malloc0(sizeof(*fetch_cpuid) +
+                                sizeof(struct kvm_cpuid_entry2) * size);
+        fetch_cpuid->nent = size;
+        r = tdx_vcpu_ioctl(cpu, KVM_TDX_GET_CPUID, 0, fetch_cpuid, &local_err);
+        if (r == -E2BIG) {
+            g_free(fetch_cpuid);
+            size = fetch_cpuid->nent;
+        }
+    } while (r == -E2BIG);
+
+    if (r < 0) {
+        error_report_err(local_err);
+        *ret = r;
+        return NULL;
+    }
+
+    return fetch_cpuid;
+}
+
+static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
+{
+    uint64_t actual, requested, unavailable, forced_on;
+    g_autofree struct kvm_cpuid2 *fetch_cpuid;
+    const char *forced_on_prefix = NULL;
+    const char *unav_prefix = NULL;
+    struct kvm_cpuid_entry2 *entry;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    FeatureWordInfo *wi;
+    FeatureWord w;
+    bool mismatch = false;
+    int r;
+
+    fetch_cpuid = tdx_fetch_cpuid(cs, &r);
+    if (!fetch_cpuid) {
+        return r;
+    }
+
+    if (cpu->check_cpuid || cpu->enforce_cpuid) {
+        unav_prefix = "TDX doesn't support requested feature";
+        forced_on_prefix = "TDX forcibly sets the feature";
+    }
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        wi = &feature_word_info[w];
+        actual = 0;
+
+        switch (wi->type) {
+        case CPUID_FEATURE_WORD:
+            entry = cpuid_find_entry(fetch_cpuid, wi->cpuid.eax, wi->cpuid.ecx);
+            if (!entry) {
+                /*
+                 * If KVM doesn't report it means it's totally configurable
+                 * by QEMU
+                 */
+                continue;
+            }
+
+            actual = cpuid_entry_get_reg(entry, wi->cpuid.reg);
+            break;
+        case MSR_FEATURE_WORD:
+            /*
+             * TODO:
+             * validate MSR features when KVM has interface report them.
+             */
+            continue;
+        }
+
+        requested = env->features[w];
+        unavailable = requested & ~actual;
+        mark_unavailable_features(cpu, w, unavailable, unav_prefix);
+        if (unavailable) {
+            mismatch = true;
+        }
+
+        forced_on = actual & ~requested;
+        mark_forced_on_features(cpu, w, forced_on, forced_on_prefix);
+        if (forced_on) {
+            mismatch = true;
+        }
+    }
+
+    if (cpu->enforce_cpuid && mismatch) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
 {
     if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
@@ -1161,4 +1261,5 @@ static void tdx_guest_class_init(ObjectClass *oc, const void *data)
     x86_klass->kvm_type = tdx_kvm_type;
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
     x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
+    x86_klass->check_features = tdx_check_features;
 }
-- 
2.49.0


