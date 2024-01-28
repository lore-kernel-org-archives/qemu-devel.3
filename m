Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43978C47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0d-0004pF-Kv; Sat, 27 Jan 2024 23:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0b-0004p4-LT
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:05 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0a-0004MY-7L
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:05 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5957ede4deaso1180363eaf.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416983; x=1707021783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYcGKO9y7L+9nQKGBMKS98rrLGXyxY/fBFTDvtgcJC4=;
 b=cQu9qzDOk8qh/9nVgpD1JtJCoLFPpNEsrMgzXLSYxeX5TOPiDTRrOfK0vRo4bL41EL
 wqwpXgE/XdW6WM3TFOKJ2PM59zfdk3Uad71u5iCEXoONm2GvS2uOAgLF2sRoPPwi9rOT
 dSgayf0qJL1ynOQ52AF5FXXN8CZLwBW4wXN4CV7K4RyJZ4otJiKo3Yo259TVeriODl77
 TWvBymbgjOPCEJ+V0Xp2pi/1fssAWIp2UszDsWFPug+FHEzEJpof761XDMWyTJqMKx7k
 I7bzSaHjBxvMSNlksch5Vjt8BidWCbJKbo2nwjiUde5dRkULlwLbAqbf6DJ+eVktCuDg
 NtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416983; x=1707021783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYcGKO9y7L+9nQKGBMKS98rrLGXyxY/fBFTDvtgcJC4=;
 b=TczMa5ljoD5o56+yn9xco0GLCjtMNU9lUtyxET0doQzW8FMtZSg/ZDDFpKomZ2L9z4
 mat2/tvqjDl+m9e51tCewRyKo6KA2hz3+Cu5lCCNb0WFTuqizqRGGts8oAA/9CLQ3qPN
 9mt3p7TruEILFa4fUz5CBnMDFOhXOVOdFfYIMNx+7dIDe37bI+Phebp872mIjBoCD2ga
 BVo7fy1/pKmKoIAGwMF/RKYtKLg1BDxbrsKlvkvbbp3hXII2mHzCyPKjHbfF/c8L+0XT
 DkQSilivcrfDrsVGd31NdL7YgkL+/6FglfxkgrsRDNEQW2lGAM9U17/xkivwFW8W8veU
 Qpvw==
X-Gm-Message-State: AOJu0YxtXOXhD238YOketFbsPyQSBg/isl+JlfoMHxPFpmrVQO5ZTC90
 ruuuWM7kBh0VIUeX6CAV9WUqXuiJ6OxhjpsLFiVc5qIqEzes9PAvJZ0MPIhoyXT0RBUET6c1Zky
 cXUq7iA==
X-Google-Smtp-Source: AGHT+IHFNaj2yS6YbaRTmr3lHAiin40bBj0nluT6OXuPekcIN7tDCtyDDnYEiBUEBjEjo/a7OrDlhA==
X-Received: by 2002:a05:6359:2b0:b0:176:b25e:a36e with SMTP id
 ek48-20020a05635902b000b00176b25ea36emr2528020rwb.52.1706416983010; 
 Sat, 27 Jan 2024 20:43:03 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 18/33] accel/tcg: Make use of qemu_target_page_mask() in perf.c
Date: Sun, 28 Jan 2024 14:41:58 +1000
Message-Id: <20240128044213.316480-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Stop using TARGET_PAGE_MASK in order to make perf.c more
target-agnostic.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231212003837.64090-2-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240125054631.78867-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/perf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index cd1aa99a7e..ba75c1bbe4 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "elf.h"
+#include "exec/target_page.h"
 #include "exec/exec-all.h"
 #include "qemu/timer.h"
 #include "tcg/tcg.h"
@@ -335,7 +336,7 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         /* FIXME: This replicates the restore_state_to_opc() logic. */
         q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
-            q[insn].address |= (guest_pc & TARGET_PAGE_MASK);
+            q[insn].address |= (guest_pc & qemu_target_page_mask());
         } else {
 #if defined(TARGET_I386)
             q[insn].address -= tb->cs_base;
-- 
2.34.1


