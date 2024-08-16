Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480D1C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 01:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRJ-00017e-FH; Thu, 15 Aug 2024 21:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selR8-0000nb-My
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:28 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selR2-0002Ig-E4
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:25 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-27020fca39aso133701fac.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770439; x=1724375239;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xTvsa+ViAqHINj5oJb/iz6qO9j2BBr+FG4wAjwt7ac=;
 b=MttkHC8VYzfLHYTI6aJw9Y4bV12w8Fu0Ke6mYqt4+OPgZDaRZDORsU5d0lkXMFlFWT
 BZhN3soiQv3Mno/d6gZ5l4VN1BHdmjPo2hyc4LpE0ztXcuOdRDTCrsMDAtBK3+VJAEXX
 cN4HJyQowk74atS222B4w2ZOxyaLwxLfKbOToDd+OwK0rzRxx+TD8n1zzHuaFbCobX++
 FRnFaqeuU8daZY8gqGzzRpZU4A71kJyRpxlKAunrepsFHsXquMH6DzLyfWCZDh1a4s5k
 8lCspvpqt/4P9tRmG46ilEwqy18ItbDxQxy0DeZHWuqoGiWkGG4ytZYjXGKpHaNIWseL
 Snfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770439; x=1724375239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xTvsa+ViAqHINj5oJb/iz6qO9j2BBr+FG4wAjwt7ac=;
 b=N8RMhO7K13eSOUCRgL0QyTZCY91Czzkh1eSMj9CCkj6QTO9gOPDlyf/AsivOUEmVrf
 fOM27mBGg/IJmTt4U7XNsli/UBFCX25UePnhRllDak8JWlbsb/tjeBEoiw7EXkG21Tzx
 RTs7AxZsqZLTHoMBHtI6ato8C+zwrx0tgJyPztW6Q78MsBN20JOviBZW488u6N8/STVv
 5xHhaDE0/9P1g60W/981TDW4//sO02dpQ0YvRsGAJcFW6ds9avxGFAmrSq39cfkHF6Qz
 vs8feBEfagI6xzBP5QwThUOQ5tB3efmv6qEaQS+IyFugrKIk9J0PmRY/cjRoa4b79lhN
 SZEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBHWaweRydWH4ShlwDbpSYoe3w7H9U9muUCSIpWY76c3e2fIXgJPv0zIndVzwvUTibK68Nb3X4zQcpZMMeTlBhSgk5gpo=
X-Gm-Message-State: AOJu0YzEMlTcGuUxlpwJqOgVqZqxwqCCvQZV02L0P0IM+LdH+y+Ubt1R
 nRg0YttU4dE+46nSVx28IAS9s9TbxWJN7MRZ38CeIAchFIO+2ytdjpIwV/GnyqY=
X-Google-Smtp-Source: AGHT+IEJSOVz8C98YCMXJ/uT8Q6KzRedu8l4G45zvGrU7s2x0po32tgvZpn4vJaYlyOzfSwtK5UhGg==
X-Received: by 2002:a05:6870:c1d0:b0:260:fbf0:d65c with SMTP id
 586e51a60fabf-2701c35484amr1667205fac.9.1723770439104; 
 Thu, 15 Aug 2024 18:07:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:18 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 01/16] target/riscv: Add zicfilp extension
Date: Thu, 15 Aug 2024 18:06:55 -0700
Message-ID: <20240816010711.3055425-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816010711.3055425-1-debug@rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=debug@rivosinc.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

zicfilp [1] riscv cpu extension enables forward control flow integrity.
If enabled, all indirect calls must land on a landing pad instruction.

This patch sets up space for zicfilp extension in cpuconfig. zicfilp
is dependend on zicsr.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c         | 2 ++
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 33ef4eb795..5dfb3f39ab 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -106,6 +106,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
@@ -1472,6 +1473,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
+    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 120905a254..88d5defbb5 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -67,6 +67,7 @@ struct RISCVCPUConfig {
     bool ext_zicbom;
     bool ext_zicbop;
     bool ext_zicboz;
+    bool ext_zicfilp;
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b8814ab753..ed19586c9d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -623,6 +623,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->pmu_avail_ctrs = 0;
     }
 
+    if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
+        error_setg(errp, "zicfilp extension requires zicsr extension");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.44.0


