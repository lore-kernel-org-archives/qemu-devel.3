Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F2BCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWPU-0005Sz-B1; Thu, 15 Oct 2026 21:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMK-0000Td-HB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:52 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMJ-0004Ii-3F
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:44 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e934449bb0so20560055ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112622; x=1792717422; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MBK8eYjfsPbIseVenOWdyMadZX0/gjf5rcvF6hMo6LI=;
 b=jD00gJIHBqdCrvtlxsue8SB/j72ELkuNBIBT1qfTLCWnNZ0+GUSzFuHB3KMwAxUVqS
 03/S2JXbDwkaKy5eovcgT1vlVj7GgsCMcjyZATiRMEdFo1fVN1z6R/D8PBSO88yO1lCF
 WLtLr1ShXHnr9oS0Y/peIRrg/EUgpaEWB5IGOqy8MGk6Gae7L3cL/uZdkaoDBcgzmN3J
 XzCr/AmNBvYJLhn1RaI3cjRC+i0pXH1NIV6IWm/XFiQ4J1fsrwMpOgLWuNkVvmZMefLB
 Hzev2yG2NMFVjtPeEiisww92FHF67F13c6BGTLbQYm1IjERwT0eKr98qn6j6kJtbXXOW
 7g+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112622; x=1792717422;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MBK8eYjfsPbIseVenOWdyMadZX0/gjf5rcvF6hMo6LI=;
 b=UI2LA4Co8sxaExM9jYyFbCV26xEn//aFyaJXopqAEwMOhJDjoU2H7tW6G+7M7urdRp
 5g8Ji+3oljHGp2Ltuatc7JA3x3MXbEHhpiAMZ8y9O0uHBvNNLu5zglqUXtOIcy1E+bpA
 NfRgCJ68Wc1enAaf93PUQ+RZa0SJwWJwTDKadPcPyypig0tdxxm1/yWUZb2+MTIuD/1m
 9DG6r9QxXgkU5pfkcn8OY07d7TtfwgqqXjIMDo4MXJIbAUAyc4dJ6GN8UBhxByg/g1Yn
 cPzQOH8PB4rAogZq4Y0jibjCcBGHNZ33Qa/iSkZhdfMabfu2kwz3m3cLPxVmxIiSDRiA
 lO4w==
X-Gm-Message-State: AFq9FYJBvu7NOohsCHDiH/FrxqQvgcOoDSZStH5NSjKqbPuQ+/seARIz
 wkswYm2LLxLOWuQNMSF9BShT91HxEqElNCRPMORn5yfOlOb9oy/zarv8yqpHrA==
X-Gm-Gg: AYBFou2QrCIHwm1HYINKkjFDNfXGwMboRYn0xoVKOKDL091idwmceqBWsfcYUk2dxaV
 Q/QP/wcCEmbSsG6+X2KhTWoJfoKQGXcGeWJODcwCieh2A1eMjmW0WDw7+YC2PxGDpHAeXeIjOeY
 bpeYWwR3pBu35CB/yRrsWQ9ffXCe8EaDs50uyij/z8clE5VXkyyNl6DJqI28vpSvBZgq4RuW8Kg
 RwtO9oeSF6Tsx+KjnyiXV/II4Ak5yq8kLutS4WoqC+B5V3qA7w4wjwWenGZGmw3a0f0i2hTJQPM
 1qPliPWQ/Hk90CfIzyN4Zs5Po5ZMsEatJ1r/9U2281P3l/jZNTrh1GIE9rpZW1AqgdSZ3+r/oxl
 ssi+YCEw2Q+CCQk149F/f8HREHhRenY71jKFef/IcyFwD900HZ2OAJhGk/poGSS6cDPQ5uNaCOx
 PDhHkGRObmPN/5HOwhf62nbiVo+wv1sad1c5MBDV63pHgMlVoIX1moJNUthBx2PuSztHs7yF9Tf
 dA0o6oz7S1XQfot
X-Received: by 2002:a17:903:4b4f:b0:2e3:1d30:8654 with SMTP id
 d9443c01a7336-2e842cd4527mr177091285ad.10.1792112621727; 
 Thu, 15 Oct 2026 18:03:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 19/50] target/riscv: Have riscv_cpu_set_mode() call
 riscv_cpu_interrupt()
Date: Fri, 16 Oct 2026 11:02:06 +1000
Message-ID: <20261016010237.1102834-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

riscv_cpu_set_mode() only want the interrupt re-poll: the mip update
with a zero mask is a no-op. Call riscv_cpu_interrupt() directly.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260930174508.81497-5-philmd@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 6115f65adb..6a8533ee31 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -886,7 +886,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
              *
              * To solve this, we check and inject interrupt after setting V=1.
              */
-            riscv_cpu_update_mip(env, 0, 0);
+            riscv_cpu_interrupt(env);
         }
     }
 }
-- 
2.55.0


