Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149B8C25B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlz-0008KN-Ex; Sun, 26 May 2024 15:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlw-0008GR-Gh
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:13 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlu-0007fz-Nz
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:12 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-681ad26f277so1878463a12.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752589; x=1717357389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0ldsWBJnZhqtqpvFdEeLLnM/L0AUGzGIuEYvOl7JTo=;
 b=mGxwdgkuGaTVUAcscE+00Jh3o9fMMCoyU1petzQ1d0nswAE3QxutAMbZqqdd7oKTFS
 xTIH0dd8FamK0y/DsiUGFPcbQXFYa5W/ngzX2LLTH/xADJxTSjuqaHGUchqpHKbj0Cmp
 jS+Tqqxu/3ApM5iPsVZuhZwAxCGk/2qvCl+qFRyFKJigEmhtfAARs/HZWbuagq6jGVnk
 u/55FBMIolx9uETnq/NqgzWO4FESRP1CvvHwB3WJjCQmbBFhy/2MFJFed7qkUMCdXRlU
 zBXbX+BNsGVg23rCTE4hITcpJ74g6kL/b0GPuTxtZ3jezoSqBQT/qd34mJdP9A5dUm3d
 YIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752589; x=1717357389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l0ldsWBJnZhqtqpvFdEeLLnM/L0AUGzGIuEYvOl7JTo=;
 b=R/WWWsokTy7iLLMGMDVl3iqx5YkUs8iKfY1DkEWCTd7ofVJV1HUb/JxK0v7Ud+dW0j
 8V2g0alj/tXqOcs4RUT9MuFXGVF4OZ0yPWz4e+dGzTMgjW0KkmH8gUBhrkRx29UilTSn
 OQb3wE5jlo2PmrgBbBIM3kFMVZ0fFNGWu6iGJRXEeexx+tfJAV/lEJB3ziEvNXGQY+jY
 3FOv7fZIgRXN3tG1IQkyID5Xk6LwaNpNuywF8PyqrzCAx4xUOxSchBKSz+2qjiHl2XzZ
 5iEE/iqPH72Amg2NSW4UZNPv6bXmRPugPD97ODm/tWs71+czOHVwSuSdMAUAhMd4sVez
 qGng==
X-Gm-Message-State: AOJu0YzyMmh6DwaxA/bKaO7HYOwCFf9on2BFqxW/4TjKOHzSfbM9PfhZ
 lYiTSc9zxqvI3yPJRsqN5860pfvvWhvJZDCbEgSE8dii0jWme4LD+ko2U0ZPx+mkQh4Swny4RYv
 s
X-Google-Smtp-Source: AGHT+IG2TyYHf6TjGFeNwv5L5Fju/xzBsfaFTanSFXVLmWKG6LZqperMsnrI0/YMylXww8xQKwI5WQ==
X-Received: by 2002:a17:902:cecd:b0:1f2:f4e6:cdb6 with SMTP id
 d9443c01a7336-1f4486ed3bcmr92836565ad.23.1716752589348; 
 Sun, 26 May 2024 12:43:09 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 17/37] target/sparc: Implement FPADD64, FPSUB64
Date: Sun, 26 May 2024 12:42:34 -0700
Message-Id: <20240526194254.459395-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 2 ++
 target/sparc/translate.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index febd1a4a13..70ca41a69a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -441,10 +441,12 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPADD16s    10 ..... 110110 ..... 0 0101 0001 .....    @r_r_r
     FPADD32     10 ..... 110110 ..... 0 0101 0010 .....    @d_d_d
     FPADD32s    10 ..... 110110 ..... 0 0101 0011 .....    @r_r_r
+    FPADD64     10 ..... 110110 ..... 0 0100 0010 .....    @d_d_d
     FPSUB16     10 ..... 110110 ..... 0 0101 0100 .....    @d_d_d
     FPSUB16s    10 ..... 110110 ..... 0 0101 0101 .....    @r_r_r
     FPSUB32     10 ..... 110110 ..... 0 0101 0110 .....    @d_d_d
     FPSUB32s    10 ..... 110110 ..... 0 0101 0111 .....    @r_r_r
+    FPSUB64     10 ..... 110110 ..... 0 0100 0110 .....    @d_d_d
 
     FNORd       10 ..... 110110 ..... 0 0110 0010 .....    @d_d_d
     FNORs       10 ..... 110110 ..... 0 0110 0011 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cf5f1ea4d0..52b9590b4b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4908,6 +4908,9 @@ TRANS(FHADDd, VIS3, do_ddd, a, gen_op_fhaddd)
 TRANS(FHSUBd, VIS3, do_ddd, a, gen_op_fhsubd)
 TRANS(FNHADDd, VIS3, do_ddd, a, gen_op_fnhaddd)
 
+TRANS(FPADD64, VIS3B, do_ddd, a, tcg_gen_add_i64)
+TRANS(FPSUB64, VIS3B, do_ddd, a, tcg_gen_sub_i64)
+
 static bool do_rdd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv, TCGv_i64, TCGv_i64))
 {
-- 
2.34.1


