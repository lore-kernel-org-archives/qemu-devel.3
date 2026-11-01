Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804C606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=K3heLzKX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNQxu-0000Sd-OL; Sun, 01 Nov 2026 03:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xNQxr-0000SA-8j
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 03:30:56 -0500
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xNQxp-0000wl-Ja
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 03:30:54 -0500
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-36a315ed211so2481842eec.0
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 01:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793521851; cv=none;
 d=google.com; s=arc-20260327;
 b=bq5mcdEURfXC+Myx63hYxsOWPRJ6hGIsLSUuSydHnW7L0t0Pb92uDhjkf87IrY/r78
 nMIxGGIW/3pD/ZHl/5gIY8x66aWQikJCnogxUTUy45MAAIJpltRCIuHqTgipTSqcDryK
 h134DqfB3S+/OPnMBoy7jl7MsoifRwq72T8UjrXrvXluPaWPK0Sv9w/ooKaU1cW8dEPw
 GcalPbkKCnPJhl91YCjfjgrYTzrhHHk4D/F2EwX2AzA5ys+lUgV8NOAJsuERfvrF7avL
 FO5k+OZm93KGUbKRF/i96N/xNAabMEqlb3DYWUdNlne7LcS1wPX5S4Qu+PQe8DLSJHhO
 Vm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GzXRn7YCFKIPc+rapsRL629I71VbpYSqluWKUJ0GIpM=;
 fh=VHm4GSR0eoGqeLtGAb/Vbwr27V+Q+3pjmzq6sAMKmDA=;
 b=EGRl/opLE81+8bXncVrOOJot4GNjSv6c4OsMCKnbNb0PSYWd9ak+xCRUmYiHMK2sEE
 ZbZkbcQuB09z4yKALqOpjgOt+x/SKntAfkDeTUX2JE9kxOwAK1IjzRlQbrTrOPXHu3yr
 IlaBbaJJ6R+6qQGNupjkR0UuVkHMPzf2FXxqRMIKcMdVM1XEoXMGd9pLS6UCUDb9of4X
 yhWvjcUPHGHm12IbE2AnpyRKztEmd6kC0QoaTU5MfUexEBBbPmsQCWRA38WZTrpAby3b
 rtEFBKsnVjcpPwReIgOnhKPAlRf/TsDEX7i938BFLN/1lgEcYnp3ak4AfCIwz+XwPuiv
 WFRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793521851; x=1794126651; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GzXRn7YCFKIPc+rapsRL629I71VbpYSqluWKUJ0GIpM=;
 b=K3heLzKXXaitug/DhCBBt88ceA3Hdbq4bxeAwG7w2pva4PHEmg/I8EDbiaU0AsjfZU
 mh/7MaBBCkdpEQsy9PKn5NfleK8mIxKF8uUYjqArSkMSmE/Hey3NxNxcll1Uzv0VdT0T
 dZCX6Pe0rVLDHZnT+EGZ7Qfs24YteOI4or94lU6Ml6MZ9NorvegYHkxM1bvmeu8Yn+jM
 YkyB63FMxSE9S1J0CFpDcPRZUnbVnQk1NfnzhdijSFHbY4PCPsfKtrx7+9fpBUq4YQck
 kW5unPZFNygC12EXTMG7TVUn8V40RaD7JEMStxTCQmJOewADDBhY0ewB791KFQrofTmc
 4PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793521851; x=1794126651;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GzXRn7YCFKIPc+rapsRL629I71VbpYSqluWKUJ0GIpM=;
 b=wvZ9m2drTAQEJtHeWeDB+Vg4Q/gafRqIbf0YLi/kxZBO4J0v4qmaIbWgDaYMnuSj4c
 gi5X7mw70PxAwDcwrRi2+6A8mwe72a69EK+3qPUxS37cDOWLVuGABVvZIPZmnT0J1csz
 kFXKJ8783DiESNBV/iasLqkdTjpnNOJBJ0b7QlR14GTVuIeYkWTB1nF/KfVBoJ/dsMZ6
 huCUJ9SCeNfwrGRIwmypiV1FiWltEgy2S0r8mqwRilBz8FAha5OR+KOywiJsSidWGAMw
 rGBFBCQzgLCqhaZ8jOFl+oeUzt/Z5UhyIL9uBsUXh9+1k7FdBo/+4EsTfXmd2CAvNfqR
 9CMw==
X-Gm-Message-State: AFq9FYIH/RdwFIMDVmvrq9U6seLdAZu4B4a9beYPbR15Rn3XcoNI20yY
 eMtEiHZNE9/aEzTbvz1hWtRK9qe5P8b/wlX4+15LX4iGsn1lh5TiKikx0/gJuKuNWhR2li32Gd5
 7l0Zix4vBvLGc2JdvS0h0EBEQy+wlW7krV+fA
X-Gm-Gg: AYBFou0RhR6qox9zpNy5HJCptZbjmrtqTVB7V37igh4+1pC3XofpLZ0k9D6OxAYdg+G
 gtG2G4FX2tJcFGRwVOAUB19xvR43uUAxwj+dloolZhxeh2CRiNXMHPAkdHKPaBlacV0a8wcK4j6
 11oFjsHjAR0wOWim6L3r52KiVBI0RprztKsVAYvQYh4WSMa3Gw1QbiVVPOMIts/GTbA/iIsiJDk
 rcbC9tWL3UsPdy7cK7+S/Rx6emaoK+E8GGdTYVsqR6RWFNsQvjfSdcjAFB1Hj9B9B7b4pxysjUj
 MkmW2dOQofLZeFQwluyXZSXXz4UIa7ZxdcKuK1maqzs2WTqjLh8oO+gf6wRMCAoOuoMYxV2/1Dc
 y+cem64ePYpQBYsdUThuAbKURJB3xkNETTxLKN4Xp1+RRo8I211xBWQne6CJpLv0fhjr9phJFe6
 lq7e/j8UGZKdVOoA==
X-Received: by 2002:a05:7300:7b22:b0:369:f5e0:b801 with SMTP id
 5a478bee46e88-36a30052111mr14789728eec.17.1793521851155; Sun, 01 Nov 2026
 01:30:51 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261001103412.2162829-1-marcandre.lureau@redhat.com>
In-Reply-To: <20261001103412.2162829-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 1 Nov 2026 12:30:38 +0400
X-Gm-Features: AclHuK-cdlXjKJtInNcRznFgeQNjnOq7hXH1iQ5QSSO_GL9EfP-YOJ4WXiXAc3w
Message-ID: <CAJ+F1CKcS_UK8c9M328Jkpxnq22k-5GTW9zLVmEH=b0yAC4rOQ@mail.gmail.com>
Subject: Re: [PATCH] RFC: chardev: disconnect backend when frontend closes
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Thu, Oct 1, 2026 at 2:35=E2=80=AFPM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> When the guest closes a virtio-serial channel, QEMU notifies some
> backends (spice, dbus) via their chr_set_fe_open handlers. Backends
> without such a handler, like socket, keep the connection open even
> though the frontend is no longer active. This is problematic for
> stateful protocols, as the peer has no way to know the channel was
> reset and must handle re-synchronization on its own. Disconnecting
> gives the peer a clean signal to reset its state.
>
> Add a base-class chr_set_fe_open handler that calls chr_disconnect
> when the frontend signals close. Subclasses that already override
> chr_set_fe_open are unaffected. For the socket backend, this tears
> down the connection and allows reconnection when combined with the
> reconnect option.
>
> Note: this is a behavior change that may break existing setups that
> rely on the connection staying up across frontend close/reopen cycles.
> It may be preferable to make this opt-in via a chardev property rather
> than changing the default.

ping

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 7daf87f0363e..58c69db7340e 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -331,12 +331,22 @@ static int null_chr_write(Chardev *chr, const uint8=
_t *buf, int len)
>      return len;
>  }
>
> +static void chr_set_fe_open(Chardev *chr, int fe_open)
> +{
> +    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> +
> +    if (!fe_open && cc->chr_disconnect) {
> +        cc->chr_disconnect(chr);
> +    }
> +}
> +
>  static void char_class_init(ObjectClass *oc, const void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
>      cc->chr_write =3D null_chr_write;
>      cc->chr_be_event =3D chr_be_event;
> +    cc->chr_set_fe_open =3D chr_set_fe_open;
>  }
>
>  static void char_finalize(Object *obj)
> --
> 2.56.0.rc0.29.g47ce80527c56
>
>

