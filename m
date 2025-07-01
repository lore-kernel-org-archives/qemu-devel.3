Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42B9C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcAb-0005q5-Tc; Tue, 01 Jul 2025 10:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAZ-0005pW-V0
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAT-0006ri-Hd
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso2858018f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380863; x=1751985663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLkTPhlZ6ATb7AAc3VGQov8gsRhAPF8MN9ZoezL4e2s=;
 b=edFmb+lxPD8qo79SNcAxLujTET0G+rE2jlmsBK6v4fW4Wp1MIlS/kIHFxqw5bXx4CG
 z1T/BArw+x/9NksZ7PeEVdEeTDtyn2pokUL9LRZLMFtmQbVkwXBaXdDk7cuVyXI1kxTy
 whEiyXLHwXP+wVBeQE2u9BAdWpItcbXKJSxRfwazCCCgF6rG1q0ZQLWHLmMXsPDAW1rV
 FCKHJxPWz6zmT/HL2rvbpqER55RwFaCp3xDrvIluJ3JmLl0g2Wvs+qHzBpo7F17meCKE
 A9rdVNpi8Nf4MHnRR+vfXwbOGvHEJ31WusCHzvHQf0x4RMf7JmC7ldDOAmmNFREQV0q0
 vOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380863; x=1751985663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLkTPhlZ6ATb7AAc3VGQov8gsRhAPF8MN9ZoezL4e2s=;
 b=ZwtvBDb2dBuN0XUmLURjPUrmq7akgLLGMLUNucZ4qR+7aIT+qRTPwBrUu/WRYM0rv5
 GTryB4qVKKzcrPvt6bJ+xv2PNy96b6OJ/b8Gp8FFfnwa37TTWm/bNADprZFmA2DDFae1
 l4emn3/kgqiZEKoVxvcCI12wciv63saR9q/4bNSMS2JS0v9RFYd5xz3mKYUPBid7TpVL
 PJ+wo5LZjteIFlQp+NNkMEgGqTLMbHfjZpSfaNBzArIhoKAHuli+0+HCr3Q43muniFGQ
 25G9whaGnDfl+Tehv5ZzQumXNViYFF97GvwTpto8tvm9CrORQMVot6ihPgcu756IR6Ui
 ypXA==
X-Gm-Message-State: AOJu0Yw7YgqO0p6SnUdpUMQ/MJQanfSLqmPHpNBQVV47nUHLAB882P11
 9s/yXMbB0sjtypG1kZVVDUgHniQuvgVAtdi6eTTBlq7TJ3J3B1RwfLv57erWaoPtQUHCCb6U6kc
 em3Fa
X-Gm-Gg: ASbGncua4e09tAbOVoWWjswxYXnPKtTI3boMPI4X33Fb69vdSO/olLeIl2ljoFUe1v7
 A+v3XhA3KgBQoGsglsi5cDqSM4iQZoL3dPHlGRH6Fqmh0YFU0TPYFE9Kn6e7Vm9vO8w7620Ee9u
 zV9RCSwh1jdZvJ6zj76cYMOloztXWw4BOyohoAMwpf54xdS8v4ZEMYibv+DhudyUuTTNzTUwowS
 fbiRacMLUouSiigSDj1loDsnihbvoEuVOS/BFo95vshjoX3v9kwb9cIuvxbzmANe5wEwgg44j5O
 4HzvIo/kx3PKqjwhicojyFdpeMZESNUBXp0ErsOOmYBS95vtn13cAtkyqWqLMo1KYh/gU6qG659
 YMaAVQ0WclWZ3p30V6EGoMzbkoVEeLNOWvA7J
X-Google-Smtp-Source: AGHT+IG3qdvpiwP/Wk7e+yDnsErZ6MeJ3MSSo3EX/Y4F7GB9HLSxaHSWM33tEPWcaNRCx6k9J4Ewwg==
X-Received: by 2002:a05:6000:178b:b0:3a3:7baf:f06a with SMTP id
 ffacd0b85a97d-3a8fe4bce3fmr14556007f8f.37.1751380862940; 
 Tue, 01 Jul 2025 07:41:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3fe28dsm168866135e9.20.2025.07.01.07.41.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:41:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/68] accel/kvm: Reduce kvm_create_vcpu() declaration scope
Date: Tue,  1 Jul 2025 16:39:16 +0200
Message-ID: <20250701144017.43487-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

kvm_create_vcpu() is only used within the same file unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/kvm.h | 8 --------
 accel/kvm/kvm-all.c  | 8 +++++++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 7cc60d26f24..e943df2c09d 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -316,14 +316,6 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
  */
 bool kvm_device_supported(int vmfd, uint64_t type);
 
-/**
- * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
- * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
- *
- * @returns: 0 when success, errno (<0) when failed.
- */
-int kvm_create_vcpu(CPUState *cpu);
-
 /**
  * kvm_park_vcpu - Park QEMU KVM vCPU context
  * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d095d1b98f8..17235f26464 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -453,7 +453,13 @@ static void kvm_reset_parked_vcpus(KVMState *s)
     }
 }
 
-int kvm_create_vcpu(CPUState *cpu)
+/**
+ * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
+ * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
+ *
+ * @returns: 0 when success, errno (<0) when failed.
+ */
+static int kvm_create_vcpu(CPUState *cpu)
 {
     unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
     KVMState *s = kvm_state;
-- 
2.49.0


