Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E31CCF9F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 01:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEdfd-00046C-0N; Thu, 30 Oct 2025 21:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEdfb-00044I-8t
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 21:11:11 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEdfI-0005gB-SO
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 21:10:58 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63c31c20b64so2628131a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 18:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761873043; x=1762477843; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4/0sOaBdykJ/ogHtR4zHFcPBGx2IfOF5OfPeA13bsQ=;
 b=AuHv2ZbwduL4fHaXciUi2G8/0sj0teGzqhypSx2j4voVWTEIX+N48wg8WsXS9cGNzc
 Cb5lFWyGHn0Qr2ipGuo5ZHi0aLGY5orl6g0dmI4g0RFLwPjcxW4Cn4KY+rtcYrcif9pB
 m0u7SvBOMGS7FChQomAPFe46sdhUDkkaXDRyChJIbCKPL6L9StAM1KfveXlkpJJnA82y
 v2cgan9O5I2uOPf27hnL4UTj4fZvsS+5Mo9a75EJnfGzcxPXGXDzWuMDEjB3bZblnO17
 N13vLa1PfPixVhi+s5qpKufcsYRh1p+w4BUW6xlbxcTWqiIPGph2KGsNCOJXQD1JSnxI
 qhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761873043; x=1762477843;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4/0sOaBdykJ/ogHtR4zHFcPBGx2IfOF5OfPeA13bsQ=;
 b=AdcadFF83oLU93M/lxTzzd+ZSTxaAUscn5h2lKnJ2l564YB4wu4qAdZ4vlvlj8bdAy
 oUwCDNMyLxAhUvoy3il1CfXc9wBcVLcCNp+QXmpk8myhf0tgf+roNAEekFWyIL9wUp+K
 rao40sSZQCdWHrJaGuG5Xa+bl0qmWgyKCjII9448FbJJ7h8op43ib48ElbeyPdqvGifP
 16mPz3Q/KAVGIE3ksfqTei+jQk+nNAI5um/+gQ1NL8cWefMAJX38Qb8xgN9u0qioc7sg
 7tbCxqVUspxeQ8rZotH6E5iAIitAzdvzo+7Gek3m76B8UgI9QYtOvcCvbfoWKjhz2cBL
 y+lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc2td6FQ39OBEz3sGYy3QBOh9iWQCMcmH4GkqAnIJBc/XWG0XahO5/eGHoLu/E6yIG7/5ed+RX1ftI@nongnu.org
X-Gm-Message-State: AOJu0YyzVFq6ZEbD9jNUnL6+FiVLqLZXyjeP8SWfRGbw97T2U1nNeBjs
 8ON50NVrp3rV2XplonWgAqMosgjVsNW/jhBMlZDZeXj6lsQZz6erW9U1qqrmrlkTEFh2TrNjRPJ
 nDCZ3aFjuB6PxcAd7K37ZfglrMhPdJiM=
X-Gm-Gg: ASbGncsO4SuOishr4ukb9riN0Rq4fsnsGRa3WCv183yrkAj+fn9fGoVYFfQyyPXf29y
 t7XjlQj0gjCv48ucFfYRUCYXj22gqkS+IKwbn6d0i3rhiiu0PlyLAItR1re0pSNmtd3S6mkNXUA
 745aBv2ptSrtVWSQCkHIuOcvvaCKLM84aq0zsezrIC/27t1fgKl+RzXdmisK7PSb2Je0yW8aTpw
 +7OnzWjsO8/khrXqtBVC6bN7OcRCMetEUU8BxY8uLpRqnE6aF8vFvaQOJESg0AJPTcYBHmnNxSx
 kS6HexOaUn7DAjb3bE3ekemTL1fwgOuwSpxo
X-Google-Smtp-Source: AGHT+IFDkSbXhkFn3gb5quPRMp0DMUkhZJR0c2EUtguF+BI7CUdBjBH7SLQrD+jjEhdeszzIGqi8nUThyeFTY67Yaf4=
X-Received: by 2002:a05:6402:42c4:b0:633:7017:fcbc with SMTP id
 4fb4d7f45d1cf-64076faddecmr1350924a12.15.1761873042817; Thu, 30 Oct 2025
 18:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251030015306.2279148-1-alistair.francis@wdc.com>
 <20251030015306.2279148-3-alistair.francis@wdc.com>
In-Reply-To: <20251030015306.2279148-3-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 11:10:15 +1000
X-Gm-Features: AWmQ_bnunYy4BkzYpjoKBZ5jHyXX4vE3jlZ_atCr_RQWTg6ShXRjUAWKkHCQnHE
Message-ID: <CAKmqyKPenVTBGfK4P5crzugGf_HVr_u38-g4Q4XOAt=g5VDdvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/core/loader: Free the allocated string from
 size_to_str()
To: philmd@linaro.org, alistair.francis@wdc.com, vishalc@linux.ibm.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Oct 30, 2025 at 11:53=E2=80=AFAM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> The string needs be be freed with g_free() according to the functions
> documentation.
>
> Coverity: CID 1642762
> Fixes: f62226f7dc44 ("hw/core/loader: improve error handling in image loa=
ding functions")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/core/loader.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 1598dca03c..e83d245202 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -153,8 +153,12 @@ ssize_t load_image_targphys_as(const char *filename,
>      }
>
>      if (size > max_sz) {
> +        char *size_str =3D size_to_str(max_sz);
> +
>          error_setg(errp, "%s exceeds maximum image size (%s)",
> -                   filename, size_to_str(max_sz));
> +                   filename, size_str);
> +
> +        g_free(size_str);
>          return -1;
>      }
>
> --
> 2.51.0
>

