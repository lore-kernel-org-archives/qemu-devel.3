Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1C9C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s57an-0001kg-Fr; Thu, 09 May 2024 13:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s57ah-0001iG-02
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:30:00 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s57af-0003eb-FN
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:29:58 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5206a5854adso1284218e87.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715275794; x=1715880594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=88iGUBfmU5lozJiJBggIOABZEHW2b7csBLSZoA2gDGg=;
 b=UdeOFH73UWmR4hhXqhe53sSYwIi1aI/njNiDXxBqntk40fLe3U1VKyqSH+GPyHVpxI
 W3x2rbr84RNJGfJbecOUSipXjQnXu078Wnb0LND7HvpzABgWyBkI2goicJ8djOJcxJ4m
 E/ZAgreHBrKGgCDfNJJGeMAaOFWMoC4kpfIqlluRkxU5i2t7mNgSMEtd81vA9mbO+++O
 9eIUYRRTdJgQqtIhKtnzmRl1CNsngzFV/Hm0AFi5d0apDmuDFAK0CmBmCRcRgUzm+Qbh
 O7TRtISy67KHBDAK6z9qWNTp13J0aVbkM2E8qEK2GNVMoC4ccvF8KoTykgsPt1r3ywcn
 TmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715275794; x=1715880594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=88iGUBfmU5lozJiJBggIOABZEHW2b7csBLSZoA2gDGg=;
 b=H5uAvu59LhBacgfE6OMODyxZ6dGuoPxr6pajVAqWtvGHRSyGK8UqVs54Tx3M9C9hQY
 7njGww9CD1IRmuj20uE2M+KrkulCPHBa3AcdTJh4sNJYOWIsacKC/miZF2kThbiSE81O
 L7PuurEwqxem6Lo5a6DuE8EODxTeeSeGXWW/eZD5Yav+Lmf0O6TIaa0+YkRe+LIcDAIx
 1puQ1mX2xwQVRV835IAn6h5lCzR4wBUw0Aa1gOm8pU6wVNb/IrQ5BhKPMtm91jDYj7K5
 JZyvSon0fXpNEGrucUj3V8LXZfkZwPfbmCtM1XpHFNxTFqc0SbCEIp0ZEXOcEv/Hg2UJ
 4pIg==
X-Gm-Message-State: AOJu0Yz7xH919G437wYbRrJjwhASUH1NP7Z6Ik8JB/H+bB6YCS6Cy+QH
 P+mhJKItrEDZv0sf4duOi4YT4tGT6NeVf9PKIdM321YDHXPizAx1/N353NPl
X-Google-Smtp-Source: AGHT+IFvDDGw033tziAuQdDRYGe6Yu4CE0pSWf6+eY/e0DmFk6sZdolbsDStXsJCH5g4KXCFrIjbCQ==
X-Received: by 2002:a05:6512:3487:b0:522:92f:508d with SMTP id
 2adb3069b0e04-5220fc7329bmr119443e87.10.1715275794366; 
 Thu, 09 May 2024 10:29:54 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f35ba4f6sm375156e87.84.2024.05.09.10.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:29:53 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 5/8] softmmu: Replace check for RAMBlock offset 0 with
 xen_mr_is_memory
Date: Fri,  3 May 2024 03:44:46 +0200
Message-Id: <20240503014449.1046238-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
References: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

For xen, when checking for the first RAM (xen_memory), use
xen_mr_is_memory() rather than checking for a RAMBlock with
offset 0.

All Xen machines create xen_memory first so this has no
functional change for existing machines.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 5e6257ef65..b7847db1a2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2229,7 +2229,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * because we don't want to map the entire memory in QEMU.
          * In that case just map the requested area.
          */
-        if (block->offset == 0) {
+        if (xen_mr_is_memory(block->mr)) {
             return xen_map_cache(block->mr, block->offset + addr,
                                  len, lock, lock,
                                  is_write);
-- 
2.40.1


