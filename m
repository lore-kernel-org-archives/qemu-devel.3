Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290BAD1BDD4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80zn-0000kG-U3; Mon, 04 Nov 2024 12:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1t80ze-0000ZY-Rv
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:35:59 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1t80zc-0001Gx-L2
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:35:58 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so39913535e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730741753; x=1731346553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GqDaH8FBkkxPNg8DatpDcuWIhwo3YQN0q5KUjv6axVU=;
 b=MXjNH5H0E9r1qMRyj42epJ4E95+nDXNT/H4flHOVCnb9lgY+Rd9KgNaNL31U8zB1J+
 klQ30awFab2NwtaYreWgezB/86wj0ll0ciRmcXK9y/djqdYnxh/yOz/Ya+7n7ufOBNNP
 ZNo7ZrPaRQAZCjKks9KpO/M0lgcLg5hIPhx4hAXB5tkcH9MkPVS6KswWPnRTIclclowy
 5TwWlNsqrYn5dfybigTeTiU9MeNUgegvbNDqSVD9A+1oISRPgXH77SNj4+S7QnODpCL2
 jxY4yhGgcn0HjpbiyuemU/UAPK0DAxunmQIN602HmZQr9cqJ5HYA1OJYRn0ZuMIVqJFu
 ToQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741753; x=1731346553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GqDaH8FBkkxPNg8DatpDcuWIhwo3YQN0q5KUjv6axVU=;
 b=rta1iZfFAoqcrv1NRXBKgkBleRUkPZlplCVRXyMqT2VXRxfHATvW/yzWi9zFYhOPMt
 75vurYAZcDdUfZg1qQ4ePrnNDZsYo/0zDmhvC5w8uBbENN0AU4MxnKDWAjTOh6+8McQf
 OaBNUPAgW5U9F5P8e+wm7s/TJZvIVDXab89GnC+R8dHhjOGqw2B8Mtn2bzU7q3EDTcRW
 q7Se3mAz5Kw0RzJi9TKAOsfwimAv6XcMWth5Tb93b9yIsSpTiXwnzwwaFbXgI1P4fDH9
 br/vMG2MXhC78RzLpi4Sbg7FTdeOt65v0p9M2xxHDLxu4488wG6Y5BsacxS+arC9YbVV
 6a7g==
X-Gm-Message-State: AOJu0YwrFuK1eLUO4ef7N3Az5AvqBfkhbJ1AmNo3VZA2a9tFsWI1K7Qd
 vOEsRkxYEJ/vxe7hq47HzfUW8+Fd4x7W2A3snX8AHl84lXPTTkceFaCtbU3rRnamwiosQPRIIW3
 1
X-Google-Smtp-Source: AGHT+IGNLjSfJDjKIVaaU3cbLo0NlN/k40pHJZkz97N2i+RohIklIxKhAuyH+Jsmw28gcknfrepc5w==
X-Received: by 2002:a05:600c:3b14:b0:42c:de34:34c1 with SMTP id
 5b1f17b1804b1-4327b6f9590mr141796465e9.2.1730741753590; 
 Mon, 04 Nov 2024 09:35:53 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd917fa7sm187499735e9.18.2024.11.04.09.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:35:53 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] target/riscv/kvm: Fix leak of reg list
Date: Mon,  4 Nov 2024 18:35:52 +0100
Message-ID: <20241104173551.125069-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32b.google.com
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

Free the temporary register list.

Fixes: 608bdebb6075 ("target/riscv/kvm: support KVM_GET_REG_LIST")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index cbda4596da73..effd8fed815d 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1170,6 +1170,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     }
 
     kvm_riscv_check_sbi_dbcn_support(cpu, kvmcpu, reglist);
+
+    g_free(reglist);
 }
 
 static void riscv_init_kvm_registers(Object *cpu_obj)
-- 
2.47.0


