Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C67CEDD89
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW28-0004vX-Gl; Wed, 09 Oct 2024 08:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW22-0004si-G3
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1z-0005WI-U9
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FjMBCXJg2PmGEwp55y/1gkUv3OpESanW4HCUWzVhmPI=;
 b=fRsBt1nrDfcK8UJmzYMm/XDjh/dNNciUrAZ4wdI+AWonhDPdjGK7lkY61SaGzTkjRlPhle
 eNJD4kS9w9N1T9bLKF2B1giIA2VFrZiwj6MJoAoQUXzzvzLPSqJcT48Iz+6ESCcfRldV9r
 fnd3nt94I6nBl+PUqhilSp2BkFYdHbE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-Z0nW3H_yNUuwVb9c619QwA-1; Wed, 09 Oct 2024 08:43:06 -0400
X-MC-Unique: Z0nW3H_yNUuwVb9c619QwA-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-8353d85fc5bso91031239f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477785; x=1729082585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FjMBCXJg2PmGEwp55y/1gkUv3OpESanW4HCUWzVhmPI=;
 b=F+QYL6uZ0U6ig/gqsV7y5D9L3Kt22EZTYF4iUoN4mAm9CSIF5t16kr7fQP5cY/VutW
 iypoNSyruqqgP+/cUya4maD4mNtNo0QqIHIrdQ4xU24tULWAwu5CsuTQElx+sKzlxtcl
 8L9vm1YKFS/+XO7FoLUllt54rECgeBp8w8sMVHtdDeIfr7Ac5SSx+z6/+IwQq+QD0Qoi
 oGU+Eq6AUI5b0ssstdHXxJ6zabux9rkNzjLAvGgQ5AraW6s/FPRKzFaYEzVUJ+EsyOVH
 LbpxHVGqxbyPY4tBYZJVALua6ym9J86fKOQs+GsPwclSUPJZlfg9o2MH8oxRSwlJ51qW
 Hv7Q==
X-Gm-Message-State: AOJu0Yzv2ofmq2z6xjiqYJhb9ohd679jAWE1vka9yUVaJDkAwKaCDfRM
 nqUwpa03+YU3CT7AmFh9pdMXTul+UCheAQbJslvXMxsWx+/b0Ljonk8GRcysvaWTwq/zhHr3xQ4
 PHuFHqyQ+i5FpZvQnQ3WBXgw8ry9xE4rjHGc0pjaHVYXjiJRU4uxTVdpMDi8E1Kb+oAWuxh8FSy
 HbM4DL7QXOd7hKT7ZtMNX7r+K7V6UY986nAg==
X-Received: by 2002:a05:6602:2d8a:b0:834:d9ff:123e with SMTP id
 ca18e2360f4ac-8353d50ff39mr319810839f.13.1728477784705; 
 Wed, 09 Oct 2024 05:43:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIvCXosOt8xAP5lvYldX30CzxM+QGXfDlfoei28oII77deoT7qgign8XXMW5pxmurpkadA0g==
X-Received: by 2002:a05:6602:2d8a:b0:834:d9ff:123e with SMTP id
 ca18e2360f4ac-8353d50ff39mr319807439f.13.1728477784267; 
 Wed, 09 Oct 2024 05:43:04 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:43:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Yuan Liu <yuan1.liu@intel.com>
Subject: [PULL 12/12] migration/multifd: fix build error when qpl compression
 is enabled
Date: Wed,  9 Oct 2024 08:42:38 -0400
Message-ID: <20241009124238.371084-13-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
References: <20241009124238.371084-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Yuan Liu <yuan1.liu@intel.com>

The page_size member has been removed from the MultiFDSendParams
and MultiFDRecvParams. The function multifd_ram_page_size is used to
provide the page size in the multifd compressor.

Fixes: 90fa121c6c ("migration/multifd: Inline page_size and page_count")
Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Link: https://lore.kernel.org/r/20241008104527.3516755-1-yuan1.liu@intel.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-qpl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index b0f1e2ba46..bbe466617f 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -389,7 +389,7 @@ static void multifd_qpl_compress_pages_slow_path(MultiFDSendParams *p)
 {
     QplData *qpl = p->compress_data;
     MultiFDPages_t *pages = &p->data->u.ram;
-    uint32_t size = p->page_size;
+    uint32_t size = multifd_ram_page_size();
     qpl_job *job = qpl->sw_job;
     uint8_t *zbuf = qpl->zbuf;
     uint8_t *buf;
@@ -420,7 +420,7 @@ static void multifd_qpl_compress_pages(MultiFDSendParams *p)
 {
     QplData *qpl = p->compress_data;
     MultiFDPages_t *pages = &p->data->u.ram;
-    uint32_t size = p->page_size;
+    uint32_t size = multifd_ram_page_size();
     QplHwJob *hw_job;
     uint8_t *buf;
     uint8_t *zbuf;
@@ -560,7 +560,7 @@ static int multifd_qpl_decompress_pages_slow_path(MultiFDRecvParams *p,
                                                   Error **errp)
 {
     QplData *qpl = p->compress_data;
-    uint32_t size = p->page_size;
+    uint32_t size = multifd_ram_page_size();
     qpl_job *job = qpl->sw_job;
     uint8_t *zbuf = qpl->zbuf;
     uint8_t *addr;
@@ -598,7 +598,7 @@ static int multifd_qpl_decompress_pages_slow_path(MultiFDRecvParams *p,
 static int multifd_qpl_decompress_pages(MultiFDRecvParams *p, Error **errp)
 {
     QplData *qpl = p->compress_data;
-    uint32_t size = p->page_size;
+    uint32_t size = multifd_ram_page_size();
     uint8_t *zbuf = qpl->zbuf;
     uint8_t *addr;
     uint32_t len;
@@ -677,7 +677,7 @@ static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
     }
     for (int i = 0; i < p->normal_num; i++) {
         qpl->zlen[i] = be32_to_cpu(qpl->zlen[i]);
-        assert(qpl->zlen[i] <= p->page_size);
+        assert(qpl->zlen[i] <= multifd_ram_page_size());
         zbuf_len += qpl->zlen[i];
     }
 
-- 
2.45.0


