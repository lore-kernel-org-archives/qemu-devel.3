Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808A4D185F6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdq2K-0000bJ-5y; Thu, 08 Jan 2026 08:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2I-0000Zm-6f
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:46 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2G-0003Ur-O7
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:45 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so870842b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767878803; x=1768483603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlp0cLmJus0NWdWxkzfURjwPNijmFYD3iP511oRuVM4=;
 b=e2tnKVFTQvDnlDOVkxaFLXq+cRBmb+PCMpefQjNcXHIXHRz8rLTf41H3rr+EgzVr4w
 zewb1CGk8BOYCoRJz0YwAI7UIOze6f8wtKbOppHQbhPMrs60tSK0Hx7uJ0v0AlL0ACZ0
 CLI2lRUY3SJibDC93V7s6e4M7FXfrkfPchqlD9s9AOallhpn5m/Qx9Vb3u1syEd7Xo3g
 2EbQley9TmT4YZ6XUwQmVyXFdy5baK8cf8SKORKhV4/Ba+17OzdRsQlc/+1tGvKHEW7L
 QOrdiXG8+PQpWS2u0dnR0I95pGSqAIG8LBtUHVfRFIyBrV0hyhzhvRr2jFk+o4tC2998
 mY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767878803; x=1768483603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hlp0cLmJus0NWdWxkzfURjwPNijmFYD3iP511oRuVM4=;
 b=Z1pZqKgyl48MO7aTowtcJehCJ7H8Uli00bVf7ZZ07h1NQ0NBmKQalj5ytxhhk+Qmvw
 1JKXqeml8Cd6j8/Jy5/25xUk/8d/ND7uXrtedQpdCuOZ6dLCvUr//MDN2TQABBD+JdXb
 EIb0Kudw4bqeidf8RlwL9W1beRqlmFBwdOoQorNqtyI4e5mcfm2qLwzhxXwBJD/u7kiZ
 2u8swaZFV4tWQ+9EUcvrMKXPyT4vPXpD+8PKP6ROgBnmH4eoD+pH3BUNdkY24kXFuD2k
 eo0oYQkw4O3GAtaHmTeLeWwTKlMSi1sGpYyqo+t7wzdvfoFmxBB9DwIl2n+Ft3eWx2/V
 ZscA==
X-Gm-Message-State: AOJu0Yx/+2YFjwt6Tmr4s3Okj2PB1IHddh7nqlNlQRKD11KpYZHZ6miw
 fvxUJMqAEZLWEr5V2OPdCySdQ2S/04xKHvLzUX1HIufV91xvduoEwAjJw9kvZ3dNpsjAL//BjqH
 I8k9W+1NEekfmoWPH5pJDeIbNb+zmOfctkEdcjE1YNfpjhhJmz1qOX95iqg7l6uzHj5IWAuokuQ
 ceVV4hHraLzU0mJSnvHi+WDFDZrYIDRZa5wn0mtkQ=
X-Gm-Gg: AY/fxX4aFm1NZ/jvFQeybnD9m/ig6fVPE/B1b8VRn2txrflfCtM0d4/4DP9ZdONPZDy
 0G0RA12zhIrx34fBvDG4SLYVxLVDeEQiACMUSFtJJ7YbgmCkxm+ZjjDytt2ShiReyGpG2NglRFo
 br0svMV7Rdv+8vlI5/moPCD/PNrkzJdyuoDk1u9A2wbcgRAc0vlgcIzEYNgRVjqdVyBZRhEaoHt
 F78VzTnoj5S7VuUEx70SPQ5pNkgpO8EDkpWvUodC5z5K1JaITDcHq+OA5ijmwnRKqxKsVErOW8b
 KfLHCQnUCJImJ7ECDovFMMccZHhqZYZCCsXOYZdtXct+NXWveJVbbKZRtRlrOiiaFpVrWm7PoZX
 XkDsvYYcsvvm0k3MNkVwxBaZwMX5l9h3lbL7LPYdK+cs2Suw4XSMD9Qk9eT19Jcu99OE2x7T8Hb
 UANU5sdqpRM4AssHB+Lg+Rn0OIa45NWOjL8erVVj+6iHyvfoZ+5pWErBc=
X-Google-Smtp-Source: AGHT+IE+Ot3AaOtkTJWmqHHDqqs/vL5fKGaG3WCP6T/jl3AuljdcDEdc5KkF+uueJlX5EJ7VT/BgIA==
X-Received: by 2002:a05:6a21:6da7:b0:360:b941:9907 with SMTP id
 adf61e73a8af0-3898f91b4b5mr6050725637.24.1767878802982; 
 Thu, 08 Jan 2026 05:26:42 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6ae3f033sm2298787a91.0.2026.01.08.05.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:26:42 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 2/9] target/riscv: Add the Zvfbfa extension implied rule
Date: Thu,  8 Jan 2026 21:26:23 +0800
Message-ID: <20260108132631.9429-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108132631.9429-1-max.chou@sifive.com>
References: <20260108132631.9429-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d8e2a7ced5..b3caf26704 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2617,6 +2617,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfbfa),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zfbfmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2630,8 +2639,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
     &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
-    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
-    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
+    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
+    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
-- 
2.43.7


