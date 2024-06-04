Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A057C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwn-0006Tw-S4; Tue, 04 Jun 2024 02:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvT-0004Ka-Om
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvR-0007ar-RZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMPOLamSRHQE7IaaVLuvYJHjbkszPghyVoT4hxWvYC4=;
 b=ek+jKqaauw2NZ3q9SOp/6VrBwK2oQj7uBwwHVdxOfh/s0pSRLr+Phg67jMDNhD72wIMSPm
 r64dcn/sM6KwiRusTp5X2MRq0Od2+OozJ+W5WObO4u3RwzyfdTLogf4oWXcCG0PUax0iD1
 WNFPpcnSkiMDEXjPwb0x5lZpsHp0lF4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-ydpJTyzvMMKKsquPwGO5iA-1; Tue, 04 Jun 2024 02:45:40 -0400
X-MC-Unique: ydpJTyzvMMKKsquPwGO5iA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a68cc214ac7so103219166b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483538; x=1718088338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMPOLamSRHQE7IaaVLuvYJHjbkszPghyVoT4hxWvYC4=;
 b=UE16a5tHuH8/2IbM1yOpBnWKp1E1w0B4WO5gsltoWCkQS9D2RxeaZzS5CGd6osDToB
 TDHLk34GPM3bYmOg9GBe+1EFE+QVkPFy8LCvN/fbKcsno6VwNifYk2vK2eO1lfaCDFdK
 beb/4oQtuQ98gaW6gK1EnXTBCkdq0VFa1z13r6GUOyLLHQUEtMEVhsmrfE3+GEe2ZhzH
 8KHU/CaV1yfiuaOVMBBOlM2FVf3OvqsoBdLABpOXjwRT8v8Q/JFhFUg/yrtvx/oy6CLr
 kfOHmiwoS+8oRSigI9w0wqLxcZTgZFPEsOwsKcDCwIZGLYtHXeftiFRG9iqB0oBN8+4n
 Ts/w==
X-Gm-Message-State: AOJu0YxjqLAfk1qf/WFKke+YLWJd6IaOtM417WutXQO2YDk4fXSPdBZc
 wHdBqObuKkft8DdfZ870eaLOTZw9ffxUAPhQio5oJkS/i+DHQQhd0p9l1lI4huKrMzifRsuhcPi
 k3JUgGtrlKTeOUNG9ua2HD/lDqSZg95al9Ex41CDxFXmy00V2MhOs9th0FdQUFZX2T2YDbNvK9K
 4HYrtzFiFGhs4bxwdMyRTwEC21Gm+DzCbm85zy
X-Received: by 2002:a17:906:f585:b0:a68:f0ce:9f2e with SMTP id
 a640c23a62f3a-a68f0cea079mr433530666b.44.1717483538240; 
 Mon, 03 Jun 2024 23:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKle5H+3DrBU9+OF2gPlcaVM44gOko9Z9cDrlWegkVah7ZgLJD1D73IM3Sb43xe69JS89bCg==
X-Received: by 2002:a17:906:f585:b0:a68:f0ce:9f2e with SMTP id
 a640c23a62f3a-a68f0cea079mr433528566b.44.1717483537829; 
 Mon, 03 Jun 2024 23:45:37 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a69043af942sm277148966b.72.2024.06.03.23.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 30/45] i386/sev: Add handling to encrypt/finalize guest launch
 data
Date: Tue,  4 Jun 2024 08:43:54 +0200
Message-ID: <20240604064409.957105-31-pbonzini@redhat.com>
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

From: Brijesh Singh <brijesh.singh@amd.com>

Process any queued up launch data and encrypt/measure it into the SNP
guest instance prior to initial guest launch.

This also updates the KVM_SEV_SNP_LAUNCH_UPDATE call to handle partial
update responses.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Co-developed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Co-developed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-17-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c        | 112 ++++++++++++++++++++++++++++++++++++++-
 target/i386/trace-events |   2 +
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index e89b87d2f55..ef2e592ca76 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -756,6 +756,76 @@ out:
     return ret;
 }
 
+static const char *
+snp_page_type_to_str(int type)
+{
+    switch (type) {
+    case KVM_SEV_SNP_PAGE_TYPE_NORMAL: return "Normal";
+    case KVM_SEV_SNP_PAGE_TYPE_ZERO: return "Zero";
+    case KVM_SEV_SNP_PAGE_TYPE_UNMEASURED: return "Unmeasured";
+    case KVM_SEV_SNP_PAGE_TYPE_SECRETS: return "Secrets";
+    case KVM_SEV_SNP_PAGE_TYPE_CPUID: return "Cpuid";
+    default: return "unknown";
+    }
+}
+
+static int
+sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
+                      SevLaunchUpdateData *data)
+{
+    int ret, fw_error;
+    struct kvm_sev_snp_launch_update update = {0};
+
+    if (!data->hva || !data->len) {
+        error_report("SNP_LAUNCH_UPDATE called with invalid address"
+                     "/ length: %p / %lx",
+                     data->hva, data->len);
+        return 1;
+    }
+
+    update.uaddr = (__u64)(unsigned long)data->hva;
+    update.gfn_start = data->gpa >> TARGET_PAGE_BITS;
+    update.len = data->len;
+    update.type = data->type;
+
+    /*
+     * KVM_SEV_SNP_LAUNCH_UPDATE requires that GPA ranges have the private
+     * memory attribute set in advance.
+     */
+    ret = kvm_set_memory_attributes_private(data->gpa, data->len);
+    if (ret) {
+        error_report("SEV-SNP: failed to configure initial"
+                     "private guest memory");
+        goto out;
+    }
+
+    while (update.len || ret == -EAGAIN) {
+        trace_kvm_sev_snp_launch_update(update.uaddr, update.gfn_start <<
+                                        TARGET_PAGE_BITS, update.len,
+                                        snp_page_type_to_str(update.type));
+
+        ret = sev_ioctl(SEV_COMMON(sev_snp_guest)->sev_fd,
+                        KVM_SEV_SNP_LAUNCH_UPDATE,
+                        &update, &fw_error);
+        if (ret && ret != -EAGAIN) {
+            error_report("SNP_LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
+                         ret, fw_error, fw_error_to_str(fw_error));
+            break;
+        }
+    }
+
+out:
+    if (!ret && update.gfn_start << TARGET_PAGE_BITS != data->gpa + data->len) {
+        error_report("SEV-SNP: expected update of GPA range %lx-%lx,"
+                     "got GPA range %lx-%llx",
+                     data->gpa, data->gpa + data->len, data->gpa,
+                     update.gfn_start << TARGET_PAGE_BITS);
+        ret = -EIO;
+    }
+
+    return ret;
+}
+
 static int
 sev_launch_update_data(SevGuestState *sev_guest, uint8_t *addr, uint64_t len)
 {
@@ -901,6 +971,46 @@ sev_launch_finish(SevCommonState *sev_common)
     migrate_add_blocker(&sev_mig_blocker, &error_fatal);
 }
 
+static void
+sev_snp_launch_finish(SevCommonState *sev_common)
+{
+    int ret, error;
+    Error *local_err = NULL;
+    SevLaunchUpdateData *data;
+    SevSnpGuestState *sev_snp = SEV_SNP_GUEST(sev_common);
+    struct kvm_sev_snp_launch_finish *finish = &sev_snp->kvm_finish_conf;
+
+    QTAILQ_FOREACH(data, &launch_update, next) {
+        ret = sev_snp_launch_update(sev_snp, data);
+        if (ret) {
+            exit(1);
+        }
+    }
+
+    trace_kvm_sev_snp_launch_finish(sev_snp->id_block, sev_snp->id_auth,
+                                    sev_snp->host_data);
+    ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_FINISH,
+                    finish, &error);
+    if (ret) {
+        error_report("SNP_LAUNCH_FINISH ret=%d fw_error=%d '%s'",
+                     ret, error, fw_error_to_str(error));
+        exit(1);
+    }
+
+    sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
+
+    /* add migration blocker */
+    error_setg(&sev_mig_blocker,
+               "SEV-SNP: Migration is not implemented");
+    ret = migrate_add_blocker(&sev_mig_blocker, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        error_free(sev_mig_blocker);
+        exit(1);
+    }
+}
+
+
 static void
 sev_vm_state_change(void *opaque, bool running, RunState state)
 {
@@ -1832,10 +1942,10 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
     klass->launch_start = sev_snp_launch_start;
+    klass->launch_finish = sev_snp_launch_finish;
     klass->kvm_init = sev_snp_kvm_init;
     x86_klass->kvm_type = sev_snp_kvm_type;
 
-
     object_class_property_add(oc, "policy", "uint64",
                               sev_snp_guest_get_policy,
                               sev_snp_guest_set_policy, NULL, NULL);
diff --git a/target/i386/trace-events b/target/i386/trace-events
index cb26d8a9257..06b44ead2e2 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -12,3 +12,5 @@ kvm_sev_launch_finish(void) ""
 kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret, int len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len %d"
 kvm_sev_attestation_report(const char *mnonce, const char *data) "mnonce %s data %s"
 kvm_sev_snp_launch_start(uint64_t policy, char *gosvw) "policy 0x%" PRIx64 " gosvw %s"
+kvm_sev_snp_launch_update(uint64_t src, uint64_t gpa, uint64_t len, const char *type) "src 0x%" PRIx64 " gpa 0x%" PRIx64 " len 0x%" PRIx64 " (%s page)"
+kvm_sev_snp_launch_finish(char *id_block, char *id_auth, char *host_data) "id_block %s id_auth %s host_data %s"
-- 
2.45.1


