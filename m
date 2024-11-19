Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052A9D60D05
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 01:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDCsP-00056i-MF; Mon, 18 Nov 2024 20:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDCsN-00055x-8s; Mon, 18 Nov 2024 20:17:55 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDCsL-0003Zz-J8; Mon, 18 Nov 2024 20:17:55 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5139cd01814so170943e0c.0; 
 Mon, 18 Nov 2024 17:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731979072; x=1732583872; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ETPuDfp4+qKnMAnwy5QW57rWJiIu9lvPi1Nj5PKfhC0=;
 b=BeJhbuScdGG17Eu4RdCA6LDpBet8xAvHH/d3iCelLD1iyHj7/qd6N0Z9v7hCcXl9vj
 IkQaFlAXUiyIzPyhkWJ2uTBOSQicHPEc0ABi6w97I3tfPjwj2Wl1VVysgTYYOP7raZIb
 Zx+eAGsJEZWxSeRdDakYlCZ3BFQIz2dG8gXHXqAapxa1tvupzXUcbdAZ9MzPWhHWT7tK
 o33x0FD73pye1J45IPGtmcwbfj7vfxcix7L7PddBXvvTzR+GRWy5uGTAokGbU25p08Ym
 3SEbs6erKFlB20gZFRQnone+Q3r8tUNEFlPRZ1qnGNyKIBEYnhVawvrUeEphNFVVrXgb
 zQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731979072; x=1732583872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETPuDfp4+qKnMAnwy5QW57rWJiIu9lvPi1Nj5PKfhC0=;
 b=dzD8bBTU8s8fhtNZwcLc4pKdNmxKj+ZcN2iGhatWqmluS6lgbXpiIAq85YkNUJiXQ/
 Fu3+HGYh1BY2OfjY7AXfnT31BxZAciF+Wx2wubvB15T3i5kqHcoCfGMkSgKmJx0CyJfN
 7a8uj0Z2KZt727JWbqcw77YHyXkz+9ncirQbGPNwUvrgXRL7bKa1Nx2h8xxKmhckf2V0
 ay8FddZg8ghrD/i+EiTCoA0I4lEP2+FhNRui+TVC917T5IrqfxRBAfdLijqj+KgohUBn
 5YGMwF/Pl+0OQjyPmwCHEFH6r9XMssKbtEA2Vyk6bnJ2q6gUc9g2ger/sMQFbznhUYiJ
 0ZWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOcFz2EQqG6e1LtD4rWYVvEHe5wdKOzcC6ERCo6y51+Wpx2h71L9IoTjhrFtKNXf8cI0pXn6s6Ja30@nongnu.org
X-Gm-Message-State: AOJu0Yz5zTK4fnxABiA3G+vnhkS6thVreauyGgxmY7wa6ipKqHouWVds
 NHx8/7y3rIuSIfT3wIwq0oOJhnfEK5aeTYeu1YrksTOUdApV0WGfx0yM+bRrQRgqiWte5xf7jPp
 2dxNLMiZpAXM/A9AdZxIsVOqy+kU=
X-Google-Smtp-Source: AGHT+IFH61fQW/8NdQVHQYAD/olk+GjS9RGeTOPuLfAYI7zzoyuvkg0SNdWkdZyLoEr2hFXops3LApT6Soi3zALeVrY=
X-Received: by 2002:a05:6122:2027:b0:50d:83e1:94fb with SMTP id
 71dfb90a1353d-514786d4cfemr11261818e0c.12.1731979071753; Mon, 18 Nov 2024
 17:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20241029085349.30412-1-yongxuan.wang@sifive.com>
In-Reply-To: <20241029085349.30412-1-yongxuan.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 11:17:24 +1000
Message-ID: <CAKmqyKNgfcqnoQkn+jUo_tyDEk4RQATsWGLDYkDOQTNax5vZsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hw/intc/riscv_aplic: Fix APLIC in_clrip and
 clripnum write emulation
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Tue, Oct 29, 2024 at 6:54=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifiv=
e.com> wrote:
>
> In the section "4.7 Precise effects on interrupt-pending bits"
> of the RISC-V AIA specification defines that:
>
> "If the source mode is Level1 or Level0 and the interrupt domain
> is configured in MSI delivery mode (domaincfg.DM =3D 1):
> The pending bit is cleared whenever the rectified input value is
> low, when the interrupt is forwarded by MSI, or by a relevant
> write to an in_clrip register or to clripnum."
>
> Update the riscv_aplic_set_pending() to match the spec.
>
> Fixes: bf31cf06eb ("hw/intc/riscv_aplic: Fix setipnum_le write emulation =
for APLIC MSI-mode")
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> v2:
> - add fixes tag (Daniel)
> - follow the suggestion from https://lore.kernel.org/kvm/CAAhSdy3NmwbHY9Q=
ef9LUeXfr0iE7wC-u0d_fHzC47PXk-MzmRg@mail.gmail.com/
>   (Anup)
> ---
>  hw/intc/riscv_aplic.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 4a262c82f078..74c82a841101 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -248,9 +248,12 @@ static void riscv_aplic_set_pending(RISCVAPLICState =
*aplic,
>
>      if ((sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
>          (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW)) {
> -        if (!aplic->msimode || (aplic->msimode && !pending)) {
> +        if (!aplic->msimode) {
>              return;
>          }
> +        if (aplic->msimode && !pending) {
> +            goto noskip_write_pending;
> +        }
>          if ((aplic->state[irq] & APLIC_ISTATE_INPUT) &&
>              (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW)) {
>              return;
> @@ -261,6 +264,7 @@ static void riscv_aplic_set_pending(RISCVAPLICState *=
aplic,
>          }
>      }
>
> +noskip_write_pending:
>      riscv_aplic_set_pending_raw(aplic, irq, pending);
>  }
>
> --
> 2.17.1
>
>

