Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A466CAC5BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RkV-0001gq-Vt; Tue, 30 Sep 2025 00:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RkR-0001eZ-SE
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:13:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RkK-0000jU-ST
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:13:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso40466615e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205621; x=1759810421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJyVnOWNCddCGl/+ypfUNoAsZWxoJ+Iw1ZeRnG+UY2M=;
 b=QPnDMS67UqHeorTvQwwGCH4gO5Q+8a491/aL+YdKLcPvtHJono3Il3R4NrRJjbbavr
 zRdwHY8kXEsWyx8pdotl3l0hAU6DGmAgxJs628zd0e7FnO+XmUgxe+VfG7jMTTa+wNOb
 GVpcSRnUbZPo3c7M2Rr8DXWat6amodkon+5okJBGAEuTHYg/fFfsDTkU18Iuh2Lkz1PP
 H40zfDz50qt54BddudYf2wMBJ3wY5rEt3DJ+sR/x6w7u7pglVa5fTygeeYOKxhpe+BGU
 n7IS4RsU+BdaH+tnTpeAg3kQO/DAtK73w5sil9/q9FyOVTV+gmQC9F949Tbj+Nxkq6uI
 GVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205621; x=1759810421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJyVnOWNCddCGl/+ypfUNoAsZWxoJ+Iw1ZeRnG+UY2M=;
 b=fPyXhLhUQEThOC5SX+Q85drRT6QE9uuvxi2tWEnrE6G9PARBTfuSfAh51TrOR0LaO4
 1OwC8KOZNVrANDzXv/89/JA7jZRPgsePIa9zukHImuYhGq8wj4ClikXuQo+mLflOKCFV
 MhUHLArBq6eWGO9haoj8qfX/GRs7Rfaj4EpSP0pAOPpkt8lKhQ4Kj7yYVGtF8AhCsBeH
 x3GKQCU+Q08d2qM8bp9n6+9+V6DbT32WWmmzUluNFQpmlti73wp2DMZqamm9T5bhha9/
 PMKrq6H/IGfmAw/E+D8o40SxCM0Y0NHPxc+2x8/v+8pNXcFgo5Ycgw4MJaQuxA0LIke/
 zO6Q==
X-Gm-Message-State: AOJu0YyD8ANfca8FJlawh9RN8UxyvnYp7cPr8zh3LM9029m3ul39+Ra0
 SH6TUsOV82oxMAURn5QNBQqqm/P8H5QRdGtbC2eeumRCIUEIfRoFBXTOGyoI5EZcO5qX50Qeo5J
 SQjGGu5YWashz
X-Gm-Gg: ASbGncs172sN7Ppnowyr/CSai2eKd4WMKL3on8b0P1Y1rceosAsgQMzq441pueMFHUB
 3fUmnWh71U85z8ZYyffQFgSmEsL5uiKBNwnOaJy3sf4IChF0cqOZF2d5sMz/jpgwfo844sg01ac
 pK2nKKsega2wMyFzfYhmZrmrB0PyOxiyu2tkl3HuhOiONGAuhY53kx3IJbmmKJeGHNcFLIJ0Jjk
 7U6d9w5Rpa7vBzZX/lWU+XB7hgXeegMx7HfXSXAMFjNCPMRtXcm8qXPZ4Q/Rq7mWiETYlDAkywu
 JK3HiRFVaVxs179rLu/+PGO1pSLWs7llXGTD8k1yDXthcSrmCHfLmK8D2EfRgT7D3Jd3ljGpJ0I
 bIugNkBS47isxy7DA5pp5NjNlhZeXl0ypjTzm8sDDlroJVCBWmP7MTzn7rx7hFACHnyFdKo0S30
 hkKsbvgpnW06ejTK/+InrQ
X-Google-Smtp-Source: AGHT+IEBLGmPjHaV6MityTIXBSpNltcXVYjuhb00aWpIbO25PxYLKS/w9T+ltaJf/K1UbWKlm67UDQ==
X-Received: by 2002:a05:600c:4ec6:b0:46c:7097:6363 with SMTP id
 5b1f17b1804b1-46e329b441cmr166612445e9.13.1759205620914; 
 Mon, 29 Sep 2025 21:13:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3dbcfsm38006405e9.3.2025.09.29.21.13.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:13:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 02/17] system/memory: Better describe @plen argument of
 flatview_translate()
Date: Tue, 30 Sep 2025 06:13:10 +0200
Message-ID: <20250930041326.6448-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

flatview_translate()'s @plen argument is output-only and can be NULL.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h | 5 +++--
 system/physmem.c        | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index aa85fc27a10..3e5bf3ef05e 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2992,13 +2992,14 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
  * @addr: address within that address space
  * @xlat: pointer to address within the returned memory region section's
  * #MemoryRegion.
- * @len: pointer to length
+ * @plen_out: pointer to valid read/write length of the translated address.
+ *            It can be @NULL when we don't care about it.
  * @is_write: indicates the transfer direction
  * @attrs: memory attributes
  */
 MemoryRegion *flatview_translate(FlatView *fv,
                                  hwaddr addr, hwaddr *xlat,
-                                 hwaddr *len, bool is_write,
+                                 hwaddr *plen_out, bool is_write,
                                  MemTxAttrs attrs);
 
 static inline MemoryRegion *address_space_translate(AddressSpace *as,
diff --git a/system/physmem.c b/system/physmem.c
index 8a8be3a80e2..2d1697fce4c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -566,7 +566,7 @@ iotlb_fail:
 
 /* Called from RCU critical section */
 MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
-                                 hwaddr *plen, bool is_write,
+                                 hwaddr *plen_out, bool is_write,
                                  MemTxAttrs attrs)
 {
     MemoryRegion *mr;
@@ -574,13 +574,13 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
     AddressSpace *as = NULL;
 
     /* This can be MMIO, so setup MMIO bit. */
-    section = flatview_do_translate(fv, addr, xlat, plen, NULL,
+    section = flatview_do_translate(fv, addr, xlat, plen_out, NULL,
                                     is_write, true, &as, attrs);
     mr = section.mr;
 
     if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs)) {
         hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
-        *plen = MIN(page, *plen);
+        *plen_out = MIN(page, *plen_out);
     }
 
     return mr;
-- 
2.51.0


