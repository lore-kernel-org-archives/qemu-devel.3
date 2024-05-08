Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9B6C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ei9-0002X5-1D; Wed, 08 May 2024 06:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4ei5-0002WB-R3
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:39:41 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4ei2-0006xW-Nr
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:39:41 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59c0a6415fso965187966b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 03:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715164777; x=1715769577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tZSb4kex2VFiwM4IXr6Tp6GwJBex9wUMrGNtxG3oTbE=;
 b=XT8HZGwxqPCYVv0q+0vnfGx8oPikcB6Bm0o2grBRlHNLhU/sQtT5+iBp6+bIbYf5Pw
 cWy/G3hbLfx530zT6/mioAJT9Lt4kYTx5t2JLVc8/ZT5Ir2PWWn847rSj16+y3d9Zo3u
 vM5bdwZ/kGLyDwLeaQKWKAGeRqd7hknDngjnERLGIdhlURfJTpqo5Zfw2JgIC8ifQoF4
 vm7+TW/SRGuoFKyK1enFXLzD5sNnSnQPXK+Nc700VpRvsLpxCZcQPt/bN03xyqXA9cY/
 y3KIay1YNS5hslPMWokW/++fwxRTGtcq4vjTO8CDtgtCaYQ4GCuTa01EbLkfm2ho/Np7
 StxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715164777; x=1715769577;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZSb4kex2VFiwM4IXr6Tp6GwJBex9wUMrGNtxG3oTbE=;
 b=r7SgMmRRKcKzjg79lyAS6rR9kljkAxwUQTAQE4sQaRjXy/gCXA1xX6HN/qZRha/2e0
 FpBUgLL9995+sEjoKYpic3v+HJKqpyDMdr9TQXAtgxVnWjqgaGhZuPigcW9H6IIUysJJ
 ExDSTthLyj6eyLrrr9PsQCrutDhhFNNX2KGlXEh/ENBcGH7bPQgQUjIcJOe6igRRtnrn
 dEAORjg/Njl9eYxEJF7SktEc6Ths/X+gtE8C7/f9eDo0KePKoN1IRQatq8qaaLPEj/PP
 C3eo7vCVopUrzu6pen1cye+SXOYnFx7Yqx4e2b6dJRnLUS5CziQKy8Hck56ILSjswdTg
 H3Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ+3Xiu/g/RtpiSyBbE3/X5c5QfRC3U6ahFkJFjG5ZMJ5vjiePuNxkZfht9t8csvAEy3PyCiXycbN9e1RaIrpVKaUukPc=
X-Gm-Message-State: AOJu0YyxnvT4kfSf4jwJF7bl6dVgHc4oujcSTc5YYAePZgbEZpyEXqHY
 8ceYXpsKDPeUKnj6zVP4QRk2ejwR7s+vE7vM1N7p54t7YpD+MlxH/Uy6nQaiwAQ=
X-Google-Smtp-Source: AGHT+IHp9WIi5eGHu9irLbTg1W7qM8C/6iPuPRu3j88iGmQkkQR/JVB/MInmFI1mfJrjHmrqtjr3PA==
X-Received: by 2002:a17:906:6d7:b0:a58:832d:c3e8 with SMTP id
 a640c23a62f3a-a59fb9c88b2mr144609766b.58.1715164777064; 
 Wed, 08 May 2024 03:39:37 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 bo15-20020a170906d04f00b00a59b87dd0bbsm4650814ejb.161.2024.05.08.03.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 03:39:36 -0700 (PDT)
Message-ID: <bde68851-04a0-424f-9412-69d11b9a9caf@linaro.org>
Date: Wed, 8 May 2024 12:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] libvhost-user: mask F_INFLIGHT_SHMFD if memfd is
 not supported
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-4-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508074457.12367-4-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 8/5/24 09:44, Stefano Garzarella wrote:
> libvhost-user will panic when receiving VHOST_USER_GET_INFLIGHT_FD
> message if MFD_ALLOW_SEALING is not defined, since it's not able
> to create a memfd.
> 
> VHOST_USER_GET_INFLIGHT_FD is used only if
> VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is negotiated. So, let's mask
> that feature if the backend is not able to properly handle these
> messages.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   subprojects/libvhost-user/libvhost-user.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index a11afd1960..1c361ffd51 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -1674,6 +1674,16 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>           features |= dev->iface->get_protocol_features(dev);
>       }
>   

Maybe move the #ifndef here?

> +    /*
> +     * If MFD_ALLOW_SEALING is not defined, we are not able to handle
> +     * VHOST_USER_GET_INFLIGHT_FD messages, since we can't create a memfd.
> +     * Those messages are used only if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD
> +     * is negotiated. A device implementation can enable it, so let's mask
> +     * it to avoid a runtime panic.
> +     */
> +#ifndef MFD_ALLOW_SEALING
> +    features &= ~(1ULL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD);
> +#endif
>       vmsg_set_reply_u64(vmsg, features);
>       return true;
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


