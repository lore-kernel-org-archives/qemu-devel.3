Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0FAC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqTW-0001kQ-Ft; Thu, 22 Jan 2026 03:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTU-0001aD-H1
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTS-0006Gd-Sb
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47ee807a4c5so6935125e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072129; x=1769676929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xvFM3jj3SDZYk2Qo4ED4KDuoRX+gzM/iORleOolpIfE=;
 b=yr7fDpUWmeAdMyxaDWeTQmUPD0YQS6NtcQ93kTYEuRSce2y6jBpvXcjxHrvbPo5c1d
 WOY6SyM3j66/YAdTbCG7l83K+eO9/HrXCuW/lG7k92sEP91WpC4kIU9ntG8JALGVwarT
 MgC13ekpZ7osks+udgkQLzSfWXb5CBKg/XUX2rbaI592R8dCbTDO0YyYpET4MN68/vP0
 U6cCnNkwRRYk9letQ3HZrv8sRrJSBb9q11/zBZaf54Atq7khEjwrWfdTHVmPFQrZxNl7
 oLCShn7fCla5hwIDLSoiucLUvlteooZXLdAh29Vx9UUQFwEQNtgIX0MRhXYHlB4siZ4M
 Y7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072129; x=1769676929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xvFM3jj3SDZYk2Qo4ED4KDuoRX+gzM/iORleOolpIfE=;
 b=wHIY+Q/Q1eLncWGuyOmvtONHYH0oA/h/igzoWm/kkuagzu5apxhoCO4Nfeu4b4vlO6
 0+myVNWyVig38ENgO0heNTH+122BfZZisZ4D7n2IAU5xA5O0PcXUUZWz9nmwzPzY7cu8
 WaA3AUvIY8fcyI6CA7Wcbh8H3afIhsqN/VLntcbHNZKjRLjR2hw5AFd15BVqqFvFJknY
 Vp/tYK5tmtMU/J/kGaIPKuPWURR/iWDOXsN3/iXZ4pDmu9i2qr2Jisy8Cc0YWIWoFkin
 axJlhVE3/Ugm20PkxXDvG00ozP0qKNwhFrtmShAYbVIiVlcgzS34VXof4h/NQmb7C7LW
 i7mA==
X-Gm-Message-State: AOJu0Yyr1nXOUdfOZRZIXd8b80l+WKBL2wKm3wYKj3cV1jZ/KZvdBGHf
 YJ54M1KA2OpSYTsLF/EVlF6dM/oGKILxwL8bxpSgDYvCXA0dOBTDahSyadoGFLwGW6yasPAE6CR
 6ty/RqAk=
X-Gm-Gg: AZuq6aL7irJyOnf//7mjNuCwTQgauASDIdJsuNq+0kEhzYW4ynP7KbJKcEZEVwxoL2s
 F8qkKON5P02bjHBMWW67PfZC36dkLTWQTrpp98R+9cnAqw/4O4tivvwTVRl8z2qelNUz4kDMY3q
 wTBf80F09fI+2uo8DJfIo8cwIUukBhbryXL6FgsR6Bu7QjWfyS00MV6QqrLEageKuvaXe7Xt4Xw
 xTgkryhNK9rrdKpgAU3N/5UC3Pe6rfwXTFPEz7JfM06Dz7BaNVgrEnqOeWtrsaxEmm0WVGsJ0fy
 mX5c/wbLtg4zj+OAictjCZEtbVxjZBVyFzqz69PqeAghiYu4hEWFGbYVrsG3HV3YXKKlmfKdUIJ
 FQTkzac4585KiNcAKrPrrZfTpLNPCR+k0gjXknTe+BclXLK1sEknpJDjfBo3UOIyQ5ce0A8qytp
 GTQkUhYVQ/sfxo065aqcwcRhwNuBEj4NYlZRN94GdxZuccDfpaOp1Au4n/MoyG
X-Received: by 2002:a05:600c:4e0f:b0:47e:e779:36e with SMTP id
 5b1f17b1804b1-4801eb0375amr268036795e9.19.1769072129020; 
 Thu, 22 Jan 2026 00:55:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48048b49880sm38299775e9.11.2026.01.22.00.55.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:55:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/31] configs/targets: Forbid TriCore to use legacy native
 endianness API
Date: Thu, 22 Jan 2026 09:52:46 +0100
Message-ID: <20260122085255.95035-24-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

The qemu-system-tricore binary is buildable without a single
use of the legacy "native endian" API. Set the transitional
TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Preliminary commits allowing this final change:

 . 8075a0a5479 target/tricore: Inline translator_lduw()
 . 4a4b272ae87 target/tricore: Use little-endian variant of cpu_ld/st_data*()
 . cd08bcaa36b target/tricore: Expand TCGv type for 32-bit target
 . 8a2235dd077 target/tricore: Un-inline various helpers
 . e843ef2bbac target/tricore: Pass DisasContext as first argument
 . 4f08815467e target/tricore: Expand TCG helpers for 32-bit target
 . f30c8aa229d target/tricore: Inline tcg_gen_ld32u_tl()
 . 6b2e4fcb836 target/tricore: Declare registers as TCGv_i32
 . c558aa94211 target/tricore: Replace target_ulong -> uint32_t in op_helper.c
 . 30257dcd2b0 target/tricore: Remove unnecessary cast to target_ulong
 . 44e2b68d275 target/tricore: Remove target_ulong use in gen_addi_d()
 . a15e8996268 target/tricore: Remove target_ulong use in translate_insn() handler
 . 0d5f9542561 target/tricore: Replace target_ulong -> vaddr with tlb_fill() callees
 . 809b460f305 target/tricore: Remove target_ulong use in gen_goto_tb()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224163005.91137-4-philmd@linaro.org>
---
 configs/targets/tricore-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/tricore-softmmu.mak b/configs/targets/tricore-softmmu.mak
index 5e018d81068..9a9f23c7731 100644
--- a/configs/targets/tricore-softmmu.mak
+++ b/configs/targets/tricore-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=tricore
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


