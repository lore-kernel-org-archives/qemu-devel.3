Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22867D232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56v-0004tM-IE; Fri, 09 Jan 2026 00:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56t-0004p9-Ns
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:31 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56s-0003lX-Ap
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:31 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7b22ffa2a88so2145972b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936749; x=1768541549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvTSqQaiPlcXOqq0UTpnohksxxgB/Z8RGxM2VcVu16E=;
 b=BGhNgD+nl20V5+eqP1X0wyLqEmNHTS7jSCncQkgA/0c7fhu0hkLzM9/M03H+yjYf6R
 V2Ea1X+Sdxz/R/ATSQM5nByQRW83JIIMhHtjwlLj1wbUlSVwYjS4PDSjxsuTlQIK1+hD
 Q8Lt7SZeQIpd2pI4E7rQjC9PMXH+Mzo7cANqmr8jIcr+fxwzdk3xxAN9Rd1dB63r073J
 /R2w2pV5Nk/SxZdgRnCTgWlrIcPqU8e7HQMW/R9TA0O2NMeQHFlwohYl2Btom1ipeksM
 98lM/Pn0sHb0pnnoWgpy/XuYiTYfpoIBY1mnWyaZn3LI+GkPkI5YkCse97ub6dX1eD17
 d72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936749; x=1768541549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HvTSqQaiPlcXOqq0UTpnohksxxgB/Z8RGxM2VcVu16E=;
 b=eszI7ppVK6Y3BjjTe2AoNil9OeUuZAFVmTn162i/MfR5PlZG1DO/X52ScxSEuAjo/H
 ip5ia4RjhCZlvuK3rRdwDN+rztFKhYMeL2DABUsgkUEa/7XHH3foACmNJ7FCop4lCz4w
 qHRr+viiTwIeiruWTR6N5k/OUHbPhiZ/TolDjFiofHVdWqI9BfFxTVmE6fk4u13jn0JS
 +sb7inVnYo3HM58q0HaiBO8UDtwd5paxWrE22sID8nu9AOEM6AwLV1Nl3bu9WkL2ZL2A
 1NsOtjvSxGpjn02Lh75NjJqGKwq0nghJKmc09uBepg8+Dx2hPLp6ohb9YZshvVYeekSz
 CDpg==
X-Gm-Message-State: AOJu0YzI3g2nFU2FAUJmsNEYVMNtzh+ZZdmijOBmmeVqV6Li+KQtapno
 p9vWAWtyJI1oZJVUIq5wYZa5E8KkOidRmKyOu51QcGeIHHEIPnd14j63IZo/cJQIPVmK6WeTBwB
 CwwT7
X-Gm-Gg: AY/fxX4O09flfvAer6siEZCibW4OYtSl8lV3X44k6LGaiUUoe7YSNo0/BcIURji/Nn5
 0NUooZNeFLX0ES954Ylxi7ZCkTDHlIiOIRxVxxc0oGKMer70EAy2RwzBG1qAATxsLQLwlfd4rrk
 SdnxYiHD2S80Bw1PNsanHWoyWl8VSv8QQ+UHb+Es+grG5x02SZr2GzrOgMJvLI1ZoGmvX8CSDpd
 MQsFpxeB4I7pEyVTHoUT2rEnUzLs2n80DUSGgGipDqlL/OobZoe+ERhkIV3C4T6dqZwejlztmO3
 NxOde5wud0zvBg8HU+YWYe28P7i3Goz8uqBvl3BZyO9bU5SetY9aWl6DHPZSpuy6d0SsDia8o9l
 HY9HmHni2spVQCDJSKnl+CzZLEhvVur13gpLqcu/HTgjRqq/vmMKGHNdTb+V4kFv5aIUKyZ9OJP
 g4LC92HNqa5lK9Ietn+4C2RSE6gVvrLYa3dbXPp5kGx6jq63HQm1zGdAingm/dYaOw
X-Google-Smtp-Source: AGHT+IHweUG/HNIFjyaNuz90mk0Mm6yKJmBp/MrmxHlAmpxZ/LIYI5WaZXYECU2SVmUbIYLfaiMNYA==
X-Received: by 2002:a05:6a20:4309:b0:341:c255:7148 with SMTP id
 adf61e73a8af0-3898f8f35b3mr8730593637.28.1767936748678; 
 Thu, 08 Jan 2026 21:32:28 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:28 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 27/29] target/arm/tcg/translate.c: replace target_ulong with
 uint64_t
Date: Thu,  8 Jan 2026 21:31:56 -0800
Message-ID: <20260109053158.2800705-28-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 55b89817cb1..7128c633290 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6433,7 +6433,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
      * fields here.
      */
     uint32_t condexec_bits;
-    target_ulong pc_arg = dc->base.pc_next;
+    uint64_t pc_arg = dc->base.pc_next;
 
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
@@ -6595,7 +6595,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     bool is_16bit;
     /* TCG op to rewind to if this turns out to be an invalid ECI state */
     TCGOp *insn_eci_rewind = NULL;
-    target_ulong insn_eci_pc_save = -1;
+    uint64_t insn_eci_pc_save = -1;
 
     /* Misaligned thumb PC is architecturally impossible. */
     assert((dc->base.pc_next & 1) == 0);
-- 
2.47.3


