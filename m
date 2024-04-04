Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2839CCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsM8M-0000ky-VD; Thu, 04 Apr 2024 08:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8L-0000kn-K8
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8K-0000zF-3x
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712233435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZpxLxEjZKPolHxK9jEBltREEiUiPHa29JLrUzO0K+0U=;
 b=EdzoA5dDCnFXA3IeNd3Jp8f8ooY1J9/3b2l1DWOltoFCBcnimjGf28YFAviABtcJ5yYhfQ
 57wJgbFVLNDopy9ZetMs/ygdyDKdjtqAdnVCpjdV5V6fnuyQTl/mw7hIWNlul72b+F4DZq
 rtixOrdXdC00AdaTxvYG/BmZjnM5qD0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-Xvx2rbBaOoy0jB0Ws_xOMQ-1; Thu, 04 Apr 2024 08:23:54 -0400
X-MC-Unique: Xvx2rbBaOoy0jB0Ws_xOMQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5684c1abc7fso489865a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233432; x=1712838232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpxLxEjZKPolHxK9jEBltREEiUiPHa29JLrUzO0K+0U=;
 b=FtuBWsCllOCRNCmK0qmKGGdHIwREOZ3/8CzF82KOnYHWvnvDSUlcB54P2Wg50mBCqx
 SCNSA3WH77t7gIZ015trsToRsijyUrdP4hrPFIAbXWQ4Bc0WQwz35IMdxgxV6nOTPCx+
 gUTlpHkeM6WOLPyOhNoLcZ12IwgQtHbNKT6ClDFFFI+yNEOEzwF5ozn1oRo7zY9ISnmx
 /uHfp9JuwmVJejvVk9hLFwMNfKcU9XKw0boIq00X47fVzUqFUrwQ+nPu8r73ZZpk170u
 xsAHfyKcyyvA88FnROZFOFABZsvFPBQ/LjA74FbxUHvNLRDw/wWJVJDcKvktVlU5SkYD
 zw8A==
X-Gm-Message-State: AOJu0Yxhh2SS7msJ5RH3w+xpvCJ+2+HNE7PZGUa23XtjH4M1ZxlIADy2
 9tr0nMus0Eqr0/2XtGMgej6MqzAeMpc2fOz9hogUmYDxBd4DlpPN41t+elnRV9cJ4yILsvIDIzx
 X8WcJqb2eX/08EbsUW4jjtnC6QKsP50hoUfRN8Qd/qu6HQ55Z6f60HH1PYH80w3qb5H2oy8Z4n5
 RwXXAQAutlErvh/YKmJL/dGOIZJ1xCOysBAtQC
X-Received: by 2002:a50:ab5b:0:b0:56d:fca8:d209 with SMTP id
 t27-20020a50ab5b000000b0056dfca8d209mr1685420edc.10.1712233432321; 
 Thu, 04 Apr 2024 05:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo5LhWeqDE998SAVHKQT4KfEeuzyPktirErjhPfVxA/95CkcUbc78fYRSokzUX2kv/oeQiYA==
X-Received: by 2002:a50:ab5b:0:b0:56d:fca8:d209 with SMTP id
 t27-20020a50ab5b000000b0056dfca8d209mr1685384edc.10.1712233431989; 
 Thu, 04 Apr 2024 05:23:51 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
 by smtp.gmail.com with ESMTPSA id
 k16-20020aa7c390000000b0056e2979b960sm1076edq.20.2024.04.04.05.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:23:51 -0700 (PDT)
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
Subject: [PATCH for-9.1 v3 03/11] libvhost-user: mask F_INFLIGHT_SHMFD if
 memfd is not supported
Date: Thu,  4 Apr 2024 14:23:22 +0200
Message-ID: <20240404122330.92710-4-sgarzare@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


