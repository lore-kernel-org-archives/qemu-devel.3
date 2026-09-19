Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C742C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 08:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7qqx-0005B6-5I; Sat, 19 Sep 2026 04:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqv-0005Aa-M9
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:21 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqo-0007HR-MU
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:21 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so14662945e9.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 01:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789808113; x=1790412913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fdG8iXqPUCUC/4wJK/Az/Smh8dRjZ4Q22DabWoEWdDE=;
 b=cEgb7FFqnSGabkC4t3M/ql8eykM7iZaNl6trxPr83+DIGYZh+cCitWK+1C/hAI0Y05
 UhyKgfu+0yGBvsMr7+x7bEp4p1cPDEvWLCRXEaOWG6AUNmAvfBcOnE9jM+C+4FifwE7h
 7PfRxTNcicYP/G8ZPvWdhXrP5yZZKSorPJhbP7nUkz72Aqrd4gaI/7b6vjhReXTZzaHC
 1gN1OZ7CuD+eJg+hfwHXgq2c+CEc9bwVzLpPGiHO3Dk/Lus7AJfVJy6vAnjUIMK3HrSB
 cY7dqPxfeBeaddqak+hi8DzCTX6UCLLN7Hp7Pz9xcGpIae0zc88+65odgB+k54gXGGlx
 s3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789808113; x=1790412913;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fdG8iXqPUCUC/4wJK/Az/Smh8dRjZ4Q22DabWoEWdDE=;
 b=g7zHbI2lnen5cKuoxov+qe1CKQIKQJffgw1B8YWRI2NuJpj5yLiCvIRsn2M4Rc4Dw/
 Kb0f/zFhRc0fKdiXtY/VK4Nw1YDpNtErjjJhIuN9l3+T35rPJcBcykVUTp4D0pX4ot6S
 hDGOznY+4wS2dvncMHhsjHpOgsTpe4GlWwDLYZ/k5ykTrzotbikvXsZLpYFkXeJI4OjD
 yk2GEwwHkmVtjrdukHBElCTr25pGVgsEUhJeF5nFkQPOfNt8ScqZuIbhQB4LsHltl6cC
 yaHoDwyRNnee0dnMJVXea2TqbwsXaquvuLiZNNb+IKHsw0748o5QO1hi2kDpT+U5W9Ws
 XzSQ==
X-Gm-Message-State: AFuF++k3LXGs2li9D0qwTwvM/w9joqgsMy8Ims02HuFXG5hZ1xmKFbje
 d/QOFIGZTjwWupaZT2B/zCMB8ty+jjw27HXWsmwmyFd11XiusCX4btjav++peqVoxyschgerFDE
 uMtTLfDM=
X-Gm-Gg: AYBFou2/JqKtk2HCF3zE7Nj8MFwNJD1koJwxXgDZ7LjPX1/EOZkfhfrbMAoH5TBPRo4
 HXpxAHx+4RMAcZaRc90WHnWwS2b2mH2Nd6oOAlJ1RhvfPNeJRjghuiVtIRrUbMBHPPUdLgx0Uvg
 8lGZhdrZHhr4+Pgy/QfCWYTeD3m7oSXM2+Cttj6xDpst5ooZdqC9NgGSEkl1TTvP5Rh4noBVznf
 tntO5CZQ5H8/AtWfBvqGps2NHPBpB6WOIO8Wzpm4EeUNjSMTOwIhtRd4Gicf4ZEPfnGCtre8tif
 wSECI2xYkJ1NrJp1buG6GtcXt9e8pfEpc3J3xj3L8O6G2XzSMWUPDe7Zsix5ghcGPGv2KBj35k8
 4hGyj8zUJxDEGhDv7bwMUxd5N3lvqXMBU5loBfYgHw99P5oMBk/wkI01oMVZGvt1r1392Ro64dt
 OilFHsmYnGAVMrBiyTI91MuJAfoaUlIl/NgyDVC8KP7pNC/IVCRV4Mv7Sa3JyJbe5qGHKEbMn7L
 1KugFTuqQwEgqayGOOnaT+ua2JEzO4iPomDKnlarzTNVX4GZpQt1BVCKPHrb0cYgLhwRauEWugb
 J+FKAl2DaCtGu3MNGiWBo6TBftQFL11haDgDN/POZ/37ScjTewMHyhJnhBspSu1VXAg8OVrDCKs
 fKJSo8Z4jRVVAufCgTRT1GXpSyTl3LmzmIQ==
X-Received: by 2002:a05:600c:468c:b0:49e:81db:4926 with SMTP id
 5b1f17b1804b1-49fc5670ff1mr72579515e9.5.1789808113016; 
 Sat, 19 Sep 2026 01:55:13 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc58ce1ddsm82736875e9.3.2026.09.19.01.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 01:55:12 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 01/10] hw/audio/virtio-sound: remove channel positions field
 from VirtIOSoundPCMStream
Date: Sat, 19 Sep 2026 11:54:48 +0300
Message-ID: <20260919085510.3388454-2-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
References: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

This field seems to be useless currently, as we
don't implement VIRTIO_SND_R_CHMAP_INFO.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260803081159.91981-2-alexander@mihalicyn.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/audio/virtio-snd.h | 2 --
 hw/audio/virtio-snd.c         | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index e28f1be5db..f8bb5c95b9 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -137,8 +137,6 @@ struct VirtIOSoundPCMStream {
     virtio_snd_pcm_info info;
     virtio_snd_pcm_set_params params;
     uint32_t id;
-    /* channel position values (VIRTIO_SND_CHMAP_XXX) */
-    uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
     VirtIOSound *s;
     bool flushing;
     audsettings as;
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 694bcebb60..46d81cc9ec 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -463,8 +463,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     stream->info.rates = supported_rates;
     stream->params = *params;
 
-    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
-    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
     stream->as = as;
 
     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-- 
γαῖα πυρί μιχθήτω


