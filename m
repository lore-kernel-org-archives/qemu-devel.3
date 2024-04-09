Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6182BC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGT-0000Yj-6a; Tue, 09 Apr 2024 15:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGR-0000Ya-V2
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGQ-0004dV-97
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e3ca546d40so32787645ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691373; x=1713296173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcrZGxEnfZgrLqlhciK4hABUGUNHIg16hIoNjeHOda0=;
 b=O0XjgK0BOwClsrHSD5SVhItjS0tXD5REhSWHRaLcsuoHHSTR5ZKYWhk4sn4yr0uvy5
 GpAhRKyJB52zRXjE11IY0FpYSD1MEYSU5xNypA1OW9HC7UqZhieTLx0e3Ckdm4E09pW7
 I7nsWq8yJQBGHIO0CBqTIxbWwGFYXqI1RnwKhz9YIKMknIi6Z4S0lkDvvV8AcEIRkil9
 KpQKIl6ZjZ++GORxWMbMk1PJpzPYo77idXjyJhOJi5BfYhrLOC2hxuVx2kWBRIlY+f7q
 WHNb5IowYYcPoSqZKRp/Ix3aNTXGFdgUAKzBHQ27oBHqr3Yq0q2rvopDRIJoIjRKVT9q
 e4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691373; x=1713296173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcrZGxEnfZgrLqlhciK4hABUGUNHIg16hIoNjeHOda0=;
 b=BPGnub6gilv+W0pYLEsWTlyr8lkxehhroRgBhF0KLt8WU+r7CY5h5dvCHe7xbfQV//
 8R6xKTO6Hx/WGf4P6RdpdXJeEgDP0mbkPJj4TSlY3Ym9L/HTZZf3FIRFCvHlU+/tIHeQ
 i3UKE2RoqCI58zQ/hZNwTzij7SsgrWN1W+Yon0Cz0F8aOi3rAKpxc16ib8bErhpp/7dB
 10uiL2LrjvaJjdDHb8t3IrqXjVzK1lqu2O4sqRt4E7r59q2S/DzaCd+CGPUj8LTpBcw0
 91fkdbHiIiZ1M7Ar+lOfRPrx00eYH9vMwU9wlbyuQ9pHiI6NYJOz8jMnGFGiHtg1MXsl
 yCxw==
X-Gm-Message-State: AOJu0YzymKBEoT0HlmlkEdb22TTl2bVGmIKX+G0Qa2PMZOfhMFz2dIpY
 Z/3aVwGupvUTYlX4gz0rUmZ78yWBrxwaKQnamL0Xkm5bry/lApayRe+CXhgulvDlAZeELIMxmba
 A
X-Google-Smtp-Source: AGHT+IHzLEmVrSQQngDOt3J2FuXdg443OTw76cp7x8wqkU1vabvTdt/3CtGFOUDAHHmdMR2RXKXMPw==
X-Received: by 2002:a17:902:e541:b0:1e2:a5b3:e4 with SMTP id
 n1-20020a170902e54100b001e2a5b300e4mr996525plf.0.1712691372878; 
 Tue, 09 Apr 2024 12:36:12 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zack Buhman <zack@buhman.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 05/20] target/sh4: mac.w: memory accesses are 16-bit words
Date: Tue,  9 Apr 2024 09:35:48 -1000
Message-Id: <20240409193603.1703216-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


