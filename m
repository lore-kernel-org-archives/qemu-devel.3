Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C11C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIQR-0002Rd-QV; Wed, 28 Feb 2024 06:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQ9-0001yt-KW
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:48:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQ5-0002yB-Hl
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709120895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MgJ0yPm3ToTqOR/tn/By3XWvH0ZNAU51N+FqVYYj+A=;
 b=NTUCzFSBeENMQ0pw1IpyjPUIIMJuqu74x0lCZBjjLq7Xt+MYEplaWl7gd8o9UWGFHfephI
 wDKhbUmqhhFz+L9zyQDrW/eDxm1NcSc/J7ZUWGVd6rfGu7GBZVPzGYvKjV7cuS1N1CMo0A
 ropuwsX/s/MY6FuOYPc2XLJ67DK7H3A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-bub-RQRTP4Ge1EjB9H71Pw-1; Wed, 28 Feb 2024 06:48:14 -0500
X-MC-Unique: bub-RQRTP4Ge1EjB9H71Pw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-68facaf1c37so63772696d6.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120893; x=1709725693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MgJ0yPm3ToTqOR/tn/By3XWvH0ZNAU51N+FqVYYj+A=;
 b=eQayJ3l2ojGJXXWglfbA8E28xy2jHdbYDY2gMomvRfWHFPe2oknbvTFNT0IrPhudkR
 UgarQlMrfaLL1gfhm6QULxfvt9EEIHooT4kICMUuMCP42tRZNkjIbmZD6l0dxrJUSF1R
 kBcnDlcDPJL94QJytsCA9yosY85xeoqaLpR+VZtgwxGySeHg+fgU4roXxjD85abmfVaz
 hjYZKAdhD1sXkvqWom1WzQYMMI409MXkg8OVvQWSm1NWxYJNEUeFVLCdmBnOCh7ybVfV
 9Q+d99djd3RD7HTf28++I+F1OBaFQ+lm/jy4sRQHHMtJpr4pylVQuYJYDuXHtqy88Sw4
 JozQ==
X-Gm-Message-State: AOJu0YyA+g7CrWvEDUcqNKk7NAxVFIN4+Rwwc5/BFNhmOVldMJ/Ra8wO
 i3I9MhuMhHzDx9/2bh6LftujpE6g8pkyOCqpXjJmeT3+5ZGbEhjrl82ZnG1AwlY5aZmu14ruuAG
 ngqyGIkztRLSr5mXdry5NZxtJlY0WnMK5TA3LLXptjVy/a1BroX21aa9lA0U3iru6HYrDgIdNlc
 9Rzv2u3mvuMIr2CScTqi5sGoi+QB7QfyEANHhQ
X-Received: by 2002:a0c:b55a:0:b0:68f:3a7b:acde with SMTP id
 w26-20020a0cb55a000000b0068f3a7bacdemr5767703qvd.41.1709120893531; 
 Wed, 28 Feb 2024 03:48:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh5j+33195MLcwMYVLgDq21ulPQrd9yO0i820OvlHkq7/w48sElOO7s98RYQZETG5tvWX6/A==
X-Received: by 2002:a0c:b55a:0:b0:68f:3a7b:acde with SMTP id
 w26-20020a0cb55a000000b0068f3a7bacdemr5767668qvd.41.1709120893157; 
 Wed, 28 Feb 2024 03:48:13 -0800 (PST)
Received: from step1.redhat.com (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 og17-20020a056214429100b0068fe3170b0esm5168982qvb.11.2024.02.28.03.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:48:12 -0800 (PST)
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
 gmaglione@redhat.com, Stefano Garzarella <stefanogarzarella@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/9] libvhost-user: set msg.msg_control to NULL when it is
 empty
Date: Wed, 28 Feb 2024 12:47:51 +0100
Message-ID: <20240228114759.44758-2-sgarzare@redhat.com>
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

From: Stefano Garzarella <stefanogarzarella@gmail.com>

On some OS (e.g. macOS) sendmsg() returns -1 (errno EINVAL) if
the `struct msghdr` has the field `msg_controllen` set to 0, but
`msg_control` is not NULL.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a3b158c671..b9c18eee53 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -387,6 +387,7 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         memcpy(CMSG_DATA(cmsg), vmsg->fds, fdsize);
     } else {
         msg.msg_controllen = 0;
+        msg.msg_control = NULL;
     }
 
     do {
-- 
2.43.2


