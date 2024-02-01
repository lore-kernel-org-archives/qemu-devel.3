Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1E9C4828C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWBR-0007qy-Jf; Thu, 01 Feb 2024 07:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVWBP-0007pQ-KM
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:28:43 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVWBN-0002Av-C2
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:28:43 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55c2cf644f3so1113389a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706790519; x=1707395319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TIyz7/5C01pE+WSqKNz5zxOPpiT8BdSgjCe1JUQ504=;
 b=iKFzcPNBT4hBJlKNTH47w2k7xk2xnvjUB0Lm5z+IxjbJfy/kbFDSE4MWl9oqQwJO2B
 zBcuNSvEul1e45KiHJ/gMvsc7/HfMocY4YC0o4AxiF91KDlf0QlKzOkj0EIAWUZf4EFv
 77ZoAGIo4/aVBR35qYlDrqZ9scTZrnB8n0Jt52pmf9ab2sCGrdi56FAj7raReni6JmSs
 d9kgPIJgaMZey0sPkIGfsy4VkMwloiU4LteTRJf6fSDlS+6KQ1ohkJCW8v6lBJAUQ9WB
 kh9u8YuH7u+O7Ozu3sYRa0W2mvjR30Czo/wBbU8gTg35rKezoc8zT9AWt1WYypMy8Xl4
 tRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706790519; x=1707395319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TIyz7/5C01pE+WSqKNz5zxOPpiT8BdSgjCe1JUQ504=;
 b=ldu/uD9g0KyD8Qc6z/r4hBn65F6z3AvRoU21Ok4bXJj8dCLXYoQyoE553KrqZMgi9f
 RbZLhMoY0fpzBSHN0REeR9a1juppHfV50um242T9F8x8AZAK0mMkXl763/CZ6ET/mlLy
 h4QL9x+0ScJABPLvQ+DBMDwJhd3dE34GYf3LsB9RdxXtjGmAL8zpxLFOdNE7yATT6i/F
 tUcBYXf2BXzVuMfXhGRjXML27/1UqXAOvROClhYr9fIXOd9DcxRaBxIAsd0qM8kFiUH8
 jIQcV+Eo8BGsEQbrye5X6nrQvHTyIgZojmsiFN02zhm+IMJV4rth2UykoYkGQNGGQI7N
 F1TQ==
X-Gm-Message-State: AOJu0YwAXaq5/BDc7kCSmCz/3dXQlgIBXpm+rDkILhGnRl/K9wDuOFMa
 rlQY0n8AtRbEPA87EQRGsKqhc2DomIOnba7qYeZMMDNcFT7scsJjnU/V35LnGBw=
X-Google-Smtp-Source: AGHT+IHxgV7bzGmvJmYDMfkZzy3sm3ndOVRBWrFh7bUG5k2eu/yqJgeQqWkvo5P/d9q+uORlG1tyHQ==
X-Received: by 2002:a50:c35a:0:b0:55e:dbb8:4c6b with SMTP id
 q26-20020a50c35a000000b0055edbb84c6bmr3262632edb.42.1706790518811; 
 Thu, 01 Feb 2024 04:28:38 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXV63BBOD1doNfROSikQ+uHSekeSYo5CJveFGyWQ+kPkTaqLMFJZRuoSpP65MHERodTnenmx8G/AjLsGYLHOawz42s0Hk1E/qCLREc4mQVL2IBtyjHj8Ek/AdTy4YeY3WNBrlQtgv9jl2gqRqffF/pUwX4WQekAEWDopbI4KcrGyXi+3RuRRhdoFjl3R6t52FhAOJitPp9LND9aJ++sGJRLsUEizQt2GSRDd/j3kTkQVPtA5HcXA2dnG677nzvUTq8DI6/MsxaLprrdk7FUTlXvBXht2QC1Ypp+XmwRDEx/P1ngzbuD7Y/HgiHHWxYjPLbkZ4h3P2tHLVtUc/EVALkxYY4peXwzJ9a7jr7halPZkSzOBOHRJ7/M4HjFMG+zuEqXAM7X3njgAUud0U3e6yrYYXlIKI8N5M/CbdxVVH3PH9NV1BcdaQcc+2lPyREEutUKVxNeCI4kg7loti/s0AMaS73fqBWGvLvkFxBQmVp84EgSSH15eMRJ2JdL/YD7eOC9BAnCQJEXyqFfVslffqlj47LPMEPAlSiFD9vAAcKqZ/IcaC8VBOku4vqWHd4sEXWbqk6vqY9riklq8CnyfvMIbPiXCbv0fOW2dRzixEU3/wUwibpIZzqmbnw4QFmyZ0/hlWd3m3A=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n17-20020aa7c791000000b0055f283314e1sm3153680eds.43.2024.02.01.04.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 04:28:36 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A41CA5F9DC;
 Thu,  1 Feb 2024 12:28:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Beraldo Leal <bleal@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chris Wulff <crwulff@gmail.com>
Subject: [PATCH 4/5] Revert "hw/elf_ops: Ignore loadable segments with zero
 size"
Date: Thu,  1 Feb 2024 12:28:34 +0000
Message-Id: <20240201122835.1712347-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201122835.1712347-1-alex.bennee@linaro.org>
References: <20240201122835.1712347-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This regressed qemu-system-xtensa:

    TEST    test_load_store on xtensa
  qemu-system-xtensa: Some ROM regions are overlapping
  These ROM regions might have been loaded by direct user request or by default.
  They could be BIOS/firmware images, a guest kernel, initrd or some other file loaded into guest memory.
  Check whether you intended to load all this guest code, and whether it has been built to load to the correct addresses.

  The following two regions overlap (in the memory address space):
    test_load_store ELF program header segment 1 (addresses 0x0000000000001000 - 0x0000000000001f26)
    test_load_store ELF program header segment 2 (addresses 0x0000000000001ab8 - 0x0000000000001ab8)
  make[1]: *** [Makefile:187: run-test_load_store] Error 1

This reverts commit 62570f1434160d356311e1c217537e24a4ac85cd.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/elf_ops.h | 75 +++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 3e966ddd5a1..9c35d1b9da6 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -427,16 +427,6 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             file_size = ph->p_filesz; /* Size of the allocated data */
             data_offset = ph->p_offset; /* Offset where the data is located */
 
-            /*
-             * Some ELF files really do have segments of zero size;
-             * just ignore them rather than trying to set the wrong addr,
-             * or create empty ROM blobs, because the zero-length blob can
-             * falsely trigger the overlapping-ROM-blobs check.
-             */
-            if (mem_size == 0) {
-                continue;
-            }
-
             if (file_size > 0) {
                 if (g_mapped_file_get_length(mapped_file) <
                     file_size + data_offset) {
@@ -540,38 +530,45 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
                 *pentry = ehdr.e_entry - ph->p_vaddr + ph->p_paddr;
             }
 
-            if (load_rom) {
-                g_autofree char *label =
-                    g_strdup_printf("%s ELF program header segment %d",
-                                    name, i);
-
-                /*
-                 * rom_add_elf_program() takes its own reference to
-                 * 'mapped_file'.
-                 */
-                rom_add_elf_program(label, mapped_file, data, file_size,
-                                    mem_size, addr, as);
-            } else {
-                MemTxResult res;
-
-                res = address_space_write(as ? as : &address_space_memory,
-                                          addr, MEMTXATTRS_UNSPECIFIED,
-                                          data, file_size);
-                if (res != MEMTX_OK) {
-                    goto fail;
-                }
-                /*
-                 * We need to zero'ify the space that is not copied
-                 * from file
-                 */
-                if (file_size < mem_size) {
-                    res = address_space_set(as ? as : &address_space_memory,
-                                            addr + file_size, 0,
-                                            mem_size - file_size,
-                                            MEMTXATTRS_UNSPECIFIED);
+            /* Some ELF files really do have segments of zero size;
+             * just ignore them rather than trying to create empty
+             * ROM blobs, because the zero-length blob can falsely
+             * trigger the overlapping-ROM-blobs check.
+             */
+            if (mem_size != 0) {
+                if (load_rom) {
+                    g_autofree char *label =
+                        g_strdup_printf("%s ELF program header segment %d",
+                                        name, i);
+
+                    /*
+                     * rom_add_elf_program() takes its own reference to
+                     * 'mapped_file'.
+                     */
+                    rom_add_elf_program(label, mapped_file, data, file_size,
+                                        mem_size, addr, as);
+                } else {
+                    MemTxResult res;
+
+                    res = address_space_write(as ? as : &address_space_memory,
+                                              addr, MEMTXATTRS_UNSPECIFIED,
+                                              data, file_size);
                     if (res != MEMTX_OK) {
                         goto fail;
                     }
+                    /*
+                     * We need to zero'ify the space that is not copied
+                     * from file
+                     */
+                    if (file_size < mem_size) {
+                        res = address_space_set(as ? as : &address_space_memory,
+                                                addr + file_size, 0,
+                                                mem_size - file_size,
+                                                MEMTXATTRS_UNSPECIFIED);
+                        if (res != MEMTX_OK) {
+                            goto fail;
+                        }
+                    }
                 }
             }
 
-- 
2.39.2


