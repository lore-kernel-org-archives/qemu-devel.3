Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6DDD1A610
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 13:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veCNZ-00075V-GW; Fri, 09 Jan 2026 08:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCN7-0006zC-Cb
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:17:46 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCN3-0005vs-1w
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:17:43 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso44847215ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 05:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767964659; x=1768569459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AotlSXgtMThsWPFh4xyqLvvRMQWRm88XvYR4PBobHgk=;
 b=XY4FmjRBVyNZ98uQgqCWELlxJoQr7XLQzjjJXVJsY8o14IhudhTkWkKZ86mr8PqBl9
 8MPurQzAs86nKVclFBW744Tug0xzCIOB92c3x8M2wqjkOqUWx8sgJ9OJ1YA/Mzan7C7g
 lU1+HAisOQ7cCa2M+CC72R3aK/AYFu91FkMC30hERLFcEtiee2/hjxcrOQiVfFTNkkmQ
 vcz0WqZBhufh0GdxwYqL/p/TSRx0IqNWbPmJbKOq/K75xLwSatqFeuD4jzrowDhefSmY
 FPYh50DWaDWfTODqFLAhKjwl7c9k/9CkvVfmzgySuOpi6uNaEqyB3hgq2T2xZZwF4CYk
 kzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767964659; x=1768569459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AotlSXgtMThsWPFh4xyqLvvRMQWRm88XvYR4PBobHgk=;
 b=PYXKO/6T30LQrj/tEEaA+WCImcEQ3mhWZQs2KPwk3H81KAY0jGKOeWgiiVEYet1TRQ
 ciyDWflaYIqrh5PUaz3LlSMUM65RRgm/WYfrLK2orgPWEEDsk5CMZ5o6WbWAOzGwKAGe
 BZDPcen+OIqIz6ISen1pc2OjLPVDmHFt/vRHOO6h0YyNTNUcztF51RG6yqXRnEJPb16/
 lt+h6cXLow9n5UDePZw4iSgasl9R2vj/EN+AJD7aLOIWM3nsVuHwiTM+uQPt6U1uvXrr
 mAbuwvJuED4OCY5y145DHtDT+RD20bQMvMFdBecoiYs8AS6j3ypd8ihfdvuonLZdf9cD
 yrFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN7xvvXdAcK+s9j8yvtUUfjHPFKdnjIEqx11at/m2esgpjmP12+YBm7Au+tBGQfAoyakXcrH9uZ/uP@nongnu.org
X-Gm-Message-State: AOJu0YxFTubqlCnjCMQwAu0ZOHbl0HcxED3+Xc+j59FuSLEHUlkCgh5/
 +duxgvYMp38P3CcLD9qygdtSVW/CQbzkj84mNR8pAPHyuvTTmaxArxHN
X-Gm-Gg: AY/fxX5QdqlwKop2e6AoaNVVSYJ83gxjTKqBi7W9Bkek1F4MdtcWBDNJ0pzW+fR84os
 VOEq1sinKu6OQiWBB5li8N/h/Cs6s67tDp/80CkTmU+oU99QGv/qcES6rdNZNsOWpucclK35LbC
 1JQm99+PcexMgoIKaku7nDtxoD2OMDiT4+Yc87dYXqjlo+h2cdezDHFi8U/3eL+Qq3vcHb0KZBH
 RW8LGzpRFyDy4urD3VPhZbEwA27xG1bOFR+iNk0kEt67gvRxxuInE2QurO4EZMM5lJVy5CJujgs
 SezNOL9b3H02wPx8trUfw4hBqmO1x2LVh/PldsiL+lgP91UnIhN+Qb3qgANSsl0+5plA+u+ivBe
 BrQl8b9VrpU8yZcyzxDE9MXbyEuB30LIvPLxTr18OhGz8no9Av8CYNVyJrzaU+jRRYrBmKEwR+Q
 PqXwVkgfidRGCpbceZxB7I
X-Google-Smtp-Source: AGHT+IEXkG5m93JuLmmHhoiXmhLPWoPtnfIQncLSHPXliQNnunzi8EyPLWvQnB/RqZg4tqNnD8GVzw==
X-Received: by 2002:a17:903:230f:b0:258:f033:3ff9 with SMTP id
 d9443c01a7336-2a3ee4b2467mr99411425ad.48.1767964659401; 
 Fri, 09 Jan 2026 05:17:39 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c47390sm106103735ad.25.2026.01.09.05.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 05:17:38 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Vijai Kumar K <vijai@behindbytes.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 3/4] hw/riscv/boot: Warn if a ELF format file is loaded as a
 binary
Date: Fri,  9 Jan 2026 23:46:54 +1030
Message-ID: <20260109131657.396794-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109131657.396794-1-joel@jms.id.au>
References: <20260109131657.396794-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

It is possible that an ELF file can not be loaded, in that
case the loader falls back to loading the file as a binary
blob. Print a warning in this case because it is likely that
it is not intended.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
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


