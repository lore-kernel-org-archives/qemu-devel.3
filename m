Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B47CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRHL-00028M-Rc; Mon, 11 May 2026 10:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRGJ-0000u3-P8
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:45 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRGG-0007JC-1e
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:33 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c8016d642b2so2456292a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508325; x=1779113125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NsI6Qqs4AUchAJ89hl2uKc8SPPduRq1NaW8uY3dlWFc=;
 b=I+tIaful+U8PFhjg+bFUo78zYvyNsuOF2PMCOiEHPyD55qRCIHP+Smht65YZ1Fo1ko
 Dm+bq/brmzUEtUXVRvtHkfz7Urxl63CJihk1KSqTXcqhsj8h/iRg87SIXJZPG4A3d1ra
 +89JUc9tzHFYD3bzCHVcjYf8IahxSKeumvWIx3PENbFKtD7olPBnM1ymzv6xhkL1x9Gt
 MmP11WdsydVZjsxs8j0B6M/InaLJ/3f75qtFZIR1uNaEvQfCTwhRW/20g4HL2+pdT6Bm
 s71tFGesQl0waD2Jfd3zUdP6RsbN0u+Z2tuEJ7yvUJFsaa6IuJVewl+ehQ2nh5h+c82Q
 3lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508325; x=1779113125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NsI6Qqs4AUchAJ89hl2uKc8SPPduRq1NaW8uY3dlWFc=;
 b=W3TBcjetGZA2iWxsmftxRTRGn2ezrsdF9+JmuSzg9STbhDJGH/jTCOxB5yrzI4FFCB
 g+OowwdOywcKSINZXM8CEPb+omOM20vMK/VPCsCexHe2bpkU25oRAOyyocqC3XWzPFqC
 cgqT9kCjfQ9rPPz6ji/SSa63v85MOk/NHOerWZdUavBZZftPqXy08ie68xuT8VLQH2sL
 DZ8kKn+cfrGgXJ28UOV2t+r5n0fQPxgghy/KjLaTweSQ9FRMETiArZhr2smj2kkspzVP
 TqB3Ol/ijBJ0UOVIe8V6JaujQw64f9y2aCJ9kO8/Pj0mZXSzjvcBmxu2PUFI1yH1gmj1
 F94g==
X-Gm-Message-State: AOJu0YzbRZZYn/3O22USPiq1zbGid1TNj9EUdJ51nvwAOaJXXMbI9bc8
 lDeNkJ36YufTWIG84HpMDzZYqwe7qbBgMC6X4YBcGwIqQ6gh8Fq6YrWLd/iFX0f8eGE=
X-Gm-Gg: Acq92OEcjMK4Q11xr3zZabU5lhGbDfeyxmt3Q98VJtqzGnpIx+9Mnt/IWRtWHgo46XP
 it6myYJiVPm+tkMCx6luGdte4KVCfUHQ8n/5X+TDj4L3tlG6YFg2UM8rwFDPar4wgEez//n4Y6L
 0jLaQfaoADqIuDvqYO+Lg4aEV0GodK9ch5pDWhqNHuMGMKdGMSO380beuwvH6M0ugVtCzLc03gs
 P3bmWaQIH3xq9gDa8KG79pLo9FA4rfE2dxLy8/4qyEoJMiHe7BIbTDvr3vTZgsDSMdvdteYwH0I
 AsGLkfxKoYHUfKhcEYrNd+AOv9tZ4BUCRPjFKcNZzX3ru0f7qEvCEDiSD0L4b7kMM7CYWkTGZhl
 f5a1abG2BIiKydtlFJwA86XsPid7oLzd6tchMGo/G0neX3/GAgwnobzf8h2ST7LR1+dUzAjMTPO
 +ID2iCqpCut2pPyJpqv8g7LsdS70HpE7xiP5BuC/D5DPndmA==
X-Received: by 2002:a17:903:1a23:b0:2b2:6fbf:ea2d with SMTP id
 d9443c01a7336-2babc864863mr163916755ad.7.1778508325346; 
 Mon, 11 May 2026 07:05:25 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.05.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:05:24 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 11/14] vfio-user/proxy: Update tracking iothread users with
 holder name
Date: Mon, 11 May 2026 22:04:13 +0800
Message-ID: <20260511140416.28271-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add object_ref/unref calls with iothread_get/put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/vfio-user/proxy.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 314dfd23d8..eebe202c4a 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -898,6 +898,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     QIOChannelSocket *sioc;
     QIOChannel *ioc;
     char *sockname;
+    g_autofree char *path;
 
     if (addr->type != SOCKET_ADDRESS_TYPE_UNIX) {
         error_setg(errp, "vfio_user_connect - bad address family");
@@ -917,6 +918,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
     proxy->ioc = ioc;
+    path = object_get_canonical_path(OBJECT(proxy->ioc));
 
     /* init defaults */
     proxy->max_xfer_size = VFIO_USER_DEF_MAX_XFER;
@@ -936,7 +938,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
         vfio_user_iothread = iothread_create("VFIO user", errp);
     }
 
-    proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->ctx = iothread_ref_and_get_aio_context(vfio_user_iothread, path);
     proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
@@ -967,6 +969,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
+    g_autofree char *path = object_get_canonical_path(OBJECT(proxy->ioc));
 
     qemu_mutex_lock(&proxy->lock);
 
@@ -1021,6 +1024,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     qemu_cond_destroy(&proxy->close_cv);
     qemu_mutex_destroy(&proxy->lock);
 
+    iothread_put_aio_context(vfio_user_iothread, path);
+
     QLIST_REMOVE(proxy, next);
     if (QLIST_EMPTY(&vfio_user_sockets)) {
         iothread_destroy(vfio_user_iothread);
-- 
2.49.0


