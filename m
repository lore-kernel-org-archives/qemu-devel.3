Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C00C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJVhs-0003WY-De; Tue, 18 Jun 2024 06:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVhq-0003Vx-Ii
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVho-0001Bu-Vq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718705088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Iv4GZfjfSmrbe9mbetH0GZZLouN4MvBd3gnn16kx+E=;
 b=O+vdnpPQ8KeVpYzEecBMXorGv89b/IozUw9nPLBKbWQpVDx0Svho0IIbNtCkbXw10MUCrC
 sh+KmPhCDqceNBqk3IGATm7UjmXAPx0D0i26kyjMAg6zTZ764JqjXZGPKmO915h4N9N3bG
 vkgdHZaYjA+bWuWXoJbuUGVysfaeJ7E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-0mK8aASjPeyJaGLrpFHv0w-1; Tue, 18 Jun 2024 06:04:46 -0400
X-MC-Unique: 0mK8aASjPeyJaGLrpFHv0w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42181c64596so32024695e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718705085; x=1719309885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Iv4GZfjfSmrbe9mbetH0GZZLouN4MvBd3gnn16kx+E=;
 b=umwyvDbWPICGqSpPWn3LAaEQU15CsxgaOasb7BJcmSI9S7IZ/VPRJ0XI0KeIkW2X4C
 TjMGmWIY3muKXy9j6s97/Xxikh5Mbk564j37nVvr+edCZG66ECO1pjEqyt0Ynv0f1YD4
 Jl/dgNp8qVsCEbwn6u+zIQt7uGBAF8q85yVtlhfncz8n8T2iDNvNfqH2kq0wmh/3KbSI
 SfN9z64UyOtrgdb3ZelXPAAz61pHQNr1GJvUt5PHSyesqjVyTmm0+VjkuJILUQ/Erwm3
 ZZbtbnjgF+8j7EZaUkYbHxcq8HfGZ25INOV5IjuyNzvmBoN04+Esli1lvyV400A9RJAB
 P6xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU220lLt9o61gS1cArJouY+4NA2eJ+lq08MzlgE3si1YTNRKhU2Xsn0ZzCr9fhLSWq6E1ATo5zYdKDtKhTCkqPyrqi5ig=
X-Gm-Message-State: AOJu0YygCL/rkLWvuBPd1kJ9mlK8pAm+e2v7CiIbxQZqEUPl6ttWmZgm
 xqFoWyT4Or1Byy0LX/rnjVxFzoOrbSsNZrXo2AY8K1f3STv6v4jH5xxjj8NHAdRLjstRAwT3JMM
 0nj+Ge9XRa/E56hwo7oKCYTVMGlqKWeJ8fMiPQxmOaFS9Vf804GFo
X-Received: by 2002:a05:6000:18af:b0:35f:2256:1722 with SMTP id
 ffacd0b85a97d-3607a7622aemr12290153f8f.33.1718705085651; 
 Tue, 18 Jun 2024 03:04:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2b0tg9SYAZ02QJF7y7JVz7gyuCyH/CzZJE7spMUKO6IIIbB9FDId7s6Qc5j0duGnSO0qNFw==
X-Received: by 2002:a05:6000:18af:b0:35f:2256:1722 with SMTP id
 ffacd0b85a97d-3607a7622aemr12290111f8f.33.1718705084968; 
 Tue, 18 Jun 2024 03:04:44 -0700 (PDT)
Received: from step1.redhat.com ([193.207.160.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104bd1sm13809681f8f.113.2024.06.18.03.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 03:04:43 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Brad Smith <brad@comstyle.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com, gmaglione@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, stefanha@redhat.com,
 Raphael Norwitz <raphael@enfabrica.net>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v8 06/13] contrib/vhost-user-blk: fix bind() using the right
 size of the address
Date: Tue, 18 Jun 2024 12:04:39 +0200
Message-ID: <20240618100440.145664-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618100043.144657-1-sgarzare@redhat.com>
References: <20240618100043.144657-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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
2.45.2


