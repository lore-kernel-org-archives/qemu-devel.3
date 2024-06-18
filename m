Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1124EC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJVee-0006bv-1a; Tue, 18 Jun 2024 06:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVea-0006YK-G1
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVeY-0000pP-Jk
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718704885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCSYM/hkoNpk10raw3aulgVh0FcgzvIKh+wFjcoj8Zs=;
 b=F5hg5InnEARCDFDb+AKcFpNOz4G7hmLhz8Egp592KSFza7YrCbnk/9K/Rnr9TNz4e/rFZp
 OET7Rnpb6JsrMD68BtJ7Y+L8KuFI9XN/WwmxR/GD5RAbKrfrTvqKew+TtoxElRFmTSlXWu
 aBgQ/Qr2fJqFAO8YeKAejzo1tKiA8B8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-7fJrjY_POYaEYalwh7U8AA-1; Tue, 18 Jun 2024 06:01:24 -0400
X-MC-Unique: 7fJrjY_POYaEYalwh7U8AA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2eaec29f8e3so41808581fa.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718704882; x=1719309682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCSYM/hkoNpk10raw3aulgVh0FcgzvIKh+wFjcoj8Zs=;
 b=RKmpm8riGvhjxo88JqDkMFAUqlEyAAYUnBN2z+jDcZd+Qrkgv/a2wE9MSTWmz5Xl11
 tzui9qx1wcrwrFceKDrEQAY1vSlE7u21WUted37gyqBCTdLZwaAzrlOo6/Dee4gNOzWS
 kCbYx6jc5lZRX5g0IZD7etzP5KEitL8jzqZ3klk+5qJzx1NsLSk6hbpzBcvHfcsVHFCJ
 q/lXZRuEU9UgKtaF0Hp79F/Ut5uAjuIVm64BpjLDloYAYrnzAbfaI3mGwe/BCTODd4ZY
 znP58YHQnhPfjl5pbi8pGYfjz6Rbxs1VkNfvAPoUhhuGoxpv+i0c4H/ijhqEFblOhqtB
 Hp+A==
X-Gm-Message-State: AOJu0YwKXxhN4DcRTQPlcVGQ8ARx3NiGuJpgFMl0RDXKN/RH5P/FqTkh
 uBfEJko7SwYykIc+p44MEI8JIQH2O0Rdperszz3QW3rXQSN+q78DkaHDdSzDVCw8RryrQJUi+yW
 W07I1yRwedBdwunQst54OuKZGi2Fns++Qf38gdbeiFIaEgzgwsli2IrJyFRpDYHjTagBtp/YdNR
 rnQ0WL11sDOQhG9T5w8huhuG6PsW3VBrEtWJb+
X-Received: by 2002:a2e:a603:0:b0:2ec:1b9a:6981 with SMTP id
 38308e7fff4ca-2ec1b9a6a5amr66199711fa.7.1718704881775; 
 Tue, 18 Jun 2024 03:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmtXszET61iFbPQN51P1efzJtKtJvKWlDgM6gA6jKyWAFKYbF2w3oZEwnOgXPh4rlS/UKAyA==
X-Received: by 2002:a2e:a603:0:b0:2ec:1b9a:6981 with SMTP id
 38308e7fff4ca-2ec1b9a6a5amr66199201fa.7.1718704881259; 
 Tue, 18 Jun 2024 03:01:21 -0700 (PDT)
Received: from step1.redhat.com ([193.207.160.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874de623sm222365115e9.31.2024.06.18.03.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 03:01:18 -0700 (PDT)
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
Subject: [PATCH v8 04/13] libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not
 supported
Date: Tue, 18 Jun 2024 12:00:34 +0200
Message-ID: <20240618100043.144657-5-sgarzare@redhat.com>
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


