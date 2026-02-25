Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984A5FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOBT-0007m4-0R; Wed, 25 Feb 2026 18:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBR-0007kT-Ev
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:45 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBP-0004Bp-PF
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:45 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48375f10628so1988775e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061642; x=1772666442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4QlfSlu4aXwljxewfykwNNatg6DZH2GiRF35bvXtANE=;
 b=B0re+4OUP13AXqCWkVdBtcJqrGUXh3zhaArZYjkZWt+/xjk81SknBt5vvhz2l5iRKp
 Vyit32vmLrxLgOofJo7trUNErutsUYnnVscL2x0lbjUhvgtCV1WJ1VkDurTVMHibkUX/
 87Vu1hdU1b/qMFHf7g4zCDW6rqrnQxNeEndqNe9aKaMYVZ6ztEVQbe9zbxZ4PnjgvrEq
 ikYrY/rVzggwl5d9BHebfi4e009+5wUVRHnKSrZKBFAA9nlclPjputi1x1NQu3uX6+U5
 NTPwgPR0aDDmJAojK+tzOjmj6hyaJTc+VA8s6Qn20ccsEmlnsZcAP65y11rCmgeCAczA
 zbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061642; x=1772666442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4QlfSlu4aXwljxewfykwNNatg6DZH2GiRF35bvXtANE=;
 b=vtTAlMu4oKyXyNM5lQKZt1dSQ8JplXPP/bMIFn4HUVVtUj0odfoC0kFPG7Tb9ofSL7
 mMWUMtl0pIxyDVvxsHzbT0K2d6CKHljJG9OdqhwDAi190HuxnnGcnU9SIkuDk6b8CRq7
 hT3+cHb0A+RE3TvnCvNNwQacSQRUyxv+xIvXLQaG4HKTyx9i+S97VbZlUCsiYo0bmOov
 JPs0761qXVJvOlyK0YSaehhJSH4SwCO9o6cIVm1+mIHmoMGh+iZVszCyT+JF3ZB+qXGK
 ou8F6XWfJzbOsnwRoMIz7mwI3xFHnVLLAz/mzdcPjDvpIGXEDX8Xin3IAmYd7E7AgtCF
 FvdQ==
X-Gm-Message-State: AOJu0YzqAqRqc5VIMiwVd7FfV/KhuZm0+Dc77xaninjnTgkrq/fjGC4R
 Tg/P2eDfn5DA+KildqmN7cuBo8Z8vpJ61e7hsaD5lTK0oFH8htE/L4OOXOXjWwxPF4Nnf1IUDKV
 q0yI2KoI=
X-Gm-Gg: ATEYQzyTy8pBzToGkka+8uU0sXjYkLaXgQnAk6R875x5FgF+2Hx5n9FXcq2EETaNbw6
 31ZhZ0nDijRgWVh9YKTZgP5V2d3jN6oaeL7r+9IJM2c713R43F+cfTFbS9TcLO8bToKPCiA3yC8
 Dj6cj954yOROSgOUSGCikqd0xGshBT+A6uwM5Y/RYSWsktWo8ERLbXTy4QGe+5FqYDVmtboBzJa
 vVdjanur/r8XwlM3K4eAL8LcKIwxG7iPsnnLVBx1t3FApptHf2AeZAe72H/ZiAfgxGFX1I5k9M8
 KLXtSE6Co9kFx4ww5cP0EkZD3JY9MHvmfX3swjHMPDP0atHvIp9QKeVClDZH/Vkc/rI9bJRr6JJ
 o3ffgWiQrFcfbDJiuXqDEf2X1+UaQunTnFCIhGaPSgcSuL9cRkcIOlkRp+o/2oHjnMCDWehnFkW
 +LVxvZBuyEKY5U2gLRVwN7I272cK/qxOiGPacSufAkedzwaj8ocohqoPdc2ZJvwUg7eTK5K7qM
X-Received: by 2002:a05:600c:8107:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-483a95c5313mr318587215e9.15.1772061642012; 
 Wed, 25 Feb 2026 15:20:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c95dsm41134746f8f.33.2026.02.25.15.20.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:20:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/70] target/tricore: Build 'gdbstub.c' once for system single
 binary
Date: Thu, 26 Feb 2026 00:13:57 +0100
Message-ID: <20260225231411.96482-58-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

There is a single qemu-system-tricore binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-50-philmd@linaro.org>
---
 target/tricore/meson.build | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/tricore/meson.build b/target/tricore/meson.build
index f40daee61ed..76cd78e990e 100644
--- a/target/tricore/meson.build
+++ b/target/tricore/meson.build
@@ -5,11 +5,15 @@ tricore_ss.add(files(
   'helper.c',
   'op_helper.c',
   'translate.c',
-  'gdbstub.c',
 ))
 tricore_ss.add(zlib)
 
-tricore_system_ss = ss.source_set()
+tricore_user_ss = ss.source_set()
+tricore_user_ss.add(files('gdbstub.c'))
+
+tricore_common_system_ss = ss.source_set()
+tricore_common_system_ss.add(files('gdbstub.c'))
 
 target_arch += {'tricore': tricore_ss}
-target_common_system_arch += {'tricore': tricore_system_ss}
+target_user_arch += {'tricore': tricore_user_ss}
+target_common_system_arch += {'tricore': tricore_common_system_ss}
-- 
2.52.0


