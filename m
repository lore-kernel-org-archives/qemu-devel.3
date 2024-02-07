Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C3BC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 02:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXY33-0003E0-Tl; Tue, 06 Feb 2024 21:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXY32-0003DG-75
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:52:28 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXY30-0000dB-OU
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:52:27 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d7431e702dso1939615ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 18:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707274345; x=1707879145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/3IB+SoDAzkmHVKlFR4bQnh/JTWAMai5rQK+rwyNyA=;
 b=DoKQseycYOVQwr8krjmQ/jUO33B5km8OCt6v40vdaxCfDT46uM3ssBhtel4LeuRK5S
 GLQmwxNXhqrBvXRUcPWhOSdPwN6OHoTWdbQPQ/aDfErS20vlni2CbK4wkEPqQg0uWFdW
 2QCG/O2+1OLb1/FgWOOYqx1IO46FOu6rjQN01D+LP11RQnbvlcRxAEnKISfAkJSnSrhi
 V3gDmej5hSGoVM7YgDH4SoKzlbUEO133qQOIVRFRMWkrf2pFmvihEKxODYC38aR+B0ai
 NroTP2ZbBhBaxyJ14swTgFBAvNYpYi9suR23pj5+LZYbJOGqpVyilCvlScwTDNarYkYW
 lTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707274345; x=1707879145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/3IB+SoDAzkmHVKlFR4bQnh/JTWAMai5rQK+rwyNyA=;
 b=mU/aKKvYGb+g5y7s+E+KflQNQ6Dwey8pBoI5RqZUOna48GHwK1XlXezfYqUwpzQw1P
 ILdb1AlR1dpNmkrkypQxOC8Zv/DMO2KrXgZppv2alc8EH9dTlcTSzEjWKCjVz9wx3Tc/
 1JGmzT6ok3io4xz7SRFwyvy3G/HWCUGeMe1NSy3G9likeVjDHczTACyLhJJU6IbOYC4C
 7Uo+sRFAL3YnRXxbi1pJzJW0+694OW6RnQ8tjVIvb1e7vkOVuBf1jGKAd3GopXjg7eQm
 t3fOFm5fAQ0G9iLQ62KLHtLHyIPLgo6Lvvb5kRR69LkbvwGxFjPz9o1DQl/j+7xPPbNc
 hY+g==
X-Gm-Message-State: AOJu0Yy412HdV9+YKyV33oqVLcEtCz2fY9kJCVaZ/PbrUtjNECFhJ9aa
 mCsJ1J+eclGMhYi+vZCg9eKJww/gLseEwuJRWh1vh1SKX720neHF++DB7jNBA9zbBgqrtmC2HXz
 J7w4=
X-Google-Smtp-Source: AGHT+IHKgVQkntaiRoJm4UCcgGjBjKoxvqU9peXhBjkUf7LKe8lpr3yH1vttfuO/2ReORC5DIr38Ng==
X-Received: by 2002:a17:903:41c9:b0:1d9:e1e3:8639 with SMTP id
 u9-20020a17090341c900b001d9e1e38639mr3687125ple.62.1707274345389; 
 Tue, 06 Feb 2024 18:52:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUAfiWzBiEt+kkkM9AN4fJ9p671JGoUeySNOU45usbl6NeaLO/FoX2gbZsuaQ8j6WIGE5bI9ADxzEBFkh4fDKXffqTFLcO+SG+kTwEKX4Jb4z5JusfDZQS+JuKObEdtmvy3
Received: from stoup.. (60-242-98-186.static.tpgi.com.au. [60.242.98.186])
 by smtp.gmail.com with ESMTPSA id
 kr8-20020a170903080800b001d8ef97de4asm255435plb.38.2024.02.06.18.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 18:52:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v3 2/6] target/arm: Fix nregs computation in do_{ld,st}_zpa
Date: Wed,  7 Feb 2024 12:52:06 +1000
Message-Id: <20240207025210.8837-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207025210.8837-1-richard.henderson@linaro.org>
References: <20240207025210.8837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

The field is encoded as [0-3], which is convenient for
indexing our array of function pointers, but the true
value is [1-4].  Adjust before calling do_mem_zpa.

Add an assert, and move the comment re passing ZT to
the helper back next to the relevant code.

Cc: qemu-stable@nongnu.org
Fixes: 206adacfb8d ("target/arm: Add mte helpers for sve scalar + int loads")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 296e7d1ce2..7108938251 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4445,11 +4445,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     TCGv_ptr t_pg;
     int desc = 0;
 
-    /*
-     * For e.g. LD4, there are not enough arguments to pass all 4
-     * registers as pointers, so encode the regno into the data field.
-     * For consistency, do this even for LD1.
-     */
+    assert(mte_n >= 1 && mte_n <= 4);
     if (s->mte_active[0]) {
         int msz = dtype_msz(dtype);
 
@@ -4463,6 +4459,11 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         addr = clean_data_tbi(s, addr);
     }
 
+    /*
+     * For e.g. LD4, there are not enough arguments to pass all 4
+     * registers as pointers, so encode the regno into the data field.
+     * For consistency, do this even for LD1.
+     */
     desc = simd_desc(vsz, vsz, zt | desc);
     t_pg = tcg_temp_new_ptr();
 
@@ -4600,7 +4601,7 @@ static void do_ld_zpa(DisasContext *s, int zt, int pg,
      * accessible via the instruction encoding.
      */
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, dtype, nreg, false, fn);
+    do_mem_zpa(s, zt, pg, addr, dtype, nreg + 1, false, fn);
 }
 
 static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
@@ -5168,14 +5169,13 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     if (nreg == 0) {
         /* ST1 */
         fn = fn_single[s->mte_active[0]][be][msz][esz];
-        nreg = 1;
     } else {
         /* ST2, ST3, ST4 -- msz == esz, enforced by encoding */
         assert(msz == esz);
         fn = fn_multiple[s->mte_active[0]][be][nreg - 1][msz];
     }
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), nreg, true, fn);
+    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), nreg + 1, true, fn);
 }
 
 static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
-- 
2.34.1


