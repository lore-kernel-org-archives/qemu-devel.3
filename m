Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748DAC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4bzs-0003az-8C; Wed, 08 May 2024 03:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzS-0003SE-Bn
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzO-0000q6-H0
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vs3QOPT0b+rkefawz4PPNw8XtECEjgm+FjXJsIBmtfo=;
 b=i5fMwZrFIGxXV/Uqcfj3hDCQz7qOiF8nWPf8NBRGd5uiEEBbJRnvGI4ZNIkS+yuXuApmtR
 2anxvrRIveFhxRyOfrBKbz86pTMDoq8h/FZ8ul3VF5I3RFHYCbhzpEiRgMzLJ2wF/1KbIQ
 7/1COt/PS23FKaD7kQ5VWA+DYoAOhYE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-LizKm5plOdKsxa1X90lQtg-1; Wed, 08 May 2024 03:45:15 -0400
X-MC-Unique: LizKm5plOdKsxa1X90lQtg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-572b3091d68so2349579a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154314; x=1715759114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vs3QOPT0b+rkefawz4PPNw8XtECEjgm+FjXJsIBmtfo=;
 b=d/hwByzQa/L3J5cG2xyondP8wIrYm9SZBIfet1OKqDPF7z+cn75LZ0OLqk6QgQqw+t
 gzY0Z9koa0+r25/Azrcgpmq2JtBTvl9RAOqSH3BlvbehsXjwMWdoJtRQ2Uj81fYa5Sn2
 s3hQLrWS76JuHxcc80qFAdcJl9J+FPvKJE9khOFeLpEnrJd8OPmXZ+CKkFzvFvTBlGRl
 Cn6ltG5vSMUAFFuw1/Ugd2EO14fx0YRMfXJ7AfFMo7fQ7wOBz9SomwN7VmvHrBKpn3VA
 1qayeLnBGFWvG2mg2TWQrpdhZmxlwD70fIdRGI0NElsW3uFngWmTBGrx7QnG+hpPxdvs
 0s2w==
X-Gm-Message-State: AOJu0YwSF5IY3kKX2GNOQv3uPw+rSW6X3Z0AqnUDW5D9dkWti9Ny/zsK
 GqV/ie5v3HvUgoQNcFDDh6/IqMAtPJz87szKIT/KDYo3dki8DsQ8PSq7Mbixo3HUs8JGE9lPhc2
 0FIbQiiOzpQV3BD3+smG28/tNTv6YcmeIHAQs30rg0CkoOhY5Ff7FJCxnV8413JKMRZpSm6P9UC
 wis7GMa+ZcLTc3Spqivm3I3xD6W3XvDPK62+e1
X-Received: by 2002:a50:9317:0:b0:572:8aab:441c with SMTP id
 4fb4d7f45d1cf-5731da5b65amr1253646a12.26.1715154314054; 
 Wed, 08 May 2024 00:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHrsrWeJgIT3Ek9Coozq8NQkbRqXhAGzux1zrYc55O/lshafDqRssXbCHqeprmjqg24zdK3A==
X-Received: by 2002:a50:9317:0:b0:572:8aab:441c with SMTP id
 4fb4d7f45d1cf-5731da5b65amr1253613a12.26.1715154313727; 
 Wed, 08 May 2024 00:45:13 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
 by smtp.gmail.com with ESMTPSA id
 bt9-20020a0564020a4900b005729c4c2501sm7303585edb.24.2024.05.08.00.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:45:13 -0700 (PDT)
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
Subject: [PATCH v4 02/12] libvhost-user: fail vu_message_write() if sendmsg()
 is failing
Date: Wed,  8 May 2024 09:44:46 +0200
Message-ID: <20240508074457.12367-3-sgarzare@redhat.com>
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
2.45.0


