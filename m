Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F5AC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJmS-00013l-1o; Sun, 26 May 2024 15:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJmD-0000R5-8F
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:29 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm8-0007m2-Sb
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:27 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-681a48efe77so2014809a12.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752603; x=1717357403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADgeOSedbVT4WLVTe/jbh46tCWtzpdfEWbBUSGOZW6w=;
 b=Hcd7RTn8+u0qBkXVlBs+cvyUwlug9Acb4wD7dcWVk4NldZDHAqaF/gYAplX+ed7XbP
 /pU5Y0SvsdRq64BIuTRFLChXPaTQmoTv+3sxH73Xvw6KmkgjnhT69dfLEd+/b9m5TZC+
 AcKsKWZdSNcLnVmLSlQeB9wUYVXU2/Mkw3iHT/Icdsw+Q5Fleoiwc8/5e/fGO+EZKSH+
 gXqhA7b24ASNgvAo7bGYKkwWM3kQV0i5bgofaqtnx4Ws0va7jUq/ZgpXJDElgb6JLft5
 LHt4qTQKfpEfiPtk3lfR0G9ee+jYmbxEJxGa7VHhWu477wvSPI0QCoevl58WgEq5fLld
 bMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752603; x=1717357403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ADgeOSedbVT4WLVTe/jbh46tCWtzpdfEWbBUSGOZW6w=;
 b=D51zGNsqhm48HBdEX2yYpdMr7y7TUR3R58zaJ9hLJcKK68oVW1E0nffQvVHFU34Dyx
 zm2GDBo0V/2DNM1CHbz7gLtr8TH3cblecC05iNS0DA6gTRXzG2yL9dSjWeH3nBEwsWsA
 b/xQPyBDfD/my4SHfTIzdS4f0HZ3dWRrxvX6FOSoD3Bsk7NUjmZcGkd8t/2WSek2uukR
 BcvLaDvMPjcATRwrf7UHFTfSFrSWs7YxCfgq7vXApp9K9bcpR2gTCTZpZjNt8N0QqCrl
 P4VwDczQYzwjbKzvGvg8h5wA73k0iQSi2ePof/Ls/hZVgGBgmwHy0gLw2603q3F68jLs
 o/3w==
X-Gm-Message-State: AOJu0Yw3c0h7WlOt2G0pNY3+mTFWX+dKYq+hNYkodaUpaKQgoWtnNHWg
 +HIixr2QrhAbOv9innOwuitI/y7opJ3qB3C/Wb6mACCYRxG3MrOnnRg57q6YWomlCtxjb2exFnH
 F
X-Google-Smtp-Source: AGHT+IEQA8ob2pI4W58UiHbnukcCbISmhf/nc9KOImNWjNsZBWzHqX57Y/AFnUIlvWe5Urvt4qvxNQ==
X-Received: by 2002:a17:902:e849:b0:1f2:ff65:d2e0 with SMTP id
 d9443c01a7336-1f449026bdamr99291885ad.42.1716752602963; 
 Sun, 26 May 2024 12:43:22 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 35/37] target/sparc: Implement MWAIT
Date: Sun, 26 May 2024 12:42:52 -0700
Message-Id: <20240526194254.459395-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a7720560f8..fbcb4f7aef 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -124,6 +124,7 @@ CALL    01 i:s30
     WRTICK_CMPR     10 10111 110000 ..... . .............  @n_r_ri
     WRSTICK         10 11000 110000 ..... . .............  @n_r_ri
     WRSTICK_CMPR    10 11001 110000 ..... . .............  @n_r_ri
+    WRMWAIT         10 11100 110000 ..... . .............  @n_r_ri
   ]
   # Before v8, rs1==0 was WRY, and the rest executed as nop.
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index e3e92bcf83..dba0eaa30c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3344,6 +3344,17 @@ static void do_wrpowerdown(DisasContext *dc, TCGv src)
 
 TRANS(WRPOWERDOWN, POWERDOWN, do_wr_special, a, supervisor(dc), do_wrpowerdown)
 
+static void do_wrmwait(DisasContext *dc, TCGv src)
+{
+    /*
+     * TODO: This is a stub version of mwait, which merely recognizes
+     * interrupts immediately and does not wait.
+     */
+    dc->base.is_jmp = DISAS_EXIT;
+}
+
+TRANS(WRMWAIT, VIS4, do_wr_special, a, true, do_wrmwait)
+
 static void do_wrpsr(DisasContext *dc, TCGv src)
 {
     gen_helper_wrpsr(tcg_env, src);
-- 
2.34.1


