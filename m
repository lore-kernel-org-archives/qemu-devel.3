Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AAFC44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wke80-0008ED-Cv; Fri, 17 Jul 2026 04:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wke7y-0008Dq-QW
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:41:02 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wke7x-0003CB-F1
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:41:02 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so7581212a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784277660; cv=none;
 d=google.com; s=arc-20260327;
 b=VfhfbyPsaJkUOfZivvHp/kYP+GoBMWpmLfWAyoGA5klN9L0HZB64PSkWiALCmO8KAn
 5G9dtoXqmBAfpn6E0o9cUl0QZBkkJSZMzVfmS3ZjZnz+ezvCoCTtMILe0QHAjXDKFK8j
 G1cl3rdi+1y9aBeTkEB/enyMP6p2EIul5K/ieDJepeOXlaFcJvPWihJvIPFQE8+zWcax
 j/4MFiSZLeGeedbPmst8TKnO0qKz5rAWxddbk73TIf3ytcCzODzhdM311r+abJf+FJyW
 JBx4zSM5lqGRKBm4V6/OOTWpLZSggiuqSP9/lb+CmN2T116I+zmofAy2nVEvh83RMugP
 W0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PPHYjY6sL/vBYr/9fmb/6V+00XD9M5ZuJ4NUWt5w8DE=;
 fh=KnxVq+/dNMGR5XtbHr3cm7WMCtMcRbEU6z8PkW8LG2I=;
 b=RCf55x83Dyr640phEsFVyQOWCX7eyYGEcGwpRWUenXTbAsM0DcgNmsEteY/IkEweFA
 ggkjjrrC4NbYMhGDomhrtXNpBel2vNaeR3QLvrNd/YtReYuglKzdmuJJlLZ9r1e/PMnZ
 j1IRg0wBd9pEmLuxxPzdErVxZE30p6F00Km1HJOCWuAsuEiib5O+AzKIARd4PdT/pl0j
 v+9F0AUTpcwDmKI5TVqYdLXHYz8bayGgLSgTJpI6/5kCeSioUXvM9iowEP0bafg6p9k4
 cPDa7XS7oAe1acbsEBaPYPNX2H4xfitlQaDBvz0ef4QpbaVZFeV6+eYt85Y70uYk4s/U
 jo7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784277660; x=1784882460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PPHYjY6sL/vBYr/9fmb/6V+00XD9M5ZuJ4NUWt5w8DE=;
 b=NX2nv2tI+IFVMKHSOD206KbapLqQvpwCUPedduF2Hs7Iz67Y41wB58wCsY3BS2c9Js
 xF9Yy2sK2wSY6rA0e7QqTpdCdJl8TozYlH9V1cO2POQzVWp2TKUY9kUtJc2a2dChTka0
 2OWTxRBv/nX6LSmD0tu8r1GZwZkuiJTcBXsplHadaTWsbRYA0yfTTumCqx3FLZ1Onyxu
 1J0M4jRuMT+Mhff0NDlSlLfQCDClZIuJuTNUsF3L3M7KyDO8MS4kwGkixDscbB+p/x2q
 Y/5A3NxhD0lPiXM0eKdMLkvIAGqDJUzWdPjU9mWORotNQ6gfIiVRnE2yshUETY1U3g2U
 hsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784277660; x=1784882460;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PPHYjY6sL/vBYr/9fmb/6V+00XD9M5ZuJ4NUWt5w8DE=;
 b=Y0FyjFve3XxX5udMOJ6I3Y2yrF8S1M7phfw5LTSN0W84Nu0qgmAFxVoTnr7vNvhzD6
 /hC8onp+Tfwu2Ihlv8z3XIgI8dkLYCkd7Wuvsj944N60UBtp88BAJqtEDVy5xcmwBmdp
 D8YfJi8WHNwLcd46uqR+d26IxcGXdXbXwxLMbjttYmkq8Ew/SHXftJRHkW8kp+f8VXvi
 p1emjLS4iTNzO8Qfi2rthCXhO0ijAKIxeqgexxp9NfSkrTWwbWPWMJzdKeGQTzEwrhck
 f2LYaDuGv6AON3VS7ldp3liyhhDZvf5Y2I5PTy41V2tNYXhpSyhNWm6sbPYyqsFROrRa
 YkaQ==
X-Gm-Message-State: AOJu0YwIrtfM5vuNYmUBSdg9NePC3nsCNT4LCLCvQmUtkMRSyHaGvnU5
 GAW2teo9nK+2+8bT2WjkVZNBTsBlMeiUqEl+zJywGg3YrNS8oNDSu7h8xngvQ3ys+0YrlEEI4zM
 /8zvMQlTqhGdP+DZ3iWszgszIGfwCLJP5A7wz
X-Gm-Gg: AfdE7cl24lGsUu1SnExp73Wkhe2iA+6PJ/iHYQvnAdE/nj7fbvCSUjVUSj2gv2uCrg0
 UyN4sGDcreQgfP7iDKwqkr5fnm9b68/hl/CjfbZeSTaJo1Rheb/eurxYDQDa3JZ2EnW0jXUKvqk
 Tl88KK/JkvXgIybghU0dOABlIeVbfZ0yIzUmcroRmMYo5nOYrHZ1iN/T+ZVGVGirKB/DVHM5lrL
 m2dhsluwUI4+7fmITr2z6p5HXBAoVXijaYQWFD26LD4MzahYF9eX8UPkuKDTcJ1bxSbtsGET+yf
 ZER2a6ES4COxXiw1kQ==
X-Received: by 2002:a17:90b:1c86:b0:37c:6130:7a5b with SMTP id
 98e67ed59e1d1-38e4b41ff25mr1591177a91.8.1784277659790; Fri, 17 Jul 2026
 01:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260717-pixman-v1-1-89ea33b50b75@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260717-pixman-v1-1-89ea33b50b75@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 17 Jul 2026 12:40:47 +0400
X-Gm-Features: AUfX_mwL3QHeG3ns_VYqJdzWn39sN994NYA6fgMaKdQnj8CGd3YWtkoDbdw5xPw
Message-ID: <CAJ+F1CLEY9ThGC0nrNe9LAOqe-vybWZN1uV8Qm2ic3XLE6HBOw@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: Check pixman_image_create_bits()
 results
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Jul 17, 2026 at 11:07=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> pixman_image_create_bits() returns NULL for allocation failures and
> unaligned strides, which may be supplied by the guest with
> VIRTIO_GPU_CMD_SET_SCANOUT_BLOB, and virtio_gpu_do_set_scanout()
> subsequently dereferences it.
>
> Fixes: fa06e5cb7b10 ("virtio-gpu: fix scanout rectangles")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 88526051a992..edbb02ee0516 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -674,6 +674,10 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>          void *ptr =3D data + fb->offset;
>          rect =3D pixman_image_create_bits(fb->format, r->width, r->heigh=
t,
>                                          ptr, fb->stride);
> +        if (!rect) {
> +            *error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> +            return false;
> +        }
>
>          if (res->image) {
>              pixman_image_ref(res->image);
>
> ---
> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
> change-id: 20260716-pixman-58020972475d
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>


--=20
Marc-Andr=C3=A9 Lureau

