Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E30C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnho-0001b7-3f; Mon, 11 Mar 2024 18:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngr-0000rP-PM
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngq-0004Hd-0W
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LgyHPzF/xmcyuUnqn1KinqQdKLq8XEiNwDRL/hsnc9k=;
 b=Q815McEMWocxBdr4+MASRneP1GBpS0VJ11U4X2Hy8bOazxNm3wNYDisonPWHOVO2gyH5Rl
 m6f7bmTXF4AmWpDtWz5rScFaEWe1F7urxs95gt85YZBYIxB7JnyZbfyLumWGhodegfD7pd
 fPG9TR/rbrFlJfYWfJu0PIocIXtjEuw=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-CneGIuaXPhGATvVsqo8f-Q-1; Mon, 11 Mar 2024 18:00:09 -0400
X-MC-Unique: CneGIuaXPhGATvVsqo8f-Q-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7da965e700fso482477241.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194409; x=1710799209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgyHPzF/xmcyuUnqn1KinqQdKLq8XEiNwDRL/hsnc9k=;
 b=X8Ms7bMT2+S8/c4QLeIFAmKGQkUM+Siw/qoGoEDBv/qAnHK8IHe8xqDl+hs7nL9hQH
 ZAOTOp9bsIjfy2iBeFMKqNgrQO9ok2HdLAgGChHx1umy1BDjTesfCWAVPaXqbZyuXCW3
 HWjHcmEJwunNOeZDMu9wYwUlu7c3PYmbdOdj9Nf68ccjDpAlYBZR2jg14FsBulVMRZtk
 oPmnMbVKQqqowdbA4NmMmIKUWY1fGkdqszTyXWYp0j8/+zy9wahueACCZyjvOKgq+XUI
 B0yM68nYRlFsr4qq9NMfiixMuqM73N79n5AFJMuQv4Vb2EvGIbCpgkq6I7+cHR0oey0f
 fvIg==
X-Gm-Message-State: AOJu0Yyqe/mkQRtnX3uZPR+ZsIfL0Dg+XJ4sscxyfE4IMVgYokILTUY+
 zzZ77iP01zYKzEBfL0v3zFCaxTZqECRN5pldmdiZExAnxpKKZkdRVqytjcHrRLnGLWe9tAHh9Cy
 DXO6Ef4FqoVh+LUk+HPp/GGI/XHjjwUrnuC8O83lIqzeMUpiB3+q/LFjZTvHXc3r4Z7aGSp4les
 x5IjmEgDvqrGnmaMCIDY9r90cR9p7ckegpGA==
X-Received: by 2002:a05:6102:5127:b0:473:1ac8:5ef5 with SMTP id
 bm39-20020a056102512700b004731ac85ef5mr307656vsb.2.1710194409071; 
 Mon, 11 Mar 2024 15:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWoMYWpRefpIPYtlLxLHpZ3dnw8fpsVZGbhEl6K0NlO2iDafEQvp4Hkv4W1ty2lZhLvWTdxg==
X-Received: by 2002:a05:6102:5127:b0:473:1ac8:5ef5 with SMTP id
 bm39-20020a056102512700b004731ac85ef5mr307632vsb.2.1710194408664; 
 Mon, 11 Mar 2024 15:00:08 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.15.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 15:00:07 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: [PULL 28/34] migration/multifd: Allow zero pages in file migration
Date: Mon, 11 Mar 2024 17:59:19 -0400
Message-ID: <20240311215925.40618-29-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Currently, it's an error to have no data pages in the multifd file
migration because zero page detection is done in the migration thread
and zero pages don't reach multifd. This is enforced with the
pages->num assert.

We're about to add zero page detection on the multifd thread. Fix the
file_write_ramblock_iov() to stop considering p->iovs_num=0 an error.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240311180015.3359271-2-hao.xiang@linux.dev
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/file.c b/migration/file.c
index 5054a60851..b0b963e0ce 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -159,7 +159,7 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
                             int niov, RAMBlock *block, Error **errp)
 {
-    ssize_t ret = -1;
+    ssize_t ret = 0;
     int i, slice_idx, slice_num;
     uintptr_t base, next, offset;
     size_t len;
-- 
2.44.0


