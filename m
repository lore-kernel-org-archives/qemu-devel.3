Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE77CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G5Q-0003uw-DX; Mon, 29 Sep 2025 11:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4y-0003Fi-CR
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:46:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4m-0008Cp-VX
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:46:19 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so3257836f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759160760; x=1759765560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mzk7TvYEUHOAeZyPbb/RaRgUKTr/BD06CzZU6YBZwkQ=;
 b=qxxURNWtuHFAoCPMDG6V7F9dmE0U0/nwFqLv9jkV+k8hYYK7Wo+ANO98+rNnSodXEH
 vdg+EUjjHm1rHbw0g2aBcBRmKbd9qkEscR7XDuoh7Ul5rzGRdvfl3w494Gjp79odUVou
 ac43z3bhRH7UOjovjiHLjMc7u/INr13TkTtfxKtIB7dw31AyFZFpTHnveV67weiN7d41
 +Tg/d/zGxbeX+A3syKAI7ck7AZTjl/vcq3LnMZf0SbqlXFAJbZAkGjwdsOu2fwXj6fpg
 LOeq9P/drgKX54tDWFrP3GHiu+A7d/dTx7gipxOKMAcaoV+gHIxCzzy22A5Z8ewq9eIz
 nMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160760; x=1759765560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mzk7TvYEUHOAeZyPbb/RaRgUKTr/BD06CzZU6YBZwkQ=;
 b=xIZP3r5wU7qOZ70m1dDLrJVszqLYUIQXwpCAfRo2D28OX2Toz9EH4CY+b4gxCEa3Qi
 bBnGcE71YgIMic8JSOew2MJHUFX9hCjrH7RMVZa1cOVjXL1jcikRL3C4FRpa4aDi2z0D
 CIxdi52gpQhvj/hUvum57WBU1AnREfbDoCIwjqW1AEaut7a+yfoieioNHl/hzq0KLQlI
 SkTPyY7FbnS7oDXN2la4Wh/vafEYF/474gPWbj68vY29JSTIiEZpdGCSoWnl1isxRQ0m
 SWe4qvwIuGjiQytBHIM3Tr1asSg9oJDcIJpcWzWTKfFy3fFuL+oj6m03mPFN5EEVFWK8
 hNWA==
X-Gm-Message-State: AOJu0YyemBgfeAV0K1ITwtJw7TmmrssS8XmvlWSSH5bDnKnqBfeuIpHm
 Z+3tW/MbIKsA+25w9ammZM1lXLK4TU4aJAMQgpvY6anw6JM5UR8EfOaiiLs4ui6MqoSshus+yG+
 nLRIFzTQLwQ==
X-Gm-Gg: ASbGncu2jKPsxr4m+xsm4hixwSs1on6hDx9JmFBEcWilSsIcgo2nixoRgp7oG8YTqOF
 eRbqpeWT7CO2KD4hBI1rMJqSs3FH645mRp1k+8bAP1kJ/fHZ5ZbDiINm+W+mT6V1TzWv1gxdMLW
 p1qCDlIfY7ZgFJGEWIlrTiypMu+XGskjxIsM3L2EYPfEoVcCgl7BK5De1dRKUxeK8syqzAsIQt8
 y6Xq5C5tBO6zF/EPvq5RVUD2dgcFmHAN0iMKqZen6rBlr8/stkHbBQQXOlL0SzYEV35amdWnyeQ
 CLLEY8+MMTVV3hx/uU/l/SiXdNwKys4M+3vqQIACr3Dwk2H8GOgd0ofQQ7jo8GKQYiuLjsl0EjG
 YddGJdoAqRuLNaDlQmktoQCmhSIre/1HJ+YoiJrt+Ax0A2krXVfPU9M9lwPTCmbbEq6rlbr+apm
 IIqM3YVgw=
X-Google-Smtp-Source: AGHT+IH3YlclHUvzBeZmjHgHfu13/rjSq09wBftIgqk34vt3aorhDGFF6U+XwbRLbXnplvAK5b40Pg==
X-Received: by 2002:a5d:66ce:0:b0:40f:288e:9966 with SMTP id
 ffacd0b85a97d-40f288e9d15mr10386034f8f.51.1759160760285; 
 Mon, 29 Sep 2025 08:46:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602df0sm18812064f8f.36.2025.09.29.08.45.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 08:45:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: [PATCH 6/6] system/ramblock: Move RAMBlock helpers out of
 "system/ram_addr.h"
Date: Mon, 29 Sep 2025 17:45:29 +0200
Message-ID: <20250929154529.72504-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154529.72504-1-philmd@linaro.org>
References: <20250929154529.72504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
index 57c00e42ca6..1b4092d6322 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -119,4 +119,15 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr, uint64_t offset,
  */
 bool ram_block_is_pmem(RAMBlock *rb);
 
+static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
+{
+    return (b && b->host && offset < b->used_length) ? true : false;
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


