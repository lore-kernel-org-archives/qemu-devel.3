Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475C8C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Hi-0006xG-21; Wed, 02 Apr 2025 17:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Gz-0006E3-Jb
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Gx-0006TM-Tl
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso937995e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627917; x=1744232717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L5kDYbbK5HDage0dOAETaHuUGfc/nGK2Y9BW2LB07RU=;
 b=qwhuTbJrZS6SwFpRg6W5j6/bNgZB4YYpCgbqcx4Q7LpsEGVePSs18PmVlNCRfkATwa
 qB0AWJ4B8X0af3IOxjPN5XsBlerE7W0zQWCGRUXtk4XInHdL2sR7o0TLV51F4G3g7EFL
 9mi0Qx9peM7YIP94IRNvRIlBMWFIaoqqrNEOZqut6aIpEtqpzSBcHQXNoCKlHoLWeoj1
 v+e5ffpDEXTgJisrUhGWz+uFH2S1RYq1vW1RLwxbk68sLB2d5VbK6nk1RTR/X0fr3jDl
 9n5vssA6j+EcNZEzk1FdjA8sX/I8jLI+Pk+fw/it5vXdGF2xszZ6MHn07i0dwLf2SBSR
 IPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627917; x=1744232717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L5kDYbbK5HDage0dOAETaHuUGfc/nGK2Y9BW2LB07RU=;
 b=qP/GxzlgU8dMd+AAyC9TfXKE868TwOcQIsY1XL4PLyUj2CUAqCNQdS0JObabjch/q1
 7f6V1Xp5refTqOK6BDkebxzC19Sd26E0eXPLUNAm1kXP/qdKuEiqVXlDnsbM76iIEOec
 bDqI/aFFkZxbYLJUkpZ6Jjmwvoo3BVp0pAtx+1ygoHk+YQQ6e8cE6eZp9kyi1oj5GQS8
 pHiPJLpLDHke++i14Pe5DQUV0pbWXH0X23kAG42tDVNv8Lo1sWxzJ2mBx2HWZdQEvLca
 smcxjdsEoaH13nu6LLf4SKLUuuYrnpFu/0gfrv3LKWCN4mDIs2IEQqvVgIWfITTtXayR
 0ZhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn2cYnh6iMkSizwaaOuvZ2t7VSxXzY0/C3NoNKPvsGOC9UPfawkoGYTe026iN0h4JO3PhyIDzBcYYZ@nongnu.org
X-Gm-Message-State: AOJu0YyAs8SeDUVrnnF/fro6V6HsEMDdEmjDW9lpbCz1e+dEnBmfY34w
 hD8OpNZsDKAV43vi7fg3WAzGfEzuJyLwvjrcWbe62FsKoUDKAf2o35SJ+q2UQDlAIQYaCZ6hate
 h
X-Gm-Gg: ASbGncu3tbumsgKQzgGeMGXnZd3s8/kasw1Z5kYJGDGcMPXrd+q89xp3k0t6ZgXV9Ll
 9rH0vEyWk5MZZi7f82KhnYmgcBgahmiGoUGyjb0GyjVgyoXfzALQgp0MYIeRNwDVeXkJxTaq2UB
 Hee7b9/EYMRy3rqDkSYveBGDukZSAmWBd+rvLq+U5qcqbL/GU8juT/Ti3vI7W2Rk/yYsc7kq0AN
 rbJUC4v7T8RIfyK4qsIAe1OpdTwErtDOWcjchs3bns31iMaRF0OEGig74zw4gU/uoofGuZVgSMe
 G6gCTZixhU7xXfafCaOAjMsJGOWYtiVh1mD9ErDdBH1s6yPToNBRvxSXToE+IbmbFLhQkMifCXI
 3TkIplo8VsKvlUdZJwtQ=
X-Google-Smtp-Source: AGHT+IHnIM2+nXlKMwzms60T6aSHotKK5daIRJxxh4VjSDjnyW/Fn7hNF1K2YA2Kq4TZncdDza6QTQ==
X-Received: by 2002:a05:600c:1c22:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-43eb5bfc50cmr39272145e9.2.1743627917591; 
 Wed, 02 Apr 2025 14:05:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec24f9d08sm54275e9.17.2025.04.02.14.05.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:05:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 22/43] target/sh4: Restrict SoftMMU mmu_index() to TCG
Date: Wed,  2 Apr 2025 23:03:07 +0200
Message-ID: <20250402210328.52897-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
 target/sh4/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index ce84bdf539a..df093988cb1 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -266,6 +266,7 @@ static const TCGCPUOps superh_tcg_ops = {
     .translate_code = sh4_translate_code,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
+    .mmu_index = sh4_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = superh_cpu_tlb_fill,
@@ -291,7 +292,6 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = superh_cpu_class_by_name;
-    cc->mmu_index = sh4_cpu_mmu_index;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
     cc->get_pc = superh_cpu_get_pc;
-- 
2.47.1


