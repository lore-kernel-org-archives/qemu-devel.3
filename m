Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4808CC31D97
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjxx-0006Xu-HK; Tue, 02 Jul 2024 16:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxX-0005MT-UN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxQ-0000bg-IH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scNChYFZ1BVuw6o3t83CBrfTE58zls/yBMV5gH+83JU=;
 b=IKy4HJ6KvtbgQlyfcU8Fo78Oarqj4K5T8/E/5Z76QSgYPRxzqH5ZT5wzdGSPOvvvGJHiEt
 rlD/HLIu/tgf6ZIJexiPM/E1NDmHik8aFQfZZH9kH4UQC68JUe+CtMRvp9C38+TjAd/Tbu
 oMvLVypcN/mn62N2IvkSC9pIhy2uBhY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-A3js8H_0Pqe8RXNsLzvsJQ-1; Tue, 02 Jul 2024 16:18:30 -0400
X-MC-Unique: A3js8H_0Pqe8RXNsLzvsJQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4257f95ffc6so19714105e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951506; x=1720556306;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=scNChYFZ1BVuw6o3t83CBrfTE58zls/yBMV5gH+83JU=;
 b=xSDrs3VvM9iIj4xK7nPE5Ah4+K8G7oAW/wtIW9FckzpFlf5y/0XX+qgKPKuc88U2uU
 ztQSrwkNUbMRxOcA7nA9Dyr4lCbX6CkVUHhx5P5x9wYaWU1VaK9jmoKHBPgPfDvWP8JF
 FZMbjemPtWBcYsLcfL8QVTHQ8SLzqxwGsLPy5S50en8rXXR0Bqwepfhr+mtDqA6N0f8n
 wIvlqtvBzy0/iif6Zdl6KoU0JRBH7yv3XuFk3cQlM3EpD2MF7B0Ca3+0wFZh9KXpwpYh
 ZjhfEv5M2PZq2aCZKcQCimXwDZsn/h47T4rXebRfMHwt0udCAI4WZI55ocKVYadfrpPo
 hhLw==
X-Gm-Message-State: AOJu0YwLHzPjkTgvXvIsJNRkvnNVbLqNSdwnuhoLRo/I0PBq2QZALXUC
 hMxqZzEuvf6cJhasnDAhQQoFi7FZsxHzPvG86guo5yLHHxkQd+39e/lPFHSGyPjm7204fS1LZw4
 u7ecQjvija3ox+KUpLPTsI9O4zN9EzrblCZjEmViW0aTcIrZegNUXY9J1Prh9s4BdfODGN9GVsx
 +sR2P/6yuHD34TZ3x8PWxo+jZltV8aLg==
X-Received: by 2002:a05:600c:4fc5:b0:425:6f3a:651d with SMTP id
 5b1f17b1804b1-4257a020e78mr65389795e9.27.1719951505837; 
 Tue, 02 Jul 2024 13:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqRAbKOX6Gv0g7eHEcu0DFJN2qaEJJgG0DWX/1BFxc7uW5te+F0biTZ0ZXQWm5IXZihgjSGQ==
X-Received: by 2002:a05:600c:4fc5:b0:425:6f3a:651d with SMTP id
 5b1f17b1804b1-4257a020e78mr65389615e9.27.1719951505329; 
 Tue, 02 Jul 2024 13:18:25 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bcbsm211126005e9.35.2024.07.02.13.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:24 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL v2 48/88] libvhost-user: fail vu_message_write() if sendmsg()
 is failing
Message-ID: <92b58bc7e9086e489295040d408118a81c47b31d.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

In vu_message_write() we use sendmsg() to send the message header,
then a write() to send the payload.

If sendmsg() fails we should avoid sending the payload, since we
were unable to send the header.

Discovered before fixing the issue with the previous patch, where
sendmsg() failed on macOS due to wrong parameters, but the frontend
still sent the payload which the backend incorrectly interpreted
as a wrong header.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100043.144657-4-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 53bf1adda6..ea27683dac 100644
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
MST


