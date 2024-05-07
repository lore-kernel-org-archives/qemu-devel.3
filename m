Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237C1C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HoW-0006X0-1q; Tue, 07 May 2024 06:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1s4HoL-0006Rn-Dl
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:12:40 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1s4HoG-0007cn-Rg
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:12:36 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6f04ec17bacso1225449a34.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715076747; x=1715681547; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4/GAPdJUfHnp48kN0aWhS7WR6PdArXN2IIWbN7coW0=;
 b=RnZLHtXY7nnYhaijyLXnbJUHzjGsHDlNFFXakI3/rCCoGEFgfpZt5YQIATxAmAQjtX
 98maJGCvk6FUZEIaLbSUysGWLCYRfm3cVFN9hMqsYcOthdckgF/lVL88jkrgtcy6EKS5
 QCQA5f5UTRYFXH38aEF4OKgaPiSwfJDAcRx88iufujhN/UNMuTNEmdi9mkvT8BOHC+f/
 kbhxp9AxntoHlZIexkYYXWSwRt3TZU1A3tB/ntMG2le20jS1aeLfdv+nwqpG1jvoqPWN
 U2Icuad37zw9yCfAumzG6Dv4igrzxiVqhi+PQDNsexoJ1RkR25qTtUX2iaQGy8er1Qwy
 wY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076747; x=1715681547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n4/GAPdJUfHnp48kN0aWhS7WR6PdArXN2IIWbN7coW0=;
 b=SFlj7+9utwof935v59HIciAhuoUxnxz/uLmCQDC25UOMQB0GwWMMsxFkFwdNheqd5g
 Z/V99s6RRYT0M3nkdmU6cMkjK9++rmNqbOetY8MyRX5UxWjvC5kO+0NQsdhE2tMTpwAT
 +hHN0i6kwBmpX6oJ9SVSfvVaDlLMmVQWbt2ZnNrVVvWESQMjyz/d9xJDzPj7opgE/Hu5
 /evDf1Qd+9YD2T+vE8vzoLxGVkrIpjxiXMVD2pHfQfEMoxFeC3M26LCLaxS+8WvMBcku
 4L510A5uCwGFMCUCtIZmL8E7Jhq5q/K8AAkVPibYauptn3REnIqVk2Up/4trzqYTnaoZ
 F68Q==
X-Gm-Message-State: AOJu0Yyl3+KMh6Ctw/z8lx5b0U3b7AKivVwJVxkMU+85/fK+ahJKJrl+
 oElHTu47lyIjLQeVULdQsyZhHKwH/vyuCasHHAYooAuNF1k8TGZbAwaFiRfcNtm1txAvDSgpmJS
 NAEUQACf1xols8bRKTj7VDS0AGnO7pJgIX3ZNjQ==
X-Google-Smtp-Source: AGHT+IGzBoELkMyDthtPioUrbGr0WU7/8LaTFS3isC/sBOp7EiPzsaDUZt98yiaSPIZGmVYlaLWNvCumtx9/AWkQQ9U=
X-Received: by 2002:a05:6870:32d3:b0:23f:6c3d:c789 with SMTP id
 r19-20020a05687032d300b0023f6c3dc789mr8380041oac.30.1715076746856; Tue, 07
 May 2024 03:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240415065245.25455-1-yongxuan.wang@sifive.com>
 <CAKmqyKO3qj9k74RBp+KCGxgPR_=ZGCSzdUDdGrQj9TPJCUD1Nw@mail.gmail.com>
In-Reply-To: <CAKmqyKO3qj9k74RBp+KCGxgPR_=ZGCSzdUDdGrQj9TPJCUD1Nw@mail.gmail.com>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Tue, 7 May 2024 18:12:16 +0800
Message-ID: <CAMWQL2h3+1rkYMusg0Mzgu6NZy4gYLa75+nGWRVzjF83jCukzA@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv/kvm.c: Fix the hart bit setting of AIA
To: Alistair Francis <alistair23@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-ot1-x32e.google.com
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

Hi Alistair,

On Mon, Apr 29, 2024 at 11:25=E2=80=AFAM Alistair Francis <alistair23@gmail=
.com> wrote:
>
> On Mon, Apr 15, 2024 at 4:53=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sif=
ive.com> wrote:
> >
> > The hart bit setting is different with Linux AIA driver[1] when the num=
ber
> > of hart is power of 2. For example, when the guest has 4 harts, the
> > estimated result of AIA driver is 2, whereas we pass 3 to RISC-V/KVM. S=
ince
> > only 2 bits are needed to represent 4 harts, update the formula to get =
the
> > accurate result.
>
> I don't really follow this.
>
> Do you mind re-wording it to talk about what the specification says?
> Not what Linux does.
>

Sure!

> >
> > [1] https://lore.kernel.org/all/20240307140307.646078-1-apatel@ventanam=
icro.com/
> >
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > ---
> >  target/riscv/kvm/kvm-cpu.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > index 6a6c6cae80f1..388c4ddaa145 100644
> > --- a/target/riscv/kvm/kvm-cpu.c
> > +++ b/target/riscv/kvm/kvm-cpu.c
> > @@ -1642,7 +1642,14 @@ void kvm_riscv_aia_create(MachineState *machine,=
 uint64_t group_shift,
> >          }
> >      }
> >
> > -    hart_bits =3D find_last_bit(&max_hart_per_socket, BITS_PER_LONG) +=
 1;
> > +
> > +    if (max_hart_per_socket > 1) {
> > +        max_hart_per_socket--;
>
> Assuming there are an even number of cores (which there usually are)
> won't this always result in a
>
> > +        hart_bits =3D find_last_bit(&max_hart_per_socket, BITS_PER_LON=
G) + 1;
>
> 1 being returned by find_last_bit()?
>

find_last_bit() returns the position of the leftmost set bit. The
output will not be 1 when the given input is an odd number.

Regards,
Yong-Xuan


> Alistair
>
> > +    } else {
> > +        hart_bits =3D 0;
> > +    }
> > +
> >      ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> >                              KVM_DEV_RISCV_AIA_CONFIG_HART_BITS,
> >                              &hart_bits, true, NULL);
> > --
> > 2.17.1
> >
> >

