Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2DFC54E49
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjm-0002V5-L5; Sat, 02 Mar 2024 00:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjj-0002UU-Qb
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:39 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjV-0007Vd-Vx
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:39 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so2577351a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356584; x=1709961384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFEdg7NNQgrayWD3SI3BgIOCHtplkk9gYK46g8nra+g=;
 b=G0PRaYXxD58R7+6KMBxs53LCV4yY4ZAu9FN0Zy3cIzRjIOsH0KIfkF6ju+IStmwz1u
 4ZFVZwoS+t4TdtkP5B/8yuRTDNHnB4wG65IFONprNFAhXTjOjq7Ozhza/4FxwfCtO6jE
 q4eWWPXuVq94BsSpU+QCKAMdC0t3OZTTY6pikOtmP/5P438BlG+UrP/zLp3zx4yomxWJ
 E6cCIo75j6rxWhpfIBfRohn8cJIEWKP3FrohKCZZiWyloCuO/XoUIufWp0g9nGjYET7f
 7VzZceIllGzChOMe5vIoYrQFm5fuMT2R7Ts6pyuB8LgxXPkwZLfujelfrKm7PnCQFEaf
 VFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356584; x=1709961384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TFEdg7NNQgrayWD3SI3BgIOCHtplkk9gYK46g8nra+g=;
 b=Hlm4Nxnu0VXy5NAM5JpwqsoHVuslPwlHT2SYURfe7fGFV/cHMOBX+xUG+8i6VG+Smj
 UXVUrBu3SWdcUs0JMTexy4FWvwMKlLXLo3QwZ9nwnwo8OUx/TrkxcHbeO7Px6B5BsHW9
 tkkZGsgMr1eW7EUGnRzXJy0sXSpWhE3IQPwQpPMQWfqHIpDHRjSe7e7LMANYoVtOZul4
 Hgb3dCiUu6R7BbGMkRxYEp+Deuuu34CbN4mh4CxHig1odwF+0ePk7gvJL/PG0lM5dMBq
 dDuDcCmLUMbOFeL5TCVFuiduyk693bteAW6T1hYem+qGlL3S6KW0K66Zcpv3hOHCJwAe
 3o5w==
X-Gm-Message-State: AOJu0Yy5EME1FMynwt6QIVnvRCE3YWM2BKkZANx9UQVgnzwydK72YCdX
 MtHK47vkMddKxEVMewiGxcpox+WxD2ZT0V6udpmRWufHU1JrJPsgNtv1JEPdAK2kpfkG9fciTHA
 Q
X-Google-Smtp-Source: AGHT+IH4DTXqmHQBl8eb4Q14+01SjVnoY7yUJbX8Jm3E+2XxLLRJy75DlCvud8y6Vrifzbrt1XjECQ==
X-Received: by 2002:a05:6a20:244d:b0:1a1:461a:331b with SMTP id
 t13-20020a056a20244d00b001a1461a331bmr1031194pzc.18.1709356584664; 
 Fri, 01 Mar 2024 21:16:24 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 11/41] target/sparc: Use gvec for VIS1 parallel add/sub
Date: Fri,  1 Mar 2024 19:15:31 -1000
Message-Id: <20240302051601.53649-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 981d9d9101..ee3da73551 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4645,6 +4645,20 @@ static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8x16, VIS1, do_dfd, a, gen_helper_fmul8x16)
 
+static bool do_gvec_ddd(DisasContext *dc, arg_r_r_r *a, MemOp vece,
+                        void (*func)(unsigned, uint32_t, uint32_t,
+                                     uint32_t, uint32_t, uint32_t))
+{
+    func(vece, gen_offset_fpr_D(a->rd), gen_offset_fpr_D(a->rs1),
+         gen_offset_fpr_D(a->rs2), 8, 8);
+    return advance_pc(dc);
+}
+
+TRANS(FPADD16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_add)
+TRANS(FPADD32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_add)
+TRANS(FPSUB16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sub)
+TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -4665,10 +4679,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
 
-TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
-TRANS(FPADD32, VIS1, do_ddd, a, tcg_gen_vec_add32_i64)
-TRANS(FPSUB16, VIS1, do_ddd, a, tcg_gen_vec_sub16_i64)
-TRANS(FPSUB32, VIS1, do_ddd, a, tcg_gen_vec_sub32_i64)
 TRANS(FNORd, VIS1, do_ddd, a, tcg_gen_nor_i64)
 TRANS(FANDNOTd, VIS1, do_ddd, a, tcg_gen_andc_i64)
 TRANS(FXORd, VIS1, do_ddd, a, tcg_gen_xor_i64)
-- 
2.34.1


