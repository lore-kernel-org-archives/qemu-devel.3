Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03C4CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsM8H-0000i5-5Y; Thu, 04 Apr 2024 08:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8G-0000ed-Ep
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8E-0000xy-QX
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712233430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e0qQ06PVKFywP7ew4GM4yPpqWIJ6sbW+Ybg5PYCFH7A=;
 b=h+16GMffgKUVrt9123vA2gx83dWFsFKFqGK4DPy+539rL+Z5Yzr3ndA9gl4pi+s5XfaIhG
 fI3R+vxdKUePISVPbqwV2qFNBohbK/5bNDRMsLhErj0FbITLoR9c5ieXB8msdG+sqtbfc+
 RrseK5m/SUwfOY+bgSnD5zc/Wrg8vvw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-M6ckj_pLMkO5D62Cs6cLFw-1; Thu, 04 Apr 2024 08:23:49 -0400
X-MC-Unique: M6ckj_pLMkO5D62Cs6cLFw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a4e846f0acaso77062166b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233427; x=1712838227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0qQ06PVKFywP7ew4GM4yPpqWIJ6sbW+Ybg5PYCFH7A=;
 b=mHujCzMjbvMdxClJzbPQPjxw+pvMlgx+GwdhAh9SVi4q3DDzKj67YKiDoxMow9OvKc
 RJUp7tZ88AMhlZXElFv5Z9LKlvNyWYGfyhdYMzb7UCEyizEfUTu/nMUoWk8yKwJH7A+P
 zVIt/tVZht4Y4Ha6VEf5y//KR7jnNCshEYOKpb8UHjjivxYqSKsRaUD40IS2Xs4Q9PW1
 Po9D4ypFYY2OH29RZXFzm+HLdBxTU1Ic/lr1p7LraenVGle3jp4kmhrwIbuyHEekSq7J
 0Ld9rZH+Q6eK46A1owNAyPQBU6NzrZJKnd2x2fA9goqpfFOribdp+5OdurlyFceC9dMJ
 Rh0A==
X-Gm-Message-State: AOJu0YxYi/PkV9sez9FZwAkjL5oZprS3w+7EYCvAyUkPk/UjV12HL3qQ
 PTs5VX45azp4QSiil7v7hIxr47keEqW7NZbfe8g9pC/g0Sls631mcRp/1P3AoIedcbWDR4zN0N4
 f1y+Jg+zKqVnAVqarUIbLVdjI9HD80PyPyDHPgJVUmUgg1SO3bLRezykXH2hZFmC7xV51am+Jdy
 y60KMac6kUxUFQGSXrUM85G7HJs+3VKIjoY6cl
X-Received: by 2002:a17:906:5fd4:b0:a4e:1154:fa46 with SMTP id
 k20-20020a1709065fd400b00a4e1154fa46mr1475026ejv.70.1712233427424; 
 Thu, 04 Apr 2024 05:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpmnAKlRvQWA3fSspahWldcTefg82FZZxs3TBbeilAReIUd1d/B90RxGCv9v7iPwbbnI616w==
X-Received: by 2002:a17:906:5fd4:b0:a4e:1154:fa46 with SMTP id
 k20-20020a1709065fd400b00a4e1154fa46mr1474988ejv.70.1712233426951; 
 Thu, 04 Apr 2024 05:23:46 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a170906539000b00a46dd1f7dc1sm8991860ejo.92.2024.04.04.05.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:23:45 -0700 (PDT)
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
Subject: [PATCH for-9.1 v3 02/11] libvhost-user: fail vu_message_write() if
 sendmsg() is failing
Date: Thu,  4 Apr 2024 14:23:21 +0200
Message-ID: <20240404122330.92710-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404122330.92710-1-sgarzare@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

In vu_message_write() we use sendmsg() to send the message header,
then a write() to send the payload.

If sendmsg() fails we should avoid sending the payload, since we
were unable to send the header.

Discovered before fixing the issue with the previous patch, where
sendmsg() failed on macOS due to wrong parameters, but the frontend
still sent the payload which the backend incorrectly interpreted
as a wrong header.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 22bea0c775..a11afd1960 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -639,6 +639,11 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         rc = sendmsg(conn_fd, &msg, 0);
     } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
 
+    if (rc <= 0) {
+        vu_panic(dev, "Error while writing: %s", strerror(errno));
+        return false;
+    }
+
     if (vmsg->size) {
         do {
             if (vmsg->data) {
-- 
2.44.0


