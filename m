Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312E6E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 14:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPj6-0000Vv-8S; Wed, 24 Dec 2025 09:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPit-0000Qk-VU
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:20:23 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPis-0004qy-7B
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:20:19 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64d02c01865so5998844a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 06:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766586016; x=1767190816; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2c+CY37/4+MDwwaKXqSfTP2RuyG2SrY5ypnWP9AWwyM=;
 b=VgRgykJvqR9thWRiHMBVOp/NkAHWez5cT5BPvHUZsUlplUUViMtD3/Cqw/YLV3zNsY
 KPAMc5YDrwz3EbQWzbpRCQIjYz8W9jIXCIAf6lg/0kht/dWK1nBd5xJOVNrcK5ikNlPm
 SJOv/ofd3g6HvtJGn7d4X7t440adtFrQMOLWH+zLmc5mtKR8VZLdQXKA1KD2TKDkwFYZ
 IXLPq4eXYwvcXwbeiAEhUGc55Bc8AEq2WQqQoOUy1qMENIvvLhwoX2km1ywuBAUm8/Za
 HCScduNd9OJEbeR8gfLewMgTv+YizJ0qC5+D9/UisedoqniX+WKZUvDpQnIyEhtYJg0t
 UPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766586016; x=1767190816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2c+CY37/4+MDwwaKXqSfTP2RuyG2SrY5ypnWP9AWwyM=;
 b=f3iBCdFebLLGfwdDDSIDjijSRAJPgYqRexgJ70gNrgtC14eKCwHP5QJMSPKuJRct5g
 AK1VlGQaXV+G0DWwie8QtotwqRPOoRaAoimx0fupdrhDxhv2P6GEccOkPSzVB4DEXJMQ
 jl8I/QyDeyX5cG2g84FH3RHuTevc5St7nrE5k3iIg6nzu2X/pmcRpre7HxbdoIk6TKmK
 IDLiuWDgfIM10PKfvtG5vi3J0QEBPQHSLGcFTmSQThiFr7sIIkYeELen1rpL14DdYn33
 bTsVXc4VBGOmDv1EpdZR3LzayXmKr6hDTfYx/bP6OrzMLhFCyqmL7xJQQBx8/3rkp3ul
 DfXQ==
X-Gm-Message-State: AOJu0YzV/hk7GSbvEeKG8vFLLPD7QjvQvGmoZ5xPwhHF0NRg6U+czoTD
 glM3glG7VXc4yg1rsgCk4P96jQbFwwAGl+U6OeRy3q3LsBfEOAa8SBBGiUaASpJDdpr5ELYPO5y
 AeaTO+ILVy1GlEJYCQ3NN1Fgkr6smF84NR9n2MIIMfA==
X-Gm-Gg: AY/fxX7G8UK27vH3xaYCDUIbdT8D3EuxWowYtPiSfDVxJ/D6NVEyeyNOJPmaytDccyw
 1qURTIh461KzCRG3+k+a2fCJaSmD2kKRfhIoWxxxuIdNqxaUHqmku0t0XcVwh5lE1fsy/XTrIMF
 t9zI8frR8zo2debSk3Bw+Fdh5immZFQEwCOoGzBReO6ujzEHJhho46ZNGB+4iT5J9UBVOX9E9Wr
 Czyq1UNMPDRSJixf44kgKL5tB8qDF/LVdK19zHUr23zl0KPptrYc1vBRwKeIpoMQb8pT+I=
X-Google-Smtp-Source: AGHT+IHpMruxh31hYjki0bv35ZjPyiLOjB8nexa/hKJcSCjX9pMXvrgSJvOOS1zgOOTgxtnHXdFB7lGN6PJVk6So6qI=
X-Received: by 2002:a17:907:3ccb:b0:b80:3101:cd13 with SMTP id
 a640c23a62f3a-b8036f0a480mr1932211366b.10.1766586015967; Wed, 24 Dec 2025
 06:20:15 -0800 (PST)
MIME-Version: 1.0
References: <20251224133949.85136-1-philmd@linaro.org>
 <20251224133949.85136-5-philmd@linaro.org>
In-Reply-To: <20251224133949.85136-5-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 16:19:50 +0200
X-Gm-Features: AQt7F2oKkDf1c6y3qoIYfsRLserBQSI1fhtF3GrlrMpss704sppoariU8YUACW8
Message-ID: <CAAjaMXa7TD-gF_dqNNna6zOz-NH+OUrffSjUTFJyM4Ve8vZoBg@mail.gmail.com>
Subject: Re: [PATCH 4/6] monitor/hmp: Inline ld[uw, l,
 q]_p() calls in memory_dump()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, Dec 24, 2025 at 3:40=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Remove the last target-specificity in this file.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  monitor/hmp-cmds-target.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index d2bdf44dafd..efab133cf2f 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -129,6 +129,7 @@ static void memory_dump(Monitor *mon, int count, int =
format, int wsize,
>      uint64_t v;
>      CPUState *cs =3D mon_get_cpu(mon);
>      const unsigned int addr_width =3D is_physical ? 8 : (target_long_bit=
s() * 2);
> +    const bool big_endian =3D target_big_endian();
>
>      if (!cs && (format =3D=3D 'i' || !is_physical)) {
>          monitor_printf(mon, "Can not dump without CPU\n");
> @@ -192,13 +193,13 @@ static void memory_dump(Monitor *mon, int count, in=
t format, int wsize,
>                  v =3D ldub_p(buf + i);
>                  break;
>              case 2:
> -                v =3D lduw_p(buf + i);
> +                v =3D (big_endian ? lduw_be_p : lduw_le_p)(buf + i);
>                  break;
>              case 4:
> -                v =3D (uint32_t)ldl_p(buf + i);
> +                v =3D (uint32_t)(big_endian ? ldl_be_p : ldl_le_p)(buf +=
 i);
>                  break;
>              case 8:
> -                v =3D ldq_p(buf + i);
> +                v =3D (big_endian ? ldq_be_p : ldq_le_p)(buf + i);
>                  break;
>              }
>              monitor_printf(mon, " ");
> --
> 2.52.0
>

