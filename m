Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EB9C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx09-0004hG-Td; Sat, 27 Jan 2024 23:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx08-0004h1-I9
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:36 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx07-0004IJ-2T
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:36 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2954b34ddd0so313366a91.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416954; x=1707021754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Abpnrf3mk/IImEiBxCwuY+1bvCj+UYnsd1PobWXi05Q=;
 b=DvHQdL7RtDp5fiwNd6IpYwISdNEuhL42GcWdh498Rp/aryiZssq2rrbzALLYd4HjjP
 wAWOxZsPLX1E6EyKi5dECOfcPddFvPtHWvleD27hThyh00iYVFJzyS9usmT0lpNybE89
 lH5/Fv+I1fbp5TzxyOERuufr+s6OdKtFSGnu4iFTeUrWK3Qdwk60jqnvfzNI7H59HYjB
 Be3j/9fWcJJnyETWs2ik+c1bjaeFwu7dWuMc6qyspdD2EUo4mVUv/vJdDkKFYtYWiJYd
 1gteFDpL9sdBx3+VltnJPJqUaE+ul1E/TzegE4LccY9o/MbQBnkZ+kr/gKNpuqx2HsFL
 ipQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416954; x=1707021754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Abpnrf3mk/IImEiBxCwuY+1bvCj+UYnsd1PobWXi05Q=;
 b=gV43DT1iu6vII7+yNxyXr7koNSSUkEe7ZDS4jnCX39nyokYhLu7uMWds1BU1/Vz50d
 GqpSRO0Z9AY+3vPSjWQ/0aYqdlpoz2awyJUOTv5wYMySVi/TU9cIS+tWmESMKhQPNkPr
 Bc0PqLVa6Ls3fsZeb69yVZXPg33IlNild8TGh9rfg+purmdtIWzKKHJqnpIva4kwkzFq
 PxtnHGSWTKA9bTBf3kiNtVsS2OFypw23FDFocmD8JACB0h8+WD8BOH2vIC3Xed2ps6zM
 ZL4jLAl26WXTZa3A0OIctCuDFWceoPZghtztSw/W8Xtl0N8SZ4Q2CMQohiTG0HX48AUe
 fhxA==
X-Gm-Message-State: AOJu0Yx9yYV4Z7QNG6k+iC58/540fCXTpC6kN5ZVKjVqUwzD2W+xbuFs
 ZvhbEd5vC12Xw6Peu/pBtUTOf3aZH9o0VND0nWeFLEee3xsJk0v/NrtLxI7qWHk35p5LMk2btNM
 xq0N6Sw==
X-Google-Smtp-Source: AGHT+IEpoFNnLJgaHzROu/lUfkxEWLO/lsNJko8Ud3yiNdnTm202KvvGo/iFmaREBhwSLEJRNlM5Ig==
X-Received: by 2002:a17:90a:dc0a:b0:28e:8937:7db0 with SMTP id
 i10-20020a17090adc0a00b0028e89377db0mr1668006pjv.65.1706416953673; 
 Sat, 27 Jan 2024 20:42:33 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PATCH 06/33] include/exec: typedef abi_ptr to vaddr
Date: Sun, 28 Jan 2024 14:41:46 +1000
Message-Id: <20240128044213.316480-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

From: Anton Johansson <anjo@rev.ng>

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-11-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 6061e33ac9..eb8f3f0595 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -121,8 +121,8 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
     h2g_nocheck(x); \
 })
 #else
-typedef target_ulong abi_ptr;
-#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
+typedef vaddr abi_ptr;
+#define TARGET_ABI_FMT_ptr VADDR_PRIx
 #endif
 
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
-- 
2.34.1


