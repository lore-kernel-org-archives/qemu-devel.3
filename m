Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4BBE9A03E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSX1-0002Yw-Th; Tue, 17 Feb 2026 16:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSX0-0002U5-U2
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:22:54 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSWz-0002HZ-GX
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:22:54 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-46392972257so3050760b6e.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771363372; x=1771968172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roZH7wWMiHXqJhkkLgzH66/YK99zxeBEoHW/TKhv7pA=;
 b=dXccdL3i/mmnRxZFBCyGUlJa7IUEhqSadntcmqvSJtAgumFBgyOLLxc6RE7xjF64Sz
 9g2q8o+H0H3lp1owK/+PD5mQKn31Lt/+IQH+dUdhswdfKz7T85azoRuOHXtNajZhM1nm
 MEk/CBy5vaOfAa4yzlHOTBuCxwIoD0nPeckGxAVSgZF4j+aEs8MNMeg8uaNMKzwkJqgK
 +vWyuLDm70Yxp8hs77fyYCkFGlB6hQKmjAgdkWr2b6+H6ya+MU9yyC4kGUxN1E9CQUt7
 +n38+Z13Npbyw/5b2BX/Np/OEFnRGBxAWRLahMa7DMniwDrVz9wSAQDYcoG4cpOMERpH
 D6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771363372; x=1771968172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=roZH7wWMiHXqJhkkLgzH66/YK99zxeBEoHW/TKhv7pA=;
 b=rth1pm529j2kXgtGfgs6zKxtquor4UwA4cu6pwrUqVmOXCJje7iLDjG68MDDfCBP55
 sbq53L4H/uaAEYK+KRMx6DC1iOlAhr+hCBbNeLUOePee9xoAH5JaS/A6HPqB8gDc+qYI
 mQ0HE4Hej32Y962FjRVxXqdzgzPh6UIlO4qLYYvjZHSe4u2e3hPDJHtzQCos2LvOjmoy
 pJXEA16mxLLcFmK3xDz1PtmQ7dZri6+/z1dkU3GBNo04FJNR+N1fu5L3+9auxbAdf0TX
 CbFf8HdJnFtMdXc0mcULbQOQxKcMkW7/CLdWs4+6ss7WouTu0lFnVsHs+yFZG+Y2E6l4
 BSUA==
X-Gm-Message-State: AOJu0Yy6y7NFDjRz+HKMTojD2TBzdkdBJOB23rU+cA4XvZ+caYFSvmak
 3GpGP2hahLs7voHNhXSyweKh8ZP9FnqnHSBoUtjWao8+M5m+tEZlglaP3QcTuQ==
X-Gm-Gg: AZuq6aLYsMV9Qd8z1KeJ+TkoI01BSuPtGwDYlrkpSEOBkD9kRib2zC8603PkGXxsRW1
 BhB9G7Ec+8RmRSiXv8TxCtsXWTYvdbMRON/YhZ1fdwYKtIC8i1DLddJ8R/3z2PciDm1XKmm00zd
 xVMEjZoeSsiywVGZFCZ++t7WKRL83zqvHM8HkGR/bPXA6HuUksqQEkJGFN8L/vLd68RqqUeg9RJ
 BKzT1VA9A4LeHayvRAJ2aL6TmRfSjDDkzHnIH4Zp2HKjHKEC88RdA6tXbdZV7FrmA43BczNIrCb
 CvmTuemTmfy2mF+6HHo8SnH4NMRP/8aIoqOQiSw7x9RD15dWZ9JUG+zgZklvOHfJgT+9eT8PcTy
 FnwcXbNJwNHDmv52qcRAsKNBzZr8Kp8jf/4oAGEbJ/RgVup9zUw1DC5/Gm1wFzLbiZXACzTHpQb
 rrkPfpNKC1UePTfBlA1nGjoHnjfqPor2qHKpibAVPi4oulo4zJNsk+pCNpI5lrgqSllD7XUOjYR
 s6KOIVzqQD9+46m
X-Received: by 2002:a05:6808:1689:b0:463:927c:1e3d with SMTP id
 5614622812f47-4639ef4ab7bmr8885434b6e.23.1771363371882; 
 Tue, 17 Feb 2026 13:22:51 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm12899319b6e.3.2026.02.17.13.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 13:22:51 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v3 3/8] Hexagon (target/hexagon) Add Hexagon definition field
 to DisasContext
Date: Tue, 17 Feb 2026 14:22:40 -0700
Message-ID: <20260217212245.95321-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
References: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22e.google.com
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

Initialize the field in hexagon_tr_init_disas_context

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h | 1 +
 target/hexagon/translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index b37cb49238..9cdcbd6416 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -30,6 +30,7 @@ typedef struct DisasContext {
     DisasContextBase base;
     Packet *pkt;
     Insn *insn;
+    const HexagonCPUDef *hex_def;
     uint32_t next_PC;
     uint32_t mem_idx;
     uint32_t num_packets;
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 2fdc956bf9..a4c2ef534e 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -988,6 +988,7 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->branch_cond = TCG_COND_NEVER;
     ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
     ctx->short_circuit = hex_cpu->short_circuit;
+    ctx->hex_def = HEXAGON_CPU_GET_CLASS(hex_cpu)->hex_def;
 }
 
 static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)
-- 
2.43.0


