Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CF8CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fDl-0005Oh-7d; Tue, 14 Oct 2025 09:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDj-0005Nu-ID
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDf-00011l-66
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qb+w2Eh2JL0o4/v0hD4mR2Bl33h8FgZ1hMmCI2Aaztc=;
 b=jJl6WveYYP9nrN2rdOJS8KEid1B2k29fUaPn+9cR7s50w8cgyxcuFw6rA4AciLBPLrfceU
 yDepHWGLx4XCvmBIBBv09LRX7Bt8KaJnVxQ4qFPJi29T95nYS3ad04oDuMxaSk2hEgyBNB
 XlW2k4Qzm3QzgAOkP50hETqdvrHLTWU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-CuJvJzLeNniH6Eqv7gHZwg-1; Tue, 14 Oct 2025 09:37:35 -0400
X-MC-Unique: CuJvJzLeNniH6Eqv7gHZwg-1
X-Mimecast-MFC-AGG-ID: CuJvJzLeNniH6Eqv7gHZwg_1760449054
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e32eb4798so27756055e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449053; x=1761053853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qb+w2Eh2JL0o4/v0hD4mR2Bl33h8FgZ1hMmCI2Aaztc=;
 b=uEtbjWhrvHKAsbS+9C+4ZfIEzvOOKSDou+/UhY+2vbSpQiaHOzbdgRh8UAzn0RT4Y+
 AlwkSbmPNP3lhYVuHt68aQzVQCkhFVb7RgpADFs0XBbzrv79l5DvZUoTgw/vkLL9H7Hw
 vEmb/ZeDCV/lJI1ger2pxVuaDeIdNeXYQpb+i+BMgXpUc/0Yj8PK5a8qpRDBGHoI3W1V
 a7siaUcsdtWxtLtSDTK8TfeBKKGaDg4/Sl3PMwE3qKddRThv+bYXtOgysE8NITpKewkU
 Ijm7J3jIW2uLkaxjMJktvZ778ynHVJwV7KomVRS1+3YqwFFwJTwZKaQ6dHVwLUd/oHg0
 ScgA==
X-Gm-Message-State: AOJu0YyGAklpjH077zQzaAboOqGX7KKUOcHZpKl2txp6R6hx7yjbYemx
 BHkJygfRy+Dkshn49ob7V3HwaoVjeANUR3GNuvEj+GpGqMrFi6hRRV9hIjmqHUFi69qjhbWhz5H
 lrBk1qng1f0HEgVrjCth4a42VbxFyO7KdWST1UTa5ed7btyOkjs1aIquJlbwWOiCKueDD6Qktjj
 2LaIFLrysTd0DbdCvV02vHZqQuR4bAPr7KH2rFOIwd
X-Gm-Gg: ASbGnctg35qZ4CKFEP1fpt2+PkVQiy1YRVCRAWjGobi8SMy7ayA4xXOwhRIMtIkhNYH
 wR2xsxUN4youL4IXrPav2e+8Db5lryl6g5yJRPL1LlUJD16Dn9irFVKR9wFzW6i9u7kdGv/SbpS
 p/0stWhQG38YaLH5PbSLKYMI4DxLywZkLInkrQ8seXB77+yBsWY/MNJVT3qb3iISAVIj9KvhFQe
 G/6vbdz+IOHwCBCAyhSnIAd2P5AD/+h2zoO/pAMk9wxdV2uUWIkfD0jHnD3BnuxSGsEMP3Sk+Ua
 BZ/JJqQAybXdqlBdIWGXPTnJ6kOTcJUGp9W8vg6/NM19gCNfEhk6+N7PIHKDCmfelaRt2kb+QBj
 5WbSpaYXuG/JwbgB3DBn5Oov/0vb4f6heFUOqgSpTZCA=
X-Received: by 2002:a05:600d:416a:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-46fa9b11794mr176638365e9.37.1760449053222; 
 Tue, 14 Oct 2025 06:37:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGahZnaCHbiP1ZAhAAulCTNUjphIuxxm7ZG6Z7vq8wAX20/lhsmcyI17LvVpgh6mHqGUJ2oVw==
X-Received: by 2002:a05:600d:416a:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-46fa9b11794mr176638175e9.37.1760449052742; 
 Tue, 14 Oct 2025 06:37:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb497af18sm242164095e9.3.2025.10.14.06.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jon Kohler <jon@nutanix.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, qemu-stable@nongnu.org
Subject: [PULL 08/28] i386/kvm: Expose ARCH_CAP_FB_CLEAR when invulnerable to
 MDS
Date: Tue, 14 Oct 2025 15:36:53 +0200
Message-ID: <20251014133713.1103695-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jon Kohler <jon@nutanix.com>

Newer Intel hardware (Sapphire Rapids and higher) sets multiple MDS
immunity bits in MSR_IA32_ARCH_CAPABILITIES but lacks the hardware-level
MSR_ARCH_CAP_FB_CLEAR (bit 17):
    ARCH_CAP_MDS_NO
    ARCH_CAP_TAA_NO
    ARCH_CAP_PSDP_NO
    ARCH_CAP_FBSDP_NO
    ARCH_CAP_SBDR_SSDP_NO

This prevents VMs with fb-clear=on from migrating from older hardware
(Cascade Lake, Ice Lake) to newer hardware, limiting live migration
capabilities. Note fb-clear was first introduced in v8.1.0 [1].

Expose MSR_ARCH_CAP_FB_CLEAR for MDS-invulnerable systems to enable
seamless migration between hardware generations.

Note: There is no impact when a guest migrates to newer hardware as
the existing bit combinations already mark the host as MMIO-immune and
disable FB_CLEAR operations in the kernel (see Linux's
arch_cap_mmio_immune() and vmx_update_fb_clear_dis()). See kernel side
discussion for [2] for additional context.

[1] 22e1094ca82 ("target/i386: add support for FB_CLEAR feature")
[2] https://patchwork.kernel.org/project/kvm/patch/20250401044931.793203-1-jon@nutanix.com/

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Link: https://lore.kernel.org/r/20251008202557.4141285-1-jon@nutanix.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index db40caa3412..e40e374b046 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -653,6 +653,23 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
         must_be_one = (uint32_t)value;
         can_be_one = (uint32_t)(value >> 32);
         return can_be_one & ~must_be_one;
+    case MSR_IA32_ARCH_CAPABILITIES:
+        /*
+         * Special handling for fb-clear bit in ARCH_CAPABILITIES MSR.
+         * KVM will only report the bit if it is enabled in the host,
+         * but, for live migration capability purposes, we want to
+         * expose the bit to the guest even if it is disabled in the
+         * host, as long as the host itself is not vulnerable to
+         * the issue that the fb-clear bit is meant to mitigate.
+         */
+        if ((value & MSR_ARCH_CAP_MDS_NO) &&
+            (value & MSR_ARCH_CAP_TAA_NO) &&
+            (value & MSR_ARCH_CAP_SBDR_SSDP_NO) &&
+            (value & MSR_ARCH_CAP_FBSDP_NO) &&
+            (value & MSR_ARCH_CAP_PSDP_NO)) {
+                value |= MSR_ARCH_CAP_FB_CLEAR;
+        }
+        return value;
 
     default:
         return value;
-- 
2.51.0


