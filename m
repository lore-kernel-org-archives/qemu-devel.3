Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67664C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEJ-0000Hs-Iu; Fri, 04 Jul 2025 12:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEG-0008UQ-9V
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:36 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEE-0006Cf-Db
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:35 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so919822f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646333; x=1752251133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uUGcmKTWMbJhfqvYvcu9u5YllHguR2fLLPA2S7EUDak=;
 b=ukj2ZoFxrGipRG4QmkDmwb2NBS6yZUOpd6ZjahWKqajJqbNXyVpRPh/CDFr1zEP/G+
 WI0reKAtqjSbXggJSvX+WL+g3iYsLWWTIEtkdqq+CEuTZNPrZbHyvqea7a/kkd2iCf9d
 a2eMhlPIu7Oxg2IABggPAGGAtXqqK+UqFkLbOXSREAWHU1fczssbq3MtvprvQcXUP1kL
 TMFB5ugTA1uZS1ZrXK5hVDxeo6xrfrD+eQgngct29B8e5zwQIpyrKLuq/lhJjfICOhnT
 1Fkl1vHbu28h+9wpZ7ZRw5okDJSNeqak2HmIfC+SWAy71n08s7BCud4Bd1Lj+1FLWOxm
 mEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646333; x=1752251133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUGcmKTWMbJhfqvYvcu9u5YllHguR2fLLPA2S7EUDak=;
 b=Qo6zNLCmePo8DgCkYwcPYS3KpsGZ2Lx5adDvAWsPEzi0hCuotCZvIxeQfi4D6/6oGR
 i7n4ojQwMFP1/PwVzrNtzIRHvYn5GPP7M76xebN7gVnUtTwI023KboTsB3M4J6HXqoXy
 ibqGW3XuY+vxlt9kFwaqkEImvElX4LbCcHU+OoszsJV3wiV/SNpfLjXgm5p/p3WhkXHq
 bX3+i+2dipkEs4y0/Y7uka0mrv9oEbFYkuC4qI6RGxsTTb7rkOPfWyUOH6J5aXdwHC3C
 W7mtiAHHIO8vxE65d73jDcy8OfDlCgtS+0HsvD44cnjCQVpPcm/2hqPrNEmxANvlEXRf
 3qpg==
X-Gm-Message-State: AOJu0Yz9Qhvd6f5t9608wc3Jo5A7qlSva/PddFhHEq4CO7+YgaIyHhwA
 6tWl36jyU5vqPd/wXY7jNXJE4GCbe3IDB2iLT6DQ/TYQYgKN2RWclW5NkqFFZT/ZkLIxN97fLuL
 b1lPF
X-Gm-Gg: ASbGncvd/fxz7MOPAqZCAfjXb2/3Ukq2p7jPviK5o4kW726R5MD0XHJBk4us7t+oFWP
 rHZ/vK+zyN/up0UexkmADiPcixlXkViBuIxctaHT61239LJBPplUqI4jcq3dhp8tRTmTgx6RP4E
 3Ngk+lRBn+DHOuHoXk4knHAlRiRyhgMHvRr6g5W1jqYVa9aFhkvTHojFjO/OiaCzJNOoeJ4fe0D
 nCZh27dfwVM5Gfr/MXj/2y+SeTP1YI5gplW1EoXS81KNMUG2+prS289teDS56SSFUr7Wohgl9ni
 AsjSHVeBTNgS6YKJgIMRTHTKzXCzVTfMCqv/XYgKFQdfV/9P7YK//QPWa20T6vL3nwwY
X-Google-Smtp-Source: AGHT+IFUu0UVyjNQGgbdoXisTdCLsQIicBNaQBNI/Y66yt9NzUojZxQKVVsqrTEhqacrF3u7xu4izA==
X-Received: by 2002:a05:6000:4818:b0:3a5:783f:528a with SMTP id
 ffacd0b85a97d-3b49703b910mr2131833f8f.59.1751646332643; 
 Fri, 04 Jul 2025 09:25:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 032/119] target/arm: Implement SME2 MOVT
Date: Fri,  4 Jul 2025 17:23:32 +0100
Message-ID: <20250704162501.249138-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      |  5 +++++
 target/arm/tcg/translate-sme.c | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index cef49c3b29b..83ca6a9104f 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -39,6 +39,11 @@ MOVA            11000000 esz:2 00001 0 v:1 .. pg:3 0 za_imm:4 zr:5  \
 MOVA            11000000 11    00001 1 v:1 .. pg:3 0 za_imm:4 zr:5  \
                 &mova to_vec=1 rs=%mova_rs esz=4
 
+### SME Move into/from ZT0
+
+MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
+MOVT_ztr        1100 0000 0100 1110 0 off:3 00 11111 rt:5
+
 ### SME Memory
 
 &ldst           esz rs pg rn rm za_imm v:bool st:bool
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 9f252739926..797035e2892 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -210,6 +210,19 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
     return true;
 }
 
+static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
+                    void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
+{
+    if (sme2_zt0_enabled_check(s)) {
+        func(cpu_reg(s, a->rt), tcg_env,
+             offsetof(CPUARMState, za_state.zt0) + a->off * 8);
+    }
+    return true;
+}
+
+TRANS_FEAT(MOVT_rzt, aa64_sme2, do_movt, a, tcg_gen_ld_i64)
+TRANS_FEAT(MOVT_ztr, aa64_sme2, do_movt, a, tcg_gen_st_i64)
+
 static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 {
     typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv, TCGv_i32);
-- 
2.43.0


