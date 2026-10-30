Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D72606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Gi9K7B7/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTN-000399-RB; Fri, 30 Oct 2026 09:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSs-0002kC-Uh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:18 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSo-0005Vz-TC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:13 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6df0b02fe91so1349470eaf.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366165; x=1793970965; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5j5+t/rNvpj+687FV3vQnTBAaY6AK814ujVkWS3xeMA=;
 b=Gi9K7B7/waqHp2pYi6zXZ78XEN84dnfRoDLlCC628l4JJv6l2+xGVtO/OlCIdelEMi
 IeekT/LZ2F5TKrpaXBeZYELwy1XV7N4+I/BiAlJiAI58wmX2bxW2NUMonCbXsDzYcIHU
 miwJcLSILj4AMl8XkaV518TlA5ILdGKCLtUEgYKK8ZXorI0pewqnN5+S2oCOhFasyq+g
 rF4ajMXk9KNG4RSSGBIFImx0GcvQIZe9lHr1ZMID5q97laLPdlYDw6+pqjUOZ7f+9ZWk
 WeBFMmqUcjJ3H81L3GGvhrWgX5+0gvL62nXCl95+VHWJ1xzUiTO0PU7puWu/WM772mui
 6Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366165; x=1793970965;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5j5+t/rNvpj+687FV3vQnTBAaY6AK814ujVkWS3xeMA=;
 b=EC2vogOquPFrD+W2ioo40LDC4UtJSfhbDwegWKSsr9SjXuDVTI/NftAwGqJJoLjV5A
 m5RYrQUUvEf3b7HGILRt5bJkifattrA8saw56Ir0EkvFPzxMr0fwWRqlig+5SxC6U926
 FxZs7oCxut/RtCOO41xbElBG3I84creXGtpvMgeqJ5Cv+00uuCihAvNUUKI2CqvGvBv0
 GOkna/shg4vBkUSeeG0nY7cIEvMgnJsQdnbH22V1VywH0k2BbP/LbLdskUmOdT6DUVVF
 DZpgotlLiZ6jdBvGoQHJe+bogTs9bUUrZ74O0tPgeVGK68bMOp77vybBScPK5wEbVBWF
 jZyw==
X-Gm-Message-State: AFq9FYKt2Tze336VOCI/+hVwBW7per63JazEYfAgs5WWOoXkxU8X29av
 YONdmHeFk0bkr3tzABKWQbOVnw25EEx3QN6GgbETAacXZpQ80sW/1GZlUu0XT4RXyL7VFiZkJ/B
 egrXP
X-Gm-Gg: AYBFou2YsezcQB0mW0UpS6jrA5tQM8WsXd5VCnaMa/Z1A29UoT2B1fqU0E3VsLO4Tqm
 laycjNqwRhJa1h5PY9quQ7f9h5fPMFuPGqstShtgdIPufEfcYzQwv2mjYrSgGOHeZrpodbr79v9
 cqv3OSdypwh2MbUE4xlJT7DqWasQPuMDZ0xYYaqaAtjrgPB+GHjveSv7+rF+SM2j1UO+C741i6r
 U4CyyFPmzq9IIMW+jpUno8KyeTJre1LDfi1hZb5Yd2qXGwHLkx364pu/+wK5p9+PKAkxi86oqK7
 pBrmI0nyeniQ7B++4gZ/xgQ6d0UXxUD67NHtpzpFaCJ6VUefRbCXE+iQ6eq/Fx1nCHH2sazu9Ok
 Co6fYxN6vbx0pJLbGZ5iSUnKAur+0NFJ5Ji07jcX4AVT5jUkm+MbV01EziZwCzo2vb1eEfKA8TX
 Wwq0+A/q3sdGSY15ugs0VOFQc29v/QZhDYmRi18PDzeG9XsEZysoYDjiddpg3GNea3hdrJKATmN
 6/buw8jv4ajkiPjlni16tZgalR1GIwaFiG/yHg6K/r0FqWJJFhHLSn/g86xUboEUyCEoY5t/XVs
 /YZfQKiMSR/JcrCL4xxs28yxpvQzeQ==
X-Received: by 2002:a05:6820:c91:b0:70d:1de:34ad with SMTP id
 006d021491bc7-714ddf79d7cmr2957683eaf.41.1793366165152; 
 Fri, 30 Oct 2026 06:16:05 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 10/19] target/riscv: Use tcg_gen_lea_tl for SH*ADD
Date: Fri, 30 Oct 2026 08:15:45 -0500
Message-ID: <20261030131554.41208-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/insn_trans/trans_rvb.c.inc | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
index 3e74be223b..82e715c7b7 100644
--- a/target/riscv/tcg/insn_trans/trans_rvb.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
@@ -336,10 +336,7 @@ static bool trans_orc_b(DisasContext *ctx, arg_orc_b *a)
 #define GEN_SHADD(SHAMT)                                       \
 static void gen_sh##SHAMT##add(TCGv ret, TCGv arg1, TCGv arg2) \
 {                                                              \
-    TCGv t = tcg_temp_new();                                   \
-                                                               \
-    tcg_gen_shli_tl(t, arg1, SHAMT);                           \
-    tcg_gen_add_tl(ret, t, arg2);                              \
+    tcg_gen_lea_tl(ret, arg2, arg1, SHAMT, 0);                 \
 }
 
 GEN_SHADD(1)
-- 
2.53.0


