Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF246C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1jft-00024F-6U; Wed, 02 Sep 2026 08:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1jfr-00023u-VH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:02:40 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1jfq-0007HD-DB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:02:39 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-857ff9fef54so10781887b3.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 05:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788350557; cv=none;
 d=google.com; s=arc-20260327;
 b=Mi16Xvvjo/Pw0UWfqWGwTQtXV8ja/4KQND+9Dq42mDSR83R8J/Qfu6upIK0zDa4MGC
 Fdg5oONMsFqe+xaOHJ7yHcAetWjtNzljz1s0Mg8WAgfJeOGQfcUyJgG+pAKEJGUajU/l
 yrg3Fd6vSS6aL32AATVdY7WYzkPe4SZYZAvMKXRXt6DYqxTitfhfLP5jviBZAJxEqlkU
 ynR7MmQskbtVt+pui3h+6Z0OjTwiugtmpXP2L7SUOScnpeNKVNNSn4TSnR6iWCaSfdOt
 ZFXwbdcVXogxSyDKnHhw6QgPPK2rvTZ1/DGJ+NKO7czVJ3oAIjhCdXvkJI7AIxuUUyYi
 4TMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9qk6ImHY667voTs9DIwtVKu6PG7TkSsRnaUuUx4vwXU=;
 fh=ufEK1cj6fIdUEYFiVU7sZUSO3Fk+JJvYl70xdBqogzo=;
 b=hStlDdE0KZQpq6e+OajXY1pWgCkmjVgxvvyldCxjHbKcWpZxXUCuq811w3V0TMzRj5
 IOrjnXhg8k9YIZgg3S/MhF8X81fLT6ovLOrN48GMOO5ZQI4qbtBd1X+h6NkUrRCZ+KD7
 PAeTpaTNhZvOxEw1ACOEbYw8NXpz1uhB7juDfVE6dElZfT1zfAs4s/6Hgh88fFVYo7Zs
 dTgNhTaV7jBbEQ6kBTV18ajVfD7m7O6RfDMrsd/SwLKzWdgAB4+L+0Qx+XeP4iMQG19A
 XiB42dLdfKcNzBkrQHudgR6g2yD/8WgU2PPY/BSDylBRlHdOWYlgFjmv27/dZ4xcqjFx
 23ew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788350557; x=1788955357; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9qk6ImHY667voTs9DIwtVKu6PG7TkSsRnaUuUx4vwXU=;
 b=o+O0BdERNRKIvKnIFxERSP1u2rxLfksfBjMXKvHTEgpbG4fjwrbDK97A/uXhzGbRHl
 6U4fABFk1RaJLDtlm0oBydPe8hKS54qWrBazLaRciZ++u6r75xcOEChp95s8PQ50GodT
 D5vZiizjIXQf1KBp4EYXrQQ+F4M7GUeJe+EjTKSQIO36OFiwb9u8pexw5xVgZEvabi7s
 eYvC/J4Tzcv20B8pvNTkYNXm+nI/6ef4WFx2EXeRAIZPqfG86tku1Ad4e/N8MQpMtSeD
 Qhctrq4FhznxSdIN72RX9J927OwYQFkDX4fdlyf0ZIHaKxaenJ9ThSumwA1ntZOSQqNB
 LOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788350557; x=1788955357;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9qk6ImHY667voTs9DIwtVKu6PG7TkSsRnaUuUx4vwXU=;
 b=l7KKg7QZ10pmh0cYnqYRBZCarSTJmG9GmYF7Dh/X/afAE58aBODYrbIKtHp1u70DjT
 Xk+uDeaPdEUbnZGN2HySV51HmnK+7GHpneOp88As7T9cowvWBjA5Ow19WygStiTg/EU/
 AJD51OuLuk0hAS1sYD8jI83nTtRmFyNJSw3Wsi+vS4Nq9ecy3ZBbVVGeH3VSLfoV3wls
 1+j/VMIpuc8BxYIEIBVjzb3jKKTyhKSE6Cn90MYoO2mcJkqeQxECIBM0QBU2wVP372IU
 FxGZ2Ml17brQwfKwwWfUvj7rxdWlgVHIxyvUZcHo2FbXbNbdslWiAk0IqJ0jBohWCtzs
 cCcw==
X-Gm-Message-State: AFuF++nVCF6lxLWKoY73R9EtmSBgfaVx2tgl0Pmpec00ICqC+jOw4KG+
 4u4ERnL/K4LAA0+Byn2bCZn5exbf6tun6BdeCNl0zabnAjaluT0OZUTk4eWzHy2LHZKtAEp7IpD
 Svrsl90oh/LImwTB4YUaZr6wz23r7o4bzHnGT58KZINFmdwPpHqgJOOU=
X-Gm-Gg: AYBFou29L76qtsGRSzPUYh5GP/aILQIWu/D58pYDg7iwQ6/l2p7AtfbXHFcfBOctMOm
 V3gJzk254FBKvFn2UoRimAPSgg+zqwvXtP8/sbYJfU6iMakMD9RRuCWv/l/EU3LvOiDUHKi7y/V
 zTmoUrJcHDiN3YZg+dhHSS/m2qwPP+HXumQOajjVNR2dr05EMf0vnk3wERajpy5AE43sNRi2lnU
 2JmwTpiwe5Q4oR3onsRaGMO2C1bI69FZDQjUoPgriGFqmh8y1BSU1oN0ZtH6IPJM+yu2mr5bLCY
 FN+xDo3W8/3yGSLaNRpDRHF9Q/Hb3f5yD4YS356GWN5cyWa8h9Gba5yyL4bArzatSYQPUP2Aq1X
 6GqcKTyPfSKvMv+rnkzBG56viXmFK
X-Received: by 2002:a05:690c:60c1:b0:80c:cad:c4e5 with SMTP id
 00721157ae682-86c5492a1d4mr20960407b3.30.1788350556144; Wed, 02 Sep 2026
 05:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260902104753.1756783-1-berrange@redhat.com>
In-Reply-To: <20260902104753.1756783-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2026 13:02:24 +0100
X-Gm-Features: AcwNN1XzABOvwPjFQQPUrP5eaxwGIGLT6Y5hClHjrqH3aCkPOpNObJJt2AgvM5k
Message-ID: <CAFEAcA_8zwA+bP-95obC9f=-DHDP73n0RQ5JJ59r_bqVJXW-XQ@mail.gmail.com>
Subject: Re: [PATCH v2] system: improve -mon deprecation warning
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 2 Sept 2026 at 11:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Expand the text a bit to make the new syntax more explicit and point
> users to the man page for further info.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  system/vl.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index eded498fa7..d1d9209038 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -3239,8 +3239,13 @@ void qemu_init(int argc, char **argv)
>                  default_monitor =3D 0;
>                  break;
>              case QEMU_OPTION_mon:
> -                warn_report_once("'-mon' is deprecated, use '-object' wi=
th "
> -                                 "'monitor-hmp' or 'monitor-qmp' types i=
nstead");
> +                warn_report_once(
> +                    "'-mon' is deprecated. Switch to either "
> +                    "'-object monitor-hmp,id=3DID,chardev=3DCHR-ID' or "
> +                    "'-object monitor-qmp,id=3DID,chardev=3DCHR-ID' inst=
ead. "
> +                    "See '-object' docs in the QEMU manual for further "
> +                    "configuration guidance: "
> +                    "https://www.qemu.org/docs/master/system/invocation.=
html");
>                  if (!qemu_opts_parse_noisily(qemu_find_opts("mon"), opta=
rg,
>                                               true)) {
>                      exit(1);
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

