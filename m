Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84451C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBuBt-0004R0-Rr; Tue, 28 May 2024 06:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBr-0004Mr-TP
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBl-0008EZ-Pz
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716892574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bUhfln96QjtAy11XUS1EjId/7CwaVd+bJQnV2M45BI=;
 b=AuaaOy/aHpVM6IjPXBG29/2M1BCYoRo4jKZ+3wdpXdk7PJXInO8mFjwEAp0WAF5o06N3dp
 ascgdisJJGpq0q4wbSKJ/GSq24tZHLzN3EqUIwPQXaX0RmDXjZgNYqJtxtwhntY2cfnUnZ
 /X4WEndmQ/WsgQ+i3oXXIYLa0tlgpwA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-_I0jgNvGMHCs0GywptXwaQ-1; Tue, 28 May 2024 06:36:12 -0400
X-MC-Unique: _I0jgNvGMHCs0GywptXwaQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3564bb7b352so372174f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 03:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716892571; x=1717497371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bUhfln96QjtAy11XUS1EjId/7CwaVd+bJQnV2M45BI=;
 b=aBZ7y/mX8H6ZE3ijJhiZLovTAuwxgO8XTp6KbpULqSK0NMofQXo2zz8VjlI32hMoBB
 xjLDeFSD+iaT+qJmjf/QoEu0bHUO/6OzHsYXA+3fHRsAEuqNE7xlFvwJE1xZKhw3J00a
 QcabgS5auv8t+x90oit98mC3L1do1476hbuZCVb2aykNFSFcjzTYO/lZ3fwj3mWOC+RS
 j11B4qi6jyHU+K1wI9pfFJFa3Y4Ah/2UgmCknhNXkED/1mYRMxHpndnQdeYoaatghalb
 MCcTtsx7Vt032gOySBGeyhZMU6Xb/AZJ0dIySenaa7ddkXwtJANNFs/arFiOqcId5lW+
 f+cw==
X-Gm-Message-State: AOJu0YyAEsHTNQz0A42BFAKMxv0ViNF/EGBKQMExPzrIpG9KUbktot5p
 6M+kLe2CW31G9t5OEpHAT3QY4Jer5L9LUZZZxgVn1C8BxtjqRujo/HSx/P/YW+U/yyHuvgRtS1z
 JSf9GX2E4Pr0Ps1EBjIl7ueKeedZSPV1bB7Gy5CwS2rpXkDPS/Z0LdmiMA7e5TsowklA7P/8kpk
 m2ku+7KNfF/mL4Zg1n4zz9Axh9qVNVEcfKolW4
X-Received: by 2002:adf:a316:0:b0:354:f444:c21e with SMTP id
 ffacd0b85a97d-35522186c5amr6992169f8f.22.1716892571334; 
 Tue, 28 May 2024 03:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLhNQ8/ZaebS0APBXilO61bzf36ADNcAkfEhqPDQzntQVYr0Z2ify1MYaBOdN0D+hBcqsHxA==
X-Received: by 2002:adf:a316:0:b0:354:f444:c21e with SMTP id
 ffacd0b85a97d-35522186c5amr6992132f8f.22.1716892570870; 
 Tue, 28 May 2024 03:36:10 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3577505a218sm8155894f8f.31.2024.05.28.03.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:36:10 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>, Brad Smith <brad@comstyle.com>,
 gmaglione@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v6 05/12] contrib/vhost-user-blk: fix bind() using the right
 size of the address
Date: Tue, 28 May 2024 12:35:36 +0200
Message-ID: <20240528103543.145412-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528103543.145412-1-sgarzare@redhat.com>
References: <20240528103543.145412-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
2.45.1


