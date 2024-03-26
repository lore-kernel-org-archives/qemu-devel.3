Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE28C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 04:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1royqw-00040s-4B; Tue, 26 Mar 2024 00:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1royqu-00040g-5D; Tue, 26 Mar 2024 00:56:00 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1royqp-0001FF-H1; Tue, 26 Mar 2024 00:55:59 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d49f7e5c2cso68258321fa.2; 
 Mon, 25 Mar 2024 21:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711428951; x=1712033751; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rS+wzdQT5x7x5iCFTR/am43NuWsKoxOMfZ5wiLYQm/w=;
 b=adxK4954pmGN01Hp2Qv4o276wCYLdPayDTo6GKj6Kbmk5cbVDYO6cTFLLhML5cdKh5
 nolyIFEd2nREKfaLqHCcjcgbp5KD7GPeA0PHeWjE5oGrh6cHd3hs6HFplo+XbMcQJvNX
 NfSNpsoa0mYrd8mar1RqgPV5UHAGrn+0MLVDVGq8/r6YLFXYFmOr0RaOPA/n0YgN4xQr
 yAh0+15eXf6EG1SHuIo+xdlezv2EkQC4d2zSpuup9aHpDOKRKBn6xnQiXsK4PJ5lcZWk
 0hlnWt4T1XitqrDhDksxw9rzqnn3Di8HAinDDTnJ1emkKFmi4QmB8/nIIl/zJILFkFG6
 sCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711428951; x=1712033751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rS+wzdQT5x7x5iCFTR/am43NuWsKoxOMfZ5wiLYQm/w=;
 b=P7/gvDEAjIW4PZmU+mu14YNcj1v/1+I1HZFPu6ds3OsJqu1Iuhp7C7HlYoNjQip54L
 ThUUXyeeQQ4GdzSa+vgd04uFgxRaQNXqov4hU8xNwqcqg/0q1C6/cPzJkNpMrZuWRLlT
 rcpcMXyPoVy6v3SQOppt0SOK2yA824zTR36DXKM02F98L4/AUSgqNCxMt0orqffWyNbW
 5ZgsUTHPs/jO4cRuivJOnDqZIybSa+1klKa8jWybIfGaa8LuVaJ+7Jp0nAVN8Z8FgprX
 ur6eHfcNvO1Uq2TVhnZN5LeVRSnjYO60n5oYO1p+90/c/Ep2Vrxeu42amnO/hGEl7ek3
 00FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxPZSL3+ZtRJnmkZIYzAivA8OmXSuQE4z6jWhnR9xcFfozr8Wo57RwUmhezUhsBDauE0VOh4kYtzPjdmb0X1hABpuEXRoAEryTzOI4xuciCda3FCnOrJW5a2kxBQ==
X-Gm-Message-State: AOJu0Yz3eoiIOoYb1SPJ44M5iKaH8E8qRgcGtALAjojhnS5+3nvYdMxW
 0AbjvFXwD9LyyrqAB7cmFubgd0bDp0blmxLROMSUZ8g0CS/3ly7Dgg0MVe81zCt//plX3pUGjxa
 /73t9NevUQYndqd+I5rQm3zqmKVE=
X-Google-Smtp-Source: AGHT+IHg1fw5vhSuJn7HdOWQlH3hc7vYnN35kbyA7PRBkX4/Zr6q2PepFrLV+EimGczcdzc8lyWI9flCPoJnO6xHESc=
X-Received: by 2002:a2e:b704:0:b0:2d3:f3fe:48ac with SMTP id
 j4-20020a2eb704000000b002d3f3fe48acmr5170869ljo.27.1711428951102; Mon, 25 Mar
 2024 21:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <b7fff1e9-f2b3-4a45-8966-1dbd76263457@ventanamicro.com>
 <20240325130116.13194-1-alexei.filippov@syntacore.com>
In-Reply-To: <20240325130116.13194-1-alexei.filippov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 Mar 2024 14:54:55 +1000
Message-ID: <CAKmqyKNkyxx9YV5ahb-VTO=4+mtu-1D2nMvyP6=-MpZ6KGXomw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi()
 fail with vendor-specific SBI
To: Alexei Filippov <alexei.filippov@syntacore.com>
Cc: dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 apatel@ventanamicro.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alistair23@gmail.com; helo=mail-lj1-x231.google.com
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

On Mon, Mar 25, 2024 at 11:46=E2=80=AFPM Alexei Filippov
<alexei.filippov@syntacore.com> wrote:
>
> kvm_riscv_handle_sbi() may return not supported return code to not trigge=
r
> qemu abort with vendor-specific sbi.
>
> Added SBI related return code's defines.
>
> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> Fixes: 4eb47125 ("target/riscv: Handle KVM_EXIT_RISCV_SBI exit")
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> Changes since v1:
>         -Add Fixes and Revied-by lines.
>  target/riscv/kvm/kvm-cpu.c         |  5 +++--
>  target/riscv/sbi_ecall_interface.h | 11 +++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6a6c6cae80..a4f84ad950 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1404,7 +1404,7 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struc=
t kvm_run *run)
>          if (ret =3D=3D sizeof(ch)) {
>              run->riscv_sbi.ret[0] =3D ch;
>          } else {
> -            run->riscv_sbi.ret[0] =3D -1;
> +            run->riscv_sbi.ret[0] =3D SBI_ERR_FAILURE;
>          }
>          ret =3D 0;
>          break;
> @@ -1412,7 +1412,8 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struc=
t kvm_run *run)
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: un-handled SBI EXIT, specific reasons is %lu\=
n",
>                        __func__, run->riscv_sbi.extension_id);
> -        ret =3D -1;
> +        run->riscv_sbi.ret[0] =3D SBI_ERR_NOT_SUPPORTED;
> +        ret =3D 0;
>          break;
>      }
>      return ret;
> diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_=
interface.h
> index 43899d08f6..0279e92a36 100644
> --- a/target/riscv/sbi_ecall_interface.h
> +++ b/target/riscv/sbi_ecall_interface.h
> @@ -69,4 +69,15 @@
>  #define SBI_EXT_VENDOR_END              0x09FFFFFF
>  /* clang-format on */
>
> +/* SBI return error codes */
> +#define SBI_SUCCESS                  0
> +#define SBI_ERR_FAILURE             -1
> +#define SBI_ERR_NOT_SUPPORTED       -2
> +#define SBI_ERR_INVALID_PARAM       -3
> +#define SBI_ERR_DENIED              -4
> +#define SBI_ERR_INVALID_ADDRESS     -5
> +#define SBI_ERR_ALREADY_AVAILABLE   -6
> +#define SBI_ERR_ALREADY_STARTED     -7
> +#define SBI_ERR_ALREADY_STOPPED     -8
> +
>  #endif
> --
> 2.34.1
>
>

