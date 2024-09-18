Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC54BCDD54D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 18:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqzTD-0001n5-55; Wed, 18 Sep 2024 14:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzTA-0001iL-IX
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzT8-000204-Uv
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726684321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WN5jXygqxHRuj1VtFy0rqimytcsamIGQeRfTQJKJPW4=;
 b=VuEFYt5W6Tyj/KziVJHZMsrTa/3qdupKlTsMG0vgU8sUH1me0MgBWuLj9lkB1DoAirOJia
 37FBahQRQEjwH7D8FEMus7O3KoUGFodDLw5grya+fWe7t/yuuFSIm6TD6oAowJqWF1YFIk
 1rHrLmURGTT7zwA7GiZuOCTRPx+SRzY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-vtuu4e4kNma1Eo8V8yyXRw-1; Wed, 18 Sep 2024 14:32:00 -0400
X-MC-Unique: vtuu4e4kNma1Eo8V8yyXRw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c357986fc8so107712776d6.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 11:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726684320; x=1727289120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WN5jXygqxHRuj1VtFy0rqimytcsamIGQeRfTQJKJPW4=;
 b=hHBvXxyY9hruGKOcUKWkTaUi/bID7eiq9G70ijdMw8WJ13nXAHj8ITW33k5oNcspo3
 AExdkkTt3MqZ87u9a11F3HbieBtHeIO9LTM3mzQr59d/O1QUkB4zI7WqSwThsb2HXHZc
 4k4+o2Qqk5YG9Z3izy70FeRjBrHozit8XXIBbhhJkN7GHSB7TDIGFPNjKGDhLLk07qe0
 uABqFW51jYdufEQaCIs2IO24535WaHxQW42OyiMQFzBsJQBSDJX7efDi5O397/v1Tceq
 D9WnxHDqwI6UbsjpSJl4HBII7t9S83gxfcXOZklBPnQW4nHk/svzzH1OctSCca6MrN3A
 1hzQ==
X-Gm-Message-State: AOJu0YweXgqnHqacLcWekPGw/u/s87rp4LokuyVC1iakI8B85vTNInzm
 THcXpLNUcj598JZYMskoFEcVKOldxSdMKdiwi20t+z82IpqQRX+Lyb2cGWwYvPmX4McXE5Hw+lR
 TNHC5hRIjxYdFgk4H+eOQV3dUfQJYqsslHP/Lrv6GLqTRPHQiJL3XpK+fJPodu7o/Ui1Kmd0GS5
 jzSNcNkpvrKvTv5m/zrUZ5c5bcbVJlcPp99g==
X-Received: by 2002:a05:6214:4686:b0:6c5:1a21:b8b9 with SMTP id
 6a1803df08f44-6c57df93104mr395167086d6.13.1726684319691; 
 Wed, 18 Sep 2024 11:31:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/L8OnWNvbR7s0teiUq06ymwPONV2RYnRIFwBZk7aY1X14E31hn27cP6BPVOeeNMqHbJFRkA==
X-Received: by 2002:a05:6214:4686:b0:6c5:1a21:b8b9 with SMTP id
 6a1803df08f44-6c57df93104mr395166756d6.13.1726684319311; 
 Wed, 18 Sep 2024 11:31:59 -0700 (PDT)
Received: from x1n.. (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e494a28sm30486d6.68.2024.09.18.11.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 11:31:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Stefan Weil <sw@weilnetz.de>
Subject: [PULL v2 3/6] migration/multifd: Fix loop conditions in
 multifd_zstd_send_prepare and multifd_zstd_recv
Date: Wed, 18 Sep 2024 14:31:48 -0400
Message-ID: <20240918183151.6413-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240918183151.6413-1-peterx@redhat.com>
References: <20240918183151.6413-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Stefan Weil <sw@weilnetz.de>

GitHub's CodeQL reports four critical errors which are fixed by this commit:

    Unsigned difference expression compared to zero

An expression (u - v > 0) with unsigned values u, v is only false if u == v,
so all changed expressions did not work as expected.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Link: https://lore.kernel.org/r/20240910054138.1458555-1-sw@weilnetz.de
[peterx: Fix mangled email for author]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-zstd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 53da33e048..abed140855 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -123,9 +123,9 @@ static int multifd_zstd_send_prepare(MultiFDSendParams *p, Error **errp)
          */
         do {
             ret = ZSTD_compressStream2(z->zcs, &z->out, &z->in, flush);
-        } while (ret > 0 && (z->in.size - z->in.pos > 0)
-                         && (z->out.size - z->out.pos > 0));
-        if (ret > 0 && (z->in.size - z->in.pos > 0)) {
+        } while (ret > 0 && (z->in.size > z->in.pos)
+                         && (z->out.size > z->out.pos));
+        if (ret > 0 && (z->in.size > z->in.pos)) {
             error_setg(errp, "multifd %u: compressStream buffer too small",
                        p->id);
             return -1;
@@ -243,7 +243,7 @@ static int multifd_zstd_recv(MultiFDRecvParams *p, Error **errp)
          */
         do {
             ret = ZSTD_decompressStream(z->zds, &z->out, &z->in);
-        } while (ret > 0 && (z->in.size - z->in.pos > 0)
+        } while (ret > 0 && (z->in.size > z->in.pos)
                          && (z->out.pos < page_size));
         if (ret > 0 && (z->out.pos < page_size)) {
             error_setg(errp, "multifd %u: decompressStream buffer too small",
-- 
2.45.0


