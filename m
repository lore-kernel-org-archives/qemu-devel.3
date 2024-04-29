Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005CFC10F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1GgQ-0000zv-BQ; Sun, 28 Apr 2024 22:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1GgO-0000zI-E5; Sun, 28 Apr 2024 22:23:56 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1GgM-0001t7-Iv; Sun, 28 Apr 2024 22:23:56 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-47bfea1df1dso1403108137.0; 
 Sun, 28 Apr 2024 19:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714357433; x=1714962233; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wM0MbP77v33yqkDrZ9W60qg0Q2VfoxJgdhkj1wqk0es=;
 b=hO0jiZMQio9aX1nwuaROGt6EJqbr0KiA0q0FkArK4tc90unz5IBNBFniQcS7MI26IG
 /I5CIglu/BxQ2kQXu2cZj53XbnDtGCSK9ThNbXai2vMIaZXlE2Z1rIoFTBhAq+3NyvsV
 km8GFk5BLUTRvKGHdZZrjpMPExQJAGEraa9UekKsw3FmapM2A+U+bjanroNv5DHBVVd/
 n1Fw8SioSX5tf+J4/qkYUPR6gxSD+7Bvkd5iLT2SrMlqHOt9sdejsCoBX3xdtLHPPMww
 X7WrNlpnmDHQj28UqWPiaBxceieiCmHhrcBesfdlNSd22Io1B+0HKRsramolMffUyA9B
 /9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714357433; x=1714962233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wM0MbP77v33yqkDrZ9W60qg0Q2VfoxJgdhkj1wqk0es=;
 b=rTc0UM9xu0/6FKUEfEW+SJEuZ/DvxJAAbobm0WVZHLRYuIHyAf/37B00NZM57o5rCD
 JpmrVSLXTCJEYOyXGb0QJHB0smKonnhhAWO5D8xdJNM9cjIlk65oO36Ta6dXell/QN0l
 nIwj9xmqTZOrqFrIDrNUpTwWhcC1VF337VNyRxFIGKooTjfrYgSZkGx1InwXg6IDptWT
 Po8vVcwtsix3w/6xmhdAJmFP2p2uyOH0cRh6btAgtFUBUf6FBE+BhTwOUpvdZljlkyiR
 RPqeFqS8d+OsDuVXz6f/GLyAia3KfJ4vOouj3c74HdwKUymsc33RTHc9+W7GU0r0Xnyc
 e4Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoIYQ3Vap5zwozeM4P9bK626K+Z0CzfykEkTwuaLoPfmxXSdSBth6KcWoSieW71x64Mo9OwUePHN1TKKBWFumcy1MmEoM=
X-Gm-Message-State: AOJu0YwPATK2ZC6holXNOJcS0r/KrhZtytcwX76ebKT5dxjdx3pZ3OSS
 vsfWlSVUM21KtpMBD4tCMkTL6roASLHZtoRDmHNt0Xh0KAMTLnKy9qMqtlzm+kD7qMN/Osz2vIW
 98xCBio4PYkugiI20R4exd8cckPs=
X-Google-Smtp-Source: AGHT+IE5rkTry+DLulM/Rl4nnQEfRyQshE+KppeYDqv9pTE0h0SdTd+yYTXZ8H6SQQIPDW9tba2VhxhFSyHSCY/s4f0=
X-Received: by 2002:a67:f644:0:b0:47c:2a70:422a with SMTP id
 u4-20020a67f644000000b0047c2a70422amr7920289vso.6.1714357431663; Sun, 28 Apr
 2024 19:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240425155012.581366-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240425155012.581366-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 12:23:25 +1000
Message-ID: <CAKmqyKMgZ7Kz=gi8jUn1aQpsZV0PvP+sDfzXmmjh8w7B4ZxvDA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: implement SBI debug console (DBCN) calls
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
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

On Fri, Apr 26, 2024 at 1:51=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> SBI defines a Debug Console extension "DBCN" that will, in time, replace
> the legacy console putchar and getchar SBI extensions.
>
> The appeal of the DBCN extension is that it allows multiple bytes to be
> read/written in the SBI console in a single SBI call.
>
> As far as KVM goes, the DBCN calls are forwarded by an in-kernel KVM
> module to userspace. But this will only happens if the KVM module
> actually supports this SBI extension and we activate it.
>
> We'll check for DBCN support during init time, checking if get-reg-list
> is advertising KVM_RISCV_SBI_EXT_DBCN. In that case, we'll enable it via
> kvm_set_one_reg() during kvm_arch_init_vcpu().
>
> Finally, change kvm_riscv_handle_sbi() to handle the incoming calls for
> SBI_EXT_DBCN, reading and writing as required.
>
> A simple KVM guest with 'earlycon=3Dsbi', running in an emulated RISC-V
> host, takes around 20 seconds to boot without using DBCN. With this
> patch we're taking around 14 seconds to boot due to the speed-up in the
> terminal output.  There's no change in boot time if the guest isn't
> using earlycon.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c         | 111 +++++++++++++++++++++++++++++
>  target/riscv/sbi_ecall_interface.h |  17 +++++
>  2 files changed, 128 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 03e3fee607..54a9ab9fd7 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -409,6 +409,12 @@ static KVMCPUConfig kvm_v_vlenb =3D {
>                     KVM_REG_RISCV_VECTOR_CSR_REG(vlenb)
>  };
>
> +static KVMCPUConfig kvm_sbi_dbcn =3D {
> +    .name =3D "sbi_dbcn",
> +    .kvm_reg_id =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 |
> +                  KVM_REG_RISCV_SBI_EXT | KVM_RISCV_SBI_EXT_DBCN
> +};
> +
>  static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs=
)
>  {
>      CPURISCVState *env =3D &cpu->env;
> @@ -1041,6 +1047,20 @@ static int uint64_cmp(const void *a, const void *b=
)
>      return 0;
>  }
>
> +static void kvm_riscv_check_sbi_dbcn_support(RISCVCPU *cpu,
> +                                             KVMScratchCPU *kvmcpu,
> +                                             struct kvm_reg_list *reglis=
t)
> +{
> +    struct kvm_reg_list *reg_search;
> +
> +    reg_search =3D bsearch(&kvm_sbi_dbcn.kvm_reg_id, reglist->reg, regli=
st->n,
> +                         sizeof(uint64_t), uint64_cmp);
> +
> +    if (reg_search) {
> +        kvm_sbi_dbcn.supported =3D true;
> +    }
> +}
> +
>  static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
>                                   struct kvm_reg_list *reglist)
>  {
> @@ -1146,6 +1166,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *c=
pu, KVMScratchCPU *kvmcpu)
>      if (riscv_has_ext(&cpu->env, RVV)) {
>          kvm_riscv_read_vlenb(cpu, kvmcpu, reglist);
>      }
> +
> +    kvm_riscv_check_sbi_dbcn_support(cpu, kvmcpu, reglist);
>  }
>
>  static void riscv_init_kvm_registers(Object *cpu_obj)
> @@ -1320,6 +1342,17 @@ static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu,=
 CPUState *cs)
>      return ret;
>  }
>
> +static int kvm_vcpu_enable_sbi_dbcn(RISCVCPU *cpu, CPUState *cs)
> +{
> +    target_ulong reg =3D 1;
> +
> +    if (!kvm_sbi_dbcn.supported) {
> +        return 0;
> +    }
> +
> +    return kvm_set_one_reg(cs, kvm_sbi_dbcn.kvm_reg_id, &reg);
> +}
> +
>  int kvm_arch_init_vcpu(CPUState *cs)
>  {
>      int ret =3D 0;
> @@ -1337,6 +1370,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      kvm_riscv_update_cpu_misa_ext(cpu, cs);
>      kvm_riscv_update_cpu_cfg_isa_ext(cpu, cs);
>
> +    ret =3D kvm_vcpu_enable_sbi_dbcn(cpu, cs);
> +
>      return ret;
>  }
>
> @@ -1394,6 +1429,79 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs=
)
>      return true;
>  }
>
> +static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
> +{
> +    g_autofree uint8_t *buf =3D NULL;
> +    RISCVCPU *cpu =3D RISCV_CPU(cs);
> +    target_ulong num_bytes;
> +    uint64_t addr;
> +    unsigned char ch;
> +    int ret;
> +
> +    switch (run->riscv_sbi.function_id) {
> +    case SBI_EXT_DBCN_CONSOLE_READ:
> +    case SBI_EXT_DBCN_CONSOLE_WRITE:
> +        num_bytes =3D run->riscv_sbi.args[0];
> +
> +        if (num_bytes =3D=3D 0) {
> +            run->riscv_sbi.ret[0] =3D SBI_SUCCESS;
> +            run->riscv_sbi.ret[1] =3D 0;
> +            break;
> +        }
> +
> +        addr =3D run->riscv_sbi.args[1];
> +
> +        /*
> +         * Handle the case where a 32 bit CPU is running in a
> +         * 64 bit addressing env.
> +         */
> +        if (riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32) {
> +            addr |=3D (uint64_t)run->riscv_sbi.args[2] << 32;
> +        }
> +
> +        buf =3D g_malloc0(num_bytes);
> +
> +        if (run->riscv_sbi.function_id =3D=3D SBI_EXT_DBCN_CONSOLE_READ)=
 {
> +            ret =3D qemu_chr_fe_read_all(serial_hd(0)->be, buf, num_byte=
s);
> +            if (ret < 0) {
> +                error_report("SBI_EXT_DBCN_CONSOLE_READ: error when "
> +                             "reading chardev");
> +                exit(1);
> +            }
> +
> +            cpu_physical_memory_write(addr, buf, ret);
> +        } else {
> +            cpu_physical_memory_read(addr, buf, num_bytes);
> +
> +            ret =3D qemu_chr_fe_write_all(serial_hd(0)->be, buf, num_byt=
es);
> +            if (ret < 0) {
> +                error_report("SBI_EXT_DBCN_CONSOLE_WRITE: error when "
> +                             "writing chardev");
> +                exit(1);
> +            }
> +        }
> +
> +        run->riscv_sbi.ret[0] =3D SBI_SUCCESS;
> +        run->riscv_sbi.ret[1] =3D ret;
> +        break;
> +    case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
> +        ch =3D run->riscv_sbi.args[0];
> +        ret =3D qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
> +
> +        if (ret < 0) {
> +            error_report("SBI_EXT_DBCN_CONSOLE_WRITE_BYTE: error when "
> +                         "writing chardev");
> +            exit(1);
> +        }
> +
> +        run->riscv_sbi.ret[0] =3D SBI_SUCCESS;
> +        run->riscv_sbi.ret[1] =3D 0;
> +        break;
> +    default:
> +        run->riscv_sbi.ret[0] =3D SBI_ERR_NOT_SUPPORTED;
> +    }
> +}
> +
>  static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
>  {
>      int ret =3D 0;
> @@ -1412,6 +1520,9 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struc=
t kvm_run *run)
>          }
>          ret =3D 0;
>          break;
> +    case SBI_EXT_DBCN:
> +        kvm_riscv_handle_sbi_dbcn(cs, run);
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: un-handled SBI EXIT, specific reasons is %lu\=
n",
> diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_=
interface.h
> index 43899d08f6..7dfe5f72c6 100644
> --- a/target/riscv/sbi_ecall_interface.h
> +++ b/target/riscv/sbi_ecall_interface.h
> @@ -12,6 +12,17 @@
>
>  /* clang-format off */
>
> +#define SBI_SUCCESS                      0
> +#define SBI_ERR_FAILED                  -1
> +#define SBI_ERR_NOT_SUPPORTED           -2
> +#define SBI_ERR_INVALID_PARAM           -3
> +#define SBI_ERR_DENIED                  -4
> +#define SBI_ERR_INVALID_ADDRESS         -5
> +#define SBI_ERR_ALREADY_AVAILABLE       -6
> +#define SBI_ERR_ALREADY_STARTED         -7
> +#define SBI_ERR_ALREADY_STOPPED         -8
> +#define SBI_ERR_NO_SHMEM                -9
> +
>  /* SBI Extension IDs */
>  #define SBI_EXT_0_1_SET_TIMER           0x0
>  #define SBI_EXT_0_1_CONSOLE_PUTCHAR     0x1
> @@ -27,6 +38,7 @@
>  #define SBI_EXT_IPI                     0x735049
>  #define SBI_EXT_RFENCE                  0x52464E43
>  #define SBI_EXT_HSM                     0x48534D
> +#define SBI_EXT_DBCN                    0x4442434E
>
>  /* SBI function IDs for BASE extension */
>  #define SBI_EXT_BASE_GET_SPEC_VERSION   0x0
> @@ -57,6 +69,11 @@
>  #define SBI_EXT_HSM_HART_STOP           0x1
>  #define SBI_EXT_HSM_HART_GET_STATUS     0x2
>
> +/* SBI function IDs for DBCN extension */
> +#define SBI_EXT_DBCN_CONSOLE_WRITE      0x0
> +#define SBI_EXT_DBCN_CONSOLE_READ       0x1
> +#define SBI_EXT_DBCN_CONSOLE_WRITE_BYTE 0x2
> +
>  #define SBI_HSM_HART_STATUS_STARTED     0x0
>  #define SBI_HSM_HART_STATUS_STOPPED     0x1
>  #define SBI_HSM_HART_STATUS_START_PENDING   0x2
> --
> 2.44.0
>
>

