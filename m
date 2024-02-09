Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E7FC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWqr-0005YV-T0; Fri, 09 Feb 2024 14:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqd-0005Vs-Ix
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:43 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqa-0005Ap-ON
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:43 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33b29b5eab5so650414f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707508058; x=1708112858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LPZ5f6J+7DZZSWTcdB8sRpzvNp85w3nAGoLqoRKgsw=;
 b=HRROj/awN8A5LUR200KIH+IV8QwhtEjzlNJ1OJ2EAJdhgxOq+4jfLE3/RA41uhyhsC
 ycLPEpcrXIH6L5LQttEqL+JZsv3BomvI/9ZnAYAUKtYF/Y2wcMcNkCfWAN3HG9jGIZy9
 XO1v2OgmC0N8x7Eh7NTSSZBw0rukQfYeqiEngTMq37VgwUsfv0kynpMKwEu67lEM7EeK
 ABTur091BhBwlZsuFmeA5cohbz+9omJnmHHPA30SdNkJfz1Ew98axNnuy+al01zksJLZ
 sV7pMqf5f6KQr5qonD/v3lcCtOL7CvFQrAxM3OxZo3N4cAer55HwgWUHMbhejTIFMJfW
 wpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707508058; x=1708112858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LPZ5f6J+7DZZSWTcdB8sRpzvNp85w3nAGoLqoRKgsw=;
 b=cSwi8o/fdpoqAwF5JFfX6qzEeKMRZSjuEUCHgRxwbLq5FTuQuU/TqnRvy92lKmFnGp
 D3z81u2PRrMJDFAuNSMZyjAzddhTrhMMH1NMqD9uhWpRUBT/ZdBJrQaKXMqOctUWaFjk
 aHMD/T1Fukj3HJBp6fQjOQ5OuXMkQ7lx0Bb+ZTnIGe5NDomo3rU4Ty2z4jKw9sSHPq2K
 MIVx+s0AYZM9VY+KvfnUVG8bKhEHG6sRATA5KVLb5d/pgbdV+9afj8vEAPyoOXnIrdj2
 hdZrJ1PpiibFmvawijh1BuA4Yq6FGEDrfJEqd1jQpF1DGqc0Uehf97jzmGwqJ4HFRew7
 ig5g==
X-Gm-Message-State: AOJu0Yw7+jfw8cMLPg8UmVo3c+2WPSHl1NuXeebNl10NZ89l4sGy6oCQ
 PIL5EOhpw4OoeZPk2sq/6yh85VfeIJ3KDLX9LpWe3oxqFB+y4uDpqG/45x9Iz72rpyrVY6PDQD6
 /
X-Google-Smtp-Source: AGHT+IG3eQ7LtdMk3G7CRSmVPtS4lk10UbCi3/bv5K8bUhVfhRZAaUQ+9b0OrMMtC8wnNd+Eo2+BQg==
X-Received: by 2002:adf:e4cf:0:b0:33b:998:3643 with SMTP id
 v15-20020adfe4cf000000b0033b09983643mr5665wrm.34.1707508057871; 
 Fri, 09 Feb 2024 11:47:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWxrhbjiyT22CxsKfl6zNEko5qEizQpvyV5EYy52uqvfHT5+xIuWPN26Sn2v4/pNusVdWizMGMBmZoQ8vPjrMZl
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c1-20020a056000104100b0033905a60689sm53030wrx.45.2024.02.09.11.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:47:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0AF455F8A7;
 Fri,  9 Feb 2024 19:47:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/10] Revert "hw/elf_ops: Ignore loadable segments with zero
 size"
Date: Fri,  9 Feb 2024 19:47:28 +0000
Message-Id: <20240209194734.3424785-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209194734.3424785-1-alex.bennee@linaro.org>
References: <20240209194734.3424785-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240207163812.3231697-5-alex.bennee@linaro.org>

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


