Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3078ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zy1-0004KS-En; Wed, 01 Oct 2025 12:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zxm-0004DD-Cm
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:46:01 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zxV-0008FX-FX
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:45:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso203165e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759337128; x=1759941928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VL++psIcTnezWEV7BWLGf1XEHbU+wiOL+n3sKTSCz9o=;
 b=d2MyhOCNrZOO5dLbHZv4zpSD81/LU2cW0po0jx7zrnoGUr3TCyh0pGLeh4YBF+nVIK
 C1VVzH1dG3PAKvtO/Qf9F9TME6u4s1udcu5GpCn49asm/Ps8jLECtHVJIBGmtoUF2KZs
 bvQub1xFi99E/bhjV6jTGkhS9g7rlGvn1TZQ+5fJQh9MyRSPXs7GgoZZyOsWHByDdj7d
 SeNIhlxqTBmZbsPr9CYfLd436O7OpesD31lvD6JRo3YqpLNS4/nN+b0JhdybS0AkDh/N
 JEG/5gqPE/YKiIDLy894kSZILse08H31e3J3bsJBZMqsnFB5f5wEKG/iFeAR69rpIWok
 57Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759337128; x=1759941928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VL++psIcTnezWEV7BWLGf1XEHbU+wiOL+n3sKTSCz9o=;
 b=E1fQ9gxjor6i+/IINARZo6BDBGc3eqjn2+2X4Uqop7TQryIGfGY4vl2NDwLiaD5ZO3
 FA/F+59aXkRG2cNRNfHuh9f4CfSPeRjpqXHxr30/DYODlOm6qSoOk/2ILyFW01W/I3GJ
 vs+aPj4iYlca50oK6vXgGG0h5CXMrdFgmkyIynpW1qdluJ1dgz59vMzL9hIydQFcvk/w
 9vnbBYzaTWZMqJlckYdpnvIh2lxrpJtEG1vXIkUJWOZ0dVCfqJyS3GWL+EUOO7ENdUWZ
 utd0sy/aN2xl7dEriAXCIDeMMZAU1pB29sdF2FQahtgee9u7ETu7GT7rnDVg6ot8rCE1
 HebQ==
X-Gm-Message-State: AOJu0Yyk8zZg9lElv2laSRcUzv0pOVixiNYejGNr9YJZtKQeVL9NzKEK
 nNSe2BGBcy5jkR8DNXwd1jrtLaUQEoYg06DDUOVr7GxhjBACKR1JUmEGsA6XkLh0QLgLR7ayrxJ
 cRT/7Fo/Ojg==
X-Gm-Gg: ASbGncv2UDCyxLGdx7KjQzhd5D+5HtmrEy7vW6V6Heyl0Bh9MNoeAPMnOu1RkOqhQ4l
 v+Cfsk5kp6luao9WTRw2kqZEjxM4kss+JCLbVUwXChNNZ2JuaCNRoaaIhWUZqj5qek+pRHGbf/u
 N4ON1dVuFFgpLfJIRXGTUjj6C7gIWksLlsLxdV7dOF9tECvr+F+9mOaoQOFHCjFv3ekPu++fhoz
 pq4Eh8m/LuLY8XjThEks662MTegk1+UqGJBS8HR/COuiM5qCk/4UYDC0MlGU36E2bKTnsyy23EI
 bBEl6HekN8Mxf8u5V4pEwc7DLbMA4sxvY3NdN/f/sa64LTOdOp1vHRlVUPg3U7KZXNxj4hmAiMy
 NE6O7ja6FxH39srgXfu5CDzxRH78E4iFkjAjqO15bB3ZCIkW66CKAv1h63RGNnGbDEYKphaaSZ6
 TZnPrdlEubZNqge/T2/u+q
X-Google-Smtp-Source: AGHT+IFDyHiEUjdTZfjcMgExdvmeutiDgwZCl97ycLZmqQrXlnCt5GjUjQ4J6/vZMMHCXF6n4mwPYQ==
X-Received: by 2002:a05:600c:4e92:b0:46e:506b:20c9 with SMTP id
 5b1f17b1804b1-46e61219739mr38231995e9.12.1759337127788; 
 Wed, 01 Oct 2025 09:45:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b9c88sm46228355e9.22.2025.10.01.09.45.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 09:45:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/6] system/ramblock: Move RAMBlock helpers out of
 "system/ram_addr.h"
Date: Wed,  1 Oct 2025 18:44:56 +0200
Message-ID: <20251001164456.3230-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001164456.3230-1-philmd@linaro.org>
References: <20251001164456.3230-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/ram_addr.h | 11 -----------
 include/system/ramblock.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 53c0c8c3856..6b528338efc 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -80,17 +80,6 @@ static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
     return bitmap_test_and_clear(rb->clear_bmap, page >> shift, 1);
 }
 
-static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
-{
-    return (b && b->host && offset < b->used_length) ? true : false;
-}
-
-static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
-{
-    assert(offset_in_ramblock(block, offset));
-    return (char *)block->host + offset;
-}
-
 static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
                                                             RAMBlock *rb)
 {
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 85cceff6bce..76694fe1b5b 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -119,4 +119,15 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr, uint64_t offset,
  */
 bool ram_block_is_pmem(RAMBlock *rb);
 
+static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
+{
+    return b && b->host && (offset < b->used_length);
+}
+
+static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
+{
+    assert(offset_in_ramblock(block, offset));
+    return (char *)block->host + offset;
+}
+
 #endif
-- 
2.51.0


