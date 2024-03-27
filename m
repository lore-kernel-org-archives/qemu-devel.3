Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAEFCD11DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 02:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpIfT-0005Zg-Kq; Tue, 26 Mar 2024 22:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpIfS-0005ZH-Bz
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:05:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpIfQ-0001xI-S9
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:05:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e740fff1d8so4489896b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 19:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711505127; x=1712109927;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dq9y8oIeY1L8ZIgWL8BlTPdW4sDTSYpVxv6sdWa4hnQ=;
 b=BfktOCs8qsjPrXT3cIpH0mL/wqSgZHwgybNDUP9xGavBzpsbgmiCDR7ItHWq5ZewN9
 DXa/QuLuWBCUg5ZP1iBDisNwJXKiGVjMP6VMOjoCH9NnHe9IZE3BOirIEnLmtR4MEiZA
 dFlkduatGNQOVuJkGi59l3357jdrX8+Qc7iE7xiygL1utfMZ1Q+9VMEEWHv35ODPRAwR
 ZFP8sk0dedumit7EhzXWWYlV24YnmSLN0jBT/Zv9lroaRqUcIBVFPkPSUvtfHFMTybCQ
 Um0TC+exGQQtE8WYCaNEgGwK5dVAGAUUNEUrMlJ8N92OHiOLsTTsGoGaSuJQdEFP5EOs
 UoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711505127; x=1712109927;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dq9y8oIeY1L8ZIgWL8BlTPdW4sDTSYpVxv6sdWa4hnQ=;
 b=jI9wJnPG5eBjFUNsqMVfJj1ikVZ8HnJ3rI/VXHTCxUyePOndeaCjDaKk4CzdvtfrCq
 yGYOM+dTzTumQUzabNeDFTbkp9ECcWYLc6dvDrxzFRJAHJlHDCriS9OPxckzxrKe7+fY
 /dJea/ych1RYc5sCJ+E0f1hN4jbXAI1GbwPbhUr/iKrp/BaQ+Dw3QcfLJM87r0tIPTwi
 n3sXbeCyj6Fx4tmBRzQa+tP6/as7+TTAgwtV8ZzzFKvWEP+ZReS2lJ+ROyiB7XX2E0ji
 tCwcJf3MVgjRHXqgriKyZLgoCQGoPqhuEci1LkEScfKT3NALIWgiNDGSNkLs2KJjxRwq
 KPDQ==
X-Gm-Message-State: AOJu0Yzhd8ZknrU9/j4HxiI5vA0oolI0B74nMw9r+Q9EH71M5sn41+W0
 4t1kOdSgK/fIps4EhKeLPXm3G8k4aS122uLRV0wD6gnfR9gFLhf/lOllfSrx9FDmJYPUt17RRsk
 C
X-Google-Smtp-Source: AGHT+IGcTLZm0B03InSGsbKsntOoWD0J32q78Pd/lGvkgtg3L1F1mm/5pnNdXIuAHm5LLWeiiUOrHQ==
X-Received: by 2002:a05:6a00:a01:b0:6e6:c38e:e8a6 with SMTP id
 p1-20020a056a000a0100b006e6c38ee8a6mr1957797pfh.4.1711505127467; 
 Tue, 26 Mar 2024 19:05:27 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 h4-20020a056a00230400b006ea8ba9902asm6681959pfh.28.2024.03.26.19.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 19:05:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 27 Mar 2024 11:05:10 +0900
Subject: [PATCH v2 2/2] ebpf: Fix indirections table setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-vhost-v2-2-0a89aa21b54b@daynix.com>
References: <20240327-vhost-v2-0-0a89aa21b54b@daynix.com>
In-Reply-To: <20240327-vhost-v2-0-0a89aa21b54b@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The kernel documentation says:
> The value stored can be of any size, however, all array elements are
> aligned to 8 bytes.
https://www.kernel.org/doc/html/v6.8/bpf/map_array.html

Fixes: 333b3e5fab75 ("ebpf: Added eBPF map update through mmap.")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ebpf/ebpf_rss.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 2e506f974357..d102f3dd0929 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -185,13 +185,18 @@ static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
                                             uint16_t *indirections_table,
                                             size_t len)
 {
+    char *cursor = ctx->mmap_indirections_table;
+
     if (!ebpf_rss_is_loaded(ctx) || indirections_table == NULL ||
        len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
         return false;
     }
 
-    memcpy(ctx->mmap_indirections_table, indirections_table,
-            sizeof(*indirections_table) * len);
+    for (size_t i = 0; i < len; i++) {
+        *(uint16_t *)cursor = indirections_table[i];
+        cursor += 8;
+    }
+
     return true;
 }
 

-- 
2.44.0


