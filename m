Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6834CD043B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd05Z-0005c1-Rm; Tue, 06 Jan 2026 00:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05Y-0005Pd-3I
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:40 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05W-0002cu-CI
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:39 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-34f634dbfd6so4086a91.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679117; x=1768283917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPjM/mNyxZhExOHgixfVJoXuZ2ToFw6rHXAzW208+YI=;
 b=f+3gMRJHK+4k6B8mK2mnR7eBhdwmM6nXREM0KVQvt6NbR7rnTW2WJdm8uIs6x8FylH
 qwH6sGH0CbBjJt8lSnf3BLdvwJ6U6uGheauftPLkPjmclbgny2OqOJMuTTe84YUPaceN
 1a96apzZMl7AfqotCao2z7SP03Bvxjm2+6KbbUkPe2vqkJAL7T7IXz3nQSkYXJEfGzA1
 IooRoINU4/jAiW7hEiFf0sKUhDch9wIWtijM3oOm0juX6DTyJCLeC3R7f/bMz2mN9rEY
 OfYahjP5uj2L6GGNBnsrPDdcNMix4b9ZKu4nXem2dmVTN3Z2TLwtpGLtYST6Jmx9Uy7x
 ZUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679117; x=1768283917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aPjM/mNyxZhExOHgixfVJoXuZ2ToFw6rHXAzW208+YI=;
 b=Amfc8kF0Y/LzLJCFMitqNMcE+RShYYTx5F2l62/bgHGo7sPEU3tajNqQJfFdm7Ogfk
 y2vWLFylIrM5bxomRM/l2Bl8hGu/eVzZLO8PALAD7jIrFpzGjG3sBy3lx9OSMkzwWR9W
 OyaZx7yk8GhdbB1Iv9gT/oN4piTGjwZkVayrB0q+K5dIYQPXv8Y7D/Ibm+SPzTvp95UH
 q71UCnCZJo/kv9Om6xXcvfroMuCUftQau4qKlXJqJjXISFYAc1vFk6LDGTYhjVdgAju/
 CpuSygjzfalQyHYlM6CfKL1vd+aiW5IN0ZMOpeR6IQlmLqct/EuEkUAPxpcEWqT7e79n
 INrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP+KUQTsJYYFvbgfv/NoYt5+1BabGMA6J4M3GPiNqZ58Gja7IU/oSn1fF1439VdE4sBCNSBNLlj/wM@nongnu.org
X-Gm-Message-State: AOJu0YyDh5SxQFxRQQwc/Zabuq8eLAWsmFIhaDAh90PKYdmbgt77tyUT
 hQ4DuiSXnI9T69sE3WpuEX9B8+sgt4lOzLCBF0mNDN4Ab8H3NC0Ar3Ks
X-Gm-Gg: AY/fxX5tHU8AwrBJWYa5GTKYDooZ1F+Rbyuo8p/k9trgGrulsP9apSuRm9QxMagTi0F
 xVAZHG2tubI54FFqKIVtaaCkuaNiMgsps5GPAmtsSFLQss6IkUeUihEi8D45Y5yUVyE4u4IFbk1
 pHZ1qJLFCVrZQdEcIEbsbke97NHT8km0Y8wGQzFPBKObZ2hoXin8ieAdselRa3of30kNZ9f0Qty
 vnspFx9eSWbMYyldx4alfPPXB/bMo/3yduh0J/x7QyZ/mW8fUS27T2z7CPjXvRUtVWGVTSwREiI
 QEr8Arg5YeB81u2Goe/qNaEZRpr/sQ+wTe31ibQgXofM2GuIlqX0walH76dU/Lpmop1aDBJjB+j
 0cewUeOTJ+RRLFQyxoftOE7OyyDXNI/N4mH0lbNaoGvnV8D9WbENkI5BK00NvOcKx+FpRugRGaf
 Css9ZOGAn8ExPEpGJjLRVDdQsil3bUnMA=
X-Google-Smtp-Source: AGHT+IG15ub/u40jpDBsW4flt0eqMTrpOCPVkrdlJqIU/B64ZiDEtfAyxrkT9anpV3ytNglLgjxhUQ==
X-Received: by 2002:a17:90b:2245:b0:339:ec9c:b275 with SMTP id
 98e67ed59e1d1-34f5f26df4emr1761597a91.6.1767679117044; 
 Mon, 05 Jan 2026 21:58:37 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:58:36 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 14/16] hw/riscv/boot: Warn if a ELF format file is loaded as a
 binary
Date: Tue,  6 Jan 2026 16:26:54 +1030
Message-ID: <20260106055658.209029-15-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
index ef9751730ee1..9f940c915620 100644
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


