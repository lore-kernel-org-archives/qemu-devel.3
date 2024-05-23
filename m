Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FD6C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9r6-00023t-DA; Thu, 23 May 2024 10:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9r4-00023I-LO
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9r3-0003vu-8k
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3UtH0D4I15f6AmqPGZ/mKuxu8KcITJcJzO63ZIJCMrs=;
 b=SWm2p/yZkDQdAghm/EciTkr+tMc/A/AQXqUV2gBGpy/jelV8R5VtfYx7ewqUnVCKqmAIB4
 zQ/LULxF2BgHzRy6AtpaC++qNEyJoFfHorBt4d0bKL8OoEAin8N76v7z2huYQr4taU10Zt
 VAGdGGBOd8umwL3KGRvSnTDtKIP82aw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-6-wDqsn7PGKMeGaig2Fp3A-1; Thu, 23 May 2024 10:55:39 -0400
X-MC-Unique: 6-wDqsn7PGKMeGaig2Fp3A-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ab8c89adb6so2524986d6.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476138; x=1717080938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UtH0D4I15f6AmqPGZ/mKuxu8KcITJcJzO63ZIJCMrs=;
 b=tBcOJdo8IQc8IdO+Oq/8BAu72swdw8EcMQw4u3m+lbgvWH8lVNdhKOqLh+5fnXH58R
 +1AYAGjfARa6wXnlcXJR54pLiiKKc5q04SknfAEoqcLJ9mq9I22812/YaQg8RZwYyAvt
 r/WcgnWFclxHWDo3B4THww/e2jesMy/gZnt9QW3n5Cg/UT2Ufn6FmFs5hYNm8G7bFM6I
 GNB4naMDR6C6E+peZWTKzhydS+KNZKFO9Vg1G8M/LoYq8Yza07cZNpdrkblvL/S6ZZLB
 SkESY7SgJQ53m18uORBWH5m+Vr/4lzBEseqbisT8WSAvFlpunGX7V4Qqp+8OXtoQu6yN
 IbpQ==
X-Gm-Message-State: AOJu0Yzbhws8Tkfy8PY8L3di2OUGPNENbF4tN77zffrEgZcZlroLbI3z
 rBXycQnhgu9QnSaxamMJwSGrcStoRJvTkrh5RiztocPh7BHGM0G5L+f35oyTqpglFZYjQduNT4/
 ipXetPYNYfM+8TnMQfNytvWjL9oJA/6EhpqI9VfeOy3juqnaEUva6D0D8QcM2AYIDTIH6az6BMX
 2ICW4gi5KDJWqtso3+IyVdmhjKzHrEwsJ0zo5d
X-Received: by 2002:a05:6214:3f8f:b0:6ab:6d0b:eceb with SMTP id
 6a1803df08f44-6ab7f3726b7mr73177596d6.37.1716476138015; 
 Thu, 23 May 2024 07:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQS3U9wm4xFEmU29SUT+Muh3mdHUdkEn8zwkTLSuLOn3D4YxnpDFhuLoaecn9NzLmB1Dt7yg==
X-Received: by 2002:a05:6214:3f8f:b0:6ab:6d0b:eceb with SMTP id
 6a1803df08f44-6ab7f3726b7mr73177066d6.37.1716476137468; 
 Thu, 23 May 2024 07:55:37 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ab8676b583sm14666736d6.61.2024.05.23.07.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 07:55:36 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 01/13] libvhost-user: set msg.msg_control to NULL when it
 is empty
Date: Thu, 23 May 2024 16:55:10 +0200
Message-ID: <20240523145522.313012-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523145522.313012-1-sgarzare@redhat.com>
References: <20240523145522.313012-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.45.1


