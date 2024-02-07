Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC67DC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwJ-0002r6-Im; Wed, 07 Feb 2024 11:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwH-0002pQ-Ln
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:21 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwE-00067G-Cr
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:21 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4101d096c92so4429365e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323897; x=1707928697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=al2EF5joR1GpZYix/IJ7sorp1km6Nnx+serOjQtc33w=;
 b=N+kFrznvTJ0P9ZboHnXtaevVALylMSNP24w386OGQE+l3iK6kH3jvDND58pQkemXD0
 a+GoRlPmPN07imDVS90HOho+O3UdnuIfGczSDciXexfPguAVP/Gbd8jNI7CiuuUlpaC6
 rtFDbQs3FQeBNND6Bnt32VlVXThcQ0BPlXDHTj8F66R5qvjErPqOVRA4fyuP2QqBfeNo
 LoVkw0rVcXMLpqXRLnOJuDRVHi9D3bB+OvHbMMNCzqeuIitE6A7NAKJqXbCy1SaX5cR1
 5ly7UNsiDcxJfg4jkKNJXZIgNJYZxLKlIfQOduwbXnJYldB7Edb6BDqIWW1s+WjIsh+r
 rQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323897; x=1707928697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=al2EF5joR1GpZYix/IJ7sorp1km6Nnx+serOjQtc33w=;
 b=GGvcpTemdTbemJhzqwSmH/SEzqQDYML9aTFa4WZrvM0dpaAe2G2qSXoYDbDJ9W/r0P
 3B69I6D/2pE9iEfgyU4E+UF17kPANRjs50ukn7qUaRXH81kxKt9+1zmo44Ur+UP0MiP8
 evidrwoUKtyrbPGZtvrbtuwdv0PRX6kvh3ljE01b7saVLeCCgyjbXYfC9WNUkTzMjwZi
 Ui0zzKD5OPszsNsPN/hRXP2FZjvAq2erMMF2FkpFWKk4au0avGk/z4lDQvr+ZTupwF2a
 vrgnl8wHw/l5b9w2BS6OjthmMgTq+JpchUoFi0J9noDRDwXP9LhnplGScYPfr2qeECql
 w0vg==
X-Gm-Message-State: AOJu0YwCzNcM73ga5dGZRN8IprctjfMdRC+ewmiXDmKThHuXNnJ0ecfv
 Rv1Sky1ddQ8+4X45nfl4r74D8pKpqei/s59eRwTAIciNUEOwZcKY7ZHisAxGirw=
X-Google-Smtp-Source: AGHT+IEllApoBVS2Af8bGtwiTxz/SrARQDrYzHCX+zMsLKLvVQIjfNdJUEgGbhM6ZEDvEQgUjp9vOQ==
X-Received: by 2002:a5d:6703:0:b0:33b:1ae4:10b1 with SMTP id
 o3-20020a5d6703000000b0033b1ae410b1mr3549305wru.47.1707323896841; 
 Wed, 07 Feb 2024 08:38:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU4pOfHiiGwCo4OdHghcmtkfTz/YfCpp7vi1P0k0xuEn7MMyfZkDp5SuiQyA+Dalk1TdFnzHYKAox7Cy2JBgUZvuV7AZWigReJq216WwBzezxWAcZ9bhnJQRXY2r0SV3mP8Tdnhel2lFPGIg2QKfsoGxAX6bATIC7y+sY9yBvBzKf8e/0ixlUCJFHy2ET3h4d9K4yPGT+UlK5zEtL3cEY0lRAFrRNFSNAEkudXO0jP81UW4Zl2AhKcYL6trJCRRZsToazF0RfHIgM+0nifwnqbafeCwP8Q+icMq2dVZkrxchd8ENxvMq3gtJWLuWTWIR0JNrfgc7BuLg4iQEYhNDmsRkTBnC6lqKreHleXYUqIkuoO17HJqdfmypDi+GS61iYaGNm6QSX95W4vqYBgJMLw1ukGO2Ziq3+aGhI+imBOSZ8HdelrkoaPUfJ/G2LGEGqCGLhvJk0RsOWyf8rUYpNr4E5VqVSNYF8rS7HI6wFQASzJeiVWZHPg2nrSjR+2USFDTG8FhgsMl/oWzZ2At9aXfcqxrwy9JRw9S71iJpLlNI6r1wkTvYKpgdcb3loyeVSRdBF9wk5mVZcMUCNprRJ7n6+OQbwWezf0y3wM7TNy6UYvOeKNQOSY8M76BnlFCy3Wfd0jYtU47cp02K7Vk1fw6bPr44uKVeyZQlwXfZFidPwYQESasogOqF1TYk/R/tCiAz4xyHqahKHEwaxfSwq7EGp5ChGqGqv8PakDLFUbxjElwOLUZ8halcTPZ2Fh72XskZVGrX/coi08kcBIduLGN3gKulq+c3/782DnwQc0MeM1LAPV+uT+DdlDYBBmjUDooTTp6Uu9WTxk=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 az2-20020a05600c600200b00410141aa57csm2062945wmb.15.2024.02.07.08.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7A6545F895;
 Wed,  7 Feb 2024 16:38:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>
Subject: [PATCH v2 04/14] Revert "hw/elf_ops: Ignore loadable segments with
 zero size"
Date: Wed,  7 Feb 2024 16:38:02 +0000
Message-Id: <20240207163812.3231697-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Message-Id: <20240201122835.1712347-5-alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


