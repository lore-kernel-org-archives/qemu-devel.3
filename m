Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C943B1091912
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Im2-0000KH-Vd; Thu, 19 Mar 2026 15:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Ilv-0000HG-7V
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:11:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Ils-0008Uh-Kg
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:11:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486fd5360d4so7124905e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773947462; x=1774552262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08aoZn44HcdaHVUd8YP+7Dk3Itjd86OK4YNsod7wDRU=;
 b=nYknbXY2HiDYqjRmq5SDw5gfAeuj9RSUmUPByYR1azGI4LneKhpx1z6J6CCJXbqTct
 GjUW1Ar8MKCufpHJYpLD18Mn06c/t13XT4wY5CFWXqlnrQC8GkZV9iJMBCfWkxTXf0RI
 Hf3nWpDsKYXVgYx+Zgpm5goq+ZfuUYPjceHcZdxeNelqDoqqywCwpMEyi0Qu+8QheP8f
 ePLkXBVRv89wCB47Xi+eSEkZqn+8ja33UgyEUs+FKLduetZcC0OMpaFhezwEZSvJJbub
 jPR5l/2m4By/V/TgC0eBDLMxEe53usnDa+rOSM0E9WL/Bo/SYYIb78XdV7PLdjHAM++9
 tyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773947462; x=1774552262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=08aoZn44HcdaHVUd8YP+7Dk3Itjd86OK4YNsod7wDRU=;
 b=XSG6yn5XHt3jnK+AXKCy1TfnpFbqFKp5lmjibvXF9I1VsFbImRv42wYYbDEEsoMh/L
 rqwvNDIGkqq08TcST1BGxr7E5yOwmAC25at2gDTN0h3sUTI7KAPmXo42EUY1r9inRadb
 FQXEa3fhv6PuDNtx7pTl8i+/k7qXofrqGMT23jIjtUrFfehSbuoI4ZOC0fdlWL4izwVs
 URWBoKehl9M9Kp+cIzKuOkopzwakdGO/Sxx7ZlPTjZ56D1RytL54qUf3PU/aMcomQq/T
 JKq41SxdLs9NxoaiTp+aqftvdfZcOLRmjCA0i6nLqZ3JHdsrVj0SQstjMdojb6DNJxI7
 j7zA==
X-Gm-Message-State: AOJu0YzSiK5tR1UT1onZ0hhFbkZzMN1zreAqVFUITdhZKBQMcF+qYErq
 4pJDpvdqd31aEt38hcDjM2+OOuQuE3xhB6k58E3vomDkRYVMnALyRkxQmVf/YevF/2/sM7ouSDA
 9i2ONNog=
X-Gm-Gg: ATEYQzwcE0v4A8mlhWQSqBwackgsriGE/R32+JLPA4SsuN8Y51w54pLeaZRARfoyVef
 lF6OMl8E/9qhFZW1E1xaxZMxVI0q1lfuarHFWHwG55ifFEdRrbl9ftea3pPWRaKhwQpDnUriBm0
 RylAGtfM8E4r4aAU/jBorfeKCcPHXOvdBQxQtU5CRZMZ4MZKI/Tvmr6OVuby+fARcnJ86m5WaOA
 KcbP8k2NrTlNS09yHDDIj0qVW/4jDhDHXDClzy6TzKhCPA6Bk55HJ7ZKeuOZ5HI9HlFcg0sVGNE
 CxMPMy/niCM7gH1b42FZ7dDZSbxVcQNT6isHAYE+vH9eJVrkga1rEDrkgfatwsBAImBTiEuHUts
 4upTC3uYz3TmsDz3sw3uykv5Wp0NiIBpT1LFIKXQ3nyUvb/WBuPiK9IfO3ZDfKXwbBSnDSashCg
 LM3h+y/NWQkJsFfwWPFsm0LhIXqPN7ru4bMo/lkZxHpuZKwumlPy8Wmx25WILpPAkihXuEeoci
X-Received: by 2002:a05:600c:a4a:b0:485:4eaf:eb14 with SMTP id
 5b1f17b1804b1-486fee0fbf6mr3717685e9.21.1773947461624; 
 Thu, 19 Mar 2026 12:11:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe68ec05sm18822185e9.0.2026.03.19.12.11.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 12:11:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 6/8] system/memory: Constify various AddressSpace
 arguments (cache)
Date: Thu, 19 Mar 2026 20:10:15 +0100
Message-ID: <20260319191017.12636-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319191017.12636-1-philmd@linaro.org>
References: <20260319191017.12636-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Mark the AddressSpace structure const when it is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory_cached.h | 2 +-
 system/physmem.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
index 6eb6179140b..760ecb38c19 100644
--- a/include/system/memory_cached.h
+++ b/include/system/memory_cached.h
@@ -117,7 +117,7 @@ void address_space_stb_cached(MemoryRegionCache *cache,
  * are relative to @addr.
  */
 int64_t address_space_cache_init(MemoryRegionCache *cache,
-                                 AddressSpace *as,
+                                 const AddressSpace *as,
                                  hwaddr addr,
                                  hwaddr len,
                                  bool is_write);
diff --git a/system/physmem.c b/system/physmem.c
index c00f75bf591..b7280e74aa2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3837,7 +3837,7 @@ void cpu_physical_memory_unmap(void *buffer, hwaddr len,
 #include "memory_ldst.c.inc"
 
 int64_t address_space_cache_init(MemoryRegionCache *cache,
-                                 AddressSpace *as,
+                                 const AddressSpace *as,
                                  hwaddr addr,
                                  hwaddr len,
                                  bool is_write)
-- 
2.53.0


