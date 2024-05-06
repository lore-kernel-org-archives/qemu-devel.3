Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD252C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3vBC-0007zu-8s; Mon, 06 May 2024 06:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s3vB9-0007zW-TA
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:02:39 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s3vB8-0004z4-At
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:02:39 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51f1b378ca5so2773265e87.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 03:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714989756; x=1715594556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xfdtj8h/VawKtUxi1Sd83EvjbUzAWyb7XIIUqXyv0oM=;
 b=Y663nGJOOSi3cgl9TficlC0u8IS58+DUXGrpWhW708OgoSsHauHKYdmLtR9ujb83s7
 85N0r/I9t93982RxxXe0YW1BfaIElAlsM6GtWUSldGxQaY9NkAMDAQf0oY34UVkDACWP
 5HYKIhIbdhrndr414L6IJTrQ3K2oTrUPmz1hrz6Ag4GAfKBkJ63gMrryh7rZ2B2MmqLS
 ilADdVFwMeBOaGIM5pqVpiSMER7CFIi9OFs8wBUJIt3YTUbqpoLNYuk3vBgtZBlvA+KT
 4r+AGtugye+ruZfOVZnV01M3tu6o1LVS5hFs/j/IolYowyRZqcNSfTja8iGZa41/V65L
 224w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714989756; x=1715594556;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xfdtj8h/VawKtUxi1Sd83EvjbUzAWyb7XIIUqXyv0oM=;
 b=Y2xrp6sfKBc/x/Da7sxT//jIU138OBu4MeLghH+loxo2RMJtHi441Hq3wdt7h3yybs
 H2jgIlByCAVgW0D/PpOZYwiWUJcUdSKeicpvQetfsQrMrVztL2gyuBRNcjYmlQItCGc7
 J2o4VklH8t+D3puNfW53I4+gtPkAYr9PO7dTEp1C3W0RJzPTzYy86gExk0b1aN+qSQal
 i3ZlFTTcgatkTSujTTIuIpO2yjFW90kZk+fJ8eaXk1wRF75m9LUSg1yYvoYrpUsONQJO
 l7PPStpPiva0eUxPFyxyK3roYYKNtx3R0pLAB7H+KQM/11uNNhAOH2Q/ALc6dQ2EoSZO
 Zc2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBqsf166KI1DdUCDMrwSgTJvZfD8GdJWsE9F0zDV1s3ywej08vgTStHdrF84MUsg1DWE03D/pP/oI66/VOxQu8/IqUAZE=
X-Gm-Message-State: AOJu0YxXgfTr/gyw3tkrVLhIX4DqvB/vf5y01AB1ZQNMAF7fmpwbh1OA
 stxRs+RpSWXNXX+yO0a5hJD5J0bJ8W70m/DeiFbcJbOmM2RkT+4C8MxivDnKM6MrRKZNpvJVVbN
 e
X-Google-Smtp-Source: AGHT+IHggyDs7eFPTwIL/jyRSdMsnwwsfCCtd+VhJ18DxcFAY3Y0kV57buwsGd9QQdKNp5rQoAq6oA==
X-Received: by 2002:ac2:4888:0:b0:51c:fd0a:7e37 with SMTP id
 x8-20020ac24888000000b0051cfd0a7e37mr7661835lfc.20.1714989755681; 
 Mon, 06 May 2024 03:02:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q8-20020a170906a08800b00a59ce3ec763sm1058990ejy.154.2024.05.06.03.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 03:02:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 583F45F8B5;
 Mon,  6 May 2024 11:02:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Andrey Shumilin <shum.sdl@nppct.ru>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [sdl-qemu] [PATCH v1] /hw/intc/arm_gic WRONG ARGUMENTS
In-Reply-To: <4c4dfebb-698d-466f-90b0-9475ad4c123a@nppct.ru> (Andrey
 Shumilin's message of "Sun, 5 May 2024 22:57:41 +0300")
References: <a4cbfe6c-27d6-4df0-ae31-db0d60d88f9e@nppct.ru>
 <95ab6dcf-cc96-4472-93ab-f08682b37d5e@tls.msk.ru>
 <4c4dfebb-698d-466f-90b0-9475ad4c123a@nppct.ru>
Date: Mon, 06 May 2024 11:02:34 +0100
Message-ID: <8734qvuukl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

Andrey Shumilin <shum.sdl@nppct.ru> writes:

> 1 Possibly mismatched call arguments in function 'gic_apr_ns_view': 'cpu'=
 and 'regno' passed in place of 'int regno' and 'int
>  cpu'.
> 2 Possibly mismatched call arguments in function 'gic_apr_write_ns_view':=
 'cpu' and 'regno' passed in place of 'int regno' and
>  'int cpu'.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

So this purely a heuristic test based on the parameter names?

>
> From 23b142f5046ba9d3aec57217f6d8f3127f9bff69 Mon Sep 17 00:00:00 2001
> From: Andrey Shumilin <shum.sdl@nppct.ru>
> Date: Sun, 5 May 2024 20:13:40 +0300
> Subject: [PATCH] Patch hw/intc/arm_gic.c
>
> Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
> ---
>  hw/intc/arm_gic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 7a34bc0998..47f01e45e3 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -1658,7 +1658,7 @@ static MemTxResult gic_cpu_read(GICState *s, int cp=
u, int offset,
>              *data =3D s->h_apr[gic_get_vcpu_real_id(cpu)];
>          } else if (gic_cpu_ns_access(s, cpu, attrs)) {
>              /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
> -            *data =3D gic_apr_ns_view(s, regno, cpu);
> +            *data =3D gic_apr_ns_view(s, cpu, regno);
>          } else {
>              *data =3D s->apr[regno][cpu];
>          }
> @@ -1746,7 +1746,7 @@ static MemTxResult gic_cpu_write(GICState *s, int c=
pu, int offset,
>              s->h_apr[gic_get_vcpu_real_id(cpu)] =3D value;
>          } else if (gic_cpu_ns_access(s, cpu, attrs)) {
>              /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
> -            gic_apr_write_ns_view(s, regno, cpu, value);
> +            gic_apr_write_ns_view(s, cpu, regno, value);
>          } else {
>              s->apr[regno][cpu] =3D value;
>          }

Ahh C's lack of strong typing wins again :-/

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

