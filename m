Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43883CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShGW-0005b7-SF; Thu, 28 May 2026 16:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGT-0005XS-MV
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGR-0004Vy-Cb
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so139467055e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999813; x=1780604613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HJrNam3Y5de45XIC9dG9pRaNQGigQ01OEJLLnttfn6c=;
 b=ZT+3lmRSI8B7ioWcoIg83MsWj13C8PtUP0d7nPHcOQHaWrITafKQMth1mn/2kI8ncJ
 52ZgZTWSWFUl7R8y7ushPR04ndLvWc0qIg5yJ9nnRxhb3ZI5zoUkyp16IXZCAROSMx0H
 RSDMIjJ9U7YHnF69nRY49/H7SRBX+8YkT5I4nvRRoIZ7iKGd+qQa1q3R70Xvhz+6J//Y
 lNrQj4MUnZ3nVenwW3yEGoKOc2TphXOxInSuSNS9LBkEOk5m8x0BR+Fl0C0aihrLmcqL
 Kbw1+pxXjgM/0d4mC6Mb04zRJxvzFZHXjhda6lAwJyGC5ShEpo6v4AuEV4ZPV+s5uZE8
 noEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999813; x=1780604613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HJrNam3Y5de45XIC9dG9pRaNQGigQ01OEJLLnttfn6c=;
 b=aantt+S3dhAI2mqqMSPNXozfrBgYzLF9lgeeqyDechLul9AZkepxzwMELBdtc1XvS9
 cw8a5N9ZhP+i0rccL1xysqtAKd8cR0PBkrOd9tBiaK1yAYUy3Bvm3iLNmA/1rPLFZjFq
 ckSzGlBrKr8SOOpl9GGo3RzpsBDUInTSaiUqD1vgSlr2/kE978WW7fFjVzdPdIZDliH3
 sOQg5N3M/QcKrGNokSS7sdNibvoNeaZlc+AHdsqF5Nn1uLowWB9K9mXkZr0/yISMgTfU
 8W4hTGJTWr1SAKf5jku5HmDzk9XCjQsZaeL9O+Xk3CdehvN9beYyR1yahBWJebPtXoGj
 0sZQ==
X-Gm-Message-State: AOJu0YwL55kElsYQXlevqaTa281kNHjPhaHVhjtcHwsIhK3wptpA1fba
 Jp+onyamUwNnirlEgT3p5TrgEfoueuEonGsgkdqiZdtBX5egrYBZecm3CJJJg3Xuba7vqnR/sn+
 89HZaG1Z84w==
X-Gm-Gg: Acq92OHS2N8GEFuAUNGcMg+DIeJC1xAzAB3xuvG1+tn0NqFw/HH8fWbMuK1/gwqpC6A
 qgWwsDJNzRFW2+vY91eEoqR7gtQy1xEaxdEaycJpw8jVdEdFRYtVZVOlALYWLaRpuT7GQIKk0PS
 nLBpE99oRG5kQyK78RBXKiKIF2wTfv6ELI3heUjGv3LWMZ2kYw3VU3QaMlbKk6luh5AvlysWdaz
 fm6XoPGpJmOM/E7RC8dR2Ja6F0ngPHxguacG/O5qw9XbLtgLX4rmmqDSfllxHTyM182pkUkABpa
 7QDDlFPL3/ZwQz0iYq5kdILGLpufP/8kXa7NbFAn6H9l1v2NrZYGrqpKo4uUEg8K0xvbbcbG+LZ
 +rW0qVBBkgs9JIe1GeaIVPIBHNVrprHe2anGEHTlC/sqDid01v5ffQOW/bKr1uJVupAOMucMjky
 DpyVupYU0pBGCPEpJLM0i6dpJWaJW1iIlPCpax4e747A4lCobJ1PR2FJvIdWhRhh/mHocrbms51
 TVp
X-Received: by 2002:a05:600c:4595:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-4909c0a4c85mr399785e9.10.1779999812788; 
 Thu, 28 May 2026 13:23:32 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909264a4a8sm59692905e9.4.2026.05.28.13.23.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:23:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/22] docs/devel/tcg-ops: List more vector opcodes
Date: Thu, 28 May 2026 22:22:35 +0200
Message-ID: <20260528202253.49122-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Few logical and arithmetic vector opcodes are missing, list them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20260504125032.35465-3-philmd@linaro.org>
---
 docs/devel/tcg-ops.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index c417ebe65a8..56c0b0bd3de 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -816,10 +816,16 @@ specifies the length of the element (if applicable) in log2 8-bit units.
 
    * - and_vec *v0*, *v1*, *v2*
 
+       nand_vec *v0*, *v1*, *v2*
+
        or_vec *v0*, *v1*, *v2*
 
+       nor_vec *v0*, *v1*, *v2*
+
        xor_vec *v0*, *v1*, *v2*
 
+       eqv_vec *v0*, *v1*, *v2*
+
        andc_vec *v0*, *v1*, *v2*
 
        orc_vec *v0*, *v1*, *v2*
@@ -852,6 +858,8 @@ specifies the length of the element (if applicable) in log2 8-bit units.
 
        sars_vec *v0*, *v1*, *s2*
 
+       rotls_vec *v0*, *v1*, *s2*
+
      - | Similarly for logical and arithmetic right shift, and left rotate.
 
    * - shlv_vec *v0*, *v1*, *v2*
-- 
2.53.0


