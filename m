Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2488CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt7y-000201-4Y; Mon, 08 Apr 2024 13:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7u-0001yR-IJ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:50 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7s-0003dG-2s
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:50 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2a484f772e2so1960967a91.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598586; x=1713203386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcrZGxEnfZgrLqlhciK4hABUGUNHIg16hIoNjeHOda0=;
 b=BQRaTG9An/Xtzn/H8YzpEfiGRFcqRQeMI8oWvYWFQsjIrgsCCpXvm8OyOEepZM8xCf
 lfTwq5/R5zbIA0ju5yZ5HCIqEpkBwpV0QsVYCF3baPE8jVzP+iGeRceooSKL/YF0ET2O
 6yDu9BCXKpXKB2DcFuMQmlmdShuBxJa8ZQQvAiUieLb7O3jT0Hj4MIeUWZ3pjrMmXYMy
 1WwCh6H9ca/pYOGjo8UjdcOpfEQKIaWQXKo+CcPF3Ndkf7Hd2uwbGmEv7unDwJuM3VlU
 m35+MOupQWeuhNXMLkjwGNLj6G/oxmpRye5pNxtgI70zZ41NpCXq2hLdW2wZGaLrdpOX
 yc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598586; x=1713203386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcrZGxEnfZgrLqlhciK4hABUGUNHIg16hIoNjeHOda0=;
 b=ijPYaoC/qVYlxjwFFhIdp0bale6xYbYBwnKp1wKc6JQ1MuNfnJBQtMKIpX/nujmED4
 BSlxKJ1PxqOrBGaaTIZFx3eZfQAmmcK+MxzUx+P1PD6w1hdfFCNWs4mWZ3Leb9UBO9jx
 +hveoJDIhkrzT/+whi+DlASUz9alWYpjkXQWFl3hF0LKzehwmGPPS6Q0mhgJE+/xnHgn
 ChMPLuKeD6bYCjWw26SSftj/X+cvSFZeoLNVmplSxmfEmVaZK8ZtcdJ09MAm+yw07AM/
 DszjRjSjkYW1T64RMZAV8HE7YEoPFBK8C2VELV+fOE43+QgAGIZ7DpLbfNVmgiMfaaXf
 k91Q==
X-Gm-Message-State: AOJu0YyquHiu6N4Ex5z0wwiEmYfS2l1AdQKKAnuXhIQUNsE8gGuAEkzy
 jC+9ZY4LoAhW9VF0OtkULJLjORanPYTz4S5Ex4djfWcQt33AduSRyHxC7ndiLjHXEKe8MT/aF99
 N
X-Google-Smtp-Source: AGHT+IHHMAKZhCZWVrABnWzz2ncsXhiolw8U1Q0qx5riK6QRc55ryS5wzY8nBgyntxp93aY6gmLegA==
X-Received: by 2002:a17:90b:380e:b0:2a2:d10d:d30d with SMTP id
 mq14-20020a17090b380e00b002a2d10dd30dmr9806268pjb.26.1712598586570; 
 Mon, 08 Apr 2024 10:49:46 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zack Buhman <zack@buhman.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/35] target/sh4: mac.w: memory accesses are 16-bit words
Date: Mon,  8 Apr 2024 07:49:04 -1000
Message-Id: <20240408174929.862917-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

From: Zack Buhman <zack@buhman.org>

Before this change, executing a code sequence such as:

           mova   tblm,r0
           mov    r0,r1
           mova   tbln,r0
           clrs
           clrmac
           mac.w  @r0+,@r1+
           mac.w  @r0+,@r1+

           .align 4
  tblm:    .word  0x1234
           .word  0x5678
  tbln:    .word  0x9abc
           .word  0xdefg

Does not result in correct behavior:

Expected behavior:
  first macw : macl = 0x1234 * 0x9abc + 0x0
               mach = 0x0

  second macw: macl = 0x5678 * 0xdefg + 0xb00a630
               mach = 0x0

Observed behavior (qemu-sh4eb, prior to this commit):

  first macw : macl = 0x5678 * 0xdefg + 0x0
               mach = 0x0

  second macw: (unaligned longword memory access, SIGBUS)

Various SH-4 ISA manuals also confirm that `mac.w` is a 16-bit word memory
access, not a 32-bit longword memory access.

Signed-off-by: Zack Buhman <zack@buhman.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240402093756.27466-1-zack@buhman.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index a9b1bc7524..6643c14dde 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -816,10 +816,10 @@ static void _decode_opc(DisasContext * ctx)
             TCGv arg0, arg1;
             arg0 = tcg_temp_new();
             tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
-                                MO_TESL | MO_ALIGN);
+                                MO_TESW | MO_ALIGN);
             arg1 = tcg_temp_new();
             tcg_gen_qemu_ld_i32(arg1, REG(B11_8), ctx->memidx,
-                                MO_TESL | MO_ALIGN);
+                                MO_TESW | MO_ALIGN);
             gen_helper_macw(tcg_env, arg0, arg1);
             tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 2);
             tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
-- 
2.34.1


