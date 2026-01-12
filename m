Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDA0CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQky-0001dq-JD; Mon, 12 Jan 2026 17:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkw-0001V6-PL
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:26 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkv-00034I-BG
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:26 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so66067235e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258283; x=1768863083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vkt9/c6XbTeBWxuduBukZ1sJO+ql0bGB7j+kc3pAXXI=;
 b=V9alf94LyQlhmVLgJt4SyRurl/7OxR++PqXIch/eGVNo77Lv3rGrsuQP9S0ZET1KsW
 iQMPKcrpEOZP65QlmjiyHmd5QEkWErn4naqFYlo50zjiadTOX8p4Mw7O/xSUKiIGYUXS
 ijNL7/sdjT6rmrRDBPgnXoGfzI7lP5jXoEnaJYBJ15LiQT4ooP2zZq0utw0FYYHbVsSK
 XYPTamV0N8OeqtOJ6JLrzRPITkDsW1Z7UfTweO1yCVXVL/r5gPl/SUzDO0UFQdNpUhFK
 7F6FaOWdJ7X7rRPTVVOi3jkYigs7JzY87v9M/glbwNpiO9krnd+w6cL4wpR5I5a4s8K5
 Uk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258283; x=1768863083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vkt9/c6XbTeBWxuduBukZ1sJO+ql0bGB7j+kc3pAXXI=;
 b=Dd1CSJ8lXBhozl5+N9swAtDHQyXYbqQ9BrZOGcxLUf4Eec/hb1EO59TVhp7fyICyFU
 9RR9E1TbwH+cb18w5t1LJUzrymFD2FUpIbWmw+1FI8v4EqhdIFmDKKENCLMG7mZKti5d
 IyrClULdnpbcnCrJkjubCZsQDF/Vkgmifp4S629ahBx4MtHHOznLlSdY34n7dulRuvyO
 5P9hDjk9OxMBmSGpa6XHIpxXX49W5PGWTrQKm31g0GUjankoxT2xoHXH8UsJZ8bMo226
 xqrtknV9HTRt7HOqTZMhBIp3DbjFZ/kovE/3gelE2ioZzPc61z1MpMoiyTc2/BjLS3M9
 0jYA==
X-Gm-Message-State: AOJu0YzT/iu0hf7GKnqx2ErhDWeBgIVgRQZ0lxBvfeD7XLbgs3WGo30E
 w2rw1ol/Q1WLBqS2xSmRAx8th3G+dBzRmOiRzgsO50ng4gK0wEMbYEb6xgfwOBNoFFEbi7R0u9x
 R+O8+vaU=
X-Gm-Gg: AY/fxX6mdExLibjV5k5LejQQ4SI81cW/AFbKtk0nVU1Y+uAJvcdDkJ/UGWHtyJLRsKe
 R4h4otYX5oRuXP42bknOKrztmqEak+gZJZDlRhS0n2Huru92PJcomISKxAxtTF2G7JBVhJ9ASMB
 128ga3GUKP1uXqTpvL8BXDc4s/sV8X6hvk6YXO2jrGnd9SP2IKEh4xxGh7BNvjer+qYUnVCGPJt
 ynTVFc/W9hKBlJo1LPHmzmw1Zk0iybzzF+JdyyHfgyQjr1moM8J+KaI2LnjGiBNNtZUTVYWLZ4l
 Xyp2+BhA+gg8KfMHNa709Qh0BA7bynuyDcHoOc2pFyGPf8cLWCah93h5HIQaz624vwaPaUmcjLz
 HjWuoPI425IOjWFBvqjfSlSUieeY1+Xv06MxlumeQzBXCjyF2lTA5vWEVbcTbA+lHaXH5SB2TZd
 ja07WbkM7KLPYlXy0XiGeSh0moEmvbXF/avTPtCM8AAXtFPV5Rv6Izb+eDFxwT
X-Google-Smtp-Source: AGHT+IF44kr902r4ZZXLhIWXWssoUcUYhAMTTP6lr/PxEnu8pQhCbLLPIvxZ3VFsVkE+tk6ebhqeyA==
X-Received: by 2002:a05:600c:8b0c:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-47d84b18a9fmr212070675e9.5.1768258283439; 
 Mon, 12 Jan 2026 14:51:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5dfa07sm40684120f8f.25.2026.01.12.14.51.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:51:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/61] target/hppa: Use explicit big-endian LD/ST API
Date: Mon, 12 Jan 2026 23:48:16 +0100
Message-ID: <20260112224857.42068-22-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The HPPA architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/hppa/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251229225517.45078-4-philmd@linaro.org>
---
 target/hppa/gdbstub.c    | 2 +-
 target/hppa/int_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 0c5e41410a0..4f016a0e61d 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -168,7 +168,7 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         return 0;
     }
 
-    val = ldn_p(mem_buf, hppa_reg_size(env));
+    val = ldn_be_p(mem_buf, hppa_reg_size(env));
 
     switch (n) {
     case 0:
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 4e4869285b5..d5a20cd549d 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -178,7 +178,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
                         break;
                     }
                 }
-                env->cr[CR_IIR] = ldl_phys(cs->as, paddr);
+                env->cr[CR_IIR] = ldl_be_phys(cs->as, paddr);
                 if (i == EXCP_ASSIST) {
                     /* stuff insn code into bits of FP exception register #1 */
                     env->fr[0] |= (env->cr[CR_IIR] & 0x03ffffff);
-- 
2.52.0


