Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF00FC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNd3-00062r-M8; Wed, 12 Jun 2024 09:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNd1-00062K-Un
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNcz-0008Bk-07
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Iv4GZfjfSmrbe9mbetH0GZZLouN4MvBd3gnn16kx+E=;
 b=L6QH9wy3hBUZZgA/mTT43HafJJoioMVcEbqMXU8I5MDChVYMA9CtAZQay3TGVIZL3Q4NJZ
 Ut4q3Jmdzpy6/zMFnDX9ENJQXcTK+TYarYRc3+2/95CTkKIiFVC/WN8+VfaZBsduelkn/S
 yPslW5zX7i+9/Qw9lwl+S1YD18nXPFE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-PY2O2vAVMRWMaHoite9i5g-1; Wed, 12 Jun 2024 09:02:59 -0400
X-MC-Unique: PY2O2vAVMRWMaHoite9i5g-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4405b0b5720so41552751cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718197378; x=1718802178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Iv4GZfjfSmrbe9mbetH0GZZLouN4MvBd3gnn16kx+E=;
 b=UmFJOUivccJ0DVN3I1egO3F66/fJELfnCBY1Ku0xbO2MejIRDdS4u2qod/V61lQ8Zg
 WT8j4Tz6CAz4udBViTruPUiqqvxGdhHckgPPo3H8CTMweIBcY8gHPQwkBrqAndIx2f+T
 +EjwOlQyvh9Lub4y3TFM3qbgbNbsKZUPEHHpFwX/w4ILE28VQifteQYNaU8IlCrZZNyQ
 g8CXKDMCp07fkKguk/jPJAodl09DPoOj9nBzIQhk2ZfFKf0anhSAZHhMKgBIlEGtcDWG
 JnaSzyJFx1aOEGWbmUMdh6lU9bUmpSiAHFY0Kyoa+WSlcT945zq0XIRMPghSMzTQa88j
 uJvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ0bT5ZKor6BKsxR8FjrwU/0yYTDQcwNBsQHPFyjUml0FWtjJ+8KPa/kCBU7SnKBhLgPd3s2SRDhO30/h0l0AwlAaPVbY=
X-Gm-Message-State: AOJu0YzrRAZrosktTKHOG746TNLw0ZUKu+gevOczWaxjx6kZelbZrAyV
 TpPFLSTfaY9GyR0Wos74g6obQnSEmlXzD5ScpANTexuYMLFLAIR8CALt9vaIaEDvy6hTABWfJae
 n3OEVP4HHdMaR8WSJRF000WWsTUW+dOX4YE5xht0ybTgJtDrUD0nS
X-Received: by 2002:a05:622a:1105:b0:440:384a:2dd2 with SMTP id
 d75a77b69052e-4415abf7c7amr22329591cf.30.1718197373377; 
 Wed, 12 Jun 2024 06:02:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvcv33Lq5iBdUj6iY5q3QyxaG/S+PFcfONjZLUF8jxPkPzL9CRBGfgN1zxblg+VOzACo35gw==
X-Received: by 2002:a05:622a:1105:b0:440:384a:2dd2 with SMTP id
 d75a77b69052e-4415abf7c7amr22328941cf.30.1718197372832; 
 Wed, 12 Jun 2024 06:02:52 -0700 (PDT)
Received: from step1.redhat.com ([193.207.132.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44057ffdbcbsm39647481cf.79.2024.06.12.06.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 06:02:50 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, gmaglione@redhat.com,
 stefanha@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH RESEND v7 05/12] contrib/vhost-user-blk: fix bind() using the
 right size of the address
Date: Wed, 12 Jun 2024 15:01:33 +0200
Message-ID: <20240612130140.63004-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612130140.63004-1-sgarzare@redhat.com>
References: <20240612130140.63004-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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


