Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA418C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8lv-00082K-BK; Wed, 03 Jul 2024 18:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lt-0007oR-JG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lk-0003L4-KL
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scNChYFZ1BVuw6o3t83CBrfTE58zls/yBMV5gH+83JU=;
 b=NgMjOeQ0K4cD6/o/bfVEqWKc6xaXA2dum5OiV//AhGx2OeTabgAfB0vOH1DzbizRPKVCvl
 4U6MDyuMvlI+MFv0+CrOZfUwtFdZ0nkmHMqt2tN+VyHMrcs/84NxT+39cA0XZFvyZi3PZU
 JR8bwzmfFoW7FWCRnkgAINWiTmtfNC0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-I2XGo_AvNse_UfcwiEdJCw-1; Wed, 03 Jul 2024 18:48:07 -0400
X-MC-Unique: I2XGo_AvNse_UfcwiEdJCw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-58d152f7f67so3253a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046885; x=1720651685;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=scNChYFZ1BVuw6o3t83CBrfTE58zls/yBMV5gH+83JU=;
 b=Tlt157/pUMrkyw1Mz4SDedBQfrDma9/ssYZVGeu7GBFFlLThtgUrOz1mAWRFjyQPpW
 nLUUR8vRZo6eh+F5NEh/VYR3020vl2Y2yX34C9077c1dgEfNVZQYAjb9VGzhKiaDpzve
 6aHa8ql6CxKXt8FpNCNBexrHC4gS54quy4Q3SKXUPxUYbnyE6NA/6Svz67Gt4Dhk2tRH
 e6kdTRjv4ht0M5/7PCk5Vnvf7hOVK/VFJSKPAO8nHN4sJteC5gaM8xJQS1WkghkJMZEr
 3D3PhG5q8ROr5UPr5yts5Sub11BLDY11ymqZjfY8KqYlVCT+8NGTSXo4ZOfYFMvltmdi
 SNOw==
X-Gm-Message-State: AOJu0Yxj0bncnhH1wUHCZb+xOOjZ9adU0tmH+u3OwCEcJbKfgs2B0reK
 TekepoEVTCkgoMjRlbtMcvyxz1MHD9u0kTfki4JMd1JIctfBiGs/k2OVANqMtiOw8ehNJp1nHX1
 O8twglzbe6qkLocS241sde/MFp56LE5pzgvpRbteuR7W2Pa6ulanXhxkVpncxrDgna5kpoItAVo
 RRbqfwY0IIzzHEzxJ+sb4s+jry/XcF4Q==
X-Received: by 2002:a05:6402:50cb:b0:57c:80bf:9267 with SMTP id
 4fb4d7f45d1cf-5879ede2ab6mr10478060a12.6.1720046885600; 
 Wed, 03 Jul 2024 15:48:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTuRyAhNOe+KY4BzSb/gPd1hPUPDh7S5yzsm9XCPAOXJMOKieHxXzKJi8dxh5LiSyd/YNNbw==
X-Received: by 2002:a05:6402:50cb:b0:57c:80bf:9267 with SMTP id
 4fb4d7f45d1cf-5879ede2ab6mr10478034a12.6.1720046884898; 
 Wed, 03 Jul 2024 15:48:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58d10ef413esm1261827a12.66.2024.07.03.15.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:48:04 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:48:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL v3 48/85] libvhost-user: fail vu_message_write() if sendmsg()
 is failing
Message-ID: <92b58bc7e9086e489295040d408118a81c47b31d.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


