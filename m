Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9A4C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnRj-000602-Gk; Mon, 23 Jun 2025 16:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRi-0005zn-7d
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRg-0003Wa-PW
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750709232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPAbS7kbUQ6XF3VFXAZzn4GVMjZi6hGPV20GzFZdjtU=;
 b=eeI58a7I0UJOSOOuU3DaSGa0X9r5IXBQ9bPtqLBzZJfVaWckudUq+CtMBp3gT3TKOoAjPN
 f+7vaufxYsjQ+45Ud3PrXfM5yEwglEyD5O2Y/B5XN7P+gFAaPWKqrXGyzB8ChrBNNoAq5M
 H1v57v0YKjmMRetGIVqGYJXQXmT+syk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-g1OqxblbOemHS4cXVOnwpw-1; Mon, 23 Jun 2025 16:07:10 -0400
X-MC-Unique: g1OqxblbOemHS4cXVOnwpw-1
X-Mimecast-MFC-AGG-ID: g1OqxblbOemHS4cXVOnwpw_1750709229
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fb4eed1914so101735176d6.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 13:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709228; x=1751314028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPAbS7kbUQ6XF3VFXAZzn4GVMjZi6hGPV20GzFZdjtU=;
 b=qDxaQc3qHa1pQCLJQaAvvolvdH0GLhmXEUfUEl6svJmT3z4mEB/lfr8gmkm8IhexuZ
 +6AVT/znLBuXda27GloR9wrsyT5R41N5JNRklPfiMU3Zhyt4Dn6YNMn2FWz6JQ6PLl2T
 2ObFzv+VQiSZDyHLfhtmMIql/fjp/XvvMFWPkSBfYwUd1Zp8934R30nt+Ny3VdVdzSOc
 Jb2QGh7BMsjHdVKImg34heZk63ryZK2sPCV+GMaslVpAKgZuiKFy5tmYwT+4L6Ucm/lR
 OAVs8q/WXgYuDl7H7wSR7sqLST+6d6SKV7UvXNhjvq2RSfvFk6vg9H5iPsxORJ370ccN
 yGbA==
X-Gm-Message-State: AOJu0YxzQwwTfUWkR7Gm+X4iyh1Qg/Zyckit2QrEmXVLU7oOgtPTgzFD
 V7n8eXcpWv2WPAaV4XkXDyx2gjajP0j0X0z8OKah/ynVSXG1uUAFK0/GK5E+VrpTgBHxNM2sut4
 Ptjo+tCXOTILwwVOrr66nPMVZNdYyuHYjGYHJS+R/hQWDeIfvq8hf/wWQgNQViyHvyxgUvX7QFF
 pafUXiDAcVLX174tH1EcZmrPdzfmX5y4p+478UXg==
X-Gm-Gg: ASbGncsCrBFbgEwjWooR3xGkWP8cN7zeLSikXkMeiXqWD7H62iGV4del1psOOTMUQVN
 Q6HTdbR9QhNntAqKdZKinYAewqb5x0ALawZ5dHv59pOclDs4U5nc5gRdpFg4Wzp6QPtXkfMC/q+
 D/0GC9Km7XUBS+8O+IF9c5EEaGSHVqlqnMASq/apKs6Mi55sBrRpXRYUb6LwY5lbIcytMv4g+by
 37HSFehXIKiizioldHAZ5dPKCrVfiUlMHfTUaLfv7rwD4ouJnz3REIJzn5tRx+NlRsvI/MJhnv+
 BEb4ZZ3O+IE=
X-Received: by 2002:a05:6214:4b11:b0:6f5:426c:1d1 with SMTP id
 6a1803df08f44-6fd0a57a411mr228481396d6.34.1750709228583; 
 Mon, 23 Jun 2025 13:07:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdEHpYd1fnxyu2z6UdQOpxBhS4MkasrO9OTK306GaXLjJou91TYcK6DhaU5cTT5riboBG2HQ==
X-Received: by 2002:a05:6214:4b11:b0:6f5:426c:1d1 with SMTP id
 6a1803df08f44-6fd0a57a411mr228481036d6.34.1750709228131; 
 Mon, 23 Jun 2025 13:07:08 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd095a775bsm48427976d6.112.2025.06.23.13.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:07:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Chaney, Ben" <bchaney@akamai.com>
Subject: [PULL 06/11] migration: Don't sync volatile memory after migration
 completes
Date: Mon, 23 Jun 2025 16:06:51 -0400
Message-ID: <20250623200656.1882674-7-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623200656.1882674-1-peterx@redhat.com>
References: <20250623200656.1882674-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Chaney, Ben" <bchaney@akamai.com>

Syncing volatile memory provides no benefit, instead it can cause
performance issues in some cases.  Only sync memory that is marked as
non-volatile after migration completes on destination.

Signed-off-by: Ben Chaney <bchaney@akamai.com>
Fixes: bd108a44bc29 (migration: ram: Switch to ram block writeback)
Link: https://lore.kernel.org/r/1CC43F59-336F-4A12-84AD-DB89E0A17A95@akamai.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index fd8d83b63c..024d8b3d03 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3680,7 +3680,9 @@ static int ram_load_cleanup(void *opaque)
     RAMBlock *rb;
 
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
-        qemu_ram_block_writeback(rb);
+        if (memory_region_is_nonvolatile(rb->mr)) {
+            qemu_ram_block_writeback(rb);
+        }
     }
 
     xbzrle_load_cleanup();
-- 
2.49.0


