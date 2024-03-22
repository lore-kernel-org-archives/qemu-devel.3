Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C792C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 04:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnWoz-0004CU-JQ; Fri, 22 Mar 2024 00:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWoy-0004CH-Na; Fri, 22 Mar 2024 00:48:00 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWox-0003zh-6p; Fri, 22 Mar 2024 00:48:00 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7e057fb0b69so632347241.0; 
 Thu, 21 Mar 2024 21:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711082877; x=1711687677; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVno+Qx9Q6fGVNpivFvu8+0cdt5tYcT9JAZAUs1KlmY=;
 b=FoAvOgKcKrrWvbUrXGXXhWZDKCZVpXKhSe/h9A1+SxdF/LoXzv/6+vNw2vVY3ejNcH
 1189/MNoip06vEPGSYfLhtPO/U06uXHceoMtlnnTrbLnz+aJIGeZns5pPKdGmn0yCcH/
 gx5wxpMY8OCSbLyoUzBMUHshG8c23Zlzljaatog3IdxVs0uRX/vwSiav84cYdfLMgCVX
 2Uf2+AW0aUJbQzLYQc5spo88mEjE1OlrJS5cQihCqilN5ED3RwZJa+Y5Pjk81zWo/eu5
 ycCk0kuKPUeWh3HWD9acj7bU5HDwzwY6sazOQ/B9AUX1i6CnLCRWY9rv+9sUyOSQk6+q
 LF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711082877; x=1711687677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OVno+Qx9Q6fGVNpivFvu8+0cdt5tYcT9JAZAUs1KlmY=;
 b=lOPhdisID1qYyDej0nascp5sYxF5noz+zr+fiwEZnAf1JWofYZP28W0wuXoY2NyZOZ
 kgRS+br3ybooQWvXfPhopZNMLfoC7FmIh28oZMwwXxn6U1dsBC+abjBcLjmk9NJCh5oC
 29OkjrsurhWHx0QE1v1NZuo+Z4wy6h6DORtIUwlucIjtKYmp6s4ANf1E+ErzvHgOeuOa
 ZHT3gPTs+U6qrSXpEvUSJ7JEvtkw2LDrQ8UWfF/y23peXoODQ1l6BLWP9c4lNB/mDX80
 xPNxo1MyX20vYXGl6K1E9u7F8xan9vl96r4UOPycDf5Qds+ZntCAmu7yEF8zOz5dyhQ1
 TV9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6A2R3H3jhOQHfrm+oMGmhr6V4IAsDQ5vxU+FvKX8GP+eHLFDts32+JxVV/XE6up7r3Z1DCepKParAjIZbahwYUeGmqIs=
X-Gm-Message-State: AOJu0YzoHA2f6tfazpQwX+xcX8ouN27Pu+wV0XJTwGC+KtNK03x4is2y
 RqAOQ5tH6dVBhNQ6pZsjTmGUgYtBmnkXbnTbZQb4j5SgtViI7ApBmrP66W+58M4mJ4vE7McY1yU
 A3QBDb57vyJHH3F2Shp9dS3uliHU=
X-Google-Smtp-Source: AGHT+IHRCv8TGxuhG8EKCrW2ObdzTc2zwpH4JJdbPXlu7skIc2uUeQwYF0Fr2DnsK6fDHHd4O89C85A62eLJqzPK6qE=
X-Received: by 2002:a67:f2d3:0:b0:476:b40b:b7a with SMTP id
 a19-20020a67f2d3000000b00476b40b0b7amr1612920vsn.17.1711082877483; Thu, 21
 Mar 2024 21:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240314061510.9800-1-yongxuan.wang@sifive.com>
In-Reply-To: <20240314061510.9800-1-yongxuan.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Mar 2024 14:47:31 +1000
Message-ID: <CAKmqyKOJjYLuCRNMZxCCVMLL-+pHKp3YMqhcbNntomdGJ9fUwg@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

