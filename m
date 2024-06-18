Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0140AC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJVeR-0006Uo-Hj; Tue, 18 Jun 2024 06:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVeO-0006T0-JD
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVeM-0000nO-Vd
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718704874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Su7ClX2VsFIEko0OXJVvgHI4Li50SabFJTO7o/P9fMs=;
 b=h0msHDIrYr9ABL3a2TY5xt3PAlN28S6sJtMWlKyHo0Zu+j7yQfvzSjYVFM0o1MZ5kJvlfb
 FJzp15cBXlClwHSVZk5I2Z5WZ0Rt7DyMn0apRoCHJJX4TOZ30RhIko78ZQk/EafBA6QJew
 n5YSFeIfxryqRe5Oh9dcSbzV10B55rM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-hii3cQ5FOR-kNP5R8G8LbQ-1; Tue, 18 Jun 2024 06:01:13 -0400
X-MC-Unique: hii3cQ5FOR-kNP5R8G8LbQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4217a6a00d8so34761745e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718704871; x=1719309671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Su7ClX2VsFIEko0OXJVvgHI4Li50SabFJTO7o/P9fMs=;
 b=HrkPAlcaSRjGtnwiJbiCanvcw6Q3f/JPBzi8bWDsGhS0vm326EVvRHfpa2ztfKGrCD
 R21BsMaF6vNosOZfcWAix0coazci2OPahP9El4DiRHVD9B1KnADijzTBJhDGUBHRsT25
 XOu9TzDtPMqpXAXgHX6TyYdQ6y8hWDhEb56cUns1+NUPGlic3myL+lfQZev/db+741tB
 QqgMosa7GCQpXkFUBlAECObaWd5RbKhZLZEgctb0UJOR3cVhgry5sAm1LtvttrvAJ2UQ
 Zwb77XTfwuPKfESDk8eH4vgsPWhGfoT3bsmHXyxuIgTuRZCOuJCq7VkVIuvdDvcgTxbr
 6DnA==
X-Gm-Message-State: AOJu0YxNRJ2YXhXsr74UZ0rbQLDs0T9+Yfvnejj1qCG+YcaSmTosO7wZ
 2cjj5i8ceIGdw0iX/P5OBIZQ3hkfWwDdxfPT2xrhniR0Nq6LU+g6WwWrne387q8mskgljL5DUBv
 eJamn4HkkGA0tvur/4IfQBIL5LcsNYgU9lVtoCWH3LZgXan9E9Trx3IelkmLanlDyD3ryYkTuBt
 Hay1Gyj/dUYmmcG5v4CCKON9DaFTn7NR0jgKAU
X-Received: by 2002:a5d:678a:0:b0:360:7829:bb93 with SMTP id
 ffacd0b85a97d-3607a759cadmr9333683f8f.21.1718704871317; 
 Tue, 18 Jun 2024 03:01:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwb7KX/o+IDXnpfK9XhGo2Pf+0iOdH/yhEnjTmDxufGt/jJUMMca+XHPdNilpVwZ2l3BRTKQ==
X-Received: by 2002:a5d:678a:0:b0:360:7829:bb93 with SMTP id
 ffacd0b85a97d-3607a759cadmr9333643f8f.21.1718704870995; 
 Tue, 18 Jun 2024 03:01:10 -0700 (PDT)
Received: from step1.redhat.com ([193.207.160.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c688sm13814617f8f.42.2024.06.18.03.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 03:01:08 -0700 (PDT)
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
Subject: [PATCH v8 03/13] libvhost-user: fail vu_message_write() if sendmsg()
 is failing
Date: Tue, 18 Jun 2024 12:00:33 +0200
Message-ID: <20240618100043.144657-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618100043.144657-1-sgarzare@redhat.com>
References: <20240618100043.144657-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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


