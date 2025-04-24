Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63A2C3ABA0
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 23:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u860D-0003Fr-Ov; Thu, 24 Apr 2025 19:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zs-0003BO-2E
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:49 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zq-00087L-G6
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:47 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-ae727e87c26so1042250a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 16:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745537324; x=1746142124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74On0jTwFoitdsTi4zrAD2eD1+d9no9rwvHR5I6qA4o=;
 b=oJUMnbj0aTpSWdvL591k0mHFAe+wDgncID0N1IJH3gv77zB/d55iXYN6kBVAOH+rkF
 ueKuTH/Hcfwxvy7gWEj9m5BB4dFqn2v707vR7grn93NF9MIFVOP6RHUPg4qNmDjtRHzX
 UlI/oz033D4KXqLvvHJZaRAcR4GYuDnJOViCt4ye84m4EXDBQt8i/TxChawo0bU1G4De
 8/p5TKMvKyLuc6FlaeH28O9JFecyZpF8brMyv4Z7kKOKxuAdbJLrbYO33YNInd8743Bc
 vgKlatOikFTHCsCjyWXjJAiq8LczMGQ3JSMXWfAI4CIX1m8Z1ZbBb61UynyHWydz33cD
 itfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745537324; x=1746142124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74On0jTwFoitdsTi4zrAD2eD1+d9no9rwvHR5I6qA4o=;
 b=FWmKR5/o/KUXHVUMOgSn8B5iid+eeV1L3w0KcqtJJQzl7DCB3XF6/UQfgNXgmE0zQS
 TuoLlLeeMl/VBtj0+wq3V6hhYPiOM0642pxMzj5VdA49IDPEY0iaGqLzS0A6h6vFaRt5
 WGRmJ6PFTjqjhmIVhdcnLLYP4TvWHrczTePnsOPY+mOYsKPcumKpV2RX3aysTyR4ILxS
 DveEwZrfzvAEqAH/3E2Kx11UXDUMHIv0cghxSYnNkruV5+h+gww+tXDtNI0HOlbavxV3
 F6PNfvWgvt+qVkcIlMUUUL0FQcXay4NAsp5D70Y1KjD6wLZRi/u+Em9LhzSqKOB+oR1a
 BOYQ==
X-Gm-Message-State: AOJu0YySG2YXW28Qs+6gyoHUwyTkyqK5CRb6JyVZK2aSIclvY4nziTKO
 fLED7+EJiSzMED9PSr1b48jOLmUpzALLQ2VZFuNHgEy8tHk5KVNWorhcA21LOMZA1y6uYfZ2cdV
 OWgI=
X-Gm-Gg: ASbGncs6IevD/EPqWarwOAes0I/zdLlmMms08Rs3ke/nA45sPGUyfA3pCTnDhWFafRm
 Bh8VwYpuGim2I33wzkTQeDUZkftEIPEkjAwnK3R08hW1XbOAQbPqxo89yekS4lTShGeyH3CzxeL
 PczcNAL5Ld5WjyeZwt/g90EZQ6tdjJpc7auiJSDOE3tahDldqv+EdygHsSINz8R5VNx0rgC1fZv
 txAXMICFDoXVqeywBK1dthi/CupD9L+ip72UjDDeH2uM0Z8WrE/zub9Q+gxCKKgZ/APvoTFG7fY
 HLfYzQoGShkCBu7AZ1EvrEKEGfLysfLWvXaqi/TV
X-Google-Smtp-Source: AGHT+IHB9N0x/f7qY9ZvBt2OkR6aKoT3LR0rIcTQkENbimzoV8Z91BtLZRoVeqO4MCvkOQfAgJyXXw==
X-Received: by 2002:a05:6a00:1305:b0:737:9b:582a with SMTP id
 d2e1a72fcca58-73fd9051555mr132199b3a.24.1745537324570; 
 Thu, 24 Apr 2025 16:28:44 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25accfbesm2044318b3a.177.2025.04.24.16.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 16:28:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, philmd@linaro.org, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH v5 7/8] include/system: make functions accessible from common
 code
Date: Thu, 24 Apr 2025 16:28:28 -0700
Message-Id: <20250424232829.141163-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/kvm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 18811cad6fd..b690dda1370 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -210,6 +210,10 @@ bool kvm_arm_supports_user_irq(void);
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 int kvm_on_sigbus(int code, void *addr);
 
+int kvm_check_extension(KVMState *s, unsigned int extension);
+
+int kvm_vm_ioctl(KVMState *s, unsigned long type, ...);
+
 void kvm_flush_coalesced_mmio_buffer(void);
 
 #ifdef COMPILING_PER_TARGET
@@ -237,8 +241,6 @@ static inline int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_t
 
 int kvm_ioctl(KVMState *s, unsigned long type, ...);
 
-int kvm_vm_ioctl(KVMState *s, unsigned long type, ...);
-
 int kvm_vcpu_ioctl(CPUState *cpu, unsigned long type, ...);
 
 /**
@@ -441,8 +443,6 @@ void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg);
 
 bool kvm_arch_stop_on_emulation_error(CPUState *cpu);
 
-int kvm_check_extension(KVMState *s, unsigned int extension);
-
 int kvm_vm_check_extension(KVMState *s, unsigned int extension);
 
 #define kvm_vm_enable_cap(s, capability, cap_flags, ...)             \
-- 
2.39.5


