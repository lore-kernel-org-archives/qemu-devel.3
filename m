Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033F6CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryXc-0000UK-Fm; Wed, 03 Apr 2024 07:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryXR-0008Q0-4W
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:20 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryXP-0007Pw-Hd
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:16 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e740fff1d8so4787493b3a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142734; x=1712747534;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nOqObjFvo/9oAC/9p+G1KW7r4O+qd7IGNrZnts75bB0=;
 b=FMzqlDRjmkUMhhYesMDAApxfpfXcUzGBKu/g+ctD4GIoKO97ryvdetX+v0c5v5tkra
 20Nl2VQGRgPEuCyF0fZ/uHkoJuPVLYJiibkyq/nzUQvlehBXlbGpBJ1wo++2M7cx/SSL
 2BqTsEN0D+qAb/KBxCvyjS7zrjHyQWLfJ7/xKi4G6S1qovdRJ7HPxhge7ZVktiywKDtx
 OpeYFvn5hF0V9+FBjBMcMXKhlGiZQCCLGhtvXTUSvvHLLdt4Ia1EQRiwwZOUJxntlkXw
 uqfjweOUAMZxikrCkITOHq0bDM2McTwRKgkaSpm7vTZzmR9HtEsUDJHSP8RCAZQQ8SJc
 5MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142734; x=1712747534;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nOqObjFvo/9oAC/9p+G1KW7r4O+qd7IGNrZnts75bB0=;
 b=xDS/ob8LkZx51+FX28WYeexZ6eKMnfeydVV+4XxIjc/ENoGGNiYg2sle18CS/eZ/nt
 atltXU0QfQlWE+q1jETeWM03xQQwOtFwREBB4h66HkNICvQv1jp8rgFTm9hzqpVIjGaD
 k7BiYCECT7nFtkbU1W7nA0xUrnl3vYeiSnOe5kjK+gPXPvNjBY+QhWH4IgI6f1lHN2tn
 0vFFhM4pCyP6GU5ZkfQFT+iE4X4nsxOof4YQJNWFsZIkdoUWt+twSH+Hx8L9NpPFsuNb
 I2/7Nd1yNlzc8AqP7GjQ6Cu39ikp9WHfTP+/KaVzJVLGL7+Qc5+H8CttxhYwAhqgd7ZG
 ye3Q==
X-Gm-Message-State: AOJu0Yy8++PNem21vfJ4avITpcxcusn4nbCJb+hd5u3n7GPLu9kju3Yt
 GrNGXIIEX7LDSMUhEux1fDEc61vChafJgHW2wqcP26I9RAMwZMjtnzvaPocCMFE=
X-Google-Smtp-Source: AGHT+IG5zRHgw+6UH+XKv2HDkk9dkN/7eAFt7aPnG4OUy7YqIcOqfqNIAIoUqp/xbxmXvbMmXm6cDQ==
X-Received: by 2002:a05:6a20:959b:b0:1a3:c2dd:f1cd with SMTP id
 iu27-20020a056a20959b00b001a3c2ddf1cdmr15814183pzb.56.1712142733978; 
 Wed, 03 Apr 2024 04:12:13 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 fi13-20020a056a00398d00b006ecca2f2a32sm2359481pfb.168.2024.04.03.04.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:12:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:11:07 +0900
Subject: [PATCH v9 19/20] ebpf: Refactor tun_rss_steering_prog()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-19-c6d87e69d38b@daynix.com>
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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

This saves branches and makes later BPF program changes easier.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/ebpf/rss.bpf.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/tools/ebpf/rss.bpf.c b/tools/ebpf/rss.bpf.c
index 77434435ac15..c989cb3cd82c 100644
--- a/tools/ebpf/rss.bpf.c
+++ b/tools/ebpf/rss.bpf.c
@@ -547,27 +547,23 @@ int tun_rss_steering_prog(struct __sk_buff *skb)
     config = bpf_map_lookup_elem(&tap_rss_map_configurations, &key);
     toe = bpf_map_lookup_elem(&tap_rss_map_toeplitz_key, &key);
 
-    if (config && toe) {
-        if (!config->redirect) {
-            return config->default_queue;
-        }
+    if (!config || !toe) {
+        return 0;
+    }
 
-        if (calculate_rss_hash(skb, config, toe, &hash)) {
-            __u32 table_idx = hash % config->indirections_len;
-            __u16 *queue = 0;
+    if (config->redirect && calculate_rss_hash(skb, config, toe, &hash)) {
+        __u32 table_idx = hash % config->indirections_len;
+        __u16 *queue = 0;
 
-            queue = bpf_map_lookup_elem(&tap_rss_map_indirection_table,
-                                        &table_idx);
+        queue = bpf_map_lookup_elem(&tap_rss_map_indirection_table,
+                                    &table_idx);
 
-            if (queue) {
-                return *queue;
-            }
+        if (queue) {
+            return *queue;
         }
-
-        return config->default_queue;
     }
 
-    return 0;
+    return config->default_queue;
 }
 
 char _license[] SEC("license") = "GPL v2";

-- 
2.44.0


