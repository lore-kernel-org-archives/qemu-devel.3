Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C9BC54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 22:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhH7L-0007rP-EQ; Mon, 04 Mar 2024 17:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhH7J-0007r3-IZ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:49:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhH7H-0001S1-WD
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709592543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cgUvIl5+RU1WsUWMBt5CD8iRmvnfCu2nTiFI6QKvaZ8=;
 b=cepoEjeX26Cl81eQ0AKwsNAWbVigSR0S7WbEgoOT2BbtAI8XmuCBYR0/+VQGaBbcBuRXyR
 6HbFuh5NaHSzJRZu8ZCx4TOgjlz1VaxXIMrWR+cqhVNFiAU8VyNpb40xEUAIm4TXD8VJIc
 yS1KpCCs3KhuosduHChxEja7CJhyCrc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-XgLqZfxyO0i-zl54zUaUag-1; Mon, 04 Mar 2024 17:49:01 -0500
X-MC-Unique: XgLqZfxyO0i-zl54zUaUag-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412de861228so11068515e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 14:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709592539; x=1710197339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cgUvIl5+RU1WsUWMBt5CD8iRmvnfCu2nTiFI6QKvaZ8=;
 b=MWR10mVeBJbOvjqfLZdjzMZoTOg3sYWmEhXejgcQbvw4hFS8WLxo9me4zRfA7wEAP/
 FY65b+Oi31ZgTuYfa5i/9MpZJFPNhGH4Obd9QBwN8Vnv2kxrQHds/XpO5zpBCUP5NeyW
 40PSUBJGlSKmdXy3Qd7ylDudCH3Cm6izas2cr63vFTLmk7Pq5giUDCpDmP4oxJsjvGqY
 G9Gpd7bM2ApnQfdFGy3zktZff7qlpiBO+EU3BL8Q0VhwE/VfGvCB0fZ8xYJAgsLd1UBy
 ZN4dNlH11mz1mNbzJQaiIEDK0hdbHKtZL3n8czCbdiE1Gp3ImPtl6Z6DIn2gcAjkY4Wr
 jr/Q==
X-Gm-Message-State: AOJu0YwPofwCGPT2U0qEv+NUurNZYm4mQeneoblUwWOfv8JvGyRpNnbx
 Vn6n/hvBok2EKJpuMw8fHK9n/FkALi6hoPrt9z2T2QVo038Z6CCZztJKuoF+zfvVITZfReg3Dm2
 AD8uSJVhvBE7osKka5GY8WSc5T7H+PFkF7foVlTehAS5BWF/38YZ59+mJSvFN8PlqhU7jspVVrk
 8jowblIIDcY1C4li0oMT/kG4lA30QTdiDTeoMu
X-Received: by 2002:a05:600c:4e8e:b0:412:e70a:ab8a with SMTP id
 f14-20020a05600c4e8e00b00412e70aab8amr1949130wmq.25.1709592539389; 
 Mon, 04 Mar 2024 14:48:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1c4ab18TYfKeou5rHvFC9et/l7UvB29U0/VXpHw3f7E5kG/Akz1aVkhWCK9j+25Yb4xQNYA==
X-Received: by 2002:a05:600c:4e8e:b0:412:e70a:ab8a with SMTP id
 f14-20020a05600c4e8e00b00412e70aab8amr1949123wmq.25.1709592538997; 
 Mon, 04 Mar 2024 14:48:58 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a05600c0a5500b00412cb0961fasm11358493wmq.6.2024.03.04.14.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 14:48:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Kanda <mark.kanda@oracle.com>
Subject: [PATCH] oslib-posix: fix memory leak in touch_all_pages
Date: Mon,  4 Mar 2024 23:48:57 +0100
Message-ID: <20240304224857.268503-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

touch_all_pages() can return early, before creating threads.  In this case,
however, it leaks the MemsetContext that it has allocated at the
beginning of the function.

Reported by Coverity as CID 1534922.

Fixes: 04accf43df8 ("oslib-posix: initialize backend memory objects in parallel", 2024-02-06)
Cc: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/oslib-posix.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 3c379f96c26..e76441695bd 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -467,11 +467,13 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
          * preallocating synchronously.
          */
         if (context->num_threads == 1 && !async) {
+            ret = 0;
             if (qemu_madvise(area, hpagesize * numpages,
                              QEMU_MADV_POPULATE_WRITE)) {
-                return -errno;
+                ret = -errno;
             }
-            return 0;
+            g_free(context);
+            return ret;
         }
         touch_fn = do_madv_populate_write_pages;
     } else {
-- 
2.43.2


