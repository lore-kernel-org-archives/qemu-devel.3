Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7653C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQco-0006re-On; Tue, 18 Feb 2025 11:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tkQcn-0006r3-5t
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:39:09 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tkQcl-0002Ln-Kf
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:39:08 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22128b7d587so45183135ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1739896746; x=1740501546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYUkm0URlvt/fEHggYoxirTMYLe7QUj525r8nmoUuyU=;
 b=HSLKx+9/NxxZQJ6O2m27KiDT7MWeehDia9ORGxWrm57Qdo/gAMA3wLGzm+aVToA8lr
 uD/j25MJfdnK+42QKTVkHENg8R9f0T743TIXfgLO4VdRdT5ovbbHJ9ioTX5IUT+OyoGF
 9NhCnp0GduUnzy1lwIJC9kzb7qT1yebVfPvbgTezBcLD9dv+4hqYblzUD5l1STX1XoVk
 660sH08Z+mwc3WYbJqMsYc3kAZQOhWA/OogKm0PeIO/vR/L+p7CzMloF55oiC+bcBycm
 lsxrE0Tp09QO2pfnBXukNYP/UxcNG2UVy79ykyHNKt1XbWYEvGfthYfiGnXc6Huh+QRt
 trVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896746; x=1740501546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TYUkm0URlvt/fEHggYoxirTMYLe7QUj525r8nmoUuyU=;
 b=Tjnhmrt81I1Ihi1g162WxjsiDaxNjs+qUVEkrIPwY83EfdRVEddO9fhEVIidih3e0O
 uX+m+D9v+jCFml0kSt7Y6B7kEYl8WTr5KjxcwjN4bTOViPMQZb7JkVMlb6bMCJwSuYnl
 f547QPsX1TbwI1k3n4x9DV0IVIHVxub/tw494BU+GYSn24JnjI/ce6GXbxEDeXHS/Knu
 HQLaxX73SoJm2Ykl40mLwXctV9JHmRyD//uSQs4Asyani8ox2e1zvVX23pVwHEhx0+oe
 /UKc5LMPCBaLHSMnSSy9G5R1jbNaQWaHwAduZh+F3Gz847OKgVu/jIVhu+1ENqRTrAxh
 yQeA==
X-Gm-Message-State: AOJu0YwfJHuCG2B59KWZOwMXebacXHiNOLEyRrQj1yBcxcIb2WHPevuK
 pfvL64c8fI+C2CDKKdspbMZ9WCsmdqmiTfRGAQRqA5BpWLIXcFbn3amg3KPgZl4yrUvim5xQ+fZ
 6
X-Gm-Gg: ASbGncu9lKaeShzjc7VHYhBZSqzJS0sN1FTsJ2Sv8iS7n9mqb4tjrnjIkT5g3udILQ/
 kUNuVMYTugdKOre9A1U7TCOHO6nhxuE8J9MuDKzW2Oy52KsU8pu+buSgb89YGiayjIJ/txyvqDy
 ITuYVCo9FEcFCgC6EZbCgAZycu3KdmLSgGJkh6/oUSGWMPkzq2Ho6mgoIPorXjzzDq+21XsovGS
 hlDA91IXvaK32ztdbSSP3WDd5bRO8AKuqQEf8by0x9iU2mhvm5yaH5TRh7j6a7mxH7KNWXcZCl+
 7RTvMyW2dHvh8ZT7mmRU5dsncrqKI/01Vo/NAykAkzpg3KnMiy6e
X-Google-Smtp-Source: AGHT+IHtTeK7YiNntz8FIcfbRLXiFgTpoBDoe3qIcisBZRjXMGXrcSzcH+qOvAHyc2QRheznYF6HsA==
X-Received: by 2002:a05:6a00:3d06:b0:730:9204:f0c6 with SMTP id
 d2e1a72fcca58-732618c2a69mr24657445b3a.16.1739896745820; 
 Tue, 18 Feb 2025 08:39:05 -0800 (PST)
Received: from grind.. (201-68-240-180.dsl.telesp.net.br. [201.68.240.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73278d09228sm4595533b3a.117.2025.02.18.08.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:39:05 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/3] target/riscv/cpu.c: create flag for ziccrse
Date: Tue, 18 Feb 2025 13:38:53 -0300
Message-ID: <20250218163854.425607-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218163854.425607-1-dbarboza@ventanamicro.com>
References: <20250218163854.425607-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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

At this moment ziccrse is a TCG always enable ext that has no flag. KVM
will expose ziccrse to users, allowing them to turn it on/off.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c     | 5 +++++
 target/riscv/cpu_cfg.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 522d6584e4..0b8d2c0c25 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1711,6 +1711,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvksc", ext_zvksc, false),
     MULTI_EXT_CFG_BOOL("zvksg", ext_zvksg, false),
 
+    /*
+     * KVM can turn it on/off. For TCG this is always
+     * enabled if priv_ver >= 1.11.
+     */
+    MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
     { },
 };
 
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 3f3c1118c0..88565e29fd 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -157,6 +157,9 @@ struct RISCVCPUConfig {
     bool ext_ssstateen;
     bool ext_sha;
 
+    /* Always enabled for TCG, KVM wants to switch it on/off */
+    bool ext_ziccrse;
+
     /*
      * Always 'true' booleans for named features
      * TCG always implement/can't be user disabled,
-- 
2.48.1


