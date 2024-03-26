Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07221C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp72H-0007VQ-OI; Tue, 26 Mar 2024 09:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp72E-0007RV-FI
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp72C-0005Ab-7m
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711460411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKw7wwOpcT5LAk2fX9NUDEtqgiO584+Et0vV37YJJRo=;
 b=MElvr9m0N3+DzlPFs+YmV8FRcT2WHrHJQa6J2t6xbHXZY4hL2t5asUVxN5klurNkwtAE9Y
 2Tp3HCkPITXmUdbddrHM5MyL91SElsUyKiYjuMhEbNVME66xu5Qht+yqWBgNDCRGRhwMnu
 Pee14tE5+QwKhldPDHwqGTHZE/duJpI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-O-WKnm5sPqmSkwwk8aQm3A-1; Tue, 26 Mar 2024 09:40:07 -0400
X-MC-Unique: O-WKnm5sPqmSkwwk8aQm3A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3418f237c0bso2807342f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711460405; x=1712065205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKw7wwOpcT5LAk2fX9NUDEtqgiO584+Et0vV37YJJRo=;
 b=QnU90EDVz6179UiZNINlVOc9zyjfewbLB+qz0Y4umfAS2AEgQZPrE3zeuvWV9YSffb
 H7zPQD3SmFw2691YEjpHftd88VVHHCs91q99s3KgaYDteZkc/iRe4v7G+CMDVUKV/wse
 JLfMqOr+rnLi+B8GBo3Q1oU5+uk8QkvI5XG8ez8ZQ0FLBztDm3t+jYy2FwhqLtw7CD/F
 neafRngV0A0JN906xlx1eKPnUzD1c8E7JOUGjM5N6ROJz7WMrCkpEcKbRz5p/Di4e+4k
 Prdopt9dsHYGpH29JBi9N+h5bclejDvZK5dmCQhDiP+ndkHuyFcJZeJWSs2hggCAvcid
 suCg==
X-Gm-Message-State: AOJu0YzViYGBIyLLiKCkD3GTVXg5bX3vEbHE33CyBbjIQZx2iyJ2oqAm
 bn3gz3VfD1CLPYaFijZwuAtEpYwNWOxV9XLK3vrQYtsT3X3jAe3ExiRnlMZray6KhueSMtvXDWA
 F9aLgxde/pUgmeUJy/826Dx7sKUCDgeLe+lUFP4xp9CeAFOrDe6oAlp09bJRRX3MhG4tAQtRWJ5
 ROaoyjSKQM3nxCBYvVoiSrN0IFswlNoQ0d4PLm
X-Received: by 2002:a5d:6e88:0:b0:33e:bf11:a007 with SMTP id
 k8-20020a5d6e88000000b0033ebf11a007mr1015446wrz.31.1711460405408; 
 Tue, 26 Mar 2024 06:40:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtcEO0M9lq6C75Hqd6uCy0EDmER4gQXhoRzLyt0r3wluU94R3XlnCfYqFXYdF9WX/VBCfkVQ==
X-Received: by 2002:a5d:6e88:0:b0:33e:bf11:a007 with SMTP id
 k8-20020a5d6e88000000b0033ebf11a007mr1015413wrz.31.1711460405139; 
 Tue, 26 Mar 2024 06:40:05 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 t13-20020a5d42cd000000b0033ec312cd8asm12230707wrr.33.2024.03.26.06.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:40:04 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, gmaglione@redhat.com,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, slp@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v2 05/11] contrib/vhost-user-blk: fix bind() using the
 right size of the address
Date: Tue, 26 Mar 2024 14:39:30 +0100
Message-ID: <20240326133936.125332-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326133936.125332-1-sgarzare@redhat.com>
References: <20240326133936.125332-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PP_MIME_FAKE_ASCII_TEXT=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
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
2.44.0


