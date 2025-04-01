Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8718C3601B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWi7-000744-Ig; Tue, 01 Apr 2025 04:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhm-0006yl-DQ
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:47 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhk-0005yG-L0
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:42 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso2929876f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495039; x=1744099839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTF2Nwd/7EYny8ycNBkkJ38P9w+PAXKeooK7567a9ug=;
 b=Aa+qmfI75Bwjevipm4s6brCQ5Es3sFTHgZbB+LDPHzxWTZQmoU2q8LHDab86YSgyIC
 w8k4yFW8ngUosp+vmmgUiruxUV8HRlMygd3/jCua7i6hIAuOlg3J4Slv/2IJ/ptiQCcZ
 ekvNCzS/D5Xb0haLpuOK4vxyc4M3vOZCIfbVKsdKd8vu8WaqBZnYBSf9JGSWttJUSAw5
 9FU22m4hrA752IoTW4GBZJ7Ago+HFVSVtRWWk/KddVbSIhq1KABcVwbHFeF8BDBoBXwn
 OYVKLU4BIKo1fnw77cBlhHwgNK/9yuLafzybGn6m/34nXjDIsMkuCA+17r55Oi7D0GfR
 uxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495039; x=1744099839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jTF2Nwd/7EYny8ycNBkkJ38P9w+PAXKeooK7567a9ug=;
 b=kDI7/EvT1UqvZgA/pKalQU8LJRuXaPN0Hc+FJqXWFujUQPQUekfk4X+R0vgL0drQ/w
 wZNP3lcOfhxJLADzqD29I6CHxI6BIXpf3iLHWC9LIss3ES3ttavx0DE/bpon6oE4+E3p
 tGKypF/fO3niTrmtomsAC/dWXLxJmukYAlxvscHMSlKttiEuo+6odwk8mr0UziUgYLiA
 o7vKfbPIOeEx+fE9jY3TuU0JgLVAZrzdlTHSJ+gC2G5LPuTDXulPXciuRrbzpJ+HsU18
 aDfHrs9tojTV87JqKglIkpEwZYRaY7oqZH9OXyu3TNtZXDGepkGgNPQcEvaSlqQ0uW88
 8H1Q==
X-Gm-Message-State: AOJu0YxuQy8GUVWMzOZExc1vFnzHX3qrrSndlnImSPbXFmSNlb3lT7Uq
 uevQa1i+zKjDqo9dna9HQIheADPjC9pEdZX26ZYeP+YGDEdlVN7dysfknZah7vAz5ikd0ltMNmM
 q
X-Gm-Gg: ASbGncvOOcWUP4+nfrMNEgkFBpZUIEYEsve8U8HgGQxyucOXHjvnghcKQTz08XB3/zx
 128HIVTe6/xBth+diEM0EssShxpNi9GW8HoaWTPDHHBgVb4knD5MO2YkaDVOJEyiOnBtDYx/3X2
 /xUwoJknZBwVexx83RlxHr1YrnvHrzYgQsBre7aoJFCS1VdUtNGCaqhPBe5c5cpleik9jIyOsCI
 DmxlafJS2a0eig8AtJPmAHZJd+iAsFrTNPEkF90HYRqqqwdJ86Q/IzROpkVptCZxowMUnwxvdFh
 oRRENmNYC9sl1/JpGdmr4QqOQxLMiQc43rAEHOn3YMABmXtK/jY7ENTrsdKg29Kni6ULii7VF26
 sT0ZegQh7gcpkq/0Xhgs=
X-Google-Smtp-Source: AGHT+IFxF+ZDFJ4PYQ4VtbVEnN2L16NQiZxRJH3BnFMnyqqgE/I6wJnym/WL3tZEayM+jOzUG42T2A==
X-Received: by 2002:a05:6000:2913:b0:391:4674:b136 with SMTP id
 ffacd0b85a97d-39c120e21famr9564965f8f.29.1743495038741; 
 Tue, 01 Apr 2025 01:10:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0dcc66a4sm12394423f8f.42.2025.04.01.01.10.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:10:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 12/24] target/microblaze: Restrict SoftMMU
 mmu_index() to TCG
Date: Tue,  1 Apr 2025 10:09:25 +0200
Message-ID: <20250401080938.32278-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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


