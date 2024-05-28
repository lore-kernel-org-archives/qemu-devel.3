Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDDCC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBuBv-0004SH-J6; Tue, 28 May 2024 06:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBh-0004Kg-C3
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBe-0008CY-Cx
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716892569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcMdg1C44DPSxqgUst9QRh9S77EyKlJRt0SoqUaUqls=;
 b=CewPHu07UzAlzSu0tl9AZFaQAwSP+Wwomr5XhaN2qrVxf3QgFgRCdRzLxKWxH68LS49CaQ
 R05eWYbbaXAQC90TahpQbBGxXE/SJEK7IuixOkmq9sEp5OmF6nmvkDqgJsSJK1QjHMZic2
 TSzWKowAvY2NmLoaY6E+kA1cAaK8jx0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-fh72tz-zNaiG9cyQk-v6gA-1; Tue, 28 May 2024 06:36:08 -0400
X-MC-Unique: fh72tz-zNaiG9cyQk-v6gA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42120e123beso1600995e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 03:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716892566; x=1717497366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcMdg1C44DPSxqgUst9QRh9S77EyKlJRt0SoqUaUqls=;
 b=i7vXkKfxheGp345fL9JAXXKRNOqw+OxtIoJZB/fftYlJwO7ux1G9EuZFtxbqlcFVuv
 dgzsM1Oq4Q/+FDR9+ZdZIKA4q25ZwJZH5xB0yPIOwWNV+h0mXNftO0Hx5Pi2XHrdbFZD
 ssZZgfXZqHWe6vFk8nGAbHTHlaAO8XhtYb2fbyrpIvbHmoMJ/NPg5pxyr6MGSaa5UTay
 GRaJnwdrO8gFYDcF3t2D1oUgQqLbx+VRO8tNxznosEUfCaLyXeTxytTt6XZqHWeFACaV
 y/ZN+S5vqlRKqOa2AGDV25GGh0BibiANNn7KFiLKQBKt+2F1oSiCe9B2cpIwK6JIx/SE
 fBVw==
X-Gm-Message-State: AOJu0YwDrGkSa4INEvqGjCde3KHaTC/O30rW0puP39T4q+GVP2prOE85
 TsNw6V7I8ws4Hbu4y+z+tTuP0nWp+IFTgopvAVykfCzUDl9KUpZTVXpiZiHf8fEa5qIcKxeTJQw
 oSpCgIWQfBDNpUjldNf1rxT6tnHs1VmJSaMYTciSAouGBbrfT12fiHW4qI/zZHeZh9X2mNiLRUE
 9DWh3N75JPj8lT4tAiQB1+zQGAistRuNOe+8Oq
X-Received: by 2002:a05:600c:63d6:b0:41b:f6b6:46cf with SMTP id
 5b1f17b1804b1-42108a40d1fmr125049865e9.11.1716892566529; 
 Tue, 28 May 2024 03:36:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxGsL+lkv7+GYt5RQJfSGZRCesMmsGpI3fY/XA7nhVa5XJeLs/IwrQsfGn1paE/WqYCd4R2w==
X-Received: by 2002:a05:600c:63d6:b0:41b:f6b6:46cf with SMTP id
 5b1f17b1804b1-42108a40d1fmr125049365e9.11.1716892566119; 
 Tue, 28 May 2024 03:36:06 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f759f0sm165844865e9.28.2024.05.28.03.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:36:05 -0700 (PDT)
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
Subject: [PATCH v6 04/12] vhost-user-server: do not set memory fd non-blocking
Date: Tue, 28 May 2024 12:35:35 +0200
Message-ID: <20240528103543.145412-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528103543.145412-1-sgarzare@redhat.com>
References: <20240528103543.145412-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

In vhost-user-server we set all fd received from the other peer
in non-blocking mode. For some of them (e.g. memfd, shm_open, etc.)
it's not really needed, because we don't use these fd with blocking
operations, but only to map memory.

In addition, in some systems this operation can fail (e.g. in macOS
setting an fd returned by shm_open() non-blocking fails with errno
= ENOTTY).

So, let's avoid setting fd non-blocking for those messages that we
know carry memory fd (e.g. VHOST_USER_ADD_MEM_REG,
VHOST_USER_SET_MEM_TABLE).

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
- avoiding setting fd non-blocking for messages where we have memory fd
  (Eric)
---
 util/vhost-user-server.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index 3bfb1ad3ec..b19229074a 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -65,6 +65,18 @@ static void vmsg_close_fds(VhostUserMsg *vmsg)
 static void vmsg_unblock_fds(VhostUserMsg *vmsg)
 {
     int i;
+
+    /*
+     * These messages carry fd used to map memory, not to send/receive messages,
+     * so this operation is useless. In addition, in some systems this
+     * operation can fail (e.g. in macOS setting an fd returned by shm_open()
+     * non-blocking fails with errno = ENOTTY)
+     */
+    if (vmsg->request == VHOST_USER_ADD_MEM_REG ||
+        vmsg->request == VHOST_USER_SET_MEM_TABLE) {
+        return;
+    }
+
     for (i = 0; i < vmsg->fd_num; i++) {
         qemu_socket_set_nonblock(vmsg->fds[i]);
     }
-- 
2.45.1


