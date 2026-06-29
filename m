Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F1DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we7H3-0004tO-3j; Mon, 29 Jun 2026 04:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we7H1-0004t6-Lf
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:23:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we7H0-0001bw-5B
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:23:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4936e85e0deso8837455e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782721399; x=1783326199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=R6u0vAA0vK+l4013l2rEJFfm9M5Jph43ZQDwKJ1GRxE=;
 b=N/qWjqV/+xaOmPL8edaiIA/EPy/CJSrWRqzIhQQP96OnREMbYC57HbvY1xmESxrXYn
 rp7GpM+jAN1OI+THLvp3WE0q1r8qyIHgYltBsNxZqhVrUncVe1aWgGeOwi55XJl5fk/k
 jPisYfNn1rWDBMQrmSbplE4deIsnrFlmJAyMAo00ol4Xj1VgrYt+vusa8RRZe6KeLu8+
 uistmR0QvXHfZT+U1P92JVnrB7N9+qwCozdpSZ9sf5feOtFrn5r6yrjCKbqX8sdzxN4N
 bm64t7zLkdQUpSc2rhWAYyjnZRq4WmP2V6EQBI7+zAMwAWR8s5n4IXWZF5htReWGn7ee
 +IEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782721399; x=1783326199;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R6u0vAA0vK+l4013l2rEJFfm9M5Jph43ZQDwKJ1GRxE=;
 b=aLTf4cOaB9/3xdJJMREOIZHT8zsju3Zn5Rwn7OEaXKatyApkD8TlmMdSkTN6K7DCC8
 5g3MPkjkB+8YhEJ84XuBkkbA+QoRukTXmTY+Gg0lXYiy2VCSv/bc+PP/pbbVYavekQnu
 32mcCwEaINuuUcD0CZUttJR/Nc9FubZ7l9C4cAJkgvMRfD+UnmxND2bRoksrcyDwjLl3
 M3TUcJYw7SaKRT8QtNK9/3H4edvEBkPAGSucjByBkfQuGdac36noYqZ3My0NIY4o/UHK
 j4z5r67ehffn8pMrjTNxPKCMaquXihR+p/wc/NvqN6M1bQVnhqFZqGWYxuog2r6otX53
 NWTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qImhKXYo1ECUoxv0OSEppLf+ty26lltJr5MLGpLMgmnnPlcxXclRzaTbZg4ww7mB1G/sk+tDJmcUz@nongnu.org
X-Gm-Message-State: AOJu0YyMbK5s0MglEgGO+7NbWfHjc8T2jhozJmIAALY2MQzs36scEGIg
 IJL0j+U7ldPuOtXAFhmAZEr92nn+spTZWOyRpfE5CSAS7EEtMhazNju+XsETBEjk1BY=
X-Gm-Gg: AfdE7cl+gip/soCiW6bROkFqQvpj7j8RGfLGRlNlGyEqvo51t9hAdOmTiYh8YqnJ1tj
 pcOyAxceKKERPm051HKD+BhSruFu8D99giwYjF4smIXT2OAHl0dw65CrBpQGwcD6eVWtfH2as+y
 d9DeZ3igqIz5ytzlC/8DTDSz4lm+o4sDuIUQPF6USPYOc9E2gPYSxL6CvPfAP8cewOi70hU7ARF
 SreT/O3bqe2F+UHavDcVE8xQ22hMDoDTWGBjVedUP6Vls99wSKIkNnKYgTCLb9EA/Q3304qazg1
 9GkZEzGlAi1SHpwn4RPd2t+MaP+K/+dZKLBDi7RDHerH9uogDJ5MqQQNnf5j+xyshYE1+hxNggQ
 SnmPFuZJJXVmK3z02PhqrqzoRQY13XrAF9vVhq9SDt/E/fXQjXoCgYKy3S4ffywcXykfnNxwpse
 dHsXQdAsx8Tkz6qYLQ2YLgFZMNJtXZ0yD9cIaBHcAptw0KV6uFzCR0wjSnyrB41Pefd4WZa71TV
 HBcmvAGaqJo+1VtWoxwdljIAgb0y2hl69HfACuK8JC8Ahv657svQWFHjHLgOqrr5IqWaoaUk+7c
 gHR+IsZFkhzQXIIOVyYmRgw=
X-Received: by 2002:a05:600c:4515:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-49266873f75mr218148655e9.9.1782721399272; 
 Mon, 29 Jun 2026 01:23:19 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269071d05sm302174125e9.11.2026.06.29.01.23.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2026 01:23:18 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:22:12 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org
Cc: Volker R=?UTF-8?B?w7xtZWxpbg==?= <vr_qemu@t-online.de>,
 Marc-Andr=?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 St=?UTF-8?B?w6lwaGFuZQ==?= Graber <stgraber@stgraber.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v3 8/9] hw/audio/virtio-sound: remove channel positions
 field from VirtIOSoundPCMStream
User-Agent: meli/0.8.13
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-9-alexander@mihalicyn.com>
In-Reply-To: <20260626123531.132078-9-alexander@mihalicyn.com>
Message-ID: <thdwmt.3hykbwjwse6du@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
>From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
>This field seems to be useless currently, as we
>don't implement VIRTIO_SND_R_CHMAP_INFO.
>
>Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>---

You could move this patch at the start of the series so that you don't 
need to move around lines that touch positions and then remove them.

Either way:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>v3:
>	- this patch was added
>---
> hw/audio/virtio-snd.c         | 2 --
> include/hw/audio/virtio-snd.h | 2 --
> 2 files changed, 4 deletions(-)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index c9c93bd090a..81ba1e1a277 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -437,8 +437,6 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
> static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
> {
>     virtio_snd_get_qemu_audsettings(&stream->as, &stream->params);
>-    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
>-    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
> 
>     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>         stream->voice.out = audio_be_open_out(stream->s->audio_be,
>diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
>index 72ef34e0976..85d5d7c8619 100644
>--- a/include/hw/audio/virtio-snd.h
>+++ b/include/hw/audio/virtio-snd.h
>@@ -123,8 +123,6 @@ struct VirtIOSoundPCMStream {
>     virtio_snd_pcm_info info;
>     virtio_snd_pcm_set_params params;
>     uint32_t state;
>-    /* channel position values (VIRTIO_SND_CHMAP_XXX) */
>-    uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
>     VirtIOSound *s;
>     audsettings as;
>     union {
>-- 
>2.47.3
>

