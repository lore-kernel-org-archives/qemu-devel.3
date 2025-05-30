Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F364CC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtxL-0003KK-Nn; Fri, 30 May 2025 03:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwl-0002II-GN
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwj-0006ye-Tk
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=maB1BlEmn/NmHGZNEPTxLDttQWYrYe8P0K3V/b2OBfU=;
 b=Hwzprjj/Yq95ut1/pHCa26FxIBujIMFovAHkwdbBUV1Bk6xf895GmzOzg4O9D6q5ux0GPX
 FgtrMxA2d4QN3ODa703gkSmXUbcgreAM6wL/7c0Zhk7Gfr4U9V+vrdWYkzlDJsFZumM6nC
 RortbexsV506t7+tT7sXxe8BzIs0Mps=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-O_EsH3SyNB-rTdBegs-0Ng-1; Fri, 30 May 2025 03:14:26 -0400
X-MC-Unique: O_EsH3SyNB-rTdBegs-0Ng-1
X-Mimecast-MFC-AGG-ID: O_EsH3SyNB-rTdBegs-0Ng_1748589265
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-adb32dbf60bso62514166b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589264; x=1749194064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maB1BlEmn/NmHGZNEPTxLDttQWYrYe8P0K3V/b2OBfU=;
 b=i5QV/gTjZ5I3/O+O9CoS0EaNEMdAhASWpN2IwLg0vps0GcgEYWqbGCGoPlHrtEZcpH
 JsmYA7wBAPyP3fz5OHQoSJKcx1cf93MjtzOmx3Tr1KaROLFa2wiwMTqmcl2Es39YZsbX
 ggVCBvjUbXvhgSOjkSofWGy2C0wR2p7yiMQPilzdv/8V/BudPLLFCqu15HcQWLdgx3P4
 81G7wpIBsY/0rA0w+RDSaa0JaPf4De0mto8ivbOtxzXDQ0NGDdjnihGFpFIqsR4541BY
 Kdh5bnVNh2xbHNblPIx5DxSYWHQtJYUmnFXDts4BG+bcWk20+69PiZRqV5NmHJM0ps6T
 4BWw==
X-Gm-Message-State: AOJu0YzAXbYGQzjQjF3g6z7QZYREBsw+PDU3mzPIU2tRyCUsfgIX/5rP
 MtzIfS0V42nyTIC3YssqT/c51ougRUNarkKTDkYaX0/AxlPnvM6Hu3Zm+wWa5NiMoib3VWo3R42
 yfv8PFqT9KL9lKqtptOU8XEr0xNmcKxW37L2WjBBljtCM12+49qLN30ckd44zF/2CeByKf3cAq6
 8GB7YDPwlllose8GAQg3sPnf9JXjQa2F+ZggGpuLzF
X-Gm-Gg: ASbGncuXbTVO64LPwSFyjRTlx8Yr87mS2IdOvbVMcHz64hTMX7hnc5MJOUY7kI7o6LV
 NCFK67JyYHLA3A1fMMvcnxoynRLFcVm3+yTQqz9578uY89yJ0oZXhyGTikU0RBkMKmY072srclh
 JqFXnu12W61u0AzZazEUDnu6suf/bzrT4iesW8TVP5zmfUohdSdcYSqhhkoRmivpHRNdtZNK53k
 4JtiLh0uTvyelifpa3oepWGK/R6hGkMcEdjtVnlsvWog8ltAoeJdyncbt60choET/w/YKhs8LFK
 DleBeflfnV12rg==
X-Received: by 2002:a17:907:972a:b0:ad5:777d:83d8 with SMTP id
 a640c23a62f3a-adb322a34eemr202899866b.29.1748589264211; 
 Fri, 30 May 2025 00:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2K7RQE7aWQ5Qrouiy2GpWF1UrWyD22NV4d6r/9+uZltcldqaSTsf4qY3vixt0TXmeHkGHRA==
X-Received: by 2002:a17:907:972a:b0:ad5:777d:83d8 with SMTP id
 a640c23a62f3a-adb322a34eemr202896466b.29.1748589263538; 
 Fri, 30 May 2025 00:14:23 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fecc5sm280859066b.10.2025.05.30.00.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 37/77] i386/tdx: Call KVM_TDX_INIT_VCPU to initialize TDX vcpu
Date: Fri, 30 May 2025 09:12:07 +0200
Message-ID: <20250530071250.2050910-38-pbonzini@redhat.com>
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

TDX vcpu needs to be initialized by SEAMCALL(TDH.VP.INIT) and KVM
provides vcpu level IOCTL KVM_TDX_INIT_VCPU for it.

KVM_TDX_INIT_VCPU needs the address of the HOB as input. Invoke it for
each vcpu after HOB list is created.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-26-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 43529a9e0ed..99d13bd8441 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -259,6 +259,18 @@ static void tdx_init_ram_entries(void)
     tdx_guest->nr_ram_entries = j;
 }
 
+static void tdx_post_init_vcpus(void)
+{
+    TdxFirmwareEntry *hob;
+    CPUState *cpu;
+
+    hob = tdx_get_hob_entry(tdx_guest);
+    CPU_FOREACH(cpu) {
+        tdx_vcpu_ioctl(cpu, KVM_TDX_INIT_VCPU, 0, (void *)hob->address,
+                       &error_fatal);
+    }
+}
+
 static void tdx_finalize_vm(Notifier *notifier, void *unused)
 {
     TdxFirmware *tdvf = &tdx_guest->tdvf;
@@ -302,6 +314,8 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
 
     tdvf_hob_create(tdx_guest, tdx_get_hob_entry(tdx_guest));
 
+    tdx_post_init_vcpus();
+
     for_each_tdx_fw_entry(tdvf, entry) {
         struct kvm_tdx_init_mem_region region;
         uint32_t flags;
-- 
2.49.0


