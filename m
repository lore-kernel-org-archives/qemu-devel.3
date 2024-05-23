Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5109C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9rp-0002eg-Iu; Thu, 23 May 2024 10:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9rM-0002BI-S2
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9rJ-0003ym-S0
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JAQwZsc8cKAlH0q2kUc7Sw/ErfWrVXpWDlOF1f/YOjk=;
 b=YVwGjMDWzH4Xek+ghegA/VORyrl9uHyK+jhqg/FMcIAXHeZD3VYP+KgSW/0S6JmfOA1X2c
 ICLSzvGZoRBJT/moWCtFpqJ5hmNV4W3kXy1fyoLeDqig+C/Tib1Ouav8l7yFLBz8EzGgVs
 PyHoUiFen3ug9NEnDAi2W9xfXlSiZn8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-10W5v2GiNry_d9v1GW7BQQ-1; Thu, 23 May 2024 10:55:54 -0400
X-MC-Unique: 10W5v2GiNry_d9v1GW7BQQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-43e096020baso2516431cf.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476153; x=1717080953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JAQwZsc8cKAlH0q2kUc7Sw/ErfWrVXpWDlOF1f/YOjk=;
 b=BntRTPMD/POqHjGa6gXXWlX0mN/0u5gMZa7naXK3ZN/s0SMacm+cW47offtpoYwfsd
 ka3/DN/5V6vKBGY1Es/8DoIgOrbPvtVWEwIRUtpj0WwVcEnM0EODiias74cFBiXUh/ki
 p7j9HFaYlmHlAWgxDXv9kBK6tb1RkTanU91h6cN0bGAkczi7JDZTsZ374PUESBAJ2B+e
 AknVNNiXu1/PexVOOP0GAdhD7snghkZiDbCrqBzikEnwfFZWW0wxgm8b+Qy0DDCq5ayE
 ItkyMDYz+8iJBthUGmiKh7XqvljV4Kq2+mSg3ykagXE4+mq2zsdIxpJPlurBMNxM7lE1
 2vFg==
X-Gm-Message-State: AOJu0YwEm1xfN9M5g7OYC27AYS25si/moH+qm+PE8o+Q6YNhf2BuU+ki
 xXv7MPrOCl/vQ48iGpu+FC89Fb0oSPo3Wh4DwLm54cySVarj379DaaeO5prAyAabaJrgoBQtjS4
 OtGxOCqXwyBL6vrVqQ4CDwbO3+wUisNE8H7RSHHW7bKtk5ClYxpUa3cbjYl2zTbhkGl2Mztd2i7
 fp/K2irNtyFUKN7sLVyIUzYrVCbk/tp/yvaqLl
X-Received: by 2002:ac8:5dc8:0:b0:43a:43dc:f5e0 with SMTP id
 d75a77b69052e-43f9e089d65mr59625581cf.9.1716476153273; 
 Thu, 23 May 2024 07:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4Dfku7jRiy/tU2GetMzIMaF0liT1J8UGbSy7sP31dqk4PdtJh/rzTfx5m4mvlqRrZcS18nQ==
X-Received: by 2002:ac8:5dc8:0:b0:43a:43dc:f5e0 with SMTP id
 d75a77b69052e-43f9e089d65mr59625151cf.9.1716476152803; 
 Thu, 23 May 2024 07:55:52 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e12f41a0asm148192191cf.48.2024.05.23.07.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 07:55:52 -0700 (PDT)
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
Subject: [PATCH v5 03/13] libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not
 supported
Date: Thu, 23 May 2024 16:55:12 +0200
Message-ID: <20240523145522.313012-4-sgarzare@redhat.com>
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
2.45.1


