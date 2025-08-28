Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F945C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgCf-0003HF-JE; Thu, 28 Aug 2025 13:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urfSx-0001fi-M2
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 12:27:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urfSu-0007cx-Vx
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 12:27:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b4d8921f2so10308205e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756398423; x=1757003223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=b/fvrXfYxMrQ2GUwG53WS5yqxuWvVCymC7y5qNB8550=;
 b=MeXMWtPSTHwkCOIROQ/uzwBZrkhges48tD9qspu4H5nFeO0X0a7JXxSvxJaiKaUFSj
 b/EUqRAqQGr6VYxz86bfASzGYpp8EkR5F/19gZ6w+HuJgpJ9evtV6Zw9pvbBNd2eh9tU
 dATk0Crjt+b+BuYli/aHveNp/sTl4Bo7niO0KDdqCsn1zf/FzmVzXOaSAf3QdKCVRyTj
 55NBkfR4rJVHVJP3nTAK3sMtR+sqiG76YJZCaVs0sApZ5mSH4W1aou37FuajKAl/Yt9R
 qWBuO0jlHu7e9PRjTFYyQ0w13STSKEcY+Zw8FA9QBxGUkwW2atT77CINZZ+A+I2ej4gf
 RIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756398423; x=1757003223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b/fvrXfYxMrQ2GUwG53WS5yqxuWvVCymC7y5qNB8550=;
 b=dmjhT2uJoVQKgaK4adTUhi1zxMPS4S8d9kBlWvOsKKBNtJQ66/rIXXB5he1WAAGBNF
 ZJBtWyVhDDnHQG6/DNwjEEn+/BDdKAkkanlE6gOcRAEptQwOUX4nnq3KlM+IQt1i4eZb
 CPA6Wwb4UuCOdKULkQhRhbJK5EapQXxz624UA7GIc6CdwbXyowxVCB2R3if5JpZNWmj6
 6Xr1seYgb04Ues3YGXpzKbPwq072CqL53rfzQJ37y8oPC2gX6LdAGwQonQmL8Q4w4oNQ
 w+7lJaUrVDO9QxNDPfuWUjUnG51VqQNdAooOBFPa851Q3fvXwIlb2ZFqyGeJsW4OgTfV
 IYyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUagfSCMf3j/oDb7axq8yHqldfCkuCzqZ2oFlm1OqWAsKb6vKtHtQx30wwBV10OKABIDZDD2xVsq5Rv@nongnu.org
X-Gm-Message-State: AOJu0YwIjKG5pITJ5dsy9oLkyB7M0SBsLXhwk2q07MEfiwVE2B5KDMHm
 wBIEKx87eq7AlTaFzXKSahfo+Oq5rryACARUqM1c9zQztOB/kovTwnpJ4LbZg/CqFYAEju8Yi+O
 ephf3
X-Gm-Gg: ASbGncu4pJ6q0g47cr5vXauShGal0c4n0NMp0ZWBgSdiC1yL5/qzbnpo2FFUhd/O2b/
 WnYq1NW12x9zb3zvR3z/5yWox3i4TJloguyeQNi6vlJ/pNovKbs0FGDIFHTmvHx53DClE+3G6B1
 EDNwdBpgMzrb5oZX6nuPl3ueaGkasBnYOEICO7X/io9UBZWYcv5GyS/z69c+/esZmuAEI40hW3r
 QJkVAiy6q6JaRMnrR4OI5SA4uI/RSOJDOi57ZOkntOO6uXamVCaCowmnk4/XX3FuVcobwf6qsPt
 oVHn6Q6bgz6NJ/1hvVgZEqtdDtMycladvD5NEbUW0Qr2abRLdoTepmxV8qpjBuWRKNFKUFZyFFi
 etpoQxfDiOehcWwCV1mkU5f8La7AaDNdAu973JOl/FjbGsQcPBQ==
X-Google-Smtp-Source: AGHT+IFD9cnwMVLj+APiL+koVzBUVDV3e6Q/u8XEiaA9mASVbCcEWW0oKvjIFAzz9StEiL08USWAfQ==
X-Received: by 2002:a05:600c:46cd:b0:45b:75d6:73c5 with SMTP id
 5b1f17b1804b1-45b7631191emr34348805e9.18.1756398422560; 
 Thu, 28 Aug 2025 09:27:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6b99sm81600145e9.4.2025.08.28.09.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 09:27:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] system: drop the -old-param option
Date: Thu, 28 Aug 2025 17:27:00 +0100
Message-ID: <20250828162700.3308812-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We deprecated the command line option -old-param for the 10.0
release, which allows us to drop it in 10.2.  This option was used to
boot Arm targets with a very old boot protocol using the
'param_struct' ABI.  We only ever needed this on a handful of board
types which have all now been removed from QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/about/deprecated.rst       | 13 ------
 docs/about/removed-features.rst | 12 +++++
 include/system/system.h         |  1 -
 hw/arm/boot.c                   | 81 +--------------------------------
 system/globals.c                |  1 -
 system/vl.c                     |  4 --
 qemu-options.hx                 |  7 ---
 7 files changed, 13 insertions(+), 106 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d50645a0711..58bce715f9c 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -68,19 +68,6 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
 marked deprecated since 9.0, users have to ensure that all the topology members
 described with -smp are supported by the target machine.
 
-``-old-param`` option for booting Arm kernels via param_struct (since 10.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``-old-param`` command line option is specific to Arm targets:
-it is used when directly booting a guest kernel to pass it the
-command line and other information via the old ``param_struct`` ABI,
-rather than the newer ATAGS or DTB mechanisms. This option was only
-ever needed to support ancient kernels on some old board types
-like the ``akita`` or ``terrier``; it has been deprecated in the
-kernel since 2001. None of the board types QEMU supports need
-``param_struct`` support, so this option has been deprecated and will
-be removed in a future QEMU version.
-
 User-mode emulator command line arguments
 -----------------------------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index d7c2113fc3e..b1b3d1b1b3f 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -560,6 +560,18 @@ the options along with the machine models they were intended for.
 
 Use ``-run-with user=..`` instead.
 
+``-old-param`` option for booting Arm kernels via param_struct (since 10.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``-old-param`` command line option was specific to Arm targets:
+it was used when directly booting a guest kernel to pass it the
+command line and other information via the old ``param_struct`` ABI,
+rather than the newer ATAGS or DTB mechanisms. This option was only
+ever needed to support ancient kernels on some old board types
+like the ``akita`` or ``terrier``; it has been deprecated in the
+kernel since 2001. None of the board types QEMU supports need
+``param_struct`` support, so this option has been removed.
+
 
 User-mode emulator command line arguments
 -----------------------------------------
diff --git a/include/system/system.h b/include/system/system.h
index a7effe7dfd8..03a2d0e9005 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -42,7 +42,6 @@ extern int graphic_height;
 extern int graphic_depth;
 extern int display_opengl;
 extern const char *keyboard_layout;
-extern int old_param;
 extern uint8_t *boot_splash_filedata;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d391cd01bb1..525b31e1659 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -336,81 +336,6 @@ static void set_kernel_args(const struct arm_boot_info *info, AddressSpace *as)
     WRITE_WORD(p, 0);
 }
 
-static void set_kernel_args_old(const struct arm_boot_info *info,
-                                AddressSpace *as)
-{
-    hwaddr p;
-    const char *s;
-    int initrd_size = info->initrd_size;
-    hwaddr base = info->loader_start;
-
-    /* see linux/include/asm-arm/setup.h */
-    p = base + KERNEL_ARGS_ADDR;
-    /* page_size */
-    WRITE_WORD(p, 4096);
-    /* nr_pages */
-    WRITE_WORD(p, info->ram_size / 4096);
-    /* ramdisk_size */
-    WRITE_WORD(p, 0);
-#define FLAG_READONLY 1
-#define FLAG_RDLOAD   4
-#define FLAG_RDPROMPT 8
-    /* flags */
-    WRITE_WORD(p, FLAG_READONLY | FLAG_RDLOAD | FLAG_RDPROMPT);
-    /* rootdev */
-    WRITE_WORD(p, (31 << 8) | 0); /* /dev/mtdblock0 */
-    /* video_num_cols */
-    WRITE_WORD(p, 0);
-    /* video_num_rows */
-    WRITE_WORD(p, 0);
-    /* video_x */
-    WRITE_WORD(p, 0);
-    /* video_y */
-    WRITE_WORD(p, 0);
-    /* memc_control_reg */
-    WRITE_WORD(p, 0);
-    /* unsigned char sounddefault */
-    /* unsigned char adfsdrives */
-    /* unsigned char bytes_per_char_h */
-    /* unsigned char bytes_per_char_v */
-    WRITE_WORD(p, 0);
-    /* pages_in_bank[4] */
-    WRITE_WORD(p, 0);
-    WRITE_WORD(p, 0);
-    WRITE_WORD(p, 0);
-    WRITE_WORD(p, 0);
-    /* pages_in_vram */
-    WRITE_WORD(p, 0);
-    /* initrd_start */
-    if (initrd_size) {
-        WRITE_WORD(p, info->initrd_start);
-    } else {
-        WRITE_WORD(p, 0);
-    }
-    /* initrd_size */
-    WRITE_WORD(p, initrd_size);
-    /* rd_start */
-    WRITE_WORD(p, 0);
-    /* system_rev */
-    WRITE_WORD(p, 0);
-    /* system_serial_low */
-    WRITE_WORD(p, 0);
-    /* system_serial_high */
-    WRITE_WORD(p, 0);
-    /* mem_fclk_21285 */
-    WRITE_WORD(p, 0);
-    /* zero unused fields */
-    while (p < base + KERNEL_ARGS_ADDR + 256 + 1024) {
-        WRITE_WORD(p, 0);
-    }
-    s = info->kernel_cmdline;
-    if (s) {
-        address_space_write(as, p, MEMTXATTRS_UNSPECIFIED, s, strlen(s) + 1);
-    } else {
-        WRITE_WORD(p, 0);
-    }
-}
-
 static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
                                uint32_t scells, hwaddr mem_len,
                                int numa_node_id)
@@ -760,11 +685,7 @@ static void do_cpu_reset(void *opaque)
                 cpu_set_pc(cs, info->loader_start);
 
                 if (!have_dtb(info)) {
-                    if (old_param) {
-                        set_kernel_args_old(info, as);
-                    } else {
-                        set_kernel_args(info, as);
-                    }
+                    set_kernel_args(info, as);
                 }
             } else if (info->secondary_cpu_reset_hook) {
                 info->secondary_cpu_reset_hook(cpu, info);
diff --git a/system/globals.c b/system/globals.c
index 9640c9511e9..98f9876d5d4 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -52,7 +52,6 @@ bool vga_interface_created;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 QEMUOptionRom option_rom[MAX_OPTION_ROMS];
 int nb_option_roms;
-int old_param;
 const char *qemu_name;
 unsigned int nb_prom_envs;
 const char *prom_envs[MAX_PROM_ENVS];
diff --git a/system/vl.c b/system/vl.c
index 3b7057e6c66..00f36947257 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3524,10 +3524,6 @@ void qemu_init(int argc, char **argv)
                 prom_envs[nb_prom_envs] = optarg;
                 nb_prom_envs++;
                 break;
-            case QEMU_OPTION_old_param:
-                warn_report("-old-param is deprecated");
-                old_param = 1;
-                break;
             case QEMU_OPTION_rtc:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("rtc"), optarg,
                                                false);
diff --git a/qemu-options.hx b/qemu-options.hx
index ab23f14d217..aa44b0e34ae 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5347,13 +5347,6 @@ SRST
         specified, the former is passed to semihosting as it always
         takes precedence.
 ERST
-DEF("old-param", 0, QEMU_OPTION_old_param,
-    "-old-param      old param mode\n", QEMU_ARCH_ARM)
-SRST
-``-old-param``
-    Old param mode (ARM only).
-ERST
-
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
     "-sandbox on[,obsolete=allow|deny][,elevateprivileges=allow|deny|children]\n" \
     "          [,spawn=allow|deny][,resourcecontrol=allow|deny]\n" \
-- 
2.43.0


