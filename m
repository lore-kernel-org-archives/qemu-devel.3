Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A5FC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZGc-0000sZ-Gz; Tue, 17 Jun 2025 12:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG5-0000lO-LS
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG1-0000dP-Cl
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4533bf4d817so20403475e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750178036; x=1750782836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4mTaJwkAe0rgPcWQ6kEwY/uI1enES5AbvkajjNAiL4=;
 b=FT3jVPIkt5uUfNwK/IZvjugQHOE5Fn6jzm8TZt0UNPS8R1z2MbtgBKoosXGoWIDSBs
 eeW6yfR+uVYPLIJK6GWDuKfsODCWwZ08q5tDCwOExP1bKccHjFRI6/uLS0cLPLf28EvS
 S7xSp8efVGYldEJR5/6RzD2j2x+z8u1MymYOd4MPTTwtn6eWWMMQ/G+8nyYQ8SSv31Is
 9GVjv70tLTlM0XGn5ou6aTFohK2FxcRpDlIzBq7/6b4cOfLoiSFxVBiniGj6UWAXzgZL
 LnKNQ4dSlT0J0h1jxdnon4t2buxeZAxlRiC2xrrg5MXQdmUMQZPXQJdf6jMPCKv3aaOL
 H4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750178036; x=1750782836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4mTaJwkAe0rgPcWQ6kEwY/uI1enES5AbvkajjNAiL4=;
 b=V+byQ2n72766k1SskNN6pg06WLalCDa9bOpbwtopW73ZQoI0G0MnJIYCyGxXg6+/do
 LNoI7tCOm4vf9NOkuO4eNdSG53w1nSv6Iq+LHC/FotgXQ5i+G6aJpj5UnTYnq/cURz+W
 SfP03kvuzHeKzkfbZpa7mIYnlVLi2+EgDFm1wES2TW+hWwl1eKHgjtY9x2cOdd3e9sTj
 diRtOxWckFlr6hbhgR2jIANIK5Pa4dpFmc0Y2ChPnilcNaFe7bQXTBGOwx+h+7gKkQ8N
 zLo0L+NoW4/mqydUB8YgFfCwRwPdWgc1RXqb9cwgIkF9sx4eZfY4E/KZcHNqdZkzGBiX
 4CSA==
X-Gm-Message-State: AOJu0YzdsLiOB/FaJXo+oKl/N/cNA3LC4VKEJGkxFXxB4ogh3ZfshQNc
 Xfj/hyEPxnTExAGHXWWPYDOSd8CHkxPzsuE3+Y6rp+nZFrVAeNVNc2Ertthbf86xtq4=
X-Gm-Gg: ASbGncvRMvHems7MB1X6VBKL/5UknHCKJHzlHKPwCQCL/+w/FJcdXDOwCqNPmrPrWoP
 TiCX7kBkPa28bSEyDTmY5wwm4MHVQwNG00+52xGQPHtg4VzOJS/Z7Ds4UqjstAHDibGFW7wDH+j
 LnrJnlsdUckosvFGXZpxKFEEyxzV9Jj/Mpx4RHc6CFiP6fdc9WFynBfqIivBZGwBTR6RaIbygGo
 MQAVeHJkTv9hDhfxZKBveabfp8a1QedsHSwTMuYbaCW2hrJKK0lOPg5rSFIVnP9HQf6nfcX1/7e
 fdlaBbpfI9347z3EEsxJRlr+BFfl4DwAnnOp6gCRF5cWQp8UgJx44xg7kLNVEKw=
X-Google-Smtp-Source: AGHT+IESqAJjlJORLPBH6qBRxEOGX0LC6olwh+WEK+ySWojj+8sfKO3Ap0Z35PSoPGipXAysw/qWZQ==
X-Received: by 2002:a05:600c:1e02:b0:43d:fa59:af97 with SMTP id
 5b1f17b1804b1-4533cac919bmr120131075e9.32.1750178035689; 
 Tue, 17 Jun 2025 09:33:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e232219sm178762495e9.9.2025.06.17.09.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 09:33:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5B8825F8B5;
 Tue, 17 Jun 2025 17:33:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <graf@amazon.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 05/11] target/arm: enable KVM_VM_TYPE_ARM_TRAP_ALL when
 asked
Date: Tue, 17 Jun 2025 17:33:45 +0100
Message-ID: <20250617163351.2640572-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617163351.2640572-1-alex.bennee@linaro.org>
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/kvm_arm.h | 9 +++++++++
 hw/arm/virt.c        | 7 +++++--
 target/arm/kvm.c     | 7 +++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 7dc83caed5..a4f68e14cb 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -191,6 +191,15 @@ bool kvm_arm_sve_supported(void);
  */
 bool kvm_arm_mte_supported(void);
 
+/**
+ * kvm_arm_get_type: return the base KVM type flags
+ * @ms: Machine state handle
+ *
+ * Returns the base type flags, usually zero. These will be combined
+ * with the IPA flags from bellow.
+ */
+int kvm_arm_get_type(MachineState *ms);
+
 /**
  * kvm_arm_get_max_vm_ipa_size:
  * @ms: Machine state handle
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9a6cd085a3..55433f8fce 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3037,11 +3037,14 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
 
 /*
  * for arm64 kvm_type [7-0] encodes the requested number of bits
- * in the IPA address space
+ * in the IPA address space.
+ *
+ * For trap-me-harder we apply KVM_VM_TYPE_ARM_TRAP_ALL
  */
 static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
+    int kvm_type = kvm_arm_get_type(ms);
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
 
@@ -3071,7 +3074,7 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
      * the implicit legacy 40b IPA setting, in which case the kvm_type
      * must be 0.
      */
-    return fixed_ipa ? 0 : requested_pa_size;
+    return fixed_ipa ? kvm_type : deposit32(kvm_type, 0, 8, requested_pa_size);
 }
 
 static int virt_hvf_get_physical_address_range(MachineState *ms)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8b1719bfc1..ed0f6024d6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -515,6 +515,13 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
     return ret > 0 ? ret : 40;
 }
 
+int kvm_arm_get_type(MachineState *ms)
+{
+    KVMState *s = KVM_STATE(ms->accelerator);
+
+    return s->trap_harder ? KVM_VM_TYPE_ARM_TRAP_ALL : 0;
+}
+
 int kvm_arch_get_default_type(MachineState *ms)
 {
     bool fixed_ipa;
-- 
2.47.2


