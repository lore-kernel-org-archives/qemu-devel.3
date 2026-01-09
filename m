Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8211ED232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve65f-0001xf-Go; Fri, 09 Jan 2026 01:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve65e-0001u9-BJ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:35:18 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve65c-0007MJ-F2
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:35:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so42375935e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767940514; x=1768545314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYe5OM9n3hWR6ZPryFp5pgvfiahoglXKqPwtWMRKxsg=;
 b=KYDEgZ7Kz8rdr6o4c9RwgQN7pnYKVNvqZ/OJ5Ixs/QRFG/Xf76FodM6oN03n5rji05
 NfaLjicPMDN9/bqA9dl06GgH7CuIJ5vmOhABYrhjcCrreVUDer+c1ZHPsrA7u8Q5pRQt
 tpzP64VogAINDCJMbWqLda6Uf+S57JVjGwQUoYD+sV37vveOwDoetrW3t0BqsUJIQRwg
 MTML/MEKqwgiyebGULvRVHVmEKFjnjpOXS123+XS69TTGhdjosUI84W54JP2H1oLrA8O
 MAa5YvHxXVQD3Iz28Mq7azk0E68fjA24ewZp5s9HxEqYkpbvF2IPoZknrRh/GiCVRqh0
 ferA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767940514; x=1768545314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lYe5OM9n3hWR6ZPryFp5pgvfiahoglXKqPwtWMRKxsg=;
 b=MbtkK8STkaGIo3/k+slhIOYFuNs42KRVOiwZtXNjn323B0dPCoNmw0AL40Pf5mY8hy
 eL7jBDFkAleRBvPcPNtQ1mKx3hUeHZxgL6HAbvqlxQVfzHeyzuj4Xzctho2KPJ3Yr18j
 EYu1gCYTfiftkZ/rA/L84qDPrVuuCutKN3hjDF05vlQgJUdwe4RwRe2G5QUxz0b1xgqG
 xSZpM5aNuU/yQ8oVDuKfFE0CJlTxuTejPCBURtSDqUmRb2nMkQDqQsKjfrHcznynaNQy
 BMDf7OhhIIshbKQBtEdo/ML3hUVyZcQ73XBEkgNzlD9n+v+4Y5ffEGgz+JAvIeJNoKTJ
 P04Q==
X-Gm-Message-State: AOJu0YzqVurUGNUDUeK8ppcaYVgG/ks1T6Tg3B9GKiyP46jshiyhBvSm
 ySLM0tGuWS5TKbn1/6ldgk67SnrSIotiie0MFxaIWPyhSXKOKQpMrb5lx2kgd/hHs4bH2btrrSs
 VUd6hFoE=
X-Gm-Gg: AY/fxX4GC/Yk69fCT9iEpxlRDNKRvIWhxfDjAjgGsEUl+MW+btFCTmc94V9bB3vSIQT
 eeScQ3mG7uOBp98xNMnvJeGfm96IFAf4EDO+oUwraImuwPEp7/0jp00kRKMoe7B+u6J408uYuls
 xlVGZPK7mdmZPBtsN9AtZxTl4anAbQzPJdsBxAawOMkJ9dPVrlkmS/ghMNfG4dQGRzWoTixonI0
 YBG1ksZflVyAqmbTggluwesP4aEKnGL7RxgYrZMMMJw4iFza6DXKNRIlevVUZp/T1rbxYkn4k3s
 tS+KCSKREomMgNNkWzK5+Qf67V21YdcQpONp9eNiqxeFh0+7c7EFDQogpx7dwrjILwI9CutJrwF
 ys3UHzJkjM+lk6FTyb8iiwkz9cF/ReyYaZfy6tQQOkMgnVsGhp627k6QX10TxCKYq2pJQ6l9wxr
 ub/bCY6l+mGgZtvO1q8kZhL5Z1CEPPffH2HLA8W8tAtS4P8tj6pDfCQLQH41s1
X-Google-Smtp-Source: AGHT+IFqOU8/u+XVqW5AaXsguYp54q742aG4CDHtRjPgeGi4FlEsFtkwyqEWp4ZRAX2+ZAdVLh8qCg==
X-Received: by 2002:a05:600c:3143:b0:47d:4fbe:e6cc with SMTP id
 5b1f17b1804b1-47d84b179f7mr105791515e9.13.1767940513669; 
 Thu, 08 Jan 2026 22:35:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41f5e0sm186116365e9.8.2026.01.08.22.35.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 22:35:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/4] docs/devel/loads-stores: Clarify regexp are POSIX
 basic ones
Date: Fri,  9 Jan 2026 07:35:01 +0100
Message-ID: <20260109063504.71576-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109063504.71576-1-philmd@linaro.org>
References: <20260109063504.71576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

While git-grep uses POSIX basic regexp by default, git-config
can select a distinct one. Add the '-G' (--basic-regexp)
argument to be sure our regexps work on first try.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/loads-stores.rst | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index c906c6509ee..fc78def0612 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -63,7 +63,7 @@ which stores ``val`` to ``ptr`` as an ``{endian}`` order value
 of size ``sz`` bytes.
 
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<ld[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
  - ``\<st[bwlq]\(_[hbl]e\)\?_p\>``
  - ``\<st24\(_[hbl]e\)\?_p\>``
@@ -120,7 +120,7 @@ store: ``cpu_st{size}{end}_mmu(env, ptr, val, oi, retaddr)``
  - ``_be`` : big endian
  - ``_le`` : little endian
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<cpu_ld[bwlq]\(_[bl]e\)\?_mmu\>``
  - ``\<cpu_st[bwlq]\(_[bl]e\)\?_mmu\>``
 
@@ -154,7 +154,7 @@ store: ``cpu_st{size}{end}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
  - ``_be`` : big endian
  - ``_le`` : little endian
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_mmuidx_ra\>``
  - ``\<cpu_st[bwlq]\(_[bl]e\)\?_mmuidx_ra\>``
 
@@ -192,7 +192,7 @@ store: ``cpu_st{size}{end}_data_ra(env, ptr, val, ra)``
  - ``_be`` : big endian
  - ``_le`` : little endian
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_data_ra\>``
  - ``\<cpu_st[bwlq]\(_[bl]e\)\?_data_ra\>``
 
@@ -231,7 +231,7 @@ store: ``cpu_st{size}{end}_data(env, ptr, val)``
  - ``_be`` : big endian
  - ``_le`` : little endian
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_data\>``
  - ``\<cpu_st[bwlq]\(_[bl]e\)\?_data\+\>``
 
@@ -265,7 +265,7 @@ load: ``cpu_ld{sign}{size}_code(env, ptr)``
  - ``l`` : 32 bits
  - ``q`` : 64 bits
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<cpu_ld[us]\?[bwlq]_code\>``
 
 ``translator_ld*``
@@ -296,7 +296,7 @@ swap: ``translator_ld{sign}{size}_swap(env, ptr, swap)``
  - ``l`` : 32 bits
  - ``q`` : 64 bits
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<translator_ld[us]\?[bwlq]\(_swap\)\?\>``
 
 ``helper_{ld,st}*_mmu``
@@ -325,7 +325,7 @@ store: ``helper_{size}_mmu(env, addr, val, opindex, retaddr)``
  - ``l`` : 32 bits
  - ``q`` : 64 bits
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<helper_ld[us]\?[bwlq]_mmu\>``
  - ``\<helper_st[bwlq]_mmu\>``
 
@@ -382,7 +382,7 @@ succeeded using a MemTxResult return code.
 
 The ``_{endian}`` suffix is omitted for byte accesses.
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<address_space_\(read\|write\|rw\)\>``
  - ``\<address_space_ldu\?[bwql]\(_[lb]e\)\?\>``
  - ``\<address_space_st[bwql]\(_[lb]e\)\?\>``
@@ -400,7 +400,7 @@ Note that portions of the write which attempt to write data to a
 device will be silently ignored -- only real RAM and ROM will
 be written to.
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``address_space_write_rom``
 
 ``{ld,st}*_phys``
@@ -438,7 +438,7 @@ device doing the access has no way to report such an error.
 
 The ``_{endian}_`` infix is omitted for byte accesses.
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<ldu\?[bwlq]\(_[bl]e\)\?_phys\>``
  - ``\<st[bwlq]\(_[bl]e\)\?_phys\>``
 
@@ -460,7 +460,7 @@ For new code they are better avoided:
 
 ``cpu_physical_memory_write``
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<cpu_physical_memory_\(read\|write\)\>``
 
 ``cpu_memory_rw_debug``
@@ -495,7 +495,7 @@ make sure our existing code is doing things correctly.
 
 ``dma_memory_rw``
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<dma_memory_\(read\|write\|rw\)\>``
  - ``\<ldu\?[bwlq]\(_[bl]e\)\?_dma\>``
  - ``\<st[bwlq]\(_[bl]e\)\?_dma\>``
@@ -536,7 +536,7 @@ correct address space for that device.
 
 The ``_{endian}_`` infix is omitted for byte accesses.
 
-Regexes for git grep:
+Regexes for git grep -G:
  - ``\<pci_dma_\(read\|write\|rw\)\>``
  - ``\<ldu\?[bwlq]\(_[bl]e\)\?_pci_dma\>``
  - ``\<st[bwlq]\(_[bl]e\)\?_pci_dma\>``
-- 
2.52.0


