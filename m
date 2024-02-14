Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72E9C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFq-0006EE-IQ; Wed, 14 Feb 2024 06:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFN-0005bx-Mu
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFL-0007Ox-Uu
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YXqr7ST6Ul9FSSoAU3o419J9SGTE+jd0wE02/JUaNUI=;
 b=e32kLoJhCLYhcLABgfsqkcqTE1FWkOQxtHSOXFXHXHv+O2SbYhObTkN0LBlocL3DmJ32A5
 nOu5KBXumBkExEDBzPhL/UJTnidWPEoYqK73RH3uMndh1VJySxp+Z/AFruuRi2od0tTTix
 qfJTwMHM6BqK4KWRTtv71YNFer7NC+M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-F0fLAng-OcecVMHWt4HvIg-1; Wed, 14 Feb 2024 06:16:09 -0500
X-MC-Unique: F0fLAng-OcecVMHWt4HvIg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3d3e8f1635so32640766b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909368; x=1708514168;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YXqr7ST6Ul9FSSoAU3o419J9SGTE+jd0wE02/JUaNUI=;
 b=B9RUTub47WX6tOYslZo9yS6D1eFAh5EnUP7js9A3KvcI+EIwmNQ1d9AbHf3ftfgfzA
 2j/TwVYZc9G5hcxN1wTXzyyHkWn9Vkwjjq5wimMpAccTd5vlsnZ88w1BF4+femnV75iN
 zjCStrE/vmZU2lIQTLxzwnrATLE+HIB9rSA7wtpXZKoG3Au5RIf0c5U0NiAY+mUp8RgK
 5VvrQSjeOjAv77c0Y2kgUYVk2tILPAB+n2krrassdf9CBKqobJ8A17si8iYZwAvWVZeP
 zGdtwr6t08SOhUZibsXYFb/ICpWtHUShBKYrUKeDrIdh0TEPt03eJFQnX9MLxYKThybu
 nqzw==
X-Gm-Message-State: AOJu0YwjcIP9a5mtfohCIB47eVwB77xsqy5Udh3R+obKjbOVuVCltBV6
 Cg0bohRraQm3bl28Uh4lfVc6kKvmPJNRkqXg+RDPZK/z0DsIp2gmlpMty1VsGJSzoCGaIRQiuGy
 Hg6Wnfh3jKt9GmudkBy0VGQnEsE0ZXJZIpzyl7CQ36PqUMNUFkKACsRHyhzT6WN4SUlMgD7SF0l
 J6JvxOS46O9oyqDaE++oyGrfkDPZY1pg==
X-Received: by 2002:a17:907:378:b0:a3c:a6de:a132 with SMTP id
 rs24-20020a170907037800b00a3ca6dea132mr1434715ejb.57.1707909368165; 
 Wed, 14 Feb 2024 03:16:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/YdiwdOS7wLor/YnjKGgPNT3Qi9IfRkVD3oYLpQ5RWW1QNSqmc0GNgMidFatApXgA5Dt5ng==
X-Received: by 2002:a17:907:378:b0:a3c:a6de:a132 with SMTP id
 rs24-20020a170907037800b00a3ca6dea132mr1434699ejb.57.1707909367867; 
 Wed, 14 Feb 2024 03:16:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUVLx8F6LS+1vzdgVzPvmurqPddMV49N1GxsoZawCpSQtaCIQlAtemogFT0KUXH4HtjyaNa5hNSUIH974t9aYGJwRbH9l2Y39fvcKfLOUacRyMmgSNmie/zArNYFLbILD2d9y6a/PI9sqaIuKpTSA8xq6/hVyWW270vhagbWPBEAkXVYGGtAxoToh4hPBMkvr7b/QAp2g==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3ce8093f6esm1981759ejd.179.2024.02.14.03.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:16:07 -0800 (PST)
Date: Wed, 14 Feb 2024 06:16:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 54/60] virtio-gpu: Correct virgl_renderer_resource_get_info()
 error check
Message-ID: <574b64aa6754ba491f51024c5a823a674d48a658.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

virgl_renderer_resource_get_info() returns errno and not -1 on error.
Correct the return-value check.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20240129073921.446869-1-dmitry.osipenko@collabora.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/vhost-user-gpu/virgl.c | 6 +++---
 hw/display/virtio-gpu-virgl.c  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index d1ccdf7d06..51da0e3667 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -327,7 +327,7 @@ virgl_get_resource_info_modifiers(uint32_t resource_id,
 #ifdef VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION
     struct virgl_renderer_resource_info_ext info_ext;
     ret = virgl_renderer_resource_get_info_ext(resource_id, &info_ext);
-    if (ret < 0) {
+    if (ret) {
         return ret;
     }
 
@@ -335,7 +335,7 @@ virgl_get_resource_info_modifiers(uint32_t resource_id,
     *modifiers = info_ext.modifiers;
 #else
     ret = virgl_renderer_resource_get_info(resource_id, info);
-    if (ret < 0) {
+    if (ret) {
         return ret;
     }
 
@@ -372,7 +372,7 @@ virgl_cmd_set_scanout(VuGpu *g,
         uint64_t modifiers = 0;
         ret = virgl_get_resource_info_modifiers(ss.resource_id, &info,
                                                 &modifiers);
-        if (ret == -1) {
+        if (ret) {
             g_critical("%s: illegal resource specified %d\n",
                        __func__, ss.resource_id);
             cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 8bb7a2c21f..9f34d0e661 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -181,7 +181,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
         memset(&info, 0, sizeof(info));
         ret = virgl_renderer_resource_get_info(ss.resource_id, &info);
 #endif
-        if (ret == -1) {
+        if (ret) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: illegal resource specified %d\n",
                           __func__, ss.resource_id);
-- 
MST


