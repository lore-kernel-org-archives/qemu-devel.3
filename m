Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57ACC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFJY-00053b-Qu; Mon, 17 Mar 2025 14:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFJB-0004kk-RH
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIV-0006AA-4m
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:29 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-225fbdfc17dso32762515ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742236470; x=1742841270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wT5ohu0Ui7xrH+jgYqMJMpKemGPcZNvy7jzdyuAyzEs=;
 b=mMxRwKruY5z7V/XDapsbBm3uimBKs+VaKDFV5vgMOCrDNgAQIh138Bh3STmsUNgwaW
 +7lflS7MsI17sNBZ1VLuJMEePYrmOqj6eupWL/LH1382Rhpf8W4+frp3ivWnGlet7J0M
 oSkeYsT+SoQyqFvejHO5ugUzadfSBCsn4bLksf2qUDHSVp0PplDKw+NmIPaqf3n2zMuE
 2e7EsXFVrC4Q4wZrtZbEV/O1YcVqH/AGv7U74mCxjQwW1XMwAFLnDgK7JOOtXm0Cw2VQ
 j+Zu8pG74kDXQFiYF/WrKcvPq/KE0ePk+44EwTKvp3sj6IpKdh9xT73schu0UayVzW5A
 Rfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236470; x=1742841270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wT5ohu0Ui7xrH+jgYqMJMpKemGPcZNvy7jzdyuAyzEs=;
 b=wugwDYb0toUuLRyQgAqixZGMUlbNpP6u1XUfzJPF/WigwnNItGVHW0ykF7YTC7UbI/
 5DWBnXGHZKI1syvnGcMpZ1wJmcnjp75ept6kV5Uq2IU4KcyVpteOe0n1wm+2NbvcUS5a
 fy3F0NivBVa/aQlEWj+RQr3zhqfp4zFtmkF8m/WfQiqci8hOagoKYhEVJ9I4Au/nzAPI
 /lL69X1nJRcZ1BIUqLJZ348Fnk7xzONwXZPm4E2XIwXLrm6RK2+Q8BK3KMEdO6G3yPoC
 0EQl3IgS9Gel80XuQBPIvSUHurcuCQ+NYeNvDdkMqzDlzhehi23VdL7MAd8T+2zK1VTQ
 5Ktw==
X-Gm-Message-State: AOJu0YzqjxEBOl+PoZfbIx/apfWgpaBATs5xwrtrYePACE6/DzT/9NsO
 WWBTyc2ptzugsgAi7vXegAT3cEbRYZvfv/PNmaX/ttlURPCBC4KR+IGZfVf/+ufdjGgXhOKKSHA
 n
X-Gm-Gg: ASbGncu3zt34j4oe4Szz43G1yNcUAFJlgqga31YdsvcOnqM01mcLnJHvTEygo9AqZJi
 VadVTvVNAJ1P1IhRXJd94CyfLpf+IFxcZUXGqVOBPbe7smjVScPDcjcN7d4OFxPnwQWdrpZk2QR
 KRQfU13arqyilntogkJ1+h1dbU1yKCVV8T3dWfz9sNnBlxgp979Gc66OYszGkHce+tHlsqpZK7/
 0pmbt8Ny0LLSR0yWGED1+h+o62Xv4BimRU4kPkcE0Qv7L8x4dCQOIHbXLtICWLV8kRYxHad0Dd/
 7t45QOVrQ97niIvRIcgaIiT+cimEsXYNJZgPo/BG6suw
X-Google-Smtp-Source: AGHT+IHwzlIJ6LxZBvPsjg5l1kKbXhEFWIu9N9qHSrE9Y+TBbc5aw9FWPh64Zl9aShUUkawUwyHzSA==
X-Received: by 2002:a17:903:22c8:b0:223:517c:bfa1 with SMTP id
 d9443c01a7336-225e0af0323mr191813145ad.38.1742236470577; 
 Mon, 17 Mar 2025 11:34:30 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695a2esm8188770b3a.144.2025.03.17.11.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 11:34:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Xu <peterx@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 05/18] exec/memory.h: make devend_memop "target defines"
 agnostic
Date: Mon, 17 Mar 2025 11:34:04 -0700
Message-Id: <20250317183417.285700-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index da21e9150b5..069021ac3ff 100644
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


