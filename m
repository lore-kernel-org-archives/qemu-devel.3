Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9EDC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4bzs-0003d7-Jn; Wed, 08 May 2024 03:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzI-0003Ce-KG
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzG-0000pI-Gx
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YbzVl5wRGWe908cwmJ2aOwwM140Jnex44Vl/80qgX2Q=;
 b=dTqlNn9R8VQwPQDSIk9emQ+t3mEBdVFUDKvq3aFH+VtPh+ZZY7QE10vNlQqozGyWppSJv3
 JddX4RD+1OVCW2Pt0eSIKjRsYPGPPKv4ZbUgsY9hjy/NsrnyEUO6gpgfFI+2z1P/5OzuNW
 emIyiFwiD+tm7nQnHBE7T9CMKoO7Lp4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-68-dGFZ_OiCVeJU0I9T8tw-1; Wed, 08 May 2024 03:45:11 -0400
X-MC-Unique: 68-dGFZ_OiCVeJU0I9T8tw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-572eea3758dso620455a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154309; x=1715759109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YbzVl5wRGWe908cwmJ2aOwwM140Jnex44Vl/80qgX2Q=;
 b=Hxdu2IGey5912Ot0kDas09DpMG1cCeJ7FuSBdFcLRco6PTwa4dUHY1qFsWq5oQeG5Q
 WiPBXPr4guv42ZnEKhURgXPOyJbbudWHJiS3teEVLfSjrxqQK3j7TaeBaKX18JtsG7CR
 pN+bCOpGQQfAedaXzeXNtxlzXZnGfiO8bbU5lnZHlC4w/uF+Zr16i216cEHMMbvkQ1s1
 BZvbbm7wBVO7BmLy0wUWToEJp5GMQrC0KEin019d+/+FNvTEaWpYkGHXI0RkVmYgpTxt
 +H8SfD8acIzCEWjWTqSDojR4pKXHwDuyOQFfrwqUIsrltjlRg5XYEMpAWFd1mjo/Xg4P
 9y6w==
X-Gm-Message-State: AOJu0YybYTyPscHoihpnSeQl+zqdqmLDz3/AIBSvmkZzIm5VZMnLtSI6
 nvUKs/SpR+NX1cAvShuVAHhmOOVnMBs8J7dcqLGcE2trICISN1T6h6Omn0z58r8ojlpsJ8xt0qp
 qS1UHL/+3PoAdouGhaMm4zrszdR2/ypHoUTMhXnDbqJdwvBk4ABpoNGTVL9eub1mLrDdPv87Kw4
 +foLh/bNn6uh1Z9s6/AwYOUDINS6DcYFPMDL5D
X-Received: by 2002:a05:6402:1d97:b0:572:b0a8:65fd with SMTP id
 4fb4d7f45d1cf-57311023570mr3919815a12.6.1715154309470; 
 Wed, 08 May 2024 00:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF38JbOblCH1yEilJgauIqNafLDlu99f3VffjFz2RRltfCOib6epN92pAMjSCaMK4qMlUXRyg==
X-Received: by 2002:a05:6402:1d97:b0:572:b0a8:65fd with SMTP id
 4fb4d7f45d1cf-57311023570mr3919778a12.6.1715154308974; 
 Wed, 08 May 2024 00:45:08 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
 by smtp.gmail.com with ESMTPSA id
 d25-20020aa7ce19000000b00572a7127cb0sm7303838edv.50.2024.05.08.00.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:45:08 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 01/12] libvhost-user: set msg.msg_control to NULL when it
 is empty
Date: Wed,  8 May 2024 09:44:45 +0200
Message-ID: <20240508074457.12367-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508074457.12367-1-sgarzare@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PP_MIME_FAKE_ASCII_TEXT=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.45.0


