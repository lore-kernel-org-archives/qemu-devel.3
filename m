Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FBF606A685
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eHscsa0G;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VykKS6PM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVUF4-0002Z7-Fi; Mon, 23 Nov 2026 08:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVUF1-0002Tz-82
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:37:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVUEz-0001N0-Bu
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795441072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hBUSydXgdo+NJzAP0oUvalDfmF37+5nue+3eUtAoz6k=;
 b=eHscsa0GLRo0m/ER8cc6RSAbVTTZk4UzFRdyIOPJVxvlrDDKncdZekShrKxDrPsKocevkx
 d/aphtn7AfwNXiklHOf2cUDsviX50CU1LurWmvK2xjaP6auRrLsrC3M0rapfEw/2/wEv6X
 SZKHuCEIHJqK/4YfesWzSOKQBY079R4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-8ccZtCvCNHaRBNA38pbX4Q-1; Mon, 23 Nov 2026 13:37:50 +0000
X-MC-Unique: 8ccZtCvCNHaRBNA38pbX4Q-1
X-Mimecast-MFC-AGG-ID: 8ccZtCvCNHaRBNA38pbX4Q_1795441070
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-92109408212so71072446d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795441070; x=1796045870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hBUSydXgdo+NJzAP0oUvalDfmF37+5nue+3eUtAoz6k=;
 b=VykKS6PM0aCw8XKb3HP6g0iuBfdtdPY/OiXdKXLNGHtqnP942P/bVHBkWQND5LzwOc
 cGdHifIJ16WwvNTzcf9eW+V9aDZJ4NGZGh+1f4seGArgVayrQf8zRC1eILkDkdn5/iah
 RP74R6dFjImdOdp4L2nPXyq8gWWgHO9XG9k0I7iAVaJWtampSQtM9MLXyD3GVBC9IsiZ
 hq92mFfalc/nLAD/6NE5FLdmoD7Na7nPIMa7Qr6mGO+EgxIjmOlfkG0rBJ85dl1KUf6n
 m4qC7rjgkbxHMovBNLCJzPdgGK3mJpM1JB3MLh/Zjdvzsd0KSsO/XTskP0KG/84r2CS/
 WXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795441070; x=1796045870;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hBUSydXgdo+NJzAP0oUvalDfmF37+5nue+3eUtAoz6k=;
 b=WuLI+2lFVkQS2lGEq38Y9h2ildiWsS5998P59RgQ9pOAI7k7KX0L3JxzWWRA5d3h4W
 N81wHe+AGfFZWIcJSdk/+hoJ+85+qLiLkORRNSWP/t9Qm+C0mB1zcHNKh3kct1kNRpfR
 AnjAvqCT/QJeewOmFpUa+uardOz1+cXwSU9vTi3IMRX47CA7O3URupw9Xhw23qptOpI3
 6JcsQuQ16DbUDoGEs7QzLbntC3edD0/rNihNB64doQcYZnRMcYCnFMiTYAhyOrWcl3a2
 4udA99gETGYqiFtdcFZlK1aR6PIAjTTIa+GO+F+CEPg40f276kN5SHfeFg/BNGTDwtVy
 0gLw==
X-Gm-Message-State: APuU4Z+2CO9HR7OsAh7MkIaA3qzKUSwOay2C2fZOVY+JQq1VAepbsLnD
 24+VEePPFiTYSlOHzbx8G9DhbxsdGIc12gLhQj2M+Fjj+aCIjS0EzQFUJfz4za5q0C7UQOjiGkE
 NvL+WwAs2os7jiXNOpX0mxf1qxxhqXLpc5aLhVD0qjPOcD/x+u9hPO0/3rX5mt8q6IhvI0wbTbt
 q2qAY+/WHMPCHBImsQ7O28CP39i3S7CfjbFbzNCg==
X-Gm-Gg: AZFdTZdzVF8UWne0q6Mota7ORcu2ccAiyGTpITnArcBIsaMPd8qwmsLYAjMTwbJw7i7
 9PlRUBXM2+S1P3b7eHqKH1A/py9ZyQAvFhSJE0HhXeqw3rXJu92I7Ffam81D6oyyHVIjWVJSXhC
 U9Th0AB3g5hqqnnh7h2dHFJJwM+hBN8xlH7W3rWFzjG0qZbdA32oML6lSuavch12FyQedrF8cqy
 bv74Fff0rl1EOpf24lkX3vYs9FmdJlPKyQiLRN66Pt8BmajJj6nQbQh9HsjeO6g8wNpP3gfRVzT
 6Gfs8qp1rxOUxMshMkTiCOgEPyX1kEGmq7GPi5GzqgTgToN+rvk6fHd4idMWszl/8H0jhxiGLND
 7c6Cq7WUfsIZkvKCYS/Z5Q7xfODbgKKj2ezxK5wbY31Ex
X-Received: by 2002:a05:622a:4d93:b0:55d:2e93:ffad with SMTP id
 d75a77b69052e-55d76ac5898mr209115781cf.37.1795441069935; 
 Mon, 23 Nov 2026 05:37:49 -0800 (PST)
X-Received: by 2002:a05:622a:4d93:b0:55d:2e93:ffad with SMTP id
 d75a77b69052e-55d76ac5898mr209114821cf.37.1795441069208; 
 Mon, 23 Nov 2026 05:37:49 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349f2186sm107887486d6.29.2026.11.23.05.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:37:48 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Hongyan Xu <getshell@seu.edu.cn>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: [PATCH for-12.0 v2] coroutine: Make yield_until_fd_readable() detach
 fd handler always
Date: Mon, 23 Nov 2026 08:37:47 -0500
Message-ID: <20261123133747.2571462-1-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hongyan reported a possible use-after-free of RDMA migration code:

https://lore.kernel.org/all/20260904033130.276-1-getshell@seu.edu.cn

The issue seems real, while this patch is a proposal to fix it in a simpler
way, meanwhile it should be a problem to the yield_until_fd_readable()
helper in general, so it should make more sense to be fixed there too.

The problem is about the use of the stack allocated FDYieldUntilData where
we must make sure after yield_until_fd_readable() returns it's not used
anywhere.  If the coroutine yielded can be entered from outside of this
helper (fd_coroutine_enter()), then the aio handler might be installed even
after yield_until_fd_readable() returns, and that makes the stack variable
accessible by aio codd, even if stack gone.

Fix it by moving the aio handler removal outside the handler.

Reported-by: Hongyan Xu <getshell@seu.edu.cn>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Cc: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- Drop FDYieldUntilData altogether [Kevin]
- Drop the comment, doesn't feel as helpful now [myself]
---
 util/qemu-coroutine-io.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
index 364f4d5abf..720d27d737 100644
--- a/util/qemu-coroutine-io.c
+++ b/util/qemu-coroutine-io.c
@@ -65,28 +65,18 @@ qemu_co_send_recv(int sockfd, void *buf, size_t bytes, bool do_send)
     return qemu_co_sendv_recvv(sockfd, &iov, 1, 0, bytes, do_send);
 }
 
-typedef struct {
-    AioContext *ctx;
-    Coroutine *co;
-    int fd;
-} FDYieldUntilData;
-
 static void fd_coroutine_enter(void *opaque)
 {
-    FDYieldUntilData *data = opaque;
-    aio_set_fd_handler(data->ctx, data->fd, NULL, NULL, NULL, NULL, NULL);
-    qemu_coroutine_enter(data->co);
+    qemu_coroutine_enter((Coroutine *)opaque);
 }
 
 void coroutine_fn yield_until_fd_readable(int fd)
 {
-    FDYieldUntilData data;
+    AioContext *ctx = qemu_get_current_aio_context();
 
     assert(qemu_in_coroutine());
-    data.ctx = qemu_get_current_aio_context();
-    data.co = qemu_coroutine_self();
-    data.fd = fd;
-    aio_set_fd_handler(data.ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
-                       &data);
+    aio_set_fd_handler(ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
+                       (void *)qemu_coroutine_self());
     qemu_coroutine_yield();
+    aio_set_fd_handler(ctx, fd, NULL, NULL, NULL, NULL, NULL);
 }
-- 
2.56.0


