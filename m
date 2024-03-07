Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDB1C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCcl-0001Yc-7Y; Thu, 07 Mar 2024 07:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCch-0001YF-Dk
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:13:19 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCcd-0008Rp-2t
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:13:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33e6aca1ca9so186006f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 04:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709813592; x=1710418392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9jKcNU8mtddf0xD96048JENdNgxkV5RZUTuB2JvZ3Dk=;
 b=AQnbdTD68ea+zEn5TKotv4T3qzUL2boqStW0b+62GFUKYr+aMUElzDtRRk3kA6st9y
 cieyqPDLeAAsL6P436Y5ENyZK/ieelMuxhKGVKe/JvO2jv69qKb5RmcFeZFLJLyujF+Z
 KOp1QUEZfXeBHyzpAPaMsdmMvswFsJaymH9WlWju33thMVce8DUFBRKHR10UjPnk9f6M
 104G2m++IK5MqqspBiIPFkSv6oGdK7t6Pyz+z8gZoD1j1KbRrIXKUCfwGtVYwlvJWx1b
 /JuA1AOZ7H58rcOSKC5h9CeTPa3J+jk/xjVY3FyOgg7zTvhFVRxbrUYu6P0GJtyX7FGC
 Ltjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709813592; x=1710418392;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9jKcNU8mtddf0xD96048JENdNgxkV5RZUTuB2JvZ3Dk=;
 b=bRUDn1UYiQ+1OGDlBPX9YrRmjZq/RoJ2JdvI8Wpyy1sasxDtQmXdavxkiYVla+a3Ot
 /IXKnooS5k1FD/rEurHukSHydPHfUMYBR6Kxl02ARhQZRgVfL4ld+oAAvGEGIwcj47LB
 UajTsvS4rXInpyPPHnB+sXUfZhfr2POANZfip+ddHLCULsYZta1nTTgOeGSQSoIKy22U
 p+aMrlpB2PbHxB5hfQSk4LjIAvnaNn/gIwAoHWCM5hg44EYfIAm+WrHSbR7nzMtP7nS2
 vTVYGyd+yluwF8LW1jAo2h/e3flQ0L88QH8MreIpktKuZcZgiSd7oDHe8pRI5ynSL/dQ
 icAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwFZk9qgsIcKWlh/V/5o0HjARlULw8b4k/rr8kREEatYJR1ovdQbN8CY+46X9dYi3fWs/KRCueyatuACNok3UtpMZKx0w=
X-Gm-Message-State: AOJu0YwpAZ2MkS+m/3V5YdkRx6ef82TMWe7U9fgp30R1r7H7i5+Qbdrh
 CsWvV65YOeu1EUrAuIrr0M4LCxUkbCbG+qnasplg56kw9YsrLTx4joHIhuN4eCA=
X-Google-Smtp-Source: AGHT+IEZSbHZqEkiGm8ptHFul1KfAi5rGSBCKI8+od071N4EROSygV23LA7LHPIPhTI5uqeuF0rSog==
X-Received: by 2002:a5d:64af:0:b0:33e:5310:820f with SMTP id
 m15-20020a5d64af000000b0033e5310820fmr5236522wrp.67.1709813592443; 
 Thu, 07 Mar 2024 04:13:12 -0800 (PST)
Received: from meli.delivery (adsl-101.37.6.0.tellas.gr. [37.6.0.101])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a5d59c7000000b0033e475940fasm7826319wry.66.2024.03.07.04.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 04:13:12 -0800 (PST)
Date: Thu, 07 Mar 2024 14:11:03 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-arm@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH-for-9.0 9/9] hw/xen/hvm: Inline xen_arch_set_memory()
User-Agent: meli 0.8.5-rc.3
References: <20231114163123.74888-1-philmd@linaro.org>
 <20231114163123.74888-10-philmd@linaro.org>
In-Reply-To: <20231114163123.74888-10-philmd@linaro.org>
Message-ID: <9z8lx.2kzq0em3zqbp@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 14 Nov 2023 18:31, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>xen_arch_set_memory() is not arch-specific anymore. Being
>called once, inline it in xen_set_memory().
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> include/hw/xen/xen-hvm-common.h |   3 -
> hw/xen/xen-hvm-common.c         | 104 ++++++++++++++++----------------
> 2 files changed, 51 insertions(+), 56 deletions(-)
>
>diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
>index 536712dc83..a1b8a2783b 100644
>--- a/include/hw/xen/xen-hvm-common.h
>+++ b/include/hw/xen/xen-hvm-common.h
>@@ -99,8 +99,5 @@ void cpu_ioreq_pio(ioreq_t *req);
> 
> void xen_read_physmap(XenIOState *state);
> void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req);
>-void xen_arch_set_memory(XenIOState *state,
>-                         MemoryRegionSection *section,
>-                         bool add);
> 
> #endif /* HW_XEN_HVM_COMMON_H */
>diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
>index 50ce45effc..789c6b4b7a 100644
>--- a/hw/xen/xen-hvm-common.c
>+++ b/hw/xen/xen-hvm-common.c
>@@ -426,50 +426,6 @@ void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
>     }
> }
> 
>-void xen_arch_set_memory(XenIOState *state, MemoryRegionSection *section,
>-                         bool add)
>-{
>-    unsigned target_page_bits = qemu_target_page_bits();
>-    int page_size = qemu_target_page_size();
>-    int page_mask = -page_size;
>-    hwaddr start_addr = section->offset_within_address_space;
>-    ram_addr_t size = int128_get64(section->size);
>-    bool log_dirty = memory_region_is_logging(section->mr, DIRTY_MEMORY_VGA);
>-    hvmmem_type_t mem_type;
>-
>-    if (!memory_region_is_ram(section->mr)) {
>-        return;
>-    }
>-
>-    if (log_dirty != add) {
>-        return;
>-    }
>-
>-    trace_xen_client_set_memory(start_addr, size, log_dirty);
>-
>-    start_addr &= page_mask;
>-    size = ROUND_UP(size, page_size);
>-
>-    if (add) {
>-        if (!memory_region_is_rom(section->mr)) {
>-            xen_add_to_physmap(state, start_addr, size,
>-                               section->mr, section->offset_within_region);
>-        } else {
>-            mem_type = HVMMEM_ram_ro;
>-            if (xen_set_mem_type(xen_domid, mem_type,
>-                                 start_addr >> target_page_bits,
>-                                 size >> target_page_bits)) {
>-                DPRINTF("xen_set_mem_type error, addr: "HWADDR_FMT_plx"\n",
>-                        start_addr);
>-            }
>-        }
>-    } else {
>-        if (xen_remove_from_physmap(state, start_addr, size) < 0) {
>-            DPRINTF("physmapping does not exist at "HWADDR_FMT_plx"\n", start_addr);
>-        }
>-    }
>-}
>-
> void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
>                    Error **errp)
> {
>@@ -512,20 +468,62 @@ static void xen_set_memory(struct MemoryListener *listener,
>                            bool add)
> {
>     XenIOState *state = container_of(listener, XenIOState, memory_listener);
>+    unsigned target_page_bits = qemu_target_page_bits();
>+    int page_size = qemu_target_page_size();
>+    int page_mask = -page_size;
>+    hwaddr start_addr;
>+    ram_addr_t size;
>+    bool log_dirty;
>+    hvmmem_type_t mem_type;
>+
> 
>     if (section->mr == &xen_memory) {
>         return;
>-    } else {
>-        if (add) {
>-            xen_map_memory_section(xen_domid, state->ioservid,
>-                                   section);
>-        } else {
>-            xen_unmap_memory_section(xen_domid, state->ioservid,
>-                                     section);
>-        }
>     }
> 
>-    xen_arch_set_memory(state, section, add);
>+    if (add) {
>+        xen_map_memory_section(xen_domid, state->ioservid,
>+                               section);
>+    } else {
>+        xen_unmap_memory_section(xen_domid, state->ioservid,
>+                                 section);
>+    }
>+
>+    if (!memory_region_is_ram(section->mr)) {
>+        return;
>+    }
>+
>+    log_dirty = memory_region_is_logging(section->mr, DIRTY_MEMORY_VGA);
>+
>+    if (log_dirty != add) {
>+        return;
>+    }
>+
>+    start_addr = section->offset_within_address_space;
>+    size = int128_get64(section->size);
>+    trace_xen_client_set_memory(start_addr, size, log_dirty);
>+
>+    start_addr &= page_mask;
>+    size = ROUND_UP(size, page_size);
>+
>+    if (add) {
>+        if (!memory_region_is_rom(section->mr)) {
>+            xen_add_to_physmap(state, start_addr, size,
>+                               section->mr, section->offset_within_region);
>+        } else {
>+            mem_type = HVMMEM_ram_ro;
>+            if (xen_set_mem_type(xen_domid, mem_type,
>+                                 start_addr >> target_page_bits,
>+                                 size >> target_page_bits)) {
>+                DPRINTF("xen_set_mem_type error, addr: "HWADDR_FMT_plx"\n",
>+                        start_addr);
>+            }
>+        }
>+    } else {
>+        if (xen_remove_from_physmap(state, start_addr, size) < 0) {
>+            DPRINTF("physmapping does not exist at "HWADDR_FMT_plx"\n", start_addr);
>+        }
>+    }
> }
> 
> void xen_region_add(MemoryListener *listener,
>-- 
>2.41.0
>
>


Same observation as in previous patch, in Arm xen, qemu doesn't handle 
memory, it is only responsible for devices and their memory.

