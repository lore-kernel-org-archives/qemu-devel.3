Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39A4CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9E-00038x-Jl; Sat, 30 Aug 2025 11:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtqv-0003L8-Kn
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:48:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtqs-00061i-2Y
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:48:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b7d497ab9so10387615e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756453728; x=1757058528; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mPWey27stMgUc4PmpbFoGL+j+T/9NtWsZahvA8j7Rgg=;
 b=UzjXh9UnGUDh0Ux6b/4rvBOAHKP4vB5NeVa8HETe/4wbtK1r1qLY17NcB54fyC7Ass
 qoJi2M/h1czM9dnmov5C2lIOgUWQqr+aNkEVJKg6dx0cVikLO9R0jHqOQWoGis0ww58Z
 j594BBYW0hbjYiEtOgXUOV7WXZpSagKD8lYe6LUx+dxLZDAiV++Gob3ItzCY7/fUzld4
 j1o6GL8bq3OpeUhNIHnIn702bkPg9K4+IKRLWkNaSKyBVh8OJ3T8pzFoD7Jg/MBSXUjJ
 ZydZUWF8OGLbpftcldMk9WCeorZgCPiSTOx3OZScLxu7pTAm4a3zHyYhl4uM0zITmHlp
 /Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756453728; x=1757058528;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPWey27stMgUc4PmpbFoGL+j+T/9NtWsZahvA8j7Rgg=;
 b=NTlDtZU0CxWGeiEzpar+GWG9bXBOYe1yO4thn0MHF5zcb9B97MzvHiz5bEBliRwhyz
 cArbS/oDia6jmQuKJhnP4DcGnoN8xQL7CXHVsLDKNdRBqKJfJP5rrecMDdhriLANr6xW
 e5b3k1HE3KE6tZvNHpzXMbqJmImg3kePiAVkHdsdhHYXGM1J1aGs1nlYB6hIZApU3jN6
 bpbP59obOFNVsDL2g5DfN7mntpVgZhnDllP4SHal44ozyozPmrJBQkhxr+PHRBGVV62R
 XwJQNzpuLDDo8/r5PPDmWtw/Ry/wMA6n9FhOqpf2m1HqPj3M6FAjtSsPEkysFBnx69Gz
 6Wrw==
X-Gm-Message-State: AOJu0YxcQt+QsXg+AJtrbeOgMs9eEXm3UyARIBlMi0l8wIIffukhjQdT
 m7Pw/Earwn6Ka5qZmDGO+ZsHooFaDTVbaqi/7kZ/n4QTS05SQU5sdsY1DkH/KzpPrU2pzAU7dTa
 usW6o02o=
X-Gm-Gg: ASbGnctYebG92HvVMHMw3Fj6f73mb6npjvpThWksuTuwGvwXJEJKV/JJadAiESvVDZ0
 V77RtzD01/U4t6Q1Bjq7ku1qF36qjt0q9+vy86DQKKLk2oWjIvBVXKcSEgmpvcickEKEynnRjCj
 gpga9ZxC2DNdQ9khwN5unktXVPf7yqLPxDS3UD5JuokzGi6fJA4v9j1BfBPDzQiqGtaJdTLJ0sf
 pFAlzF8vrGfK14+DxDtOyo9WhzvwK/dHx4hifQwUFm2/yYjFx4DESxkzmSgsi8oEqpUMljSxIeM
 /IMIzJbCSuY2N8Ct1I9z7HPm8v3ft1A8uAH4YBFmd5H5fL2x6+tQBcrTfPMt1187EyR3uQMUdl1
 2/9tMNafW+Rl/nGxJmUJqzSED1K+XeNJiRf3Ag5r217IGwNy9nHrCtGbbLZnxOrjjbboRn03/
X-Google-Smtp-Source: AGHT+IFPK9xHyfFLx3AtdQmz952OoKadoYGclLJh6pWH/WaverPFoL8mnc6NwE1I23oNhj4H6CgK0g==
X-Received: by 2002:a05:600c:1f8f:b0:45b:47e1:ef6a with SMTP id
 5b1f17b1804b1-45b517e9d25mr206277745e9.37.1756453727790; 
 Fri, 29 Aug 2025 00:48:47 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm105697915e9.16.2025.08.29.00.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 00:48:47 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:47:34 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Cc: 
Subject: Re: [PATCH] system: drop the -old-param option
User-Agent: meli/0.8.12
References: <20250828162700.3308812-1-peter.maydell@linaro.org>
In-Reply-To: <20250828162700.3308812-1-peter.maydell@linaro.org>
Message-ID: <t1qwda.kroreyuwz7ew@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

On Thu, 28 Aug 2025 19:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>We deprecated the command line option -old-param for the 10.0
>release, which allows us to drop it in 10.2.  This option was used to
>boot Arm targets with a very old boot protocol using the
>'param_struct' ABI.  We only ever needed this on a handful of board
>types which have all now been removed from QEMU.
>
>Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> docs/about/deprecated.rst       | 13 ------
> docs/about/removed-features.rst | 12 +++++
> include/system/system.h         |  1 -
> hw/arm/boot.c                   | 81 +--------------------------------
> system/globals.c                |  1 -
> system/vl.c                     |  4 --
> qemu-options.hx                 |  7 ---
> 7 files changed, 13 insertions(+), 106 deletions(-)
>
>diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>index d50645a0711..58bce715f9c 100644
>--- a/docs/about/deprecated.rst
>+++ b/docs/about/deprecated.rst
>@@ -68,19 +68,6 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
> marked deprecated since 9.0, users have to ensure that all the topology members
> described with -smp are supported by the target machine.
> 
>-``-old-param`` option for booting Arm kernels via param_struct (since 10.0)
>-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>-
>-The ``-old-param`` command line option is specific to Arm targets:
>-it is used when directly booting a guest kernel to pass it the
>-command line and other information via the old ``param_struct`` ABI,
>-rather than the newer ATAGS or DTB mechanisms. This option was only
>-ever needed to support ancient kernels on some old board types
>-like the ``akita`` or ``terrier``; it has been deprecated in the
>-kernel since 2001. None of the board types QEMU supports need
>-``param_struct`` support, so this option has been deprecated and will
>-be removed in a future QEMU version.
>-
> User-mode emulator command line arguments
> -----------------------------------------
> 
>diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
>index d7c2113fc3e..b1b3d1b1b3f 100644
>--- a/docs/about/removed-features.rst
>+++ b/docs/about/removed-features.rst
>@@ -560,6 +560,18 @@ the options along with the machine models they were intended for.
> 
> Use ``-run-with user=..`` instead.
> 
>+``-old-param`` option for booting Arm kernels via param_struct (since 10.0)
>+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>+
>+The ``-old-param`` command line option was specific to Arm targets:
>+it was used when directly booting a guest kernel to pass it the
>+command line and other information via the old ``param_struct`` ABI,
>+rather than the newer ATAGS or DTB mechanisms. This option was only
>+ever needed to support ancient kernels on some old board types
>+like the ``akita`` or ``terrier``; it has been deprecated in the
>+kernel since 2001. None of the board types QEMU supports need
>+``param_struct`` support, so this option has been removed.
>+
> 
> User-mode emulator command line arguments
> -----------------------------------------
>diff --git a/include/system/system.h b/include/system/system.h
>index a7effe7dfd8..03a2d0e9005 100644
>--- a/include/system/system.h
>+++ b/include/system/system.h
>@@ -42,7 +42,6 @@ extern int graphic_height;
> extern int graphic_depth;
> extern int display_opengl;
> extern const char *keyboard_layout;
>-extern int old_param;
> extern uint8_t *boot_splash_filedata;
> extern bool enable_cpu_pm;
> extern QEMUClockType rtc_clock;
>diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>index d391cd01bb1..525b31e1659 100644
>--- a/hw/arm/boot.c
>+++ b/hw/arm/boot.c
>@@ -336,81 +336,6 @@ static void set_kernel_args(const struct arm_boot_info *info, AddressSpace *as)
>     WRITE_WORD(p, 0);
> }
> 
>-static void set_kernel_args_old(const struct arm_boot_info *info,
>-                                AddressSpace *as)
>-{
>-    hwaddr p;
>-    const char *s;
>-    int initrd_size = info->initrd_size;
>-    hwaddr base = info->loader_start;
>-
>-    /* see linux/include/asm-arm/setup.h */
>-    p = base + KERNEL_ARGS_ADDR;
>-    /* page_size */
>-    WRITE_WORD(p, 4096);
>-    /* nr_pages */
>-    WRITE_WORD(p, info->ram_size / 4096);
>-    /* ramdisk_size */
>-    WRITE_WORD(p, 0);
>-#define FLAG_READONLY 1
>-#define FLAG_RDLOAD   4
>-#define FLAG_RDPROMPT 8
>-    /* flags */
>-    WRITE_WORD(p, FLAG_READONLY | FLAG_RDLOAD | FLAG_RDPROMPT);
>-    /* rootdev */
>-    WRITE_WORD(p, (31 << 8) | 0); /* /dev/mtdblock0 */
>-    /* video_num_cols */
>-    WRITE_WORD(p, 0);
>-    /* video_num_rows */
>-    WRITE_WORD(p, 0);
>-    /* video_x */
>-    WRITE_WORD(p, 0);
>-    /* video_y */
>-    WRITE_WORD(p, 0);
>-    /* memc_control_reg */
>-    WRITE_WORD(p, 0);
>-    /* unsigned char sounddefault */
>-    /* unsigned char adfsdrives */
>-    /* unsigned char bytes_per_char_h */
>-    /* unsigned char bytes_per_char_v */
>-    WRITE_WORD(p, 0);
>-    /* pages_in_bank[4] */
>-    WRITE_WORD(p, 0);
>-    WRITE_WORD(p, 0);
>-    WRITE_WORD(p, 0);
>-    WRITE_WORD(p, 0);
>-    /* pages_in_vram */
>-    WRITE_WORD(p, 0);
>-    /* initrd_start */
>-    if (initrd_size) {
>-        WRITE_WORD(p, info->initrd_start);
>-    } else {
>-        WRITE_WORD(p, 0);
>-    }
>-    /* initrd_size */
>-    WRITE_WORD(p, initrd_size);
>-    /* rd_start */
>-    WRITE_WORD(p, 0);
>-    /* system_rev */
>-    WRITE_WORD(p, 0);
>-    /* system_serial_low */
>-    WRITE_WORD(p, 0);
>-    /* system_serial_high */
>-    WRITE_WORD(p, 0);
>-    /* mem_fclk_21285 */
>-    WRITE_WORD(p, 0);
>-    /* zero unused fields */
>-    while (p < base + KERNEL_ARGS_ADDR + 256 + 1024) {
>-        WRITE_WORD(p, 0);
>-    }
>-    s = info->kernel_cmdline;
>-    if (s) {
>-        address_space_write(as, p, MEMTXATTRS_UNSPECIFIED, s, strlen(s) + 1);
>-    } else {
>-        WRITE_WORD(p, 0);
>-    }
>-}
>-
> static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
>                                uint32_t scells, hwaddr mem_len,
>                                int numa_node_id)
>@@ -760,11 +685,7 @@ static void do_cpu_reset(void *opaque)
>                 cpu_set_pc(cs, info->loader_start);
> 
>                 if (!have_dtb(info)) {
>-                    if (old_param) {
>-                        set_kernel_args_old(info, as);
>-                    } else {
>-                        set_kernel_args(info, as);
>-                    }
>+                    set_kernel_args(info, as);
>                 }
>             } else if (info->secondary_cpu_reset_hook) {
>                 info->secondary_cpu_reset_hook(cpu, info);
>diff --git a/system/globals.c b/system/globals.c
>index 9640c9511e9..98f9876d5d4 100644
>--- a/system/globals.c
>+++ b/system/globals.c
>@@ -52,7 +52,6 @@ bool vga_interface_created;
> Chardev *parallel_hds[MAX_PARALLEL_PORTS];
> QEMUOptionRom option_rom[MAX_OPTION_ROMS];
> int nb_option_roms;
>-int old_param;
> const char *qemu_name;
> unsigned int nb_prom_envs;
> const char *prom_envs[MAX_PROM_ENVS];
>diff --git a/system/vl.c b/system/vl.c
>index 3b7057e6c66..00f36947257 100644
>--- a/system/vl.c
>+++ b/system/vl.c
>@@ -3524,10 +3524,6 @@ void qemu_init(int argc, char **argv)
>                 prom_envs[nb_prom_envs] = optarg;
>                 nb_prom_envs++;
>                 break;
>-            case QEMU_OPTION_old_param:
>-                warn_report("-old-param is deprecated");
>-                old_param = 1;
>-                break;
>             case QEMU_OPTION_rtc:
>                 opts = qemu_opts_parse_noisily(qemu_find_opts("rtc"), optarg,
>                                                false);
>diff --git a/qemu-options.hx b/qemu-options.hx
>index ab23f14d217..aa44b0e34ae 100644
>--- a/qemu-options.hx
>+++ b/qemu-options.hx
>@@ -5347,13 +5347,6 @@ SRST
>         specified, the former is passed to semihosting as it always
>         takes precedence.
> ERST
>-DEF("old-param", 0, QEMU_OPTION_old_param,
>-    "-old-param      old param mode\n", QEMU_ARCH_ARM)
>-SRST
>-``-old-param``
>-    Old param mode (ARM only).
>-ERST
>-
> DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
>     "-sandbox on[,obsolete=allow|deny][,elevateprivileges=allow|deny|children]\n" \
>     "          [,spawn=allow|deny][,resourcecontrol=allow|deny]\n" \
>-- 
>2.43.0
>
>

