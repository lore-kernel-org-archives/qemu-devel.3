Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2834EC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYGE-0003Sx-M7; Thu, 15 Feb 2024 04:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYGD-0003Sh-Ju; Thu, 15 Feb 2024 04:42:29 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYGC-00079s-3R; Thu, 15 Feb 2024 04:42:29 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7ce603b9051so292680241.2; 
 Thu, 15 Feb 2024 01:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707990146; x=1708594946; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGvkS8n+Oh+TPiwAZSZyAc7k3ZMDeGDOd94zL/zN2dI=;
 b=Qozq5X69me73x26xu4MTFroFvXBHOhMVTdIfHbUWW6DAuA0dX/dfEj9FcIzmmTX+91
 XhglvwomvGevmAK0J932byRZolERAY6r2cef2B9mycwvB3wZ5DUPe/0kost0EAnJ7VNU
 PamTWOQqb3xHMYmP+qb3zjEYSqg3IzQULTTVNC7AX+p9DZs8ewohDVAkFtjUiW51Zocz
 8lsDtJVluT1M5D/lJx1rUnJlTJlXOf7Hl6tloogp/q/l0gvMpnWAnoPvg7xpzLovU8ky
 e1lgZbjr4ONNLY2dFQ7hfO3DV40Y4gZPhuVqoXCIFbyjGOpCQG/toji4KlUWoMu465/6
 noGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707990146; x=1708594946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGvkS8n+Oh+TPiwAZSZyAc7k3ZMDeGDOd94zL/zN2dI=;
 b=VqFnj8YFbnps+WMOL0ZPh2DNkAuXTFezCwe0vUf4tKTNMUMBDB4uUrB9LCeTByQDKi
 Zio+T+He143dt7spC+04X5luEZCwIDZE8ko0/xuadAVbcozNsICbi8oafJECs8IT/Pgc
 9eRX9l5QXDhGczbsGZuusum5MXroa40y/DdPm3bI62zEh/c1PW6jjAc2LIuZESIzBix1
 y4jk6jhHlDZJB/JcK3Vwww3Go12y2+8zYOaXxs+HFgltIhY6OwxF162tfcHFM2gRajPF
 jrb+d/Fs/jsW4g0MGd5JIQPZqDif9mGJcX5S83VLmhC3wPtzOrkEETyPBfZtw8qcdbOO
 QvNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFwACN71HAGtbPzhMh+PJHeIBXXiAeLFl7rkmiGOWQ7Z17AOHsMxXPccUNG0dnWyFFjEd67u3lVtPiEF10xl8FV+7tB0M=
X-Gm-Message-State: AOJu0Yz8PlC/Var60o8zmCHY6Yq4hl5npekfI2RT3WAEQMNR4kdafSa8
 voW2SpuilB0CJgze8NjvXRut1cnPXkKPIRb1AphhjWEt5lOC1ZbVvD5PJOq6pgziJK1ONTG6NoL
 7JJoRhE3iqZ5ZxYsDW+rBruuRp7M=
X-Google-Smtp-Source: AGHT+IEdmrQ4a8IEemozXqBMZYvVKvEHZ2K1majW3ZVetk+gLkVxibJHqI4OZmvgjOXcCd0f/7tdxei6QXCy1Tb591o=
X-Received: by 2002:a1f:ed01:0:b0:4c0:285e:79d with SMTP id
 l1-20020a1fed01000000b004c0285e079dmr925546vkh.1.1707990146503; Thu, 15 Feb
 2024 01:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20240212171156.47293-1-irina.ryapolova@syntacore.com>
In-Reply-To: <20240212171156.47293-1-irina.ryapolova@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 19:42:00 +1000
Message-ID: <CAKmqyKPuwp9sssyQkV253AgjLS+Q7H=rkU8rokF1jGrVhhLvhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv/csr.c: Add functional of hvictl CSR
To: Irina Ryapolova <irina.ryapolova@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 13, 2024 at 3:13=E2=80=AFAM Irina Ryapolova
<irina.ryapolova@syntacore.com> wrote:
>
> CSR hvictl (Hypervisor Virtual Interrupt Control) provides further flexib=
ility
> for injecting interrupts into VS level in situations not fully supported =
by the
> facilities described thus far, but only with more active involvement of t=
he hypervisor.
> (See riscv-interrupts-1.0: Interrupts at VS level)
>
> Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
> ---
>  target/riscv/csr.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 674ea075a4..0c21145eaf 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3585,6 +3585,21 @@ static int read_hvictl(CPURISCVState *env, int csr=
no, target_ulong *val)
>  static int write_hvictl(CPURISCVState *env, int csrno, target_ulong val)
>  {
>      env->hvictl =3D val & HVICTL_VALID_MASK;
> +    if (env->hvictl & HVICTL_VTI)
> +    {
> +        uint32_t hviid =3D get_field(env->hvictl, HVICTL_IID);
> +        uint32_t hviprio =3D get_field(env->hvictl, HVICTL_IPRIO);
> +        /* the pair IID =3D 9, IPRIO =3D 0 generally to represent no int=
errupt in hvictl. */
> +        if (!(hviid =3D=3D IRQ_S_EXT && hviprio =3D=3D 0)) {
> +            uint64_t new_val =3D BIT(hviid) ;
> +             if (new_val & S_MODE_INTERRUPTS) {
> +                rmw_hvip64(env, csrno, NULL, new_val << 1, new_val << 1)=
;
> +            } else if (new_val & LOCAL_INTERRUPTS) {
> +                rmw_hvip64(env, csrno, NULL, new_val, new_val);

I'm not sure I follow what is happening here, the section in the spec
is tricky to comprehend.

Do you mind being a little more descriptive in the commit message as
to exactly what we are supporting here?

Alistair


> +            }
> +        }
> +    }
> +
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.25.1
>
>

