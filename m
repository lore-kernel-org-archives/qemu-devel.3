Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986F1E94110
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 06:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaT5I-0001zA-Ej; Tue, 30 Dec 2025 01:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaT5F-0001yc-Rs
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 01:19:53 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaT5E-0005mJ-BL
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 01:19:53 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b83122f9d78so588429966b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 22:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767075591; x=1767680391; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNa1poXdjVVyyMhg4rfaZsPOaRK4bsWJm+gCmDbBPqk=;
 b=JjyHBZ8wr+Jbl/8//ManAcJjMCbRKDmeS1Wagceu5JZMEBadIi5k4Dy6xauCKM7EjF
 x1LraG/nbJkGP+ZSMZpRjelizSBozbyx4WKoxbmpsE0oh91Kmj5XHqe+vWKNL0/SN/CA
 CFYZrQtvowWvNDBgnqHdoiKFpaUefaWA4ogRyEr2gAyV0qnYuV/ZblKZAlRA60y85oHI
 fTj7PoDU3g1VqnVEUm/9wdMFqCLNbrB/sEe1fhe6ufNGhw2Z3eU47dpuM3gvzsukiAGf
 y842CtWrcBh8F0Srk2Mf6lIvLdv/DiebBS1yazKpA/LUn5gDATjJIXmjvDzCz/6V/KOu
 RRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767075591; x=1767680391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VNa1poXdjVVyyMhg4rfaZsPOaRK4bsWJm+gCmDbBPqk=;
 b=ZP68RJS7+PPB+72br5cbUafK5CoRclcp4TS5fRsUbGQTE0oR2DwUKKGi3006jEkTfm
 tNwEPYTLqJN4FayEBb8GTc3/JUU+Dd5+3wYxa+2sNeMP8oY2zd0ly86brGUDEz38R6Pe
 QLt6i/CU3U2bpfPph3Ki3NWAJcgY2w2zmr5wTxTdax/04hDwcYqqhOY7LPYWT3h9t45l
 0hHOyIyPSQ4JZ/vcl9QcQRlk6IID1KLXx9M4TmBm/loWtEq8q6nILr5lsIbjEzQYN5Ye
 ePhhjqNV5By04Lu1155TghbBZFI8MLO9Tlfv5wyOuq66rpHhM352GKDKHwF2DrfhaEpG
 ANIg==
X-Gm-Message-State: AOJu0YzQ2iLvch+lnSk7KdI1hnuJrnK7CoKGA0w9Y9rE0uLezCKWLdCi
 G+EpdoBsSvnl/hU+G/1dI/C+yb98xwqMwNNe8d4rt0UADmssQnV8eL8v82R2zyX7lZ7FUtkUknW
 7FJC4MujEZve/FgfgbLDfTzZUqs8C9WxXDNuAfGu7OQ==
X-Gm-Gg: AY/fxX6gPlYPuQxzjgOgtTf/gkT6SjMl/QnxNwlWvVzrcQulZJXe2qzefOPjC+L1Y9H
 SsgwrB/X2HlMHbTA2qHdiKq/j7mhDaWXKiBD/gLAV+rwxQrXzUrswURrX9F9RdGNU6pusobSPyO
 6m1aaDzW6Cv0qqlh1yOyKhr5qPzcGorW9KNfn0yPUYb0CJFqppQPOaPsn9SXdaxbOCzSr0sSpN6
 omNcFbOovk3io3MqB35Nvb9A25jC9WMn18124w3wexdQBbYzq2fjseXCdEJYnjk2WzwkccREhjj
 lC+F/Heet1i28v7QKjCsXQn4tQMjbVBDwEpIeGY=
X-Google-Smtp-Source: AGHT+IEXyVxTC9zIGELEewazH8Ca6t5aB/1Tkce0o8CfPAuHsowlyvQ/D0PxZcyMtO/ciTAl/LPm//NXZ0nOI64mLZ4=
X-Received: by 2002:a17:906:6a18:b0:b80:1a97:64e4 with SMTP id
 a640c23a62f3a-b8037051115mr3456954066b.39.1767075590703; Mon, 29 Dec 2025
 22:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20251229225517.45078-1-philmd@linaro.org>
 <20251229225517.45078-3-philmd@linaro.org>
In-Reply-To: <20251229225517.45078-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 30 Dec 2025 08:19:24 +0200
X-Gm-Features: AQt7F2qgd7bM_2fPLyMaLbt1pprfRRlX3G8145LCVWd5T1ubgEuUjCYVHK45ohg
Message-ID: <CAAjaMXb0=+k1fRTzczqqoRtZg0MSpW-c7-LczE2qF-gk_bj_yw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] target/hppa: Remove unnecessary @cpu variable by
 using cpu_env()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, Sven Schnelle <svens@stackframe.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Tue, Dec 30, 2025 at 12:55=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Partly revert changes introduced by commit b2c2d00f48c ("target/hppa:
> add 64 bit support to gdbstub"), restoring the cpu_env() call and
> removing the unused @cpu argument.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/hppa/gdbstub.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
> index 777f4a48b99..0c5e41410a0 100644
> --- a/target/hppa/gdbstub.c
> +++ b/target/hppa/gdbstub.c
> @@ -33,8 +33,7 @@ static int hppa_reg_size(CPUHPPAState *env)
>
>  int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>  {
> -    HPPACPU *cpu =3D HPPA_CPU(cs);
> -    CPUHPPAState *env =3D &cpu->env;
> +    CPUHPPAState *env =3D cpu_env(cs);
>      target_ulong val;
>
>      if (n >=3D hppa_num_regs(env)) {
> @@ -162,8 +161,7 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
>
>  int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>  {
> -    HPPACPU *cpu =3D HPPA_CPU(cs);
> -    CPUHPPAState *env =3D &cpu->env;
> +    CPUHPPAState *env =3D cpu_env(cs);
>      target_ulong val;
>
>      if (n >=3D hppa_num_regs(env)) {
> --
> 2.52.0
>

