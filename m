Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0429C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNcP-0003Td-U9; Wed, 12 Jun 2024 09:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNcN-0003RE-HM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNcL-00082k-TQ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Su7ClX2VsFIEko0OXJVvgHI4Li50SabFJTO7o/P9fMs=;
 b=g/Jjp/MUT9cmEymAuu1oTMstFVioDCArQ905CPOg/xCIWPiVO4kqfop+5hIe5DWU/a4O0p
 cLd5+EPPM/qZQQEYc5MpIeUZBoH8sVkETse+Eqp6cuLMCt+M8lp7cI/8yTTD+qy91vp5OQ
 +JU47zf5fn94goL6XumAL+q80qvNoUE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-otdwcqrwNoeLinQ4Gj14OA-1; Wed, 12 Jun 2024 09:02:19 -0400
X-MC-Unique: otdwcqrwNoeLinQ4Gj14OA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4406476507cso20626791cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718197339; x=1718802139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Su7ClX2VsFIEko0OXJVvgHI4Li50SabFJTO7o/P9fMs=;
 b=UB6PqWib4hJuOVuxNe1wEWEPVe8u8w0iu4Oqr26OBAC3IUr33md37MF496kg+Rd7P+
 IUvSzHG/+ETlxN/IyJWnHyoWx+DAfiRBLmbdgskdQPt1Lb7vRMA/Vj63ICf31NG7gmw7
 ZRy07zPv1GskjSmpaYrWhyZFxMFRQkAcEiXq5GLf7o506cFVb6klN6O5V145lqTsD34a
 bp539VWUVTEp4oMQPAecbTCxYWt8i2F7RpFAIqk1ct0CmMEqfXnUmuqnSyWM2mituwE3
 aMTtfiiLXLQiYjB42gbGXICKpwhHdm4ShHNKOTHPgHTutEiKb9ioUELTKgFLWJBTkRVa
 KBGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfZnz/Gk9fImFCbbZcLWB4U6bYWPq4BpWJ3y8Qb79qks268l3kokhySLvNFMxpfqULPW+7+2uabWLtEZx/ILFOCgovBrc=
X-Gm-Message-State: AOJu0YwFaGqMp4YWVtf/zmKTkjbnSWIwhZvnmFgGCd5ODD66GN+rUpDG
 gUy0qMF3QgZH8ZPfAcGZRsn7sHRKxY+aPHuIIsImu8y1PgW108AaooNvmWUYZmL3lbszZv6ozS0
 LL9f7qJU1jES6R0/17arvAvlyg9027wPTOUwWaaVZadTdgs00WAyC
X-Received: by 2002:a05:6214:3291:b0:6b0:8b40:c7e0 with SMTP id
 6a1803df08f44-6b1a731b7d6mr18097986d6.44.1718197338850; 
 Wed, 12 Jun 2024 06:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEderl/MfePzFiHQ2ncxEuElJrm+4BKYlXdhuE/JLFmI8+4UqTQNNgTmOVLm1w6aUl87AC0UQ==
X-Received: by 2002:a05:6214:3291:b0:6b0:8b40:c7e0 with SMTP id
 6a1803df08f44-6b1a731b7d6mr18097576d6.44.1718197338326; 
 Wed, 12 Jun 2024 06:02:18 -0700 (PDT)
Received: from step1.redhat.com ([193.207.132.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b07a727eb8sm33527016d6.9.2024.06.12.06.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 06:02:16 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, gmaglione@redhat.com,
 stefanha@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH RESEND v7 02/12] libvhost-user: fail vu_message_write() if
 sendmsg() is failing
Date: Wed, 12 Jun 2024 15:01:30 +0200
Message-ID: <20240612130140.63004-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612130140.63004-1-sgarzare@redhat.com>
References: <20240612130140.63004-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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
2.45.2


