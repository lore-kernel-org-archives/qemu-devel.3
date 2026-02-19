Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61ABE9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9e5-00028D-5S; Thu, 19 Feb 2026 14:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9d8-0008Gg-Oq
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:09 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9d6-0000Ah-5a
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:06 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so1045433f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529041; x=1772133841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKJRQy1UNSEtrClZAG9qJ5eCcY9fvgKkELXH9QrvK+Q=;
 b=z3iN5OZzgLepN8yVAb4mF4VR1l69PXbCxq/1QZ/2RiFMuUFLIQpHRA+ZmzD38jbHqP
 tQYYdy1iXRQKM8I/jtxVjmvteminTMC5RRsXCNMPX9MVRUSKlITtqxOOc6ju0/+n6Sbc
 YXLTfB0L/gSQdXSY2VrOBr7Kp/9jpjgmQluLeis5t3m51ikfzi9yx1D6RbktUvedqcqU
 foq8lrtZkIzNIs2FHGHywugAeYRsxqdhcHnbb7pyysCxjL8ezf9av0h/iZnZPnPqMvKp
 fPgiGgS25/hqxWIV6bokCNIxSmltCQq4KiSpoo6KyPkLo/ceCQFMUUQu/c2QVWa6xSU/
 FoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529041; x=1772133841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FKJRQy1UNSEtrClZAG9qJ5eCcY9fvgKkELXH9QrvK+Q=;
 b=JjhHHnSibtZKpss4CWAEnFwBb4STXVmj5y5hxz4nMEeOICieCusKe3vedruLon+8fL
 MfCxWe4tKOdu/MMu9hykjdHqYx97XIv4Jd0H5z1MzaDsVvdkCSG8P+KVsCOEFPOnoKCw
 npiU0QJcaPFIRmMAajQJPPfaS6stRHY2t/Hm+ewgbMpQtLceiKMFS38apmKdgXOnfvO9
 6f0gSWDvBJSzfe8be2+C/WWWhrFuVVelis4GEPthNNz/lBnOIK40OIcZ4NvKIwwNsCTR
 Ur/+nUWp8M8MaLwzLeQ8LiXSqgfLVlUo6zcfMu+4NKbjr90wD7bm3922qV2TcvZ6PpHT
 XYkg==
X-Gm-Message-State: AOJu0Yxe1UJQeMF0A9w9CK03O7yg24mq0TkyfYp4xiBKTJrPdIK6dD03
 OQhrG2TFfVD52CGF0P4lajYYISBcNTRsWG5u9uVMst8QwN9MQ5jDk4H+1OlHc584fDSVTYzgovL
 8Lb3sJz/8tA==
X-Gm-Gg: AZuq6aJhMvi98XFwr0mtx0UCamzo+VG7vMYqLu5nxUnAIZvx1u7vuSvN6cAfvEqHcVq
 wGturXYV1I7t1GuMUdvFiHJDsFtEFt2gRHSWqwdK4jmiiGR1sJ+xCCMyCQleSK9q7f1PoX7tyq7
 KU4LZIa5o9uBpCPuMGJepVWM/lMpksUYRSGsyEHfdoFFDZqoTpstGk4/2eg9m6Ii0cOA4b8vlVj
 3iBDzRmAy1EHEnu0vYkdv61n23lzDeFuNDJpCo1fiAyWvRZzLxGB7pbPo2mdYVWMnAynCnbKd5a
 dDalqXMZQp/tftHxIEg0ApjelA2hz/k9pGbZdwewcBlj0+bcrVCOyxgnqPP86yCODxVNbKjvvty
 zmnmi2oJVj1JOgHmpdtwn9PwDnFc2+yLuKYR1PS80F8Y/ELzHrVxUO47q5SC+aI+1FjffpQBwYN
 cwSW/nCU8fkORicYWndrAwNHONT9RoNbcEsHH4GdviNRvuqlEsFqPwJngGgYz5/B4YcMcvj/g+
X-Received: by 2002:a5d:588d:0:b0:435:bdc2:461 with SMTP id
 ffacd0b85a97d-43962733de0mr5584553f8f.21.1771529040689; 
 Thu, 19 Feb 2026 11:24:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc85csm50293133f8f.22.2026.02.19.11.23.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:24:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v2 34/50] target/rx: Expand gdb_get_regl() -> gdb_get_reg32()
Date: Thu, 19 Feb 2026 20:19:36 +0100
Message-ID: <20260219191955.83815-35-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

The Renesas RX target is only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/rx*
  configs/targets/rx-softmmu.mak:5:TARGET_LONG_BITS=32

Mechanically replace:

  gdb_get_regl() -> gdb_get_reg32()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/gdbstub.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
index 30074c9da7b..8be5141f5bc 100644
--- a/target/rx/gdbstub.c
+++ b/target/rx/gdbstub.c
@@ -25,25 +25,25 @@ int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
     switch (n) {
     case 0 ... 15:
-        return gdb_get_regl(mem_buf, env->regs[n]);
+        return gdb_get_reg32(mem_buf, env->regs[n]);
     case 16:
-        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] : env->usp);
+        return gdb_get_reg32(mem_buf, (env->psw_u) ? env->regs[0] : env->usp);
     case 17:
-        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] : env->isp);
+        return gdb_get_reg32(mem_buf, (!env->psw_u) ? env->regs[0] : env->isp);
     case 18:
-        return gdb_get_regl(mem_buf, rx_cpu_pack_psw(env));
+        return gdb_get_reg32(mem_buf, rx_cpu_pack_psw(env));
     case 19:
-        return gdb_get_regl(mem_buf, env->pc);
+        return gdb_get_reg32(mem_buf, env->pc);
     case 20:
-        return gdb_get_regl(mem_buf, env->intb);
+        return gdb_get_reg32(mem_buf, env->intb);
     case 21:
-        return gdb_get_regl(mem_buf, env->bpsw);
+        return gdb_get_reg32(mem_buf, env->bpsw);
     case 22:
-        return gdb_get_regl(mem_buf, env->bpc);
+        return gdb_get_reg32(mem_buf, env->bpc);
     case 23:
-        return gdb_get_regl(mem_buf, env->fintv);
+        return gdb_get_reg32(mem_buf, env->fintv);
     case 24:
-        return gdb_get_regl(mem_buf, env->fpsw);
+        return gdb_get_reg32(mem_buf, env->fpsw);
     case 25:
         return 0;
     }
-- 
2.52.0


