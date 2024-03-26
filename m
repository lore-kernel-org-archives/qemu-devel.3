Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DDAC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp72A-0007Gn-UI; Tue, 26 Mar 2024 09:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp720-0007AI-9N
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp71y-0004vX-Vp
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711460398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZpxLxEjZKPolHxK9jEBltREEiUiPHa29JLrUzO0K+0U=;
 b=Xx9PvlQMYlv4Rpa3qtl3wdo5lY1/0pbMqTsxS0VJTwBhnP9zkuuDUawvVrg4A8rXQ8W/DB
 poRG1m0saHM5JIrxlE0YjtMbagvXpnnBxvsgF/0dP4xJi7s9mWdeRDB/0dv+wqKvb5v9hE
 HL/W3QeUBTcjsjFwMcyA6Dz7j0Qj89g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-FQeY9lvwOYizEE9S2MGk4g-1; Tue, 26 Mar 2024 09:39:56 -0400
X-MC-Unique: FQeY9lvwOYizEE9S2MGk4g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3416632aeffso2894368f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711460395; x=1712065195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpxLxEjZKPolHxK9jEBltREEiUiPHa29JLrUzO0K+0U=;
 b=LAKZj5fcWLsHdyPEfmc9KoplNHWpfsLNGDB6oH5SG+Hp604xdKfdwI+Gyb3oalrQFR
 04f35UTm4GZI/rsHZNwABH2Uz/ozzMlH8QXg3Zv6gaJHC/vJX+3S+pmpjFXjuIxFevpP
 Y+M+Qhye4p24Itp6Sfh6Mxm6Xi4Gi/IbaQ/XEnis4usR3XZl71EteElPmc/a3zR9R0ZZ
 +Kv7AU88c95F0X0Bl6Oh5/TxFgqx6tOUFpqHphli9Jw5r8878FrCMa60HKGrtt+NVOeh
 9JexoixU6jacyTKxGAt6jx5Q0wBCCeTGx5QtLUfr+rnQiSXZsl9oOov8p4efntZz3FRr
 0I4w==
X-Gm-Message-State: AOJu0Ywom82LZGHk16+BAcl0qpzAFbfYrJmFnocoprqrDF3/OycUl0EZ
 xRkTIkSb5G/LMEREHHl1PhKMcPa7Ay6KxyUy74wd5CKatj9VphLgN/fd9/6xoyEQ4XB+dqanqu4
 GsoyAjbmzSJbBwSwAmqBXVJgjC96pKztsIWOnmigfjKeMIhb9YVrpD0lYseHXQChAsXUinpGMUI
 wA0f9LFCx6nkahzUHH/bNt4r2GTY42X/9beHuR
X-Received: by 2002:a5d:47cc:0:b0:33e:7f51:c2f8 with SMTP id
 o12-20020a5d47cc000000b0033e7f51c2f8mr1312641wrc.36.1711460395369; 
 Tue, 26 Mar 2024 06:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsfbF75YQvyd3MpA4mQ/dmq+lcrj3CNMZvjVZRgsQYppIUmvrrcYLHzpdXAhGGlhaUPqUMsQ==
X-Received: by 2002:a5d:47cc:0:b0:33e:7f51:c2f8 with SMTP id
 o12-20020a5d47cc000000b0033e7f51c2f8mr1312605wrc.36.1711460395020; 
 Tue, 26 Mar 2024 06:39:55 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 t21-20020a05600c451500b004146e58cc35sm11706050wmo.46.2024.03.26.06.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:39:54 -0700 (PDT)
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
Subject: [PATCH for-9.1 v2 03/11] libvhost-user: mask F_INFLIGHT_SHMFD if
 memfd is not supported
Date: Tue, 26 Mar 2024 14:39:28 +0100
Message-ID: <20240326133936.125332-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326133936.125332-1-sgarzare@redhat.com>
References: <20240326133936.125332-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

libvhost-user will panic when receiving VHOST_USER_GET_INFLIGHT_FD
message if MFD_ALLOW_SEALING is not defined, since it's not able
to create a memfd.

VHOST_USER_GET_INFLIGHT_FD is used only if
VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is negotiated. So, let's mask
that feature if the backend is not able to properly handle these
messages.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a11afd1960..1c361ffd51 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1674,6 +1674,16 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
         features |= dev->iface->get_protocol_features(dev);
     }
 
+    /*
+     * If MFD_ALLOW_SEALING is not defined, we are not able to handle
+     * VHOST_USER_GET_INFLIGHT_FD messages, since we can't create a memfd.
+     * Those messages are used only if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD
+     * is negotiated. A device implementation can enable it, so let's mask
+     * it to avoid a runtime panic.
+     */
+#ifndef MFD_ALLOW_SEALING
+    features &= ~(1ULL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD);
+#endif
     vmsg_set_reply_u64(vmsg, features);
     return true;
 }
-- 
2.44.0


