Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB01CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 10:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyShK-0007uG-Pm; Tue, 16 Sep 2025 06:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uyShD-0007sg-I4
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:14:00 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uyShA-0008Lm-0q
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:13:58 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b04b55d5a2cso913784466b.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 03:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758017634; x=1758622434; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++j6klW6GN5e3hzIMYzI5/MR8X6ZXjBvz1+RnvCIlQo=;
 b=ckSgslI6zbiHvUV8/Zi0W9SwtBy2DwQXyJfLO7iiQjBGn274TPmcPkd4cQofmFn/JN
 8DBUs+xPrwR8nappbaNUf2E9zYOC4vGtHgQcmees2j4/XauH7BDkPK8SxWZOPxTWKyZl
 PpGEyMjcw+reNAWk1qOvQcCelYZY2CRUb5sJz8ID2MLWen+CndsdMEx+cDYuBwx9tZWH
 ql7ri5eRWfMhemgKiqV46ZkyVTvsbheyluhNC5Gv9rzpYr2oRXLQDeqQp0+zn8i6BNEu
 v1V+HwtTaBjmzi6Yf9lx09eFNJ4z3l+Lx3kFQLWaX3bsu/3I+v0A6iXqZXC0q7ZxmOrF
 Abuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758017634; x=1758622434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=++j6klW6GN5e3hzIMYzI5/MR8X6ZXjBvz1+RnvCIlQo=;
 b=Y7Ouu5Ky6qnLViJgnm7F3Wl+F4RCZMVLNMFD2Sc5jVD3Sk3LswpFz0gypV+qzJFC2V
 OYMBSdHPD19e06sVri8jmjRji9y9IlQcK47d2I0Fl6Zidv7LBVX8RxztIXkUrSVWphx0
 8PT1N0nIlzPsMbFqh3uHrdCC+L91AstWtNkrW0W7KQ/ynek8kiOUeTuvLMOnbqg4edyg
 OMJzXXie6YZXG/yV+qVmeFUKwAjw6cqIZ4SEk1vuQ912N3/x+B4E1Kk3ApE4AX6faoV0
 4p+c3wJifjwJE7Eo0bhi5OLUYg3xbgDJTYSwGOXPOcowSi/xLAGezCqNFmy8A/if9CCL
 U4ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdGI1rmF4NS5uI3+Hwsbb1gNOOuL9PwBAX5eVSw/fBaHG99T/dMlgLGRufaVSMchBGuw2trUaUjG0f@nongnu.org
X-Gm-Message-State: AOJu0Yy9SHl6Dl1Mtt8BS8Ai3do7IxkrmH0G6o5LWF6t0xZbifzct3Yo
 ZW6xe3ZPmtT7CZs+IiLgE0MiVyyD6bH+vNIjQkvO8LQwip2fFDfmoGnvgNoNe9DfnyX0VaY7GXp
 20qy2H3c/Rj+AuGootXIWY0Amryl7qmzh8wTzhyecuQ==
X-Gm-Gg: ASbGncsI/WksYuRiBTxQDrhWRaAgKAvapnXvLe+nCu/OUM9vj9kS6F5TMi4xJvtMMrC
 NexRpn0sdjsv2dYlGvM8wsdldWR3N6uP9hWDsBg9tgPpWqEVQojW2oTXItc28ymO2h53m0IKbp4
 KayE9+QZu6U/wGL3N7GSJaN/F5zJqxttFLRG/SeW4hpKylCUjoaRvjRDt9Km0b8ydLK5x4fCGeq
 KXa/TQf
X-Google-Smtp-Source: AGHT+IFhvZoZvqifBFGcPYKJF2Ey0Ci1YS2m51UsA1eyzF8F4nSpJwtMBJ4AWJTgZx27/dpELJZzqp9XT3gb6LROX54=
X-Received: by 2002:a17:907:1c1d:b0:b04:568b:8a42 with SMTP id
 a640c23a62f3a-b07c35cd7c3mr1546326366b.29.1758017634030; Tue, 16 Sep 2025
 03:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
 <20250916085557.2008344-9-zhao1.liu@intel.com>
In-Reply-To: <20250916085557.2008344-9-zhao1.liu@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 16 Sep 2025 13:13:28 +0300
X-Gm-Features: AS18NWCpvlcfsfK0wVEAjukJfD_JcmmyLbtGWlDM_m_fNV-C6-3dXBU-24Q1ynI
Message-ID: <CAAjaMXaVavbhgF49iCy-kgXB3uk06d=mShK_WrVJu9Bd3HUz0g@mail.gmail.com>
Subject: Re: [PATCH 08/12] rust/qdev: Support property info for more common
 types
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62b.google.com
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

On Tue, Sep 16, 2025 at 11:34=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> Add a helper macro to implement QDevProp trait for u8/u16/u32/usize/i32
> /i64.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

You can do something like this btw:

macro_rules! impl_qdev_prop {
    ($($type:ty =3D> $info:ident),*$(,)?) =3D> {
        $(unsafe impl $crate::qdev::QDevProp for $type {
            const BASE_INFO: *const $crate::bindings::PropertyInfo =3D
                addr_of!($crate::bindings::$info);
        })*
    };
 }

impl_qdev_prop!(
    bool =3D> qdev_prop_bool,
    u8 =3D> qdev_prop_uint8,
    ...
);


>  rust/hw/core/src/qdev.rs | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
> index d887046d8de1..b57dc05ebb0e 100644
> --- a/rust/hw/core/src/qdev.rs
> +++ b/rust/hw/core/src/qdev.rs
> @@ -134,20 +134,24 @@ pub unsafe trait QDevProp {
>      const BASE_INFO: *const bindings::PropertyInfo;
>  }
>
> -/// Use [`bindings::qdev_prop_bool`] for `bool`.
> -unsafe impl QDevProp for bool {
> -    const BASE_INFO: *const bindings::PropertyInfo =3D addr_of!(bindings=
::qdev_prop_bool);
> -}
> -
> -/// Use [`bindings::qdev_prop_uint64`] for `u64`.
> -unsafe impl QDevProp for u64 {
> -    const BASE_INFO: *const bindings::PropertyInfo =3D addr_of!(bindings=
::qdev_prop_uint64);
> +macro_rules! impl_qdev_prop {
> +    ($type:ty,$info:ident) =3D> {
> +        unsafe impl $crate::qdev::QDevProp for $type {
> +            const BASE_INFO: *const $crate::bindings::PropertyInfo =3D
> +                addr_of!($crate::bindings::$info);
> +        }
> +    };
>  }
>
> -/// Use [`bindings::qdev_prop_chr`] for [`chardev::CharBackend`].
> -unsafe impl QDevProp for chardev::CharBackend {
> -    const BASE_INFO: *const bindings::PropertyInfo =3D addr_of!(bindings=
::qdev_prop_chr);
> -}
> +impl_qdev_prop!(bool, qdev_prop_bool);
> +impl_qdev_prop!(u8, qdev_prop_uint8);
> +impl_qdev_prop!(u16, qdev_prop_uint16);
> +impl_qdev_prop!(u32, qdev_prop_uint32);
> +impl_qdev_prop!(u64, qdev_prop_uint64);
> +impl_qdev_prop!(usize, qdev_prop_usize);
> +impl_qdev_prop!(i32, qdev_prop_int32);
> +impl_qdev_prop!(i64, qdev_prop_int64);
> +impl_qdev_prop!(chardev::CharBackend, qdev_prop_chr);
>
>  /// Trait to define device properties.
>  ///
> --
> 2.34.1
>

