Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336F7E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9dw-0001Mu-7f; Thu, 19 Feb 2026 14:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cS-0004RF-D0
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:24 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cP-0008Rl-3x
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:24 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso10972775e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528998; x=1772133798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bd+JFTRxY93XqgYZ2s6fGqp/CkjcYlTlJqxSz1umUY4=;
 b=F4fyELqzTVWaa2ie4kIWCFEUbgyl7GB48NbzbHi+7hsJHlktxEi+/H8rEkqJHZkbwX
 9riKp2vQQDm4ibTOG8BHSrzcxhzJOGG1lZb6PfpeK1As5nklWK3v7H8R0R+2jvwDGuu8
 5ABIRQZ2hIN9k+vZhSoZJ0ucZHQIQr5w6JBdx3UpJjtBb0u60jjajUMEGFQ+ivxoNr2C
 h+FpzeofT8/B4M0wrHHM2fXp8ZA0MCt32H5oin/6fWG6G91uD2v4Z4WsnIS3WghKnkis
 fSfBcB0/EFUCdwahJessBSP+t89DQtBTB/iP01tFpbhWgrBVxyZlTzCaXOLq+hbXIvGY
 bROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528998; x=1772133798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bd+JFTRxY93XqgYZ2s6fGqp/CkjcYlTlJqxSz1umUY4=;
 b=KnIcersNZj1qpF1IcViwzgc9JlZVpJQzpgy2zkqT4v2XqyuKkCz6gegOInkCd2vrJc
 ADNC8fW4dL7D9ZQECPE2xLj6IilRFqi5B3+VMlRaW5GIaELmNDN1MIEQoXKTuEoBBmPJ
 L2ocxQAdOe+oG3pUkapVNtrTdT7xgV261RXU410xRrL66Wxf6Cu0tqYRYVTjWzMerb4Q
 Tuoegd7TkWpZnoP/2Cbxum2WA4nr6IbUSdONi+mHItMpcGLgX+68mTw1nyX9UPPhKdSj
 KIZ4wCdCIqfzn96OSeekFNG1Ka2A2FWv2ZrC5VTWCP+SgFCfaJugeLuxLaz1DcxDk8Us
 gygg==
X-Gm-Message-State: AOJu0YxbuOmQBQHJVbkkaLIkwzgjRo0CyTRHYebsFcTXGTqoptOIg9IE
 TZ31gtfgl7uApnWADunQovvigINfcIEBLhbwuR2EtzLXFc66neQkIw7fHtEDc/s3I8rN0UmADck
 IffmIzOQN+w==
X-Gm-Gg: AZuq6aIbJlAqN6I99TVU7g419g8eK4O2xb70bThivQ5+PJ8MY401xqp5vQrdNX7ayql
 JSdwJ0NFzWSkSOOqGRGQ32GggUqp8RGYQFLNT6Od8GhYb/BubF/OKgbCfEDmfMExmOsf101mhTS
 QEusM8EGArIbH4Mi7RVl+51rAUnBnhyq7voAVGGebMSlc1qU5sKhOFL+kQziT22IT4nsGf0Twaj
 KNP7KIPNEGO7kJ/253Ce9gojVyEbj9ova+AzZ9tHQIYBQwBwtItECOW2LZdtj/AJ2PmcVQBkv1u
 P0kEtyKSTI6z1zKjSDGX08yHo2pKDoIFonhYp30DaOXzGJEZQ9X6Kpst0Lw3tZdni9uRlVqZk1D
 xkO9mC+RwV12aQCDeBczDvAbNHdT11VYLXs0qZDMBy+AA9eFFdMIkFEs+0i9BL1XwSm4SKhF+9G
 38dgtXarccQO880308mzOxW0UVYsAfYaU50LaoKoX6Vn83LiK6PX0GQ3vvavZxpgzetKbxjPkK
X-Received: by 2002:a05:600c:3e14:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-483710904ecmr337507715e9.29.1771528998317; 
 Thu, 19 Feb 2026 11:23:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31bc068sm18755615e9.4.2026.02.19.11.23.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:23:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 28/50] target/riscv: Remove unnecessary target_ulong type
 uses
Date: Thu, 19 Feb 2026 20:19:30 +0100
Message-ID: <20260219191955.83815-29-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/gdbstub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index f89b20ea84a..a053009ccd3 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -52,7 +52,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    target_ulong tmp;
+    uint64_t tmp;
 
     if (n < 32) {
         tmp = env->gpr[n];
@@ -80,7 +80,7 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     int length = 0;
-    target_ulong tmp;
+    uint64_t tmp;
 
     switch (mcc->def->misa_mxl_max) {
     case MXL_RV32:
@@ -194,7 +194,7 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *mem_buf, int n)
     const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
 
     if (n < CSR_TABLE_SIZE) {
-        target_ulong val = ldn_p(mem_buf, regsz);
+        uint64_t val = ldn_p(mem_buf, regsz);
         int result;
 
         result = riscv_csrrw_debug(env, n, NULL, val, -1);
@@ -215,7 +215,7 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
         CPURISCVState *env = &cpu->env;
 
         /* Per RiscV debug spec v1.0.0 rc4 */
-        target_ulong vbit = (env->virt_enabled) ? BIT(2) : 0;
+        uint32_t vbit = (env->virt_enabled) ? BIT(2) : 0;
 
         return gdb_get_regl(buf, env->priv | vbit);
 #endif
-- 
2.52.0


