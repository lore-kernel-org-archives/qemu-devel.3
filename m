Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB4EC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp72A-0007Ei-6J; Tue, 26 Mar 2024 09:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp71v-00078Q-Po
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp71u-0004v4-BV
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711460393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e0qQ06PVKFywP7ew4GM4yPpqWIJ6sbW+Ybg5PYCFH7A=;
 b=Gq5/dk0czLKZ2uTJLYJqzu5nrTgUlXjaWRJlblWrUDHGydplh9mvrsisO2y/mVVSlOjGRV
 zENUBu6qBH38iy0L4CKZbk+O6e3WJ5f7Ic7cp4Xu4NQMGArxe3tCdTVmPjxfDYUOtp0nyo
 9RpOogz9G1PgIFL+tp7l+Z1wB9j6m74=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-Ao2HqfbuMgOC6Cxx5xRBUA-1; Tue, 26 Mar 2024 09:39:52 -0400
X-MC-Unique: Ao2HqfbuMgOC6Cxx5xRBUA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d6ebaf2199so6059011fa.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711460390; x=1712065190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0qQ06PVKFywP7ew4GM4yPpqWIJ6sbW+Ybg5PYCFH7A=;
 b=Qpi0uhhWAYaCCWNFyecEucjiyfQdd1qvcAITH1mHB7ScvSRO2YVYmUaMunPnpYTr3T
 3fQ10nIq3/2MUUXxGLIBqbIzP86c0WHf3HKeXOIT9Q8aXPAfqe0eDEceueKFK+rIt4Qq
 PdeNQgcwwKdPwbihnwIBBwXm9RARTfHjUHrZ0XLEXQ3Xkyeo/0rIfnZtcVJ84l6xirXe
 ImpZzuhPveId5i4PZP5iQukXnfyGR2BFwVpLaJKkLZsq2jDF1nNj5YJx5UUT+wPL0vo+
 V+aFs/jKWV9JUZ89K1rSU+ZeEvWRVvPoGRHHksSFBQ1J+8wjxuT6GRxOUb5MeIaU98Uf
 j7wg==
X-Gm-Message-State: AOJu0YwBZLEZQ/L0q6JpsitVoc1joHvo27Z2Ge6LGQ44kCSfYBJD6knK
 pyQUdLHi6lpPf8xrZhmynm0REzHK0Qit346kNLmfMDkuMB23RjStKWyiAfSXHEVijIqo7FHTxRr
 W1iNy07MFfLlmQyH0ixXCOsP5dA1P85QZAp52gq0XQavn9GjfVoxvBbzSa/6MjxMPp4f77ejcP0
 TV/CLzLy3BF0GWOvNU8/efNZzZ+evlstw1Vddj
X-Received: by 2002:ac2:5b84:0:b0:515:a733:2e21 with SMTP id
 o4-20020ac25b84000000b00515a7332e21mr1113572lfn.44.1711460390481; 
 Tue, 26 Mar 2024 06:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXMeJVb9UNLsatjzLHXHQe7s0tIPjM0905G3cw1On4yVBwzqvNnkiZe3GmStKAhEVLe2/27w==
X-Received: by 2002:ac2:5b84:0:b0:515:a733:2e21 with SMTP id
 o4-20020ac25b84000000b00515a7332e21mr1113541lfn.44.1711460389979; 
 Tue, 26 Mar 2024 06:39:49 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 h19-20020a05600c315300b004147c8dd13fsm11603766wmo.30.2024.03.26.06.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:39:48 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, gmaglione@redhat.com,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, slp@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v2 02/11] libvhost-user: fail vu_message_write() if
 sendmsg() is failing
Date: Tue, 26 Mar 2024 14:39:27 +0100
Message-ID: <20240326133936.125332-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326133936.125332-1-sgarzare@redhat.com>
References: <20240326133936.125332-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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


