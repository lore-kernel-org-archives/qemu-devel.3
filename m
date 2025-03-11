Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F31FC2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqwM-0003gV-Tz; Tue, 11 Mar 2025 00:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvV-0003Kw-Hb
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:10 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvS-0006R2-PE
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:09 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fec13a4067so7695711a91.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 21:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741666143; x=1742270943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igRm5DauylZU7kF6A9LJbRIXn+glPoGkFsEjcODvlvM=;
 b=LaAhm2BVRNUDJAYX00fcWJKDpIVK4g+BjUmoxtIXm6ldMF5aSksYUBkz+CQ4eVqIgY
 lv3RxX3+cBQY9SDKwqDcNc/SihQ7UV7/a6WTkoCraOiiLO4HOM1IQy6qKQDHda4PZZa/
 TzJYUuIxt5rXw7UjqoqGr66iZ7+zLw1eeK53I0QseZuwdiRj8XZkdQPyyqu2j/phsix4
 TimnQ512Boc1dSmtw2vj2xpwW9OZfvdp8c3OWGv9qfw8B1CvR+N0V5VL4DAF626E2YyA
 eK32QV+JzmvE/9lMzHmi1RKyum5mPh/CSJHXnxANTVyZSVp37XpBbCCkHNTMwXh54qrH
 o+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741666143; x=1742270943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igRm5DauylZU7kF6A9LJbRIXn+glPoGkFsEjcODvlvM=;
 b=VxeZAPtRTU1kAaF/PuMtr2R72OVeC3ZF4MmGFu38T+AKyHw3U6tLlbaE1sBologciw
 y0wAfoKPQgaZpPNltS+H47aJA79ZNkooA4i6AmayNwSfnmvWPFNMCXdGR/J3qFA4GH+i
 tK5QNvM79pDvBcundXsMftkAMASTsuFJV6mD4jfmTL6d+m/H68E4F0DANT/kvd87QzSy
 X5JsG1jgRMePoDsYC1nvF9d3gdYsuB9REsPgA2efkB3gfm+k0v1//+SOYXiczg5LkkNV
 xwsjIUHw70PIh4cBNaktE2mEX0KbdTrEKu2Cn4Op72G9zyuWl8DS1+Nk5tBANC527lXA
 rSVQ==
X-Gm-Message-State: AOJu0Yy6w0uEWTAZLBG5C+6zlGwhEuEkciQ3ci3mz/furFdm9MAbLoHZ
 3/Q37iIfu2yecv6n5CRmnBvP9H8ZSTJBA4jC1sOTCUyGXh3PjYygZsZ4iCwzeICqjAVXBPs+dnX
 NlMY=
X-Gm-Gg: ASbGncu4cVZW1eJMHgdaSwMEm2TkpW3Wf4hElvgruoGp60/nB7DzJGeIHSpbRTAAZXh
 N+P/BJIuPWWNV3iGcwYec6FwVkSUKCL2pqlu6FHOXz5CbbZFhMt3WdnzrJId8F49v4uoH1NpuQ5
 +svT/PlaszQKhGBC5HYvuLkVH0UnR4w6E9+CueV2cWCfIcsGzFk5PTn1pV/A1iUoSzVAe0+6X0j
 yBRNOR2GwigP/QJre6U9kIBitOkX95qB/TOE9mTchYyTL9UrxqHDp9PN5KLAY+yIZWfXi9ys7WM
 cB0IGFuZZLaCTBwN9yDQB9LnyMPj/8UxcCl9HPGCjOEF
X-Google-Smtp-Source: AGHT+IHqGisSQCK+iGHuI44FF+Puo0WshM2hC7DuGryTfuE/I3BKO7cRhsCQCZNyA9pqBEuzvyba5w==
X-Received: by 2002:a05:6a21:3a85:b0:1f3:40a9:2c36 with SMTP id
 adf61e73a8af0-1f58cb20502mr3303668637.10.1741666142929; 
 Mon, 10 Mar 2025 21:09:02 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28c0339cesm7324454a12.46.2025.03.10.21.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 21:09:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 05/16] exec/memory.h: make devend_memop "target defines"
 agnostic
Date: Mon, 10 Mar 2025 21:08:27 -0700
Message-Id: <20250311040838.3937136-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Will allow to make system/memory.c common later.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index ff3a06e6ced..60c0fb6ccd4 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3138,25 +3138,17 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-#ifdef COMPILING_PER_TARGET
 /* enum device_endian to MemOp.  */
 static inline MemOp devend_memop(enum device_endian end)
 {
     QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
                       DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
 
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
-    /* Swap if non-host endianness or native (target) endianness */
-    return (end == DEVICE_HOST_ENDIAN) ? 0 : MO_BSWAP;
-#else
-    const int non_host_endianness =
-        DEVICE_LITTLE_ENDIAN ^ DEVICE_BIG_ENDIAN ^ DEVICE_HOST_ENDIAN;
-
-    /* In this case, native (target) endianness needs no swap.  */
-    return (end == non_host_endianness) ? MO_BSWAP : 0;
-#endif
+    bool big_endian = (end == DEVICE_NATIVE_ENDIAN
+                       ? target_words_bigendian()
+                       : end == DEVICE_BIG_ENDIAN);
+    return big_endian ? MO_BE : MO_LE;
 }
-#endif /* COMPILING_PER_TARGET */
 
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
-- 
2.39.5


