Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7015C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjt-0002Xc-OC; Sat, 02 Mar 2024 00:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjq-0002WP-8f
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:46 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjn-0007Yu-LC
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:45 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso2574438a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356601; x=1709961401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpT0TxxiSn2UFTAP4U5DaTEU/B/NB8CZNMPlZnOT5fM=;
 b=nRokxzDrzONKJcwsQ+BOxQmzshsfmo2gr4JgjrYjRvA6Hn+FdrEUWdkNGLYlL9V5Ni
 Do9nztwkPwsGGoPteJEAtNy4VCsZ/QOwfCG9yCmyfAz5ZcMM8WZC4n+heD1DRqPrCN9N
 KIJWCCezNDoBOWUzjqG1Fl/G5hfAE6QUlJ8d2kRF+TGVcriZTsoOio+/Ilqu9CdqQY4/
 ZrX+rplFuDsVfbQyJN1GHT3GUYuLt7gpyP6975BvQy7T31oE3GuObtjUqr2W2Vy7WTwU
 fFG3EqaK24PJlik+F4ElQtfsNB6ATntwBsce9Q0KPEewLAZERg2fJSaZ5vEUgqQsIuLd
 SMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356601; x=1709961401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FpT0TxxiSn2UFTAP4U5DaTEU/B/NB8CZNMPlZnOT5fM=;
 b=KPGuf3hMTwXe8EhL2kKNHW0cee3KQui7/S+UY3bH8ydGmwQ/okC9qewufmLD6p3pZV
 jVZr5ScqWDA8diwxWVYcqbIEGNmsiPI6VE2RlEtw0oXvA/LQNtmyxUqbttCkZhAAAjQZ
 VYS63Aia9c8NyNv8yjvTfSSiW6YT7ygIwQ0PKYJCEDi+W6s0kVFlclOuRNN2k4Wc72C0
 we6pEPTwUqBot3k8pBPDPjlyL18kzoukx+rSXzC5mAGST6pi2MDMtCtxCYkbFgVqVL6g
 O4UQA+Tn+ACYxYD67pkt99yrGMpjGMvkNYEDFAeA5oZmYofWoRUjxG0eyAiurQBJwX5r
 Pyig==
X-Gm-Message-State: AOJu0Yxfgax7OJkw26lBa3Miiv+IQtPEZOQhZ8hscu1jmIB7NaHzaOIq
 29bYh0FuYql5Ea6CROVfsKGHkkfKUjHgICaMXiZnooL5CxGnwIJfEagH41sJLD/tBTthFYeaAky
 m
X-Google-Smtp-Source: AGHT+IFEWSOTdaE4kw6NhSSejQ+cc78jL2+Si1ol3fl0GCVmiOV/xydL7cMoA2bhS7/4tBudKRWG/A==
X-Received: by 2002:a05:6a20:144b:b0:1a1:476b:8199 with SMTP id
 a11-20020a056a20144b00b001a1476b8199mr645733pzi.26.1709356601174; 
 Fri, 01 Mar 2024 21:16:41 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 21/41] target/sparc: Implement FPADD64 FPSUB64
Date: Fri,  1 Mar 2024 19:15:41 -1000
Message-Id: <20240302051601.53649-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
 target/sparc/translate.c  | 3 +++
 target/sparc/insns.decode | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4876d46ebb..9af30d8fa7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4905,6 +4905,9 @@ TRANS(FHSUBd, VIS3, do_ddd, a, gen_op_fhsubd)
 TRANS(FNHADDd, VIS3, do_ddd, a, gen_op_fnhaddd)
 TRANS(FNADDd, VIS3, do_ddd, a, gen_op_fnaddd)
 
+TRANS(FPADD64, VIS3B, do_ddd, a, tcg_gen_add_i64)
+TRANS(FPSUB64, VIS3B, do_ddd, a, tcg_gen_sub_i64)
+
 static bool do_rdd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv, TCGv_i64, TCGv_i64))
 {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index bc5640aa5f..c9dab4236d 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -441,10 +441,12 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPADD16s    10 ..... 110110 ..... 0 0101 0001 .....    @r_r_r
     FPADD32     10 ..... 110110 ..... 0 0101 0010 .....    @d_d_d
     FPADD32s    10 ..... 110110 ..... 0 0101 0011 .....    @r_r_r
+    FPADD64     10 ..... 110110 ..... 0 0100 0010 .....    @d_d_d
     FPSUB16     10 ..... 110110 ..... 0 0101 0100 .....    @d_d_d
     FPSUB16s    10 ..... 110110 ..... 0 0101 0101 .....    @r_r_r
     FPSUB32     10 ..... 110110 ..... 0 0101 0110 .....    @d_d_d
     FPSUB32s    10 ..... 110110 ..... 0 0101 0111 .....    @r_r_r
+    FPSUB64     10 ..... 110110 ..... 0 0100 0110 .....    @d_d_d
 
     FNORd       10 ..... 110110 ..... 0 0110 0010 .....    @d_d_d
     FNORs       10 ..... 110110 ..... 0 0110 0011 .....    @r_r_r
-- 
2.34.1


