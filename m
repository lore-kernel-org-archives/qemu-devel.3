Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F42C54E66
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 11:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjHkK-0007j8-12; Sun, 10 Mar 2024 07:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjHk9-0007ga-2u
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 07:53:31 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjHk7-00041a-Nr
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 07:53:28 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so3216468a12.1
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710071605; x=1710676405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=DJuFY74Ib7pRxCJOJmYWV0G/GoToKoLv9rCnKlYvsnUrzFh8qG6RiGg4okZ1VF4CtE
 4N3dTBxI02yD2JkTUbGKIajPhvjcsMHbKNOiClh39rqyUoejNf3+LDkD4XgdYpNR0+Ef
 rX2ZlIIjJgMzeHmCTxjFdkOsSedYPYEuZqRtfnfiic2oIaOnMQnH0IMipvcFQHYrBh5y
 yLW1fvYHRn08GTa3Rc2KZISyYQZ9YRVpuvk4lbPv74bj0iJJuWJ7aWMvtVMnUg5FBdS0
 g9sUnkKGRjQhtMYq4gH2TChBOmC6t5Y8lIdw0Gp7JH6I6VVs+au/alXyUKBLV4qV1ERI
 CfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710071605; x=1710676405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=oBb1Vplp6Vjm5IB8TSxA/KaAchxNfm0uYIXUBaDkN4JAQUl8RjPsLWE0wNjt9l9uID
 /Y/7LsYFqiTRtKtdV287z2SjHEM0q/E4Dluk9ANRIKjDky9qEE/ffPFlJTwP+oE/tUHt
 6ckrHMrB6z/vqax/5MoFPWBHs6jwF/aizRI1KjfWxpW3moc0iptpkc5sUWaIrgqJgAJ5
 BgEJef0Ju9zXAcCz8qKUAjg2ivUDyH1DCQcv4XElTJH4rUyo14dubjHSm8pX/qrtXg0r
 QALIvXVgq9Dc19/vsVRjGVWqQwDgBGibnyncqCdz5yziy891pyKIAZITJJA4EHoxB5s1
 /9wg==
X-Gm-Message-State: AOJu0Yx0+GITEJIJQSU0sfbRJtCgmSpEcjFHqqkl05GQUajSaMr/40+f
 TeD1/0V1tbEDvOYCu22Yh+qKp/mL2L5/DtMvSBd8jDpzJa4jyXwUAlpE0TTZF+ao2C3rEv0XEcE
 W
X-Google-Smtp-Source: AGHT+IG4KfrazGU/f//rbpQyy9ewTUhdUY8aWZmwDc/x1u4CMpXVcc+gFv/lSI1EDGDRHxQP913xOQ==
X-Received: by 2002:a05:6a20:e608:b0:1a3:1349:8489 with SMTP id
 my8-20020a056a20e60800b001a313498489mr1092223pzb.30.1710071605583; 
 Sun, 10 Mar 2024 04:53:25 -0700 (PDT)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 g22-20020aa78196000000b006e647059cccsm2449253pfi.33.2024.03.10.04.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Mar 2024 04:53:25 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 01/10] target/riscv/vector_helper.c: set vstart = 0 in
 GEN_VEXT_VSLIDEUP_VX()
Date: Sun, 10 Mar 2024 08:53:05 -0300
Message-ID: <20240310115315.187283-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240310115315.187283-1-dbarboza@ventanamicro.com>
References: <20240310115315.187283-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The helper isn't setting env->vstart = 0 after its execution, as it is
expected from every vector instruction that completes successfully.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fe56c007d5..ca79571ae2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4781,6 +4781,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
+    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
 }
-- 
2.43.2


