Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAE9C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 03:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGr7p-00077g-IC; Sun, 18 May 2025 23:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGr7o-000778-3o; Sun, 18 May 2025 23:25:12 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGr7k-0007V1-85; Sun, 18 May 2025 23:25:11 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-87bf5c80f56so1452706241.2; 
 Sun, 18 May 2025 20:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747625106; x=1748229906; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8CE9Or7O+vz8tkllB6X9o67rFt86YkC2U/ryCCZRvM=;
 b=imnIpXXkfdYOL6roWL+/TAI3eVxOpv3QDzvAzTvYTNoeDeOQNGeGaKKVVL0oo8eNPX
 uVBM4aeM9OXyApVw2+xu1HCyLV1uuQfWsOyUHAauVeCMQkeiVY+anmcZzRS1FqMFJR7n
 AaeGihAT6/OK++J1vAkH9OdH4WPV+q5nKs5Yi+jhXzT6SgqE3d+YwKYJ/eAR/qh98Ha1
 9k6b1770XurwkH3ft3xKufHvZmN8BmGIHXQSZkVjzNsFb800LGtrloGgZKpB85pBt8or
 IdwAGwunnoVMsVrIxSmjIyN6uSq/bNKRl8z8NERqMw9h4Qc8UPvNTE+cF+mSoJBPCaCL
 XhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747625106; x=1748229906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8CE9Or7O+vz8tkllB6X9o67rFt86YkC2U/ryCCZRvM=;
 b=pcd3JvVWYNzimxcfNSFkMnsqqHXVbX8BlFc1/cMlFLg3kPPocvZdQugDSmvL6ifmzJ
 HZQd4FVi2afGSid4hXeo16Cx4eQVxl0C+B+i2g+GDn1I83cyTJMPqwVx3IZHmbvSUf7B
 iw6/ghznTxsyMDt9VVYWT9bV+c5A0GhMyH/dW7+qK0bE0RvmvT2YuJZyzRkMwCEdXmzU
 kwZPIPP2YcUW+fl6Ujno6crzBLJGjSPVM93gKUNxcmB0twereH5j+qcZ66BKUyX9161i
 5SJ7OP1CBOC8TPjeJ/LXm/wReCmpSajl5iIvc9dh//JpPW8b0vIiNHiKbr6PKbm7pqma
 V2Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjp2uZ44NkFCaVLK0PFzRcjfQLuFOdE5iqrueskmQtkFT6VQH0wkU65804Rhs1meHOMgPG+KAOhZbS@nongnu.org
X-Gm-Message-State: AOJu0YyazMP6R5HWRJgzoZ2NucPZwtYTANwXpsTRkdORvrXpNjCOJm7e
 yMcu3SCmJyVMs8fV0urzHCGX6Vl/56KLflc5HJSBioOuXqSRxUXXvE4/JMaAqchHvxJdvobvxBc
 no0VlhgfChmo0XkGcjf2wUuizFMNBTyc=
X-Gm-Gg: ASbGncu7O1jGk/5n/VZArIMTKxBJGGFLbfcfSE91ZFQirAUmSD3RnV/Cx4VUsBixwBj
 8xV4Puav4uO1Ga+eIXl1ajtmnSLJIIVGgPDgjsEUCLfvjVWUgish1N8Y4iCS3+1M1W+nALZxa3O
 Qecw+y6rctLvbFXcgeTu+S4TVURqPGQWQitcT8sfMPd+5/ybFlrBRrc4ETutNty8DsBIF23ImT7
 A==
X-Google-Smtp-Source: AGHT+IHBbzN+zqF50I66dPGdaXMjERnuZRaRXsBEH2pRmU37LnvOGM5s6lSdAsQS/wA4z8SSMm47PlJOY5yDPSgFnJw=
X-Received: by 2002:a05:6102:1514:b0:4bb:e36f:6a35 with SMTP id
 ada2fe7eead31-4dfa6bd805bmr10325499137.14.1747625106491; Sun, 18 May 2025
 20:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250428085632.3102-1-mengzhuo@iscas.ac.cn>
In-Reply-To: <20250428085632.3102-1-mengzhuo@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 May 2025 13:24:39 +1000
X-Gm-Features: AX0GCFu4_fZRcSz5ZGSczjma6QtvrgKv0Y_A0quh2lSWBxrN2-q6_LQk4_SU86A
Message-ID: <CAKmqyKPMwvDV=VYSkSMDC90jqQZ5FynRns8yttyrbJEZDeK2hA@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv/kvm: add satp mode for host cpu
To: Meng Zhuo <mengzhuo@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Mon, Apr 28, 2025 at 6:57=E2=80=AFPM Meng Zhuo <mengzhuo@iscas.ac.cn> wr=
ote:
>
> This patch adds host satp mode while kvm/host cpu satp mode is not
> set.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2931
> Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>

Can you please rebase this on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c         |  3 +--
>  target/riscv/cpu.h         |  1 +
>  target/riscv/kvm/kvm-cpu.c | 20 +++++++++++++++++++-
>  3 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2b830b3317..98f78886e6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -434,8 +434,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_=
32_bit)
>      g_assert_not_reached();
>  }
>
> -static void set_satp_mode_max_supported(RISCVCPU *cpu,
> -                                        uint8_t satp_mode)
> +void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode)
>  {
>      bool rv32 =3D riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32;
>      const bool *valid_vm =3D rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 167909c89b..44318d2e97 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -916,6 +916,7 @@ char *riscv_cpu_get_name(RISCVCPU *cpu);
>
>  void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>  void riscv_add_satp_mode_properties(Object *obj);
> +void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode);
>  bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
>
>  /* CSR function table */
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 5315134e08..8f465119f5 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -953,6 +953,23 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScratc=
hCPU *scratch)
>      close(scratch->kvmfd);
>  }
>
> +static void kvm_riscv_init_satp_mode(RISCVCPU *cpu, KVMScratchCPU *kvmcp=
u)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +    struct kvm_one_reg reg;
> +    int ret;
> +    uint64_t val;
> +
> +    reg.id =3D RISCV_CONFIG_REG(env, satp_mode);
> +    reg.addr =3D (uint64_t)&val;
> +    ret =3D ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> +    if (ret !=3D 0) {
> +        error_report("Unable to retrieve satp from host, error %d", ret)=
;
> +    }
> +
> +    set_satp_mode_max_supported(cpu, val);
> +}
> +
>  static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvm=
cpu)
>  {
>      CPURISCVState *env =3D &cpu->env;
> @@ -1212,6 +1229,7 @@ static void riscv_init_kvm_registers(Object *cpu_ob=
j)
>      kvm_riscv_init_machine_ids(cpu, &kvmcpu);
>      kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
>      kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
> +    kvm_riscv_init_satp_mode(cpu, &kvmcpu);
>
>      kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
>  }
> @@ -1891,7 +1909,7 @@ static bool kvm_cpu_realize(CPUState *cs, Error **e=
rrp)
>          }
>      }
>
> -   return true;
> +    return true;
>  }
>
>  void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
> --
> 2.39.5
>
>

