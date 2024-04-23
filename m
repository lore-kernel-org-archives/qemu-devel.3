Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB500C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOn4-0001rZ-83; Tue, 23 Apr 2024 18:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOml-0001eV-HX
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmj-0006EP-L9
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uufuWa7UUHVcyWc4Hr5CmlTlCPL2KkHNrpavQ9qeFxE=;
 b=N1hwswR8Bbvm13LBdoFYWH2ByGBMJOzvVw+R8OEYUDcUlrXffYPoPCox8DiecjEGGVkDUO
 ieyFq1uRMQ2ZhtfU5GAj1JECNr6PHMZi+NEMvCdekftAlGGAF5nsgTxGr6dzWxJwO+s964
 mlQgpoLjmlKaQ0Y2PvVOJpXllLUD+A4=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-thX1BInyNTmEjYsCDayV-A-1; Tue, 23 Apr 2024 18:38:43 -0400
X-MC-Unique: thX1BInyNTmEjYsCDayV-A-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c72fe44b54so1300020b6e.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911922; x=1714516722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uufuWa7UUHVcyWc4Hr5CmlTlCPL2KkHNrpavQ9qeFxE=;
 b=dpusbZAvC0Fmc27QW3KkOrFhICUoBXQyxYOxJMA85B+NY1l7B7P8+eAugeVxu41i1J
 XpJZKaXjkUIfYw9U53oX0nLT9Ron19rGQXDeiNyeIGiYiUrZ8HlKtZ2euv42zY3u8MQg
 H2lQdVbPrITEobZX4ugvhsBfB4yxafJAuytaGXjmlLSYB6OVrgoM/Csgevs+hhcSJpY/
 Fw+QP7b8SYvYPXDA8+Dp5lbgOH+jpvHWRIDzi4h9cpzxASJkoCO3M7YwRBoR2fsCaoD5
 dmYo0Mk0GSuBYqHonf2kzzViaUxPKx+Tvf5xAd9E051xti8f0GQq7Okm9IoDcuSvWe+e
 lkEQ==
X-Gm-Message-State: AOJu0YwSMCT4e4EL4riJzBkexQK9lPxmFtRa30iJLeEwM8JAlZNwnbKS
 qzoXRYMgR0LpBwNlcIyTenzOEzBXuyREzbTemQIntdQLL7USf5996Zyg8wHeb0JgDBU43nczAx5
 7cSdwTVmqGzTu7wUPx/G2aPOEpycXlXq5VkqmI/YP8iBTlSWWc1C8RaCACliUeVlKOR3m4oMzFc
 vySeOcoIwkEDg3lBgPxKKHZ0CtJ5kpAPK1Kw==
X-Received: by 2002:a05:6808:13c1:b0:3c8:2a1b:d2a0 with SMTP id
 d1-20020a05680813c100b003c82a1bd2a0mr765466oiw.4.1713911922362; 
 Tue, 23 Apr 2024 15:38:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvscFnMiaf1fObzVL6J/AgUi90/1NhLq2CYcZOT9DRDnFrSJ+bGviOZ1f72B9HGk958SOZ5g==
X-Received: by 2002:a05:6808:13c1:b0:3c8:2a1b:d2a0 with SMTP id
 d1-20020a05680813c100b003c82a1bd2a0mr765440oiw.4.1713911921843; 
 Tue, 23 Apr 2024 15:38:41 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/26] migration: Add Error** argument to xbzrle_init()
Date: Tue, 23 Apr 2024 18:38:09 -0400
Message-ID: <20240423223813.3237060-23-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

Since the return value (-ENOMEM) is not exploited, follow the
recommendations of qapi/error.h and change it to a bool

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240320064911.545001-14-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 26ce11a337..70797ef5d8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2727,44 +2727,41 @@ int ram_discard_range(const char *rbname, uint64_t start, size_t length)
  * For every allocation, we will try not to crash the VM if the
  * allocation failed.
  */
-static int xbzrle_init(void)
+static bool xbzrle_init(Error **errp)
 {
-    Error *local_err = NULL;
-
     if (!migrate_xbzrle()) {
-        return 0;
+        return true;
     }
 
     XBZRLE_cache_lock();
 
     XBZRLE.zero_target_page = g_try_malloc0(TARGET_PAGE_SIZE);
     if (!XBZRLE.zero_target_page) {
-        error_report("%s: Error allocating zero page", __func__);
+        error_setg(errp, "%s: Error allocating zero page", __func__);
         goto err_out;
     }
 
     XBZRLE.cache = cache_init(migrate_xbzrle_cache_size(),
-                              TARGET_PAGE_SIZE, &local_err);
+                              TARGET_PAGE_SIZE, errp);
     if (!XBZRLE.cache) {
-        error_report_err(local_err);
         goto free_zero_page;
     }
 
     XBZRLE.encoded_buf = g_try_malloc0(TARGET_PAGE_SIZE);
     if (!XBZRLE.encoded_buf) {
-        error_report("%s: Error allocating encoded_buf", __func__);
+        error_setg(errp, "%s: Error allocating encoded_buf", __func__);
         goto free_cache;
     }
 
     XBZRLE.current_buf = g_try_malloc(TARGET_PAGE_SIZE);
     if (!XBZRLE.current_buf) {
-        error_report("%s: Error allocating current_buf", __func__);
+        error_setg(errp, "%s: Error allocating current_buf", __func__);
         goto free_encoded_buf;
     }
 
     /* We are all good */
     XBZRLE_cache_unlock();
-    return 0;
+    return true;
 
 free_encoded_buf:
     g_free(XBZRLE.encoded_buf);
@@ -2777,7 +2774,7 @@ free_zero_page:
     XBZRLE.zero_target_page = NULL;
 err_out:
     XBZRLE_cache_unlock();
-    return -ENOMEM;
+    return false;
 }
 
 static bool ram_state_init(RAMState **rsp, Error **errp)
@@ -2904,7 +2901,8 @@ static int ram_init_all(RAMState **rsp)
         return -1;
     }
 
-    if (xbzrle_init()) {
+    if (!xbzrle_init(&local_err)) {
+        error_report_err(local_err);
         ram_state_cleanup(rsp);
         return -1;
     }
-- 
2.44.0


