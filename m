Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEBFC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjy3-000740-MB; Tue, 02 Jul 2024 16:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxa-0005MY-UZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxX-0000gy-V1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyIX+6gMMv2zX4UnJSMWLVmYqSE0wXcA/BACsQ8Un/M=;
 b=MT4QBvNGQyLJyk0XewqnNroIRkBmn/VWO7fGCzznroYUA7eLd8QFi50nJPG5fFa48UlRot
 Tfx7S1SzMXX4Wmajuihv+czMQv7Xd231BN0GyWsx7rNcsKNxznJzcPReUkIt7K/DDYTsCa
 KsdEXVMSt3EFKOV9erDQIYFC2zPkWpw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-YaaaJHd1PyOHgRyag0WyFQ-1; Tue, 02 Jul 2024 16:18:37 -0400
X-MC-Unique: YaaaJHd1PyOHgRyag0WyFQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4256f895ce8so34846675e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951516; x=1720556316;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hyIX+6gMMv2zX4UnJSMWLVmYqSE0wXcA/BACsQ8Un/M=;
 b=G4mQ2bo9GdgMw4G5yRqhorFIQOYZMdQi+fK5hqn4cKVO7UJg4nCBBj4ZcLFHDPwE4W
 gwLEpetm9wWBYqOSG8HYt/qNL5FpldCx5GdJo7psPifVmKaEv4ze98av4+VOJ+hvaPCE
 YfWYaL4WkNqSMYkIImeEwJSgZKJvVfZgadM6tjbIJbZcJPCYu6atsU8bnUYDF+/rDGIP
 jp5CdPgCzUYQ3BMX6hh7oh8yEOdTJ/OMJZCbAOHYBHpCoSiIR2wqDqU4A5+D1J8FTE6S
 bkadVIpojW5ES9YMQYWhlFU9bVqlGk2QqVNQrgBCZmYy4L/8v/ZftBHhVMnlec6Qr3Ei
 M2EA==
X-Gm-Message-State: AOJu0YxDw3Fs+GdkJf4z1xkSPltChJNZFIOWIcAPJkdDhIslrFBhk6x7
 N2BT8h6UxkdKx5IRj/hL5Sk1jcl7sHQ5YFn74ltRhxvQfbd5xdE3nripyvZg4XDKP13zMBk5LYV
 sOXQDIy8aDeFqTv6Y+xylWgEnPLXngv3zHFnjRAhCNe/bcyQol7dwj78dv6OSZNK4u7vTwqKsiG
 FCKVZiZ8CnOTqWl7piB10MnAMtDY27IQ==
X-Received: by 2002:a05:600c:4f93:b0:424:acb4:2798 with SMTP id
 5b1f17b1804b1-4257a02b908mr61837285e9.7.1719951516085; 
 Tue, 02 Jul 2024 13:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqGaV9sk7NiblCcBgn9W5L6EiHuuZhthHbnR+r35kMf16sJMXYv9ZxsWSyz7m/CkU2luIVeA==
X-Received: by 2002:a05:600c:4f93:b0:424:acb4:2798 with SMTP id
 5b1f17b1804b1-4257a02b908mr61837115e9.7.1719951515543; 
 Tue, 02 Jul 2024 13:18:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fc4c9sm14109459f8f.86.2024.07.02.13.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:34 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>
Subject: [PULL v2 51/88] contrib/vhost-user-blk: fix bind() using the right
 size of the address
Message-ID: <03582094da1ea7ce978cec58008c81f7458ee8dd.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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


