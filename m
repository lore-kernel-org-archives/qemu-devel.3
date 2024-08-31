Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54414CA100A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 00:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skBcD-0001RJ-In; Fri, 30 Aug 2024 20:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skBcB-0001QF-5I
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:05:15 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skBc9-00065T-IK
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:05:14 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c2460e885dso1425a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725062712; x=1725667512; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hHwsTRHG7Fg9rTjm09JasTDM1mNWCiIuk1nsCb8SBc=;
 b=ZPfcw1+gwa49p94hpYtEuhfah5c+CPsYrtVAm+Y2iGux9gI14PpJpm+E+2smkbsTPN
 gfN/aTIZyRIJENWy8DkEZVAtICQrzyh/0vGs9OR4YZGHjz8xFZ3+nhQQ18jiRSHhNfh9
 ZnHLsP2/nsh0bgj9nygMa2lh5aaEWzXkvB5w7idlmpuoBqyGlYsW4bOYaNw+Kklp4vKp
 UxvWahBcJ3tpZy1zBCeol/JeVoKr1PocbJCHyWw7HXaP1vwIBi/aP2woqLGVsrBm2Bs7
 pq93a6BGbvDGtzsX8rHfE+BQrt3QVrbzmxhufOIVW9OvMkY+Masggg88lq1CQCLTiTEa
 ++lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725062712; x=1725667512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hHwsTRHG7Fg9rTjm09JasTDM1mNWCiIuk1nsCb8SBc=;
 b=rnUqMoVi7GRQ16u6pcoMgEb+NuHA9nS6u+GC9z8xMOmG8vexpm908WmKA5DLP3+X0d
 HT3besznzUlfL2d6YT100vVdruModlmrumidgQ1118UnAsAFCdh4e5Drbe64rElNfsHK
 1iynCc8k75DQg7B/PyIvlYA4SqXwq8N35hxw/i1mjaQXXp75Y0iTbQQvS9b/BDIy8xDP
 WL3myUrsP2SoueKYn1UMPZFEEQMkFo5CCSARdZr9fCQj6e0lL3ZWOpCUqw/NPN7VswXS
 a5K4bDR1kMN8dz37jB9cABCPW6IAXcIJmzjinksb8lwqNLiawcLLho4FMXtLNMKGQPAd
 jdjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9s89y4AXOPHTsklpOilYMpbE/3TxJLnGot1CUafkbu9JsJNvBY3zkQBIk7ziL29Tg31mapug5kYGk@nongnu.org
X-Gm-Message-State: AOJu0YwsJNjk4mh7YgMQnZBmyeoPUTlcVxyuHoa4UnPM+s3ZUbKMWdlL
 zCuJI+2EvkN9aR/6WkeXfrCojFsYG8z0geHC1U/G1v1MZJSQ1twrGaQyzqF9RoyfYi5IhjqayPP
 SBsSSO72qcr5LTRQQgkoZcAp48K4heoIgVr/fewwevX5VXmXVLhI4
X-Google-Smtp-Source: AGHT+IFjtEKvdFwk4fm4MoDpfHiyezSOWS6yANqcixwzu+NczcAcoVBmaj4ExiP40uQYdxd4bOM70a85fouQJtsJ1lQ=
X-Received: by 2002:a05:6402:268b:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5c245b7607dmr54841a12.5.1725062711651; Fri, 30 Aug 2024
 17:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-3-mark.cave-ayland@ilande.co.uk>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 30 Aug 2024 17:05:00 -0700
Message-ID: <CAGWr4cQx1Crojsn8rvE6MzRZkF7tkn=obkwFe-_ha2gv3w+7EQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] fifo8: introduce head variable for
 fifo8_peekpop_bufptr()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=tavip@google.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Aug 28, 2024 at 5:23=E2=80=AFAM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> Rather than operate on fifo->head directly, introduce a new head variable=
 which is
> set to the value of fifo->head and use it instead. This is to allow futur=
e
> adjustment of the head position within the internal FIFO buffer.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Octavian Purdila <tavip@google.com>

> ---
>  util/fifo8.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 61bce9d9a0..5faa814a6e 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -75,11 +75,12 @@ static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fif=
o, uint32_t max,
>                                             uint32_t *numptr, bool do_pop=
)
>  {
>      uint8_t *ret;
> -    uint32_t num;
> +    uint32_t num, head;
>
>      assert(max > 0 && max <=3D fifo->num);
> -    num =3D MIN(fifo->capacity - fifo->head, max);
> -    ret =3D &fifo->data[fifo->head];
> +    head =3D fifo->head;
> +    num =3D MIN(fifo->capacity - head, max);
> +    ret =3D &fifo->data[head];
>
>      if (do_pop) {
>          fifo->head +=3D num;
> --
> 2.39.2
>

