Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD63FA0C3C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 06:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCu3j-0001N9-4t; Wed, 15 Apr 2026 02:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCu3d-0001LW-Jb
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:49:05 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCu3c-0001k4-0b
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:49:05 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2aae146b604so46020285ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 23:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776235743; x=1776840543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saXM7xSssgxjzAfOLez7avcgUU6NwNqgzcU4H5W0wO8=;
 b=e/D8XYyDJvnLQd2gmxbYyXaRQdlsyudDAcq5iMSw7Mn3VIo6dhbFJVUUcTcP0JOBFA
 E4zwxfZx4zRFTHugN6IciuOtN6Ek5Wd3+L1LbZTt3lzyTHIzqUBNg7TTCp9io8x23etd
 /qGbjYiLMYQBd3xDIZCyz6OOlr6vkjyB9rNJcY8+XlZXus23tZQNp+QfI+b+DZM3x9DM
 rSPU0Kg5e66NCOE5/Hiyo5Ak8EW3PXCNFnQrwruoIFi1bi7KMEkQ7MPs03Dlc9MC5AsO
 GpnjDzgzN2qF7Xlqkoh9fgdDB7wWr6i37+uliTh5+StYR2yiVF6UgwsGdAWEeosNwfwu
 Qs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776235743; x=1776840543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=saXM7xSssgxjzAfOLez7avcgUU6NwNqgzcU4H5W0wO8=;
 b=LRzPEmrxqFdfZtVt6lSt4Qne8XSD+nefskl6xiR+Z1sBPqvMeSy5bg83FAWAzaKy68
 UkbDFB+OxgBL86bBqW24Ce1wVjJDhCXlPMWHYz89Pttsffxc55urVF6YCGIKBbIRaZTt
 kzeuSyLKBHvOC3KintxbXudVF0/D9Fv3MMFGMWniujkUR0KfsgaNYH0Ftuwna4+zSN3/
 3WO6A3EMvZByf4/RQvog//3cN8dpykkC3KQhA7iIGzwMZXT8zT6KrS251DqodjFxPc2w
 KbZtUX45ctFhjc1jhVK1Udm+6rglKOtbZSSHzpH6H9OMcDNJZ8sSBxtytgBlUFBXuRlF
 DZig==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9nQH233ng/MgXrU6HRZpnL8f9ibUkaMnKc2iPoC7NVUvqafpQLk5uaqpj1DECbZ0IYQcr0c0VmAJv@nongnu.org
X-Gm-Message-State: AOJu0YwtwPrpaCzFhsdzKJSCwhOU6QQtNvt3jHFGOEL1xkBEqdowRf2j
 q9FywgQQ5YhvR7BndUh2z2PjlIfvem9/zyDUWhu18XCXKK5lMLc8Uh4L
X-Gm-Gg: AeBDievyq0VIz6Zxv82VCr+VbQXuJbl6WJ1+ZltAB5WfmNx2OmV2I0r5YtY2ArZ7LIt
 54FgkNZ2VUUGnkMQ27+o94dEaf0L+t1MHYwCXzhNkvgIhWj/SvmMsmU/LuO/5IisxWovFv31DPe
 904mAr+UEHuhlT/X15GZ8tQj6orWn8XpkVb3t+pOmDrqgEQbBpKoFj6914T+WEVkGZ2MOxkN6v7
 7hgpewQLHfqGyKake8KZwNUIeIL1bclCzfGRBpFkVpO5vi6FiGdhHTk/4xD7fxhGxuyRYyhc4Dz
 QaEymhgTWNNlcq1kPpjeQi1kPzlNV66M0dBeEo00tT35/LWqEIeImsTqcxRahTaewQyWnfWlaca
 Tm7QoSyMS4z/6ILToufXeLiH0Y9VyDwpivbO+v9W+1tEgx9t7mE47CJ3Dad1ES6OdbIQzraq1EB
 f0NRhyVsgfuZjfJe6b/rn1LGpCBO5DQFB3DLFMggltEkvI1mcScaEvbsKmu7Ob+MU7R5EYLY1Cq
 b/auFeog7YDKx2h8ulVRA==
X-Received: by 2002:a17:903:2ac3:b0:2b2:6b58:9317 with SMTP id
 d9443c01a7336-2b2d5a77878mr201111515ad.39.1776235742750; 
 Tue, 14 Apr 2026 23:49:02 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b478142565sm10353195ad.37.2026.04.14.23.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 23:49:02 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 3/4] hw/riscv/boot: Warn if a ELF format file is loaded as
 a binary
Date: Wed, 15 Apr 2026 16:48:35 +1000
Message-ID: <20260415064838.652297-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415064838.652297-1-joel@jms.id.au>
References: <20260415064838.652297-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nicholas Piggin <npiggin@gmail.com>

It is possible that an ELF file can not be loaded, in that
case the loader falls back to loading the file as a binary
blob. Print a warning in this case because it is likely that
it is not intended.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/boot.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index f3857e984240..3ea95c175c14 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -179,13 +179,27 @@ hwaddr riscv_load_firmware(MachineState *machine,
 
     g_assert(firmware_filename != NULL);
 
-    if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
-                         &firmware_entry, NULL, &firmware_end, NULL,
-                         0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
+    firmware_size = load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
+                                     &firmware_entry, NULL, &firmware_end,
+                                     NULL, 0, EM_RISCV, 1, 0, NULL, false,
+                                     sym_cb);
+    if (firmware_size > 0) {
         *firmware_load_addr = firmware_entry;
         return firmware_end;
     }
 
+    if (firmware_size != ELF_LOAD_NOT_ELF) {
+        /*
+         * If the user specified an ELF format firmware that could not be
+         * loaded as an ELF, it's possible that loading it as a binary is
+         * not what was intended.
+         */
+        warn_report("could not load ELF format firmware '%s' (%s). "
+                    "Attempting to load as binary.",
+                    firmware_filename,
+                    load_elf_strerror(firmware_size));
+    }
+
     firmware_size = load_image_targphys_as(firmware_filename,
                                            *firmware_load_addr,
                                            mem_size, NULL,
@@ -195,7 +209,8 @@ hwaddr riscv_load_firmware(MachineState *machine,
         return *firmware_load_addr + firmware_size;
     }
 
-    error_report("could not load firmware '%s'", firmware_filename);
+    error_report("could not load firmware '%s': %s", firmware_filename,
+                 load_elf_strerror(firmware_size));
     exit(1);
 }
 
-- 
2.47.3


