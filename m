Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1FE606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TdHb39m4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4pf-0001Fl-ME; Mon, 16 Nov 2026 17:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xT4pd-0001El-Kk
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:05:45 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xT4pb-0007H1-69
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:05:45 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso393675f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794866741; x=1795471541; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1h1SO99KW4rOw1vA0qqF7IE8ZxOco3npd6k8b9OwRfg=;
 b=TdHb39m4GXVWngg4M07Ime6Xf02wU3SgZPBS4ih9fa6WALAI5uMVC5cBqjHfqziYbN
 uSDB2y0hrQLI07Bp0cRg8e5X9+PcmHZX1FuYVjw8G/u1wXEncjs1RQI4tv9HZAAhFG+Y
 c4sfQs8m4n5iQcM9iij5jvKPz9oa/REscqE63wd9DStJUFePoK0LJgFWbePsyFVgfg9j
 BFMZPruCiQE1dL0mNq/D6Nq2j0nRGq+wQDWdERBMxgMsPcwPfo6D1VFd3lMD91t3jBR+
 IsHnkNBvJNEnOYlpf3a3MxtJndm7+Ybztivpls24VXlmbvY3eSl7kYsCP33B08vSkMKY
 8Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794866741; x=1795471541;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1h1SO99KW4rOw1vA0qqF7IE8ZxOco3npd6k8b9OwRfg=;
 b=tDwN4PCVEpFmLXrOVCyLrQSyH/MIK89/VFJCMug9uNgAwjxpnx+kWT5479LkW38YE4
 Mlla2hXLQwHBkRUtahlWyNsGVk9Zm72aES/8kYOuhHaaxsJ3wZHVAPBla4hVKmI9PMEj
 hAdYrElso9ujmj9CQX1UZtZQIAry5zW4xvTlRt2ISEjiHn1DetQzyYf3x/sYNnffkb+1
 hT9dpkCgU+LLFPDoR8Q7EeJVoFYFLEFIJUcB5j4B0APtLibSXQOEiW/5UzyAZ2u8qsgp
 o48y6quesMDldGP9iItxoP7CVb/utoTcSNzhgdnxe9Oy1BnfYZl4jWoaaoNCm4WdgGU+
 5m2Q==
X-Gm-Message-State: APuU4Z+Np34aruPPX7dV5QiMzRuQWhddDVi9wVLvwI+Rv5hC1JQho9kR
 KpQ2I5vOBHM2cBNG5Wd32mM6ljhvHs+McUs9qBMiusSSgZuyvsKuBU1yu/aYYjZQ388=
X-Gm-Gg: AZFdTZcZ1V+f6vybrTIkeiXJy2RWWX9qeyPxDEqinyVMKPgGeJbzCg43QeQzl2UDqUh
 Q9ugv1RxwtdrMWehLr8RgIN6njyZ6EnPo3PJj4I+qRYwW3E+zGyABC1TrZcz4twxVqK9X1g2gxs
 7WlmiNXtgchXYCUCFF22ulzAbHgVBC7iOW7R6SyUWczV4suvD8rAqEvLGBxp6vCjog+47xlEJxw
 h8n/7QkPfPl7JsgiDLxbnLcGKn1mfdBv6N4q76uiyVg6Z4kfpPhN9zucGg6eb0rEZmTrsmBCa2f
 dW93+Yy6/EVjXtutSQy6ZwpSi+uC1EMm5B/RCAt1XSQpd2fAQPtuIie8O1/ClAQKnjapeD4G7ZJ
 HbIH7fi75dI4SvhNA+Q6WI+mK4E+49EUuGowlKK+mT8Pwk2SFgLZmZi+ceZdosU+wd9w8uPVGWW
 ZURPda2Eu3zAJ8WApZqnEsc+grgQAxjJ1jF9t64rQrz3GTBecE5nhFl8kIzBp/mX6eepoHYFn1B
 vtvv+cwAKyjApL+/JUNVSHa64J8rol3EAbq3EoMbbbmNfXTniJOe0c8LLc/3Gtc6lTnU+Z2e2rl
 zyJvZlIRz+G8nDEZW+qgun+zdl0nWA==
X-Received: by 2002:a05:6000:26ce:b0:48b:e50:7159 with SMTP id
 ffacd0b85a97d-49c71b5bfbemr24288527f8f.30.1794866740686; 
 Mon, 16 Nov 2026 14:05:40 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c0e0dsm23515187f8f.15.2026.11.16.14.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:05:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 84F3D5F8FE;
 Mon, 16 Nov 2026 22:05:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  qemu-block@nongnu.org (open list:Floppy)
Subject: Re: [RFC PATCH] hw/block: validate the fdc sector position fits
 within bounds
In-Reply-To: <20260812172842.60524-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 12 Aug 2026 18:28:42 +0100")
References: <20260812172842.60524-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Mon, 16 Nov 2026 22:05:36 +0000
Message-ID: <87fqx0ig9b.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Previously the guest controlled the value of last_sec and wasn't
> particularly careful to check it didn't exceed the media size. We
> can't re-use drv->last_sec as that changes as we do operations so we
> set media_last_sect when the geometry is probed.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3800
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Gentle ping.

> ---
>  hw/block/fdc-internal.h |  1 +
>  hw/block/fdc.c          | 28 ++++++++++++++++++++++------
>  2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/hw/block/fdc-internal.h b/hw/block/fdc-internal.h
> index e219623dc7a..81775fe55aa 100644
> --- a/hw/block/fdc-internal.h
> +++ b/hw/block/fdc-internal.h
> @@ -83,6 +83,7 @@ typedef struct FDrive {
>      uint8_t max_track;        /* Nb of tracks           */
>      uint16_t bps;             /* Bytes per sector       */
>      uint8_t ro;               /* Is read-only           */
> +    uint8_t media_last_sect;  /* last sector of current track according =
to media */
>      uint8_t media_changed;    /* Is media changed       */
>      uint8_t media_rate;       /* Data rate of medium    */
>=20=20
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 1178b959a64..18a61f5ce87 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -192,6 +192,7 @@ static void fd_init(FDrive *drv)
>      drv->max_track =3D 0;
>      drv->ro =3D true;
>      drv->media_changed =3D 1;
> +    drv->media_last_sect =3D 0;
>  }
>=20=20
>  #define NUM_SIDES(drv) ((drv)->flags & FDISK_DBL_SIDES ? 2 : 1)
> @@ -373,6 +374,7 @@ static int pick_geometry(FDrive *drv)
>      }
>      drv->max_track =3D parse->max_track;
>      drv->last_sect =3D parse->last_sect;
> +    drv->media_last_sect =3D parse->last_sect;
>      drv->disk =3D parse->drive;
>      drv->media_rate =3D parse->rate;
>      return 0;
> @@ -1905,6 +1907,17 @@ static void fdctrl_handle_partid(FDCtrl *fdctrl, i=
nt direction)
>      fdctrl_to_result_phase(fdctrl, 1);
>  }
>=20=20
> +static bool fd_validate_last_sect(FDrive *drv, uint8_t new_last_sect_val)
> +{
> +    if (drv->media_validated && new_last_sect_val > drv->media_last_sect=
) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "FDC: Guest attempted to set last_sect to %u, exce=
eding valid media max of %u\n",
> +                      new_last_sect_val, drv->media_last_sect);
> +        return false;
> +    }
> +    return true;
> +}
> +
>  static void fdctrl_handle_restore(FDCtrl *fdctrl, int direction)
>  {
>      FDrive *cur_drv =3D get_cur_drv(fdctrl);
> @@ -1919,6 +1932,10 @@ static void fdctrl_handle_restore(FDCtrl *fdctrl, =
int direction)
>      /* timers */
>      fdctrl->timer0 =3D fdctrl->fifo[7];
>      fdctrl->timer1 =3D fdctrl->fifo[8];
> +    if (!fd_validate_last_sect(cur_drv, fdctrl->fifo[9])) {
> +        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_EC, 0x00);
> +        return;
> +    }
>      cur_drv->last_sect =3D fdctrl->fifo[9];
>      fdctrl->lock =3D fdctrl->fifo[10] >> 7;
>      cur_drv->perpendicular =3D (fdctrl->fifo[10] >> 2) & 0xF;
> @@ -1983,13 +2000,12 @@ static void fdctrl_handle_format_track(FDCtrl *fd=
ctrl, int direction)
>          fdctrl->data_state &=3D ~FD_STATE_MULTI;
>      cur_drv->bps =3D
>          fdctrl->fifo[2] > 7 ? 16384 : 128 << fdctrl->fifo[2];
> -#if 0
> -    cur_drv->last_sect =3D
> -        cur_drv->flags & FDISK_DBL_SIDES ? fdctrl->fifo[3] :
> -        fdctrl->fifo[3] / 2;
> -#else
> +
> +    if (!fd_validate_last_sect(cur_drv, fdctrl->fifo[3])) {
> +        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_EC, 0x00);
> +        return;
> +    }
>      cur_drv->last_sect =3D fdctrl->fifo[3];
> -#endif
>      /* TODO: implement format using DMA expected by the Bochs BIOS
>       * and Linux fdformat (read 3 bytes per sector via DMA and fill
>       * the sector with the specified fill byte

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

