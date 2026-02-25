Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F25FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO7u-0000Dm-3C; Wed, 25 Feb 2026 18:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO7Y-000803-JO
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:47 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO7X-0002u8-2v
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:44 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so3056335e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061401; x=1772666201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nJ8BmygwV5uM3x8177Nc6uLEekFys9eBWoDNCjse/DU=;
 b=ru12PnUm2Kx3MH3hhXBfLXu0z3h9ueAboQdKpKw2HM6d3jlgtQkAAvoNy51iOojnUA
 Gq9uZqucf2AjPhYhP9l8mgIfcGxpj5ufw36uCJg0FLIT9sZPLk0So6PFrdLkmHS+9QDY
 V+6tl/+t0RsAmEmoVzs5zk0OYN5SEJ9cOz02XhjzMkbibd9oxyq65vCdlYQFL6MlqhTv
 gIo48QdCXMQW5cNq0cp2YBT+lhgW3h5790ZtLZpVa80nffNLaJcwbxUmD/bQ5xtiYm6E
 1O2alDzTuaPrBHtSge7zA1HDVyZ9ky4GuWO9mjXKYgrwAqEQEeGmwKuw0qlu1mgL4g+1
 wpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061401; x=1772666201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nJ8BmygwV5uM3x8177Nc6uLEekFys9eBWoDNCjse/DU=;
 b=RfsY0PAJph3xpT4Ne26iWWpdhtO7/gtRlwWczsxwvMFpiDZRVI7wxx6FklADXi2O/X
 mbLlo/OwlyYfOcOojhhDLZVYD1xqM5fI1T/dIc5kmVyyeqUlcqcf4/+Junn46/N73iu9
 nyk5ULWXmjvyd7EihvFYVMGF7wHft9Nb/l5CCl6sQykHx7NL3GUEXtxUOqokr5W1Mem9
 /JPtOfmNfQ8RsulATwj1gCtu2oUV9UadyYOfbxPSkg4QBnXK1iOSc7dIgqksuZbhgu7s
 wpzX0Q4ntyDaAyF9vrn6mOlpQOT6M9/axlgJz8EXabiBT/IdpQ2jd6sPW0OuMrQSbcvP
 YjPQ==
X-Gm-Message-State: AOJu0YzRNJeqFeV49Exp37WohYOVVyKyC9B9zKjXyfHwWS2x1S5lGyuo
 a61ESufiz7VShsm/qzMa9MDVD5B6D3Jj0QwCByQBEFNUMazPAL2W+nS0XMjyAC2gi6ufJVTKreI
 uc2FtE6g=
X-Gm-Gg: ATEYQzyHRuLprB8aG8AhZ2BTLcg9UfESJxc7RPrL+8xBLfoc2QbT7OgrdbRLdLl1dSi
 ufoZ715/x7eNG88vcKSpGKQccdDydtMeZwnxf/Jx9+z1rDyf5U9cs72VmTU2htYEhucTfX4oEK+
 4NnsaE1mziEkizVV/YOtBF2nfyf7qqJoqc1+utUZPrI8Vi6qJ5vpfBGMEZRvzF0PnS5AnFf6qs6
 Th1OoklCeEBzzRZeAJHbMob6Q//r96tuObzbRBI0NY1gAlwqk0lVXR2olXi/3m3IZU3lbUHTc/B
 5m6fu1sDBolSpQ1vzHfI5eVgpXX4S5GKyW3kAxxzYayxpb3vPzz5AaEakPLxMbA8ZYk+/R5q+cA
 zhoHcePCwa0WfF7LlmUBVH3rHJD9gDGw9zAC6N9tDv5szjFuEX1+zgiGBcvBdFQi1T3UotK5rgt
 cWEjWvhoI6FvjNxXgNuF9uRo/25oVqBk47xh59PvCpq0n8s+sjsFUQF41Rz1Lo1IhOv7opcn+R
X-Received: by 2002:a05:600c:8287:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-483a95e205emr275774155e9.22.1772061401145; 
 Wed, 25 Feb 2026 15:16:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfbb6d16sm30082165e9.5.2026.02.25.15.16.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:16:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/70] target/sparc: Expose gdbstub registers to sparc32plus
 target
Date: Thu, 26 Feb 2026 00:13:22 +0100
Message-ID: <20260225231411.96482-23-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-15-philmd@linaro.org>
---
 configs/targets/sparc32plus-linux-user.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
index 3e6c72e793e..cf49c53ce44 100644
--- a/configs/targets/sparc32plus-linux-user.mak
+++ b/configs/targets/sparc32plus-linux-user.mak
@@ -5,5 +5,6 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_XML_FILES=gdb-xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml gdb-xml/sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


