Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5864C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HeI-0001jc-Ti; Sun, 28 Apr 2024 23:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1HeC-0001eH-L3; Sun, 28 Apr 2024 23:25:44 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1He9-0004I4-KE; Sun, 28 Apr 2024 23:25:44 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-479c39b78dbso1311639137.2; 
 Sun, 28 Apr 2024 20:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714361139; x=1714965939; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYhQAU/Afxth6vnbLdTZgBMdxkrplsa+qMwLgMZc9wY=;
 b=SGxlYe4esFDDMG/pD8ro7WoU2CTLePivjF4GfOICtwnqz21Ycc4Off70qkN6novu30
 01KcnvRkdI3S/O+mWySksOfSRcriZGM6uWtc1jGgfQoWELLLrMAGjruGc7Vv00WOJHaT
 I6nbMVogce75PAKMiGBpsDMKg63tZhN4mHSgcmdFZ33GQjOPyqOHiR0uQVr1lCs/RVW4
 A+8+CCIKQHOwmNSS1x1JTZu8dgvrMhHt6gI+AckPapRQ95NAAZlKudGVCecJGx5ZNgkW
 1cgezuCpLpj8jvU3/Sm46HhDu0/E6W5yz+KDjL+q+yPvPQ91UbBqG1f/UQfeYyxzG3b1
 +E9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361139; x=1714965939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FYhQAU/Afxth6vnbLdTZgBMdxkrplsa+qMwLgMZc9wY=;
 b=HWVNdZIpw8rbriAwWAKXpkEUr1EFxcLmpNOiGBgynR57n91F8TkC2tPEoarnyedy9u
 VTdsJkxf3eTHP7+EJUKYgh7IsGwg4aZUQC6ZFXbB/bqwXEnV1MFn7nVJqNYcLekBD3z8
 8AhgFGsJKSYs0FO+JDgWD4ls5djnHP/CSRv8lWEkvHl3Qf8Lc2M605NS/BoxhliWDcfE
 CPpSs/jy9w/558c7DgpM1KOARlPxguYQjtUW++NgDqw4Gz3FPimtQaN+s+MuVHaOcmRE
 pdX9oAmEBqYzreLAfjWItZU6U87RExR+pP/JMt5nSUdr7lWeN7vBkQDRcuQI2LU/4wYD
 08rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm8edzw8BMR1+RigH5+LoZQ4eC9AEN6t2vmJY1FU6VoNIzeBQxhKYyeBT0Aa8Ubz3fXG8WZi7xSP56KEQrpKRPO+cxVbU=
X-Gm-Message-State: AOJu0YyV96PgfzywBIEm89n9FFSW4oi/aZnk/UXZeDLBvcLIzf61Sj/o
 BUghNCSBxwbQqRyzb95Fnlsfhcq3FlxU4DOZJWOpYambD/z+NHjh69mQomKzcfKipYevAm07des
 seibmp/whP3yZd8hZmHcMxcWizUg=
X-Google-Smtp-Source: AGHT+IEEmfZlv15C+AOu2umMqydhnt3cOdgCumrR46nNtUoVqYzp+qhF4ufizwTdhRFGMAw66fEX7NczpCXHoLwTn/M=
X-Received: by 2002:a67:ee90:0:b0:47b:ba81:5f93 with SMTP id
 n16-20020a67ee90000000b0047bba815f93mr9520531vsp.11.1714361138817; Sun, 28
 Apr 2024 20:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240415065245.25455-1-yongxuan.wang@sifive.com>
In-Reply-To: <20240415065245.25455-1-yongxuan.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:25:11 +1000
Message-ID: <CAKmqyKO3qj9k74RBp+KCGxgPR_=ZGCSzdUDdGrQj9TPJCUD1Nw@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv/kvm.c: Fix the hart bit setting of AIA
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Mon, Apr 15, 2024 at 4:53=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifiv=
e.com> wrote:
>
> The hart bit setting is different with Linux AIA driver[1] when the numbe=
r
> of hart is power of 2. For example, when the guest has 4 harts, the
> estimated result of AIA driver is 2, whereas we pass 3 to RISC-V/KVM. Sin=
ce
> only 2 bits are needed to represent 4 harts, update the formula to get th=
e
> accurate result.

I don't really follow this.

Do you mind re-wording it to talk about what the specification says?
Not what Linux does.

>
> [1] https://lore.kernel.org/all/20240307140307.646078-1-apatel@ventanamic=
ro.com/
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6a6c6cae80f1..388c4ddaa145 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1642,7 +1642,14 @@ void kvm_riscv_aia_create(MachineState *machine, u=
int64_t group_shift,
>          }
>      }
>
> -    hart_bits =3D find_last_bit(&max_hart_per_socket, BITS_PER_LONG) + 1=
;
> +
> +    if (max_hart_per_socket > 1) {
> +        max_hart_per_socket--;

Assuming there are an even number of cores (which there usually are)
won't this always result in a

> +        hart_bits =3D find_last_bit(&max_hart_per_socket, BITS_PER_LONG)=
 + 1;

1 being returned by find_last_bit()?

Alistair

> +    } else {
> +        hart_bits =3D 0;
> +    }
> +
>      ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
>                              KVM_DEV_RISCV_AIA_CONFIG_HART_BITS,
>                              &hart_bits, true, NULL);
> --
> 2.17.1
>
>

