Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384BDC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCi-0001oI-Gb; Tue, 02 Jul 2024 10:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCb-0000rg-J0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCW-0008Q7-4A
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyIX+6gMMv2zX4UnJSMWLVmYqSE0wXcA/BACsQ8Un/M=;
 b=OYOKjyRAPTtSeqUKoXuFaFRpPYwD4G3Pj7qzdqpoHJ3bFagVOP8CbZVNrKK3IXHJFB8WeE
 Ulev7elPpALOJaDBMhSyu4CaLcUZYcvZd/PxI5+0QF4RWesWFwsjVuDp2ftlxIjLu3BvJM
 XkFUxaJ/50LQoYkM40xcBREW4ViRfVw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-XH3OD9E7M3edTRJ8jg-vdQ-1; Tue, 02 Jul 2024 10:09:37 -0400
X-MC-Unique: XH3OD9E7M3edTRJ8jg-vdQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36743ab5fb3so2631494f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929375; x=1720534175;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hyIX+6gMMv2zX4UnJSMWLVmYqSE0wXcA/BACsQ8Un/M=;
 b=MXdnR0ELlm+G2z3IDLK4evfbiQ4onYDUkKCn4u+Y7aVGTnoJTcXAvy3mpcFZRNbeSn
 8allZ+Vrqcd9LJkgvg4bTRYXK6nUEc6j5q2AOGvcflXmPH9t4mUNOVIb0tFDxqFi+Isg
 GmgrAW/OvIowyQeEw3hVkcIiWtRMeNcYp0kpC9cntg9lPW6rt+Zbfn0Jvz10RkHmaGWF
 nPt6Gvm0YnT1siLo4WOlqGsvt9MpfbM+sZu+3VDgrv8OcZ6cgv82ppq/gKCYjuXoiOCI
 VzIfIuoPO9r30XLdU0LSVg75xrzkEARY1qZ44lefBmj4IHBJJrVgZcoomvmwcg6DzS0t
 BSBA==
X-Gm-Message-State: AOJu0YwdwKTn3c/0LvdlMVcJg8Rc+VSwF4Hxhpx0Un62fSO2bMznA4Dw
 zXtMMRTC8dzBu1tq/ezy/3+NhJDraxBQA53UJhJal7lVlc0T4bebcGSBFnSEe0sBEAG3D77F22X
 cUXkPbQfUbQJJVlRpmHjqJGUVLyACVtd4y2sQCqJHOhEQhow3gAA6WS9SxJdnQyvD1rmixvUsxF
 UQ0Ia+v/BZlTpzf7YbX1I77e9EQzyOIw==
X-Received: by 2002:a05:600c:3089:b0:424:ab8c:a24e with SMTP id
 5b1f17b1804b1-4257986256bmr76503945e9.11.1719929375473; 
 Tue, 02 Jul 2024 07:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbmq/VKXGOolJIsaGFW/Ph9dgGPejQhQd6cTLWIFBNxtohAqRTAk08vXxhV72OoQatigxOiA==
X-Received: by 2002:a05:600c:3089:b0:424:ab8c:a24e with SMTP id
 5b1f17b1804b1-4257986256bmr76503545e9.11.1719929374866; 
 Tue, 02 Jul 2024 07:09:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3cf9bsm203206195e9.8.2024.07.02.07.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:34 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>
Subject: [PULL 51/91] contrib/vhost-user-blk: fix bind() using the right size
 of the address
Message-ID: <f198e30f0ade672979b27700db856817bdc798b9.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Stefano Garzarella <sgarzare@redhat.com>

On macOS passing `-s /tmp/vhost.socket` parameter to the vhost-user-blk
application, the bind was done on `/tmp/vhost.socke` pathname,
missing the last character.

This sounds like one of the portability problems described in the
unix(7) manpage:

   Pathname sockets
       When  binding  a socket to a pathname, a few rules should
       be observed for maximum portability and ease of coding:

       •  The pathname in sun_path should be null-terminated.

       •  The length of the pathname, including the  terminating
          null byte, should not exceed the size of sun_path.

       •  The  addrlen  argument  that  describes  the enclosing
          sockaddr_un structure should have a value of at least:

              offsetof(struct sockaddr_un, sun_path) +
              strlen(addr.sun_path)+1

          or,  more  simply,  addrlen  can   be   specified   as
          sizeof(struct sockaddr_un).

So let's follow the last advice and simplify the code as well.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100440.145664-1-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 89e5f11a64..a8ab9269a2 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -469,7 +469,6 @@ static int unix_sock_new(char *unix_fn)
 {
     int sock;
     struct sockaddr_un un;
-    size_t len;
 
     assert(unix_fn);
 
@@ -481,10 +480,9 @@ static int unix_sock_new(char *unix_fn)
 
     un.sun_family = AF_UNIX;
     (void)snprintf(un.sun_path, sizeof(un.sun_path), "%s", unix_fn);
-    len = sizeof(un.sun_family) + strlen(un.sun_path);
 
     (void)unlink(unix_fn);
-    if (bind(sock, (struct sockaddr *)&un, len) < 0) {
+    if (bind(sock, (struct sockaddr *)&un, sizeof(un)) < 0) {
         perror("bind");
         goto fail;
     }
-- 
MST


