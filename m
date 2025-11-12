Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02062CCFA18
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 02:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ0AV-0001pw-MZ; Tue, 11 Nov 2025 21:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ0AU-0001oL-KW
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 21:01:06 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ0AR-0003wc-DU
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 21:01:06 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b3d196b7eeeso62262066b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 18:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762912862; x=1763517662; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQ7QF0ps6N0HRFpih7ytSBiHJmPtif6ZfI8zeZ3u+4g=;
 b=grNjFhdUSRkrkVVbBcYDypWSy6pMd6tCylxSFeNN46uoGcjDjLvQeEJfiEexDQSFZ2
 S6rJKJlktJ4K7P8tO3iK7KqnR3oZavsvrjtRBaGGQhBPDODAw9iQsvualC91dmMy8x3b
 kTJaGIJU7uuv7YdkkRlE7XO8vQbsxDFjgFUJz3GQl8Mq6mDuUy/a8LoHXN3EXkv3+6BU
 3DsCqcbBKA207VNz2HL87aJED/VRF1bueiPgobxGN9BODaT4qwq3cGHxbdVTQeOY43/s
 vMowRcHJmsLNj+3orSwnTIZ5g4uUjqpKjVCR03wsBaIsoAikAe2NdmjJ6kvDV1wZnw9w
 B17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762912862; x=1763517662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQ7QF0ps6N0HRFpih7ytSBiHJmPtif6ZfI8zeZ3u+4g=;
 b=Lw3c+bEJfubH6cBDt3WYflMbitbpFof+JN/WBR6uef6SYfOxc5PN4HUF/zMggCUKaV
 mG7G6rKBKh8AuUxp9EH/tzsInoUOfKuHVabmAH64GsIa1pbyetFAUc7ZiYfrDnjE6YdA
 SIg8PzPe09xkydVQWJ4OSeJreKxk9WiQAcg34CQqG0ghLSI0eE1YHOgjxBele5jsrJvG
 q593cB2+XFNoosLjMqhXxjiYXZ/yTKEm6rKQbZAPxByytEcxLyG0XD3RSb3U4mftr00G
 m9ufaYKy1QkWKPhCiz1U33XEJs7DqZBm6k++wdXz8yeq1YjYx5kvGyracDe4HHLHh4mK
 FdLg==
X-Gm-Message-State: AOJu0YxCJx7KydXKZqaMOvrwdxH07nB8rKlU+PAoixvSlGXYxMQkWf+J
 Yb8zPjwFvJtrU/sv6+sAt+OxlogJPwMs/TWQKTS1GOc0m1/zmLE7cdIaPNron/V538IarHE3Am9
 E0buv8fh8VZKxacatPyInjlA4+bfuSHA=
X-Gm-Gg: ASbGncusbxYNG7Aj429ydMXdAS+KPzJWMTctcashS1mcJh5U3Da/5tDeIqQmabZK0h0
 E4ih7OK5XTCbx6IGtHX4ZN7s47g7Q6xmZVNeBtVi3OzPYBF2w0QFfhrETe8AK534zw2ZKmqBmXO
 zr226Z4pGvtTogHuipk0Rw6Ya4n/Puz5KR5Oq6QhXnPikr6NS0gdOZcggi2Neso9zkNTiFfIRI0
 6snLA4kjRWI92wt9KxTSGoSEiIUrzNmOfzMWCayUWWHfdnliRZNw0+EQ/V9Rxie8S5RU73A/5Z3
 j3vrU8zxW9E3ksA=
X-Google-Smtp-Source: AGHT+IGWwY/IFKcL9Ik/MqJ022BjD2RyeSDcYtucCBxcnmIDBsQ9bIGzPGSXNseRL9bk1e53QaP6wPZc3bmpwpCLYCs=
X-Received: by 2002:a17:907:2d20:b0:b6d:8385:2164 with SMTP id
 a640c23a62f3a-b7331aeb326mr142446866b.54.1762912861624; Tue, 11 Nov 2025
 18:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20251027100938.11822-1-michael@videogpu.com>
 <20251027100938.11822-3-michael@videogpu.com>
In-Reply-To: <20251027100938.11822-3-michael@videogpu.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 12:00:35 +1000
X-Gm-Features: AWmQ_bmOGKDnBkl88klegMvYOQ7weYSLfZdknc5QXE7a0V40lwHgDVo88OA-H5U
Message-ID: <CAKmqyKOwBvq_Rut1pwEmAG0Y9uyevOCdH-MwutWx7mZRhZcwpA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] hw/misc: add NEORV32 SYSINFO block
 (CLK/MISC/SOC/CACHE)
To: Michael Levit <michael@videogpu.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, philmd@linaro.org, 
 pbonzini@redhat.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 liwei1518@gmail.com, smishash@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
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

On Mon, Oct 27, 2025 at 8:12=E2=80=AFPM Michael Levit <michael@videogpu.com=
> wrote:
>
> From: Michael <michael@videogpu.com>
>
> Add a minimal SYSINFO MMIO device compatible with NEORV32 SDK expectation=
s:
> CLK (rw), MISC/SOC/CACHE (ro) composed from constants. Includes Kconfig/m=
eson.
>
> Signed-off-by: Michael Levit <michael@videogpu.com>
>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 4e35657468..3de644a9e0 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -235,4 +235,6 @@ config IOSB
>  config XLNX_VERSAL_TRNG
>      bool
>
> +config NEORV32_SYSINFO_QEMU
> +    bool
>  source macio/Kconfig
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index b1d8d8e5d2..4ea46ec2d1 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -34,6 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: fi=
les('sifive_e_prci.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.=
c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.=
c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prc=
i.c'))
> +system_ss.add(when: 'CONFIG_NEORV32_SYSINFO_QEMU', if_true: files('neorv=
32_sysinfo.c'))
>
>  subdir('macio')
>
> diff --git a/hw/misc/neorv32_sysinfo.c b/hw/misc/neorv32_sysinfo.c
> new file mode 100644
> index 0000000000..09378b17a9
> --- /dev/null
> +++ b/hw/misc/neorv32_sysinfo.c
> @@ -0,0 +1,183 @@

Run these all through checkpatch, you are missing license info

> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "system/address-spaces.h"
> +#include "neorv32_sysinfo.h" /* QEMU related */
> +#include "neorv32_sysinfo_rtl.h" /* RTL related */
> +
> +
> +/* Register addresses (offsets) */
> +enum {
> +       REG_SYSINFO_CLK    =3D 0x00,
> +       REG_SYSINFO_MISC   =3D 0x04,
> +       REG_SYSINFO_SOC    =3D 0x08,
> +       REG_SYSINFO_CACHE  =3D 0x0C,
> +};

Why an enum?

> +
> +
> +typedef struct Neorv32SysInfoState {
> +    MemoryRegion mmio;
> +    uint32_t clk_hz;   /* rw */
> +    uint32_t misc;     /* ro */
> +    uint32_t soc;      /* ro */
> +    uint32_t cache;    /* ro */
> +} Neorv32SysInfoState;
> +
> +
> +/* Safe integer log2: assumes power-of-two sizes; returns 0 if size is 0=
 */
> +static unsigned int neorv32_log2u(uint32_t x)
> +{
> +    if (x =3D=3D 0U) {
> +        return 0U;
> +    }
> +    unsigned int r =3D 0U;
> +    while ((x >>=3D 1U) !=3D 0U) {
> +        r++;
> +    }
> +    return r;
> +}
> +
> +/* Compose MISC register per the firmware header */
> +static uint32_t neorv32_sysinfo_build_misc(void)
> +{
> +    const uint32_t imem_log2  =3D neorv32_log2u(SYSINFO_IMEM_SIZE) & 0xF=
FU;  /* [7:0]  */
> +    const uint32_t dmem_log2  =3D neorv32_log2u(SYSINFO_DMEM_SIZE) & 0xF=
FU;  /* [15:8] */
> +    const uint32_t harts      =3D (SYSINFO_NUM_HARTS & 0x0FU);          =
     /* [19:16] */
> +    const uint32_t bootmode   =3D (SYSINFO_BOOTMODE_ID & 0x03U);        =
     /* [21:20] */
> +    const uint32_t intbus_to  =3D (SYSINFO_INTBUS_TO_LOG2 & 0x1FU);     =
     /* [26:22] */
> +    const uint32_t extbus_to  =3D (SYSINFO_EXTBUS_TO_LOG2 & 0x1FU);     =
     /* [31:27] */
> +
> +    uint32_t v =3D 0U;
> +    v |=3D (imem_log2 << 0);
> +    v |=3D (dmem_log2 << 8);
> +    v |=3D (harts     << 16);
> +    v |=3D (bootmode  << 20);
> +    v |=3D (intbus_to << 22);
> +    v |=3D (extbus_to << 27);
> +    return v;
> +}
> +
> +/* Compose CACHE register per the firmware header */
> +static uint32_t neorv32_sysinfo_build_cache(void)
> +{
> +    uint32_t v =3D 0U;
> +    v |=3D ((ICACHE_BLOCK_SIZE_LOG2 & 0x0FU) << 0);
> +    v |=3D ((ICACHE_NUM_BLOCKS_LOG2 & 0x0FU) << 4);
> +    v |=3D ((DCACHE_BLOCK_SIZE_LOG2 & 0x0FU) << 8);
> +    v |=3D ((DCACHE_NUM_BLOCKS_LOG2 & 0x0FU) << 12);
> +    v |=3D ((ICACHE_BURSTS_EN ? 1U : 0U) << 16);
> +    v |=3D ((DCACHE_BURSTS_EN ? 1U : 0U) << 24);
> +    return v;
> +}
> +
> +static uint64_t neorv32_sysinfo_read(void *opaque, hwaddr addr, unsigned=
 size)
> +{
> +    Neorv32SysInfoState *s =3D opaque;
> +    uint32_t val =3D 0U;
> +
> +    switch (addr) {
> +    case REG_SYSINFO_CLK:
> +        val =3D s->clk_hz;
> +        break;
> +    case REG_SYSINFO_MISC:
> +        val =3D s->misc;
> +        break;
> +    case REG_SYSINFO_SOC:
> +        val =3D s->soc;
> +        break;
> +    case REG_SYSINFO_CACHE:
> +        val =3D s->cache;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid read addr=3D0x%" HWADDR_PRIx " size=
=3D%u\n",
> +                      __func__, addr, size);
> +        return 0;
> +    }
> +
> +    /* Enforce access size semantics (1/2/4 ok); we just return the low =
bytes */
> +    switch (size) {
> +    case 4: return val;
> +    case 2: return (uint16_t)val;
> +    case 1: return (uint8_t)val;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid read size=3D%u at addr=3D0x%" HWADDR_=
PRIx "\n",
> +                      __func__, size, addr);
> +        return 0;
> +    }
> +}
> +
> +static void neorv32_sysinfo_write(void *opaque, hwaddr addr, uint64_t da=
ta, unsigned size)
> +{
> +    Neorv32SysInfoState *s =3D opaque;
> +
> +    /* Only CLK is writable; others are read-only */
> +    if (addr =3D=3D REG_SYSINFO_CLK) {
> +        /* Accept 1/2/4 byte writes; update the corresponding bytes of c=
lk_hz */
> +        uint32_t old =3D s->clk_hz;
> +        uint32_t val =3D old;
> +
> +        switch (size) {
> +        case 4:
> +            val =3D (uint32_t)data;
> +            break;
> +        case 2: {
> +            uint16_t part =3D (uint16_t)data;
> +            /* Little-endian halfword at offset (0 or 2) */
> +            if ((addr & 0x3) =3D=3D 0x0) {
> +                val =3D (old & 0xFFFF0000U) | part;
> +            } else if ((addr & 0x3) =3D=3D 0x2) {
> +                val =3D (old & 0x0000FFFFU) | ((uint32_t)part << 16);
> +            } else {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: misaligned 16-bit write at 0x%" HWADD=
R_PRIx "\n",
> +                              __func__, addr);
> +                return;
> +            }
> +            break;
> +        }
> +        case 1: {
> +            uint8_t part =3D (uint8_t)data;
> +            uint32_t shift =3D (addr & 0x3) * 8U;
> +            val =3D (old & ~(0xFFU << shift)) | ((uint32_t)part << shift=
);
> +            break;
> +        }
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: invalid write size=3D%u at addr=3D0x%" HW=
ADDR_PRIx "\n",
> +                          __func__, size, addr);
> +            return;
> +        }
> +
> +        s->clk_hz =3D val;
> +        return;
> +    }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "%s: write to read-only addr=3D0x%" HWADDR_PRIx " val=
=3D0x%" PRIx64 " size=3D%u\n",
> +                  __func__, addr, data, size);
> +}
> +
> +static const MemoryRegionOps neorv32_sysinfo_ops =3D {
> +    .read =3D neorv32_sysinfo_read,
> +    .write =3D neorv32_sysinfo_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size =3D 1,
> +    .valid.max_access_size =3D 4,
> +};
> +
> +void neorv32_sysinfo_create(MemoryRegion *address_space, hwaddr base)
> +{
> +    Neorv32SysInfoState *s =3D g_new0(Neorv32SysInfoState, 1);
> +
> +    s->clk_hz =3D SYSINFO_CLK_HZ_DEFAULT;
> +    s->misc   =3D neorv32_sysinfo_build_misc();
> +    s->soc    =3D SYSINFO_SOC_VAL;
> +    s->cache  =3D neorv32_sysinfo_build_cache();

These should be properties that can be set

> +
> +    memory_region_init_io(&s->mmio, NULL, &neorv32_sysinfo_ops,
> +                          s, "neorv32.sysinfo", 16 /* 4 regs x 4 bytes *=
/);
> +
> +    memory_region_add_subregion(address_space, base, &s->mmio);
> +}
>
> diff --git a/hw/misc/neorv32_sysinfo.h b/hw/misc/neorv32_sysinfo.h
> new file mode 100644
> index 0000000000..c0ac7d87e4
> --- /dev/null
> +++ b/hw/misc/neorv32_sysinfo.h
> @@ -0,0 +1,79 @@
> +#ifndef HW_NEORV32_SYSINFO_H
> +#define HW_NEORV32_SYSINFO_H
> +
> +#include "system/memory.h"
> +
> +
> +/* Internal memory sizes (bytes) */
> +#define SYSINFO_IMEM_SIZE        0x00008000U  /* 32 KiB IMEM */
> +#define SYSINFO_DMEM_SIZE        0x00008000U  /* 32 KiB DMEM */
> +
> +/* Number of harts (physical cores) */
> +#define SYSINFO_NUM_HARTS        1U
> +
> +/* Boot mode (matches RTL BOOT_MODE_SELECT encoding used in your firmwar=
e) */
> +#define SYSINFO_BOOTMODE_ID      0U           /* 0..3 */
> +
> +/* Bus timeout encodings: value is log2(cycles); 0 means "no timeout" pe=
r your helper */
> +#define SYSINFO_INTBUS_TO_LOG2   0U           /* 0 =3D> returns 0 */
> +#define SYSINFO_EXTBUS_TO_LOG2   0U           /* 0 =3D> returns 0 */
> +
> +/* Clock (Hz): writable at runtime via SYSINFO.CLK */
> +#define SYSINFO_CLK_HZ_DEFAULT   100000000U   /* 100 MHz */
> +
> +/* Cache topology encodings (log2 values ) */
> +#define ICACHE_BLOCK_SIZE_LOG2   0U           /* bits [3:0] */
> +#define ICACHE_NUM_BLOCKS_LOG2   0U           /* bits [7:4] */
> +#define DCACHE_BLOCK_SIZE_LOG2   0U           /* bits [11:8] */
> +#define DCACHE_NUM_BLOCKS_LOG2   0U           /* bits [15:12] */
> +#define ICACHE_BURSTS_EN         0U           /* bit 16 */
> +#define DCACHE_BURSTS_EN         0U           /* bit 24 */
> +
> +/* Feature bitmap for SOC register. */
> +#define SYSINFO_SOC_ENABLE(x)    (1U << (x))
> +
> +// Enable Bootloader, IMEM, DMEM, UART and SPI
> +#define SYSINFO_SOC_VAL \
> +    ( SYSINFO_SOC_ENABLE(SYSINFO_SOC_BOOTLOADER) | \
> +      SYSINFO_SOC_ENABLE(SYSINFO_SOC_IMEM)       | \
> +      SYSINFO_SOC_ENABLE(SYSINFO_SOC_DMEM)       | \
> +      SYSINFO_SOC_ENABLE(SYSINFO_SOC_IO_UART0)   | \
> +      SYSINFO_SOC_ENABLE(SYSINFO_SOC_IO_SPI) )
> +
> +/* ---------------------------------------------------------------------=
-----------------
> + * Address map
> + * ---------------------------------------------------------------------=
---------------*/
> +#define NEORV32_BOOTLOADER_BASE_ADDRESS (0xFFE00000U)
> +#define NEORV32_IO_BASE_ADDRESS         (0xFFE00000U)
> +
> +#define NEORV32_IMEM_BASE               (0x00000000U)
> +#define NEORV32_DMEM_BASE               (0x80000000U)
> +
> +/* IO base addresses */
> +#define NEORV32_TWD_BASE     (0xFFEA0000U)
> +#define NEORV32_CFS_BASE     (0xFFEB0000U)
> +#define NEORV32_SLINK_BASE   (0xFFEC0000U)
> +#define NEORV32_DMA_BASE     (0xFFED0000U)
> +#define NEORV32_CRC_BASE     (0xFFEE0000U)
> +#define NEORV32_XIP_BASE     (0xFFEF0000U)
> +#define NEORV32_PWM_BASE     (0xFFF00000U)
> +#define NEORV32_GPTMR_BASE   (0xFFF10000U)
> +#define NEORV32_ONEWIRE_BASE (0xFFF20000U)
> +#define NEORV32_XIRQ_BASE    (0xFFF30000U)
> +#define NEORV32_MTIME_BASE   (0xFFF40000U)
> +#define NEORV32_UART0_BASE   (0xFFF50000U)
> +#define NEORV32_UART1_BASE   (0xFFF60000U)
> +#define NEORV32_SDI_BASE     (0xFFF70000U)
> +#define NEORV32_SPI_BASE     (0xFFF80000U)
> +#define NEORV32_TWI_BASE     (0xFFF90000U)
> +#define NEORV32_TRNG_BASE    (0xFFFA0000U)
> +#define NEORV32_WDT_BASE     (0xFFFB0000U)
> +#define NEORV32_GPIO_BASE    (0xFFFC0000U)
> +#define NEORV32_NEOLED_BASE  (0xFFFD0000U)
> +#define NEORV32_SYSINFO_BASE (0xFFFE0000U)
> +#define NEORV32_DM_BASE      (0xFFFF0000U)
> +
> +/* MMIO creator */
> +void neorv32_sysinfo_create(MemoryRegion *address_space, hwaddr base);
> +
> +#endif //HW_NEORV32_SYSINFO_H
>
> diff --git a/hw/misc/neorv32_sysinfo_rtl.h b/hw/misc/neorv32_sysinfo_rtl.=
h
> new file mode 100644
> index 0000000000..594e251c5b
> --- /dev/null
> +++ b/hw/misc/neorv32_sysinfo_rtl.h
> @@ -0,0 +1,134 @@
> +// #####################################################################=
############################
> +// # << NEORV32: neorv32_sysinfo.h - System Information Memory (SYSINFO)=
 HW Driver >>              #
> +// # *******************************************************************=
************************** #
> +// # BSD 3-Clause License                                               =
                           #
> +// #                                                                    =
                           #
> +// # Copyright (c) 2023, Stephan Nolting. All rights reserved.          =
                           #
> +// #                                                                    =
                           #
> +// # Redistribution and use in source and binary forms, with or without =
modification, are          #
> +// # permitted provided that the following conditions are met:          =
                           #
> +// #                                                                    =
                           #
> +// # 1. Redistributions of source code must retain the above copyright n=
otice, this list of        #
> +// #    conditions and the following disclaimer.                        =
                           #
> +// #                                                                    =
                           #
> +// # 2. Redistributions in binary form must reproduce the above copyrigh=
t notice, this list of     #
> +// #    conditions and the following disclaimer in the documentation and=
/or other materials        #
> +// #    provided with the distribution.                                 =
                           #
> +// #                                                                    =
                           #
> +// # 3. Neither the name of the copyright holder nor the names of its co=
ntributors may be used to  #
> +// #    endorse or promote products derived from this software without s=
pecific prior written      #
> +// #    permission.                                                     =
                           #
> +// #                                                                    =
                           #
> +// # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS=
 "AS IS" AND ANY EXPRESS   #
> +// # OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED W=
ARRANTIES OF               #
> +// # MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED=
. IN NO EVENT SHALL THE    #
> +// # COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT=
, INCIDENTAL, SPECIAL,     #
> +// # EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=
 PROCUREMENT OF SUBSTITUTE #
> +// # GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTER=
RUPTION) HOWEVER CAUSED    #
> +// # AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILI=
TY, OR TORT (INCLUDING     #
> +// # NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS =
SOFTWARE, EVEN IF ADVISED  #
> +// # OF THE POSSIBILITY OF SUCH DAMAGE.                                 =
                           #
> +// # *******************************************************************=
************************** #
> +// # The NEORV32 Processor - https://github.com/stnolting/neorv32       =
       (c) Stephan Nolting #
> +// #####################################################################=
############################
> +
> +
> +/**********************************************************************/=
/**
> + * @file neorv32_cfs.h
> + * @brief System Configuration Information Memory (SYSINFO) HW driver he=
ader file.
> + ***********************************************************************=
***/

Can we cleanup the autogen file

Alistair

> +
> +#ifndef neorv32_sysinfo_h
> +#define neorv32_sysinfo_h
> +
> +/**********************************************************************/=
/**
> + * @name IO Device: System Configuration Information Memory (SYSINFO)
> + ***********************************************************************=
***/
> +/**@{*/
> +/** SYSINFO module prototype - whole module is read-only */
> +typedef volatile struct __attribute__((packed,aligned(4))) {
> +        uint32_t CLK;   /**< offset 0:  Clock speed in Hz */
> +  const uint32_t MISC;  /**< offset 4:  Miscellaneous system configurati=
ons (#NEORV32_SYSINFO_MISC_enum) */
> +  const uint32_t SOC;   /**< offset 8:  SoC features (#NEORV32_SYSINFO_S=
OC_enum) */
> +  const uint32_t CACHE; /**< offset 12: Cache configuration (#NEORV32_SY=
SINFO_CACHE_enum) */
> +} neorv32_sysinfo_t;
> +
> +/** SYSINFO module hardware access (#neorv32_sysinfo_t) */
> +#define NEORV32_SYSINFO ((neorv32_sysinfo_t*) (NEORV32_SYSINFO_BASE))
> +
> +/** NEORV32_SYSINFO.MISC (r/-): Miscellaneous system configurations */
> +enum NEORV32_SYSINFO_MISC_enum {
> +  SYSINFO_MISC_IMEM_LSB =3D  0, /**< SYSINFO_MISC  (0) (r/-): log2(inter=
nal IMEM size in bytes) (via IMEM_SIZE generic), LSB */
> +  SYSINFO_MISC_IMEM_MBS =3D  7, /**< SYSINFO_MISC  (7) (r/-): log2(inter=
nal IMEM size in bytes) (via IMEM_SIZE generic), MSB */
> +
> +  SYSINFO_MISC_DMEM_LSB =3D  8, /**< SYSINFO_MISC  (8) (r/-): log2(inter=
nal DMEM size in bytes) (via DMEM_SIZE generic), LSB */
> +  SYSINFO_MISC_DMEM_MSB =3D 15, /**< SYSINFO_MISC (15) (r/-): log2(inter=
nal DMEM size in bytes) (via DMEM_SIZE generic), MSB */
> +
> +  SYSINFO_MISC_HART_LSB =3D 16, /**< SYSINFO_MISC (16) (r/-): number of =
physical CPU cores ("harts"), LSB */
> +  SYSINFO_MISC_HART_MSB =3D 19, /**< SYSINFO_MISC (19) (r/-): number of =
physical CPU cores ("harts"), MSB */
> +
> +  SYSINFO_MISC_BOOT_LSB =3D 20, /**< SYSINFO_MISC (20) (r/-): boot mode =
configuration (via BOOT_MODE_SELECT generic), LSB */
> +  SYSINFO_MISC_BOOT_MSB =3D 21, /**< SYSINFO_MISC (21) (r/-): boot mode =
configuration (via BOOT_MODE_SELECT generic), MSB */
> +
> +  SYSINFO_MISC_ITMO_LSB =3D 22, /**< SYSINFO_MISC (22) (r/-): log2(inter=
nal bus timeout cycles), LSB */
> +  SYSINFO_MISC_ITMO_MSB =3D 26, /**< SYSINFO_MISC (26) (r/-): log2(inter=
nal bus timeout cycles), MSB */
> +
> +  SYSINFO_MISC_ETMO_LSB =3D 27, /**< SYSINFO_MISC (27) (r/-): log2(exter=
nal bus timeout cycles), LSB */
> +  SYSINFO_MISC_ETMO_MSB =3D 31  /**< SYSINFO_MISC (31) (r/-): log2(exter=
nal bus timeout cycles), MSB */
> +};
> +
> +/** NEORV32_SYSINFO.SOC (r/-): Implemented processor devices/features */
> +enum NEORV32_SYSINFO_SOC_enum {
> +  SYSINFO_SOC_BOOTLOADER =3D  0, /**< SYSINFO_SOC  (0) (r/-): Bootloader=
 implemented when 1 (via BOOT_MODE_SELECT generic) */
> +  SYSINFO_SOC_XBUS       =3D  1, /**< SYSINFO_SOC  (1) (r/-): External b=
us interface implemented when 1 (via XBUS_EN generic) */
> +  SYSINFO_SOC_IMEM       =3D  2, /**< SYSINFO_SOC  (2) (r/-): Processor-=
internal instruction memory implemented when 1 (via IMEM_EN generic) */
> +  SYSINFO_SOC_DMEM       =3D  3, /**< SYSINFO_SOC  (3) (r/-): Processor-=
internal data memory implemented when 1 (via DMEM_EN generic) */
> +  SYSINFO_SOC_OCD        =3D  4, /**< SYSINFO_SOC  (4) (r/-): On-chip de=
bugger implemented when 1 (via OCD_EN generic) */
> +  SYSINFO_SOC_ICACHE     =3D  5, /**< SYSINFO_SOC  (5) (r/-): Processor-=
internal instruction cache implemented when 1 (via ICACHE_EN generic) */
> +  SYSINFO_SOC_DCACHE     =3D  6, /**< SYSINFO_SOC  (6) (r/-): Processor-=
internal instruction cache implemented when 1 (via DCACHE_EN generic) */
> +//SYSINFO_SOC_reserved   =3D  7, /**< SYSINFO_SOC  (7) (r/-): reserved *=
/
> +//SYSINFO_SOC_reserved   =3D  8, /**< SYSINFO_SOC  (8) (r/-): reserved *=
/
> +//SYSINFO_SOC_reserved   =3D  9, /**< SYSINFO_SOC  (9) (r/-): reserved *=
/
> +//SYSINFO_SOC_reserved   =3D 10, /**< SYSINFO_SOC (10) (r/-): reserved *=
/
> +  SYSINFO_SOC_OCD_AUTH   =3D 11, /**< SYSINFO_SOC (11) (r/-): On-chip de=
bugger authentication implemented when 1 (via OCD_AUTHENTICATION generic) *=
/
> +  SYSINFO_SOC_IMEM_ROM   =3D 12, /**< SYSINFO_SOC (12) (r/-): Processor-=
internal instruction memory implemented as pre-initialized ROM when 1 (via =
BOOT_MODE_SELECT generic) */
> +  SYSINFO_SOC_IO_TWD     =3D 13, /**< SYSINFO_SOC (13) (r/-): Two-wire d=
evice implemented when 1 (via IO_TWD_EN generic) */
> +  SYSINFO_SOC_IO_DMA     =3D 14, /**< SYSINFO_SOC (14) (r/-): Direct mem=
ory access controller implemented when 1 (via IO_DMA_EN generic) */
> +  SYSINFO_SOC_IO_GPIO    =3D 15, /**< SYSINFO_SOC (15) (r/-): General pu=
rpose input/output port unit implemented when 1 (via IO_GPIO_EN generic) */
> +  SYSINFO_SOC_IO_CLINT   =3D 16, /**< SYSINFO_SOC (16) (r/-): Core local=
 interruptor implemented when 1 (via IO_CLINT_EN generic) */
> +  SYSINFO_SOC_IO_UART0   =3D 17, /**< SYSINFO_SOC (17) (r/-): Primary un=
iversal asynchronous receiver/transmitter 0 implemented when 1 (via IO_UART=
0_EN generic) */
> +  SYSINFO_SOC_IO_SPI     =3D 18, /**< SYSINFO_SOC (18) (r/-): Serial per=
ipheral interface implemented when 1 (via IO_SPI_EN generic) */
> +  SYSINFO_SOC_IO_TWI     =3D 19, /**< SYSINFO_SOC (19) (r/-): Two-wire i=
nterface implemented when 1 (via IO_TWI_EN generic) */
> +  SYSINFO_SOC_IO_PWM     =3D 20, /**< SYSINFO_SOC (20) (r/-): Pulse-widt=
h modulation unit implemented when 1 (via IO_PWM_EN generic) */
> +  SYSINFO_SOC_IO_WDT     =3D 21, /**< SYSINFO_SOC (21) (r/-): Watchdog t=
imer implemented when 1 (via IO_WDT_EN generic) */
> +  SYSINFO_SOC_IO_CFS     =3D 22, /**< SYSINFO_SOC (22) (r/-): Custom fun=
ctions subsystem implemented when 1 (via IO_CFS_EN generic) */
> +  SYSINFO_SOC_IO_TRNG    =3D 23, /**< SYSINFO_SOC (23) (r/-): True rando=
m number generator implemented when 1 (via IO_TRNG_EN generic) */
> +  SYSINFO_SOC_IO_SDI     =3D 24, /**< SYSINFO_SOC (24) (r/-): Serial dat=
a interface implemented when 1 (via IO_SDI_EN generic) */
> +  SYSINFO_SOC_IO_UART1   =3D 25, /**< SYSINFO_SOC (25) (r/-): Secondary =
universal asynchronous receiver/transmitter 1 implemented when 1 (via IO_UA=
RT1_EN generic) */
> +  SYSINFO_SOC_IO_NEOLED  =3D 26, /**< SYSINFO_SOC (26) (r/-): NeoPixel-c=
ompatible smart LED interface implemented when 1 (via IO_NEOLED_EN generic)=
 */
> +  SYSINFO_SOC_IO_TRACER  =3D 27, /**< SYSINFO_SOC (10) (r/-): Execution =
tracer implemented when 1 (via IO_TRACER_EN generic) */
> +  SYSINFO_SOC_IO_GPTMR   =3D 28, /**< SYSINFO_SOC (28) (r/-): General pu=
rpose timer implemented when 1 (via IO_GPTMR_EN generic) */
> +  SYSINFO_SOC_IO_SLINK   =3D 29, /**< SYSINFO_SOC (29) (r/-): Stream lin=
k interface implemented when 1 (via IO_SLINK_EN generic) */
> +  SYSINFO_SOC_IO_ONEWIRE =3D 30  /**< SYSINFO_SOC (30) (r/-): 1-wire int=
erface controller implemented when 1 (via IO_ONEWIRE_EN generic) */
> +//SYSINFO_SOC_reserved   =3D 31  /**< SYSINFO_SOC (31) (r/-): reserved *=
/
> +};
> +
> +/** NEORV32_SYSINFO.CACHE (r/-): Cache configuration */
> + enum NEORV32_SYSINFO_CACHE_enum {
> +  SYSINFO_CACHE_INST_BLOCK_SIZE_0 =3D  0, /**< SYSINFO_CACHE  (0) (r/-):=
 i-cache: log2(Block size in bytes), bit 0 (via CACHE_BLOCK_SIZE generic) *=
/
> +  SYSINFO_CACHE_INST_BLOCK_SIZE_3 =3D  3, /**< SYSINFO_CACHE  (3) (r/-):=
 i-cache: log2(Block size in bytes), bit 3 (via CACHE_BLOCK_SIZE generic) *=
/
> +  SYSINFO_CACHE_INST_NUM_BLOCKS_0 =3D  4, /**< SYSINFO_CACHE  (4) (r/-):=
 i-cache: log2(Number of cache blocks), bit 0 (via ICACHE_NUM_BLOCKS generi=
c) */
> +  SYSINFO_CACHE_INST_NUM_BLOCKS_3 =3D  7, /**< SYSINFO_CACHE  (7) (r/-):=
 i-cache: log2(Number of cache blocks), bit 3 (via ICACHE_NUM_BLOCKS generi=
c) */
> +
> +  SYSINFO_CACHE_DATA_BLOCK_SIZE_0 =3D  8, /**< SYSINFO_CACHE  (8) (r/-):=
 d-cache: log2(Block size in bytes), bit 0 (via CACHE_BLOCK_SIZE generic) *=
/
> +  SYSINFO_CACHE_DATA_BLOCK_SIZE_3 =3D 11, /**< SYSINFO_CACHE (11) (r/-):=
 d-cache: log2(Block size in bytes), bit 3 (via CACHE_BLOCK_SIZE generic) *=
/
> +  SYSINFO_CACHE_DATA_NUM_BLOCKS_0 =3D 12, /**< SYSINFO_CACHE (12) (r/-):=
 d-cache: log2(Number of cache blocks), bit 0 (via DCACHE_NUM_BLOCKS generi=
c) */
> +  SYSINFO_CACHE_DATA_NUM_BLOCKS_3 =3D 15, /**< SYSINFO_CACHE (15) (r/-):=
 d-cache: log2(Number of cache blocks), bit 3 (via DCACHE_NUM_BLOCKS generi=
c) */
> +
> +  SYSINFO_CACHE_INST_BURSTS_EN    =3D 16, /**< SYSINFO_CACHE (16) (r/-):=
 i-cache: issue burst transfers or cache update (via CACHE_BURSTS_EN generi=
c) */
> +  SYSINFO_CACHE_DATA_BURSTS_EN    =3D 24  /**< SYSINFO_CACHE (14) (r/-):=
 d-cache: issue burst transfers or cache update (via CACHE_BURSTS_EN generi=
c) */
> +};
> +/**@}*/
> +
> +
> +#endif // neorv32_sysinfo_h
>

