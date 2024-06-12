Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635B8C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNcg-0004Ly-UI; Wed, 12 Jun 2024 09:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNca-0004Ac-Dd
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNcY-00083H-U3
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCSYM/hkoNpk10raw3aulgVh0FcgzvIKh+wFjcoj8Zs=;
 b=ZTWZXThCX5gnEnzpb5s+hccsFbytTf+/abWe5zmWZaaB/7u8bLhbybfZa6gKXIPby3qyNv
 qtS/LaVc0nJvxvNr/D4Yt5zNJ9/PmrHpvT5Qd7g7OkndrY00thWG9KIiGhUoW4JYkvLu/s
 j6bpiQ+W22yFgtHk1tWKIdjWgt4rHEY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-D9tDz7aCO96wnUHxmQZJIQ-1; Wed, 12 Jun 2024 09:02:33 -0400
X-MC-Unique: D9tDz7aCO96wnUHxmQZJIQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7955f8b4bcfso247153185a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718197350; x=1718802150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCSYM/hkoNpk10raw3aulgVh0FcgzvIKh+wFjcoj8Zs=;
 b=PLp9K2CUpu7zpvzLt96q+0Vja5EX/aW+1IoGyqmtwbYjmeZkiigKwbQpsyYObOoykM
 bKMALLljWwyDlmk49SYkeV511cnPb7pgd95JyoV27/ohwzW8C2lvfd5U6hJM8QrLG0+x
 Rep2F70QG1S+nUg9FzRJlCHOAALlKkz7HOWg09V5EpRRo6Cq3K41JLZl8ISY4IixvoED
 HcXlzj8xkegpQmu1tsZz24OhdXpuBqbP+O/0f2S/L/9WnR716P10xBsGcXUbttxe00ze
 RkPZs9KanpnKh55rfaFmYH/NzO4/meQ1pAgOztSp+NF9tHbmhASs3+KVKWHF94SwwlFk
 vLJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoSJ5gzxxKsWGqrVr2bon42zd5tUD27IkfBPHquaS0Qd/MsI9zBWDMTpUZ6BLFbTudIL/QpZW+Y6y5OmGHrECQJASoR9Q=
X-Gm-Message-State: AOJu0YzNR3qxK9gD6674wWDZ3n8dGCT23Vo7b2OkOB24slb3NrfwWRp/
 VwsM2Q4TYJm+cM74dVwOU/X64HHacHIkSGO1T4C/K0LW/3+2uYYYHUa1ZBBJ+jN2GpBm6/KTCWN
 glta4sa/1do4cKdVPONpkURIkLzSkJlNa//NRDAXR/mv3v2g/3I3x3YE9AOcR
X-Received: by 2002:a05:620a:468c:b0:795:5ad1:a218 with SMTP id
 af79cd13be357-797f6037e2cmr175909185a.17.1718197350385; 
 Wed, 12 Jun 2024 06:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsSt0RZcRr9OnR/vocJe+Xf951H24BU/vf4cjqFxivopk9gMGwG0l+M54Y6TKmUFpaT1EfIw==
X-Received: by 2002:a05:620a:468c:b0:795:5ad1:a218 with SMTP id
 af79cd13be357-797f6037e2cmr175904785a.17.1718197349908; 
 Wed, 12 Jun 2024 06:02:29 -0700 (PDT)
Received: from step1.redhat.com ([193.207.132.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7978863766dsm233919685a.5.2024.06.12.06.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 06:02:27 -0700 (PDT)
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
Subject: [PATCH RESEND v7 03/12] libvhost-user: mask F_INFLIGHT_SHMFD if memfd
 is not supported
Date: Wed, 12 Jun 2024 15:01:31 +0200
Message-ID: <20240612130140.63004-4-sgarzare@redhat.com>
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

libvhost-user will panic when receiving VHOST_USER_GET_INFLIGHT_FD
message if MFD_ALLOW_SEALING is not defined, since it's not able
to create a memfd.

VHOST_USER_GET_INFLIGHT_FD is used only if
VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is negotiated. So, let's mask
that feature if the backend is not able to properly handle these
messages.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a11afd1960..2c20cdc16e 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1674,6 +1674,17 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
         features |= dev->iface->get_protocol_features(dev);
     }
 
+#ifndef MFD_ALLOW_SEALING
+    /*
+     * If MFD_ALLOW_SEALING is not defined, we are not able to handle
+     * VHOST_USER_GET_INFLIGHT_FD messages, since we can't create a memfd.
+     * Those messages are used only if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD
+     * is negotiated. A device implementation can enable it, so let's mask
+     * it to avoid a runtime panic.
+     */
+    features &= ~(1ULL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD);
+#endif
+
     vmsg_set_reply_u64(vmsg, features);
     return true;
 }
-- 
2.45.2


