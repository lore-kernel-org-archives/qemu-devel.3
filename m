Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659C7C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIQT-0002ev-6n; Wed, 28 Feb 2024 06:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQE-000239-Ch
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:48:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQB-00034K-9J
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709120902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERqbbN2GBkLZQ1HHjRaVA+d7aKobFGUJTjgGsOPEJxA=;
 b=aSdK6AlyQLHRnTwars/mXsL8Cr743H7+ni0W3JO33wBIYr/md/mCVIkRwJGAEa7WCzzEMo
 CEHURWrGBCDdbeHS3F8yFNLh+kIlB6VZIrnEY2Ga5VxatphyHb2Mpla+dCMf5OWEvEEaU3
 OlA4Qb4sN6JAlmTBXLqoJbr6Z0hKZIM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-fMnTfEsRNmO7mpEDIiNY5g-1; Wed, 28 Feb 2024 06:48:21 -0500
X-MC-Unique: fMnTfEsRNmO7mpEDIiNY5g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7830ab8fb5aso690667985a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120900; x=1709725700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERqbbN2GBkLZQ1HHjRaVA+d7aKobFGUJTjgGsOPEJxA=;
 b=IvviR/Vl/io5UJX7c3PoxtH5yb2D4heBNkAv/Nzhe3AIGW/Ao0KNoP5z1Xy3WaZaYx
 np32kEjm5GI+y9Hsd26cpUx3s4mjAcblXWIIxPsNGsiKDklAWMOywmTYaHSePe+z+t7j
 0Rs9nOOtFBqM27YkwO6WPYGiYUJivUB5Kdfbab7BpKONAh8+ALTIng6oWzph2id2OxGS
 DHk0nH6ocHBrSL35zOMpVbIxZ96lTbvBXXufZptrQlC9Vs/xy76H5CiSotPjbVDSB9M8
 /Uvm0tA2yAJ0DkL/RQLWYwnxnRseoufQYFb1U4IbZECMqWxdWpKm77Q98hrqZetvdQCe
 xVqw==
X-Gm-Message-State: AOJu0YycjTLOwn7ewRR8pKf8+m3tgAvUfCx187hJrYPzrH2yqNV29gXq
 dFRRb/Cefg8x5BhxCai6bafqGuR9gFWu6OlU/PQJlHNDm7A8MEI4stLY71uuVsm78mCoD5BnxZl
 vSfB9EA7Cq7GJtYlKsLyVWkTwo/VnSu4jEJpCaED53UhIO7aNlsfi6IQ86nPk+NZg5kRV9FAPM8
 djoLpZlDFHU85MilJmGEgD2GROs6GyboAPU8WC
X-Received: by 2002:a05:620a:2994:b0:787:870b:3021 with SMTP id
 r20-20020a05620a299400b00787870b3021mr6252027qkp.25.1709120900619; 
 Wed, 28 Feb 2024 03:48:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWCFBKAKLh2a9z+1xczZ5ji44WuCsPiijnvIyXIlLgM8olszwBXmmUP6TBWWSYAvrhcOd1GA==
X-Received: by 2002:a05:620a:2994:b0:787:870b:3021 with SMTP id
 r20-20020a05620a299400b00787870b3021mr6251988qkp.25.1709120900261; 
 Wed, 28 Feb 2024 03:48:20 -0800 (PST)
Received: from step1.redhat.com (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 j25-20020a05620a147900b00787ad5ca70fsm4469892qkl.122.2024.02.28.03.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:48:19 -0800 (PST)
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
 gmaglione@redhat.com, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/9] libvhost-user: fail vu_message_write() if sendmsg() is
 failing
Date: Wed, 28 Feb 2024 12:47:52 +0100
Message-ID: <20240228114759.44758-3-sgarzare@redhat.com>
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
index b9c18eee53..527a550345 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -394,6 +394,11 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
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
2.43.2


