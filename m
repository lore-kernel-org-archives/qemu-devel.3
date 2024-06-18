Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0337C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJVeO-0006St-K3; Tue, 18 Jun 2024 06:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVeH-0006Qx-Is
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVeG-0000mn-63
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718704867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYivD0Oj8DZaeGa3x1w3lr0EcGpbXryh/Rf51uyXwz4=;
 b=d3xuxWIr2xWn1Fz3g78CQC+AKaRxR4KAxbaZRc05NTd4vQUbFTpkntOdWo8jHcOVst47PS
 LOjOk/EVTgFk+erXgMYNpdDlMLpljBdLiDbEqmfw3pgPdzVTO2SgfSd0aFwniPVFWs7/5C
 7s/vqCmfC6n88BBE/NEOpg0muRBZ8fw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-Wpz5d1NdPRCKETkRsMs6gw-1; Tue, 18 Jun 2024 06:01:06 -0400
X-MC-Unique: Wpz5d1NdPRCKETkRsMs6gw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4212e2a3a1bso34589945e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718704863; x=1719309663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYivD0Oj8DZaeGa3x1w3lr0EcGpbXryh/Rf51uyXwz4=;
 b=aJbOTzVrvWgsJpDCUgbpRk4XEqTA5bEI2i09wd6xMLAHDm1HJRgqouoHhsL4guZuAG
 LG4u0BlNA/8dsWCMF2qt72ue39NiPZuEVzRgpyHnGPPpHsCF3ijD7fZSllv006Z2NVLe
 nJPHxOwgYHJme/+qTRNwC1QjZS9eReQuc5bOxpYOQffHog+BJNKHGFOOookFoRvZN/VH
 s5W4FmoHRyONIKxHYWq7JotCB8VMrgz3TMGUbwgg5Gfm1malpQJdAAvcuAzFqB3wG8xn
 YWzpXhZgtoxxRgDUcoV3oSqn6cUQ66W5tvwmSv0MnCMKfvHKghaFxQIno5jrXrB+OZQc
 wdYw==
X-Gm-Message-State: AOJu0YwyffHbXioYxWgVw6uErQm2H+RtMF05SA5SiEw/QquekN4RWnH4
 QjkYiy57Gc9RBrzJCoHzP35rln2erlpmur0+ZpG+/r2L6nh+56/vlTJ7V2VOuJYND2r5PG5MeTe
 e/lzL1wDwYg8V5Va91mpcGsHYENBF9xECbwluB/S3XXm8KpV9XCVTKd+CfyeOHH8eNZLVWH1l2L
 FTEfwrxVIDkILLnaRD2PecVvJopw6xFOc4ukAh
X-Received: by 2002:a05:600c:3492:b0:422:720a:1bef with SMTP id
 5b1f17b1804b1-42304825b7amr83208035e9.24.1718704863550; 
 Tue, 18 Jun 2024 03:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ+vAj6lu23qAiopYx9ERsQ1Lgp25YRq6ksq8ZfSPrx1enqhTSTiTcPr8D1YTQX3ncN22zMg==
X-Received: by 2002:a05:600c:3492:b0:422:720a:1bef with SMTP id
 5b1f17b1804b1-42304825b7amr83207605e9.24.1718704863097; 
 Tue, 18 Jun 2024 03:01:03 -0700 (PDT)
Received: from step1.redhat.com ([193.207.160.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874de5d5sm221194775e9.33.2024.06.18.03.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 03:01:00 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: Coiby Xu <Coiby.Xu@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 stefanha@redhat.com, Markus Armbruster <armbru@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Brad Smith <brad@comstyle.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, gmaglione@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v8 02/13] libvhost-user: set msg.msg_control to NULL when it
 is empty
Date: Tue, 18 Jun 2024 12:00:32 +0200
Message-ID: <20240618100043.144657-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618100043.144657-1-sgarzare@redhat.com>
References: <20240618100043.144657-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On some OS (e.g. macOS) sendmsg() returns -1 (errno EINVAL) if
the `struct msghdr` has the field `msg_controllen` set to 0, but
`msg_control` is not NULL.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a879149fef..22bea0c775 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -632,6 +632,7 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         memcpy(CMSG_DATA(cmsg), vmsg->fds, fdsize);
     } else {
         msg.msg_controllen = 0;
+        msg.msg_control = NULL;
     }
 
     do {
-- 
2.45.2


