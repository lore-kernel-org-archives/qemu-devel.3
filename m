Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC3ECAC5AD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 21:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqgAM-0006XK-95; Tue, 17 Sep 2024 17:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAI-0006OW-EZ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAG-0004sX-On
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726610116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1EwRJ2C6TfAu0owbGHqQmsTLpssDSJGcP8SDLMrK6k=;
 b=iylPHQ5dGNVqoaSDnLuJFAjuf8tgtHvT+pF0ON4Kd0HdEcBUp/fp20pUhlOsREIEDL+dRx
 9pGUx30UN+2tyLuEL8gtoyJPRJHpYP9zONWQaUFFmZRe426HGUCoXwBn9pEN6C9BJ1xOIp
 sItNsBHpiItZWptdRnVnjRHS6gPSyck=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-go3QWBmSO9SGMFoZFmehMA-1; Tue, 17 Sep 2024 17:55:14 -0400
X-MC-Unique: go3QWBmSO9SGMFoZFmehMA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a99ec827f3so665181585a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 14:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726610114; x=1727214914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1EwRJ2C6TfAu0owbGHqQmsTLpssDSJGcP8SDLMrK6k=;
 b=iOik8xnWZIHeaK5c2btrHnVB80VMvnxvR4qQikmxaMOLZbBFvi+TrfpcP8+CgErkHP
 U9JLQgshTOVwpPWXZdDeT/l7/A/viS6ygUsNyLoVHwhQLlrHVtwW17BwW5zocrjhOlJl
 oPwY8Crlj8VipseNKwWaFlOPfco4xQFQG12WAlaf4wg4oBOCuHG04J6LwNQjSxjcVcLw
 qkAVB44SGm+gZ6ogyEUYSRejBEqJrwJIf5AzTEqr4dArk6heF+/6JP1FRiUJkpjwOBCp
 9MGKmVQZ8rcbVEGmTognidWkkT3DwvNcSslYxkgzGibRq6DbHrC2ZPUOnF8Jci+8LpHJ
 CNGg==
X-Gm-Message-State: AOJu0YylrtYqeaym0p2XfcqT1kjIAdn6il9KG4IwsRczuBb5B1lTLMVG
 tQm6yBmDE0Nhotq6qCAb+e6HDlmLeioyJFgaWzcK1wcH3dMHAk1LmMdUuuEmT9uAZdnUJOx4iFW
 DM0sJ69UFelriLixUnS4N88I7HCSAc3FOfo2fQT4Tp6FT1HH4PFArCSaR6FEgWBfylr/ZZb0mRz
 zVmp2STNrWg/vgmkBeEcDYAhZt15O4VMUUUA==
X-Received: by 2002:a05:620a:2495:b0:7a9:d4ae:5f85 with SMTP id
 af79cd13be357-7ab30da32c6mr2632591285a.43.1726610114185; 
 Tue, 17 Sep 2024 14:55:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrrgZRn/wKcpriEJBW+Hw3qIZRoAt6KPemuOhriLh+xoF9Fk7NyUmbjh0rVmsDt8eSyRyE1Q==
X-Received: by 2002:a05:620a:2495:b0:7a9:d4ae:5f85 with SMTP id
 af79cd13be357-7ab30da32c6mr2632587785a.43.1726610113781; 
 Tue, 17 Sep 2024 14:55:13 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3e97c9fasm402869685a.28.2024.09.17.14.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 14:55:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Stefan Weil <sw@weilnetz.de>
Subject: [PULL 3/6] migration/multifd: Fix loop conditions in
 multifd_zstd_send_prepare and multifd_zstd_recv
Date: Tue, 17 Sep 2024 17:55:03 -0400
Message-ID: <20240917215506.472181-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240917215506.472181-1-peterx@redhat.com>
References: <20240917215506.472181-1-peterx@redhat.com>
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

From: Stefan Weil via <qemu-devel@nongnu.org>

GitHub's CodeQL reports four critical errors which are fixed by this commit:

    Unsigned difference expression compared to zero

An expression (u - v > 0) with unsigned values u, v is only false if u == v,
so all changed expressions did not work as expected.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Link: https://lore.kernel.org/r/20240910054138.1458555-1-sw@weilnetz.de
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


