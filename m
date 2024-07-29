Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C63C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZc-0007BE-FU; Mon, 29 Jul 2024 13:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZP-00066i-Lq
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:54:03 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZL-0000P3-8D
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:54:02 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d2b921cdfso3169260b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275638; x=1722880438;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pr/AcYF8z8+IP/7vhXiuKTgBOUJ+TMutbX74doKlSC0=;
 b=e7F1o4U30ZUifqqc1k2xQbAhvli44x6HlZYgky33EXxaRaYm99063ftc6jbxNBPpNc
 +E8Pu7VfdXSPk30XEpeqC1rMlUx7XwUe+gs9ZkAkDnhh9o/eJNiK9rTIYjGB+UDriYk5
 Th/z4uy/1rikif1fqzPQ/81Aa7Iu7fyHgXAXX4qc4SEhLRTX0KJM0fLAB47NM3jAK3l3
 vH3sepbET2HEXxJe+EJgokRy3CK3jjtOtFONYFyvDHTtLBKj6+Kx3pfvAiRucUVKVNZR
 6iXDmoS4z+uAgEfGFaFIOaMYOgGAV1R3y/aiI4MQ6131uTS4OZjtn/ydKGlDXndMubNh
 ALYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275638; x=1722880438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pr/AcYF8z8+IP/7vhXiuKTgBOUJ+TMutbX74doKlSC0=;
 b=pxuPm3IEdO2n0ezcHJc1YYkkQzZVj7Nvbb9nZo6G9U77E7ibp5xz+fRzNHlQnV1zgN
 uavK1d/95lzmiOjSy4ZW+8ickOwkqqOi+6vaIz7NTp8MSp+soPnkfTiQTPYzNjC+GiXm
 VHLHVr1N4c29YRVEa6y6H+Tg54kG0t9a8HbwSieEzooHuHZU2XEbgF4jxStstKMhu1vY
 +Z52s7rZDCFxLlzBi4OMlV34KF3BUsR4oWU2hiG4SyFJOzudMS77amFSILbNtp4nVbOO
 lXGPepsb4FU4Ujgp7Iz4+GU0zmiNFElTV0b36L42hYpMOiKynMLD3GQ8EiOTs7vvZvgj
 sG8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWGVnQJV8nn/vYHoKJw61Mk1OTJ2+P2PdT25jxbqAL5AkvuOGp/ttBiXb7fQdBE4cb0osQPrMcNdlK4dyA6G+2J/CRNB4=
X-Gm-Message-State: AOJu0Yz7fo4GldyUArKxRpKdJa5YcDT9X5zur+AryIf4eQb8PNyAYbkr
 NVwW/+AvGfKNhHLqekx1nnIb0Ukhz1PXV/+qZvI1gcnoGiecFRO26qZY854Mjew=
X-Google-Smtp-Source: AGHT+IE+JAVdCygqc/cQPj9kW6GA8Un/NL9GuhpnzbHcxU8r68n5OIj88j3g/Aw6pSTF3dXSP989Sg==
X-Received: by 2002:a05:6a20:2449:b0:1c3:a63a:cf04 with SMTP id
 adf61e73a8af0-1c4a12d00bdmr11069126637.20.1722275637754; 
 Mon, 29 Jul 2024 10:53:57 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:57 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 22/24] linux-user: permit RISC-V CFI dynamic entry in VDSO
Date: Mon, 29 Jul 2024 10:53:24 -0700
Message-ID: <20240729175327.73705-23-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

RISC-V CFI use new processor-specific dynamic entry in ELF. Permit it in
VDSO post-processing script.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 linux-user/gen-vdso-elfn.c.inc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/linux-user/gen-vdso-elfn.c.inc b/linux-user/gen-vdso-elfn.c.inc
index 95856eb839..59c818eb11 100644
--- a/linux-user/gen-vdso-elfn.c.inc
+++ b/linux-user/gen-vdso-elfn.c.inc
@@ -273,6 +273,13 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
                 errors++;
                 break;
 
+            case PT_LOPROC + 2:
+                /* RISCV_ZICFILP_PLT: for RISC-V zicfilp extension */
+                if (ehdr->e_machine == EM_RISCV) {
+                    break;
+                }
+                goto do_default;
+
             case PT_LOPROC + 3:
                 if (ehdr->e_machine == EM_PPC64) {
                     break;  /* DT_PPC64_OPT: integer bitmask */
-- 
2.44.0


