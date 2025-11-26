Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD44D10384
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 07:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAJT-0002Ba-O1; Wed, 26 Nov 2025 02:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAIV-0000eu-Sj
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:50:46 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAIP-0003RB-MN
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:50:42 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b3c965df5so3434017f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 23:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764143434; x=1764748234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/moKxyhhhNUAAssiCB4z5/4yHLvVf9L6ospDexZsZ8=;
 b=u77gY4/r3HAEigtzbSh8xCFznChX+lrQEq4kjFVtSt1rH2aLnvJO9yc1/VK94TQ4YQ
 Ww3GIr0+mTSH5kDbn/TGhemodVHnCpq/ImbQDUUwenUAjLqfTDXoQoCH9B8OHNlrHHrV
 nbfdrzWJT4bHXh1HlEjvcYWFaHyfRrOSrvibg/WbPrHODafP+dD+Z8NaPaIQTeAKOatQ
 1ElZPuhzWUYZGfuVxGCjjEhWQHZ2nBAYq9orcBbbqiVXMAWwPdwfqlFGRxlhceXObHy7
 lqHU9yRTDYOwb8KeHvblaQGCssi11GrpSV3ZdQLfZVZyKdCYT//03SLYxlG9WjMEebCn
 QA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764143434; x=1764748234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1/moKxyhhhNUAAssiCB4z5/4yHLvVf9L6ospDexZsZ8=;
 b=XVblkzJyA63VnHVsJGHkzfkJOxCToGXqVjAW0uVT2sUxUBwuV0jC1w3SPV0T9JARK6
 Boi4yh2MoZOwKqRk7o67ucZJgDlC5xsK5QB3T+boXKWR+VqgAw/X//mFQzyJpIKEfMeL
 6cctNDfNwxtcw9WmQQTDjzxuMJs/Q92AnevN7js8Mjw3ETeDdRlybhyG/HAGcjt+Ka3z
 d2kFQSJjnkmKXBLmm5QEg7cQK2CD/kmI0Jusnq5htQSdj0OtUig2Bgu9t+9Re7Psw73X
 yy2dSYoqONnN0itMM3PN7Cq4R5YIljAiEzCgB3GEfVIwVM/c56xLUHvlVlLMJ5e59dCl
 lrQA==
X-Gm-Message-State: AOJu0YwSWt4zPKHJSG3QAYQPAMb1ZkSXGyaxMU7eER7m7n0yV/+q/5T2
 FvIyVSocVWixgN+xTrZFOuQDKrtae8/gP9iRPPsMG3Hd3CH30BSQRWBeh6/3aZGG0hU3fzouBye
 yVMs8L2Kn5g==
X-Gm-Gg: ASbGncsEbNikN8zIhtb2bkC4hEWBlt9Era4KvpRmUHeD4+6OI2EUUmnrRjkCm9NL1Yf
 jDEOR5JZszTTn1jWZ/+tY1qdjFVZZfSwE34X7umdUWtGK3Sy9oeX/ZAhDtR8LV81JAC+WV1yom6
 UYB5p6R89OfzD91wmnz4wVyAxwJPY6XRHDnN8n1eZlOKFGN+qmYAcjiGQB74VVnU/FLCG1jyH3u
 RUNnU8zgF7rUuFRA1bqiohM63plK7t64oY0P4vSow7ABW0zEK903KdQU1vLQRJfpL13XMFedPB+
 dBzGt4X80mt7+w6dB/ZuRLfWPJJBd9e/jaISPlflwgJwvAK7nI5RTA31bSXC4QGdLfqyFhDrGg1
 Le14RP/WJeWvIgUtu8TOR7QY168ECxkqjxYbvPUlQR8cEu0KAXU9qp7dN39ueRfCllYvdELm/SQ
 mFv53aqgcnk1DUTYykLhdcLSU3C2/465nbfpn0+dhVMDp1p4IsXTETFx3HJXQk
X-Google-Smtp-Source: AGHT+IGpHFx5wlWKUxvQGYPRAWG2eCuJjiDnbMvbYCeEcFP1dIGqQ4iMwaNKA56WiwfjHOYFdEselQ==
X-Received: by 2002:a05:6000:2c05:b0:42b:40b5:e64c with SMTP id
 ffacd0b85a97d-42e0f34460bmr5616687f8f.30.1764143434080; 
 Tue, 25 Nov 2025 23:50:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa35b7sm39542842f8f.20.2025.11.25.23.50.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 23:50:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH-for-11.0 v2 04/12] target/riscv: Use little-endian variant of
 cpu_ld/st_data*() for vector
Date: Wed, 26 Nov 2025 08:49:55 +0100
Message-ID: <20251126075003.4826-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126075003.4826-1-philmd@linaro.org>
References: <20251126075003.4826-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

RISC-V vector "elements are simply packed in order from
the least-signicant to most-signicant bits of the vector
register" [*] which is little endianness, therefore the
cpu_ld/st_data*() definitions expand to the little endian
declarations. Use the explicit little-endian variants.

[*] RISC-V "V" Vector Extension v1.0

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/vector_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 2de3358ee86..caa8dd9c125 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -193,9 +193,9 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
 }
 
 GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
-GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw)
-GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl)
-GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq)
+GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
+GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
+GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
 
 #define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)             \
 static inline QEMU_ALWAYS_INLINE                            \
@@ -214,9 +214,9 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
 }
 
 GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
-GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
-GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
-GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
+GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw_le)
+GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl_le)
+GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq_le)
 
 static inline QEMU_ALWAYS_INLINE void
 vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
-- 
2.51.0


