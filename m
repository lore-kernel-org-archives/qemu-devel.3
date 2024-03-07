Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427C5C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCFE-00058p-8M; Thu, 07 Mar 2024 06:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCFB-00057Y-Sh
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:49:01 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCFA-0008Q2-B7
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:49:01 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-413131d40f4so1535025e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 03:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709812139; x=1710416939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=G/SbbEMUCs/VycRuaZQyQX/2EumGC/JTHxyB6vdSb1o=;
 b=qt5v3AjDbin5KRRelugwE7u1bl9j6wai4BnQbvaDpbub1yJQX8ZceL8gg5uvtQtuDY
 1/DXz1UCi4A/PgL86CK7rS2ON5aMB8fPIw1+GvKS9I5UqqqgwZSVkg03Fje88/YeEyCH
 gL9zzCBYPk02pVSNksLmZwoVgxiiJttXTzB2LQG8ewMMXLCmHl2fgF3Msj2C1x39RUCy
 puJJv3Rr3jsD9Oxv5LpLM175mXCAyEt8mCbp5MtoKOZbpoUPJnL2bJDjk/mtsaviu123
 NVaoSLhPeENEl9IMH+vdjazDPtZ/lYhYZGMdzo+UZyI1ZhZo65LbPmLczijMu2qLK/ie
 0CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709812139; x=1710416939;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G/SbbEMUCs/VycRuaZQyQX/2EumGC/JTHxyB6vdSb1o=;
 b=FjWnG+0Q5910ihTDHa9/M5L7o6AMc1V0q/b8pTrR7sqj1ygHBtcD0GDFqWMm5W0oaW
 ZKvu2Th8N+SYZSW9ABg86bWuIrV42ERcJtpBBHw5UIZsEPvTg29dCoB+IZ2HjIvwf9/H
 1Zszof65V1SVoaI1wcJdMhooxl1UKmWEjqNV6OUMYesjCnbPwSWXbX5M95s8s3ayU78A
 Ot0aRrlx0LDjkZjyww/kJXWyNUx5Kvv2bwy0uCQ0gY8eGzb8bvaTO5P1B3lIW5BUbIDD
 rlgVS1XeRT5aOFZD3VDUVp/JWCec6ZpdiBDkSBxmsQYEqKFGwkFAgH/eAX9+5yS0hPZz
 OSTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCuWHiMBvaK7aEP2AStQczgzgaUcw62g5ePUf12Yi+Z7wHAXYPzKQRDudqPcpcYT1Q7a3Dp6runA9V2hwvCBJZX4ig5S8=
X-Gm-Message-State: AOJu0YyR7hFnRTVkZ+UPTuFABRKcrtMjYmy4lYk1INIip8TEB4mlfZtp
 UGST3RGogspZ0ELKUjVUGPGJDp6ZXbYoUolHTYfXBdCxeYdhxafRdjHV2sbM83Y=
X-Google-Smtp-Source: AGHT+IGkmoMw3a1DPayc7QnWHr4dDS3sIBh8SO1Tg4XHtfrHtXIYWWCQjxeTzAsb6sqGUSlj3ULtUw==
X-Received: by 2002:a05:600c:3c86:b0:412:8d98:78a with SMTP id
 bg6-20020a05600c3c8600b004128d98078amr14629463wmb.13.1709812138686; 
 Thu, 07 Mar 2024 03:48:58 -0800 (PST)
Received: from meli.delivery (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 fa18-20020a05600c519200b004130c1dc29csm2432000wmb.22.2024.03.07.03.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 03:48:58 -0800 (PST)
Date: Thu, 07 Mar 2024 13:46:27 +0200
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
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH-for-9.0 2/9] hw/xen/hvm: Propagate page_mask to a pair of
 functions
User-Agent: meli 0.8.5-rc.3
References: <20231114163123.74888-1-philmd@linaro.org>
 <20231114163123.74888-3-philmd@linaro.org>
In-Reply-To: <20231114163123.74888-3-philmd@linaro.org>
Message-ID: <9z7hk.qddjfbvts5k7@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
>We are going to replace TARGET_PAGE_MASK by a
>runtime variable. In order to reduce code duplication,
>propagate TARGET_PAGE_MASK to get_physmapping() and
>xen_phys_offset_to_gaddr().
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/i386/xen/xen-hvm.c | 18 ++++++++++--------
> 1 file changed, 10 insertions(+), 8 deletions(-)
>
>diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
>index 8aa6a1ec3b..3b10425986 100644
>--- a/hw/i386/xen/xen-hvm.c
>+++ b/hw/i386/xen/xen-hvm.c
>@@ -174,11 +174,12 @@ static void xen_ram_init(PCMachineState *pcms,
>     }
> }
> 
>-static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size)
>+static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size,
>+                                   int page_mask)
> {
>     XenPhysmap *physmap = NULL;
> 
>-    start_addr &= TARGET_PAGE_MASK;
>+    start_addr &= page_mask;
> 
>     QLIST_FOREACH(physmap, &xen_physmap, list) {
>         if (range_covers_byte(physmap->start_addr, physmap->size, start_addr)) {
>@@ -188,9 +189,10 @@ static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size)
>     return NULL;
> }
> 
>-static hwaddr xen_phys_offset_to_gaddr(hwaddr phys_offset, ram_addr_t size)
>+static hwaddr xen_phys_offset_to_gaddr(hwaddr phys_offset, ram_addr_t size,
>+                                       int page_mask)
> {
>-    hwaddr addr = phys_offset & TARGET_PAGE_MASK;
>+    hwaddr addr = phys_offset & page_mask;
>     XenPhysmap *physmap = NULL;
> 
>     QLIST_FOREACH(physmap, &xen_physmap, list) {
>@@ -252,7 +254,7 @@ static int xen_add_to_physmap(XenIOState *state,
>     hwaddr phys_offset = memory_region_get_ram_addr(mr);
>     const char *mr_name;
> 
>-    if (get_physmapping(start_addr, size)) {
>+    if (get_physmapping(start_addr, size, TARGET_PAGE_MASK)) {
>         return 0;
>     }
>     if (size <= 0) {
>@@ -325,7 +327,7 @@ static int xen_remove_from_physmap(XenIOState *state,
>     XenPhysmap *physmap = NULL;
>     hwaddr phys_offset = 0;
> 
>-    physmap = get_physmapping(start_addr, size);
>+    physmap = get_physmapping(start_addr, size, TARGET_PAGE_MASK);
>     if (physmap == NULL) {
>         return -1;
>     }
>@@ -373,7 +375,7 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
>     int rc, i, j;
>     const XenPhysmap *physmap = NULL;
> 
>-    physmap = get_physmapping(start_addr, size);
>+    physmap = get_physmapping(start_addr, size, TARGET_PAGE_MASK);
>     if (physmap == NULL) {
>         /* not handled */
>         return;
>@@ -633,7 +635,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
>         int rc;
>         ram_addr_t start_pfn, nb_pages;
> 
>-        start = xen_phys_offset_to_gaddr(start, length);
>+        start = xen_phys_offset_to_gaddr(start, length, TARGET_PAGE_MASK);
> 
>         if (length == 0) {
>             length = TARGET_PAGE_SIZE;
>-- 
>2.41.0
>
>


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

