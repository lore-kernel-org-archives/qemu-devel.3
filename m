Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D8CC5AE49
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtRSO-0002S4-Tb; Mon, 10 Aug 2026 10:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wtRSN-0002Re-J9
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:58:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wtRSL-0008Mw-Sc
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:58:27 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so17853145e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786373904; x=1786978704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MxdIz3kikgU2hEFrcrCau2io7vnun9UoeypO6RHhoik=;
 b=DMgqXC5OlmcbpRE95TWE8xueFqssh29+VrjcUCNvUINA/SOAI7VXBsMKj2eiqM5YGR
 v6zAn/ToNHaj1RlBXCvAyBfT3tK5A1EbfFgJ+wEf7qMAPNjlmgttt5s7ktNN9ulTVMx6
 FbSuR9V7F8GrfoA2RtEBp8XjTzqTUTedH0lmlfYFZ8iw8FsXrnkJOdBaurwU7vGnoUeR
 0HeINNmVoD3byw6DJmDv/3uXrm4w39vib+Gqee+eJ7xtA59m5Kiw5oiQ1PLkrRmU9p2f
 hwdA5yGpYMSKM3WcZ90+n0czFoSspZ6RuTlwELYmpYKJOkFQ6v+K7kcRYch2Etylhwmt
 hKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786373904; x=1786978704;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MxdIz3kikgU2hEFrcrCau2io7vnun9UoeypO6RHhoik=;
 b=PziAOR9iQtsGtj6dctLkx/1sOefExSfV03YEJF4hnNqBK2Ellcm/2eJI39ZV0CXHhF
 eZ8xQgUf2ELCI+rZ4WTdWiN1tPtjkzGaG2EpZX0JTx0u6vJkWyvDcFngGfzVpL3ERswX
 zy12WuDxkpnDELLNOXqsIvgOUP6vuXgAk/aT0vlLRFBrKJK/+vWE7dYb6MSKozcRY/kG
 cQ+0X0JvloZREmCbK93Au/gFscu3YiMOO9pUVmUEszJ4urgTex/5nLt6qAj+t6X0wrAQ
 6+cEBZk41NTCPLGhPpge/15P5zJvooME2MkFL6N2meLdImfALX83qPZVIpNZsrHrrO/v
 Go6g==
X-Gm-Message-State: AOJu0Yw8DCmU0rrrZbPwUjFZz6jTET69LU3mW2CdZttuLuetQlue4+UF
 BSwQmjmRAyclT6MaLOkVLafRq9OU3U8Un2qKxA5WjZuL6X41j8KQNh+kuW8LPrR7BkE=
X-Gm-Gg: AR+sD10ZvnBsR5l0dkKpZKEVIiQP1SqkCuMYP97RTRWVpwU60+1XjqbWMlJVIheOzSD
 am/4tW99p5CXW+Wt/4++xntV89sswXCNirk2QO5PObWc6Yk8i19ma563Htdyja6boS93bSE2g+A
 8q8tgcFbrJfbTEr4KW/18qXP42kBe/JaHmTubxhmoiLPkK3zOIzb15TgnAPzY10clUMVEhrqEpK
 Hq5jp/nqD2Q50Mvb5LsimFYR9PfBK/ocyCOIEmaH9t3cjqM1PlU137DqikQWiu4lPLkE64Iewbz
 O4du/6Zcg9Kqmrr2IK49TnvkwkfvPBirWIlHIbNl59CAYGDMw6t/a6jyX7W1kbdk5/uuntS4hI+
 7GruardHo8AzBuvg6ngzp+sgYWUTlVE8wIcwRHk3hKMXTnhy4h9WzAW4+BDrPGjqk57X2IJ+INs
 6uSmkS0viCyymgRCRsnrE07FFN3l+IDybAcIPQErsxXn627cRv93RS+elJYwgy
X-Received: by 2002:a05:600c:1d23:b0:499:51b8:d649 with SMTP id
 5b1f17b1804b1-49951b8d652mr502149015e9.3.1786373903672; 
 Mon, 10 Aug 2026 07:58:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea2dc4esm345729905e9.13.2026.08.10.07.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:58:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E92D55F83B;
 Mon, 10 Aug 2026 15:58:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?St=C3=A9phane?= Graber <stgraber@stgraber.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-arm@nongnu.org,  Alexander Mikhalitsyn
 <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH] hw/char/pl011: support backend hotswap
In-Reply-To: <20260810121525.100540-1-alexander@mihalicyn.com> (Alexander
 Mikhalitsyn's message of "Mon, 10 Aug 2026 14:15:25 +0200")
References: <20260810121525.100540-1-alexander@mihalicyn.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Mon, 10 Aug 2026 15:58:21 +0100
Message-ID: <87h5l22faq.fsf@draig.linaro.org>
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

Alexander Mikhalitsyn <alexander@mihalicyn.com> writes:

> From: Aleksanr Mikhalitsyn <alexander@mihalicyn.com>
>
> Currently, when Incus issues "chardev-change" QMP command to change
> chardev backend from ringbuf to socket it receives an error (with aarch64=
 VM):
> "Chardev user does not support chardev hotswap" [1], [2]
>
> Let's fix this by properly implementing BackendChangeHandler for pl011.
>
> Link: https://discuss.linuxcontainers.org/t/unable-to-connect-to-vm-conso=
le-on-arm-architecture/23096/3 [1]
> Link: https://github.com/lxc/distrobuilder/issues/892 [2]
> Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> Signed-off-by: Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@futurfusion.io>

At first I wondered why the FE needs to care about where the BE is
routed to but 7bb86085e61 (char: chardevice hotswap) explains:

  However, backends are not stateless and are set up by the frontends
  via qemu_chr_fe_<> functions, and it's not (generally) possible to
  replay that setup entirely in a backend code, as different chardevs
  respond to the setup calls differently, so do frontends work
  differently basing on those setup responses. Moreover, some frontend
  can generally get and save the backend pointer
  (qemu_chr_fe_get_driver()), and it will become invalid after backend
  change.

> ---
>  hw/char/pl011.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index cb12c3e224f..3622248ec0c 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -660,12 +660,26 @@ static void pl011_init(Object *obj)
>      s->id =3D pl011_id_arm;
>  }
>=20=20
> +static int pl011_be_change(void *opaque)
> +{
> +    PL011State *s =3D opaque;
> +    int break_enable =3D s->lcr & LCR_BRK;
> +
> +    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
> +                             pl011_event, pl011_be_change, s, NULL, true=
);
> +
> +    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
> +                      &break_enable);

So this is just ensuring that if we switch to a serial backend we
properly register the break behaviour on the backend? Is it idempotent?

> +
> +    return 0;
> +}
> +
>  static void pl011_realize(DeviceState *dev, Error **errp)
>  {
>      PL011State *s =3D PL011(dev);
>=20=20
>      qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
> -                             pl011_event, NULL, s, NULL, true);
> +                             pl011_event, pl011_be_change, s, NULL, true=
);
>  }

This does make me wonder if having a static pl011_set_handlers helper
would keep things tidy and in one place? Either way:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>=20=20
>  static void pl011_reset(DeviceState *dev)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

