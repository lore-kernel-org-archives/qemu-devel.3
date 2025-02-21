Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C4AC021B6
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTrp-0002Pq-15; Fri, 21 Feb 2025 09:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlTrk-0002M5-Kn
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:18:56 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlTrh-00073z-Jr
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:18:56 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220f4dd756eso42413675ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 06:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740147531; x=1740752331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRPV5pMQqeuIeYHTl+TnsXZt99QM6n1GWtO9C1Zj3A8=;
 b=MLVGd1NDKsfdvAwXFDGkRikLPg7xfgh9MgRW2MUJgmJWIU44pFTXLhLrtpHxh+mWOL
 Mtv3t2WqmPQ0ecB4gpBpTmzCY8WHRMXSzv9n9gSR9FDtDUpE8KsJikK8cB+OsETpQ0WD
 yibgjF8UwEyh9sCKWLc7Ym1WDmKSlF6x9GnLlEK9iICLleVezKQB3aKgT7+w41tIA8yI
 fRLYhzSTm/sJXBhw9PSscF44eD3vSST+g6x8n3uC8jIWJsQzr91vxHt83n01TJUuQU6/
 p576a8YXm7oOqlXTtMKmXO4s6KTUdGrzBC8juBHBaygIfKKcTyC5ifUnlgeawjbbB7sp
 cPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740147531; x=1740752331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRPV5pMQqeuIeYHTl+TnsXZt99QM6n1GWtO9C1Zj3A8=;
 b=dFrCY0iBqJJ11PeNO6zrC6m5radNdlkxEqrebM/QjOJRGtwnLfCQT/cg21au5u23P5
 aENxuyMnmwzZCv4xrEZmR2vl1J/DKy3Dtx06X8oIWxrLtePngabZFi+xiLct8At/xhZo
 gjNp5wtW1M4sEdWs7JQ1e6a9RZwmbCpcs35Ly/zulmC7H3TOJBJPJqjVtW4Qy9btZg9/
 wSRJazlR8JsD4HfyOnba5vgXMk0UOOeNM6ckmnRqZilyFF7zMCc6A0/jqoCLq+jqKoiJ
 gdrmpjF+FdQWpYITS5l3A0QetfY/nUGsUFQDioe7n6YevKQGUPb/f9Y8qxkGD8885lZp
 F0CA==
X-Gm-Message-State: AOJu0YwqAPx6C/+Rivx4FPJGT+faW8sYlb0Bcg5k4p5NSfo+EEvG6lH4
 wz7oEmDCUkIX7/TCJk311C+pNjMkHL4KTrl3v7q6KxJ3AvDbxE+6DNAXTcliZc7CpNmDJMxANQV
 m
X-Gm-Gg: ASbGncs7BqLt7r3Zfc0VUFq7wBJOilcyc4JK7MsibXdxstnVR0howVzg1SjF75Ih2z+
 kMUazshP7JJd2cvte6/GmpZctukrTTqDnhqhhakOKS5oLOeHeXOX/tK48DW9DEYA3UPc11Tffsy
 a6Uzbfys4oHa1vXVBR3pzc71nEZyEL4yxse7HFXKayjvzDH21gV1+Rxx+6LXTD46uSCK0iEXyh2
 WzsKnUvjhT1iWcx15XsqHLFjKW6i19BVX9K37qMdfWpA4BDQ/ZdU/vv+yp9bNcqwgDnqDHkmzKU
 er0cTscgB5sERAIL8deFUQ4o5ugguq+s8sb1hL+flNLFoeiqCg48rw==
X-Google-Smtp-Source: AGHT+IG1gJbZSLGT8kbGcLEdEUZfvd4h5LxJewnrUzdqufxPWGt1QSLacG/vEj7frKnEEZkMBxgkAw==
X-Received: by 2002:a05:6a21:9218:b0:1ee:cb08:d0a8 with SMTP id
 adf61e73a8af0-1eef3cb91d7mr6582896637.21.1740147531584; 
 Fri, 21 Feb 2025 06:18:51 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734300da098sm1150290b3a.129.2025.02.21.06.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 06:18:50 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 3/3] target/riscv/kvm: add extensions after 6.14-rc3 update
Date: Fri, 21 Feb 2025 11:18:34 -0300
Message-ID: <20250221141834.626722-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221141834.626722-1-dbarboza@ventanamicro.com>
References: <20250221141834.626722-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Expose ziccrse, zabha and svvptc.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 23ce779359..471fd554b3 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -274,6 +274,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
     KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
+    KVM_EXT_CFG("ziccrse", ext_ziccrse, KVM_RISCV_ISA_EXT_ZICCRSE),
     KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
     KVM_EXT_CFG("zicond", ext_zicond, KVM_RISCV_ISA_EXT_ZICOND),
     KVM_EXT_CFG("zicsr", ext_zicsr, KVM_RISCV_ISA_EXT_ZICSR),
@@ -283,6 +284,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
     KVM_EXT_CFG("zimop", ext_zimop, KVM_RISCV_ISA_EXT_ZIMOP),
     KVM_EXT_CFG("zcmop", ext_zcmop, KVM_RISCV_ISA_EXT_ZCMOP),
+    KVM_EXT_CFG("zabha", ext_zabha, KVM_RISCV_ISA_EXT_ZABHA),
     KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
     KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
     KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
@@ -325,6 +327,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("svinval", ext_svinval, KVM_RISCV_ISA_EXT_SVINVAL),
     KVM_EXT_CFG("svnapot", ext_svnapot, KVM_RISCV_ISA_EXT_SVNAPOT),
     KVM_EXT_CFG("svpbmt", ext_svpbmt, KVM_RISCV_ISA_EXT_SVPBMT),
+    KVM_EXT_CFG("svvptc", ext_svvptc, KVM_RISCV_ISA_EXT_SVVPTC),
 };
 
 static void *kvmconfig_get_cfg_addr(RISCVCPU *cpu, KVMCPUConfig *kvmcfg)
-- 
2.48.1


