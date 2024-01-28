Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C387C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0i-0004qW-4x; Sat, 27 Jan 2024 23:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0h-0004q4-Bu
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:11 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0f-0004Ms-TM
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:11 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-59a146e8c85so791257eaf.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416989; x=1707021789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TByYFDCUWCaxnnHjASz8MJMk4paFqdDSnL+kqN7t/Zk=;
 b=eXVbQFpA+LwlZFCaBQFGeO7sBbwOFpHC+n0fqfHlnsGsrCQorVgeKYt3/KczxMixdM
 wrGi1d7xPh+MwKQoMQ5pMDYBOFBxUf/fHe/PAInQdvqZbJJveiEITSnUPZ3mfoDbQyMG
 QCsjiT5ljWld1z3cHeLY7fQTlxMUlsFqlJ01CzyBYlP3YDsOcRdkf632C1oJjeS5j41m
 G2zo3xWKbK5bmPbcMmvEgHp8THlNXwMiAQX/+e9mZivYEZxn5/7bjvL0FMVtvXgmqYkO
 pDZTaWEueUb+0ANvDCulyAlqORr65MSCizDjhb5CC7z44OW4276hLB//cC4PibsgNKEb
 eYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416989; x=1707021789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TByYFDCUWCaxnnHjASz8MJMk4paFqdDSnL+kqN7t/Zk=;
 b=UsSrDRgdVtNrp6lWlo+EOKnp8scB87+c2gHEgDQvkKLtn7oHST8quLMTHDaFlnMLCT
 MAErvj5zGoLJaVM/CmN+QK8AQ8+fKwYeTR+sMYPjo+JrLRk+NaQzfpcnYhcoR4MwzzSa
 SAdtyNUewBcEGJ4SKjM74JIlZBU8tpeuYAIfFTvi7ksTLYqrWjs9Z9Q4VHcixZI/AXSg
 40N+Fld5kpTOMnJuDsfdcZGzuf+T4DcM69nWOXl9VDyd2eXaTA2kITowPcGWAkatsurC
 NoWpQSY0M2zI0CgQwj01snN0b/cMlO/L0hBcLBe1BEO5ZFGC/dz0eEVD9nBTdzpa86ac
 m2kA==
X-Gm-Message-State: AOJu0YwFHCfr1LkDdYN6A3OzvA0g+ix0uNW9Ydq3zL6OznsnSvRus8qX
 yzFHDU7aspjK0EGMawzMDM33dzdETwCIxN9sOdevW070nkUY85YfiE4GmW6TwNTfzsW2h1OmVDY
 /2j3MGQ==
X-Google-Smtp-Source: AGHT+IEGpw6L5swsr+ZUjpZfyryp3qm5R51U2sJW0Yl9+Ko5BkDSoHjb+W9SM5aSwGMBgov3iRSJUQ==
X-Received: by 2002:a05:6358:7e9a:b0:175:cc50:56dc with SMTP id
 o26-20020a0563587e9a00b00175cc5056dcmr3369287rwn.58.1706416988777; 
 Sat, 27 Jan 2024 20:43:08 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 20/33] accel/tcg: Remove #ifdef TARGET_I386 from perf.c
Date: Sun, 28 Jan 2024 14:42:00 +1000
Message-Id: <20240128044213.316480-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

Preparation for moving perf.c to tcg/.

This affects only profiling guest code, which has code in a non-0 based
segment, e.g., 16-bit code, which is not particularly important.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231212003837.64090-4-iii@linux.ibm.com>
Message-Id: <20240125054631.78867-4-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/perf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index ba75c1bbe4..68a46b1b52 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -337,10 +337,6 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
             q[insn].address |= (guest_pc & qemu_target_page_mask());
-        } else {
-#if defined(TARGET_I386)
-            q[insn].address -= tb->cs_base;
-#endif
         }
         q[insn].flags = DEBUGINFO_SYMBOL | (jitdump ? DEBUGINFO_LINE : 0);
     }
-- 
2.34.1


