Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5ECCD1280
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 10:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3i5-0006B5-9T; Tue, 26 Mar 2024 06:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp3i1-0006AZ-LH
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:07:09 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp3hz-0000cp-Pm
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:07:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e6afb754fcso4677867b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 03:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711447626; x=1712052426;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C9ZtEo8zXe/BK9I7qoRpJCkIeC3s39lHzzgTxhX0Iv0=;
 b=IhzhzKIWHF1ZQBNbCOjfxtKoGFA2aA87toZHgJp+LUIHBJOrnaTWa3KX9BcILgZIuL
 ASzcQp4ogu91ozdPoLDwpjdexSyxk2KfJYG8+f6dKtLRu1ULMy4/Bl0d23za485T9tIr
 8DPWzfPpsvsmg55VVosjHqJ6YxQy9inEqaioaV1UprF6nQ52VH5XrxyyLU5pOq42Vjpk
 tFGSHPh2bnygt7UWuSwGQ9MZqgW6zQipg7UIgyMKj2kt35Or7FKzGEH7Lk0hkPhG+vNX
 YpvPyqE8P5wRYxORNO5PkGMkHBaft0lmylHXhDjog6TvoWwwLFZqrIwg0oib4sQ95/GR
 /D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711447626; x=1712052426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C9ZtEo8zXe/BK9I7qoRpJCkIeC3s39lHzzgTxhX0Iv0=;
 b=YsJ7R5IcLITRf8tHbbOsWfK7JI7tA3JPh5pGSpN11mPOma9pWWUIJVbyjBjezaw+8w
 MWUu31b5sN5JV+vyT35/PoNS7jxqGXhuDkpsPsf5mJd3QNMUckGCol9XHm8lwWI2S1uF
 Hecom+xwPEpFsHiQI0nGfqx0V4O/SIxlLF9tzT8v+VbciKmkpNGoEWuOQfqW7lpVoj0L
 zanN7DX6pgM7A2pRgUfTVxpnD9FrnsYP0Dt/+uLSXV5vjScFBlICykfvmjJOPyh4syZR
 xSxMFxrApqOvgo1Xz8A5leDHxY84F3dDJ++jStxFCfBG6qCEUhCgYKZtzJMxNsnvS9Bg
 XgSQ==
X-Gm-Message-State: AOJu0Yypre8mTsY8f1PxqBwc8OaG1mj0YcWFfPhebgSg0oPtRaa6ZYDR
 RYc6DGgHpi3BUjLxDR4d9FIRJJJATNd+sYj53UhiF0otunwpuzLFOtLYOJX0sZU=
X-Google-Smtp-Source: AGHT+IET/NGPJWeIfRy0DbO5vQ+KLBUr6O2Tu6dsI/MGhXV8vBFRFAwT3oSrOQSkqFQoXQJ5HTOVsQ==
X-Received: by 2002:a05:6a00:801:b0:6e6:f9b6:4b1a with SMTP id
 m1-20020a056a00080100b006e6f9b64b1amr12162097pfk.11.1711447626321; 
 Tue, 26 Mar 2024 03:07:06 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 a9-20020aa78649000000b006e681769ee0sm5725873pfo.145.2024.03.26.03.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 03:07:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 26 Mar 2024 19:06:30 +0900
Subject: [PATCH 2/2] ebpf: Fix indirections table setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-vhost-v1-2-09bd85b1ba2c@daynix.com>
References: <20240326-vhost-v1-0-09bd85b1ba2c@daynix.com>
In-Reply-To: <20240326-vhost-v1-0-09bd85b1ba2c@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.13.0
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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
 ebpf/ebpf_rss.h | 2 +-
 ebpf/ebpf_rss.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
index 239242b0d26e..7d15b600bf5b 100644
--- a/ebpf/ebpf_rss.h
+++ b/ebpf/ebpf_rss.h
@@ -26,7 +26,7 @@ struct EBPFRSSContext {
     /* mapped eBPF maps for direct access to omit bpf_map_update_elem() */
     void *mmap_configuration;
     void *mmap_toeplitz_key;
-    void *mmap_indirections_table;
+    uint64_t *mmap_indirections_table;
 };
 
 struct EBPFRSSConfig {
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 2e506f974357..e0f300febb77 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -190,8 +190,9 @@ static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
         return false;
     }
 
-    memcpy(ctx->mmap_indirections_table, indirections_table,
-            sizeof(*indirections_table) * len);
+    for (size_t i = 0; i < len; i++) {
+        ctx->mmap_indirections_table[i] = indirections_table[i];
+    }
     return true;
 }
 

-- 
2.44.0


