Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8784DC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 16:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX2FP-0003p9-OO; Mon, 05 Feb 2024 11:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rX2FM-0003oO-53
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:55:04 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rX2FI-0000Vf-Im
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:55:02 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a37ce4b2b23so109264766b.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 08:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707152099; x=1707756899;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNpxq6Apbo1PtxtrKGMXSaSi9q/5migrwbdEokXR2Eg=;
 b=wEXH+73prz0Ijei9K0UNzIW2BzvJ8ZKVqUNDm6ZbSTPzqH8oqWJVH1qK+uUBisAHEX
 lY0Hbe+WaZKHIUcEjkfKHdFXIFsPeQOwUNBt20XwCu3tzI37Wvj7HtUOvGpfJFsJ33d1
 YeClO05Onp5u3jehDDJPR8fDAs/ayyLLqx4yHhZFhx3kSOm37Kt6LHbWdkq88tg8phX4
 oF6jH0ZqB7y/UlmiuVJWlDueigJesUyW8E5Q/YnRuSPURlUrHSZFJeH1LRJIHuNfM9TQ
 dmHpFHLayQpDWCnCk+f8eeD9+LTtp7USyohZ6DblFUUQrWtd9lWcay+bVVaOcIp5xmp6
 A8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707152099; x=1707756899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNpxq6Apbo1PtxtrKGMXSaSi9q/5migrwbdEokXR2Eg=;
 b=RPKEa7w8gUE6Uu3PFTo4flwYeAG3RleEwfT6LGrB+M5HF1SvK2WcWm7DfnhrtnqSah
 rLDq4T0ecD9w/FWnFF4k2iqaSpSWAUDeHbQF16g+iK8XyH8U5g6XBpFG43yBeLFh/w6d
 WuBN9IUu+utFANn6mFbh5prRHGjuhZr+yqu5800FRoiFOsn95C1xXjAx0njnn0GTo8FJ
 EI5PTsdnWNvi7N+Oc+O6LrjxmWCPSefoY8h5+0vbUhKuECKc6tkFYJFeXlE8DmlW+4u5
 YtttcoR2/82I8tcSAbVdmfePIAlKp+86fv5Buf7FxnhbrSYXS8YbpWEh/zHgYnyP5Kir
 RtVQ==
X-Gm-Message-State: AOJu0YxUTjY+dw4WQaPfvd0CthSX15Lbdyvy2hiqJwRoyB+pxYTq4ADq
 gG7Thq2Ic0NgQEzlhHXPHhUzcmT2JlDAlG9B6VvEHivNUo2Dqn1pwlB2EWfpzEw=
X-Google-Smtp-Source: AGHT+IH8UcjMYsYtJn1zkvloCSXKhLrgFL8ly0Q0purBlRIHArnhz/oHaNcNzn2vQmvPGtOHJxHX3g==
X-Received: by 2002:a17:906:4558:b0:a37:fe16:dd35 with SMTP id
 s24-20020a170906455800b00a37fe16dd35mr15212ejq.42.1707152098998; 
 Mon, 05 Feb 2024 08:54:58 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWCYt3uZWoNlGdhLlOQSXv4M9v4u9W0ucG0ax8YIkMp1yn1UXUiYe5uCxj8voXrhZ+pZTW9IpFCc0q6RLmjK07mpAdPCbCosWhfMJAf8m0GjFuMY8U/7jUGJunONvxOHcdRVNfZC/oo1SJZJ5tLcq62rO9TBUzT+/UbhFDScltQ1aZtacOZIDgzHj1aDswSHHfBuo5KDrFaCw4pUkF9KnnS1mskR7+vo1M8ZjIxXvoSnKY0W1ZxWe8673I=
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a170906074e00b00a370a76d3a0sm20580ejb.123.2024.02.05.08.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 08:54:58 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com,
	akihiko.odaki@daynix.com
Subject: [PATCH v9 1/5] ebpf: Added eBPF map update through mmap.
Date: Mon,  5 Feb 2024 18:54:31 +0200
Message-ID: <20240205165437.1965981-2-andrew@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205165437.1965981-1-andrew@daynix.com>
References: <20240205165437.1965981-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::62f;
 envelope-from=andrew@daynix.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Changed eBPF map updates through mmaped array.
Mmaped arrays provide direct access to map data.
It should omit using bpf_map_update_elem() call,
which may require capabilities that are not present.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf_rss.c | 117 ++++++++++++++++++++++++++++++++++++++----------
 ebpf/ebpf_rss.h |   5 +++
 2 files changed, 99 insertions(+), 23 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index cee658c158..f774d9636b 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -27,19 +27,83 @@ void ebpf_rss_init(struct EBPFRSSContext *ctx)
 {
     if (ctx != NULL) {
         ctx->obj = NULL;
+        ctx->program_fd = -1;
+        ctx->map_configuration = -1;
+        ctx->map_toeplitz_key = -1;
+        ctx->map_indirections_table = -1;
+
+        ctx->mmap_configuration = NULL;
+        ctx->mmap_toeplitz_key = NULL;
+        ctx->mmap_indirections_table = NULL;
     }
 }
 
 bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
 {
-    return ctx != NULL && ctx->obj != NULL;
+    return ctx != NULL && (ctx->obj != NULL || ctx->program_fd != -1);
+}
+
+static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
+{
+    if (!ebpf_rss_is_loaded(ctx)) {
+        return false;
+    }
+
+    ctx->mmap_configuration = mmap(NULL, qemu_real_host_page_size(),
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   ctx->map_configuration, 0);
+    if (ctx->mmap_configuration == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration array");
+        return false;
+    }
+    ctx->mmap_toeplitz_key = mmap(NULL, qemu_real_host_page_size(),
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   ctx->map_toeplitz_key, 0);
+    if (ctx->mmap_toeplitz_key == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
+        goto toeplitz_fail;
+    }
+    ctx->mmap_indirections_table = mmap(NULL, qemu_real_host_page_size(),
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   ctx->map_indirections_table, 0);
+    if (ctx->mmap_indirections_table == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection table");
+        goto indirection_fail;
+    }
+
+    return true;
+
+indirection_fail:
+    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
+    ctx->mmap_toeplitz_key = NULL;
+toeplitz_fail:
+    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
+    ctx->mmap_configuration = NULL;
+
+    ctx->mmap_indirections_table = NULL;
+    return false;
+}
+
+static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
+{
+    if (!ebpf_rss_is_loaded(ctx)) {
+        return;
+    }
+
+    munmap(ctx->mmap_indirections_table, qemu_real_host_page_size());
+    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
+    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
+
+    ctx->mmap_configuration = NULL;
+    ctx->mmap_toeplitz_key = NULL;
+    ctx->mmap_indirections_table = NULL;
 }
 
 bool ebpf_rss_load(struct EBPFRSSContext *ctx)
 {
     struct rss_bpf *rss_bpf_ctx;
 
-    if (ctx == NULL) {
+    if (ebpf_rss_is_loaded(ctx)) {
         return false;
     }
 
@@ -66,10 +130,18 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
     ctx->map_toeplitz_key = bpf_map__fd(
             rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
 
+    if (!ebpf_rss_mmap(ctx)) {
+        goto error;
+    }
+
     return true;
 error:
     rss_bpf__destroy(rss_bpf_ctx);
     ctx->obj = NULL;
+    ctx->program_fd = -1;
+    ctx->map_configuration = -1;
+    ctx->map_toeplitz_key = -1;
+    ctx->map_indirections_table = -1;
 
     return false;
 }
@@ -77,15 +149,11 @@ error:
 static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
                                 struct EBPFRSSConfig *config)
 {
-    uint32_t map_key = 0;
-
     if (!ebpf_rss_is_loaded(ctx)) {
         return false;
     }
-    if (bpf_map_update_elem(ctx->map_configuration,
-                            &map_key, config, 0) < 0) {
-        return false;
-    }
+
+    memcpy(ctx->mmap_configuration, config, sizeof(*config));
     return true;
 }
 
@@ -93,27 +161,19 @@ static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
                                             uint16_t *indirections_table,
                                             size_t len)
 {
-    uint32_t i = 0;
-
     if (!ebpf_rss_is_loaded(ctx) || indirections_table == NULL ||
        len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
         return false;
     }
 
-    for (; i < len; ++i) {
-        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
-                                indirections_table + i, 0) < 0) {
-            return false;
-        }
-    }
+    memcpy(ctx->mmap_indirections_table, indirections_table,
+            sizeof(*indirections_table) * len);
     return true;
 }
 
 static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
                                      uint8_t *toeplitz_key)
 {
-    uint32_t map_key = 0;
-
     /* prepare toeplitz key */
     uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] = {};
 
@@ -123,10 +183,7 @@ static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
     memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
     *(uint32_t *)toe = ntohl(*(uint32_t *)toe);
 
-    if (bpf_map_update_elem(ctx->map_toeplitz_key, &map_key, toe,
-                            0) < 0) {
-        return false;
-    }
+    memcpy(ctx->mmap_toeplitz_key, toe, VIRTIO_NET_RSS_MAX_KEY_SIZE);
     return true;
 }
 
@@ -160,6 +217,20 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
         return;
     }
 
-    rss_bpf__destroy(ctx->obj);
+    ebpf_rss_munmap(ctx);
+
+    if (ctx->obj) {
+        rss_bpf__destroy(ctx->obj);
+    } else {
+        close(ctx->program_fd);
+        close(ctx->map_configuration);
+        close(ctx->map_toeplitz_key);
+        close(ctx->map_indirections_table);
+    }
+
     ctx->obj = NULL;
+    ctx->program_fd = -1;
+    ctx->map_configuration = -1;
+    ctx->map_toeplitz_key = -1;
+    ctx->map_indirections_table = -1;
 }
diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
index bf3f2572c7..ab08a7266d 100644
--- a/ebpf/ebpf_rss.h
+++ b/ebpf/ebpf_rss.h
@@ -20,6 +20,11 @@ struct EBPFRSSContext {
     int map_configuration;
     int map_toeplitz_key;
     int map_indirections_table;
+
+    /* mapped eBPF maps for direct access to omit bpf_map_update_elem() */
+    void *mmap_configuration;
+    void *mmap_toeplitz_key;
+    void *mmap_indirections_table;
 };
 
 struct EBPFRSSConfig {
-- 
2.43.0


