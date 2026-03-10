Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2895AFD88D4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06wq-0004wg-OM; Tue, 10 Mar 2026 19:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3zq-waQQKCkUyrpynvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--rkir.bounces.google.com>)
 id 1w06wl-0004vy-LB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:57:09 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3zq-waQQKCkUyrpynvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--rkir.bounces.google.com>)
 id 1w06wj-0002JW-E4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:57:07 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-c73783c96baso3427647a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773187022; x=1773791822; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=b+nzrbNAdvs+x6jyHUYdxcTNGPkpA+/DNlvOeQtkqPs=;
 b=tFsWc7iq3chudIyGL57ce21m+6bctB80uSNLlJftQQodrTaaQXZixaGGqJb04b/aLO
 trTljrgZN7py5DAReTmBwdeLNBv24pBAME6/EweCKpzFzVL/HFktB23NBVHzBmVv9z3X
 kLYYWNJl1JmAmNhd8NVnCwSYgzptQstTeYOUKuCG2PBSfbrL0YVxs4QPjF8ftPSoDnTI
 M7nFvYI9OXQ3jiIczAGw1cjfUJLRXuTvj4x5j/j3IhTLVMzVsImyAMLTAYvZ2VXZUbpy
 GVEgAF+F+fVapm4ZBoDlRPT1LX++Vmh+Nd99GVpGCUN0q5raeIPgCuSoYBR8qxqqSAsc
 5AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773187022; x=1773791822;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b+nzrbNAdvs+x6jyHUYdxcTNGPkpA+/DNlvOeQtkqPs=;
 b=a4afFdI2R795J8WU72OM+sXZB/W2RuWhkfrSYMqVFb5gFi/8uSS5LKLZzr/+PD4Uy1
 BvGXE1i+SQ9XAbi0nY6W4FpKoMQ8hJS217HwXDJoD/h0jvv80+sYvJ96cs3vQUKk+zWe
 jSBT4FkXgyuM3RzQLfagurr+Z+4y0F3cAhb3clTwFxO5gd5OuRa4x0Ia9DFfN9sPxm/a
 lgaeUjsDGj2U6+IyBBDxt7ewsjaEX6w1H2zPmaE/UHeFHI9VMhpdLSz5ziEhEDk1pMzm
 v/6kphsURJrLt27kWnB7YUBN4tJTDaBX035WpVpBZJoVn7U9CGXFasfQdb8vobkZjxY0
 mPQw==
X-Gm-Message-State: AOJu0YzCQDS4Z3zGKuEXrorwBEMqiAkYNbepVkQ0GvsyQLusl6+mLS62
 AcNIU15OEVTUPmY66+n+uHbG0VTcXdIUWPNaqo4NiXhBrJb+Qew5zj3buPqzE2HHqNUgCODfDw=
 =
X-Received: from pfbic8.prod.google.com ([2002:a05:6a00:8a08:b0:7b8:ac8f:27c])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4c8f:b0:829:8969:b8b4
 with SMTP id d2e1a72fcca58-829f6e714e3mr589703b3a.11.1773187022104; Tue, 10
 Mar 2026 16:57:02 -0700 (PDT)
Date: Tue, 10 Mar 2026 23:56:30 +0000
In-Reply-To: <20260310235632.3987668-1-rkir@google.com>
Mime-Version: 1.0
References: <20260310235632.3987668-1-rkir@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310235632.3987668-2-rkir@google.com>
Subject: [PATCH 1/3] virtio-snd: remove the unused field
From: Roman Kiryanov <rkir@google.com>
To: philmd@linaro.org, manos.pitsidianakis@linaro.org
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com, 
 jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3zq-waQQKCkUyrpynvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--rkir.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

VirtIOSoundPCMStream::positions is set but
never read from. It can be added back once
required.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 hw/audio/virtio-snd.c         | 3 ---
 include/hw/audio/virtio-snd.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index fb5cff3866..bd6a5d71bb 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -462,9 +462,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     stream->info.formats = supported_formats;
     stream->info.rates = supported_rates;
     stream->params = *params;
-
-    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
-    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
     stream->as = as;
 
     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
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
-- 
2.53.0.473.g4a7958ca14-goog


