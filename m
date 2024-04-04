Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFC6CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsM8W-0000nh-Tm; Thu, 04 Apr 2024 08:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8W-0000nS-2S
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8U-00011B-14
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712233445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKw7wwOpcT5LAk2fX9NUDEtqgiO584+Et0vV37YJJRo=;
 b=Hke4Z/5VkHOPfYvjDhJIRQoNvAg4pXurmNlaj890Nzkg5p7CLNjYXu/P6JELutgUHocrAr
 NYOL8NBIBbL0uIZzcTk9XvfLVNALiFGWUO98pw/ojOLaW+qbRj8to+NJvAz0UQ1y/y+A35
 sqP7u/fe3+Gt+2Pc/IdwJipBBVX5od0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-XpfEoJrEN2KAw9dAtJ_0_A-1; Thu, 04 Apr 2024 08:24:04 -0400
X-MC-Unique: XpfEoJrEN2KAw9dAtJ_0_A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a4d8e5d6722so74891466b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233443; x=1712838243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKw7wwOpcT5LAk2fX9NUDEtqgiO584+Et0vV37YJJRo=;
 b=P/VhoB6Jdipxuvy7d61MvKkFIg+1Yb+eoykcKEfHdoP/3CtlRUSBr0Mj3Caapy/CMg
 7aI4ebY3NGXZyZzgYH4dOSr2w3TXzSqlXxTVrrInjS10RrCruxRAbhPbEIJA/U+8MYbV
 /cBBagpHmAB3916EQd13RchPF0SVm5DuVVrJFoDgR6BGM4g4yTWUb5w91OlT5wmSRfO3
 51QU76zWlywakE+rLvrLUQR+poYxLhT1c7jwo7LIEVOXZIg43rvUaHOhgVHN9opXr9vw
 8/g8+sPAAPtg609IkwoBnMybin9Wdssmz2neJIVbSRW0inJTm2Vv2LRModZ1rLfKlvo5
 9VdA==
X-Gm-Message-State: AOJu0YwIFIfdkpenmb+f5/A0c7jVSpoAW4Tlpf8t6QO03Lv7cHUgTXtQ
 TqBOqNfrT+HhLCyNewmnet7FRhmH4/V5nCUZxL9PB8vQtCsFGaSJV/A5HZlAeo9qKC5XviqXopw
 DkFmjGgBbY7KdNZpyeFu26SBuET+45zpT+YgoHj1MAXLmCewS+T7IwfCpbCQ+M+wS1bP6dPAyYx
 Tg3kpZwKDy51wgV5LBTMKhedzga2ar6A6qlWHi
X-Received: by 2002:a17:907:7fa8:b0:a47:533f:2d0f with SMTP id
 qk40-20020a1709077fa800b00a47533f2d0fmr1870271ejc.66.1712233442810; 
 Thu, 04 Apr 2024 05:24:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUkMNDCbjmDXUBORv2+OjnxSPlQZHeZfj3puzvtjO4VS/SA9sf6x+sWV8YND+p4xcSVaYgrw==
X-Received: by 2002:a17:907:7fa8:b0:a47:533f:2d0f with SMTP id
 qk40-20020a1709077fa800b00a47533f2d0fmr1870237ejc.66.1712233442542; 
 Thu, 04 Apr 2024 05:24:02 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
 by smtp.gmail.com with ESMTPSA id
 he18-20020a1709073d9200b00a4729f093ecsm8939234ejc.53.2024.04.04.05.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:24:01 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v3 05/11] contrib/vhost-user-blk: fix bind() using the
 right size of the address
Date: Thu,  4 Apr 2024 14:23:24 +0200
Message-ID: <20240404122330.92710-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404122330.92710-1-sgarzare@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


