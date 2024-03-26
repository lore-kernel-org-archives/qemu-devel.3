Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01664CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp71w-00078B-S4; Tue, 26 Mar 2024 09:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp71q-00075n-0g
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp71o-0004uc-NL
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711460388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQ/XWWXh4XW3dUXwm+qOVxK0ZPm+OgSJNqqiqFOv16A=;
 b=d5ZizVkSYJeK4Zxi8e0eYi6StV004fRj00ExexjPoWG5lciNdeBC9JcMssRccHoFyZ9wYa
 9y4ibJz1Kr/ypWg6L7Be/hNy+9vHOGV0AhdQM1llYMsmNpr/84VxY9rcn8tpFgmvExP2nZ
 qtYozriNlP9LrlaD2wtNiKlBGmkMagA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-O9n9iaKSNLy1pVREdcM0VA-1; Tue, 26 Mar 2024 09:39:46 -0400
X-MC-Unique: O9n9iaKSNLy1pVREdcM0VA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-41407fd718dso30621605e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711460385; x=1712065185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQ/XWWXh4XW3dUXwm+qOVxK0ZPm+OgSJNqqiqFOv16A=;
 b=KwC6xEgNZfO6WUNrOi33ISbHmTDNxXOTxGCJmbYU0urSxXedcGZKonNbq69+IeTQdj
 1eWhBrqZLrQIxa65AvyYwEzG1QrItZXWz6jkHOc0+TMx7HfyCiXpjgncPrxPYbPpTeHF
 am1JMHeutqH6yjDx4GRF8KK1/DFQ5xjSjLuRp06lCFqtoMa+dTxiuR6PcwbRaBlgR3ak
 dAGzua+dsJbqM31mtl2WugRXpcxOCIQ41OUANPQoTC3K7OlHwqe9pqLfU/CWf31uUaKb
 Lqy8iHmWzx7rs6Z8pmkldNS7gQYVN7u4ebA/IxAGYn1OAQ7+8gCrVPl4XwbNJf84d/gf
 43+g==
X-Gm-Message-State: AOJu0YyX8eZ2Aj9rhZlXdbtH+7MyDyh/mzPKz+v5AfgqVv6VZVWznnaB
 vPxFgbOX2vXKq1E36bdaEFoRCrpmNWZyybSELzyHqiQOoDyTW+lw2h3RasNH7jfeF5Vi9pGMX0N
 jlemPo0vabyCpGcJsuBC1v8vmgUiIrXREtcKXPdaQaZIqyGIj4uoVcZpysUw0OrEP8CTdDorP6n
 ftw7Y+OfkSsbNjA+WSgOQbJc+N3eQslk0UOFL2
X-Received: by 2002:a05:600c:3c8c:b0:414:7e91:a992 with SMTP id
 bg12-20020a05600c3c8c00b004147e91a992mr7110723wmb.3.1711460385120; 
 Tue, 26 Mar 2024 06:39:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcuTVUAVz3+ongCHaVJuO2UGjdpPG6N8IXZQzaAYvQjIYxDMzFMO5d9D5hABaxiYGjmz9B3Q==
X-Received: by 2002:a05:600c:3c8c:b0:414:7e91:a992 with SMTP id
 bg12-20020a05600c3c8c00b004147e91a992mr7110679wmb.3.1711460384636; 
 Tue, 26 Mar 2024 06:39:44 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 d8-20020a05600c34c800b00414903d20aesm1169213wmq.11.2024.03.26.06.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:39:43 -0700 (PDT)
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
Subject: [PATCH for-9.1 v2 01/11] libvhost-user: set msg.msg_control to NULL
 when it is empty
Date: Tue, 26 Mar 2024 14:39:26 +0100
Message-ID: <20240326133936.125332-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326133936.125332-1-sgarzare@redhat.com>
References: <20240326133936.125332-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On some OS (e.g. macOS) sendmsg() returns -1 (errno EINVAL) if
the `struct msghdr` has the field `msg_controllen` set to 0, but
`msg_control` is not NULL.

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
2.44.0


