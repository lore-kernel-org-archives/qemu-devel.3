Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9A2D12669
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 18:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQVP8-00035e-Cr; Tue, 02 Dec 2025 13:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQVP6-00035O-Ll
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:47:12 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQVP4-0002Gs-W9
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 13:47:12 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so38764495e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 10:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764701229; x=1765306029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TB7kgqvDgJRKLwRyCHojtHzbJ9g7pRARYcUzoRtozD8=;
 b=memDZ6uQYCNeZxhwjOJi9nhUjk90ZOQaMYOkgiTeDKutZ04mFswf2XRrDSkQqTGFzy
 GX1KHg0I5vb8pKzW8qSCQEhbxWC3c6KKoKRRfnpQmEEh5DbdukrMHwdYyet0DqQk7dlA
 nAvFJITE7Bl8izMO9EAI71hpXg+0i5GCVPQ6CMLgv1j/pWtlwqng7jCVxP+WaQO1QJYk
 0izFOa1MDFfwoDnT12NuzYoWvcOHZuOIc5Hk3xTxZh3bzFgC67bUHACd1lLO03IZ7+VC
 fOBTfxxAHsiJ86nv0i4xCm6b3yBwQgEqoUUWTPD2sVTlRhzQMTOTgc1ZPjCqwZ+lnk8E
 hZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764701229; x=1765306029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TB7kgqvDgJRKLwRyCHojtHzbJ9g7pRARYcUzoRtozD8=;
 b=FPTBupGInXNSH4PehrQqCNK5rC+2ixtJZ1oX42kjt7j38qPiNyJ2M9ibFevsFmLlYJ
 E3eZreiyET9ZmrYk/6DJ/gdJBDc6u3uvjta43sZghCZvxmF8j5Y6KALnSWYUOAJazuGD
 VVXKZDGYOVfwh4JxM0TjceATjnfPAFv1hSz2gYGaPx3gUvC+ipAhLaCCfE+FHN5x4q3Z
 O0uJcZ/JnCtdcq8A5WG4+43bo0/2XM6GY5cB6Nl8iCu/vFLM2nxhGLTGxhpjQoRAN2pK
 +pCImyW6r04VRj8DrYUocZodbKN5dnoRL65mbMa4u1jLyFfk4srth5J0x/CvxKuCDabv
 J+hw==
X-Gm-Message-State: AOJu0Yz+sZvZHEPIQ1GNRqIBoKb13q/+KlPU5kLcQ0l4fsqAJVwggXcC
 vrkaq9BUl4XZGUeyEGOBaLFIiZJTEXgUNh3nWItlEWzpZ2erh9gRgtEhwIdMtkYFHHP42ATlNas
 RXNAPX4I=
X-Gm-Gg: ASbGnctaL48HU1f1iO/14jQEgT7gWdSWKyCTwibi/O1IRHDAK0wcGKTOchJbWJGf0MO
 P82uEwCGGgqR975AFhZyTsJJQtkgftKAw4EBrjyk/66PbCvLrrLvwqw9s+smegZIMVBcoyrQ0WP
 gwenbHnOPDl5BdSNeCtKq4e3EXdLxyzaEP2QK/W+z7WVxdICNYwloNL/QLynxwRs/tUZCJ8ETUN
 He7Hc2pISfVSXcG7VwmBAIH5KVX+R5BKEHDDEYdZePNyT3vdA83w7/uXbirQDv/T2/3nghLYfLB
 l8yXdPSoQwowYmHUZ+zMGw5NrxVwGquMU59gTk4SXI/VEbzq6/A4TfJBTqOWCTBSMtWMPaPB7Jd
 G94m/G4xw5xLizoqnu6jrQjl2FQ+5LlIkWnZKOYvaCt2/WUt3l0NsZ798RBamfrTbozn0cIDfY9
 APxKyAPECF4yHhuhw4oyMNGoZejiKRrPPKPxu31NZAZcgnjwSnPpwbVX9JZ2/e
X-Google-Smtp-Source: AGHT+IGb1mrddnkXLp8ccNaQ9wooTVWLi/M3ttx5Ol+f/NH95mhe62lQpKa814V55iMpcrMQjnh1Jw==
X-Received: by 2002:a05:600c:354c:b0:477:a977:b8c2 with SMTP id
 5b1f17b1804b1-47904ae7322mr340676355e9.13.1764701228910; 
 Tue, 02 Dec 2025 10:47:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a79761bsm4423405e9.2.2025.12.02.10.47.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 10:47:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.2 2/2] tcg/tci: Disable Int128 support
Date: Tue,  2 Dec 2025 19:46:53 +0100
Message-ID: <20251202184653.33998-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202184653.33998-1-philmd@linaro.org>
References: <20251202184653.33998-1-philmd@linaro.org>
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

Disable Int128 on TCI, otherwise build fails:

  In file included from ../../tcg/optimize.c:29:
  In file included from include/tcg/tcg-op-common.h:12:
  In file included from include/exec/helper-proto-common.h:10:
  In file included from include/qemu/atomic128.h:62:
  In file included from host/include/aarch64/host/atomic128-cas.h.inc:16:
  host/include/generic/host/atomic128-cas.h.inc:37:12: error: initializing 'Int128' (aka 'struct Int128') with an expression of incompatible type '__int128_t' (aka '__int128')
     37 |     Int128 old = *ptr_align;
        |            ^     ~~~~~~~~~~
  host/include/generic/host/atomic128-cas.h.inc:39:52: warning: incompatible pointer types passing 'Int128 *' (aka 'struct Int128 *') to parameter of type '__int128_t *' (aka '__int128 *') [-Wincompatible-pointer-types]
     39 |     while (!__atomic_compare_exchange_n(ptr_align, &old, new, true,
        |                                                    ^~~~
  host/include/generic/host/atomic128-cas.h.inc:39:58: error: passing 'Int128' (aka 'struct Int128') to parameter of incompatible type '__int128_t' (aka '__int128')
     39 |     while (!__atomic_compare_exchange_n(ptr_align, &old, new, true,
        |                                                          ^~~
  host/include/generic/host/atomic128-cas.h.inc:50:12: error: initializing 'Int128' (aka 'struct Int128') with an expression of incompatible type '__int128_t' (aka '__int128')
     50 |     Int128 old = *ptr_align;
        |            ^     ~~~~~~~~~~
  host/include/generic/host/atomic128-cas.h.inc:52:62: error: invalid operands to binary expression ('Int128' (aka 'struct Int128') and 'Int128')
     52 |     while (!__atomic_compare_exchange_n(ptr_align, &old, old & val, true,
        |                                                          ~~~ ^ ~~~
  host/include/generic/host/atomic128-cas.h.inc:63:12: error: initializing 'Int128' (aka 'struct Int128') with an expression of incompatible type '__int128_t' (aka '__int128')
     63 |     Int128 old = *ptr_align;
        |            ^     ~~~~~~~~~~
  host/include/generic/host/atomic128-cas.h.inc:65:62: error: invalid operands to binary expression ('Int128' (aka 'struct Int128') and 'Int128')
     65 |     while (!__atomic_compare_exchange_n(ptr_align, &old, old | val, true,
        |                                                          ~~~ ^ ~~~
  1 warning and 6 errors generated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d9293294d8e..692a62e6c18 100644
--- a/meson.build
+++ b/meson.build
@@ -2996,7 +2996,7 @@ config_host_data.set('CONFIG_ATOMIC64', cc.links('''
 
 # has_int128_type is set to false on Emscripten to avoid errors by libffi
 # during runtime.
-has_int128_type = host_os != 'emscripten' and cc.compiles('''
+has_int128_type = host_os != 'emscripten' and tcg_arch != 'tci' and cc.compiles('''
   __int128_t a;
   __uint128_t b;
   int main(void) { b = a; }''')
-- 
2.51.0


