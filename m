Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB0606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A5ZJVcXw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxC4-0006mi-PT; Fri, 27 Nov 2026 09:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWxC3-0006iH-3O
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:44:55 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWxC1-0002Va-9G
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:44:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so53283865e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795790691; x=1796395491; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xSX8pKUyvTOCcIzht26OjB0n8eHCImgAm6MnuFUvMGI=;
 b=A5ZJVcXwoMeSvL7khHWg5HhJ/9W/1AqFVAi6rsPLvlgBWL3Ws3qo4z3BDKkZq4dFM5
 yPi5sZ+REQ8zJ48F4KnUFIrTxZxO2euphQckx1gIkTOMgYmS6c+mYk8VJLvGtYDyW0a0
 +rEtK9RK0GSmMNDbxYMtkcH9tlNp0g1fDTr4wAnlSRAoF+LimUW4R5QFVRhz+vK43ViG
 nwvlXLwkk1G11BL1krDfaowa0J2BMrrDMb/LUt3C0R9ku9boFDGh/fyUHq9aruBT2Gcy
 m/r1hFz3U7y9dAOtnuM4fdIQF/nQZmWA+IT6XZRVRUlCsC3knm0G+fLrjIkWK8lF1cbK
 +HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795790691; x=1796395491;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xSX8pKUyvTOCcIzht26OjB0n8eHCImgAm6MnuFUvMGI=;
 b=qQP83Iw4GliFJ9y002PNggf6rQxI7EXS4S9JJKhLPG9N1or95FCIX/WmSdJMGwBQcz
 rjEQIjasZvaDiCUzIacXicdhDJo/AeT0bv1VD9R9jwNK00RYRYyhgwGh+MAH6qAL02ED
 QIZQjbQKIkLO/0pxXM/8gQ8T51EwYWTpy3bS+BvSEqdmWg2DaWTAgFFoxCsrlfTGhMgr
 yUB94K+9bDrVD5qqlaZhQij7rqi78B3dOiHiRSY87I3a38odwO3in4Ai+wgUCVY0q6Xv
 86dXE0Ko5yDidiHCQSSNRANJy61zMLDagKGWo7nZwRV6lakhk8znA7T3S9KGRdOcO99H
 eiLg==
X-Forwarded-Encrypted: i=1;
 AL+hErEqbjIfF4NurX3aZwm8OlSFix3rFlPSbW4set4R4bLCuwDseWW/5UnMxP+FuskdcArMZh3MmMfNZ4fh@nongnu.org
X-Gm-Message-State: APuU4Z+Ji2niRYZp1L2KY7nufFGMYDONgtfFvSnD3goVtqytEw/xWaG6
 F+8aEqQ9vyKxK1ldDsJvKxv0tmIX77OVXc1tov/AMtlcGDz/1GkRDH8kiQNWv2BUU0nGeTeBhb8
 4tuQ3
X-Gm-Gg: AZFdTZeCkAT/g286DDNY1iXjSKxaqlddCbBeYK7uVkOo1GjJNll9kA7gEd6JwRwWE+9
 T81biSvdMRYpDRZoi24AAJnKoPYhv7YJq7VEqx8WoRWMCeWlkuPfIRLNWSYYO2LXtxdzCqlzjFq
 fuYa2K12VkMAVf5vYV4X+tSDHB64cEM44I+BjD4qdNPjqNlb9wf9+0suhOnhHk7TRsH+xUhHV9G
 +veausLeIACtoJIr1+h2cLCkqHxNLopMf7l4glrV3s7255X0KZfCbyFpOj+9z//Y1mh0w/iNPUd
 hK9T5E7yGer5qYSzT8p7Bu1MxXE97G9EP0Mn5zayb1OiHrnPpkR6/MftXg+6xEsHaFBJxolZZA/
 Pa9TZBlrMHegoZZVKod1PIK+DIpsiDpe1GvvjLKY7DDBuqqpE83GNFt5iTEgpoMu/DfxbmvLzxt
 /6ebUeGHEuSFPpd99MXCeWzp2uRyzc+BYO2X+U1Df5cR68IZuNh8rfknZjT25Mxxla3738uYPvV
 9QZw7AryNDJIQw1So8mF5ADbiAV7+8MFQ3Qpg3ucnMtYDdEZ6aRZas7TSdDKsWYv1sfCdgXgSHw
 xXOfld9RLltZkk3nuWGjBgyv0J4k
X-Received: by 2002:a05:600c:5395:b0:4b1:4017:c4f4 with SMTP id
 5b1f17b1804b1-4bb8880ca2fmr491881675e9.20.1795790691265; 
 Fri, 27 Nov 2026 06:44:51 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb42absm48316744f8f.1.2026.11.27.06.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:44:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 14B135F8CD;
 Fri, 27 Nov 2026 14:44:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Honglei Huang <honghuan@amd.com>
Cc: <dmitry.osipenko@collabora.com>,  <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 <Ray.Huang@amd.com>,  <mst@redhat.com>,  <cohuck@redhat.com>,
 <pbonzini@redhat.com>,  <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH v7 1/5] virtio-gpu: Update Linux headers to add ROCm
 capability set
In-Reply-To: <20261106082711.813336-2-honghuan@amd.com> (Honglei Huang's
 message of "Fri, 6 Nov 2026 16:27:07 +0800")
References: <20261106082711.813336-1-honghuan@amd.com>
 <20261106082711.813336-2-honghuan@amd.com>
User-Agent: mu4e 1.14.5-pre2; emacs 30.1
Date: Fri, 27 Nov 2026 14:44:49 +0000
Message-ID: <87fqwmtjtq.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Honglei Huang <honghuan@amd.com> writes:

> Add VIRTIO_GPU_CAPSET_ROCM to the imported virtio_gpu.h so the device
> can advertise the ROCm capability set to the guest.
>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  include/standard-headers/linux/virtio_gpu.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standa=
rd-headers/linux/virtio_gpu.h
> index c67f50f56cd..976bd225875 100644
> --- a/include/standard-headers/linux/virtio_gpu.h
> +++ b/include/standard-headers/linux/virtio_gpu.h
> @@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
>  #define VIRTIO_GPU_CAPSET_VENUS 4
>  #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
>  #define VIRTIO_GPU_CAPSET_DRM 6
> +#define VIRTIO_GPU_CAPSET_ROCM 10

Generally while patches are in flight you would include a reference to
the kernel patches so we can track when they get merged into the kernel:

  linux-headers: Update to v7.3-rc1-amd-baz (!UPSTREAM)

  You can find the current proposed  kernel series at http://foo.bar/repo/b=
ranch.

  sob

And ideally use the update-headers script to import them to make sure
they are properly sanitised.

>=20=20
>  /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>  struct virtio_gpu_get_capset_info {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

