Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8104C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAfo-00070Y-9E; Mon, 29 Jun 2026 08:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfa-0006tJ-PA
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:03 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfV-0007NI-7g
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:56 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4745492ed3aso410523f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734450; x=1783339250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9DBBXZ6/da7INOl9cTlESZkgra1ZBKms/6DduvGkI/E=;
 b=Fk89nO6mbfwDuZIm2aTiEDCdwYiDUr8JSLZ/oBjgiWN2yZ1TjNiwy99UiA7JJAuomd
 1QYUrG79owq0gvEEwEjezVcL+cv6mumIXVSaDIcGmA2/HKErX1bVU8oCOgtiEh96uTuB
 qSGw1SjVx9+3urd0pKbfBUFUj1H2C1PiBjkTbg23CYIr88S6/IXg/SJpAkgs2rzqzQtD
 vAUbqxoe1JA8zGgS0kF8pjgvMmFtF4IcXqxI1Zn5EyrivnAaM4MzGgKN316HUOhOb6M3
 RefPP1X0Y7LIo4mANjBBKis8cC6VFM133Ip2l71lSFpfDoycj04AnDSGdFIXE1+rerPj
 0QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734450; x=1783339250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9DBBXZ6/da7INOl9cTlESZkgra1ZBKms/6DduvGkI/E=;
 b=ndqmauNA8JAiRZ2lagJXZwbxQVnku2iElbwWwSq+s7CMQDkgBqNTXJuL1OFwMxZbBb
 Pm9fJ20lL+c4l6bgbv3RiD6FA2uHBdWno9HQPASWXmk4oZnyWsGheyBvM7Slb73Snos7
 7VK5r9m9DLqfAe6x6QEooTj1izC+VtUXgQkRmxL0SGEZB52/GtWLZKOEFfP4UortdAX5
 1w2rA3uJLhhtzR8PMEB3CEwdEgfqQ8D9XL2P4QpO5wp1Z2gyuSmCfDBIPxgYNB3+rrWW
 tyhG7mXkfSNHdIsto9X2NVe8UX0dguRYftaseWKg+dfxwgNi65y84OMc3IRssY838/b+
 e40Q==
X-Gm-Message-State: AOJu0YwjXdLUP0SgYcA8fuk5i1CrdSF2iHzyZKNXb0ECEmnV8478pva9
 sFFm/p1XFiHK3hPW0wvW8bbfiC+ATABbQVQzmFTqAocqrQUitEYcRuAjOt5J4AMmFfda79dTat7
 +sWqU
X-Gm-Gg: AfdE7cnBpIeP4PqE3MUjxPs9g0XJrh2CQsRsACgbW3OBWCZ2DK4zlfWVMVGsasFy7G8
 zVlwvMjvyxcvioawc+Kc7f5b6mkY/kJQGoamgmgOoS5lTe0mGOaD415WJaKQ9MgwcTGpljx19qg
 o1X3QkkpglM6ROGXdTcUtCjVIb2dUcfff/zknmBhqEiIvcQ6rwegTn1R24f8pH5rB+u5G65yVVn
 MFTM0f1Y3TvP6OFkyvQzFYgbDY8ydzsEL2uNgSi+oFyURbdPmIz/RDiCD+ctP0jO6DIxqPq3Irk
 +KG3EoMfUhFRGB8KoyEkFPq1g6FYEqTAHMHfQEx1giTG3z31OSvulSExU/rpGuktmhq3c3aeXKA
 NKvixyxclHwZZRuJmdasHrb8LUxUIwO2i+gOXAY2igr0af0AYpfC/VEX9KasX304ju+DnG3R63w
 O2iGYl42gYEd6ZkxjQsXWSi6iWBxLRkdTtxl+S2jFGDeO6ows90DIF5jMi3fA1qh5h3UAeAmybd
 ywONyd3C98Ae4+7/qzGfg==
X-Received: by 2002:a05:6000:29c6:b0:46f:ce0c:f1f3 with SMTP id
 ffacd0b85a97d-46fce0cf2f1mr11076759f8f.6.1782734450211; 
 Mon, 29 Jun 2026 05:00:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/54] target/arm: Implement FDOT (multiple and single vector)
Date: Mon, 29 Jun 2026 12:59:53 +0100
Message-ID: <20260629120032.1645265-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260618041517.573469-7-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 3 +++
 target/arm/tcg/translate-sme.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 80ad674cf2..3c7caf8bdb 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -449,6 +449,9 @@ FMLALL_n1_b     11000001 001 1 .... 0 .. 001 ..... 000 ..   @azz_nx1_o2x4 n=1
 FMLALL_n1_b     11000001 001 0 .... 0 .. 000 ..... 0001 .   @azz_nx1_o1x4 n=2
 FMLALL_n1_b     11000001 001 1 .... 0 .. 000 ..... 0001 .   @azz_nx1_o1x4 n=4
 
+FDOT_n1_sb      11000001 001 0 .... 0 .. 100 ..... 11 ...   @azz_nx1_o3 n=2
+FDOT_n1_sb      11000001 001 1 .... 0 .. 100 ..... 11 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index cc85c6d6e0..8fea451089 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1170,6 +1170,14 @@ static bool do_fdot(DisasContext *s, arg_azz_n *a, bool multi)
 TRANS_FEAT(FDOT_n1, aa64_sme2, do_fdot, a, false)
 TRANS_FEAT(FDOT_nn, aa64_sme2, do_fdot, a, true)
 
+static bool do_fdot_fp8(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp8(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                          0, 0, multi, gen_helper_gvec_fdot_sb);
+}
+
+TRANS_FEAT(FDOT_n1_sb, aa64_sme_f8f32, do_fdot_fp8, a, false)
+
 static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
 {
     return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
-- 
2.43.0


