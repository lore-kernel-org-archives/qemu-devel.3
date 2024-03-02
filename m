Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73840C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjx-0002x5-1t; Sat, 02 Mar 2024 00:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjv-0002rz-NR
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:51 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHju-0007aA-1d
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:51 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-299354e5f01so3095172a91.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356607; x=1709961407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0v55yt+Y5Qgy/d3Wvq5QB26rXcnuWZXIdsB8/jEczw=;
 b=iypoZYdkjLzcPG6GVUbvuzFX9Au5RvcBuK4nNclNc5jheygsCScL1OXTQNdCv84XDc
 72xclDgJI15VJ2Qqif7QvKAcZpbs+78N+qMJdps88iaoq2RueSIQRaT+dEn/0+5la03G
 UhfyPr2mirr3TUl9TiMRgr0IxMmjLfqvBNm/XaD4dDkVdENehYNBcBLeyK78GBTukcVh
 hagDWxdlu+bu95FNtt3dDOw0Dq6eYEOTgqpfN7Z96gcSvQDlTUzgl0ch8slhfiIbOolw
 UvVtkKecNS99oLNCWYQ6eX2f2T8+qS3tBfe9nXj+ySpfL2xvu1iAZZDbb/qyEK2rWjpg
 Ymgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356607; x=1709961407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d0v55yt+Y5Qgy/d3Wvq5QB26rXcnuWZXIdsB8/jEczw=;
 b=VpMh/zLfnKfjNKYYtMcNIyZRkPwk/oQGT1Jd03nSnXv6LC34a7mM0hmxN/h+goTHDP
 dOv+DHNraE8ekTMGvsZHDKeoZizMYW3HX0zaJB2AtafmrZMVARWgpjoOff9cNlNPy0lR
 7/ODXyEpUTo8Q4IIq4TyX3ROnzDcErvR6CgHrZO2IJp1B2hZMwntXo34/W3Rx7o5zRmP
 eI0TqZXKVbK8CTYp3CqMZ+sIPGiIvcbfY4ankJdr4Pq4cVyg78SlbgEbf9woDPq1tYhD
 OT7OWkKUZ2h5THZ0CDgLflmjhYeCFJEmIGGr0qEgLwx0oJgROizvBJBMcpCdpAM9c0gi
 MIvw==
X-Gm-Message-State: AOJu0YzxHQ4E1oEuA8JYCKEdpKY918BFmm9t1mUt3h9TzYh4TfI0sa4n
 /wEoVfsJr/j8WMX/7Vp/bW1PskeucjxHWyV5/8SdxZPHcZzyEhLNuKyS+mzjwjze2aoN3WxRzzW
 z
X-Google-Smtp-Source: AGHT+IGp9nrVOmMlIrOGQe/kWuSLY/934hYmr1ZmoB+HaDDNwjKEsLoS66r4eJ6GpjagQhqHrGVezA==
X-Received: by 2002:a17:90a:c08c:b0:29b:25ba:2586 with SMTP id
 o12-20020a17090ac08c00b0029b25ba2586mr4995669pjs.15.1709356607690; 
 Fri, 01 Mar 2024 21:16:47 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 26/41] target/sparc: Implement LZCNT
Date: Fri,  1 Mar 2024 19:15:46 -1000
Message-Id: <20240302051601.53649-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 18 ++++++++++++++++++
 target/sparc/insns.decode |  1 +
 2 files changed, 19 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c26fd04598..761ae204b9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -667,6 +667,11 @@ static void gen_op_popc(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_ctpop_tl(dst, src2);
 }
 
+static void gen_op_lzcnt(TCGv dst, TCGv src)
+{
+    tcg_gen_clzi_tl(dst, src, TARGET_LONG_BITS);
+}
+
 #ifndef TARGET_SPARC64
 static void gen_helper_array8(TCGv dst, TCGv src1, TCGv src2)
 {
@@ -3869,6 +3874,19 @@ TRANS(EDGE16LN, VIS2, gen_edge, a, 16, 0, 1)
 TRANS(EDGE32N, VIS2, gen_edge, a, 32, 0, 0)
 TRANS(EDGE32LN, VIS2, gen_edge, a, 32, 0, 1)
 
+static bool do_rr(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv, TCGv))
+{
+    TCGv dst = gen_dest_gpr(dc, a->rd);
+    TCGv src = gen_load_gpr(dc, a->rs);
+
+    func(dst, src);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(LZCNT, VIS3, do_rr, a, gen_op_lzcnt)
+
 static bool do_rrr(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv, TCGv, TCGv))
 {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 353d26b9e6..f7f532002a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -389,6 +389,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
 
     ADDXC       10 ..... 110110 ..... 0 0001 0001 .....    @r_r_r
     ADDXCcc     10 ..... 110110 ..... 0 0001 0011 .....    @r_r_r
+    LZCNT       10 ..... 110110 00000 0 0001 0111 .....    @r_r2
 
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
-- 
2.34.1


