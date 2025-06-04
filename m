Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3E5C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMs48-0000QE-Hl; Wed, 04 Jun 2025 13:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs47-0000Pg-7z
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:38:15 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs44-000355-Rd
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:38:14 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22c33677183so1069975ad.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749058689; x=1749663489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGdzMHaC98xoNo4pnLALcBmJMoP7ii68m6A0DOqBTrI=;
 b=S+9ntWpO95mI1U3SmAMN5XNtNDCAS0r0H1RzrXUF23teXnQ4kgBV4PrqfJadhwVi5Y
 QpWIf7IL6sjSYep7aFAlIo1ZsBvyuCp1KnCe0ImljS/SatshVL5xW7PJHl8/jyeFE1P7
 B8fr3nuboqr+jKC2AQCf089/1/HXSTBbFreJ67a+w55HCuKVHV+4I6oIbRzKuYE9ZET0
 yHWHD7628eQ9qDHtl9RkIJmERuzA1yYynoFDn47px2VmHBVyuwvbnmMqkSr226kI7xg6
 qjCQAht6lpw4JY3XsvEUqgJM1J9nYnzbYJM9cXo5cPEzJXeDjUXP3ExM6ZXRywzmZy+i
 cTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749058689; x=1749663489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGdzMHaC98xoNo4pnLALcBmJMoP7ii68m6A0DOqBTrI=;
 b=nB42bkY2+UsoFsRk5MRZVfT0LfIltr7KxwlPeXQhsh5xEwG7E2ie/deWUFOZoMKW6i
 XpZI0K11RhR7OP4025TzO4MyBsOWpawG2qAHKofbnO+Q7kDd7AB4aq8fSkPhy/tfX/Pc
 B6DOC4KHt2cE759t7yPCVREo8ZXvDh67nL4ZK607Xl/2cWh1AVHA6iG1hKShnDu05ZdK
 pI8FQFOVzvsQ4yVhSXNilFDZN2VtoV3batD8lEbpxd2V4pd1B7iEErRNKoLM7Lrx8xkl
 BT3U4SCBNfZxZ7ZMLHHbuVkVxfuvQF0endb1EPdbSHzWoqpiPk/Uy/9PCXImeEnq6n7P
 l+fw==
X-Gm-Message-State: AOJu0Yylav5kdRtVolsHJg4CIcTWawGJgtiVnK5Sg01EC9Y+JL13PjAd
 paWlKpxxDZo4yVih4GfYzH4EbLGSb6Q4pducPjWmo9aqX0xOrelsIJonrQ62kdlh+xehqp6/Sh7
 AV1jpR30=
X-Gm-Gg: ASbGnctSkxPdbZ3hy8nES/MgMPuxRUZdmKeoPI3LPEV5szgjK1/atL1RHWpeTaUtjAF
 9QXrvULPOjfS9KYAdLNsR26OfEtp0F/mhq60rVn0cDEK6Xl0Q8XtsNdR/b8DGac3zbmGK4F7lRs
 zO4BvQ8+mLU9Esu/C1bRpDSflozr+gSXq4CBb8VoV8RpPjWe+fqRPP9UfuvYE6Eb403oI9CCEI4
 hD6M3jAFaKBLidPRhWpq01+ZGcL3uhfDv1IRAiBbwQCBIRPLg3nAZsr0RI7bKb2giTR/ACMZOcQ
 +nHKdEi8sIJo227Nw7J8I6ukZ7BhVXIgRI+0IjvQyUywCBhSoCCPoU1h3le8Kmd4/7j9ps2RmnJ
 aV3iL
X-Google-Smtp-Source: AGHT+IHtwh1P6zEfxLfE2Cr9IqN7JbF1EhA0PTgBRyqfLAITnZJcXBRwHy+vBYktAOxMpWtNBL88nQ==
X-Received: by 2002:a17:902:fc46:b0:234:986c:66f9 with SMTP id
 d9443c01a7336-235e11509a8mr59120515ad.22.1749058689334; 
 Wed, 04 Jun 2025 10:38:09 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cfcbb9sm106913215ad.208.2025.06.04.10.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 10:38:08 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/3] target/riscv/cpu.c: add 'sdtrig' in riscv,isa
Date: Wed,  4 Jun 2025 14:37:55 -0300
Message-ID: <20250604173800.1147364-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604173800.1147364-1-dbarboza@ventanamicro.com>
References: <20250604173800.1147364-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

We have support for sdtrig for awhile but we are not advertising it. It
is enabled by default via the 'debug' flag. Use the same flag to also
advertise sdtrig.

Add an exception in disable_priv_spec_isa_exts() to avoid spamming
warnings for 'sdtrig' for vendor CPUs like sifive_u.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                |   1 +
 target/riscv/tcg/tcg-cpu.c        |   9 +++++++++
 tests/data/acpi/riscv64/virt/RHCT | Bin 400 -> 406 bytes
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ee3ee0e883..eeb44a2f1e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -189,6 +189,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 81174de409..7fbfc26adf 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -451,6 +451,15 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
                 continue;
             }
 
+            /*
+             * cpu.debug = true is marked as 'sdtrig', priv spec 1.12.
+             * Skip this warning dince existing CPUs with older priv
+             * specd and debug = true will be impacted.
+             */
+            if (!strcmp(edata->name, "sdtrig")) {
+                continue;
+            }
+
             isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
 
             /*
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 13c8025b868051485be5ba62974a22971a07bc6a..156607dec45b0e63e5b3ebed62e81076dacd80d0 100644
GIT binary patch
delta 49
zcmbQhJdK$v$iq2g8Y2S(<Ex2W2COEGj0`#x?N_s=loVyAPkd23IgL??BZrZJp^TA%
F0RTq!4730M

delta 43
zcmbQnJb{@j$iq2g0wV(h<JXB?2CRCFj0~z1?N?9ySUowLQJEu+k%6Irk%0jK_Q(p3

-- 
2.49.0


