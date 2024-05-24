Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B0AC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeE7-0006Ou-J0; Fri, 24 May 2024 19:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeE6-0006Nn-3X
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeE3-0005gX-MG
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f304533064so26451485ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592886; x=1717197686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUNkPH2LlhkOxE/FhJQAuoTP7MfTsPeCObETyK8mLHE=;
 b=T6dpvyZURTbpAR1qSKze2Qr0APB2/2lXn2HAIN9Pe+I0xYnCAHAI1h0E19Tng02TqV
 PNXDFxppY4bQhXluOzeBZZ56LbmQcJjD1eGs/dbG3baPL9Z8EKfct1fINN5B3j8lRgbz
 Nqpo5tyCW5+k0Nh4iVzd8DRy7yhYo5zGV6JCWEcyRkWxRdW18xisKmF5POi0CeuP8Fp9
 qyq+BsREL/9gvIbD4rCCbYI6s2RTecp7ecPKaOCCPsHDiDLSdNTyYEsP92avXQyBiA1C
 2u9j4KhMFW0jnCjQF3DEngHxIwTyHqmQ4LF03pGjDcM9pmxrK0x8DFIsoO57gSwD1iVs
 tChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592886; x=1717197686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUNkPH2LlhkOxE/FhJQAuoTP7MfTsPeCObETyK8mLHE=;
 b=M+17h/U7xqtSaXlIhbUqmGN938UByQvkcsECh1+4XEgu8bkeSJ8nQxC1Z3la5mPFev
 pp53gP6PNTNHx5HjkMH57+KukkN0tghBif/lkY0Uz0AyZLsttkH6sPk1/VLo3a+jacpw
 O67M3jJvV1KuQM4rf3T26zhVcaM3dnxzecJ0OEV4DK+H+qrH+unKhusXSxfU2LL+vPHa
 tZA9d3VBjv3C1ptWtgmYJ9IzWQs9pmbAlSmdcoLo7OkeJz+kM9QXr4sIylGnJi03roVH
 6dC8rCWtPyCQ3VyHbGdrIkrEgPFObSFa3Ra7bQZAIdm6AqIMm/ujBYvFRZI/FIzahEao
 k6rg==
X-Gm-Message-State: AOJu0YwIhaolutk2ziTu8JP5LRIDUrwf7bgFWhWDNVj8CijgCp7XLnNr
 uZX2N9Kn+6+A9iNTnRooVOXRhK/gfMK+Q00AygSP+4glMRDe5HPl6WLUTGblfkAi9Vk2t3z03Mx
 i
X-Google-Smtp-Source: AGHT+IGbRw56tv/nDOLHwWpzYvvs08EsmVHgBobiGMVib0z7gMZnbhegNG0lGT9ttWHOX8OyEfPp/w==
X-Received: by 2002:a17:902:ce8f:b0:1e7:e7ed:cbd8 with SMTP id
 d9443c01a7336-1f339f51964mr95547375ad.22.1716592886285; 
 Fri, 24 May 2024 16:21:26 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 04/67] target/arm: Zero-extend writeback for fp16 FCVTZS
 (scalar, integer)
Date: Fri, 24 May 2024 16:20:18 -0700
Message-Id: <20240524232121.284515-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Fixes RISU mismatch for "fcvtzs h31, h0, #14".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4126aaa27e..d97acdbaf9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8707,6 +8707,9 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
             read_vec_element_i32(s, tcg_op, rn, pass, size);
             fn(tcg_op, tcg_op, tcg_shift, tcg_fpstatus);
             if (is_scalar) {
+                if (size == MO_16 && !is_u) {
+                    tcg_gen_ext16u_i32(tcg_op, tcg_op);
+                }
                 write_fp_sreg(s, rd, tcg_op);
             } else {
                 write_vec_element_i32(s, tcg_op, rd, pass, size);
-- 
2.34.1


