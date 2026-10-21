Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD1606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Doy1Y18u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJeG6-0001WI-5Q; Wed, 21 Oct 2026 17:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJeG4-0001W5-H5
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:54:04 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJeG2-0005FF-Vn
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:54:04 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so1671397a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 14:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792619641; cv=none;
 d=google.com; s=arc-20260327;
 b=AeDtyMRiLEYRRJrEUce8uzmgaksT48iyUoWboUp1hjRTVT+PnmJzG0XkkWQur7JSrc
 9IS0QCEBNeTCHkgdPPWanrqoCY3pZoojvVbt6wc5XU2JAGTDdowaGFlHi4KW6WdVfZN6
 5ryuRXEntWxXfoBxBPLSyDCxdu90ivAbEZ0aGK/7HjC4+5PLW61bIJOYzpH7QLwHNh+K
 wmSDC1fYUxau5fHmSgxi7fWqRfIl7uNX8yMnrggbNNauGEQevwdCC5CBibdnaJw0H8QH
 rnWPed2R5uFyCj6pEOpJBs3Zlzllv+1sPL/z5UWPILwutS3wwGnsghIXS15thY7i5vdv
 +aPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=S7WVwO3jubFdoj2mP9+bFTOvZiQjkBtYyocFt8ZuarA=;
 fh=8H62a63nbPyENZDqgrXug6R7l7UVEnrjvEENi5W5aPc=;
 b=jG8GNdHv3ZJW1zQr4lXP0avKyuRx3dLLMAzTjoCKVZdjRFLhzhWHC0HEASPtomuN5A
 tI69KWTRx88WcfFPm4qoXZ8hmgo8EL/9dvbk9OLSAF1HZBXFKjdo2jV8NKBoXAThzSuF
 m+6xbdXVAxSi7EAaFOA/LwRWuhxoukZmk+ua28bfJUXQShMl9fexGAUMDsP8wPhFUjSf
 uuwrJYz+whlbXMtlgkNRClrKQ11Y2YoffictnXJJQxbaZKyTw1ApmhyJzKK4MVpmUt9F
 QoGLQGqAIM1DevCZ1T9izKd7/PwaKFYqfZxi7e8vWmYWAH6LGUw9qodXBfYTiGwC/oA3
 +ywA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792619641; x=1793224441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S7WVwO3jubFdoj2mP9+bFTOvZiQjkBtYyocFt8ZuarA=;
 b=Doy1Y18urr+410YEVtfYFq+NoRLvOW/LE8rIUoP556rEUSrqTVz8QqKAzu2d3FbXsy
 ndW8CUWH2OWKcUgeean9LTquiV4GQ3q01z1kX8l3j8jPw9gjzkdyrQNEbYmiSVAbfIQW
 FakwTZyUya6kAxbF+gTIUULHRU56ihar3N6vGm5PAZX4zhYo+8K2NUAqJE3KTPvpUo+C
 z0xWYZFMrKC7vlHl8mD7UO4pMskHmLkqomDA7cjq3V58a+58wNzpf//zk8mjgqX7abxq
 6gZqP4qdkjM/258VCS61HPIFC+mbpDbXfQzF1Pwl8970WsFXZDQYCrKoyaMYrvu3tGXB
 lkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792619641; x=1793224441;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S7WVwO3jubFdoj2mP9+bFTOvZiQjkBtYyocFt8ZuarA=;
 b=dT6teZhbFRS+Qp+IAhAP2O0L9AH3VX5fV1SFhx02yKcIjmtdK4wjWjYkVt8P8CsnTw
 5zPpZU9pTqS4LDboypvfxsCoJX+pqNoGPZhBOZ30bdDVn44lbhUC9iWeXFANhJXghXqR
 9qsVGGRSmRjb8ZyPTaDMp2DvBgXHEeaGBWFir2xmB+cc/rFNhRNaMsvb/qkMTMK3yZAT
 Lni6ykKg9pBKUKLmyNE8sFLH7NVTF6/Ig6GOB07gsJZxk9TmwtXWQpF5x9EVHUAhf4Di
 fophMEP8PTnR9jOBnXC94bi33dbRZDzCR7E5P6o2jqUJYDWM/XDYV7B9JSB4A8vWMyw1
 JPWg==
X-Gm-Message-State: AFq9FYJhFxTV4+sizaUYPbPVpvgf2q4y0ULPR7EQYrRAXjaKt4PpTyPj
 saW60KMnG1P4D802NBG+hN7Zs6+StWUFli19txvdzKze2euLLrU6fx+fGpjv1EWrYJGj+9hMdaV
 cXlK84yV+S53j2dHzaY1T9cg2FxnI5m4=
X-Gm-Gg: AYBFou0MD4hBIxpohdSVnTcrDqvK+lXLaWBkqCfHmyye14sXz5hI90MBGsA00x4d6Ia
 JTarJVk49zXPnGCm5oM1HztgkZ2lDjAlYyO4Wji4Svap8sr3JSrd5tanmfxBuI5/XlBIjvCV5Ds
 Hj6C307C3N/hn0op3grSzYg1xyk1WRAjFaUpB0Xhjza0b4oaGRN21UOiV+JR/fQHJ4Nuc/EM1ig
 AIJ7uNaYvT5nzwaCtlywqKbcPPLKcYDb0vfH+rgknwpE/hpgw7twdH3123H4Js+igIMBbwGQSfA
 +cSa9TWgf9ya1A6HMK+sTUZmdalG/AB0vZDSqby9OVHpGPeuhOoJDnuaMr4Pn446U7BG6sG5O+M
 D5sPirfgJt4FMgu5rZ45/OM8q5+BDNlRDciRn
X-Received: by 2002:a05:6402:3205:b0:6ac:773b:9c55 with SMTP id
 4fb4d7f45d1cf-6b408ee2e86mr2621109a12.40.1792619641114; Wed, 21 Oct 2026
 14:54:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
 <20261021181244.867840-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261021181244.867840-2-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 22 Oct 2026 05:53:48 +0800
X-Gm-Features: AclHuK_vdp6nkDAqkDWDPwSZ_S5gi3sB-XEVdxNRVswyvDOjmwdzBpH-AaM0QN8
Message-ID: <CAE2XoE_78JWfKfs+5ek=6E50gjGpeRsoVe1meu=gi7FunKcjAw@mail.gmail.com>
Subject: Re: [PATCH v5 01/21] target-info: add target_heterogeneous
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 2:14=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> For now, this function strictly returns false. We'll turn it to true
> once heterogeneous emulation in supported. Meanwhile, we can use this to
> add various checks and asserts over the codebase as reminders about what
> we'll need to modify.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  include/qemu/target-info.h | 8 ++++++++
>  target-info.c              | 6 ++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 862097c6c63..923c00c917c 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -42,6 +42,14 @@ const char *target_cpu_type(void);
>   */
>  bool target_big_endian(void);
>
> +/**
> + * target_heterogeneous:
> + *
> + * Returns true if current binary has support for running several target
> + * architectures at once (heterogeneous emulation).
> + */
> +bool target_heterogeneous(void);
> +
>  /**
>   * target_base_arm:
>   *
> diff --git a/target-info.c b/target-info.c
> index 254530d8ea5..b8a4a7ebf7a 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -42,6 +42,12 @@ bool target_big_endian(void)
>      return target_endian_mode() =3D=3D ENDIAN_MODE_BIG;
>  }
>
> +bool target_heterogeneous(void)
> +{
> +    /* For now, we only run a single target at a time */
> +    return false;
> +}

How about place this in stubs/target_heterogeneous.c
So when do multi-target tests, we can override it with

bool target_heterogeneous(void)
{
    /* For now, we only run a single target at a time */
    return true;
}

>  bool target_base_arm(void)
>  {
>      switch (target_arch()) {
> --
> 2.47.3
>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

