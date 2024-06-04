Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85B8C27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENww-0007yi-UX; Tue, 04 Jun 2024 02:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvz-0004mu-Cd
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvx-0007eO-G8
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=15EXu4vw0Eg5jrFDQ9InlnGmqmmoGShg6u4MR7nWG+Q=;
 b=Zzd245zuS3W1XgVsuDqCaM96Zd0C9lEXwdoF9DZXYiwzMMp7yvBokkCLlTTyDu79PETmQX
 YlOHZLVYIcuuFukvqv5M55TZiq7W8PrZ/r/r+EFK4LIJAPmuNDI/LE0MWhlfURDMOM4sOP
 1nP42BNB18oBguzWwb9dConsLHYX0Jg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-rMUyVgbPPwOG0KqAb7n_qw-1; Tue, 04 Jun 2024 02:46:11 -0400
X-MC-Unique: rMUyVgbPPwOG0KqAb7n_qw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a68bc8444f7so73350966b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483569; x=1718088369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15EXu4vw0Eg5jrFDQ9InlnGmqmmoGShg6u4MR7nWG+Q=;
 b=jlOuxuObOsy3+zfPE0a/FJ3Z7F4pKmuu/TiTiJt10xApTuPmuKTR9oADWRZ0jkU0//
 QxyRnsHUJ1XQZEgudIPobRMDcIcZxs2DxJSSJv9231T/jLrXESPrbVDtB5ueqfheXbjZ
 GNxj2UHqO10ti33x4JDm/23qDwAScvaJhj4QsNAnkd+LqHgx/yyKU84XOayWNLtA1iAz
 4jEKc5/o2cd5JZxI7L0Ss4dJz7AzCUOiWD/rh1Z0zuGImT3/CGqjm1eclb/gBQisarjv
 Rtjq65TYBWsLN/tzvBcYvfDfKwGJvgejBbV4asMSGP33WUWV2ZKmXGcm6zJXV4//6IzP
 HEDg==
X-Gm-Message-State: AOJu0Yx6WbJVya7oP8KSjJJp2v6mpU7hYIcM6754r+o4bDIgU4aTtctv
 sBqRGFrfg0KuCR2Welhgy558+ud3EhvOJvmBlGRMmbi8eBssLgoV2DSAfOnxrLyiI5K/bI0WMMI
 R0QjGe27zMUoMj1I4kSf3XQutCXPlWRY2ko0yO/nglSwmyOECwTk+v+ROvSj4m7+uhpQcZ4cJDI
 oX1jFLS4tf8H2kfu8ve85Kh5ByjjeolfYzLkbc
X-Received: by 2002:a50:d4d6:0:b0:578:5756:1519 with SMTP id
 4fb4d7f45d1cf-57a3637f588mr9668001a12.16.1717483568819; 
 Mon, 03 Jun 2024 23:46:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM3uKBIDz5fRwGVprnCP1O8rVtB2HhQyXRuCbrkg2UkFPpQ3rKOHM1RvtXVOighnzPFP158A==
X-Received: by 2002:a50:d4d6:0:b0:578:5756:1519 with SMTP id
 4fb4d7f45d1cf-57a3637f588mr9667985a12.16.1717483568371; 
 Mon, 03 Jun 2024 23:46:08 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a5dc1e2d6sm3756274a12.59.2024.06.03.23.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:46:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dov Murik <dovmurik@linux.ibm.com>, Michael Roth <michael.roth@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 42/45] i386/sev: Allow measured direct kernel boot on SNP
Date: Tue,  4 Jun 2024 08:44:06 +0200
Message-ID: <20240604064409.957105-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Dov Murik <dovmurik@linux.ibm.com>

In SNP, the hashes page designated with a specific metadata entry
published in AmdSev OVMF.

Therefore, if the user enabled kernel hashes (for measured direct boot),
QEMU should prepare the content of hashes table, and during the
processing of the metadata entry it copy the content into the designated
page and encrypt it.

Note that in SNP (unlike SEV and SEV-ES) the measurements is done in
whole 4KB pages.  Therefore QEMU zeros the whole page that includes the
hashes table, and fills in the kernel hashes area in that page, and then
encrypts the whole page.  The rest of the page is reserved for SEV
launch secrets which are not usable anyway on SNP.

If the user disabled kernel hashes, QEMU pre-validates the kernel hashes
page as a zero page.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-24-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h |   2 +
 target/i386/sev.c    | 113 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 86 insertions(+), 29 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c653b8eeb24..ca7904ac2c4 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -172,6 +172,8 @@ typedef enum {
     SEV_DESC_TYPE_SNP_SECRETS,
     /* The section contains address that can be used as a CPUID page */
     SEV_DESC_TYPE_CPUID,
+    /* The section contains the region for kernel hashes for measured direct boot */
+    SEV_DESC_TYPE_SNP_KERNEL_HASHES = 0x10,
 
 } ovmf_sev_metadata_desc_type;
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 3fce4c08ebb..004c667ac14 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -115,6 +115,10 @@ struct SevCommonStateClass {
     X86ConfidentialGuestClass parent_class;
 
     /* public */
+    bool (*build_kernel_loader_hashes)(SevCommonState *sev_common,
+                                       SevHashTableDescriptor *area,
+                                       SevKernelLoaderContext *ctx,
+                                       Error **errp);
     int (*launch_start)(SevCommonState *sev_common);
     void (*launch_finish)(SevCommonState *sev_common);
     int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa, uint8_t *ptr, uint64_t len);
@@ -154,6 +158,9 @@ struct SevSnpGuestState {
 
     struct kvm_sev_snp_launch_start kvm_start_conf;
     struct kvm_sev_snp_launch_finish kvm_finish_conf;
+
+    uint32_t kernel_hashes_offset;
+    PaddedSevHashTable *kernel_hashes_data;
 };
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
@@ -1189,6 +1196,23 @@ snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, uint32_t cpuid_len)
                                   KVM_SEV_SNP_PAGE_TYPE_CPUID);
 }
 
+static int
+snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
+                                void *hva, uint32_t len)
+{
+    int type = KVM_SEV_SNP_PAGE_TYPE_ZERO;
+    if (sev_snp->parent_obj.kernel_hashes) {
+        assert(sev_snp->kernel_hashes_data);
+        assert((sev_snp->kernel_hashes_offset +
+                sizeof(*sev_snp->kernel_hashes_data)) <= len);
+        memset(hva, 0, len);
+        memcpy(hva + sev_snp->kernel_hashes_offset, sev_snp->kernel_hashes_data,
+               sizeof(*sev_snp->kernel_hashes_data));
+        type = KVM_SEV_SNP_PAGE_TYPE_NORMAL;
+    }
+    return snp_launch_update_data(addr, hva, len, type);
+}
+
 static int
 snp_metadata_desc_to_page_type(int desc_type)
 {
@@ -1225,6 +1249,9 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
 
         if (type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
             ret = snp_launch_update_cpuid(desc->base, hva, desc->len);
+        } else if (desc->type == SEV_DESC_TYPE_SNP_KERNEL_HASHES) {
+            ret = snp_launch_update_kernel_hashes(sev_snp, desc->base, hva,
+                                                  desc->len);
         } else {
             ret = snp_launch_update_data(desc->base, hva, desc->len, type);
         }
@@ -1823,40 +1850,31 @@ static bool build_kernel_loader_hashes(PaddedSevHashTable *padded_ht,
     return true;
 }
 
-/*
- * Add the hashes of the linux kernel/initrd/cmdline to an encrypted guest page
- * which is included in SEV's initial memory measurement.
- */
-bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
+static bool sev_snp_build_kernel_loader_hashes(SevCommonState *sev_common,
+                                               SevHashTableDescriptor *area,
+                                               SevKernelLoaderContext *ctx,
+                                               Error **errp)
+{
+    /*
+     * SNP: Populate the hashes table in an area that later in
+     * snp_launch_update_kernel_hashes() will be copied to the guest memory
+     * and encrypted.
+     */
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
+    sev_snp_guest->kernel_hashes_offset = area->base & ~TARGET_PAGE_MASK;
+    sev_snp_guest->kernel_hashes_data = g_new0(PaddedSevHashTable, 1);
+    return build_kernel_loader_hashes(sev_snp_guest->kernel_hashes_data, ctx, errp);
+}
+
+static bool sev_build_kernel_loader_hashes(SevCommonState *sev_common,
+                                           SevHashTableDescriptor *area,
+                                           SevKernelLoaderContext *ctx,
+                                           Error **errp)
 {
-    uint8_t *data;
-    SevHashTableDescriptor *area;
     PaddedSevHashTable *padded_ht;
     hwaddr mapped_len = sizeof(*padded_ht);
     MemTxAttrs attrs = { 0 };
     bool ret = true;
-    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
-
-    /*
-     * Only add the kernel hashes if the sev-guest configuration explicitly
-     * stated kernel-hashes=on.
-     */
-    if (!sev_common->kernel_hashes) {
-        return false;
-    }
-
-    if (!pc_system_ovmf_table_find(SEV_HASH_TABLE_RV_GUID, &data, NULL)) {
-        error_setg(errp, "SEV: kernel specified but guest firmware "
-                         "has no hashes table GUID");
-        return false;
-    }
-
-    area = (SevHashTableDescriptor *)data;
-    if (!area->base || area->size < sizeof(PaddedSevHashTable)) {
-        error_setg(errp, "SEV: guest firmware hashes table area is invalid "
-                         "(base=0x%x size=0x%x)", area->base, area->size);
-        return false;
-    }
 
     /*
      * Populate the hashes table in the guest's memory at the OVMF-designated
@@ -1884,6 +1902,41 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
     return ret;
 }
 
+/*
+ * Add the hashes of the linux kernel/initrd/cmdline to an encrypted guest page
+ * which is included in SEV's initial memory measurement.
+ */
+bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
+{
+    uint8_t *data;
+    SevHashTableDescriptor *area;
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
+
+    /*
+     * Only add the kernel hashes if the sev-guest configuration explicitly
+     * stated kernel-hashes=on.
+     */
+    if (!sev_common->kernel_hashes) {
+        return false;
+    }
+
+    if (!pc_system_ovmf_table_find(SEV_HASH_TABLE_RV_GUID, &data, NULL)) {
+        error_setg(errp, "SEV: kernel specified but guest firmware "
+                         "has no hashes table GUID");
+        return false;
+    }
+
+    area = (SevHashTableDescriptor *)data;
+    if (!area->base || area->size < sizeof(PaddedSevHashTable)) {
+        error_setg(errp, "SEV: guest firmware hashes table area is invalid "
+                         "(base=0x%x size=0x%x)", area->base, area->size);
+        return false;
+    }
+
+    return klass->build_kernel_loader_hashes(sev_common, area, ctx, errp);
+}
+
 static char *
 sev_common_get_sev_device(Object *obj, Error **errp)
 {
@@ -1998,6 +2051,7 @@ sev_guest_class_init(ObjectClass *oc, void *data)
     SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
+    klass->build_kernel_loader_hashes = sev_build_kernel_loader_hashes;
     klass->launch_start = sev_launch_start;
     klass->launch_finish = sev_launch_finish;
     klass->launch_update_data = sev_launch_update_data;
@@ -2242,6 +2296,7 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
     SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
+    klass->build_kernel_loader_hashes = sev_snp_build_kernel_loader_hashes;
     klass->launch_start = sev_snp_launch_start;
     klass->launch_finish = sev_snp_launch_finish;
     klass->launch_update_data = sev_snp_launch_update_data;
-- 
2.45.1


