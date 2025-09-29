Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD26CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 00:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v324d-00086Z-6g; Sun, 28 Sep 2025 20:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v324X-00085W-4v
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:48:58 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v324L-0003Dl-I7
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:48:52 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b3d5088259eso116848666b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 17:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759106920; x=1759711720; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FuQ3gqrZu3wFxEKLP/t2Zn/923IEv86jm1SwODhMIg=;
 b=ijyGW7yeGOdnS0Ivms0MPQp94j7tL4FcvlPXv2rpGzrjrC7nwfoIT/geqNjN31r9Xc
 BxCkvHrVuMNPz+appfkM7R7+TAqOBIlV02l0ZNa2F0iCfUnjdo73CWHZynGB3hAUrVvz
 +jh/VrAH/LdsmxQ318Fiffvp2yzW0a+07usZsPMPAn0I1U1oWJyaLQz7JBrNDUai+ak0
 /9t/fO+Js/CbhLuIJNN7tIZsPguRm9X7eqaPJYaAs9FzNxBTkNdiObs3M7iVHJWfftUh
 4IlTXrdo9uLJuTjZ8m0zgD9Hig40RUXQ4jNki3tY29830RT0Bn9PNnhxGyCmSJzeu8Lt
 B2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759106920; x=1759711720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FuQ3gqrZu3wFxEKLP/t2Zn/923IEv86jm1SwODhMIg=;
 b=SWKyMGk/krojcSDIXU7jI7AH7G1Oa6rhrw2LnJHkVhqFwxIAF9WEjCN9+6c+25XXDv
 3lctkQng4OCU5JT4ZBareH2N1devxcjpkG6/8P2x51RVs+l0goC0vKZqflXENGK2pEK0
 /tI/2hpibJdZs8pAt7Dhspop0LdqRRVI2R0PhVnAe9SPiR6FJuMEL7Q+SmtyVe1Lr6al
 ULUW20gDbSpZEU5uTMbshT4aZ+LFnqKkqWgZxVhEMNYS+C67cq6Wmv25VC+ThHwXMX/3
 dFTyDX6+TcBlXOV+p4hUvVsXK3CSiINNrURYxzDbN2FRIk5cNDgEwLu6ST+D1Md5TbFB
 d7HA==
X-Gm-Message-State: AOJu0Yx06yE/j4ASCjOHvmi6VNmWWFruzPBlhglycu5e96momshqNGam
 QcIkXqLYHg/nvWjIdaS0PJxui/cDUj4/Y3N8g41ygAvJJUpPcxrWqbvJJp1eRLyXOD2XZ/ViDG0
 3qiwT7VYWh3ZpBC8566xt+Yxm9+Eka6w=
X-Gm-Gg: ASbGncvzFu1I0ZRkn+mBuKgaUftHsVtCzrpgnwI/b2sRLd4aixComp+wgC4cONJQ22u
 sW5/7nucraKexIVGVqfFam84KiQK4iceiJvdr0rxD18zfb8BWjzfOrESFV/ccbBFxFzEKOSrsnR
 K7F4m9k1hb+veq7caBQa78b1hQzUO935W+P+BJl05CbzUPRFaLnwB9yAI28OYnMZ23QKmf/5Kt6
 ERK2vu/Ce/KLdgdEHGiWKuB8Ul6BJ58V75HBTDg1diR4ZS/
X-Google-Smtp-Source: AGHT+IE7tq0w67WJh8Pea89OWUcIrpAjMBd715KyLKouePsMX7610vPl1gPomdlYT0kl8kVlEVaTpxljyXEs8DwyRcI=
X-Received: by 2002:a17:907:6eab:b0:b3d:c47c:7cd4 with SMTP id
 a640c23a62f3a-b3dc47cab70mr296996966b.42.1759106920025; Sun, 28 Sep 2025
 17:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250924074818.230010-1-jim.shu@sifive.com>
 <20250924074818.230010-3-jim.shu@sifive.com>
In-Reply-To: <20250924074818.230010-3-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 10:48:13 +1000
X-Gm-Features: AS18NWAApGyjWnIrnrMY84C9bx_y2UiT3GW7IYXyp-ol99Bp963zUnrexP0-eqU
Message-ID: <CAKmqyKPaPtLhKzZ2pJDVjPP8xENfC02YHOOMuLq0v0g+_N2J7A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] target/riscv: Fix SSP CSR error handling in VU/VS
 mode
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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

On Wed, Sep 24, 2025 at 5:49=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> In VU/VS mode, accessing $ssp CSR will trigger the virtual instruction
> exception instead of illegal instruction exception if SSE is disabled
> via xenvcfg CSRs.
>
> This is from RISC-V CFI v1.0 spec ch2.2.4. Shadow Stack Pointer
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 8842e07a73..0299a214ef 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -204,6 +204,8 @@ static RISCVException cfi_ss(CPURISCVState *env, int =
csrno)
>  #if !defined(CONFIG_USER_ONLY)
>          if (env->debugger) {
>              return RISCV_EXCP_NONE;
> +        } else if (env->virt_enabled) {
> +            return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>          }
>  #endif
>          return RISCV_EXCP_ILLEGAL_INST;
> --
> 2.43.0
>
>

