Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A30CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wSG-0003TQ-1B; Sat, 04 Oct 2025 03:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSE-0003TG-BG
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSC-0004sC-FP
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e3ea0445fso16138535e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759561994; x=1760166794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2oFcbpC1HbyDEsYpWRFg4rvw0CXXpnj78gi8Ht8cJ6A=;
 b=aHOaXT+MHiQJtG3fOmrHlWIXdeXtBU/qjLUzOoQQhVJK7yPsDORdBvr5n4DspJpWWC
 o1xuciaMleDQDEoIQAIrl+uBUkoH4f3WQTezQkzLCywSiUaKtI4B9dJKuZMbvkLKPDAz
 JKlBKdX7ZZbBUnJ4D4LOFPMjb9zNTT5ZkgEVaREJlVeYH66/3UK/rygrUoyz5K2fVnnR
 J0RsdEnKneHeZDsMSXZS1NqRz4iQkqenEXTqBlYqQX9nThNucNyh4ildZlY2sUqzRxKy
 dqDCHyn24vgQ+eXbU6uXpinyb3oiveCtrOdhFXYLkrCut9iHK7F3DYtXV9oxkmC4THPJ
 WqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759561994; x=1760166794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oFcbpC1HbyDEsYpWRFg4rvw0CXXpnj78gi8Ht8cJ6A=;
 b=Bmlh19P7WlodiVjsmLHqar4rKRWUbOB2PcQEDtmgJcKnQOuxb51DWjJ36X1d0ukc08
 Gz5ka39WBERYawYS8TM0Vn0sDtbjI1g/Zsk/6/37+RFL14bak8UMu/pvx1+a3Uzx5gIX
 d5jW7Nvx3pTjRQbdClJUoepXpce9ZdDor28P4Y6u+KbnlN/Lz/M1qPKg0y4Q452UUM2x
 ZYOthgNRGZD6V/JH3G2ndjkd/JkK7vxKPLnUoEWVKvhWec63I/rDwcHKoPTWjm/ObeLL
 yAbpXhwmfHvjPXLY38Xs4v8BAe3kG4Xgy0gbwKqJvKAQmN53RNNUO2NzBvwkYx7VoeRK
 cCSA==
X-Gm-Message-State: AOJu0Yx6cQSfD9WSn6qdrR12oCPNoDgqvOUIpkpIg99VKGzk/04E6loO
 eudzEWmGHxlSnIfztv+cmnY0+lxr7i7pACBRk9LrGMaQ6vdxB52trrlrDnexLyhyVKI00ZWaQBZ
 J9Orot59pkw==
X-Gm-Gg: ASbGncsDPtwliXXBOe6HZbl19N7rvUkIyvYVvbRb/rF6BCDXTDSAp4lc30Q5wKUCUOa
 RlnTXl/MoYao4Eb3hSsA5u6r4/0170sJ5Z9wzaBhC7YFd2A9m3hAVdoTkBltx0EVfCr2ffmLrTH
 diwnW2cylESRsNSfU/kGPUAqrb61HUtq6SqhyeJEmlWgC5xF/zJA/9OaimXrFfAFr8Q+mWfE3ji
 +inkH7GM7bwXNU52Pt4ic25hQBTfZ58Tv5Dw1M1vj91tCkPoSYbPsjJYwd58P6M3R/PDt3+GeMB
 hjseJzNQPJLZl0Y6IbiEhtJJg0FnguUkrNJXWTrLB5U9DoRyESU+kkB+wJ291OU/Gp5REIrUltn
 cMEc+8zQrpDmLI9sN/kexdSdvZ6ZXcInPm20U0+5dSdOS3yz4IyT9Ye62osXOsJnmtHKroeb4XR
 bMeViUPVxkGSGVrzEU04NwP5c2
X-Google-Smtp-Source: AGHT+IHvnVZ2CAJ58MuI6gpXLO0Quh9sEhL9jNFk31p456DPxyok2lHrKpVtgvyzrNeDZGmBKcOipw==
X-Received: by 2002:a05:600c:4f93:b0:46e:5cb5:20df with SMTP id
 5b1f17b1804b1-46e7110f0famr49145195e9.16.1759561994079; 
 Sat, 04 Oct 2025 00:13:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a020a3sm160888675e9.10.2025.10.04.00.13.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:13:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/41] system/ramblock: Remove obsolete comment
Date: Sat,  4 Oct 2025 09:12:27 +0200
Message-ID: <20251004071307.37521-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
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

This comment was added almost 5 years ago in commit 41aa4e9fd84
("ram_addr: Split RAMBlock definition"). Clearly it got ignored:

  $ git grep -l system/ramblock.h
  hw/display/virtio-gpu-udmabuf.c
  hw/hyperv/hv-balloon.c
  hw/virtio/vhost-user.c
  migration/dirtyrate.c
  migration/file.c
  migration/multifd-nocomp.c
  migration/multifd-qatzip.c
  migration/multifd-qpl.c
  migration/multifd-uadk.c
  migration/multifd-zero-page.c
  migration/multifd-zlib.c
  migration/multifd-zstd.c
  migration/multifd.c
  migration/postcopy-ram.c
  system/ram-block-attributes.c
  target/i386/kvm/tdx.c
  tests/qtest/fuzz/generic_fuzz.c

At this point it seems saner to just remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Message-Id: <20251002032812.26069-2-philmd@linaro.org>
---
 include/system/ramblock.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 87e847e184a..8999206592d 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -11,11 +11,6 @@
  *
  */
 
-/*
- * This header is for use by exec.c and memory.c ONLY.  Do not include it.
- * The functions declared here will be removed soon.
- */
-
 #ifndef SYSTEM_RAMBLOCK_H
 #define SYSTEM_RAMBLOCK_H
 
-- 
2.51.0


