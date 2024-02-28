Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4BFC54E49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIQT-0002jQ-Q3; Wed, 28 Feb 2024 06:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQS-0002WW-7G
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:48:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQQ-0003d4-HJ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709120918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8odq6HkFwljgpCpDbS6c4Z23ZlZa/5hXAt8C67LMRrQ=;
 b=bPlTHmi9ATd+Uuh5JT45eKhxJvEdFvjk7Sdtm1pM0ob/6zlYTKoUpA6STbsDrH+Q9ZD3C0
 1BrpjLoQ9ukG1OGoH8xceAXNrSp9h4SwVOQjKxrwv4gZ+5sImwRkuRYUI/C39K0HosRgF+
 hBtgxJXuRODDyMkXUnUzPHwwe/TIPEQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-Gz558MA7P0KdPR47mwwaHQ-1; Wed, 28 Feb 2024 06:48:36 -0500
X-MC-Unique: Gz558MA7P0KdPR47mwwaHQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-68f71d9992cso72053786d6.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120915; x=1709725715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8odq6HkFwljgpCpDbS6c4Z23ZlZa/5hXAt8C67LMRrQ=;
 b=kn2HAP41jroBipWRSzRGWHYqoIrikgnKrq8CeOA7IO/5NcNDXFxnIpjedl/HaDaIXO
 tGJhPjVVVBC2qU3MEjuPOuXpfHyF+WKcwC8AzHidGRfnPKUDZASQvjksaLUQ/jOrJnWb
 2IMwssXZAkMHuyvpZqnUkY9LCaQh8gFPy5MqSgovE0I5lUS+4G56iarfEh3pK7Ol2+Oo
 8T3S9twcBUguj6IFTnfDpLpUEVbcOY8r9ieNITxHtuFp/RzTPy/SAG90bnDox4jwMzW7
 LaZ6SZgIfi8deVpxitoFX0gzWzLTgVZXTkwhyLRGs1UuhBQLOxSIvaRnt38Axn8mL8Jb
 3tKw==
X-Gm-Message-State: AOJu0Yz5TSSrCA5R8vyK5PnbWStNafailsKWX/bRKEvMicCl4poUwNK5
 i3ElERDs/VKAK2nabam6r8dUWs3Cw/ti1M/pK0hIocNwGlcyAmYrT4FweAF4mrmWyKMNbY5xlRk
 DBiTSw+3tLSHnkL+XhK2c3wyE9ag4+DB0Q8FNebqX7XzKzF3sj2m0Sb187FG32UyiCcTtvyvMRL
 pAy/gQbU9SPTKKJ0xSjLh863/2k0Pq6IIE4Xdw
X-Received: by 2002:a0c:cc90:0:b0:68f:e766:5ee4 with SMTP id
 f16-20020a0ccc90000000b0068fe7665ee4mr4846630qvl.25.1709120915570; 
 Wed, 28 Feb 2024 03:48:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfNtXpzxbRm7H86tnWp9FQG4Uky3KM/o6Dl1PW1hGvW9zSmLrj+xdPSMGILOBiVLnkbqoRbQ==
X-Received: by 2002:a0c:cc90:0:b0:68f:e766:5ee4 with SMTP id
 f16-20020a0ccc90000000b0068fe7665ee4mr4846585qvl.25.1709120914969; 
 Wed, 28 Feb 2024 03:48:34 -0800 (PST)
Received: from step1.redhat.com (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 oj7-20020a056214440700b0068d05b81fb2sm5178666qvb.15.2024.02.28.03.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:48:34 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, stefanha@redhat.com,
 gmaglione@redhat.com, Stefano Garzarella <stefanogarzarella@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 4/9] vhost-user-server: don't abort if we can't set fd
 non-blocking
Date: Wed, 28 Feb 2024 12:47:54 +0100
Message-ID: <20240228114759.44758-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228114759.44758-1-sgarzare@redhat.com>
References: <20240228114759.44758-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Stefano Garzarella <stefanogarzarella@gmail.com>

In vhost-user-server we set all fd received from the other peer
in non-blocking mode. For some of them (e.g. memfd, shm_open, etc.)
if we fail, it's not really a problem, because we don't use these
fd with blocking operations, but only to map memory.

In these cases a failure is not bad, so let's just report a warning
instead of panicking if we fail to set some fd in non-blocking mode.

This for example occurs in macOS where setting shm_open() fd
non-blocking is failing (errno -25).

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 util/vhost-user-server.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index 3bfb1ad3ec..064999f0b7 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -66,7 +66,11 @@ static void vmsg_unblock_fds(VhostUserMsg *vmsg)
 {
     int i;
     for (i = 0; i < vmsg->fd_num; i++) {
-        qemu_socket_set_nonblock(vmsg->fds[i]);
+        int ret = qemu_socket_try_set_nonblock(vmsg->fds[i]);
+        if (ret) {
+            warn_report("Failed to set fd %d nonblock for request %d: %s",
+                        vmsg->fds[i], vmsg->request, strerror(-ret));
+        }
     }
 }
 
-- 
2.43.2


