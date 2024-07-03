Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A2BC3065C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpiY-0005mp-3B; Tue, 02 Jul 2024 22:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpiV-0005m5-HJ; Tue, 02 Jul 2024 22:27:31 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpiT-0000I2-KQ; Tue, 02 Jul 2024 22:27:31 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4ef52ac0ff5so1481829e0c.1; 
 Tue, 02 Jul 2024 19:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719973648; x=1720578448; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1u3Z3DPkPF7S50P+13nA8NYuX8jYFdedJ40RQ+y9nGU=;
 b=RdDcqi9+wu0DCDHP4AsUX5mnwUQuLd5hEghGP3pldqJwF8vYP67v9yxCLmvMnqdFte
 bm4SrShPfX/a6KlweGj1rrPE4sMNGFayIazF8E3VUCNAUABiRg2sYR/vhXq31bkPeo8V
 O/LVPPbE+f2QVBfEU35IKMDDDwzzLEqLlprlt1QrOqFP3UDCPkxYS1LlE9nv5oqAgvn0
 YNyVsZ0RdRDl0/uN+64Z7IQUaGGmW1E7GpZ5vKmltWbXGd8Hdnpx6TvcN5OBEBgLZR0P
 EudhZqjIdygQZgLzw+Q0FxKtG3qJCh6tzfiUhs71aPwc/agDENWv81rGUzy1CXRJw5QF
 /Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719973648; x=1720578448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1u3Z3DPkPF7S50P+13nA8NYuX8jYFdedJ40RQ+y9nGU=;
 b=bnts9qPbvHSGZSnIcluzRjJdFZNwwuCJXEHutqVGiaYJg7KFm2SnNO6JYGBevpOufB
 I3SICRhcHCsPg2V/50PKbbncGtpnDwUBJSijSE5DsZw6lNsnvixuUm1CZFEpI8bVbYMf
 F6HVm8PXgR0etM2wFzWnJYaJJPU55sqTEJN4XmN6vVtDDGd20CbRMJCf3cSQ02v6Io2c
 ybAW5Hx41s9f3rjigEgB3abGcFFR4ti7E721y+3LuFh9WP5YoZYoafnXZ4STte7djrRf
 O47QajcC6iJ7v05WHdnpj+l9B1sdXDfE2MejDY47fcIPr8ZRBy8JHOhSOcJkuTV1WlOi
 3TeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJD4Hom7Tx1oMBz0BCqlfSrRITxSZIeV3o6b+34iCtZavWzxxUEGmI6LDT7/kPSL7oxEMc4BTU4K4tTRN78r+GSwIXyGE=
X-Gm-Message-State: AOJu0YzUTPzhKMQ5JGEfvt6/hWNYhqKqc6x0AOjjURhPiAW+d8o6C+Ma
 tOEo4AGR3t4FwQ+nkR0JvF1tBGtulfsERcaZiLMSLqli9PPm5WJ8IuffAdOn1sr43U/TMwnBMBF
 OGwwUxp08SWmbF8PiR+aafFguO6c=
X-Google-Smtp-Source: AGHT+IHMBU0YX6+8mrBNCw35mNxrS9h253ZDxRcqEOgBbZ9GyBE34IjXIeJ66EPNzkgEV/1JEUH7Vm81/Gn6jjZW6MM=
X-Received: by 2002:a05:6122:2899:b0:4ea:edfb:8d89 with SMTP id
 71dfb90a1353d-4f2a56dd66cmr11920434e0c.12.1719973648069; Tue, 02 Jul 2024
 19:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240701033722.954-1-zhiwei_liu@linux.alibaba.com>
 <20240701033722.954-2-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240701033722.954-2-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 12:27:01 +1000
Message-ID: <CAKmqyKOFAYWk6=-_nOM=aMyQEFbkLV8hT2bGW3JrmtTDLtb7kQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] target/riscv: Add fw_dynamic_info32 for booting RV32
 OpenSBI
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Mon, Jul 1, 2024 at 1:40=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> RV32 OpenSBI need a fw_dynamic_info parameter with 32-bit fields instead
> of target_ulong.
>
> In RV64 QEMU, target_ulong is 64. So it is not right for booting RV32 Ope=
nSBI.
> We create a fw_dynmaic_info32 struct for this purpose.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/boot.c                 | 35 ++++++++++++++++++++++-----------
>  hw/riscv/sifive_u.c             |  3 ++-
>  include/hw/riscv/boot.h         |  4 +++-
>  include/hw/riscv/boot_opensbi.h | 29 +++++++++++++++++++++++++++
>  4 files changed, 57 insertions(+), 14 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 47281ca853..1a2c1ff9e0 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -342,27 +342,33 @@ void riscv_load_fdt(hwaddr fdt_addr, void *fdt)
>                          rom_ptr_for_as(&address_space_memory, fdt_addr, =
fdtsize));
>  }
>
> -void riscv_rom_copy_firmware_info(MachineState *machine, hwaddr rom_base=
,
> -                                  hwaddr rom_size, uint32_t reset_vec_si=
ze,
> +void riscv_rom_copy_firmware_info(MachineState *machine,
> +                                  RISCVHartArrayState *harts,
> +                                  hwaddr rom_base, hwaddr rom_size,
> +                                  uint32_t reset_vec_size,
>                                    uint64_t kernel_entry)
>  {
> +    struct fw_dynamic_info32 dinfo32;
>      struct fw_dynamic_info dinfo;
>      size_t dinfo_len;
>
> -    if (sizeof(dinfo.magic) =3D=3D 4) {
> -        dinfo.magic =3D cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
> -        dinfo.version =3D cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
> -        dinfo.next_mode =3D cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
> -        dinfo.next_addr =3D cpu_to_le32(kernel_entry);
> +    if (riscv_is_32bit(harts)) {
> +        dinfo32.magic =3D cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
> +        dinfo32.version =3D cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
> +        dinfo32.next_mode =3D cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
> +        dinfo32.next_addr =3D cpu_to_le32(kernel_entry);
> +        dinfo32.options =3D 0;
> +        dinfo32.boot_hart =3D 0;
> +        dinfo_len =3D sizeof(dinfo32);
>      } else {
>          dinfo.magic =3D cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
>          dinfo.version =3D cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
>          dinfo.next_mode =3D cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
>          dinfo.next_addr =3D cpu_to_le64(kernel_entry);
> +        dinfo.options =3D 0;
> +        dinfo.boot_hart =3D 0;
> +        dinfo_len =3D sizeof(dinfo);
>      }
> -    dinfo.options =3D 0;
> -    dinfo.boot_hart =3D 0;
> -    dinfo_len =3D sizeof(dinfo);
>
>      /**
>       * copy the dynamic firmware info. This information is specific to
> @@ -374,7 +380,10 @@ void riscv_rom_copy_firmware_info(MachineState *mach=
ine, hwaddr rom_base,
>          exit(1);
>      }
>
> -    rom_add_blob_fixed_as("mrom.finfo", &dinfo, dinfo_len,
> +    rom_add_blob_fixed_as("mrom.finfo",
> +                           riscv_is_32bit(harts) ?
> +                           (void *)&dinfo32 : (void *)&dinfo,
> +                           dinfo_len,
>                             rom_base + reset_vec_size,
>                             &address_space_memory);
>  }
> @@ -430,7 +439,9 @@ void riscv_setup_rom_reset_vec(MachineState *machine,=
 RISCVHartArrayState *harts
>      }
>      rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
>                            rom_base, &address_space_memory);
> -    riscv_rom_copy_firmware_info(machine, rom_base, rom_size, sizeof(res=
et_vec),
> +    riscv_rom_copy_firmware_info(machine, harts,
> +                                 rom_base, rom_size,
> +                                 sizeof(reset_vec),
>                                   kernel_entry);
>  }
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index af5f923f54..5010c3eadb 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -646,7 +646,8 @@ static void sifive_u_machine_init(MachineState *machi=
ne)
>      rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
>                            memmap[SIFIVE_U_DEV_MROM].base, &address_space=
_memory);
>
> -    riscv_rom_copy_firmware_info(machine, memmap[SIFIVE_U_DEV_MROM].base=
,
> +    riscv_rom_copy_firmware_info(machine, &s->soc.u_cpus,
> +                                 memmap[SIFIVE_U_DEV_MROM].base,
>                                   memmap[SIFIVE_U_DEV_MROM].size,
>                                   sizeof(reset_vec), kernel_entry);
>
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index a2e4ae9cb0..806256d23f 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -56,7 +56,9 @@ void riscv_setup_rom_reset_vec(MachineState *machine, R=
ISCVHartArrayState *harts
>                                 hwaddr rom_base, hwaddr rom_size,
>                                 uint64_t kernel_entry,
>                                 uint64_t fdt_load_addr);
> -void riscv_rom_copy_firmware_info(MachineState *machine, hwaddr rom_base=
,
> +void riscv_rom_copy_firmware_info(MachineState *machine,
> +                                  RISCVHartArrayState *harts,
> +                                  hwaddr rom_base,
>                                    hwaddr rom_size,
>                                    uint32_t reset_vec_size,
>                                    uint64_t kernel_entry);
> diff --git a/include/hw/riscv/boot_opensbi.h b/include/hw/riscv/boot_open=
sbi.h
> index 1b749663dc..18664a174b 100644
> --- a/include/hw/riscv/boot_opensbi.h
> +++ b/include/hw/riscv/boot_opensbi.h
> @@ -58,4 +58,33 @@ struct fw_dynamic_info {
>      target_long boot_hart;
>  };
>
> +/** Representation dynamic info passed by previous booting stage */
> +struct fw_dynamic_info32 {
> +    /** Info magic */
> +    int32_t magic;
> +    /** Info version */
> +    int32_t version;
> +    /** Next booting stage address */
> +    int32_t next_addr;
> +    /** Next booting stage mode */
> +    int32_t next_mode;
> +    /** Options for OpenSBI library */
> +    int32_t options;
> +    /**
> +     * Preferred boot HART id
> +     *
> +     * It is possible that the previous booting stage uses same link
> +     * address as the FW_DYNAMIC firmware. In this case, the relocation
> +     * lottery mechanism can potentially overwrite the previous booting
> +     * stage while other HARTs are still running in the previous booting
> +     * stage leading to boot-time crash. To avoid this boot-time crash,
> +     * the previous booting stage can specify last HART that will jump
> +     * to the FW_DYNAMIC firmware as the preferred boot HART.
> +     *
> +     * To avoid specifying a preferred boot HART, the previous booting
> +     * stage can set it to -1UL which will force the FW_DYNAMIC firmware
> +     * to use the relocation lottery mechanism.
> +     */
> +    int32_t boot_hart;
> +};
>  #endif
> --
> 2.43.0
>
>

