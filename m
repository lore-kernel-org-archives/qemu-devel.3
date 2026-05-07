Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196D9CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8S3-0007UK-8O; Thu, 07 May 2026 19:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rq-0007DX-Eb
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:12 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rm-00027z-VL
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:05 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7de44ed7a11so1212947a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197681; x=1778802481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeHqaA4eUNZ/cnZls9YTWTYizcqfhEo9ShP2VlzzQbM=;
 b=Ez0kgV0SE/0PSa3zoXPf98suNVav/ue4qKJdJS8N800X9DT968/uP/e86pdoclPYwc
 /mbhoQVEOvA4uR1hC8Vfaa1J7m7QdBybQUH1ICVMawBqlfA1SmNSKYDEvHb2mOzirqAT
 I+oc3LilT5JRaOu5PR9zS4n1lCvDkn2YVBVuMOcrkvVso1rkrdgx5QNzV0d+kJ7EvQKv
 LWBHCiUqRa49GtA57wooFX/PsFldi+Mw0HN39elF+eqeWO36UM+N12W/tl0Bh/ylY9ih
 z8IWbh5gEz0BrItWc6KuWRX63ZhhX02IUsQKj0SQ8Vm8QpONl9yOjpmmzLoV3bb8ysvM
 o+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197681; x=1778802481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AeHqaA4eUNZ/cnZls9YTWTYizcqfhEo9ShP2VlzzQbM=;
 b=ECKc0Sj6dYw6m7OpuihoAyCb3qIqXBbj0vCQ6eGUbZ1rUpA09AUDcWtp24A6EB4GmG
 pL8rP+d3gL7D+T58aWgUXT8JMy9tzFVAg1x3O0W7WAtl00WnMvct6oq9ylSSdIEptq5g
 x4T6aq6peeN6XeW1GYcMkq6qJqHoJUTjdSGL5eVRs3V23IQeFGggTCtkDNTA7FTL925p
 ggXPhO7E69VgKTgQKy500/H7A3AT7+RYLowZPJ/G5rCXb7U8iwbVRx8dDQLTH9waILj2
 YA8pkhaURCtxWSbj9G1Dr3MULw2N6GJwejCh1jd3efeVRcMvKLPYkpOjxiYBdI5CELjo
 Gl4A==
X-Gm-Message-State: AOJu0YyBbG9ena6ADFPSp0aB09Sq9OVJhJxadZaySens2FGE4sRedRjf
 LVNCVRxs5MFWzPqQnG1V5V5ME2wX22hgNnerc2PqrZ0ipwU4k1K7CvS64Bo0CgTIkpdsaiwZmkV
 oOAQe
X-Gm-Gg: AeBDietv+1TMX8rTBTFupEQvrzzlG1wmXN5MfpyiZG5brE7O92OTdyu9BkNKhWUkFn7
 q21CrySBSHw/R94GZk6UbsfUNWKZ6/vskygjAWdbOzb+U0OSW4/HXPhgja+jDE9F795+46gT5RS
 SEgLBkcNit6YejvtPZY9sdWpiKMOJRfl4dRNIUdr/Go9aiHEBCLTbIOhD3tthwcgH+JlIXdoYx3
 Dp/Gv6nNtDLaMlzx0FONILuxdqXpVUp6PHPs8ei55F/sv+7fJ91kUfxkW7IzY7mw7gMXab1mz6k
 kG+vSO0xYwRRTdc7nOhQxdslmhIR4lq2pbTLXa859ZBmPw6gEQ5sv5aYsFnMcY6qOnYLdnvPvyl
 nHyxD3KNT4IgKiOvyqeiEqPv6XxH0Og2hFJS3PdfMyN80O4fGTkUYBtq1V1a4/gANJ3LwrCo37a
 HKtniogP6JXtPJmsa98pRIlykb2vCNI7hMG/8KVzI08VF27Q==
X-Received: by 2002:a05:6820:2016:b0:67e:294b:7246 with SMTP id
 006d021491bc7-69b25b52e23mr285943eaf.14.1778197681265; 
 Thu, 07 May 2026 16:48:01 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:48:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 47/60] target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
Date: Thu,  7 May 2026 18:44:00 -0500
Message-ID: <20260507234413.643512-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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
 target/arm/tcg/translate-sve.c | 3 +++
 target/arm/tcg/sve.decode      | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index aa785fa0c3..e23ca43f55 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8369,3 +8369,6 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
 
 TRANS(FMLAL_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
 TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
+
+TRANS(FMLALL_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
+TRANS(FMLALL_idx_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 71ec09393c..06bbd7fa63 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1868,6 +1868,8 @@ BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 FMLAL_hb        01100100 10 1 rm:5 100 idxn:1 10 rn:5 rd:5 &rxx idxm=0
 
+FMLALL_sb       01100100 00 1 rm:5 10 idxn:2  10 rn:5 rd:5 &rxx idxm=0
+
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
@@ -1887,6 +1889,9 @@ BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 FMLAL_idx_hb    01100100 idxn:1 01 .. rm:3 0101 .. rn:5 rd:5 \
                 &rxx idxm=%index4_19_10
 
+FMLALL_idx_sb   01100100 idxn:2  1 .. rm:3 1100 .. rn:5 rd:5 \
+                &rxx idxm=%index4_19_10
+
 ### SVE2 floating-point dot-product (indexed)
 
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
-- 
2.43.0


