Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A792C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 04:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnWnZ-00039C-7U; Fri, 22 Mar 2024 00:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWnW-00037N-85; Fri, 22 Mar 2024 00:46:30 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWnU-0003r5-PC; Fri, 22 Mar 2024 00:46:30 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4760fe9c282so608111137.3; 
 Thu, 21 Mar 2024 21:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711082787; x=1711687587; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nxpx17JxSzUsjFIqtx9TJGsgHKT6l5JJuhit24MWsLA=;
 b=TE2o2DlwiNklKwvmTD/VHFhbjBX5X1vf5V0LR4Qt5439NYdCiyGsAi4IzTjXBuYKCr
 +rhv3Dx8/GlT+jWb3/s/2Nz5S9zm9xwtbWgRxbFO42B9wWrchCXa6h7wDhOJamhwdVXw
 Cde5dgxHS9hLSAxLPn7+vtEQL+jcS8JdtySH5id4Sfdsp/FM+MwEoI26dRWoxIiarPQN
 W8Y4zRsojUOm7PpyhrGXlCiMlV0u47Kqz74OEqCmzkb8bOxrwWxTYYaXLZ2zhiY4mgOJ
 LAJGI9Jqwk7pwXpMixifi4tsGID6THC3u+Sn8nz9yMP072o2Cpny1NBLftYP5VT8LPJO
 K2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711082787; x=1711687587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nxpx17JxSzUsjFIqtx9TJGsgHKT6l5JJuhit24MWsLA=;
 b=iNk46VXw0TX8OK6Zv3pOgFr8wLsgsVaPfJg78H7j9TFh9/TF0uha5gGPsR8hQFhnzZ
 ZscplHF7cpGHDXJqJ+EDnVFt0KMmDK9uijVjeF3Uo+OmCstI8SnlkpCOBdVya6sTIENC
 q/OL0QR4p3WVsQuSMx4w1MibtwndWD9PMIYnfLP+A049pRCV8Qgg133z5yBnzty+8fpN
 EqB8ZakCwDvSOXR4e45nhPuN7dENdL0ClbsFrn3h4u9HL7aEXPx1ZmAOonz43EEvJC+o
 o9Yd+w6050mYEcjYKhQkS7J4xIfD0M59B83LFP0DfJHYnHhyAF15SuQUocodukAzHiCP
 nMzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg/ewcOJ5xnnC0d8Hw/Ua66ohILUJmRzWE0JnwM6y4gLD5EyOAsUak6QEZ9SOM9re2DJeBLbkadSZUYs/hltTCEQVPVxY=
X-Gm-Message-State: AOJu0YwVqiJu+eFHt36VRCQ8DoKdphjYFqKWfKzxSvFCkt/zjEoAgwE0
 /hXz7uDQxX0RraJVdAnXviR11NDxHPtFTG0wnKex+lG6nos/xrZjWIq4ARZ4Z94aTvVDGXKmCcP
 et/RzTkbfEvKB0QijeR6KVcgfncY=
X-Google-Smtp-Source: AGHT+IEil8TuOBsExlwZj6uaQTxz6YnbbmZHZlmNB6GVayaceulyjOlP5gjIStXmt0YiVz9MPx9JtiGYsdb8/GaKhsA=
X-Received: by 2002:a05:6102:290c:b0:473:1582:eea0 with SMTP id
 cz12-20020a056102290c00b004731582eea0mr1855147vsb.20.1711082787370; Thu, 21
 Mar 2024 21:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240314061510.9800-1-yongxuan.wang@sifive.com>
In-Reply-To: <20240314061510.9800-1-yongxuan.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Mar 2024 14:46:01 +1000
Message-ID: <CAKmqyKNxgpcwpHn2cEXbLCZaAXE+zzCbdut9W4z6rstcUbY+vg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/riscv/kvm: fix timebase-frequency when
 using KVM acceleration
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Thu, Mar 14, 2024 at 4:17=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifiv=
e.com> wrote:
>
> The timebase-frequency of guest OS should be the same with host
> machine. The timebase-frequency value in DTS should be got from
> hypervisor when using KVM acceleration.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
> Changelog
> v2:
> - update the function definition
> - restructure if-else statement
> ---
>  hw/riscv/virt.c              | 2 ++
>  target/riscv/kvm/kvm-cpu.c   | 9 +++++++++
>  target/riscv/kvm/kvm_riscv.h | 1 +
>  3 files changed, 12 insertions(+)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a094af97c32a..533b17799581 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -711,6 +711,8 @@ static void create_fdt_sockets(RISCVVirtState *s, con=
st MemMapEntry *memmap,
>
>      qemu_fdt_add_subnode(ms->fdt, "/cpus");
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
> +                          kvm_enabled() ?
> +                          kvm_riscv_get_timebase_frequency(first_cpu) :
>                            RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index c7afdb1e81b7..bbb115eaa867 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -739,6 +739,15 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
>      env->kvm_timer_dirty =3D false;
>  }
>
> +uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs)
> +{
> +    uint64_t reg;
> +
> +    KVM_RISCV_GET_TIMER(cs, frequency, reg);
> +
> +    return reg;
> +}
> +
>  static int kvm_riscv_get_regs_vector(CPUState *cs)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index 4bd98fddc776..58518988681d 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -28,5 +28,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64=
_t group_shift,
>  void riscv_kvm_aplic_request(void *opaque, int irq, int level);
>  int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
>  void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
> +uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs);
>
>  #endif
> --
> 2.17.1
>
>

