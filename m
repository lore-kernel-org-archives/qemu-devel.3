Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F077C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAac-00062C-IK; Tue, 12 Mar 2024 18:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaU-0005Jr-RX
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaT-0004Li-A8
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZviP4yQ6PlfNYlhjLnO9O0fDmhpIErXsX1IdIBxhxY=;
 b=Sz1k3gH8Bw4DCRAuHxGXQDE+xRu4C9/7DYOborcbXIsWNyOnVYsov6VfTLBXGdYjryasgW
 TKJTntR/d8wlR+nAMTd2yv8MlT9mUEk+EIeuiT/mnQrBp+YIpyKyeKDpG5QC9MsKT+8wxT
 HPKsLXCY/SqVfxMnkXyhu5M73HSFRsw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-d4WTOU5SM_OTp5vbNf6guA-1; Tue, 12 Mar 2024 18:27:07 -0400
X-MC-Unique: d4WTOU5SM_OTp5vbNf6guA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5684650b00bso197475a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282426; x=1710887226;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HZviP4yQ6PlfNYlhjLnO9O0fDmhpIErXsX1IdIBxhxY=;
 b=GbkEJJUB1nAieTIg25lkxX7O5JJftRUbSXT36rNHQ4D8bDDxPZhWaXR+uzgdlqDgsk
 Ndujii3gHqcqXHlB65zO6N2s7h3v80hwmb2EvH8oyo/RsXLi6iq3k69vJarA6MVYTAXV
 En81/qlK5lmNE0NYsrBgVTHT4IfwxcnKipr5DTo396d/ZlE76dRzSuiGpV6jq7qrf/Yz
 MxzBBpFXi07BML+z5bAKbaIeXc0PKojxCIY8DNn0viVHDd2W4HzNHCagXHh/UMA6Qdi/
 LdWD6Uk7TSEXtFeXL+Av4zqEqATv5hru8MBXLsunCyeXQ/ZgcOU9jHRWv7iV1nyctYuD
 XGdw==
X-Gm-Message-State: AOJu0Yxu9WdgjQ7FSfVMx+CgB8A8Keslf78RuxNIA55vYh4+OovtU7pg
 kDTA3U7xgf1fde++shrBIjP1chkjOlSZup4Hfm2ewMu42MHynbfLeHw4Hn8LYy/lIXUoER/VS79
 m7I2QrvNGGBpiWohewfUMT5oSSgrhpqv9mRdP3lpYE+5MnFDKXZLZFRSeUC8VmC6RPooso53F/P
 AROcNh+jca2zqKzQfQxqVy9h+1+0nSVjsW
X-Received: by 2002:a50:d69b:0:b0:568:1c9c:95a7 with SMTP id
 r27-20020a50d69b000000b005681c9c95a7mr3130005edi.40.1710282426083; 
 Tue, 12 Mar 2024 15:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfHQzJ1JyQ7t76fDjre6/5htUCC57Xu8nWAgvtBGdQOxE6DKGNxgCsu4K3e7aDb+q3J0GZbQ==
X-Received: by 2002:a50:d69b:0:b0:568:1c9c:95a7 with SMTP id
 r27-20020a50d69b000000b005681c9c95a7mr3129989edi.40.1710282425662; 
 Tue, 12 Mar 2024 15:27:05 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 r14-20020aa7cfce000000b005687f8721f9sm296397edy.82.2024.03.12.15.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:05 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 30/68] hw/audio/virtio-sound: return correct command response
 size
Message-ID: <633487df8d303b37a88584d5a57a39dbcd91c7bf.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

From: Volker Rümelin <vr_qemu@t-online.de>

The payload size returned by command VIRTIO_SND_R_PCM_INFO is
wrong. The code in process_cmd() assumes that all commands
return only a virtio_snd_hdr payload, but some commands like
VIRTIO_SND_R_PCM_INFO may return an additional payload.

Add a zero initialized payload_size variable to struct
virtio_snd_ctrl_command to allow for additional payloads.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20240218083351.8524-1-vr_qemu@t-online.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/audio/virtio-snd.h | 1 +
 hw/audio/virtio-snd.c         | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index c3767f442b..3d79181364 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -230,6 +230,7 @@ struct virtio_snd_ctrl_command {
     VirtQueue *vq;
     virtio_snd_hdr ctrl;
     virtio_snd_hdr resp;
+    size_t payload_size;
     QTAILQ_ENTRY(virtio_snd_ctrl_command) next;
 };
 #endif
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index ea2aeaef14..e604d8f30c 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -243,12 +243,13 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
         memset(&pcm_info[i].padding, 0, 5);
     }
 
+    cmd->payload_size = sizeof(virtio_snd_pcm_info) * count;
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
     iov_from_buf(cmd->elem->in_sg,
                  cmd->elem->in_num,
                  sizeof(virtio_snd_hdr),
                  pcm_info,
-                 sizeof(virtio_snd_pcm_info) * count);
+                 cmd->payload_size);
 }
 
 /*
@@ -749,7 +750,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
                  0,
                  &cmd->resp,
                  sizeof(virtio_snd_hdr));
-    virtqueue_push(cmd->vq, cmd->elem, sizeof(virtio_snd_hdr));
+    virtqueue_push(cmd->vq, cmd->elem,
+                   sizeof(virtio_snd_hdr) + cmd->payload_size);
     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
 }
 
@@ -808,6 +810,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         cmd->elem = elem;
         cmd->vq = vq;
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+        /* implicit cmd->payload_size = 0; */
         QTAILQ_INSERT_TAIL(&s->cmdq, cmd, next);
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
     }
-- 
MST


