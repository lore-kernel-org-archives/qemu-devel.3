Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83CBC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCe-00019e-Kp; Tue, 02 Jul 2024 10:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCY-0000TI-Go
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCP-0008Oz-KP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxEb4qxo9i3miZ1US5mo9RXgQJuGwUKVIRe5VRPOVeg=;
 b=hcOhzFQNRhF2rgYXTNPrtnMVWonoB/jzLBrg9r3+/3pN7mQ5XZsoNnq05qFJ7YeEH5v7mc
 VDLeICTCkHbXcv+ioOjOhUXrL6wMbFRp5zD0K1cgzJ2PoIAuLCH3dHfDMTVKHaVT/jQQrP
 AkHJNbHwhNP/+s8TGjaLT25frusMffI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-r9FVh6T6OYy47_jFDd2xtQ-1; Tue, 02 Jul 2024 10:09:34 -0400
X-MC-Unique: r9FVh6T6OYy47_jFDd2xtQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42566c4aa0fso34065055e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929373; x=1720534173;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SxEb4qxo9i3miZ1US5mo9RXgQJuGwUKVIRe5VRPOVeg=;
 b=mlJ0nK+feVyAJp00vFpK4AjGghLNyLl5DxARWi01UC+B1ULUeTfKxSQc3w1S2n+8cc
 B/gItovICwXJ2VHV+882lsLc6wFeUeSoNJVUJWlauAKPb9QeRCMsQjYBhktx/XJngJgv
 ygKC0rCfPWiNWdd6B9+IKNL0SQ6Tq/PvJTBR3bxgD4eUrbNxncpdZLvcVXtDlQAYWaPB
 c8RI3W1qifSjNX3Zu8Hd9/8Sl2wntNzr3ANe6ZHDEAB6nIOSSn0DhYELmek9jKj2pyPB
 PoogbAsRivUFI/UF5ixdMblrCv7CTl0FVpm7BiJDWeAdjxZ+hXDDxDCWFVYGTapK2psp
 vRiQ==
X-Gm-Message-State: AOJu0YyfL0YOMm8NlsmfPpAu1ze3KxW/auj/e6Fs/TJuGG3wKcTAVx7H
 0G/g+8Gwd53+e7SAWFs6hzOcl/Ki98+tETs3ja4SuXsjuQl2OY14/kXlW4Pu5a89JBREK6TG3g6
 GHb+Xtk99Bm5tvSUjj2h2kd5RIWErxQ3+hYrgqq7wT8YdUDHm6KOfcgJtYQH/h6oMZSzHSWIPEi
 QkFsbi0nhLksIkegVLCloLAIThfqmZ6g==
X-Received: by 2002:a05:600c:314b:b0:425:622e:32f4 with SMTP id
 5b1f17b1804b1-4257a05fa23mr66589825e9.26.1719929372794; 
 Tue, 02 Jul 2024 07:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1BtGHx3eNidc0n5ZSfOsQIaaK9K4v2v4fFuEDFetv/xuQfLhwK0nLWkgOLFCx7Dxgp5XUzg==
X-Received: by 2002:a05:600c:314b:b0:425:622e:32f4 with SMTP id
 5b1f17b1804b1-4257a05fa23mr66589545e9.26.1719929372219; 
 Tue, 02 Jul 2024 07:09:32 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af376f5sm200551945e9.6.2024.07.02.07.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:31 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>
Subject: [PULL 50/91] vhost-user-server: do not set memory fd non-blocking
Message-ID: <8b525353aee211cfc049f54c3a4b2788efc5cb9f.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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
Message-Id: <20240618100043.144657-6-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


