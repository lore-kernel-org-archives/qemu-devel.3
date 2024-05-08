Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9ADC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4bzy-0003sC-MV; Wed, 08 May 2024 03:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzg-0003Zb-2l
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bza-0000xo-Sg
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CT6o3ZwtECB2PcxE9pmEPhRk7rw6h5Hp8cLiKJNeUWg=;
 b=SX+dUMI097yLreglYeCHFWM6EJ0FmdpmTeyPP0rWuK41mFeC0wWorBxI4B7ifRDd0/rU4k
 8BqacXi6YmvDnOwRuH3DE0AupUlU7teuEOZjGeNZGbfHW91VQIVzGJfLLBV0foM6bVyAVL
 YDRcs2hck2/sNYSmOONJcAcvF8ZJkQY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-d1R5-qgyOOiGlKqXgmWGuQ-1; Wed, 08 May 2024 03:45:29 -0400
X-MC-Unique: d1R5-qgyOOiGlKqXgmWGuQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a524b774e39so52552566b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154328; x=1715759128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CT6o3ZwtECB2PcxE9pmEPhRk7rw6h5Hp8cLiKJNeUWg=;
 b=WlWxjuEZB5CUQRWp91v70qghhlmJing4xCDbJpwz2bHXHkKaKVbeFd65aMZJlETHbW
 ZGn76QhuCk3kbC+ktpc1+xTXANpJOmOIxDLEbAyr2Cq8/XndAxHCQn2VU1qsA5ovVQ7Z
 5KoxfRUU/EjX63wh082T7PfG7IIaqOukkCuWxjAmSMYRi1VmVcCGm9IDmh7czqyQg3ak
 dswdgA0hlRlGk3T00cL5bmUTefE8hPNC2d2LWbTftDu7xn9RRw3+13YueI0c0bs4QLde
 KrKch7z9UGBAzxUOiUv8tKg+/ruFJKL6oX8uQuz04583yk5UCtTNBfCI/LJwQIAU027N
 RUkA==
X-Gm-Message-State: AOJu0YwhzRdfw+Exn8jtnl1wCK1Aqpq8MaAwstuxFlRAvmZjYrJjehPm
 Wmf7pMqAnkER2l1xYCSX3DdcBfmFW3tRZOQcXCRal0RpckmBCNZiEO6RFf1VgLRa0miTSLf30a2
 2jhGYkTZ6vWjCNKtBGnlzlIL8hF3QqZtApVE990C+UrU+kSuM4pi+6Aqr29j5BeAvojHT2gV72f
 FNJG9rBx2tSYxRV1YKkNCR66gGvtW2U3JLEiqG
X-Received: by 2002:a17:906:6806:b0:a59:deaf:e81d with SMTP id
 a640c23a62f3a-a59faa6278bmr159690166b.33.1715154327815; 
 Wed, 08 May 2024 00:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlIU7ymKnMk3t2pDhs92VxcgWtrt9douFzguz3qfdrYMl7PPMI0+nYdbd8zyHAoOf1ZIOb6g==
X-Received: by 2002:a17:906:6806:b0:a59:deaf:e81d with SMTP id
 a640c23a62f3a-a59faa6278bmr159686566b.33.1715154327487; 
 Wed, 08 May 2024 00:45:27 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
 by smtp.gmail.com with ESMTPSA id
 bf14-20020a170907098e00b00a59c3e28917sm4030519ejc.70.2024.05.08.00.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:45:26 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 05/12] contrib/vhost-user-blk: fix bind() using the right
 size of the address
Date: Wed,  8 May 2024 09:44:49 +0200
Message-ID: <20240508074457.12367-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508074457.12367-1-sgarzare@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PP_MIME_FAKE_ASCII_TEXT=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.45.0


