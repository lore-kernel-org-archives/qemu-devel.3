Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7B5C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 12:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx3ZL-00011y-19; Tue, 25 Mar 2025 08:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3ZH-00011d-Bz
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 08:39:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3ZF-0005Kn-Im
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 08:39:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso55151075e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742906380; x=1743511180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gRJU6iWmDstoKX97bKU9+bqCcaUQU0Z5yxalC9Q2S8=;
 b=tuDgkRO+DJx1pkqY925zaOgTCeS25lTLMt7f+aQk64vweQcPNDBodcP1MKeMKi7gy5
 6ERv9CTHsxDAVPAmvb5UlNjyoeeBp8yR97C+dt2DvLr6iZlqAfdjJ4fkZpmzgt8K3x+g
 4ZfQ2qI4d4lJ1E3fXTs5UN2IRfi3PSbOJaFqmEgcYhx6wBJdFC+hOFZ2e39ttULsY8sN
 ui/Fs885L4OeqaUjp0iX/rE6+x8yWl9OkdyHUF5UXmEko+fb24WZYks8mO/BUKFrAZf4
 4gl9l+g8Qt0T2bY+jL7u0a4UmyhtXS67AkjNG/uON5Rv+rrbLcpmu6sKIhFsFCI15MvA
 MNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742906380; x=1743511180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gRJU6iWmDstoKX97bKU9+bqCcaUQU0Z5yxalC9Q2S8=;
 b=awSkHcnhDxndhW+VlOxXGpPccPaP9a83ROcW0qnGbVYklvxnX5TAvWGomg6k20p3vQ
 HGm4Yf4BZAQujBlrBlibXNqjKzVeqTuxnwXKkd0hvJN2bBR9steC93IU+K468gGzPE8g
 n2PbHiRqtBPFDC+UMo10iI1gZeICfkmQ6B4uIR+p0N4i6ywU72kgBlSsn/caRQvP4Wc3
 fztJIKuA4MfnH2zY3BxFFspy7MkuOuOWOs1nRMSlidDj+9gHrjU+lHgwyLKkIZORvzaj
 mzVcWLa252TZzoNyr0umCF07LKchwVb8SLLcjL6vmZuP6B4MQl594QyNRaxE89qUSry+
 NSuA==
X-Gm-Message-State: AOJu0Yx6Iegp33ijOHxPzew/n1TyoOvVqR1KlsHZNXwA/vuXocsZM5Zt
 bulY1AvtLVbpMZxIPWFo51IkclxoAzjLE0jssdQ5Aa1hnYaHj3N+1YbpyqCziA8vDRYP16mIBK7
 v
X-Gm-Gg: ASbGncv6O+4lPChAObkGHn11H26nO7iUxLQX7+fjl7nkKq5ukjTNRkSfycRFP+6H97n
 o+7k1rv+sewtgoPBnkJnt27j3PvQfmjeWAF4+zzHt0uW+BPmEZWw4i2G+rQ7pHmApMT8i/Xpewp
 Sdv6cUakd3YGsYxa/S1FxBWdH6mqXCzvEZn5zSOu6W6y7OEP/e/rc+SqcTj8lt+V7caPItWIKmL
 4B/fb+sQYC5kyHCTDGhH8NONgnNVtNzhjHeNl7YzJsi6A9XgEmeAEpY7a8BRQiKhfUQkIiBfNbq
 jiFhrmdRkyGeJpxcHOE5LWLfKjiHLAXCKxuWMD/0u2KmAMzoB/PTJUmSfkR1VD2cNWsDj9II818
 NiM+VyIPjnvLbjwPsxGw=
X-Google-Smtp-Source: AGHT+IGE1d4CxhXodfStPuh8w87tht6LPRKy1NPET/cdTiVQI8t0+KTpOHgsrupA0NsCdvPHzfmZWA==
X-Received: by 2002:a05:6000:2a88:b0:39a:c9fe:f069 with SMTP id
 ffacd0b85a97d-39ac9fef08dmr1293800f8f.30.1742906379644; 
 Tue, 25 Mar 2025 05:39:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b2654sm13458040f8f.41.2025.03.25.05.39.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 05:39:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 2/4] target/sparc: Restrict SPARC64 specific features
Date: Tue, 25 Mar 2025 13:39:25 +0100
Message-ID: <20250325123927.74939-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325123927.74939-1-philmd@linaro.org>
References: <20250325123927.74939-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Following commit 554abe47c7b ("target/sparc: Partition cpu
features"), avoid compiling SPARC64 specific code on 32-bit
binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu-feature.h.inc | 20 ++++++++++++--------
 target/sparc/translate.c       | 10 ++++++++--
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
index be810052376..7b7b94a0562 100644
--- a/target/sparc/cpu-feature.h.inc
+++ b/target/sparc/cpu-feature.h.inc
@@ -1,12 +1,8 @@
 FEATURE(FLOAT128)
-FEATURE(MUL)
-FEATURE(DIV)
-FEATURE(VIS1)
-FEATURE(VIS2)
-FEATURE(FSMULD)
-FEATURE(HYPV)
-FEATURE(CMT)
-FEATURE(GL)
+FEATURE(MUL)            /* Mandatory in v9 */
+FEATURE(DIV)            /* Mandatory in v9 */
+FEATURE(FSMULD)         /* Mandatory in v9 */
+
 FEATURE(TA0_SHUTDOWN) /* Shutdown on "ta 0x0" */
 FEATURE(ASR17)
 FEATURE(CACHE_CTRL)
@@ -16,3 +12,11 @@ FEATURE(FMAF)
 FEATURE(VIS3)
 FEATURE(IMA)
 FEATURE(VIS4)
+
+#ifdef TARGET_SPARC64
+FEATURE(HYPV)
+FEATURE(CMT)
+FEATURE(GL)
+FEATURE(VIS1)
+FEATURE(VIS2)
+#endif
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bfe63649db2..53b145848b9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1850,10 +1850,12 @@ static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
         if (TARGET_LONG_BITS == 32) {
             gen_exception(dc, TT_ILL_INSN);
             break;
+#ifdef TARGET_SPARC64
         } else if (!(dc->def->features & CPU_FEATURE_HYPV)) {
             /* Pre OpenSPARC CPUs don't have these */
             gen_exception(dc, TT_ILL_INSN);
             break;
+#endif
         }
         /* In OpenSPARC T1+ CPUs TWINX ASIs in store are ST_BLKINIT_ ASIs */
         /* fall through */
@@ -2750,12 +2752,16 @@ static bool trans_SETHI(DisasContext *dc, arg_SETHI *a)
 static bool do_tcc(DisasContext *dc, int cond, int cc,
                    int rs1, bool imm, int rs2_or_imm)
 {
-    int mask = ((dc->def->features & CPU_FEATURE_HYPV) && supervisor(dc)
-                ? UA2005_HTRAP_MASK : V8_TRAP_MASK);
+    int mask = 0;
     DisasCompare cmp;
     TCGLabel *lab;
     TCGv_i32 trap;
 
+#ifdef TARGET_SPARC64
+    mask = ((dc->def->features & CPU_FEATURE_HYPV) && supervisor(dc))
+           ? UA2005_HTRAP_MASK : V8_TRAP_MASK;
+#endif
+
     /* Trap never.  */
     if (cond == 0) {
         return advance_pc(dc);
-- 
2.47.1


