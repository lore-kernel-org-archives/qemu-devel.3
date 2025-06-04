Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558C4C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMs9c-0005Zh-Qc; Wed, 04 Jun 2025 13:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs9W-0005Wg-27
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:43:51 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs9T-0004Ep-MS
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:43:49 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b26d7ddbfd7so90639a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 10:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749059026; x=1749663826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRzrOe/cf03tnXNq4F7M1tVP+Oou957h+wPpKs536b8=;
 b=Yzj3/AHpUxTKHW27kZXSSWc3pB5pD4rStBKZxrPqmWasSRpTbD6UD9unmCM0jPtJt0
 e98k++0p63HVXMAxdX4YBlZU+G2BNXPPCfsPuyC+bw6ELJ0AvXqKKy+ESlsHKj+CGqEm
 n4PzcHwGW5v6vi4RxHBtR5tWw0MpwynJdFFJ/0iiafxEWzTOs3PqTS5KZHqiSZUe1TkF
 KKXCbL2UA0oem2PPyIQzeONXbgI+7Y4HVrfX1ODxMuiMvuRGn5ITo5QgvlIGhIKYd+Kt
 JLLxVgHD9/b6c248HdAG7auEGOGc5IXl0rI3uLSqcCOUO6UWdnj2u/DXt2ehBXSQ2Poi
 /qTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749059026; x=1749663826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRzrOe/cf03tnXNq4F7M1tVP+Oou957h+wPpKs536b8=;
 b=rJ44m1pXz0IkkS2uQSPtKYsbiZksx5M7AuTlzvEC4lY+g9N3rIOdmHZeer8s9S/Ack
 C7NrJJ+XUk8qijreyGfHIX3O8S5YU4SAcH8L+fm+X4AMksDRB4CQdWV7CBxotnvFOBtr
 OcoLn7G/njtytWg43NO5OU1qbZOvWTmJSEeZOgL8CQwrzVs/+AyWdjeerRz0pU3FUS5V
 IgtBtKHMyqR574hhVFu2Pe7zFmDbIXn+KIANoT+wL1o+t83AS8eb8S8vi9bE3xESKNRy
 gMxDrlMtKalneAn7+YlP/RxU4hAoTCpmmEaHNZM8Hy2BBdDrlIgFpeWljdiRExqZYxlh
 1eAg==
X-Gm-Message-State: AOJu0YyYu1PoMTizk4iH0O0W9UMD6ciVrYbAmu57i9NrIotr3+gC5mm4
 799qFXi5Oq4TpG1K7u4nWOF5HPYp+QcY67hJKR1geNsYYegHPTNIC4G050jgQhnG69Zeoo6ynxU
 9OOmNbtA=
X-Gm-Gg: ASbGnctSKqd7awJto5g/d7Es6pC3qW/rfL1zQhmynJZoqJPBRvmItuXNw4xL/KLaf9b
 gMvMEnC+nN0OZj3dHRh8ozbZzKC8K5sx+pDrjfw20m74196ZN1ZTYh8K2adt0NdyF6RROD+VjMM
 VoxHK5P1PlF5ko1O9QS23p3u1ce9tHjaZ5uxsCRl3v9AO2kjhBPXdfi6NTKj9IX4SKFS3QZiaKa
 32/WYVu3HzNz4YlmmS2DJB6fx9mQqQvV1mFkro8rG+NHFnZ0MGvBGOQ/fmFFm9rupQO0JS97cMJ
 +N2Xa/3u0naRmV3WzPZ7KrKWB70yXHGHh16MibB580uEzeC4LkqsZSi4eh/+ben0NiGHd8IH1I/
 J2oC0
X-Google-Smtp-Source: AGHT+IEC4uS/OUWZy+gn0tza9qnxFr8koy9fiOUXuVNue5CiD9nBr+q1AW1TmpD0RLJ9Wo+F5qvCHg==
X-Received: by 2002:a05:6a21:7103:b0:203:bb65:995a with SMTP id
 adf61e73a8af0-21d22c809dfmr5867595637.30.1749059025739; 
 Wed, 04 Jun 2025 10:43:45 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeab109sm11418482b3a.40.2025.06.04.10.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 10:43:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH RESEND v2 2/3] target/riscv/cpu.c: add 'ssstrict' to riscv, isa
Date: Wed,  4 Jun 2025 14:43:28 -0300
Message-ID: <20250604174329.1147549-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604174329.1147549-1-dbarboza@ventanamicro.com>
References: <20250604174329.1147549-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52d.google.com
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

'ssstrict' is a RVA23 profile-defined extension defined as follows:

"No non-conforming extensions are present. Attempts to execute
unimplemented opcodes or access unimplemented CSRs in the standard or
reserved encoding spaces raises an illegal instruction exception that
results in a contained trap to the supervisor-mode trap handler."

In short, we need to throw an exception when accessing unimplemented
CSRs or opcodes. We do that, so let's advertise it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20250529202315.1684198-3-dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 406 -> 416 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eeb44a2f1e..c1bcf60988 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -217,6 +217,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
+    ISA_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 156607dec45b0e63e5b3ebed62e81076dacd80d0..52a4cc4b6380eee3299b965271a39e9e01f5a698 100644
GIT binary patch
delta 52
zcmbQnynvZ2$iq2g0V4wg<L!xD2CR0Bj0~n5?U@+aic5+zlS?MsG3rguW>n@VV`N}x
IU}Rtb08<(Z?f?J)

delta 45
zcmZ3$JdK$v$iq2g8Y2S(<Ex2W2COEGj0`#(?U@)SdogNHE@M>U$YEq)C}U(`008kX
B2|xe<

-- 
2.49.0


