Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19021F3ED70
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 05:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEgqx-0004sC-Vf; Mon, 20 Apr 2026 01:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wEgqu-0004qY-BA
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:07:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wEgqr-0002az-E9
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:07:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso5315555e9.1
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 22:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776661632; x=1777266432; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BwyGpcxIm+U3udOJ+6cB8zSHqyzc689Y7MjRe26X6L4=;
 b=GcH/W/zAeLQow3QxMQbYzyn/3kS3G4TTxXtWSpHlpw0n1GDDYwSyjlP+Qb89ZbPnpi
 kY3hDWW7x2pJkUdDiRuoVxyP+wrF2c1iISdtp5R5wmU/8kt4gbedCfbYwA2cIHc0iP40
 CCA0HhgRWy0F1YZUV9M/PnTDkoZa3ciUwQy0PNaoToxOvRNc+0V6VoteOFbQ5TP3r6Ve
 Z6/qeeGMthd0O/e6EgioECkf4hi/7wB4hm+Gqt4oeLDEpmqQrwO4q+GyXIdy5RboNnDu
 436rWmkmvijJU3UDvmCSiV4KaTtWBssG4vVXuqILMjt+INdO02PSJSYxZVPwUuzoB/m8
 mBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776661632; x=1777266432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BwyGpcxIm+U3udOJ+6cB8zSHqyzc689Y7MjRe26X6L4=;
 b=bDXcwLI91sh+xcv2jo1CZLCxTxnb8D7hKegCVVYXFaGmA0FGK/qqoPf+wrh2DFsCqV
 i0wX5lPQwwdNwhdEK452yrEdjwrdJ4kG3fdoxDmGttjJ2JuMkRMX6nCEKk9EVoeMiAo8
 b6oL8FeNT254FmeYMOr1QLqmljZVxC+VxBOa5JQnBh3YGQc/GK8MoK6yiMKWFB478NEi
 ImwKxtjKD5mVKPAt31H3BdkCOm+gfKTC1cO2/azwCGMLXSw3peSBs9nbVzbepsYbec+M
 lYxHmp/PCgJGAWBpqSK091RPuzpQV6q4VahCMwWUjcvN8tB4NFY/vYH2nVmzcTCgFH00
 Oz1Q==
X-Gm-Message-State: AOJu0Yz43QU/scTIogfiDaMc15Ec27dX726m3LkdmWKfkbQraMPSbfWi
 N0PimOCOlHCQLrxBBx1wVLek0YeaKpCN7H+IQdlz4zaYq+u8oy1f7iMHmFVz68KgkQBUgyLYMiU
 J2k5s7i8=
X-Gm-Gg: AeBDieuYUyMYBOv3vMrBMQzK4XoKJOfDU5hIi0J8SRmKXVHdvHpJL7+8Px35cXx5pnA
 PwanH6bpYHE02Jm289IlwPBKZqLFqgA8P5/QnrpIVaxCJmQoU3PURK9JDc6WeK/urKKvWchE6gx
 PWQ/Cr1JXB77kggdbL30yJEhaKTu5DXoxJ6Ib117oZzBIpM/o9Exp7yr8WvTkxDWJOKLsq4q98H
 SR1AphJ5MISF7lXDYNsorpIZoqtGOAp3O/PWNILnF7GLFoPl9VCIfwyWWJCt1jhRJDlTO0GY53s
 X+kunBlNZbRRMQo00ccxwV4r1ZqyQpoH8uC74PZyg2jQ4zYd5VQP7rj50oO5WZv6nyjshOuI8EH
 LyTgQNODkz0bdWepNoVYo40j5juVnsAqKchzRkm7nvgVwsOGs4l2g0UnDQIS9KNBFP/QvzqLD2w
 dEnEBKLxHs2FWaGUZ3znFYDZZOrbd9+NojlMHA2yla5y3H/ymg7x2UmDlir/glzk14kOCQFetgn
 Yi45ZxDCBbx/qhtoRo1W1SV3NRiy2kdiwwDB7IJ0osb7m9Nx20=
X-Received: by 2002:a05:600c:3110:b0:488:8c89:cfaa with SMTP id
 5b1f17b1804b1-488fb73841dmr178046755e9.3.1776661631947; 
 Sun, 19 Apr 2026 22:07:11 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440559.home.otenet.gr. [79.129.177.223])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a341sm28886954f8f.24.2026.04.19.22.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 22:07:11 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 20 Apr 2026 08:07:06 +0300
Subject: [PATCH v3 2/2] virtio-snd: check for overflow before g_malloc0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-virtio-fixups-v3-2-07aef1eff9d2@linaro.org>
References: <20260420-virtio-fixups-v3-0-07aef1eff9d2@linaro.org>
In-Reply-To: <20260420-virtio-fixups-v3-0-07aef1eff9d2@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=+9Dhd+SEfK8bKKIwFEcKs73DtTFYq0bCyKTuZMmWZ7Q=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnA1YlI4NnVkVmgzd01BeGxRZ2dVZEVhV3d1ZTUwCjRiMkxXZGFsbG5zd3ZOcWhj
 TnFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWVXMGZBQUt
 DUkIzS2Nkd2YzNEowQjFCRC85dHBlMVNiclVEOHJ4cmJuVGlvVXFGdmJvNGNldjVZRVNTaTU1VQ
 p5c1o4UHpBcjU2cDFwdkJ6R0o5NEhYNFVCeWVRMVBTS2M0cXljNGYxUVNMQWJqbVkyZVhmTFp2V
 U56ckxnWG05ClpEZmM0dWdnbHBSWE1Ha2t6UFN2TUFybWMxcjQ1UVNXZkFtT2pGdGkyTngvb1R6
 ZVREcm43L2ZqWC8zZ24rOVQKZzJYKy9HazRuR2pJQmFMOEcrTWhTQklIZVdhMkQ5RWxFaSsyWUc
 rbUJkUEhySVpBRXJJVzdTSFRNeTJ0TUs1Rwp4SVQ0alN5TThxYVNJaUNVRXk1SHhQK0dkOFFmVz
 NRUnp1UzA2R2hNbmxVNmo0NmUzR3F3QnA2ak00eU8vbE0wCkJDQXY0V3VQYlF0c0Q1Z3dmQlhEa
 XYyV3FONURicVRqRjNyQkk2MUVIdHZEOSs3OW5tUzE2TnpMWml6VGd5cTMKQzVqTXBxZGZRUUR1
 Q2NuTCtCb011REw1UGE2MTNieUtVdjdzd3pyVnZja2kvMnNmYy9UMU5PcDZ5S0trZkJkZwovOEV
 vN1dxNXd4S09na0t1ODFYYjgzU0xpcDJpc1lvb1gzOXNZd0xjZ3l3S3F6b2JCUDJvUE1CaERTNS
 t5Mk1ECkN5M0t2ZEgySnprUHlCb3p2azlZdVh6RmFLUTRDNEJyYXhHVFpSRlJMRzUza1JpZytOO
 C9ESTVmcjdTdnNrSlcKSk10VWJQZWtraUF0K1hvTzJVZzdPdWVLVHNEZ3pFOTIxZnVVUk15aVM5
 QnErWUQwMGlUaHo4T1h3Q1lsT2JMMQo3RHVjY0J4cW15VXNmbEdxYXYzLzMzWGtsajNSSHF0YlV
 1R3NRZG1tQWZHS0FpY3RCNFUwRGYrckNpdlF4dWV6CkkvOC9ndz09Cj1qUDJVCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Coverity points out one g_malloc0 overflow, but it seems to be a false
positive. Add a check to it regardless to fortify the code, and also add
checks for every other g_malloc0 use.

Resolves: Coverity CID 1547527
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 93fbcfb43f7fdcfd5c164b496015da743822f5eb..694bcebb60f6c866346470672cc798b3271ae34f 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -850,7 +850,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
-    size_t msg_sz, size;
+    size_t msg_sz, size, tmp;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
@@ -880,6 +880,8 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
             goto tx_err;
         }
+        assert(iov_size(elem->out_sg, elem->out_num) >= msg_sz);
+        size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
         stream_id = le32_to_cpu(hdr.stream_id);
 
         if (stream_id >= vsnd->snd_conf.streams
@@ -892,9 +894,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto tx_err;
         }
 
+        /* Check for g_malloc0 overflow. */
+        if (!g_size_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
+            goto tx_err;
+        }
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
-
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;
             buffer->populated = false;
@@ -932,7 +936,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
-    size_t msg_sz, size;
+    size_t msg_sz, size, tmp;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
@@ -977,6 +981,10 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto rx_err;
         }
         size -= sizeof(virtio_snd_pcm_status);
+        /* Check for g_malloc0 overflow. */
+        if (!g_size_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
+            goto rx_err;
+        }
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;

-- 
2.47.3


