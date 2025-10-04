Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E59ECCA472
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wTL-00067D-Pr; Sat, 04 Oct 2025 03:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTK-00065y-GV
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTI-00051b-FT
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so32932985e9.2
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562062; x=1760166862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q7Zn5JDt4GAjJgTV1PBuBphG2SnUSYdaQjwvSOOkpPw=;
 b=saquV9ZRoccconBF2ulV/sDHEUT0azQBZDmUMEo1itaNhX1GkAx3EW2BwYyIGpManb
 +CI6txDtc64tbvtgyvGyZOXEAnKfJNYjTmvOdd48LL2OjnTtoxqMLYK59AuaH+GdUt4p
 zrTuj9cyJnjY+xFoL2FomYvTfvs+2xi0E015uXLM5IwILqR2QTyZTfRrjm1fk79T+5dP
 g+sQiTNF99cXLq5R8D4FQ2I5jB90RZ/4HVe6nndAN4FTEnhuBVmFG+WxBnryWNgBXqlu
 NrfRXcD2R2Ac98YZCV2e0G88CmcPcH/0wP+WpK9Zx4/c64+Ux+CPJ1iBgXuc3eKdaExy
 yJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562062; x=1760166862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7Zn5JDt4GAjJgTV1PBuBphG2SnUSYdaQjwvSOOkpPw=;
 b=L0i0DpsivugENf3lQFnoVvyFzW3Ae2I2HPVrBi/jxd5W60R5kfZUNw1joqAFOAFDFo
 QENdaZYB/MiGxf6Ue88memhKkqw0r6Oy87w5GualbpCggvBaPkA8bil+qgtp5jape4Oq
 BdkT4ja6DxjNkVKSVvy0ElqFKNTRFYkSlyFEL5SomnRrQtf0RncwsDd01zoVDIOMQX3Z
 uKpa0r5YOrsy/jGSFeBvbuw3xsOANtrUuUE8j4r3eKAFpv8G4Y9rDn9Ah4qyRQWlkZyE
 XeLQ0jfktswhP/0s4kFVwyNq4jOgVrpakmmPfeFf7tPLvNWzxprjN3yIgBEJRM1KF06y
 0NaQ==
X-Gm-Message-State: AOJu0Yydp12WpPLU9+WGYI+ioeaMFLnynBp5+ryuD2eeWl+5DFcX6RRY
 FpFUD9tHOpdEECzTKuJ8RZkBV3Ao8YBcA90AElufB/LfokDnRkL1FmXeXUruUepQNTaLZxDBedt
 P6gsyDZQajQ==
X-Gm-Gg: ASbGnctfTRf7RVKADdeP+UTnrU5Et3A3b95JvxuUyhRVTRSeU1Z6FdK4J86PVYaUmCt
 26e+cn4hWA86t5El8/Bk0ljUMdQuinVLHjv0K+bnVK11g9pIdUKsXOXLA2msNnH+wWkOX7Hj3li
 IO6shSLXCBX1aINqJLTnOGimCbMv1slE2mR5xHJ+eQLCvc69zVJ56lX1fE5LSfoeNX1wgaG2TvK
 zV9AYZIwJ0BAyPu11ntqgYNj2n+Yhmov0zZDLaedc2O6THbEn61Wm0VXWOibIyiiWeUQvNcMEhO
 dC5BLUJk7S8/Yq8m1jvA8FScF6YfVyEhkE8lU2goSn3oYkMCLYvfsm0AK1Z8Ya8iKADDvqrk9cL
 Ui2SR7Cn3pWzIpJZcQCnOKyxZwXa7orhd/Q0mLyBOTrUjIJpUE0zNQOqmYtEzqgrA9BlBre4DTx
 hqekGdGGqSKwbQKw9Cr+8SxnSnOVZs2rtmQkg=
X-Google-Smtp-Source: AGHT+IFahgp1iK0UGfvUoCXTsAfNswXlvRZmxlIqO6GL/Xhqq8OcwJf/h7rSfrfLdhvbuyPd9D+NYQ==
X-Received: by 2002:a05:600c:3547:b0:46e:652e:16a1 with SMTP id
 5b1f17b1804b1-46e711019e2mr37568345e9.7.1759562061807; 
 Sat, 04 Oct 2025 00:14:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723437d8sm61281125e9.3.2025.10.04.00.14.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/41] target/i386/whpx: Replace legacy
 cpu_physical_memory_rw() call
Date: Sat,  4 Oct 2025 09:12:41 +0200
Message-ID: <20251004071307.37521-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Get the vCPU address space and convert the legacy
cpu_physical_memory_rw() by address_space_rw().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-10-philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2a85168ed51..82ba177c4a5 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -788,8 +788,11 @@ static HRESULT CALLBACK whpx_emu_mmio_callback(
     void *ctx,
     WHV_EMULATOR_MEMORY_ACCESS_INFO *ma)
 {
-    cpu_physical_memory_rw(ma->GpaAddress, ma->Data, ma->AccessSize,
-                           ma->Direction);
+    CPUState *cpu = (CPUState *)ctx;
+    AddressSpace *as = cpu_addressspace(cs, MEMTXATTRS_UNSPECIFIED);
+
+    address_space_rw(as, ma->GpaAddress, MEMTXATTRS_UNSPECIFIED,
+                     ma->Data, ma->AccessSize, ma->Direction);
     return S_OK;
 }
 
-- 
2.51.0


