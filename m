Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E192CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHEe-0008Fo-Iq; Mon, 14 Jul 2025 07:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH05-0001Ej-5v
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH01-0001um-8c
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAFYBMqDkt14ySi0Xw+9xNW0w03TjzSq5ICCJDbgD3I=;
 b=MZ7OX2PuIA2zpED9wfAsXOk+ggb5dLXDmnMzkSG+fZCPQIl5ZWTnJtAlXzd1PvDcO9wBFY
 sPRGJwF0EzS0NOv2qjiy5js2jzGrs0tKu4QGtqkMWXz7fQ3asTNwyGCA+RCiRvBoAxzPoa
 GeH0EsKRGP1SFIKt8t52qcnH61stNrs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-5ycy_HUiMFmIibCKqJHgiA-1; Mon, 14 Jul 2025 07:05:31 -0400
X-MC-Unique: 5ycy_HUiMFmIibCKqJHgiA-1
X-Mimecast-MFC-AGG-ID: 5ycy_HUiMFmIibCKqJHgiA_1752491130
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4561c67daebso2041675e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491129; x=1753095929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bAFYBMqDkt14ySi0Xw+9xNW0w03TjzSq5ICCJDbgD3I=;
 b=FDKYOeN8vNGPodWVI6fGJpQmHCz0GoGYGrkomLhq4MJX0IepzJhos/870gHQescllf
 //vejiD5Rf3Zp9TMjstJBTgwzpItlqFv4NtPBl2zdQpZaSRM3eF1vdL0tq7gHVp4IDiP
 /LjkBVCg1vP+WLCv0/1iexZAkt0CaeFYW9eVBXr5fCI+cG/q1ujD6A+rEbh6SeAui7AB
 fkPxQFj2+eWSr88B7kWoi9rDucoyn3sjjm9KehS0/JTHBl/NcWCZQzrglIjq6Z0nQ7ac
 unkofwFwJ3KW01zmXAV33wAKBa7QvzOy2q7/S2j9WVKyu4aOf6EtcCbElu5wTxhOcL0m
 CDoQ==
X-Gm-Message-State: AOJu0YxSW0X8Ws9LmsmwR0uA+IhieUViZvajDSkrOi3kxSPpMqcbXjIg
 TOumUwn9ElUpV/q4dM6Zc0Oec166ntmeQ6VJ8e/3TFSBS9mreOHLgSqtcQswvLkVx2KCE12vI2G
 WivIIrfZ+icoUQyyJ9hebBgSwTm3c8mYQ3OVDSt//ujkIdPopoqUqwcxLU0tSy2Cy61jOLI26QK
 y4el3NlXTBfshIRDISpBxieb/DSfhXeK2Y5lW/e8v/
X-Gm-Gg: ASbGncvuzCKm56oej91ZGKEZkUrMvR8hmunxHRaBfrN6p4yaKeDyUspS0au7up44Mhc
 SA6NZ9blJ7s15jw0mqUau+gdYWodeJzKIZ2nHqNN4ymh7TeYwW0JHd9W3gfzEEt99kPBWvujUsN
 cK0TE2RWL5lNrrKISQFcCC5RnlpPOQFBVYWGwvL9tYPDMPom7xXuzRzZ5NRcjHbyIeuWAsTYKEV
 Kk/0KfOH+w/KAimfOl3tbzcTSYqng2uEDs7ptCd13hlZohi+WGFwFa85XN3kc6S95y4ChxeveHZ
 FE/SsNzf1UAgi+29JoLscKi2larTFBDCzGaD4PS0Cn4=
X-Received: by 2002:a05:600c:4e08:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-454e31d6d6fmr121554365e9.3.1752491129293; 
 Mon, 14 Jul 2025 04:05:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0vM9DOBjyUWqieFVCBul1Ha39Puft5Dh5adfBiIWwg3oFstKafSOHcmt1Ef3KM/K44eGYHQ==
X-Received: by 2002:a05:600c:4e08:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-454e31d6d6fmr121553845e9.3.1752491128648; 
 Mon, 14 Jul 2025 04:05:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc3a62sm11962455f8f.40.2025.07.14.04.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 30/77] backends/igvm: Handle policy for SEV guests
Date: Mon, 14 Jul 2025 13:03:19 +0200
Message-ID: <20250714110406.117772-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

Adds a handler for the guest policy initialization IGVM section and
builds an SEV policy based on this information and the ID block
directive if present. The policy is applied using by calling
'set_guest_policy()' on the ConfidentialGuestSupport object.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/57707230bef331b53e9366ce6a23ed25cd6f1293.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/igvm.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index ebdb4594d10..b568f06c769 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -27,6 +27,40 @@ typedef struct QIgvmParameterData {
     uint32_t index;
 } QIgvmParameterData;
 
+/*
+ * Some directives are specific to particular confidential computing platforms.
+ * Define required types for each of those platforms here.
+ */
+
+/* SEV/SEV-ES/SEV-SNP */
+
+/*
+ * These structures are defined in "SEV Secure Nested Paging Firmware ABI
+ * Specification" Rev 1.58, section 8.18.
+ */
+struct QEMU_PACKED sev_id_block {
+    uint8_t ld[48];
+    uint8_t family_id[16];
+    uint8_t image_id[16];
+    uint32_t version;
+    uint32_t guest_svn;
+    uint64_t policy;
+};
+
+struct QEMU_PACKED sev_id_authentication {
+    uint32_t id_key_alg;
+    uint32_t auth_key_algo;
+    uint8_t reserved[56];
+    uint8_t id_block_sig[512];
+    uint8_t id_key[1028];
+    uint8_t reserved2[60];
+    uint8_t id_key_sig[512];
+    uint8_t author_key[1028];
+    uint8_t reserved3[892];
+};
+
+#define IGVM_SEV_ID_BLOCK_VERSION 1
+
 /*
  * QIgvm contains the information required during processing
  * of a single IGVM file.
@@ -38,6 +72,17 @@ typedef struct QIgvm {
     uint32_t compatibility_mask;
     unsigned current_header_index;
     QTAILQ_HEAD(, QIgvmParameterData) parameter_data;
+    IgvmPlatformType platform_type;
+
+    /*
+     * SEV-SNP platforms can contain an ID block and authentication
+     * that should be verified by the guest.
+     */
+    struct sev_id_block *id_block;
+    struct sev_id_authentication *id_auth;
+
+    /* Define the guest policy for SEV guests */
+    uint64_t sev_policy;
 
     /* These variables keep track of contiguous page regions */
     IGVM_VHS_PAGE_DATA region_prev_page_data;
@@ -67,6 +112,11 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
 static int qigvm_directive_required_memory(QIgvm *ctx,
                                            const uint8_t *header_data,
                                            Error **errp);
+static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
+                                  Error **errp);
+static int qigvm_initialization_guest_policy(QIgvm *ctx,
+                                       const uint8_t *header_data,
+                                       Error **errp);
 
 struct QIGVMHandler {
     uint32_t type;
@@ -91,6 +141,10 @@ static struct QIGVMHandler handlers[] = {
       qigvm_directive_environment_info },
     { IGVM_VHT_REQUIRED_MEMORY, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_required_memory },
+    { IGVM_VHT_SNP_ID_BLOCK, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_snp_id_block },
+    { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
+      qigvm_initialization_guest_policy },
 };
 
 static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
@@ -632,6 +686,74 @@ static int qigvm_directive_required_memory(QIgvm *ctx,
     return 0;
 }
 
+static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
+                                  Error **errp)
+{
+    const IGVM_VHS_SNP_ID_BLOCK *igvm_id =
+        (const IGVM_VHS_SNP_ID_BLOCK *)header_data;
+
+    if (!(igvm_id->compatibility_mask & ctx->compatibility_mask)) {
+        return 0;
+    }
+
+    if (ctx->id_block) {
+        error_setg(errp, "IGVM: Multiple ID blocks encountered "
+                            "in IGVM file.");
+        return -1;
+    }
+    ctx->id_block = g_new0(struct sev_id_block, 1);
+    ctx->id_auth = g_new0(struct sev_id_authentication, 1);
+
+    memcpy(ctx->id_block->family_id, igvm_id->family_id,
+            sizeof(ctx->id_block->family_id));
+    memcpy(ctx->id_block->image_id, igvm_id->image_id,
+            sizeof(ctx->id_block->image_id));
+    ctx->id_block->guest_svn = igvm_id->guest_svn;
+    ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
+    memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
+
+    ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
+    assert(sizeof(igvm_id->id_key_signature) <=
+           sizeof(ctx->id_auth->id_block_sig));
+    memcpy(ctx->id_auth->id_block_sig, &igvm_id->id_key_signature,
+           sizeof(igvm_id->id_key_signature));
+
+    ctx->id_auth->auth_key_algo = igvm_id->author_key_algorithm;
+    assert(sizeof(igvm_id->author_key_signature) <=
+           sizeof(ctx->id_auth->id_key_sig));
+    memcpy(ctx->id_auth->id_key_sig, &igvm_id->author_key_signature,
+           sizeof(igvm_id->author_key_signature));
+
+    /*
+     * SEV and IGVM public key structure population are slightly different.
+     * See SEV Secure Nested Paging Firmware ABI Specification, Chapter 10.
+     */
+    *((uint32_t *)ctx->id_auth->id_key) = igvm_id->id_public_key.curve;
+    memcpy(&ctx->id_auth->id_key[4], &igvm_id->id_public_key.qx, 72);
+    memcpy(&ctx->id_auth->id_key[76], &igvm_id->id_public_key.qy, 72);
+
+    *((uint32_t *)ctx->id_auth->author_key) =
+        igvm_id->author_public_key.curve;
+    memcpy(&ctx->id_auth->author_key[4], &igvm_id->author_public_key.qx,
+            72);
+    memcpy(&ctx->id_auth->author_key[76], &igvm_id->author_public_key.qy,
+            72);
+
+    return 0;
+}
+
+static int qigvm_initialization_guest_policy(QIgvm *ctx,
+                                       const uint8_t *header_data, Error **errp)
+{
+    const IGVM_VHS_GUEST_POLICY *guest =
+        (const IGVM_VHS_GUEST_POLICY *)header_data;
+
+    if (guest->compatibility_mask & ctx->compatibility_mask) {
+        ctx->sev_policy = guest->policy;
+    }
+    return 0;
+}
+
 static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
 {
     int32_t header_count;
@@ -701,12 +823,16 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
     /* Choose the strongest supported isolation technology */
     if (compatibility_mask_sev_snp != 0) {
         ctx->compatibility_mask = compatibility_mask_sev_snp;
+        ctx->platform_type = IGVM_PLATFORM_TYPE_SEV_SNP;
     } else if (compatibility_mask_sev_es != 0) {
         ctx->compatibility_mask = compatibility_mask_sev_es;
+        ctx->platform_type = IGVM_PLATFORM_TYPE_SEV_ES;
     } else if (compatibility_mask_sev != 0) {
         ctx->compatibility_mask = compatibility_mask_sev;
+        ctx->platform_type = IGVM_PLATFORM_TYPE_SEV;
     } else if (compatibility_mask != 0) {
         ctx->compatibility_mask = compatibility_mask;
+        ctx->platform_type = IGVM_PLATFORM_TYPE_NATIVE;
     } else {
         error_setg(
             errp,
@@ -716,6 +842,23 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
     return 0;
 }
 
+static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
+{
+    if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
+        int id_block_len = 0;
+        int id_auth_len = 0;
+        if (ctx->id_block) {
+            ctx->id_block->policy = ctx->sev_policy;
+            id_block_len = sizeof(struct sev_id_block);
+            id_auth_len = sizeof(struct sev_id_authentication);
+        }
+        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
+                                          ctx->id_block, id_block_len,
+                                          ctx->id_auth, id_auth_len, errp);
+    }
+    return 0;
+}
+
 static IgvmHandle qigvm_file_init(char *filename, Error **errp)
 {
     IgvmHandle igvm;
@@ -814,12 +957,18 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
      */
     retval = qigvm_process_mem_page(&ctx, NULL, errp);
 
+    if (retval == 0) {
+        retval = qigvm_handle_policy(&ctx, errp);
+    }
+
 cleanup_parameters:
     QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
     {
         g_free(parameter->data);
         parameter->data = NULL;
     }
+    g_free(ctx.id_block);
+    g_free(ctx.id_auth);
 
 cleanup:
     igvm_free(ctx.file);
-- 
2.50.0


