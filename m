Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D768AC88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7T7r-0005dN-BP; Fri, 18 Sep 2026 03:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7n-0005cM-DO
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:11 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7k-00071I-2w
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:11 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so2242935e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 00:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789716906; x=1790321706; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fdG8iXqPUCUC/4wJK/Az/Smh8dRjZ4Q22DabWoEWdDE=;
 b=VkWiK5j+LnQoV8ddSVx1zIKP/sJgXeSLK3CdGlsEKDdlgh3y0dhBaQ1RMpdEhMuxon
 OWVCFuxW9n4nbvX+5KzMZfwFLlCSw6NREVTjQbr71rETjDOQ6M9TYxVFLOc5k2/I/pyK
 l8h8kdoauXGQrGeEmszBA3timu2ebY8MtpQZA6CcuxsBh01BfTZX23xvsQNs2YGRi6v5
 KU+B6RTNQtsWJ2qTBk+Fwpkh8hbwJ5C7kk0+ZOhw9rnz5liRyJeyOZ5pHo378C60Zqiu
 2hKyxyJTVd20QW9R06ZWuDWZbC5W971bRPVY1O0pthj+KBgBHHOMnJSqF6K8FCnUZHMa
 +Afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789716906; x=1790321706;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fdG8iXqPUCUC/4wJK/Az/Smh8dRjZ4Q22DabWoEWdDE=;
 b=ZrMK8r8rSLGVPMXW3HqKQIIerZjejdX+s3t5R8YQuW6LYENi7UZb9tGC58xfVob0zJ
 ZIOwErmH+LW9ckbaofmBxN+u9sDV6Id7CJ/5CrUEangJebDtbXJbvxi58CNgpXtw6Z8c
 Xv6mPT1cdK9GRzdgjW9GnymCnZcq8uuNPkAn4ZU3EtEX0UlAo/NBv2e1bnwbYoWRJPM9
 utngoFjsvu5yZ/ol0b30RhApq18e9KQ5fb+mPXpNq5qeA4lXeO/Iim2hCQLZDex9SSvw
 Oap6jmQ+bXyt69PeysSidFcnTxOotgwFFrBENKmtwH1wxfYCWWoRAkOqTgFLH/gGzt86
 AacQ==
X-Gm-Message-State: AFuF++kc+heuOdgi0kV4HdrfdYrpEUc1rmAOMXIrlWbQFB3mgbo06lTs
 lu2MXWBfraODVcWc+QSMLx/oF3aqzHZNLpIGFlMg2/fKxLBK3qQyT1DNFplGXbfPuiGF2sidcsf
 3v9bONeU=
X-Gm-Gg: AYBFou1y9jUJHrp0NFzHI7dFETnaD7L14PXEKU0izq3JaA/eQT+cMcrdb8gnj2iBOrc
 Bn1r6A6ht6z8MycBrkfRxEDTGK3o6Sto65LhQsDZiV3mz1jZp3/GGhCHgT3Q4DXh2gFWEwqWt8C
 HPpERTZfC8FzaO+sV/cSW89E7NFabq7rRooJG/VeGlocmZ4RcM4lwJIh9Z+q10vFqQMT3HQJgsu
 d0DBZ4rQAPbirUHFQSbD1F1qGNIqtbhSED4dq6rZLkEMN6BeYFP9+U7MGQKMnavFUKMGTVWlUDF
 m5SLu7SOpxWv5dBcmXLQ+aowaQrv5KlRisuO0X7Dr9L+adV6tjXCZ/Cw8+SiwTwrpRrrghkQq2i
 frgAvc1PCj9pLXyZd4x6m+lHIcuLkDYPcX98hRsRCDJ/Ki7LeXDRLLndNrbZkGjyLK+GN1xPupI
 eRu6B4G8noIcpNORZQy3rFH36NBU+x6RT3+C9R+Gj9TqLihycHhyRLKl79JaG8h7gso7JFakE8B
 zrP7dCaBBVmZ6FZDPs/tJzK/7P9SnsfNXnMdu6v+hbP2TKbDXQcf6vBID0WlEjHZu+FEaPlnsvl
 HsoMqju7wGJsjMV2d7QKhwlPTAtQkOXVmcEscO/BbbakxFmxx+PxCFEwQO3sXDQcSBYspvG7lXu
 o47qUboMRA8y1cAu5qV4C8im75Es/PLjEkA==
X-Received: by 2002:a05:600c:4e46:b0:49e:642a:4f6f with SMTP id
 5b1f17b1804b1-49fc585e9edmr16220255e9.33.1789716905703; 
 Fri, 18 Sep 2026 00:35:05 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc471b9a2sm23879825e9.0.2026.09.18.00.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:35:04 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 01/10] hw/audio/virtio-sound: remove channel positions field
 from VirtIOSoundPCMStream
Date: Fri, 18 Sep 2026 10:34:44 +0300
Message-ID: <20260918073502.3265143-2-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
References: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
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


