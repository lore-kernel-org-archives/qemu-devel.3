Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D869C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtw0-0000qV-JI; Fri, 30 May 2025 03:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvx-0000hb-89
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvv-0006rf-LY
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETgaVTmCx5fvIvSkf0BgFyORR9OTAp95aERHyUfqGHI=;
 b=GAiw19csjoL2iCp3vXi1/HO8odS6+QakeNYeQVVKysuM87Q+spkfgAiYjTfYb1bkoh1oeY
 fYNKc55o95ImNCFk3gxg9onwC+2Fy3hl58JgiHfPZPfPHkOZgQJjpCJSz3qinSmE9HMj3N
 r9LuRPQGC8Ks5pQxG/ndn2ktzdyZS0Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-rnZB1vMhMjWvI6rq6FGNlw-1; Fri, 30 May 2025 03:13:37 -0400
X-MC-Unique: rnZB1vMhMjWvI6rq6FGNlw-1
X-Mimecast-MFC-AGG-ID: rnZB1vMhMjWvI6rq6FGNlw_1748589216
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad891713195so120115466b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589215; x=1749194015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETgaVTmCx5fvIvSkf0BgFyORR9OTAp95aERHyUfqGHI=;
 b=qqVtJCfaQtTUkCX3hly8i/jZlk+1cRKLZyvb34r2LdBl6vhMYFP7TK652KsrfNbKBc
 0cnGkwncK+LALiDL63yeeOC/pLbL0/CyEqZDdV4jBJcbssUgyDNzJ4qcyMilxcsQSyYA
 x9LAjEigefFpT564fAFz+FvWGEDPE0ILe32H56Qd6Lmljgrk1t1qrBb0Pbbxfv/FOVGd
 ZjIxJYowcs9I01hilJ60bD1bREAr6nBk483Da7CBm0cvbeeR884WIfUY0nMK3xF1VppM
 3NBFu69Yxv6maK9g9iYaHRAdpG7x/KNr/Vcox61oh+kQRCpzLoTSCBsJSHzjEeotmSyc
 ZiDA==
X-Gm-Message-State: AOJu0YycnghXyahKef5RxBilvGwvECDyOgLWblGRYN96tfwj75N8pfIg
 u3rML05PLirSVrU0iMW0kgF+Q093tqXyphJeAG8s75L/G4PRnV20DfE9n2f1wHDveMHUiYVvzDu
 saB97Shc4qlwTZlQhta6Yzz995pO/wV2pQHBD9qgoTMo7Snfun3UkNSg5U1633b/WDRYg+4PbFg
 f+hm0A292LJ95SM3C+NOlwwrHGUdOqij/MJ0M9nVhj
X-Gm-Gg: ASbGncvVM3ipd0xd19LJrj7nxeFftXggICJ2jvnkcaOq7+mLLVs6cJOz1bvxj9O9aDr
 qF1a/hW6XBn065A2sJhjiZAYZz07vZ1z2GbRCVGf9p5pmunq4Ivs2E0bkA1trzBtiiVz8wHNGGN
 zroIMxcgUxkQauPvK9uPkdbp1rmF/+cwxW/xUxYu0d8/N+PVifdbYZeVw/SS1q6SsLTg8gTmznA
 QvVRmuO//jsBEbOF5nz8oY8vFHVhbGT3wkOmZB/bTHB4BfOrnsxwNxZf4CCBUTYrSv2FGTHwKqx
 dLmgJG8BqlxcHw==
X-Received: by 2002:a17:907:d88:b0:ad5:557b:c369 with SMTP id
 a640c23a62f3a-adb322fcf4dmr209494366b.33.1748589215625; 
 Fri, 30 May 2025 00:13:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFunbXpR8GW1D/l1U14L7O1B4DV7TLTxHwwod8xNRhWOKYyHc7Ti+YtrVASMG0XsOwaP7yolg==
X-Received: by 2002:a17:907:d88:b0:ad5:557b:c369 with SMTP id
 a640c23a62f3a-adb322fcf4dmr209490766b.33.1748589215140; 
 Fri, 30 May 2025 00:13:35 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82d75bsm277061366b.56.2025.05.30.00.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 18/77] i386/tdx: Introduce is_tdx_vm() helper and cache
 tdx_guest object
Date: Fri, 30 May 2025 09:11:48 +0200
Message-ID: <20250530071250.2050910-19-pbonzini@redhat.com>
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

It will need special handling for TDX VMs all around the QEMU.
Introduce is_tdx_vm() helper to query if it's a TDX VM.

Cache tdx_guest object thus no need to cast from ms->cgs every time.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-7-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.h | 10 ++++++++++
 target/i386/kvm/tdx.c | 15 ++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index f3b72533616..de8ae919616 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -3,6 +3,10 @@
 #ifndef QEMU_I386_TDX_H
 #define QEMU_I386_TDX_H
 
+#ifndef CONFIG_USER_ONLY
+#include CONFIG_DEVICES /* CONFIG_TDX */
+#endif
+
 #include "confidential-guest.h"
 
 #define TYPE_TDX_GUEST "tdx-guest"
@@ -18,4 +22,10 @@ typedef struct TdxGuest {
     uint64_t attributes;    /* TD attributes */
 } TdxGuest;
 
+#ifdef CONFIG_TDX
+bool is_tdx_vm(void);
+#else
+#define is_tdx_vm() 0
+#endif /* CONFIG_TDX */
+
 #endif /* QEMU_I386_TDX_H */
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index f8ec4fa217e..3750889453d 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -18,8 +18,16 @@
 #include "kvm_i386.h"
 #include "tdx.h"
 
+static TdxGuest *tdx_guest;
+
 static struct kvm_tdx_capabilities *tdx_caps;
 
+/* Valid after kvm_arch_init()->confidential_guest_kvm_init()->tdx_kvm_init() */
+bool is_tdx_vm(void)
+{
+    return !!tdx_guest;
+}
+
 enum tdx_ioctl_level {
     TDX_VM_IOCTL,
     TDX_VCPU_IOCTL,
@@ -117,15 +125,20 @@ static int get_tdx_capabilities(Error **errp)
 
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
+    TdxGuest *tdx = TDX_GUEST(cgs);
     int r = 0;
 
     kvm_mark_guest_state_protected();
 
     if (!tdx_caps) {
         r = get_tdx_capabilities(errp);
+        if (r) {
+            return r;
+        }
     }
 
-    return r;
+    tdx_guest = tdx;
+    return 0;
 }
 
 static int tdx_kvm_type(X86ConfidentialGuest *cg)
-- 
2.49.0


