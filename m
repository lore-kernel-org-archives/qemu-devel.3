Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239C5C3814E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8m3-0000Tr-7c; Wed, 03 Jul 2024 18:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8m1-0000Ho-DQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8ly-00047U-QE
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyIX+6gMMv2zX4UnJSMWLVmYqSE0wXcA/BACsQ8Un/M=;
 b=YP/j/qdn/tdzRdH6cFML/70+zmqGnLMQtIfp1tHwXXgbtjHCOnkWATLd4trgOVeF6GATSl
 qOaiEEJMiLAVd99oKzs3fmVmcPMd15JtZVmHOgtpeUoAFFzGO1ID75zFQakxY9/MrZWwPy
 Sfkn3sxUTKIPJfl6NFofFoM+PkPSe8k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Vxs0kUeIPE-L3XMs23MHVw-1; Wed, 03 Jul 2024 18:48:20 -0400
X-MC-Unique: Vxs0kUeIPE-L3XMs23MHVw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57cd2950eefso7256a12.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046899; x=1720651699;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hyIX+6gMMv2zX4UnJSMWLVmYqSE0wXcA/BACsQ8Un/M=;
 b=LVRb1ZLDnrk1hSM/wsp04rQvyvEMixGqTWy6k3h5ipLOPOInJiLHWp/qaJiisqbsqc
 9mrD1GS+fqdbt18ESsBQ81m4rUMGIDXaL4ZRlNo71pPWI1Wv5ZbMIhxfBEL3uLGF3fu1
 uvIK4SJBJZYuA7jCJEnWfS3+DhHPiZB2Wn7WGNDeNmtaQYqd2hHL6jBQRVWgj40w79mZ
 vZx0473kz/EBjzyoyzVgeWoPTG0zwyMFrcjpnLupYFkag38lAnkPaQqzEiE0JuuOOBcY
 5/Czq3fGPn+2ujOwjKf9w75vl1DtawAXJ0ZkLRfecWf0SyiLs//0J5JRbH4As89fYZpM
 ZEag==
X-Gm-Message-State: AOJu0YzInnahclCkCoDEA2AArfDgXCiIQkQGx+HStWZyZ9QLhAmhFChy
 bXnfdBaOtFnLurXkgJoYERcGMx3obDAiMz1UtFAzH9B3RCDyStSQw8mIYZJS5bkHhzRE2LacKyL
 2M2p/k200xuK+x6TENxZokUaLOBbzkOlpPoT38sQQO4ZQCsUCnHcI3AMIbcOCLJFDU60gTXP7bl
 vpTFXBHKa3IdOWm43/dxdWZFyyxMtY8g==
X-Received: by 2002:a17:906:fccc:b0:a72:548a:6f42 with SMTP id
 a640c23a62f3a-a751445451dmr825381666b.18.1720046899402; 
 Wed, 03 Jul 2024 15:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4A+KCXjcekCAj8XtlIjcEhjkXdKLdsCGNZZ1xPlggqsjz6zr21Ju4KIo+4DXpBxlvELmqbg==
X-Received: by 2002:a17:906:fccc:b0:a72:548a:6f42 with SMTP id
 a640c23a62f3a-a751445451dmr825379366b.18.1720046898759; 
 Wed, 03 Jul 2024 15:48:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b56e6sm542229266b.202.2024.07.03.15.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:48:18 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:48:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>
Subject: [PULL v3 51/85] contrib/vhost-user-blk: fix bind() using the right
 size of the address
Message-ID: <03582094da1ea7ce978cec58008c81f7458ee8dd.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


