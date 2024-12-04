Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D86E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvy4-0000CN-Jc; Wed, 04 Dec 2024 15:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvy0-00007O-NV
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:27:25 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvxx-0008Pc-Uz
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:27:24 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso130881f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344040; x=1733948840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYgcsQiZUJ1Cl6dAvq/NYt2lHMXmmLs9dt69qfBSoSM=;
 b=h+JoFZKzpu9gSZc5hDJUoT9H4l1OxzrE+/9CuboSMA6jmPRKbDuLiVBuBd5qJ8YX9B
 Zl/72c+emeNclhwRQ0KlZAedOde2uRgAVGpMfPUXr9mj+fvsZf/N5og0xKvSw7f2CLjo
 iPWLKfaMWYiavpnhRRe8b/rTCvfs5iIUnyLn0OOJJv5Pf6kGQ5A6/oAIl1EHu3nNTl3n
 HeNtp/GV5c3SDfjrWE7eUQcTdvsSJRokhlBvcendyuLp9JtEfpaWnZUE4s9iy95GpjZu
 z6YJSpPoh9Xqj7Yrit2cFbkpvtbrRh9G/wPLdGPs66vQbSBa1jOF8VU9dZG5zd+0cd+v
 yLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344040; x=1733948840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CYgcsQiZUJ1Cl6dAvq/NYt2lHMXmmLs9dt69qfBSoSM=;
 b=GQ9XYfLl2NQu/zfEbGJgnOsGYPfQ209AJyxJd9uidiRk2wDWK4N3iWqn6AFFGeS2ZO
 BULl2zoGTTdNeIB/FDiMU+RkK5FfDSA1apV0XwFZ5K0seUdNmFCs3a7jCOaGPd5MVH4f
 tHaVczs5qJns/EyvkkDaNni831Byb7fyWCe2w+P+uQAqvr+yBVhs2voi3EIzax3TiCHq
 dsQfJfWj1tgNCS77ODA6DwQNc6Xz7SeFZqNAcAiFkInCsv/HotWSwsPFCr69J0cl0zTF
 4JI3WTrNWl0NEigcX8BWpJQr6nNU+yhr3fSl7PfzrewKMf3B+RNO7l9musadLFf2nIln
 zC8A==
X-Gm-Message-State: AOJu0YyYEQlTHXPqnPlUCyDb8SqNewMKQaGbPT8cbSOdGKmlArHv8eeV
 L4/fn+l8GiYTckHTgAyAuGoLrkGN0aVWn8UIjd+DjnF0jg7px2QCuCZEI6Ori2iXNcrq2NyWgcM
 e
X-Gm-Gg: ASbGncvBsf4LDXj0XB1NxoYaNUEOB9KbR/zWRThSS1TH6sdBlLDlYhy294n3FCv+QTN
 JZcXASNbllYHhwv1Cl3FkFs01H/WnkRF7MxLXLoOaLYVSiO0QC9nM3iOn/Y4B6LFYwrIvcurR14
 WucovC4Qp9PpRQOuBpKqk2kXd0JrzLXUyXRniUuwqvs+ZPh09fMQWAW12JmCnolGUlDLWL1vJe/
 rk14RTYWqRXFVZwut5a26EuX//CaNhY9NTExklxd8jj3ViiaiQrFHAW4PW6wcXWjcCJuzzV9e8B
 2/YjOf1EO0hICg+AD2vr+IV+
X-Google-Smtp-Source: AGHT+IES6IWDwM10SRQCYybARo6OEDntD5HB1a1zGV9qWqBypkoO2dssjpIRw+NSHmnqVoKSSH4lYw==
X-Received: by 2002:a05:6000:1a86:b0:385:f527:be6d with SMTP id
 ffacd0b85a97d-385fd423e63mr7466801f8f.36.1733344040287; 
 Wed, 04 Dec 2024 12:27:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e49cd788sm13643172f8f.6.2024.12.04.12.27.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:27:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/20] target/riscv: Implement CPUClass::datapath_is_big_endian
Date: Wed,  4 Dec 2024 21:25:49 +0100
Message-ID: <20241204202602.58083-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

While the RISC-V data endianness can be changed at runtime,
we do not implement that. The current translation code assumes
little-endian memory accesses (See commit a2f827ff4f4 "target/riscv:
accessors to registers upper part and 128-bit load/store").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b52..b31b9b3471d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -60,6 +60,22 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu)
     return riscv_cpu_mxl(&cpu->env) == MXL_RV32;
 }
 
+static bool riscv_cpu_datapath_is_big_endian(CPUState *cs)
+{
+#ifndef CONFIG_USER_ONLY
+    /*
+     * A couple of bits in MSTATUS set the endianness:
+     *  - MSTATUS_UBE (User-mode),
+     *  - MSTATUS_SBE (Supervisor-mode),
+     *  - MSTATUS_MBE (Machine-mode)
+     * but we don't implement that yet.
+     */
+    return false;
+#else
+    return false;
+#endif
+}
+
 /* Hash that stores general user set numeric options */
 static GHashTable *general_user_opts;
 
@@ -2764,6 +2780,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = riscv_cpu_class_by_name;
+    cc->datapath_is_big_endian = riscv_cpu_datapath_is_big_endian;
     cc->has_work = riscv_cpu_has_work;
     cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = riscv_cpu_dump_state;
-- 
2.45.2


