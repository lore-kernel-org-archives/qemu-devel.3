Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DDBC07E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 12:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytAI-0001pj-H6; Mon, 22 Apr 2024 08:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rytAA-0001du-3A
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:52:50 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rytA8-0006Pw-CA
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:52:49 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so3971687a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713790366; x=1714395166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wtIOp9fwmceyQgZZl5DZ5tv3mHejfW4oGwssHFQ9/1A=;
 b=GiuqhOOKYGFyjWJz5kJf8rdUhM3A3dP15lftwyZqeYDYuWIRd5O5XlCF5p+YOtvfd9
 P+9Ca7kcBMRhf1VdNfs4CW6fESpZ0dslkexcYnTV7kAWMrO7zWDoatpBAG2adjKsMfu9
 +EOu/Ke2o5R0tMtGW6bfjTfLTO+Ni8ZKTMqTLkw8hukKUyvDCrTH0C9CreERMSv+Hj7+
 WijlH5mFrepxwjkU4Ns0p0M4tMmeMf7DBxeYd1usKMVLU1+fgDgD6hnSqQgVSVxmrgZ3
 OfdHLb0m2ZMDVqIOesmDYbPVLPnqdRScgstjSeqeFAB9ksNLRuvFsa4eIjS8jkTXE6CJ
 Skfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713790366; x=1714395166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wtIOp9fwmceyQgZZl5DZ5tv3mHejfW4oGwssHFQ9/1A=;
 b=HrvXn+zK3miFt4CBhSPC71pMf6h/Wd7XmEqbtxl2ludsCfOz3eoH1IrqUXE5Xb66q6
 L+Zy+qKRCV6oJlS/FZDMlBG+G+ax0bVu40WwO20+Na5McAiIGS/3CUo0vVSpQbdwyrox
 JUVyp2udKBHUnMyNs5d72pIte9yOXtdj5ObPHy8atibf4UXyyFYJt5YU3Y99VIZEyntu
 8v1SQnxZeOsJQm5trv3zxPBHl5ARj4X6r16FKvJYlFXzjywHKyvBLeqVStr8TpEvfpFJ
 JMdBJuPV4qRFsEwlkR3uC2YT2ZA/tfs84ygUZIi3od/uRquB5xTEskV/+M1VLH6aMDlI
 BT4w==
X-Gm-Message-State: AOJu0YxhamQmNybDwkApEDhrUqFNgLVOsSHV8xDBkl6AL/yl55PPmP7v
 y1IyiC7PY0qCBbplhPivHp+8L8mnTyf5lblqn5ZW77UTpGK228RKhhZM2jG4t+IUz1IWzWqinIG
 m
X-Google-Smtp-Source: AGHT+IHbg2QxQMal/J5vECQD3Nyxycu/iAMpYrikqRSLeFjGXcG1XDwvlf0gdZx2hXB6CVFno2zP4Q==
X-Received: by 2002:a17:906:b117:b0:a52:671a:aaf2 with SMTP id
 u23-20020a170906b11700b00a52671aaaf2mr7136278ejy.72.1713790365901; 
 Mon, 22 Apr 2024 05:52:45 -0700 (PDT)
Received: from localhost.localdomain (adsl-53.37.6.0.tellas.gr. [37.6.0.53])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a1709066b8a00b00a55bfb4e3b6sm593574ejr.217.2024.04.22.05.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 05:52:45 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 2/4] virtio-snd: factor card setup out of realize func
Date: Mon, 22 Apr 2024 15:52:12 +0300
Message-ID: <62de737e3320e647454a306bb87c6eb20a2c0cfb.1713789200.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
References: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Extract audio card setup logic out of the device realize callback so
that it can be re-used in follow up commits.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 72 ++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 7ca9ed251c..82dd320ebe 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1073,27 +1073,21 @@ virtio_snd_is_config_valid(virtio_snd_config snd_conf, Error **errp)
     return true;
 }
 
-static void virtio_snd_realize(DeviceState *dev, Error **errp)
+/* Registers card and sets up streams according to configuration. */
+static bool virtio_snd_setup(VirtIOSound *vsnd, Error **errp)
 {
     ERRP_GUARD();
-    VirtIOSound *vsnd = VIRTIO_SND(dev);
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     virtio_snd_pcm_set_params default_params = { 0 };
     uint32_t status;
 
-    trace_virtio_snd_realize(vsnd);
-
     if (!virtio_snd_is_config_valid(vsnd->snd_conf, errp)) {
-        return;
+        return false;
     }
 
     if (!AUD_register_card("virtio-sound", &vsnd->card, errp)) {
-        return;
+        return false;
     }
 
-    vsnd->vmstate =
-        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
-
     vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
     vsnd->pcm->snd = vsnd;
     vsnd->pcm->streams =
@@ -1101,9 +1095,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->pcm->pcm_params =
         g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
 
-    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
-    virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
-
     /* set default params for all streams */
     default_params.features = 0;
     default_params.buffer_bytes = cpu_to_le32(8192);
@@ -1111,6 +1102,41 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     default_params.channels = 2;
     default_params.format = VIRTIO_SND_PCM_FMT_S16;
     default_params.rate = VIRTIO_SND_PCM_RATE_48000;
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
+        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
+            error_setg(errp,
+                       "Can't initialize stream params, device responded with %s.",
+                       print_code(status));
+            return false;
+        }
+        status = virtio_snd_pcm_prepare(vsnd, i);
+        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
+            error_setg(errp,
+                       "Can't prepare streams, device responded with %s.",
+                       print_code(status));
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static void virtio_snd_realize(DeviceState *dev, Error **errp)
+{
+    ERRP_GUARD();
+    VirtIOSound *vsnd = VIRTIO_SND(dev);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+
+    trace_virtio_snd_realize(vsnd);
+
+    vsnd->vmstate =
+        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
+
+    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
+    virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
+
     vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
@@ -1123,26 +1149,10 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     QTAILQ_INIT(&vsnd->cmdq);
     QSIMPLEQ_INIT(&vsnd->invalid);
 
-    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
-        status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
-        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
-            error_setg(errp,
-                       "Can't initialize stream params, device responded with %s.",
-                       print_code(status));
-            goto error_cleanup;
-        }
-        status = virtio_snd_pcm_prepare(vsnd, i);
-        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
-            error_setg(errp,
-                       "Can't prepare streams, device responded with %s.",
-                       print_code(status));
-            goto error_cleanup;
-        }
+    if (virtio_snd_setup(vsnd, errp)) {
+        return;
     }
 
-    return;
-
-error_cleanup:
     virtio_snd_unrealize(dev);
 }
 
-- 
γαῖα πυρί μιχθήτω


