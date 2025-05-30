Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3926FC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtwR-0001hF-BH; Fri, 30 May 2025 03:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwL-0001Um-Ek
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwI-0006vy-QP
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cdAwUYjVw4TAPIU7bCkk8Gi1InYgbYl2nnPePM6TsQw=;
 b=DbwlCyLKGoDmcIWd25akHQ5Yo3+d/J4j+LvH5qDQVCQzcmMbun2jRaSOmUesQOZWG9BdjJ
 Kllth3H3i+uzmXnRCpTNS5Tz3Iw4m1Mof/n8DfqXdv1kGnu8p9RsbJxkheFxV2FNZ/HXCz
 8hWIyYDQwRO/k36CMoBTXsWJoEl4x88=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-vHzDuJIFPn2hvWt8vDPRZQ-1; Fri, 30 May 2025 03:14:00 -0400
X-MC-Unique: vHzDuJIFPn2hvWt8vDPRZQ-1
X-Mimecast-MFC-AGG-ID: vHzDuJIFPn2hvWt8vDPRZQ_1748589239
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-601f3f35b88so1668937a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589238; x=1749194038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdAwUYjVw4TAPIU7bCkk8Gi1InYgbYl2nnPePM6TsQw=;
 b=uRvdWn1ngk8m0Zg5rFZJ2/2znbuxlUv+wqmcK1yqGmtFTx/vN2M7EkPdShfuRTIExk
 5CJgouvalMAQegtNZCDhdUpjVLpEiUFEwoPPMd9NuCz5lco2JABFeLEsSlQRVJRnnNby
 OAt7E6C5G5bRH2DgdaFsE/XnprxgcrwfpF0DZsYBp8zhRWFvVPAjf85NxTwuG73+ICzF
 hvebcFUtkM2TMPuTO6f2l3YYvIUDJKLT/DwhpiwQcoUOkkqDfmLmmYwE/Q3sbEpggR+N
 v7if01Kgu2U9gXtoAmzJz5T+iyPGcI0/5tk+AuCssEH6gyEfl2TK4rXkWtq1oK7EqaTd
 AVDQ==
X-Gm-Message-State: AOJu0YzLxcnD1sN2t6uNOWFam60FqWxMpZ6lLWRMZnwCKycXXwgdGC1n
 0x1g1i8G68s1VcwccZMX5gnFvyQd48O4msJZRpKYu4sEZKWIws2Zn2nU+PtguuInVUEUQdEclHN
 JEWKldmYi+wlNfJU/KroUxg4leAWPW4lkxG3O8WHzlpF7kIEhiR97E6qymohyh8Q1K642NpHrqI
 uSfsRewQ7WtmXqC8vzaihNE3d33G1a0xPc8fxfuWdX
X-Gm-Gg: ASbGncvmWtAzXzBnEnFqXrQafyit9YqoY+zVN35vO2igowT8NrBisAkvTMW3FQhbiXD
 a76Rhfklf9Vgjufc9HO3H4jdhb16x5QrWX7THu9K0d1jCF2Ty7rjoqa46MZGG6QTNa/zemw0LO+
 mV5lFa9hJINtMBSQi+gXkjESbkksPhQ618O4OACFC4Uy1L6hWF0sxusJl/cV0Uo55bV0ck+ojWc
 M+PE4RXuml9KWq3aXGThmb31SmphK8QcSQMGtX/Y1eFlhHYyx5CG8kcIhiqpYnkpnyif3OZX0qJ
 TS62RUMUMrDyFg==
X-Received: by 2002:a05:6402:35ca:b0:602:346b:1509 with SMTP id
 4fb4d7f45d1cf-6056db31ec2mr1618750a12.9.1748589238416; 
 Fri, 30 May 2025 00:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGhkNGmXOjlaEBsgqD3BZpmUwXvsUpVpS/g+Yt7VnLi3f992W7QWMtj0FtZVAAhIXfoCvlHQ==
X-Received: by 2002:a05:6402:35ca:b0:602:346b:1509 with SMTP id
 4fb4d7f45d1cf-6056db31ec2mr1618730a12.9.1748589237973; 
 Fri, 30 May 2025 00:13:57 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c5c8easm1195334a12.28.2025.05.30.00.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 27/77] i386/tdx: Implement user specified tsc frequency
Date: Fri, 30 May 2025 09:11:57 +0200
Message-ID: <20250530071250.2050910-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Reuse "-cpu,tsc-frequency=" to get user wanted tsc frequency and call VM
scope VM_SET_TSC_KHZ to set the tsc frequency of TD before KVM_TDX_INIT_VM.

Besides, sanity check the tsc frequency to be in the legal range and
legal granularity (required by TDX module).

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-16-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c |  9 +++++++++
 target/i386/kvm/tdx.c | 25 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e98f1ee26a6..fd1817fc5ea 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -870,6 +870,15 @@ static int kvm_arch_set_tsc_khz(CPUState *cs)
     int r, cur_freq;
     bool set_ioctl = false;
 
+    /*
+     * TSC of TD vcpu is immutable, it cannot be set/changed via vcpu scope
+     * VM_SET_TSC_KHZ, but only be initialized via VM scope VM_SET_TSC_KHZ
+     * before ioctl KVM_TDX_INIT_VM in tdx_pre_create_vcpu()
+     */
+    if (is_tdx_vm()) {
+        return 0;
+    }
+
     if (!env->tsc_khz) {
         return 0;
     }
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 58983edd80a..93a16a1aaa8 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -20,6 +20,9 @@
 #include "kvm_i386.h"
 #include "tdx.h"
 
+#define TDX_MIN_TSC_FREQUENCY_KHZ   (100 * 1000)
+#define TDX_MAX_TSC_FREQUENCY_KHZ   (10 * 1000 * 1000)
+
 #define TDX_TD_ATTRIBUTES_DEBUG             BIT_ULL(0)
 #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
 #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
@@ -267,6 +270,28 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
         return r;
     }
 
+    if (env->tsc_khz && (env->tsc_khz < TDX_MIN_TSC_FREQUENCY_KHZ ||
+                         env->tsc_khz > TDX_MAX_TSC_FREQUENCY_KHZ)) {
+        error_setg(errp, "Invalid TSC %ld KHz, must specify cpu_frequency "
+                         "between [%d, %d] kHz", env->tsc_khz,
+                         TDX_MIN_TSC_FREQUENCY_KHZ, TDX_MAX_TSC_FREQUENCY_KHZ);
+       return -EINVAL;
+    }
+
+    if (env->tsc_khz % (25 * 1000)) {
+        error_setg(errp, "Invalid TSC %ld KHz, it must be multiple of 25MHz",
+                   env->tsc_khz);
+        return -EINVAL;
+    }
+
+    /* it's safe even env->tsc_khz is 0. KVM uses host's tsc_khz in this case */
+    r = kvm_vm_ioctl(kvm_state, KVM_SET_TSC_KHZ, env->tsc_khz);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "Unable to set TSC frequency to %ld kHz",
+                         env->tsc_khz);
+        return r;
+    }
+
     if (tdx_guest->mrconfigid) {
         g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
                               strlen(tdx_guest->mrconfigid), &data_len, errp);
-- 
2.49.0


