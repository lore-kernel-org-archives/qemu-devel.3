Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BFFCD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoD-0006km-6Z; Thu, 04 Jun 2026 19:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoA-0006hx-T8
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHo7-0007tr-FN
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:06 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c0c3184c71so10000055ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616942; x=1781221742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00A7hgOZ4BJxydtU0VYApJHMDSvFHd62SnNXpfPSUCw=;
 b=Lx1pWSxjg2UyLhEBVffK6fRHna6jXQw7vuDXe0/PRojZBvdgJJaTZgzU76Pyw5ifYW
 WxXwVJX7aDF/NEfM+afkp2PyhBaTDJEq/im6QnIQ0FTudUGQJZulTi5Q+9MSNKJ6aS0h
 /IRja9SQmKlna0rrVmB+q1uNn8CxmCXUmSg+8ws9Iv4etQK15rPN4F2c4Fo4eqoNFKWu
 woxcRtdyDjNljFF8VuIa6HjaJs3SjfAxlsYKH+l3D+xw8BlDXk3kBTHzZEv0vPRGsRqF
 JG7M6B96bHjpVfQHNXKoLCMXFcPptKxxfdsC6RjENBnJejsuuICBfP+yJNoVSXoUSf7U
 jfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616942; x=1781221742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=00A7hgOZ4BJxydtU0VYApJHMDSvFHd62SnNXpfPSUCw=;
 b=N2rTNGPVsAo3YC42ZJicyODb7iJl2NPqF6MRczWxbsNpB3++ABs4AP21PJ/upzemDX
 68UCblGLD5/7wbomtc4Y5p1fOXYtBhbFPYuNrSgz4aYxWmnw7ueU3bv0b95Dt7otW170
 Oinu9NBXu+y0M3MP261oktHxKAfhZdOBAXEDxM9y+0+2Ad7SHnHFvdWSmg1TzUR389Zr
 xIeEsQxJCenuQVK2YICnkQjSae7v7eACvAD+jxUgj1r7BBaR10SE/0A7KMWu/Mq1dudL
 Mdi73NEaiES9aiYc8R0ADvhhhXparEP4TwCYZyalSDpXxyIryPFScymuW1tZyZXhgB/Y
 HwgQ==
X-Gm-Message-State: AOJu0YyhKr1l1+EC8FNoUCZT8VSXAzIRsfKYGVVPHaODMyqLhiJg1wlc
 SdOi4MqK8WM5AEoeC221t1xx2gyi8KNT64PWbXxmT0axUcezp0falRZ7auZnChOeKoQxChgxf4L
 W30wqWcQ=
X-Gm-Gg: Acq92OEzg4ajPJuRyDbGXI3Lxrft+aqLa+qn1D0WhrNNjunZIj+TLxhbOJ2rj+n0DJN
 n7NqULFsf5SSa2L3hbrwePLHW1N0czoFjcPAB7Qq3AWcVpEZZz37hTFsluV7fsQXXfvJ8BY2Kiq
 7uAn4zYmfWTYQRAGoJzNmZAy1Y/fJ+BGBHLKvsPVroVHYCTBPXOkIyElD0mKz0lIYUzcbMMzK/X
 U32d4Tav1XcMbV8WuSI26LpMb2It+uZsqJATiLmEFx474pmTbBAU+I912ZkHHMJ6aEvIpEaYfkF
 B6EViuiNZh9dRGk/qW8Nwk4JAAcnNNgfTmeojCM3E4LiXCIP//fLKUcr5ENVb28HiFuFCDHmBqs
 qXGthI3co84mXYj2E3zZXzsvhilqJyYq2DZmW5Zqyn25kYrCnGP6pq1qZ8RfomEBVDm3khskaed
 bc6Dw0F8MYcPGyjGI+5FVrpIOUrNASDVt7YTRSKsEzoBUTfrdgQQ==
X-Received: by 2002:a17:902:f64e:b0:2c0:ee6c:c53c with SMTP id
 d9443c01a7336-2c1e7b2f52dmr7355425ad.1.1780616941989; 
 Thu, 04 Jun 2026 16:49:01 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:49:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/25] target/arm: Implement Floating-point round to integral
 value (predicated, zeroing)
Date: Thu,  4 Jun 2026 16:48:38 -0700
Message-ID: <20260604234852.573178-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
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

This is the various FRINT rounding modes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 17 +++++++++++++++++
 target/arm/tcg/sve.decode      |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e9c0a73e90..3b346aed35 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4644,6 +4644,9 @@ static gen_helper_gvec_3_ptr * const frint_fns[] = {
 TRANS_FEAT(FRINTI_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            frint_fns[a->esz], a, 0,
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FRINTI_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           frint_fns[a->esz], a, 1,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     NULL,
@@ -4654,6 +4657,9 @@ static gen_helper_gvec_3_ptr * const frintx_fns[] = {
 TRANS_FEAT(FRINTX_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            frintx_fns[a->esz], a, 0,
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+TRANS_FEAT(FRINTX_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           frintx_fns[a->esz], a, 1,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
                           ARMFPRounding mode, int data,
@@ -4694,6 +4700,17 @@ TRANS_FEAT(FRINTZ_m, aa64_sme_or_sve, do_frint_mode, a,
 TRANS_FEAT(FRINTA_m, aa64_sme_or_sve, do_frint_mode, a,
            FPROUNDING_TIEAWAY, 0, frint_fns[a->esz])
 
+TRANS_FEAT(FRINTN_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_TIEEVEN, 1, frint_fns[a->esz])
+TRANS_FEAT(FRINTP_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_POSINF, 1, frint_fns[a->esz])
+TRANS_FEAT(FRINTM_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_NEGINF, 1, frint_fns[a->esz])
+TRANS_FEAT(FRINTZ_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_ZERO, 1, frint_fns[a->esz])
+TRANS_FEAT(FRINTA_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_TIEAWAY, 1, frint_fns[a->esz])
+
 static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     NULL,                    gen_helper_sve_frecpx_h,
     gen_helper_sve_frecpx_s, gen_helper_sve_frecpx_d,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index f1cf7a628d..099cd4e93d 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1240,6 +1240,14 @@ FRINTA_m        01100101 .. 000 100 101 ... ..... .....         @rd_pg_rn
 FRINTX_m        01100101 .. 000 110 101 ... ..... .....         @rd_pg_rn
 FRINTI_m        01100101 .. 000 111 101 ... ..... .....         @rd_pg_rn
 
+FRINTN_z        01100100 .. 011 000 100 ... ..... .....         @rd_pg_rn
+FRINTP_z        01100100 .. 011 000 101 ... ..... .....         @rd_pg_rn
+FRINTM_z        01100100 .. 011 000 110 ... ..... .....         @rd_pg_rn
+FRINTZ_z        01100100 .. 011 000 111 ... ..... .....         @rd_pg_rn
+FRINTA_z        01100100 .. 011 001 100 ... ..... .....         @rd_pg_rn
+FRINTX_z        01100100 .. 011 001 110 ... ..... .....         @rd_pg_rn
+FRINTI_z        01100100 .. 011 001 111 ... ..... .....         @rd_pg_rn
+
 # SVE floating-point unary operations
 FRECPX_m        01100101 .. 001 100 101 ... ..... .....         @rd_pg_rn
 FSQRT_m         01100101 .. 001 101 101 ... ..... .....         @rd_pg_rn
-- 
2.43.0


