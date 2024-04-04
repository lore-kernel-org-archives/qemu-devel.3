Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14A8CD1296
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsM8D-0000V2-FU; Thu, 04 Apr 2024 08:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8B-0000TI-OS
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8A-0000xP-Al
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712233425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RduIHs0sVwVRJt/xTxYLax5k5ayyoz0yKuhL8Jrw+bY=;
 b=evFcUZVNgqx0hxBn8PIECnztObQPsSEKytJw3IJxyOxghk0sYGkZ7cIB1qDFddWVSKrAZC
 p+o1ZUScQVWHN+0Rl/7IqG2uyuwDNNZlzlIONnahjrPkUUlX87KxpQZmktLg8131tsB7xg
 X1zmSoZYhsGiMV4M7SjIlmP0SXGbGdE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-QnH-NVhMP52bAxXKjrpXkg-1; Thu, 04 Apr 2024 08:23:44 -0400
X-MC-Unique: QnH-NVhMP52bAxXKjrpXkg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a46bae02169so183993566b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233422; x=1712838222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RduIHs0sVwVRJt/xTxYLax5k5ayyoz0yKuhL8Jrw+bY=;
 b=uv+9ZHqOJ0guSx+T+1KxTRMDJOi/+bnuBTmWfKjcNShzhUvRx1TE5BpKP7wWt810JW
 OfcIIIkg8pG9DRZQrtPni++0nB+xWYJlbG/5n4noilt54gLWl4d3e3P8HLMRS2kdx0WW
 TgAFqMAzol6zhjrTsuYqjrqQ6+WIYqDInUQhgDmUklJLYJrUPXGsaKNPLrPpGL/smqMR
 yimLToLaQe1xAx1qD/TZ1NA7xOUO2hI7HGseVspXHQS3PeMgbwuVPK0KViucWwf4HcVm
 uPazhzAFGP/xqql/2bOOjr33TtmpLg8r31bB7TBsyoazwiB5L280HpzkD9rjeyOhm7MJ
 kSyg==
X-Gm-Message-State: AOJu0YzzUymd1VXYzJZ6kzlKVkOq5JQQlKUgznZoM3PPYc9wfVptjChr
 EbI+H4Po7Bdm+zt/n4doM5mQRy2jKHWvnULA462+3yp6JRB8MzBG4SzlhIEEkGUGLQIrFH/CUdO
 dzVnWFA6/bowWFsEoaBQakQxh7w16fysPdyteqjeGYrxC3QzclqKB8Qj9wD89sONcd5lBEYnb61
 rWYgBZjTBfL1G31QX6+cFlr9vGMp7bGkEXO0PP
X-Received: by 2002:a17:906:e0d0:b0:a4e:4981:d3fb with SMTP id
 gl16-20020a170906e0d000b00a4e4981d3fbmr4783167ejb.29.1712233422701; 
 Thu, 04 Apr 2024 05:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf4eCsIC+G13AWXm6UQZeHHIGvPgrDBYeQmRPOqAoJLpzfAsa9TtnvrYBAq3muulHzgRGjnQ==
X-Received: by 2002:a17:906:e0d0:b0:a4e:4981:d3fb with SMTP id
 gl16-20020a170906e0d000b00a4e4981d3fbmr4783126ejb.29.1712233422342; 
 Thu, 04 Apr 2024 05:23:42 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
 by smtp.gmail.com with ESMTPSA id
 p14-20020aa7cc8e000000b0056c4372c161sm9302566edt.55.2024.04.04.05.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:23:41 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v3 01/11] libvhost-user: set msg.msg_control to NULL
 when it is empty
Date: Thu,  4 Apr 2024 14:23:20 +0200
Message-ID: <20240404122330.92710-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404122330.92710-1-sgarzare@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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


