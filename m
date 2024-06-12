Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE871C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNcN-0003Pt-84; Wed, 12 Jun 2024 09:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNcH-0003E9-0i
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNcC-00081J-OO
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYivD0Oj8DZaeGa3x1w3lr0EcGpbXryh/Rf51uyXwz4=;
 b=I65DlcJETzLir7+clst40ZMnfg2cU4df8ZddcsK6u1MjcbxgYq181MsFUi8GB7Rz7zfz03
 LxzGN3hjs2DfTB3qkA3VVxxEof0fPPqryASSv/3VPI7SCqd42MjyX9F21y1fgJUV9rXkom
 kR29MNVuCipL7HMUlUTYDpLfgnevsC0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-jsxu35nMMYmewaa1_-fouA-1; Wed, 12 Jun 2024 09:02:06 -0400
X-MC-Unique: jsxu35nMMYmewaa1_-fouA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7955f448a2dso318725585a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718197326; x=1718802126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYivD0Oj8DZaeGa3x1w3lr0EcGpbXryh/Rf51uyXwz4=;
 b=IthXSICLH4SmHGKM2wo23cJoVT3qE1gU67cst2UN8OpzI4a87XQ7EcHDeqR0onAwD/
 FMlgs66egces+CzqFJdBrzTk1gj3Pbq2WxFkjCcwyoZ9sJ23/n7IRp/gr0Wg8zCMoiKU
 Jekgo3xVFuxk9Yf6ME2cG9OkagtsWJ0S+Mf5Hju3XOeVeevuzL8iZbChCxcndSmEKRVD
 4YdjOz0hEdaVhaeabZHtk8D84TKIZMLnzvkfq/qtaeP1JM8HNWaLqGC+rxkH3aDB3F1u
 7y40lyxOyPzDmooebHBGu1EzQPKPyOewFtWAU66oL3aCQi8CxlTwL48ZX7xSHYNvVpUi
 T90w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEOm0zIKVS+Elu3M68XSUMF/HDi4KAHzR7Sr79cSEKYSFtbz0qbPoj3m4rlkETbjyOwehhgMCurRhMSs4jhgM9X95c54Y=
X-Gm-Message-State: AOJu0Yxor2nxJ1N7RoTLMLU8zf7HbUF1jISJZKJUivK0FtMiPxotkAX5
 B1hJRDTYp6CSnfYJfUZIpuQVBhZp2TZQxvufHjrx9fcmycVPjBimbOFLg5CV0LgzWcjtVqvUOT5
 QyxXrgXeLE/tj7hFFht1TBlU0HMBsJm+NWgxGUOpNEodMbhVLolH9
X-Received: by 2002:a05:6214:448e:b0:6ae:116b:ef6a with SMTP id
 6a1803df08f44-6b1a7ebb170mr17694556d6.60.1718197325604; 
 Wed, 12 Jun 2024 06:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRitwQKscCqag0PsLNFeOtfDq3MX8L34TOG54quvOa1DAibTb69ENOFsIyuxrR3KqtkY8ySQ==
X-Received: by 2002:a05:6214:448e:b0:6ae:116b:ef6a with SMTP id
 6a1803df08f44-6b1a7ebb170mr17694036d6.60.1718197325178; 
 Wed, 12 Jun 2024 06:02:05 -0700 (PDT)
Received: from step1.redhat.com ([193.207.132.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b04f69adeasm67464446d6.44.2024.06.12.06.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 06:02:00 -0700 (PDT)
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
Subject: [PATCH RESEND v7 01/12] libvhost-user: set msg.msg_control to NULL
 when it is empty
Date: Wed, 12 Jun 2024 15:01:29 +0200
Message-ID: <20240612130140.63004-2-sgarzare@redhat.com>
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


