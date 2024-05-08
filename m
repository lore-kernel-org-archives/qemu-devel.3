Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2A0C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4bzy-0003pB-Br; Wed, 08 May 2024 03:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzW-0003Un-KH
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzU-0000va-W7
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lre/0draOF6HH9l6k6o2fQVvpnBFZwZ7jVfKTeMsOsg=;
 b=a78b+pbqp4vDmuExBWVZ3r09XuoNbBFeP6XZ2adFQls8mOkXIdqiTbkkPb8G/Gwt2WAlPC
 rLwKwEX2ojc+onmW1YpMuqKQODAD0Du5A7jxjLOEL9IXXDMl7Lh2L1fEaClBBPLw8zPQQv
 3aAv/0LUvuqIHvTUdV6ZqDce/a6b8Io=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-WX2JHosFOme7Rev5IDdMog-1; Wed, 08 May 2024 03:45:25 -0400
X-MC-Unique: WX2JHosFOme7Rev5IDdMog-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a592c35ac06so55274266b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154323; x=1715759123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lre/0draOF6HH9l6k6o2fQVvpnBFZwZ7jVfKTeMsOsg=;
 b=e271RtZTmf5cxo+TuB6nueKJttORrQ/qQqIvFI7YUjsmvQwRHDWWoupL+gIrxeVDJS
 Vgy2kfTUGkUP4Gzo6ZLuDTX2eNvpDMfFqo8YPQ8N5z3jVPOG0p6Q0vwJnTVLdULRohSO
 pt8P2RwMzpi7pNoV8B69fmZTJ9kciGbxT2dEOO+UlaojDN9ioLrf1qo1IEMWm35i6LGN
 L2+X7ra4VkjYibe/fep8tz98fw+fJzdcw/zT0USx8pyowsRTBorzkgbB1JwnyjIvB7u6
 C66aDaxMepfX+lJYntdfo2ZhC3u3VeOTUOnd19vcR2pa+dRU/KekNoAohTS/Ht8TX2C6
 +Tnw==
X-Gm-Message-State: AOJu0YwWRO+hz3dXoVYoPl91SLnWEsGS6J4BqoBLpF//XaRqtm8Nd3wj
 munnZXXI2YEgUxRf24wMTFz2WULEOdVnEuXlLLsn3cqgOTBPs8XJ5RGDtP3ExOlIWlm52Z2PoU7
 RTfG5Z3oknkyKrOTaDwTzMKh9PupUugKYE0DSmV1B1mXdNHFRGldJ8eu7lfh2SW5ottqHrhIVvN
 EcpyEt9VnJDJXAAlzhIcOa0ywu96+lpv+EANKE
X-Received: by 2002:a17:906:558c:b0:a59:9f47:2045 with SMTP id
 a640c23a62f3a-a59e4e891famr370304166b.37.1715154323598; 
 Wed, 08 May 2024 00:45:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Y5yGG//3dXz+0naCgWcWmxEiOV6bEy1aMzP9DyQjvveYtboAeGq9PtkKFgvqPHHKRbh3gQ==
X-Received: by 2002:a17:906:558c:b0:a59:9f47:2045 with SMTP id
 a640c23a62f3a-a59e4e891famr370298866b.37.1715154322426; 
 Wed, 08 May 2024 00:45:22 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
 by smtp.gmail.com with ESMTPSA id
 wn3-20020a170907068300b00a59a5af8001sm5326505ejb.208.2024.05.08.00.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:45:21 -0700 (PDT)
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
Subject: [PATCH v4 04/12] vhost-user-server: do not set memory fd non-blocking
Date: Wed,  8 May 2024 09:44:48 +0200
Message-ID: <20240508074457.12367-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508074457.12367-1-sgarzare@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.45.0


