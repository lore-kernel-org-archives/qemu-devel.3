Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA955FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO9L-0004io-KX; Wed, 25 Feb 2026 18:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO98-0004G8-Hv
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:25 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO96-0003BF-UZ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:22 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so3176565e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061499; x=1772666299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qx8l/7wXfvDzOx35Ak8qi4667/GSVMw0wLGmPN1fR18=;
 b=S5uZ9+o0dwgMf6lRqKrFO4FUhZSVz4ET7AbsK3qEW+aYFqunMXX9Tr1LBvHKhpaZ4z
 9+XHs3NVmdX05+cfvck5wK9JAtt6BlVymQKuQQtHcGI+2RRkbBqbu8sssppvUZ5adDXE
 iBEmKr6uUQxQK1pwX5kvHwmXWwzypc636WkqiEOvWYnpByfTIr2bgsMp/HA+S/+TWZYf
 sm4t0d9AQgegNSoedzUR/bq82hP/AIPOF7sdh9NsYmVd+RyYYSlUGvmxpDFIecDuU7Ki
 NB6316AZoa/hH3wiOq8RKlf8wdiWXJ9lycGzLYH7RxWksIs+YgbRqB/uBXhcn0EDJKoF
 6VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061499; x=1772666299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qx8l/7wXfvDzOx35Ak8qi4667/GSVMw0wLGmPN1fR18=;
 b=RpDE4tY1aEF+qLjU+nztzgOsXlxIp534VyIJhY14e2Z7OU7HIIFVLX9OULai3fTZGj
 6Y+T4GhRtkdIjgIomk1qFQCApz+QsqwUkuPsnpw0GgkF7gCQTxOeyDou9ddT++mARKl6
 RJmbpWWV5/NS3HUNYtnO0OOvFwAfJTUb2sQBc+L6l32MPFH606gBg2XfQmfSG17wRLTL
 d24ng+wOUpzNhyxC7WkA5keGtQfnfHxTtmI/bWRRg6qBTmtJA98Iocj0CUIOOPNTcvAj
 nMbwNbHmWqlqq7r0sPbbYsezLIggmx6LXeBsWBUpCxOz/jp+QgWkQOb2whdWnpChk2/i
 ZxDg==
X-Gm-Message-State: AOJu0YzZNG+ygdTBmrWqmzEIw9t1WaCL9+rjCoUbLiFqJCbK/LG32Pyh
 Qb1LQPaFLXM6t0v45rgW/xoAhLuuuvEPchX7m4zdQ6PemdCkyIgky/dDzeOr2VfaGwwj869bCwj
 eJesot9A=
X-Gm-Gg: ATEYQzzvhkh90MM+8N3a6lXTjnLqXzanQ5bbeTTxQ+lChLDQb+4eP9HIeS2NQIrxDjc
 HDdANpTT4sVqpwdaSVjVDZidj7fw1Q692sL/XxWswk59H/Zs2ztdVnQ3OT18bN/0UOWY6e3huQU
 JW5DvhMRdi16ibdd5U+BrB2B3+g6h6lkGLo9u/Ff3woOhIQQUwpIBpu6C3BVrNN0YGgy3gUiXpI
 gHITlDnWjJDMs/y2Qq3Bwinzx2EC/z8mptVxSqMIADs87sB7IuWAguBFe/XE2IUo6hiyrNisR79
 I8YsOPRj7FiZllXQpI8Mokb6K/vfsOU1340qdVMXvuhJBx6dTqxWHq35/eJ85OGRv4LRuls+I/O
 h3QxhIwkk4ooF/OBdjO7rpRpj3O4hwyRFIJ7R1p97Fv8KWsaf69RZ4QuLtsLpgLRf0et8tR3Y6b
 VAoykN3b/RRwgsFlh+2U1bhIv4HqEqmwn1s/X5VaDuOWAu/uMKAPG27E5VJ1lwJrL8hPTFhM2W
X-Received: by 2002:a05:600c:4e93:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-483c3df874emr993725e9.34.1772061498830; 
 Wed, 25 Feb 2026 15:18:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb987b0sm20773375e9.13.2026.02.25.15.18.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:18:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/70] target/riscv: Remove unnecessary target_ulong type uses
Date: Thu, 26 Feb 2026 00:13:36 +0100
Message-ID: <20260225231411.96482-37-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-29-philmd@linaro.org>
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


