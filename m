Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407A4CFD370
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 12:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNrrZ-00047i-6w; Tue, 25 Nov 2025 07:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNrrS-00046g-OT
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:09:36 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNrrR-0004jI-4c
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:09:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42b566859ecso4780334f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 04:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764072571; x=1764677371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGAgNGlJ8Ge/1SRrCHPyCClzKqmksP9EpIiLpzeywVw=;
 b=KN319mVaQeGXq2zTXnKccautl82xIFfJEKuqKVGAkPjAciqbp7FeaHaouunzKPcDsd
 W9LltLvZRPQIiH/ns2X4M8mo2UFX5HHLVFef++MO07vJzfK7oDW+GEY32Pd4jHJh1lLj
 cg5rgZxtUub8WWrYjV5TpOj5hj6I61DV+VPsgiIzw3t6zk2FVok2hhY8vXFhqBZ+W6QA
 FA0KtGG/q+y/r/2Z1B/ApcVhUBW8MokD1gUwggTZ2unEGOFlFPFj8SWPj5CvaLzMPHzA
 03qbjrAuwPIdxP4bmzXQo7Aoz6GeqcDCv7kSHJTcB/f7pOETd++XsqwiRB0mBhDr0MKQ
 AoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764072571; x=1764677371;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xGAgNGlJ8Ge/1SRrCHPyCClzKqmksP9EpIiLpzeywVw=;
 b=sA/8d5SoBi6ZzCttCKNLDlVhqC1oTWe97nnU8rTTwUQ0JPNX3eM4Bw07l+IIB46cbx
 HvfqQy3v6bWYi6thzmU+eTr7nSe9H/m0XyGCsPqTa13o0R0gZeIwwMKV97XGU7QpDPas
 q1yY4/qD63qTX/VsPoiYzIYEgoAH4mcj8bdLeArJvWip0dROl1R2Wfz3ZFY++rEMi3gN
 07L/2t/lOL4pSJiFZrD9gmAvrh+0IRjDN8VauepmbFaVMacsMDA98oD2/qy/fCSjh6ts
 mjRdVrLorz4/RTnnnIfoaCUWnMUoQ2Ov9+Zhfo9nCJGOuZSUl+YSxNuQScAgIbfGFHp0
 7g0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr1rqvpAwPNTKsq9oLmzIgRXVRMLKe5/RxOMDF87mt5EX9r05/PlynLlsD6IiGCI5lvCc4zAYbz56R@nongnu.org
X-Gm-Message-State: AOJu0Yx0jZBVwPTcmGqcuu8R6ZSlOSLbPKMBTYNw1j5Flpa3T8GoFpUo
 3F/Ls07dGuEmlfyy82KribZTjSncIrYOeYlhTww9WG08Ys8niqbDbH/qqaqMv9fcPlc=
X-Gm-Gg: ASbGncv6BGnaU9krwEjlFIDVee9sqrPpna2n7fjcj8Frk1yYu2rpPPd6b0LQ2ak99ce
 mfxin/eZLffTDHb0Y1ZsM01IJ98bs/XbD4CHOoz4X7CGKXNYXSL8yIY5STMLNG4VFS9MiAatO2Y
 aA7uk8kf2Q+RAfDqx5uK/VpTE82mc8L7BXLiJlYKE7eP7Pxabfup9GZHxkphSeFSFZjdD7OjrbJ
 EwCFLrp/xutsQ913qRE1zSL6jMgPuhjAbcRNkCN+6afKgiRFhgFa7spk1nj0eKmGBuqS+3ITkNI
 16SLfxv6DHB0bSG9BzGBtd3iPsgqhK8bystE5byUwBJMiODBQ7rXaH6E7PZ07GF3NDtMBECqGVL
 hU9aa75MpUPElOgm162+EXktneaI2qOAWQgC4GDCfk2mycwfqBpOVN6L8OL6c9cPu8+SA2p/oKB
 BELwcV2V4DH/8=
X-Google-Smtp-Source: AGHT+IGTC95AGN1eZHVjoHqfqsKfiwraW3JiHzKIYGZC1o0jUI/fm283aw378ckEKHnSJk/290c5yg==
X-Received: by 2002:a05:600c:458c:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-47904b36881mr25097315e9.35.1764072570829; 
 Tue, 25 Nov 2025 04:09:30 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363e4sm34475992f8f.12.2025.11.25.04.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 04:09:30 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 75A1A5F7EF;
 Tue, 25 Nov 2025 12:09:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Yiwei Zhang
 <zzyiwei@gmail.com>,  Sergio Lopez Pascual <slp@redhat.com>,  Gert Wollny
 <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  Alyssa Ross <hi@alyssa.is>,  Roger Pau
 =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,  Alex Deucher
 <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6nig?=
 <christian.koenig@amd.com>,  Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,  Julia Zhang
 <julia.zhang@amd.com>,  Chen Jiqian <Jiqian.Chen@amd.com>,  Rob Clark
 <robdclark@gmail.com>,  Robert Beckett <bob.beckett@collabora.com>
Subject: Re: [RFC PATCH v4 4/7] virtio-gpu: Make
 virtio_gpu_virgl_unmap_resource_blob() return -1 on error
In-Reply-To: <20251125023517.177714-5-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Tue, 25 Nov 2025 05:35:14 +0300")
References: <20251125023517.177714-1-dmitry.osipenko@collabora.com>
 <20251125023517.177714-5-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 25 Nov 2025 12:09:29 +0000
Message-ID: <87qztm71qe.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> Make virtio_gpu_virgl_unmap_resource_blob() return -1 for more consistency
> of error propagation style in the code, adhering to QEMU's devel/style
> recommendations and preparing code for further code changes utilizing this
> function.

I'm not so sure of that. If the function is a pass/fail then we tend to
prefer using bools in newer code. If you need richer internal error
reporting then start using your errno defines. If this is user visible
(i.e. during configuration) then we can make more of Error* and friends.

>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-virgl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index edcdad0af232..a7b14a312c83 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -199,7 +199,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "%s: failed to unmap virgl resource: %s\n",
>                            __func__, strerror(-ret));
> -            return ret;
> +            return -1;
>          }
>      } else {
>          *cmd_suspended =3D true;
> @@ -333,7 +333,7 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>      }
>=20=20
>  #if VIRGL_VERSION_MAJOR >=3D 1
> -    if (virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended)) {
> +    if (virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended) < 0)=
 {
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          return;
>      }
> @@ -829,7 +829,7 @@ static void virgl_cmd_resource_unmap_blob(VirtIOGPU *=
g,
>      }
>=20=20
>      ret =3D virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended);
> -    if (ret) {
> +    if (ret < 0) {
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          return;
>      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

