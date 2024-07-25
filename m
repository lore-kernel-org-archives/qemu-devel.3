Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19872C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8LF-0003Jq-1G; Thu, 25 Jul 2024 19:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8LD-0002xy-1U; Thu, 25 Jul 2024 19:57:47 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8LB-0001S5-88; Thu, 25 Jul 2024 19:57:46 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2cd48ad7f0dso329063a91.0; 
 Thu, 25 Jul 2024 16:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951863; x=1722556663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjpoVU0ZZXX9XSnoeLPS/eSXr8D5zUBAP6EernATugw=;
 b=L0yDPrqHagvHMhEHzRVvOejUX6TdrpHR27D/exIw3Jt171B2v9iyAMZAcP74r/YdmT
 hLi2wuVNjNblvxawdpJp3LuoTRpSn6yGGAi4ZVciHesUBbqM/AOHvrFmZpZ8uDlf/+C6
 J+tgSIMhE047QzfJs6JW/BEWHCWGUj2UJ8qg77Kz4A4tcNCdVmRUVc9wlhbAU3HT7vSp
 AlE5CgVB+13ATgVUP7l4StATvBytV+h9JNSrUj3LfWduCT9ZWr3DXcQOQFCQpimnsHWQ
 LuRCvggHGYfPpQKFRdRzRdjrnmNmFea+QlFuwaIZ4a6/OQB6vlJxsbhb5SJgQYfbzE7t
 Yd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951863; x=1722556663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gjpoVU0ZZXX9XSnoeLPS/eSXr8D5zUBAP6EernATugw=;
 b=P3ythVuDig3Gu8Hazs8fPAnrRjP7mB/kUbCWq9aCnJdnKFHW4wc+udhxtmRZJoeP2J
 EU6jwxvhgJBNE0rfeFJX5ESl+Nugkc1xcV/vQywPb+u6BjR1ir4RtML+p9XFdLMsozBn
 yjjx8x+0W24ECmiqqSSmSRT8kg2MpoykC1s36+l/z4gPWG3T3AFkdsuWPf5ro2WsPYh+
 +OIAjZqFjtes87RPdYGpL9KZTtbJIj28V/oyq04U8W0jx9xXJvl7gvCYYd2KFdWw5wMK
 RtpiMiKrlcFxl10pmuXBrZrLnuKnlotPcSmSV8+v+8xBp4CNDPvd9ZiW2XTUKZcMo4bA
 MG+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSWIM48B5Q/E6+WH8Njb/LkByI851hr/iclCpVPUyqN2jOYSpZ2iCDuAT7nDaHlT6SLPS9BZBuTs44L8oPurqMKzdd
X-Gm-Message-State: AOJu0Yy/rDFM8OSrDdBsf1vsDMNVswGSiS6IVCgIKNWZP4/U0Jpi2tse
 D5KYjfN8uNFHz71utAW91K7PjvHUHiyeDkv1Ms1WHdJy0i2r0GBiSB+71A==
X-Google-Smtp-Source: AGHT+IFKXMpvjwVzC6I9wsBl/laqdbj8uNtIwEY7EmmRgudSrWOwwuJMJi4r2nec036ViYURaHDN4w==
X-Received: by 2002:a17:90b:1c05:b0:2c8:716f:b46e with SMTP id
 98e67ed59e1d1-2cf2e9f6d0cmr3877726a91.16.1721951863248; 
 Thu, 25 Jul 2024 16:57:43 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 55/96] target/ppc: Move ISA300 flag check out of do_helper_XX3.
Date: Fri, 26 Jul 2024 09:53:28 +1000
Message-ID: <20240725235410.451624-56-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Moving PPC2_ISA300 flag check out of do_helper_XX3 method in vmx-impl.c.inc
so that the helper can be used with other instructions as well.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate/vsx-impl.c.inc | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 0266f09119..6025119e5b 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -2712,8 +2712,6 @@ static bool do_helper_XX3(DisasContext *ctx, arg_XX3 *a,
     void (*helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr))
 {
     TCGv_ptr xt, xa, xb;
-
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_VSX(ctx);
 
     xt = gen_vsr_ptr(a->xt);
@@ -2724,13 +2722,13 @@ static bool do_helper_XX3(DisasContext *ctx, arg_XX3 *a,
     return true;
 }
 
-TRANS(XSCMPEQDP, do_helper_XX3, gen_helper_XSCMPEQDP)
-TRANS(XSCMPGEDP, do_helper_XX3, gen_helper_XSCMPGEDP)
-TRANS(XSCMPGTDP, do_helper_XX3, gen_helper_XSCMPGTDP)
-TRANS(XSMAXCDP, do_helper_XX3, gen_helper_XSMAXCDP)
-TRANS(XSMINCDP, do_helper_XX3, gen_helper_XSMINCDP)
-TRANS(XSMAXJDP, do_helper_XX3, gen_helper_XSMAXJDP)
-TRANS(XSMINJDP, do_helper_XX3, gen_helper_XSMINJDP)
+TRANS_FLAGS2(ISA300, XSCMPEQDP, do_helper_XX3, gen_helper_XSCMPEQDP)
+TRANS_FLAGS2(ISA300, XSCMPGEDP, do_helper_XX3, gen_helper_XSCMPGEDP)
+TRANS_FLAGS2(ISA300, XSCMPGTDP, do_helper_XX3, gen_helper_XSCMPGTDP)
+TRANS_FLAGS2(ISA300, XSMAXCDP, do_helper_XX3, gen_helper_XSMAXCDP)
+TRANS_FLAGS2(ISA300, XSMINCDP, do_helper_XX3, gen_helper_XSMINCDP)
+TRANS_FLAGS2(ISA300, XSMAXJDP, do_helper_XX3, gen_helper_XSMAXJDP)
+TRANS_FLAGS2(ISA300, XSMINJDP, do_helper_XX3, gen_helper_XSMINJDP)
 
 static bool do_helper_X(arg_X *a,
     void (*helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr))
-- 
2.45.2


