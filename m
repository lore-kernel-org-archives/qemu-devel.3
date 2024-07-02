Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64349C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCb-0000u4-UJ; Tue, 02 Jul 2024 10:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCX-0000LP-9M
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCJ-0008Mw-77
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scNChYFZ1BVuw6o3t83CBrfTE58zls/yBMV5gH+83JU=;
 b=WppUF3NWkZLO39LZb7ZjpkOm2d47I2kWvSAk9WiWrnvNusqOCxMcRMp3dUwpCRhYnoc/I3
 6Ew3sO9fCLtpaaYhsnxQ+bjd0HrXOnvRBFV7V29Maoln5XBizz8AM9tAv4WStdQo/I/XTb
 D0Enzg1m9NWK0x8iT48O48B8QBROojs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-S6acrnn1Ofezw2_9JGVRPw-1; Tue, 02 Jul 2024 10:09:29 -0400
X-MC-Unique: S6acrnn1Ofezw2_9JGVRPw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52ce8969cf1so4160820e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929367; x=1720534167;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=scNChYFZ1BVuw6o3t83CBrfTE58zls/yBMV5gH+83JU=;
 b=BQnkxwN9PpyK/fC/9ULaMDQlmAz5S6fTT+u7Z3L+lQUYYtYt1YruMddjEvxryFOSRl
 +MlXcyhBFC5T2qijss6Cv9BMnY+MdYLQtbRNvUa+5PxfNq+MCeZv49sykZJ6u4AEJKTe
 aWZRNZKnRaswgwf4mB2ElzfqYxqeUZ16iNyJhLa88XR5vXNIBq2LZb7y8xbueSqJ3KjM
 Nw7G7UcqA5G3C9l2kZvw4HURMUTBRwLJCSKmoe7OQL5p8oOZh2YEMF4DvTM6OxMLXafT
 dq+mSSYW4lhE2TZPptAtJamKKDLMyoZKWhI0lKdCb2TAwtRwg2f++irUFpE4P2tlsKCU
 DEjA==
X-Gm-Message-State: AOJu0YyVm9895PL/xMKutDaCy+yNsglmuPDRz3LEKrpX1DzT5j0EMhA3
 /zBnq0h0y77H6sdir+9ZW2OX3TBgv6jXbNZqULm3dEnNljrvhW0y8dYI+rc+O2RHqvdIdaPJQ4A
 zihFoXv6Udr6NyZmceuEml2X3+Mp52ahSPu+wsOQebmFtQia+s3YmM1X8dzDrjSw87FB6MRvoCy
 CZqh0nKU7F6bxU4T2hKs0SwLhfcnlboA==
X-Received: by 2002:ac2:5df5:0:b0:52e:6fe8:f0f with SMTP id
 2adb3069b0e04-52e82672582mr4932280e87.28.1719929367303; 
 Tue, 02 Jul 2024 07:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfZnHNeH4IoN8JQ5dcX1pjgpcdMDb2pFE+QlN8mPQSx9HPLECOCmM51jkKkjmljLmxpg7Ecg==
X-Received: by 2002:ac2:5df5:0:b0:52e:6fe8:f0f with SMTP id
 2adb3069b0e04-52e82672582mr4932258e87.28.1719929366739; 
 Tue, 02 Jul 2024 07:09:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097b82sm203172225e9.34.2024.07.02.07.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:26 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 48/91] libvhost-user: fail vu_message_write() if sendmsg() is
 failing
Message-ID: <f050628012f54369c6638f18cdd4de6fe94966db.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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


