Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C103BC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzch7-0006rx-Nj; Thu, 27 Aug 2026 12:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzch6-0006rm-Vo
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:11:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzch4-00081k-ME
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:11:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so22822035e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787847068; x=1788451868; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PFbdPuqdB86SykNwHkfFz8BwmjNv5g6nf3B39eU1iZk=;
 b=SKo6uRopuGt2kfcXctljumhCakLV2NoP7Gbp2eOoNYa3oeMWuuff8WbcoRXs+RUqa+
 6vxZIx1LabAMrHO2STRC8aDbsvbjErLs5StnR9bL24LajNj5ZYBwpzRMv8HG4SMJZ9+m
 tteqIrkM3cdMCPHg/7JgBfB26x8B72r1MozqUW/PICwaUmws0RwJ0J5yBDK+zdtjqtpx
 cFY0SSNQtwx80gqyD+/EA0trQlzgw0d9cLdeiPPpB9h8w1JbQTan9vHvQMwDroOiG47/
 poBg6c9NMjb9JfQfeIE10u8Bv+8YbhF6fB/vR/AnNlbUOZhBuqCbCV4vSVN4o1JXvHBY
 BXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787847068; x=1788451868;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PFbdPuqdB86SykNwHkfFz8BwmjNv5g6nf3B39eU1iZk=;
 b=WdB5vtA7tWzAv8R9nuUUnDl42ea+SqWLWXXQ7KVSOCZVMNDD4n2OJ4YA6M58iD0n2j
 aH7wChXE+x+8jKIRuKau1DIlaqHbRVxDr/VIZRUGEZIIgxbINn1+oXebfcEyjxnnqbIk
 8iNfgZjOvaiKTeeuGJ1z6M5qnzRMvQguS0Aydw1jAD0IKnrSUyk9xNggyPcTVtm31hXS
 lalJqpaplJfb/lvYRsJ0JdtHfJvjegUVMfrbG9zfJ4HVOCukNGq80QuZrFLxASGZI2US
 R+I+4bF3l8KxS/QJZ0jR63uccXMiaYG68df5+D3uS/pNmjoXaQGvBxJP0B73kwFaQ3q4
 E9ng==
X-Gm-Message-State: AFuF++k2uaKwpsmw9SCDlh4l8tUguFzN7EWsWSb4QLT1C2MwY0qOnleJ
 5cJkoQhjStjvba5xI13KZMu1f9cUd3SiY2yjccgP0l2BunBuIBEYq7eMWGJWsxKzens=
X-Gm-Gg: AR+sD13eGwdACVM9+c/Ft6segrKbGmuzYOde8+nyhD+wUC8+kCZvoTe4vIiSRbPFdiK
 3FuMODStR5AUMTVjryWJkW9UaluOZ52KeVDVWgzNd4qtH0VFdny7uOceV/7B1a3kXbPXieSNaeL
 ONyrKg/BPy433Dp9lGfXvdgQxrC3C8JLe85oe9HsdcRWZfm3Ibo/3nimv4TH3D1ZwwY8Y5vUrBd
 V0UfVIKygUScIQPnpZsn83jz15lSZDc/Bt5IIy3rGF9gi0gH3+meZbMQvBkGlRvn1t/yMpxKsXN
 0RE5Ii5bdWSBjuBb3FHsBEZ+EJgH3AZQZRV3PT1u2ILEyv/6pBS+cClpd+xTFBU1LOG/XjBF6JU
 D4t6POp8bONskRAqbOYc6yvk5Jd/ChPfzmd0r5Bl/vTcm3xntITO5p7BZCAwGkYxwGW4jK+ODQy
 Y4ytnMqj548hNfokPosOJycLCS3MDWrQ8iA1P6q7haAijsEAtU2uNquFLDjhH9
X-Received: by 2002:a05:600c:1393:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-499dc7253d8mr207294475e9.11.1787847068404; 
 Thu, 27 Aug 2026 09:11:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499e7170b72sm122699705e9.0.2026.08.27.09.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 09:11:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7672F5F882;
 Thu, 27 Aug 2026 17:11:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  akihiko.odaki@gmail.com
Subject: Re: [PATCH] virtio-gpu/virgl: free BHs and timers on renderer reset
In-Reply-To: <20260827154355.3346449-1-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Thu, 27 Aug 2026 19:43:55 +0400")
References: <20260827154355.3346449-1-marcandre.lureau@redhat.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Thu, 27 Aug 2026 17:11:06 +0100
Message-ID: <877blb5ysl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> virtio_gpu_virgl_reset() does not free the bottom halves or timers
> allocated by the previous virtio_gpu_virgl_init() call. A subsequent
> virtio_gpu_virgl_init() overwrites the old pointers, leaking the
> previous allocations.
>
> Fixes: bd9258917fbf ("virtio-gpu: Destroy virgl resources on virtio-gpu r=
eset")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/virtio-gpu-virgl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 0b79aef8d1f5..8bf6417c6514 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1425,6 +1425,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>=20=20
>  static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
>  {
> +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
>      struct virtio_gpu_simple_resource *res, *tmp;
>=20=20
>      /*
> @@ -1443,6 +1444,11 @@ static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
>=20=20
>      virtio_gpu_virgl_reset_async_fences(g);
>=20=20
> +    g_clear_pointer(&gl->cmdq_resume_bh, qemu_bh_delete);
> +    g_clear_pointer(&gl->async_fence_bh, qemu_bh_delete);
> +    g_clear_pointer(&gl->print_stats, timer_free);
> +    g_clear_pointer(&gl->fence_poll, timer_free);
> +

Don't we need some ptr checks in virtio_gpu_gl_device_unrealize so a
reset followed by an unplug doesn't causes segs chasing now NULL
pointers?


>      return true;
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

