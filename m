Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C9AC36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWiM-0007xs-Q3; Tue, 01 Apr 2025 04:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWi1-00074C-BC
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhz-0005zm-IF
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso34593035e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495053; x=1744099853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XazkvPtQxLujQX55Abw1RSktScdF6AeI34V3jacj2nk=;
 b=SVqqSW+/aId1xCo0PkbO5fFPt8zQKMOKvR4VjDNnZY/IV/f8n1dzOyBotgix7Wr0RH
 6lnTxyAwEAZcJs+cjEA66TmTTpr/2rPT8ThJAlSahGsJJ8VsCUfBK9/PrIF37ze5kGrW
 KL3gnqx4eGXtAiOFy7dByOoPYSg4lBFfHoAYIW1R+64aonbYCgZ9vO1jev0uiTcz8EHg
 KQb+C7DgBnSZRhcB1HgsqGOldsuKMMvmWKl4DxiN3yoEuWukRQu+hKYGxsywCmnc1tdz
 YF/vc7jguqeVVYu2sHHnMvfgkwBd7MEneKpxbykYJggzKEGAeQJKrEgEJTj55meknOgZ
 vOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495053; x=1744099853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XazkvPtQxLujQX55Abw1RSktScdF6AeI34V3jacj2nk=;
 b=cVk1YJuEfneiT1aOCTYTbB7A89L8nPgGA8T1fEuK+HWk/1fefOYoIopx03oNkUuzaQ
 o/k1GHY61o3AwlZfwccYAoL0Z1i8UK0qWaJl7PWcMoSsDeH6j31lmjKsiREZ2s8IjmKI
 sUwvkbZWiWO/wCKIaWNRBE0UPeEPxBdYXepFVqOKYWkMtPeOCjxl0nmqBVqw27gUro7J
 mlU7xftitIUEgNyAlLHjz8iu+lAv0Em83Suh8Q7JntKDkSMja5E7WMu8I+vxg98YaAB1
 kWbOeRy4nvgmDqWvs24jD/x8GGfJO5Nwy94Z2lElM/ux9E+9jzayubtIa6xyN8xAkz/P
 bVYg==
X-Gm-Message-State: AOJu0Yy4U7BdX2fEE+ULbDqzqyTjGIE3WqeKxkV94YZbiHmmQ/j3KPCK
 9eRxUC+nXKRPmSALVDm0BTv9UxsarETkHOMnZpOdkG5Tu01sQFFP42fBKrjAVvVRn54nACDMYhX
 e
X-Gm-Gg: ASbGncvweW2y+T/nJnai+G3IV/EDK1fY07QhDk0+kojolqWLN/ArSHyUqvNsOXY5TWx
 7rRtva0j7hqsagOOjGF+xNuGjRqbZuRLXyipeVyQ/aeUaALxRWZrmbWA9yKsedlrBp+F31hS8zE
 hZifRtHFdePUUBCj6H/R5ozd2ohb1gb6jiLJsQnpJLQwVidHUEKrBLe+sn7tHxlpVGjrK9AVrAK
 95gJPxPgpyuz44V7PKH+07ojtYJJE/y2wKNMir054YMpWmb+uguX5wyt1jtAXAw+WjiUPzgg7eV
 mXI5DPqHjl1NDe0pZ4wGL2uhqBbGqMmyf0zaU/0yTxcTjOjVw1FZTAi/500kgHXkFvmArqmQKVy
 kRXO+c70wk7DSu1fzJF8=
X-Google-Smtp-Source: AGHT+IGXBZmqk8tiiXyQyx2LAPTOxD2OuhHlZEg532Sr5lSAzwC+K9aekQUA1ZwNaOAdpgaxcdEUvQ==
X-Received: by 2002:a05:600c:548c:b0:43d:97ea:2f4 with SMTP id
 5b1f17b1804b1-43db61d3924mr111944835e9.12.1743495053438; 
 Tue, 01 Apr 2025 01:10:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea8d1673dsm13118235e9.0.2025.04.01.01.10.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:10:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 15/24] target/ppc: Restrict SoftMMU mmu_index() to TCG
Date: Tue,  1 Apr 2025 10:09:28 +0200
Message-ID: <20250401080938.32278-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 3686bbc9380..30238e9a223 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7481,6 +7481,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .initialize = ppc_translate_init,
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
+  .mmu_index = ppc_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
   .record_sigsegv = ppc_cpu_record_sigsegv,
@@ -7517,7 +7518,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
-    cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
     cc->get_pc = ppc_cpu_get_pc;
-- 
2.47.1


