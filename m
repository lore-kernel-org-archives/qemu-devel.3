Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C1AC3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05GO-0004vI-Af; Wed, 02 Apr 2025 17:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05GJ-0004qN-Nu
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05GH-0006D3-H6
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so198656f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627876; x=1744232676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XjnxNgg8gOqZw4KhTFILOmXS8vhgkIx0afLG7jNhnxA=;
 b=DyBvqHjZOmahuE9HZsbaZsPyZ38+MKD8oDq4eBgUJG9O4peL/dzNSqcxhf0gx3Rebd
 LjD/FahGBnbWcJ2E74D3wg/OgTdQLbI7XcDwEOwoyiaQAzTi/pU3RzIYWDrIKfvH7kH3
 WuppUlAUNrPQrGvf6W6YGIoR8Z79qoz9gO7WqdzFUR4UPJm9I79cH5l9ig3e2/UA0Cy7
 H9tjXAClsQjxQTcCTkSMBG2yNQjhcZBMcOp7xaEqvqCMRZ3fXHvlB9n+kkdJnJkprlQP
 30Wb7mnH3kaae3Km8ZYNbArlUBIEvn2hPdZbKgPT7o7+J+PE+l0/6nWSiTDDBXoqiQIx
 4K6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627876; x=1744232676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjnxNgg8gOqZw4KhTFILOmXS8vhgkIx0afLG7jNhnxA=;
 b=F/u7GWZ0PuRIaVZeW26pZwnlWIEB7gb9tBgRpzaUsPd33IbH2TUHPNBLk8jpJtN2Sw
 MWyBTLGlumiZE5vRAgoI4ao3d8d9JePXl5o4DLNb2ByN5oABP1t1vxJSN2wun8TnCyjD
 8cYo6WBOwq0UOzHdoqvoxq6SRe2gLsiboG2Q2RPShUf3IV00ZcufcnLbN/iiMmD4/a3C
 P8CD/uzLR39YdWW5QHZijoflPzhdOK0/q6/9sWxzdP3cTaiIWC/nvy2mqb97lGVJFs6T
 Es4n3ay+iOjtdpjeoq/uNnHL9qaJ4Qc07CCTT+5gckOG1ZGgcBPj+Q4Yl4Qy7mh5Z181
 0KWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpArdHE0f6+NU037IhOUJGoUvKtImtXHocevvnVAil5S8OyKgkd0nwGTPHjqutwVhluG8tAigwiXm/@nongnu.org
X-Gm-Message-State: AOJu0Yxu55Y1wF5tHKUg/C0HkSHTMCanKB/06K1R2Dyna/0J4DEtyg7h
 K0+aKkb5csLZbXV6QVeEaXIWLnOrYcG0VPmckov0BtEIrFwGMt7QEyr5MZaRC1AvsIGz8dNv0Mt
 D
X-Gm-Gg: ASbGncvptFfkZJg7z/C2nw3XZ7xSGUfWCcaqkdJWTNGjI8Gk0VWeDqyu2EVJCqEML+J
 fFKMWhMg619oi3TZVFe4B4VUdm36XW/oshvi7vA7jTbU5vEBeY4++Cw0jcyaBtBBHo+BjK5Jkdl
 H6RKrzWiEsWSTmTkEWmlRJk9H+8mafv1dLWcLmSEwDdOUlIR3lwr1nF3gvFG2G2FEU5Tj/vGy9d
 OO/24e7SgyBMyD0Zi0WwChj8nJmhuR5pdfM8P3HfM7Hx0sUvGHVLYRDPqKZM48yjkMozX2u3B+o
 9HVGABgEkSYBThxRL1SIdnAXet4aScnL3BCbIORhxpLNbAWbwU4uLSL6F8z/4VxmPmHTFMzT2eO
 +X3Sp7AYhpJGyWzPGZqM=
X-Google-Smtp-Source: AGHT+IEU7xCh7eaYAtdssOqKULD+tQw4L/sGkomZwpmDOT+z0feqj9nzKQVHYHKIiE5yfAW7CUBEKQ==
X-Received: by 2002:a05:6000:2403:b0:39c:141b:904a with SMTP id
 ffacd0b85a97d-39c141b90fbmr14002972f8f.11.1743627875993; 
 Wed, 02 Apr 2025 14:04:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16a3aefsm2043385e9.21.2025.04.02.14.04.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 14/43] target/microblaze: Restrict SoftMMU
 mmu_index() to TCG
Date: Wed,  2 Apr 2025 23:02:59 +0200
Message-ID: <20250402210328.52897-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f3bebea856e..88baeb6807a 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -431,6 +431,7 @@ static const TCGCPUOps mb_tcg_ops = {
     .translate_code = mb_translate_code,
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
+    .mmu_index = mb_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = mb_cpu_tlb_fill,
@@ -455,7 +456,6 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mb_cpu_class_by_name;
-    cc->mmu_index = mb_cpu_mmu_index;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
     cc->get_pc = mb_cpu_get_pc;
-- 
2.47.1


