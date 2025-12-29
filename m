Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78E8D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBOL-0001CT-3u; Mon, 29 Dec 2025 06:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBOF-000159-Cx
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:26:22 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBOC-00071y-Jg
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:26:18 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7ffa421f1bso1715650666b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007574; x=1767612374; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhFN3m/LV5JZm2WE4LRjGBxXv/1BaedT8fbrFZWJ8HI=;
 b=bpYcuNEoNABPf66BtNe1nc3bQKJ+REMhsLJTxWaeLmlcVEZjCK9+MAzUNajFSeJOLu
 NHG2LMffDCr2yDukWUMPZuHSBHxV7vx0MulCuDjoFlmc091NThBerMsJzCeZs17iHkH3
 iFPONJR2gBE3qZFaBoAwYW0SY9x/OqL6eqoPPlFVw/mp5K+IN4136LP68KuzfuiGBfq/
 vuCzuAjIbewl3YiH4XWXgFpSFsYxkBS7p3gOn5b9R+v51mwM/wAql+ftkTugxXNtkqZm
 ZL7rxG6aUoS7A/tZSkzgXoK5P0b1TjgB2mMgyySFsolkx1UHGKUqIiFIb2LTr7aPYB/c
 WJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007574; x=1767612374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VhFN3m/LV5JZm2WE4LRjGBxXv/1BaedT8fbrFZWJ8HI=;
 b=EYItYTV3PRd/qf/hRCTaXqXbtA3m10AAVVqACmhO131SXolizPjwlNwL5rNilWxJR3
 Gh/f+EIWGxC7YlQd6Qsvd0bXKNvdUTMj514g1Hn0ranB7WctxwmR6erkydf+DgWqfO6O
 tj+gNRgOtVNene+SIb4pfEkGZ3TpTj1N6ynnflFJFtZVwZ/xETqKgOVyk0L5xFC23s2A
 bzfqgN9RRq8+ERpR4WocEkrOnDBw5RVoO/AqXqQ/xOwOtbWlkglBoV9dDQhVgyCMxgSW
 b2bk0lDxP9royrb9ofuGUM/0Gv/rcUNJDzRyWFZSSkPotMn7I7nWJZqLTstGrTFMktK9
 60qA==
X-Gm-Message-State: AOJu0YxNKuqI6S9wtyuCQKNxREbDs8iOH4SNYZW6P6khq/mdAZ6j9sj5
 xZntohhhvPYNx1UIc/Q4+0LVhcv1r9SU8tIjtYNvjn+Sc+hsW/lcQ6EwCxdFoaNQcxzWP8rS/1Y
 Om4tBYMSMRaGeGpL4n4l8V5eyigmX9AZszt6sWEUCMQ==
X-Gm-Gg: AY/fxX6SMN5o2Ywp7AVYlJret59xKbnQv077fRftG+EeVGIpDFkCaeTAjy+k7dVKvha
 yhJBVvqBN7ehMNaS3kZ4XNWKudpi+O63A67zFit3KkU2XsdX6tCLhEd0Z/z0O8UzRvDcRVWwrvp
 Ky9T2miFdWBl7CY+in6hkh36O+rVbyxabyCOjdyxXNMt085eEeUzSck/6BALIOBm95lwgrKbrUi
 cOtLPT5OEpFgTrVoYjp6CW7Qc+K0eo5hpaOXcgp+2N3AsNsANlSm+V/kvi3gu0TW5AcZmcvGAhQ
 zdS9w0MbmfekAHkpFcU74yVo20sMfA+zrjDbjo0=
X-Google-Smtp-Source: AGHT+IFCv+DZz186bJBgaD1K3pvi87vuwOt2ave/LQVoHjveGaL/+pyCMBEd9UjuqeeqY/8+LYkafI/yDjsc6k70Dg4=
X-Received: by 2002:a17:907:2d8c:b0:b73:2d9c:9581 with SMTP id
 a640c23a62f3a-b80358bd87emr3544015766b.28.1767007574289; Mon, 29 Dec 2025
 03:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20251224163304.91384-1-philmd@linaro.org>
 <20251224163304.91384-3-philmd@linaro.org>
In-Reply-To: <20251224163304.91384-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:25:47 +0200
X-Gm-Features: AQt7F2r8BqlvLSauBMx6DDIJ8K-o_yCkfvtZ8fwSwNvCjdfbdFy-_bzLsAOa82A
Message-ID: <CAAjaMXYt8sEYft1VZWTmeRjH-MbZR-f=_EcOUu2vuWnaF_ZuAw@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/rx: Use explicit little-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
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

On Wed, Dec 24, 2025 at 6:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The RX architecture uses little endianness. Directly use
> the little-endian LD/ST API.
>
> Mechanical change using:
>
>   $ end=3Dle; \
>     for acc in uw w l q tul; do \
>       sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>              -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>         $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/rx/); \
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/rx/cpu.c     |  2 +-
>  target/rx/gdbstub.c | 24 ++++++++++++------------
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index da02ae7bf88..0841b594f63 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -99,7 +99,7 @@ static void rx_cpu_reset_hold(Object *obj, ResetType ty=
pe)
>      resetvec =3D rom_ptr(0xfffffffc, 4);
>      if (resetvec) {
>          /* In the case of kernel, it is ignored because it is not set. *=
/
> -        env->pc =3D ldl_p(resetvec);
> +        env->pc =3D ldl_le_p(resetvec);
>      }
>      rx_cpu_unpack_psw(env, 0, 1);
>      env->regs[0] =3D env->isp =3D env->usp =3D 0;
> diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
> index f222bf003be..30074c9da7b 100644
> --- a/target/rx/gdbstub.c
> +++ b/target/rx/gdbstub.c
> @@ -56,7 +56,7 @@ int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *me=
m_buf, int n)
>      uint32_t psw;
>      switch (n) {
>      case 0 ... 15:
> -        env->regs[n] =3D ldl_p(mem_buf);
> +        env->regs[n] =3D ldl_le_p(mem_buf);
>          if (n =3D=3D 0) {
>              if (env->psw_u) {
>                  env->usp =3D env->regs[0];
> @@ -66,38 +66,38 @@ int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *=
mem_buf, int n)
>          }
>          break;
>      case 16:
> -        env->usp =3D ldl_p(mem_buf);
> +        env->usp =3D ldl_le_p(mem_buf);
>          if (env->psw_u) {
> -            env->regs[0] =3D ldl_p(mem_buf);
> +            env->regs[0] =3D ldl_le_p(mem_buf);
>          }
>          break;
>      case 17:
> -        env->isp =3D ldl_p(mem_buf);
> +        env->isp =3D ldl_le_p(mem_buf);
>          if (!env->psw_u) {
> -            env->regs[0] =3D ldl_p(mem_buf);
> +            env->regs[0] =3D ldl_le_p(mem_buf);
>          }
>          break;
>      case 18:
> -        psw =3D ldl_p(mem_buf);
> +        psw =3D ldl_le_p(mem_buf);
>          rx_cpu_unpack_psw(env, psw, 1);
>          break;
>      case 19:
> -        env->pc =3D ldl_p(mem_buf);
> +        env->pc =3D ldl_le_p(mem_buf);
>          break;
>      case 20:
> -        env->intb =3D ldl_p(mem_buf);
> +        env->intb =3D ldl_le_p(mem_buf);
>          break;
>      case 21:
> -        env->bpsw =3D ldl_p(mem_buf);
> +        env->bpsw =3D ldl_le_p(mem_buf);
>          break;
>      case 22:
> -        env->bpc =3D ldl_p(mem_buf);
> +        env->bpc =3D ldl_le_p(mem_buf);
>          break;
>      case 23:
> -        env->fintv =3D ldl_p(mem_buf);
> +        env->fintv =3D ldl_le_p(mem_buf);
>          break;
>      case 24:
> -        env->fpsw =3D ldl_p(mem_buf);
> +        env->fpsw =3D ldl_le_p(mem_buf);
>          break;
>      case 25:
>          return 8;
> --
> 2.52.0
>

