Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCE9C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBz6Y-0001ih-Qd; Mon, 05 May 2025 12:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uBz6X-0001i9-8r
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:55:45 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uBz6V-0002ju-HP
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:55:45 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4767e969b94so23668441cf.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746464142; x=1747068942; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpspsPHStqFrWi020x5U4fFN7oF/txGwGPLr5EeL0zE=;
 b=UfZjgn+ld9O2p99vmn45BSJt9BLsGjxUGIMJ7RVR2naMna/WzQyYspos+wtjJqzY7m
 h4TRQWD//+mbIOw94Udj7x9j9sQfvZZpQzagQqqnaZLEPMh6hv/QGI9O3siTdrrPTv9F
 yYHx/PTiY82m8VpSUFJmWx/DvnrgKvczegTqMSw6Hj6EbAGFTAuNKb3RYglVUr2B7kqO
 LNFeizTpqwKorU/4d6xpOypXd6jPxmcyE43c76PspiooTVrt6kH+GH5cP3n+u3wEyzOL
 KQmZEQ4+rCthXGTzyJWYOgEvlUk/5Dx9oEjbkGVD7V/VdulpNA5COnVAI3/XJdi1Qzy3
 NKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464142; x=1747068942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RpspsPHStqFrWi020x5U4fFN7oF/txGwGPLr5EeL0zE=;
 b=eh3IdB2J35M7IdRtu0jI/Zbo5GjMQiMPulvH8qEt8qO+/VvebwpNxeHr2migRYusQk
 4C4aJDLiMv/HRuFZnrXg46/ozZ1qvMalMkvTuqO1T/y+LqDF6QV1hG5HO5+BCaoeXBWU
 T/5noX6M6MonXYN5iyVO/4hxFMSAVd8/TPiNE2HwWzq8tha/qWf9tOZLqiCJtXfYhiD8
 b0eK1G97Gbi+W/5nHJgNKlYrSkhXwIWhge2w73PXB7CEkxpuBXtmI5GB1UacVRgfjk2d
 q5OD+lQxuP4hI6n8ikBRxu2Lv43SQA9GC+Dx6XTwvRyQu9eRGDHfqvjnGKQ3ipnsvtWp
 QFWg==
X-Gm-Message-State: AOJu0Yyw06nXb+QJ6rliTMrxdEveZ8OQ3hOv7XInE6Lm5dnewkLlJavT
 SpXAHyCOxYTzVJeJvVZQdCJMgA4s0fvo3K5kga73WzxPpvdRu4PbDjhy6xOClahUfDnsessDJ/K
 RMYCVP54+G7H6JjWCoHQF+MJf+us=
X-Gm-Gg: ASbGnctRFDZlGkJSss0wMqjNhEw6FmkUesRjD46zDSXLbFDXnjIh0w3cY3oFwt5DYH8
 1xjQv3ZLgm8LF/PsUQFTVKOyfIyGuqpK87pvQNAKvVc2wrtVgH5PQuJXv/fNjf9MbBBPv9LGKDH
 ittTJduTXHklJBef12eU2lCRv7wigtp150WEcRAVm51Zi9oRGOjqGFPK8=
X-Google-Smtp-Source: AGHT+IGdRq9lDIuLBaALwOhHH7+JRVQyFVzap0UQR7mKVbrHA2vzW4r0ZTUrJ5AmqXsInSLo8CB7ifMveOaztUD8+tM=
X-Received: by 2002:a05:622a:291:b0:477:64dd:5765 with SMTP id
 d75a77b69052e-48e0135f10fmr102152341cf.44.1746464141871; Mon, 05 May 2025
 09:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250326161927.15572-1-just4now666666@gmail.com>
In-Reply-To: <20250326161927.15572-1-just4now666666@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 5 May 2025 20:55:29 +0400
X-Gm-Features: ATxdqUH8CZ_3hBANYihEY2cX5lRQtGVOtsnGfJfsdkrDKCB4Jv7R0pZ8wOpoJ5w
Message-ID: <CAJ+F1CKzKuO940euRhCb=tx_UQ-Ncs6k4yctipeT1v4vkinu3w@mail.gmail.com>
Subject: Re: [PATCH 1/1] util/memfd: allow allocating 0 bytes
To: donno2048 <just4now666666@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

Hi

On Wed, Mar 26, 2025 at 8:21=E2=80=AFPM donno2048 <just4now666666@gmail.com=
> wrote:
>
> This silently fixes issues resulting from trying to allocate 0 bytes.
>
> Fixes error, for example, for writing byte 0x20 to port 0x3c0, then word =
0xf09 to port 0x3b4 when CPU is initiated, which shouldn't break.
>

This is worth a test.

> Signed-off-by: donno2048 <just4now666666@gmail.com>
> ---
>  util/memfd.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/util/memfd.c b/util/memfd.c
> index 07beab174d..4f2c4ea1dd 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -131,9 +131,13 @@ void *qemu_memfd_alloc(const char *name, size_t size=
, unsigned int seals,
>          }
>      }
>
> -    ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> -    if (ptr =3D=3D MAP_FAILED) {
> -        goto err;
> +    if (size !=3D 0) {
> +        ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0=
);
> +        if (ptr =3D=3D MAP_FAILED) {
> +            goto err;
> +        }
> +    } else {
> +        ptr =3D fdopen(mfd, "rw");

I don't understand fdopen() here, it returns a FILE*

>      }
>
>      *fd =3D mfd;
> --
> 2.30.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

