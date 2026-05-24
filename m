Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07925CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 08:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR4N3-0000pb-Nx; Sun, 24 May 2026 04:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR4Ms-0000pA-53
 for qemu-devel@nongnu.org; Sun, 24 May 2026 04:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR4Mm-0005q5-OC
 for qemu-devel@nongnu.org; Sun, 24 May 2026 04:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779611959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFB3Z1IlTRiiapSnVe6zG2T9VrE+ICv30J8TG4XwNnM=;
 b=VY6oiDdd5orwKFqHNrWHPq/pDA3XqAsXQBTdcqpyPmDkGDQh+2qEsnbIjYb4MljUohCx5j
 aDjBKT3zvpAkYHh5I9ooPS58cNDyxwXjhbJ4mleNVGrihNFfJahai8HU9E2JL88WyZRLfE
 4uyt7JliuA0O5K7POWm84UErTSUIPYI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-n4A_G2OHPcqeXsDiFeAa-A-1; Sun, 24 May 2026 04:39:17 -0400
X-MC-Unique: n4A_G2OHPcqeXsDiFeAa-A-1
X-Mimecast-MFC-AGG-ID: n4A_G2OHPcqeXsDiFeAa-A_1779611957
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fdad6cce4so40330585e9.1
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 01:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779611956; x=1780216756; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JFB3Z1IlTRiiapSnVe6zG2T9VrE+ICv30J8TG4XwNnM=;
 b=ATZpmY4xk11J3IiHbJeHahlMgLG0gZ0iqUbFkXfrTCv6IgH3Wr+u6xWRfAPhDnRzEE
 k8FlUbNy/HxoFeyv4M63WNJ+sDbQAtt4ce15y07fSVbM4yMk+9n9TQHadZXccO4OUN15
 8K/rTiXorIdZJCgG1vTfHL+6PM4XMJxwcHgjkL+QFBjNqUJKY3bcab7tTnfvLnbbowfv
 SHs2pbIO/C5MNxL1XpEGsjbd5ibNT/umb32DaYI+GHk27Ubo56A/fqQjqoysFjR4+Lhe
 I6rEoP5uoW9Vq4B4iu7/UQTHypcKse6gEzOHLQzBT0fIBTuKK8QmdTQmPrY0Gp3sz55d
 U2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779611956; x=1780216756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JFB3Z1IlTRiiapSnVe6zG2T9VrE+ICv30J8TG4XwNnM=;
 b=lvfvzgF+35MJqH7e8pw7KCr5MaC3xwiu3tXgPTsob46AI9vvjKhy5vUpQXQCJo8RCe
 MyFUdVQWBIZQg2e3cIgeahVn2s+QHA3ktlQctz41Dx+vgMXFqtbz+exZN+/0d+ryLzk6
 H8jyFUO6Xk65GGAflevTkVIXmZ2NcXelVhOAuX13YzjeTFc6oyH2jIxkvoZX/EEWyw0N
 3jMVErx2J68HIwCMDPakCXQNwDe8AnWMxthmPYSwZMROj4EoztD3K5rinWAoTc+dkXRM
 qq4lwJqb89DDRNbXJouOQpiIi5kO+SIOe0LhAniJcGRpZgV9c+Z7rAmdl4kOSriOKeZY
 CGQA==
X-Gm-Message-State: AOJu0YxZNuVYO4Ik+dbMwe+VvIuFUOTCvbs5gzT8oOHB0TEWdJgi2AmZ
 TamvmHlRHb6LrXlwu35PgpEhTfzMAhOvewnmubNDDpHJqtSIlk65YIrSER8QcljJSxXyWxJkXXP
 Bl86tKiTvWdsfnbWVH+IOfrBB+mT/OCntsr602o4D/U0qAVWliOyMP7xI
X-Gm-Gg: Acq92OE/eJUVHwXXc5lrTBqjs7bv/07/gQFlkog2ZRNiIz1GrcF8So4uXn3Yy5lOL/Z
 QBMApgOpCzTIClfrda3S+a+XMZ6oMn+jr6NPOkyG+jEWi5kShAtCZ5bgvYUfJJ6jNhjSn2e5Oaq
 B9RlcT/1UZNSKldWIxQ/LTqM6gY2G/RXI57iEr7dP9VSVrnv+OPme6nk0szMEcucNZTVbqcWKEN
 FjU5HIV3k4LJpOBRi4FWOVw28JWmKuuAtqIi3Ff2l7Re1796YpvTa0qa8XAqACTkrucbhp+qjiI
 k4xReTE+r5PjgMhwByPtj7b33ynd8nqwOO+vkhpG3L88CaF/mZ5RBfOzWGsn73eTcead9AiYOds
 sQ74aolr44hciAaOX7j1EITxUQdZI9T8ZsPs+fhnJxj0=
X-Received: by 2002:a05:600c:2a8b:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-4904226d9camr86921035e9.5.1779611956494; 
 Sun, 24 May 2026 01:39:16 -0700 (PDT)
X-Received: by 2002:a05:600c:2a8b:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-4904226d9camr86920735e9.5.1779611955972; 
 Sun, 24 May 2026 01:39:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ea134sm187066345e9.8.2026.05.24.01.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 01:39:15 -0700 (PDT)
Date: Sun, 24 May 2026 04:39:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: slonkazoid <slonkazoid@slonk.ing>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v2] add a refresh_rate option to virtio-gpu
Message-ID: <20260524043219-mutt-send-email-mst@kernel.org>
References: <20260415-virtio-gpu-refresh-rate-v2-1-b71599d84755@slonk.ing>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415-virtio-gpu-refresh-rate-v2-1-b71599d84755@slonk.ing>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

>On Wed, Apr 15, 2026 at 12:19:05PM +0300, slonkazoid wrote:

Your From is mangled by qemu-devel (I'm not 100% sure when does it do
it, but it did here), so please include a From: line here inthe body.

And please add a short description here. Maybe the text below,
preferably with uppercase letters )


> Signed-off-by: slonkazoid <slonkazoid@slonk.ing>
> ---
> currently, the virtio-gpu module does not set a refresh rate, making it
> default to 75Hz in the qemu edid generation logic. i wrote a sloppy patch
> that adds a `refresh_rate` option to virtio-gpu, which propagates to all
> the devices based on it (i was interested in virtio-vga-gl). it's not of
> much use by itself but when combined with something like Sunshine or
> looking-glass, it can provide *far* smoother guest graphics than the
> inbuilt display devices. i have done a bare minimum amount of manual
> testing (virtio-vga-gl with venus XOR amdgpu drm native context streaming
> video games) and it functions as intended, and should not break the code
> path to fetch the refresh rate from the active display device (?), however,
> i have never contributed to QEMU before and i don't know the customs
> concerning testing, documentation, etc. if there's more i should do, please
> tell me! if this is something that would benefit QEMU, feel free to merge it.
> it's probably not a copyrightable change anyways.

I'm not sure why do you mention this? is there a copyright concern?

> ---
> Changes in v2:
> - Update default value of refresh_rate to the old implied default of 75000
> - Link to v1: https://lore.kernel.org/qemu-devel/20260414-virtio-gpu-refresh-rate-v1-1-59e6320eb24e@slonk.ing
> ---
>  hw/display/virtio-gpu-base.c   | 1 +
>  include/hw/virtio/virtio-gpu.h | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index cb76302e2d..d87f6604d0 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -232,6 +232,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>  
>      g->req_state[0].width = g->conf.xres;
>      g->req_state[0].height = g->conf.yres;
> +    g->req_state[0].refresh_rate = g->conf.refresh_rate;
>  
>      for (output_idx = 0, node = g->conf.outputs;
>           node && output_idx < g->conf.max_outputs;
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index f69fc19462..e440535fa0 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -131,6 +131,7 @@ struct virtio_gpu_base_conf {
>      uint32_t flags;
>      uint32_t xres;
>      uint32_t yres;
> +    uint32_t refresh_rate;
>      uint64_t hostmem;
>      VirtIOGPUOutputList *outputs;
>  };
> @@ -176,7 +177,8 @@ struct VirtIOGPUBaseClass {
>      DEFINE_PROP_BIT("edid", _state, _conf.flags, \
>                      VIRTIO_GPU_FLAG_EDID_ENABLED, true), \
>      DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1280), \
> -    DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
> +    DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800), \
> +    DEFINE_PROP_UINT32("refresh_rate", _state, _conf.refresh_rate, 75000)
>  
>  typedef struct VGPUDMABuf {
>      QemuDmaBuf *buf;
> 
> ---
> base-commit: 985062e2319e6bf4a4be9c216ede6d34379e5777
> change-id: 20260414-virtio-gpu-refresh-rate-37b388e7dd72
> 
> Best regards,
> -- 
> slonkazoid <slonkazoid@slonk.ing>


