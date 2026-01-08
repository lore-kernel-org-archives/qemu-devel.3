Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699ACD1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdi8j-0007UQ-Nl; Thu, 08 Jan 2026 00:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1vdi8Z-0007Rq-O0
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:00:45 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1vdi8V-0006zG-Op
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:00:42 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-88a26ce6619so27095976d6.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767848438; x=1768453238; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3vcNVxoQ86ms0LQI7aA3LODs0+8eM4a/ySAjtj1Ku0=;
 b=idphcu4NRj8UfskmqRIg0jrkB0O8/LeJ88axe9yvUcI3hPrp4S9diuZIGjGVa666Z8
 M5po7NBr7W7ZVLkzZkpOQDpd0qDoDiIeyGR1fzDq5yEKT2f8aTMM7MKxMRYWzNKztkbS
 yUPsAhYD9JlqEQJOQLZLn+NAS9LgJvvy4f8Aq9OocU2S7dpn+aUiJ0tnJw9ochAl6uMM
 mpbieFoGxrzUVhqn3SAwqjArJGo+ay6RC57afeps1HQFMdr+Go5mpnewCJzpbXrxF39c
 meuBSsAtjncij1k/HSEA+YpSfczxmV+6tdiUe+ocabs3JklDioXYPL3/QVu0pVdaugAu
 qblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767848438; x=1768453238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G3vcNVxoQ86ms0LQI7aA3LODs0+8eM4a/ySAjtj1Ku0=;
 b=CHDdFSBJS/+s+KF5lSJvXt/+nbIX1i9R7dPaU35FRkVefRrMG4NzecsSfOaS896wac
 vMEelZNwR0SkspoqN86rWccdaOy8pO/XjRl8VJ4u/4qFwiN4iUmY2KkAYuDBrHYDqBVw
 v4ab8y6ssbMeHQVSSGjUTsOwZxoxlv0mUyxe4liwJ3lyCdhjf5URtYVF8Y7A+4eHMgXV
 xTMavrnizxUG6PleFZD0AZ+tGSehOJgRYVglzdU4cvZhpBN2WNq92uVYPrG+TcEufot2
 9sNP/XlO7sOqdG5ZGZmrrrEyfsgSJ7Yn9PWbsSWFyeIEGzgRfFc0jAQaiXU1++Gduuoa
 4iNg==
X-Gm-Message-State: AOJu0Yw9bk0pSsY4Wsn2kfMc3MK2GmeaxwDpa35Xu3b4N0JB+CL7UEfP
 dHOvVeFyUOZbv7w2zltFQjT8fLu1wCkCPjnrGsHavQqzCG4rVNQerEVoCf4FYOkqJCR5bbiIzHT
 UWoy3TLM/RXzVgAckp7QJEGcp7jB42S0=
X-Gm-Gg: AY/fxX6/DqW+pReFtRyw5Rb4EvqzEZrxI67L2Q0v/rEUgJGvPmsDWWTu55o8sjh/2bN
 1x//OQAfZr/DDTTeNGrN5E+FNBQa/9SOWTYlLBkhNoRa4ahbWN7Ta248cr80i6ympiKDzyc7Dev
 sN9WplPNGCslBr2UFI/Zg4UEaWIzhX6jiY+vMwLiy2WeabWOVEEhRdE2J4ga+liVaTM1IWYvcjq
 L8Qj5VJ6fe1JyVcrMchMTUl01pc+Yz7qA3f1frPYtiDTN0luNp0Vw4vic/zI4ZMHc2wTOS5bk7o
 tpTp
X-Google-Smtp-Source: AGHT+IFl6bDgO568patCV6DFce1DRqzkOSIlCkVJGwUy0z9zr/iwrm5ODEj4p4vWhAOLTRfHh/8bxpAfo8e92BnpsH8=
X-Received: by 2002:ad4:5ae5:0:b0:888:7db7:b3e with SMTP id
 6a1803df08f44-890841ad256mr76418526d6.18.1767848437548; Wed, 07 Jan 2026
 21:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20260107202556.55787-1-philmd@linaro.org>
 <20260107202556.55787-2-philmd@linaro.org>
In-Reply-To: <20260107202556.55787-2-philmd@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 7 Jan 2026 21:00:26 -0800
X-Gm-Features: AQt7F2pTZqVLfpu1BNNvHfiHddvh5HWOxZSrJip2uIP0ZLXYbcfDw6PJcp37wgo
Message-ID: <CAMo8BfJjkdd87=50tm+dfBgix79quNCqy4b0sC=YO2XcT1xHjA@mail.gmail.com>
Subject: Re: [PATCH 1/7] target/xtensa: Convert XTENSA_DEFAULT_CPU_MODEL to
 runtime helper (MMU)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jan 7, 2026 at 12:26=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> In order to remove the TARGET_BIG_ENDIAN use in "cpu.h",
> introduce the xtensa_default_cpu_model() helper which
> returns the current XTENSA_DEFAULT_CPU_MODEL but evaluating
> endianness at runtime. Update the machines using it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/xtensa/cpu-qom.h     |  2 ++
>  target/xtensa/cpu.h         |  4 ----
>  hw/xtensa/sim.c             | 10 ++++++++--
>  hw/xtensa/virt.c            | 11 +++++++++--
>  hw/xtensa/xtfpga.c          | 17 +++++++++--------
>  linux-user/xtensa/elfload.c |  4 ++--
>  target/xtensa/cpu.c         |  5 +++++
>  7 files changed, 35 insertions(+), 18 deletions(-)
>
> diff --git a/target/xtensa/cpu-qom.h b/target/xtensa/cpu-qom.h
> index d932346b5fe..66992d08c2e 100644
> --- a/target/xtensa/cpu-qom.h
> +++ b/target/xtensa/cpu-qom.h
> @@ -38,4 +38,6 @@ OBJECT_DECLARE_CPU_TYPE(XtensaCPU, XtensaCPUClass, XTEN=
SA_CPU)
>  #define XTENSA_CPU_TYPE_SUFFIX "-" TYPE_XTENSA_CPU
>  #define XTENSA_CPU_TYPE_NAME(model) model XTENSA_CPU_TYPE_SUFFIX
>
> +const char *xtensa_default_cpu_model(void);
> +
>  #endif
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 22192924841..fe2f25e527c 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -606,14 +606,10 @@ G_NORETURN void xtensa_cpu_do_unaligned_access(CPUS=
tate *cpu, vaddr addr,
>  #define CPU_RESOLVING_TYPE TYPE_XTENSA_CPU
>
>  #if TARGET_BIG_ENDIAN
> -#define XTENSA_DEFAULT_CPU_MODEL "fsf"
>  #define XTENSA_DEFAULT_CPU_NOMMU_MODEL "fsf"
>  #else
> -#define XTENSA_DEFAULT_CPU_MODEL "dc232b"
>  #define XTENSA_DEFAULT_CPU_NOMMU_MODEL "de212"
>  #endif
> -#define XTENSA_DEFAULT_CPU_TYPE \
> -    XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_MODEL)
>  #define XTENSA_DEFAULT_CPU_NOMMU_TYPE \
>      XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_NOMMU_MODEL)
>
> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
> index 994460d0414..03dbe69c2d4 100644
> --- a/hw/xtensa/sim.c
> +++ b/hw/xtensa/sim.c
> @@ -36,6 +36,7 @@
>  #include "qemu/error-report.h"
>  #include "xtensa_memory.h"
>  #include "xtensa_sim.h"
> +#include "target/xtensa/cpu-qom.h"
>
>  static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
>  {
> @@ -119,12 +120,17 @@ static void xtensa_sim_init(MachineState *machine)
>
>  static void xtensa_sim_machine_init(MachineClass *mc)
>  {
> -    mc->desc =3D "sim machine (" XTENSA_DEFAULT_CPU_MODEL ")";
> +    if (target_big_endian()) {
> +        mc->default_cpu_type =3D XTENSA_CPU_TYPE_NAME("fsf");
> +        mc->desc =3D "sim machine (fsf)";
> +    } else {
> +        mc->default_cpu_type =3D XTENSA_CPU_TYPE_NAME("dc232b");
> +        mc->desc =3D "sim machine (dc232b)";
> +    }
>      mc->is_default =3D true;
>      mc->init =3D xtensa_sim_init;
>      mc->max_cpus =3D 4;
>      mc->no_serial =3D 1;
> -    mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
>  }
>
>  DEFINE_MACHINE("sim", xtensa_sim_machine_init)
> diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
> index 271f06e0953..2275953ce67 100644
> --- a/hw/xtensa/virt.c
> +++ b/hw/xtensa/virt.c
> @@ -35,8 +35,10 @@
>  #include "elf.h"
>  #include "system/memory.h"
>  #include "qemu/error-report.h"
> +#include "qemu/target-info.h"
>  #include "xtensa_memory.h"
>  #include "xtensa_sim.h"
> +#include "target/xtensa/cpu-qom.h"
>
>  static void create_pcie(MachineState *ms, CPUXtensaState *env, int irq_b=
ase,
>                          hwaddr addr_base)
> @@ -117,10 +119,15 @@ static void xtensa_virt_init(MachineState *machine)
>
>  static void xtensa_virt_machine_init(MachineClass *mc)
>  {
> -    mc->desc =3D "virt machine (" XTENSA_DEFAULT_CPU_MODEL ")";
> +    if (target_big_endian()) {
> +        mc->default_cpu_type =3D XTENSA_CPU_TYPE_NAME("fsf");
> +        mc->desc =3D "virt machine (fsf)";
> +    } else {
> +        mc->default_cpu_type =3D XTENSA_CPU_TYPE_NAME("dc232b");
> +        mc->desc =3D "virt machine (dc232b)";
> +    }
>      mc->init =3D xtensa_virt_init;
>      mc->max_cpus =3D 32;
> -    mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
>      mc->default_nic =3D "virtio-net-pci";
>  }
>
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index d427d68e505..5fd4d655557 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -51,6 +51,7 @@
>  #include "hw/xtensa/mx_pic.h"
>  #include "exec/cpu-common.h"
>  #include "migration/vmstate.h"
> +#include "target/xtensa/cpu-qom.h"
>
>  typedef struct XtfpgaFlashDesc {
>      hwaddr base;
> @@ -591,10 +592,10 @@ static void xtfpga_lx60_class_init(ObjectClass *oc,=
 const void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>
> -    mc->desc =3D "lx60 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
> +    mc->desc =3D g_strdup_printf("lx60 EVB (%s)", xtensa_default_cpu_mod=
el());
>      mc->init =3D xtfpga_lx60_init;
>      mc->max_cpus =3D 32;
> -    mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
> +    mc->default_cpu_type =3D xtensa_default_cpu_model();

Type was expected here, but model is supplied instead.
I wonder why xtfpga and sim/virt are done differently?

>      mc->default_ram_size =3D 64 * MiB;
>  }
>
> @@ -625,10 +626,10 @@ static void xtfpga_lx200_class_init(ObjectClass *oc=
, const void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>
> -    mc->desc =3D "lx200 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
> +    mc->desc =3D g_strdup_printf("lx200 EVB (%s)", xtensa_default_cpu_mo=
del());
>      mc->init =3D xtfpga_lx200_init;
>      mc->max_cpus =3D 32;
> -    mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
> +    mc->default_cpu_type =3D xtensa_default_cpu_model();

Same here.

>      mc->default_ram_size =3D 96 * MiB;
>  }
>
> @@ -659,10 +660,10 @@ static void xtfpga_ml605_class_init(ObjectClass *oc=
, const void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>
> -    mc->desc =3D "ml605 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
> +    mc->desc =3D g_strdup_printf("ml605 EVB (%s)", xtensa_default_cpu_mo=
del());
>      mc->init =3D xtfpga_ml605_init;
>      mc->max_cpus =3D 32;
> -    mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
> +    mc->default_cpu_type =3D xtensa_default_cpu_model();

And here.

>      mc->default_ram_size =3D 512 * MiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE=
;
>  }
>
> @@ -693,10 +694,10 @@ static void xtfpga_kc705_class_init(ObjectClass *oc=
, const void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>
> -    mc->desc =3D "kc705 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
> +    mc->desc =3D g_strdup_printf("kc705 EVB (%s)", xtensa_default_cpu_mo=
del());
>      mc->init =3D xtfpga_kc705_init;
>      mc->max_cpus =3D 32;
> -    mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
> +    mc->default_cpu_type =3D xtensa_default_cpu_model();

And here.

--=20
Thanks.
-- Max

