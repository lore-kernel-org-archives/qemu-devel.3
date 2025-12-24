Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA29E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 14:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPnO-0002zZ-SW; Wed, 24 Dec 2025 09:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPnE-0002yl-Kb
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:24:49 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPn8-0005oo-Gv
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:24:48 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64b7318f1b0so7022062a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 06:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766586277; x=1767191077; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EI5srSCW4LV7lSFvfyVvWIn5It9YMGpAbZy8Cr73gSc=;
 b=V3g2tDRvR2rn60oio6fd4k5LdRGU7DoV0I2tSEk52w6ehpTIo2zBh/jIeC+v8a/EoV
 qWIcjIU8PmAlHkaLBJ0c3b+BO8uUdzwG7Esk9u1e1wXivbUkzokz2FprIZR23BLjp4bq
 cIhv/zKV3UUPWmnsXFJA43E0DKs7bzF7wHVaCjuOeSTZGo5qFXFWVtsJ91JyqVMmMlBQ
 I2RkAvk0V5OGjCPKY/CmSWX3VYExysysxpUli51QzRAbPiSJQ4eZO//WtTIeFYdnp9U1
 NtL+JKnjzqXlQ3HHDodl8+cYHWQZW5YWgpGMaxJNf4wIf4qfT11OLmFSNS+Urv6DA6WX
 w4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766586277; x=1767191077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EI5srSCW4LV7lSFvfyVvWIn5It9YMGpAbZy8Cr73gSc=;
 b=M8gTNux3U22c9JMK+PxBuePtRAStOTa18vzPkozk8MbkYOVI4rvxPEUU5s+9ZNKqS2
 hdXRAOMy3VTYw5JOwy05xvae7/SxZHbZgez1qGzyfpifvV2qpmXO4EYO2L9PDxat6riu
 GR9ef+zVYIewjZYWshpUlSnpCUlYrRfYQlx8PzxbHExhy1T6qNFOxx6WuoMotWbFQvsB
 jSB00exB4IMpnKJNzDLmaSeR7oA0257yBJCIrAiZmACuB8LJ4GIO58urossl9v4nJOXs
 wWTDd36B7xrioKi3psia3S+WBqHTtbUw7vJ13mjLsk6yUTjOn6d2D8ETdV4RcpFKXsLF
 vifw==
X-Gm-Message-State: AOJu0YxG/kp9TDZoY5AbN0C5BC/L1mT4B2ZCKpC8frgQ6MY5sQ44dBzC
 m8MNbH2nfkDMmxP0cA2VTDiuOIP1RLVKxUcGvB9QvGf6f/f8VRT3S6RxgvxoS/LQVDrqiOi94NN
 z3F7Ku7wItfJUtjzvXz2U6Ftv3MBdTa/BOQ+UTn8fUw==
X-Gm-Gg: AY/fxX6QdgfmGejJCRZ4fLY2yhpy+UZFnKL1SmFhXeehBdsGoU88K2yUaawjmvNlb6X
 81k80va8JJ0PI7shC/pqFIwhVVsGJh4wk47P0qfQ+/t3WijPcEEfetE9iqYGvnHzMKs+KkxWXcJ
 LWwsOrI3q/nPTXKJ0wGCs5SbG2A9TSnNmpSJnDw1kTxWLrsSgRi8l1dKVO6aiygF1ssnJfJwQno
 hgHsOlsGL+ilAWKBxF2Ipk/qwILlX2dszKxVTygXxldlygTSlXT9+KRRG00FAZDtrR8Sus=
X-Google-Smtp-Source: AGHT+IEU1pTJ5TOUc4NqP0RpkZtXi52rdUkI03EF880mRi/6ABa43ynw7JcO7fxvE5zMPqW5IrqmjYlKxIikxIvH3kQ=
X-Received: by 2002:a17:907:3faa:b0:b79:fcc9:b00d with SMTP id
 a640c23a62f3a-b80371f353bmr2049318366b.59.1766586277276; Wed, 24 Dec 2025
 06:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20251224133949.85136-1-philmd@linaro.org>
 <20251224133949.85136-7-philmd@linaro.org>
In-Reply-To: <20251224133949.85136-7-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 16:24:11 +0200
X-Gm-Features: AQt7F2rPn8DXJQw9m9cO7EMD8goNZv_2qpodJzfxh9NciRu4TAh3a4HZhTK5n-c
Message-ID: <CAAjaMXauqeKDJ84LowukGMHcDy+kyB8Y_pDoBCr_kSNyguSRPA@mail.gmail.com>
Subject: Re: [PATCH 6/6] monitor/hmp: Merge hmp-cmds-target.c within hmp-cmds.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, Dec 24, 2025 at 3:40=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> hmp-cmds-target.c is no more target specific, move its code
> in hmp-cmds.c, which is built once for all system binaries.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  monitor/hmp-cmds-target.c | 383 --------------------------------------
>  monitor/hmp-cmds.c        | 354 +++++++++++++++++++++++++++++++++++
>  monitor/meson.build       |   2 +-
>  3 files changed, 355 insertions(+), 384 deletions(-)
>  delete mode 100644 monitor/hmp-cmds-target.c
>
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> deleted file mode 100644
> index 48c21559156..00000000000
> --- a/monitor/hmp-cmds-target.c
> +++ /dev/null
> @@ -1,383 +0,0 @@
> -/*
> - * Miscellaneous target-dependent HMP commands
> - *
> - * Copyright (c) 2003-2004 Fabrice Bellard
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> - * of this software and associated documentation files (the "Software"),=
 to deal
> - * in the Software without restriction, including without limitation the=
 rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> - * THE SOFTWARE.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "disas/disas.h"
> -#include "system/address-spaces.h"
> -#include "system/memory.h"
> -#include "monitor/hmp-target.h"
> -#include "monitor/monitor-internal.h"
> -#include "qapi/error.h"
> -#include "qobject/qdict.h"
> -#include "system/hw_accel.h"
> -#include "exec/target_page.h"
> -
> -/* Set the current CPU defined by the user. Callers must hold BQL. */
> -int monitor_set_cpu(Monitor *mon, int cpu_index)
> -{
> -    CPUState *cpu;
> -
> -    cpu =3D qemu_get_cpu(cpu_index);
> -    if (cpu =3D=3D NULL) {
> -        return -1;
> -    }
> -    g_free(mon->mon_cpu_path);
> -    mon->mon_cpu_path =3D object_get_canonical_path(OBJECT(cpu));
> -    return 0;
> -}
> -
> -/* Callers must hold BQL. */
> -static CPUState *mon_get_cpu_sync(Monitor *mon, bool synchronize)
> -{
> -    CPUState *cpu =3D NULL;
> -
> -    if (mon->mon_cpu_path) {
> -        cpu =3D (CPUState *) object_resolve_path_type(mon->mon_cpu_path,
> -                                                    TYPE_CPU, NULL);
> -        if (!cpu) {
> -            g_free(mon->mon_cpu_path);
> -            mon->mon_cpu_path =3D NULL;
> -        }
> -    }
> -    if (!mon->mon_cpu_path) {
> -        if (!first_cpu) {
> -            return NULL;
> -        }
> -        monitor_set_cpu(mon, first_cpu->cpu_index);
> -        cpu =3D first_cpu;
> -    }
> -    assert(cpu !=3D NULL);
> -    if (synchronize) {
> -        cpu_synchronize_state(cpu);
> -    }
> -    return cpu;
> -}
> -
> -CPUState *mon_get_cpu(Monitor *mon)
> -{
> -    return mon_get_cpu_sync(mon, true);
> -}
> -
> -CPUArchState *mon_get_cpu_env(Monitor *mon)
> -{
> -    CPUState *cs =3D mon_get_cpu(mon);
> -
> -    return cs ? cpu_env(cs) : NULL;
> -}
> -
> -int monitor_get_cpu_index(Monitor *mon)
> -{
> -    CPUState *cs =3D mon_get_cpu_sync(mon, false);
> -
> -    return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
> -}
> -
> -void hmp_info_registers(Monitor *mon, const QDict *qdict)
> -{
> -    bool all_cpus =3D qdict_get_try_bool(qdict, "cpustate_all", false);
> -    int vcpu =3D qdict_get_try_int(qdict, "vcpu", -1);
> -    CPUState *cs;
> -
> -    if (all_cpus) {
> -        CPU_FOREACH(cs) {
> -            monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
> -            cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
> -        }
> -    } else {
> -        cs =3D vcpu >=3D 0 ? qemu_get_cpu(vcpu) : mon_get_cpu(mon);
> -
> -        if (!cs) {
> -            if (vcpu >=3D 0) {
> -                monitor_printf(mon, "CPU#%d not available\n", vcpu);
> -            } else {
> -                monitor_printf(mon, "No CPU available\n");
> -            }
> -            return;
> -        }
> -
> -        monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
> -        cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
> -    }
> -}
> -
> -static void memory_dump(Monitor *mon, int count, int format, int wsize,
> -                        uint64_t addr, int is_physical)
> -{
> -    int l, line_size, i, max_digits, len;
> -    uint8_t buf[16];
> -    uint64_t v;
> -    CPUState *cs =3D mon_get_cpu(mon);
> -    const unsigned int addr_width =3D is_physical ? 8 : (target_long_bit=
s() * 2);
> -    const bool big_endian =3D target_big_endian();
> -
> -    if (!cs && (format =3D=3D 'i' || !is_physical)) {
> -        monitor_printf(mon, "Can not dump without CPU\n");
> -        return;
> -    }
> -
> -    if (format =3D=3D 'i') {
> -        monitor_disas(mon, cs, addr, count, is_physical);
> -        return;
> -    }
> -
> -    len =3D wsize * count;
> -    if (wsize =3D=3D 1) {
> -        line_size =3D 8;
> -    } else {
> -        line_size =3D 16;
> -    }
> -    max_digits =3D 0;
> -
> -    switch (format) {
> -    case 'o':
> -        max_digits =3D DIV_ROUND_UP(wsize * 8, 3);
> -        break;
> -    default:
> -    case 'x':
> -        max_digits =3D (wsize * 8) / 4;
> -        break;
> -    case 'u':
> -    case 'd':
> -        max_digits =3D DIV_ROUND_UP(wsize * 8 * 10, 33);
> -        break;
> -    case 'c':
> -        wsize =3D 1;
> -        break;
> -    }
> -
> -    while (len > 0) {
> -        monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
> -        l =3D len;
> -        if (l > line_size) {
> -            l =3D line_size;
> -        }
> -        if (is_physical) {
> -            AddressSpace *as =3D cs ? cs->as : &address_space_memory;
> -            MemTxResult r =3D address_space_read(as, addr,
> -                                               MEMTXATTRS_UNSPECIFIED, b=
uf, l);
> -            if (r !=3D MEMTX_OK) {
> -                monitor_printf(mon, " Cannot access memory\n");
> -                break;
> -            }
> -        } else {
> -            if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
> -                monitor_printf(mon, " Cannot access memory\n");
> -                break;
> -            }
> -        }
> -        i =3D 0;
> -        while (i < l) {
> -            switch (wsize) {
> -            default:
> -            case 1:
> -                v =3D ldub_p(buf + i);
> -                break;
> -            case 2:
> -                v =3D (big_endian ? lduw_be_p : lduw_le_p)(buf + i);
> -                break;
> -            case 4:
> -                v =3D (uint32_t)(big_endian ? ldl_be_p : ldl_le_p)(buf +=
 i);
> -                break;
> -            case 8:
> -                v =3D (big_endian ? ldq_be_p : ldq_le_p)(buf + i);
> -                break;
> -            }
> -            monitor_printf(mon, " ");
> -            switch (format) {
> -            case 'o':
> -                monitor_printf(mon, "0%*" PRIo64, max_digits, v);
> -                break;
> -            case 'x':
> -                monitor_printf(mon, "0x%0*" PRIx64, max_digits, v);
> -                break;
> -            case 'u':
> -                monitor_printf(mon, "%*" PRIu64, max_digits, v);
> -                break;
> -            case 'd':
> -                monitor_printf(mon, "%*" PRId64, max_digits, v);
> -                break;
> -            case 'c':
> -                monitor_printc(mon, v);
> -                break;
> -            }
> -            i +=3D wsize;
> -        }
> -        monitor_printf(mon, "\n");
> -        addr +=3D l;
> -        len -=3D l;
> -    }
> -}
> -
> -void hmp_memory_dump(Monitor *mon, const QDict *qdict)
> -{
> -    int count =3D qdict_get_int(qdict, "count");
> -    int format =3D qdict_get_int(qdict, "format");
> -    int size =3D qdict_get_int(qdict, "size");
> -    vaddr addr =3D qdict_get_int(qdict, "addr");
> -
> -    memory_dump(mon, count, format, size, addr, 0);
> -}
> -
> -void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
> -{
> -    int count =3D qdict_get_int(qdict, "count");
> -    int format =3D qdict_get_int(qdict, "format");
> -    int size =3D qdict_get_int(qdict, "size");
> -    hwaddr addr =3D qdict_get_int(qdict, "addr");
> -
> -    memory_dump(mon, count, format, size, addr, 1);
> -}
> -
> -void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **e=
rrp)
> -{
> -    Int128 gpa_region_size;
> -    MemoryRegionSection mrs =3D memory_region_find(get_system_memory(),
> -                                                 addr, size);
> -
> -    if (!mrs.mr) {
> -        error_setg(errp,
> -                   "No memory is mapped at address 0x%" HWADDR_PRIx, add=
r);
> -        return NULL;
> -    }
> -
> -    if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr))=
 {
> -        error_setg(errp,
> -                   "Memory at address 0x%" HWADDR_PRIx " is not RAM", ad=
dr);
> -        memory_region_unref(mrs.mr);
> -        return NULL;
> -    }
> -
> -    gpa_region_size =3D int128_make64(size);
> -    if (int128_lt(mrs.size, gpa_region_size)) {
> -        error_setg(errp, "Size of memory region at 0x%" HWADDR_PRIx
> -                   " exceeded.", addr);
> -        memory_region_unref(mrs.mr);
> -        return NULL;
> -    }
> -
> -    *p_mr =3D mrs.mr;
> -    return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region)=
;
> -}
> -
> -void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
> -{
> -    hwaddr addr =3D qdict_get_int(qdict, "addr");
> -    Error *local_err =3D NULL;
> -    MemoryRegion *mr =3D NULL;
> -    void *ptr;
> -
> -    ptr =3D gpa2hva(&mr, addr, 1, &local_err);
> -    if (local_err) {
> -        error_report_err(local_err);
> -        return;
> -    }
> -
> -    monitor_printf(mon, "Host virtual address for 0x%" HWADDR_PRIx
> -                   " (%s) is %p\n",
> -                   addr, mr->name, ptr);
> -
> -    memory_region_unref(mr);
> -}
> -
> -void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
> -{
> -    vaddr addr =3D qdict_get_int(qdict, "addr");
> -    CPUState *cs =3D mon_get_cpu(mon);
> -    hwaddr gpa;
> -
> -    if (!cs) {
> -        monitor_printf(mon, "No cpu\n");
> -        return;
> -    }
> -
> -    gpa  =3D cpu_get_phys_page_debug(cs, addr & TARGET_PAGE_MASK);
> -    if (gpa =3D=3D -1) {
> -        monitor_printf(mon, "Unmapped\n");
> -    } else {
> -        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n",
> -                       gpa + (addr & ~TARGET_PAGE_MASK));
> -    }
> -}
> -
> -#ifdef CONFIG_LINUX
> -static uint64_t vtop(void *ptr, Error **errp)
> -{
> -    uint64_t pinfo;
> -    uint64_t ret =3D -1;
> -    uintptr_t addr =3D (uintptr_t) ptr;
> -    uintptr_t pagesize =3D qemu_real_host_page_size();
> -    off_t offset =3D addr / pagesize * sizeof(pinfo);
> -    int fd;
> -
> -    fd =3D open("/proc/self/pagemap", O_RDONLY);
> -    if (fd =3D=3D -1) {
> -        error_setg_errno(errp, errno, "Cannot open /proc/self/pagemap");
> -        return -1;
> -    }
> -
> -    /* Force copy-on-write if necessary.  */
> -    qatomic_add((uint8_t *)ptr, 0);
> -
> -    if (pread(fd, &pinfo, sizeof(pinfo), offset) !=3D sizeof(pinfo)) {
> -        error_setg_errno(errp, errno, "Cannot read pagemap");
> -        goto out;
> -    }
> -    if ((pinfo & (1ull << 63)) =3D=3D 0) {
> -        error_setg(errp, "Page not present");
> -        goto out;
> -    }
> -    ret =3D (pinfo & 0x007fffffffffffffull) * pagesize;
> -    ret |=3D addr & (pagesize - 1);
> -
> -out:
> -    close(fd);
> -    return ret;
> -}
> -
> -void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
> -{
> -    hwaddr addr =3D qdict_get_int(qdict, "addr");
> -    Error *local_err =3D NULL;
> -    MemoryRegion *mr =3D NULL;
> -    void *ptr;
> -    uint64_t physaddr;
> -
> -    ptr =3D gpa2hva(&mr, addr, 1, &local_err);
> -    if (local_err) {
> -        error_report_err(local_err);
> -        return;
> -    }
> -
> -    physaddr =3D vtop(ptr, &local_err);
> -    if (local_err) {
> -        error_report_err(local_err);
> -    } else {
> -        monitor_printf(mon, "Host physical address for 0x%" HWADDR_PRIx
> -                       " (%s) is 0x%" PRIx64 "\n",
> -                       addr, mr->name, (uint64_t) physaddr);
> -    }
> -
> -    memory_region_unref(mr);
> -}
> -#endif
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 33a88ce205a..8ca40b447ae 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -17,9 +17,11 @@
>  #include "system/address-spaces.h"
>  #include "system/ioport.h"
>  #include "exec/gdbstub.h"
> +#include "exec/target_page.h"
>  #include "gdbstub/enums.h"
>  #include "monitor/hmp.h"
>  #include "qemu/help_option.h"
> +#include "monitor/hmp-target.h"
>  #include "monitor/monitor-internal.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-control.h"
> @@ -28,7 +30,10 @@
>  #include "qobject/qdict.h"
>  #include "qemu/cutils.h"
>  #include "qemu/log.h"
> +#include "system/hw_accel.h"
> +#include "system/memory.h"
>  #include "system/system.h"
> +#include "disas/disas.h"
>
>  bool hmp_handle_error(Monitor *mon, Error *err)
>  {
> @@ -435,3 +440,352 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
>      monitor_printf(mon, "DTB dumped to '%s'\n", filename);
>  }
>  #endif
> +
> +/* Set the current CPU defined by the user. Callers must hold BQL. */
> +int monitor_set_cpu(Monitor *mon, int cpu_index)
> +{
> +    CPUState *cpu;
> +
> +    cpu =3D qemu_get_cpu(cpu_index);
> +    if (cpu =3D=3D NULL) {
> +        return -1;
> +    }
> +    g_free(mon->mon_cpu_path);
> +    mon->mon_cpu_path =3D object_get_canonical_path(OBJECT(cpu));
> +    return 0;
> +}
> +
> +/* Callers must hold BQL. */
> +static CPUState *mon_get_cpu_sync(Monitor *mon, bool synchronize)
> +{
> +    CPUState *cpu =3D NULL;
> +
> +    if (mon->mon_cpu_path) {
> +        cpu =3D (CPUState *) object_resolve_path_type(mon->mon_cpu_path,
> +                                                    TYPE_CPU, NULL);
> +        if (!cpu) {
> +            g_free(mon->mon_cpu_path);
> +            mon->mon_cpu_path =3D NULL;
> +        }
> +    }
> +    if (!mon->mon_cpu_path) {
> +        if (!first_cpu) {
> +            return NULL;
> +        }
> +        monitor_set_cpu(mon, first_cpu->cpu_index);
> +        cpu =3D first_cpu;
> +    }
> +    assert(cpu !=3D NULL);
> +    if (synchronize) {
> +        cpu_synchronize_state(cpu);
> +    }
> +    return cpu;
> +}
> +
> +CPUState *mon_get_cpu(Monitor *mon)
> +{
> +    return mon_get_cpu_sync(mon, true);
> +}
> +
> +CPUArchState *mon_get_cpu_env(Monitor *mon)
> +{
> +    CPUState *cs =3D mon_get_cpu(mon);
> +
> +    return cs ? cpu_env(cs) : NULL;
> +}
> +
> +int monitor_get_cpu_index(Monitor *mon)
> +{
> +    CPUState *cs =3D mon_get_cpu_sync(mon, false);
> +
> +    return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
> +}
> +
> +void hmp_info_registers(Monitor *mon, const QDict *qdict)
> +{
> +    bool all_cpus =3D qdict_get_try_bool(qdict, "cpustate_all", false);
> +    int vcpu =3D qdict_get_try_int(qdict, "vcpu", -1);
> +    CPUState *cs;
> +
> +    if (all_cpus) {
> +        CPU_FOREACH(cs) {
> +            monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
> +            cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
> +        }
> +    } else {
> +        cs =3D vcpu >=3D 0 ? qemu_get_cpu(vcpu) : mon_get_cpu(mon);
> +
> +        if (!cs) {
> +            if (vcpu >=3D 0) {
> +                monitor_printf(mon, "CPU#%d not available\n", vcpu);
> +            } else {
> +                monitor_printf(mon, "No CPU available\n");
> +            }
> +            return;
> +        }
> +
> +        monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
> +        cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
> +    }
> +}
> +
> +static void memory_dump(Monitor *mon, int count, int format, int wsize,
> +                        uint64_t addr, int is_physical)
> +{
> +    int l, line_size, i, max_digits, len;
> +    uint8_t buf[16];
> +    uint64_t v;
> +    CPUState *cs =3D mon_get_cpu(mon);
> +    const unsigned int addr_width =3D is_physical ? 8 : (target_long_bit=
s() * 2);
> +    const bool big_endian =3D target_big_endian();
> +
> +    if (!cs && (format =3D=3D 'i' || !is_physical)) {
> +        monitor_printf(mon, "Can not dump without CPU\n");
> +        return;
> +    }
> +
> +    if (format =3D=3D 'i') {
> +        monitor_disas(mon, cs, addr, count, is_physical);
> +        return;
> +    }
> +
> +    len =3D wsize * count;
> +    if (wsize =3D=3D 1) {
> +        line_size =3D 8;
> +    } else {
> +        line_size =3D 16;
> +    }
> +    max_digits =3D 0;
> +
> +    switch (format) {
> +    case 'o':
> +        max_digits =3D DIV_ROUND_UP(wsize * 8, 3);
> +        break;
> +    default:
> +    case 'x':
> +        max_digits =3D (wsize * 8) / 4;
> +        break;
> +    case 'u':
> +    case 'd':
> +        max_digits =3D DIV_ROUND_UP(wsize * 8 * 10, 33);
> +        break;
> +    case 'c':
> +        wsize =3D 1;
> +        break;
> +    }
> +
> +    while (len > 0) {
> +        monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
> +        l =3D len;
> +        if (l > line_size) {
> +            l =3D line_size;
> +        }
> +        if (is_physical) {
> +            AddressSpace *as =3D cs ? cs->as : &address_space_memory;
> +            MemTxResult r =3D address_space_read(as, addr,
> +                                               MEMTXATTRS_UNSPECIFIED, b=
uf, l);
> +            if (r !=3D MEMTX_OK) {
> +                monitor_printf(mon, " Cannot access memory\n");
> +                break;
> +            }
> +        } else {
> +            if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
> +                monitor_printf(mon, " Cannot access memory\n");
> +                break;
> +            }
> +        }
> +        i =3D 0;
> +        while (i < l) {
> +            switch (wsize) {
> +            default:
> +            case 1:
> +                v =3D ldub_p(buf + i);
> +                break;
> +            case 2:
> +                v =3D (big_endian ? lduw_be_p : lduw_le_p)(buf + i);
> +                break;
> +            case 4:
> +                v =3D (uint32_t)(big_endian ? ldl_be_p : ldl_le_p)(buf +=
 i);
> +                break;
> +            case 8:
> +                v =3D (big_endian ? ldq_be_p : ldq_le_p)(buf + i);
> +                break;
> +            }
> +            monitor_printf(mon, " ");
> +            switch (format) {
> +            case 'o':
> +                monitor_printf(mon, "0%*" PRIo64, max_digits, v);
> +                break;
> +            case 'x':
> +                monitor_printf(mon, "0x%0*" PRIx64, max_digits, v);
> +                break;
> +            case 'u':
> +                monitor_printf(mon, "%*" PRIu64, max_digits, v);
> +                break;
> +            case 'd':
> +                monitor_printf(mon, "%*" PRId64, max_digits, v);
> +                break;
> +            case 'c':
> +                monitor_printc(mon, v);
> +                break;
> +            }
> +            i +=3D wsize;
> +        }
> +        monitor_printf(mon, "\n");
> +        addr +=3D l;
> +        len -=3D l;
> +    }
> +}
> +
> +void hmp_memory_dump(Monitor *mon, const QDict *qdict)
> +{
> +    int count =3D qdict_get_int(qdict, "count");
> +    int format =3D qdict_get_int(qdict, "format");
> +    int size =3D qdict_get_int(qdict, "size");
> +    vaddr addr =3D qdict_get_int(qdict, "addr");
> +
> +    memory_dump(mon, count, format, size, addr, 0);
> +}
> +
> +void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
> +{
> +    int count =3D qdict_get_int(qdict, "count");
> +    int format =3D qdict_get_int(qdict, "format");
> +    int size =3D qdict_get_int(qdict, "size");
> +    hwaddr addr =3D qdict_get_int(qdict, "addr");
> +
> +    memory_dump(mon, count, format, size, addr, 1);
> +}
> +
> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **e=
rrp)
> +{
> +    Int128 gpa_region_size;
> +    MemoryRegionSection mrs =3D memory_region_find(get_system_memory(),
> +                                                 addr, size);
> +
> +    if (!mrs.mr) {
> +        error_setg(errp,
> +                   "No memory is mapped at address 0x%" HWADDR_PRIx, add=
r);
> +        return NULL;
> +    }
> +
> +    if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr))=
 {
> +        error_setg(errp,
> +                   "Memory at address 0x%" HWADDR_PRIx " is not RAM", ad=
dr);
> +        memory_region_unref(mrs.mr);
> +        return NULL;
> +    }
> +
> +    gpa_region_size =3D int128_make64(size);
> +    if (int128_lt(mrs.size, gpa_region_size)) {
> +        error_setg(errp, "Size of memory region at 0x%" HWADDR_PRIx
> +                   " exceeded.", addr);
> +        memory_region_unref(mrs.mr);
> +        return NULL;
> +    }
> +
> +    *p_mr =3D mrs.mr;
> +    return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region)=
;
> +}
> +
> +void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
> +{
> +    hwaddr addr =3D qdict_get_int(qdict, "addr");
> +    Error *local_err =3D NULL;
> +    MemoryRegion *mr =3D NULL;
> +    void *ptr;
> +
> +    ptr =3D gpa2hva(&mr, addr, 1, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return;
> +    }
> +
> +    monitor_printf(mon, "Host virtual address for 0x%" HWADDR_PRIx
> +                   " (%s) is %p\n",
> +                   addr, mr->name, ptr);
> +
> +    memory_region_unref(mr);
> +}
> +
> +void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
> +{
> +    vaddr addr =3D qdict_get_int(qdict, "addr");
> +    CPUState *cs =3D mon_get_cpu(mon);
> +    hwaddr gpa;
> +
> +    if (!cs) {
> +        monitor_printf(mon, "No cpu\n");
> +        return;
> +    }
> +
> +    gpa  =3D cpu_get_phys_page_debug(cs, addr & TARGET_PAGE_MASK);
> +    if (gpa =3D=3D -1) {
> +        monitor_printf(mon, "Unmapped\n");
> +    } else {
> +        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n",
> +                       gpa + (addr & ~TARGET_PAGE_MASK));
> +    }
> +}
> +
> +#ifdef CONFIG_LINUX
> +static uint64_t vtop(void *ptr, Error **errp)
> +{
> +    uint64_t pinfo;
> +    uint64_t ret =3D -1;
> +    uintptr_t addr =3D (uintptr_t) ptr;
> +    uintptr_t pagesize =3D qemu_real_host_page_size();
> +    off_t offset =3D addr / pagesize * sizeof(pinfo);
> +    int fd;
> +
> +    fd =3D open("/proc/self/pagemap", O_RDONLY);
> +    if (fd =3D=3D -1) {
> +        error_setg_errno(errp, errno, "Cannot open /proc/self/pagemap");
> +        return -1;
> +    }
> +
> +    /* Force copy-on-write if necessary.  */
> +    qatomic_add((uint8_t *)ptr, 0);
> +
> +    if (pread(fd, &pinfo, sizeof(pinfo), offset) !=3D sizeof(pinfo)) {
> +        error_setg_errno(errp, errno, "Cannot read pagemap");
> +        goto out;
> +    }
> +    if ((pinfo & (1ull << 63)) =3D=3D 0) {
> +        error_setg(errp, "Page not present");
> +        goto out;
> +    }
> +    ret =3D (pinfo & 0x007fffffffffffffull) * pagesize;
> +    ret |=3D addr & (pagesize - 1);
> +
> +out:
> +    close(fd);
> +    return ret;
> +}
> +
> +void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
> +{
> +    hwaddr addr =3D qdict_get_int(qdict, "addr");
> +    Error *local_err =3D NULL;
> +    MemoryRegion *mr =3D NULL;
> +    void *ptr;
> +    uint64_t physaddr;
> +
> +    ptr =3D gpa2hva(&mr, addr, 1, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return;
> +    }
> +
> +    physaddr =3D vtop(ptr, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +    } else {
> +        monitor_printf(mon, "Host physical address for 0x%" HWADDR_PRIx
> +                       " (%s) is 0x%" PRIx64 "\n",
> +                       addr, mr->name, (uint64_t) physaddr);
> +    }
> +
> +    memory_region_unref(mr);
> +}
> +#endif
> diff --git a/monitor/meson.build b/monitor/meson.build
> index a71523a1ce8..763fcaba6c5 100644
> --- a/monitor/meson.build
> +++ b/monitor/meson.build
> @@ -9,4 +9,4 @@ system_ss.add(files(
>  system_ss.add([spice_headers, files('qmp-cmds.c')])
>
>  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
> -               if_true: [files( 'hmp-cmds-target.c', 'hmp-target.c'), sp=
ice])
> +  if_true: [files('hmp-target.c'), spice])

Nit: Indentation?

Otherwise

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> --
> 2.52.0
>

