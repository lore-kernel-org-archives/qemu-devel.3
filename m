Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A54CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kDc-0003wv-8Y; Fri, 17 Oct 2025 09:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDN-0003of-R9
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kD5-0004a1-NC
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4710022571cso16160435e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706562; x=1761311362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pwb0PJgSr2BfTlaSLjpWqnUcDaMDaP78/yq/3EzyncQ=;
 b=xFW9MFJOa8Jf6q1PmSPhXNNA7CJESMl47BJOxV3s3WR0ya7NnI3tirHSIz7SdXw/oD
 Vq2sUken7SZa0cDkjM5tN0YSWSUSe1CdpmzxtLXsT0t0otOi+gXNNv/ovwwgVxOE8e0O
 x7bpdG4xsO6xXIJDYV+wadXMSBTnCNGb0xxMonvjwaU8rn2JSxMbKyiAaKUcmBaRPZBE
 ml8GqYwx7GNm3i2bv81RyvnzFtjGb1kJOWCiV/tOieUMSqILULo2LRNhcFKnLX3JsEfV
 ffN0UKMesjI+bloTVPM3B7KujNF3FIVo/YkYjWlC6znp+4DulpvPjp08hbS7fABGm03W
 Z3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706562; x=1761311362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pwb0PJgSr2BfTlaSLjpWqnUcDaMDaP78/yq/3EzyncQ=;
 b=tGS5zFUM91vfRyMkHXLxH0lZ+UPdipA9Ix+nJxlgrwWFoWr5NE8gzgXqxzrcKdUKst
 pz+0PcXd/vUcZAC66aTxzkFnd1N9VcWQPj6lf8EW/xFGzV+vX7njeuhq4jdCL83IBQSA
 H8rBEquCEEKRclJA66S802xBITcxfed2x/W8fcjU5X7nIZVrisSP+WbjWnU1+DuHe5vE
 GoxLkEFoctKd4iR3CJJgwrh3juVcLiVZr17zeb7asXFvsK1YdX5LufzTU8vvACQ8aok7
 YKa126XZ6m8iBnRGs0qBR0SJz5dyYXA4BP/SFc6gKMww0fuHyac92KU5XBrnZV+hCyQD
 rW8A==
X-Gm-Message-State: AOJu0Yy2nBA36Sn7PoZyhr4CKLtgIoJkgDpTqjGh8qsT8OsfbyksgcUX
 7RYaIB2XkAlosjA6EGBQKxjR//m3uF4/AnBm5YZdVQQbANM2dMDk/dxKDdIVvpt5Sgvac2XIbey
 YEMoXet4=
X-Gm-Gg: ASbGncuN0huyNEh0q8FjDbA13Rne3uxy2UZ+UM3tyS3v1c7MaEMA+L0gGx+Wnhb4xMj
 cD2ID/QA2wrwYrJKBtJNasADNR3RpYlmLBq8s2dWq73jyFusG/ip2uW0RSTwNoEKyPXwX4YWXkJ
 NeatnSPc1H+wcOQGbudBfmifTUk7vQG0FQxZFoUWFMt6WupMiZinAjWi/5982f1q+9TM4fJhSet
 cYlgvU51cbvJauXQerirqYyl95labgN2ZyUI3QQKVgHalNXeMmQxdlrfluIRtl+TSmUoEBYGSj5
 YRJTszgZuv53S2FmUGeMg4XeFcUHfOcgTyaPox2b9a/E/3bHxT7s8nkJwMFqrRalbgmXREZkEHH
 1T9mPRgyA/odGR5Ru0gtWh5FUSKkotL8TnXpZkpsEa8P3Tl4G4yPClQDWxEcnKb8OhMsB7zaBDb
 QCZlXsE4X9D7wJuYqgHpAM4/VjIJCt6lUQsIzoHZVz0K1KhgUeMg==
X-Google-Smtp-Source: AGHT+IHDj4AFwp18ZHcnh2UZvTGNAfF/YXNA98LVcRKk79McZXtaIUl/pO3uSbGUmS5y8kFVQTTbTw==
X-Received: by 2002:a05:600c:4688:b0:46f:b42e:ed87 with SMTP id
 5b1f17b1804b1-47117925eb5mr27746575e9.40.1760706562251; 
 Fri, 17 Oct 2025 06:09:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47121ed98e9sm7279285e9.3.2025.10.17.06.09.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:09:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/20] hw/arm/virt: Remove deprecated virt-6.1 machine
Date: Fri, 17 Oct 2025 15:08:11 +0200
Message-ID: <20251017130821.58388-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f928a73272d..f23283e6ddd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3627,17 +3627,3 @@ static void virt_machine_6_2_options(MachineClass *mc)
     vmc->no_tcg_lpa2 = true;
 }
 DEFINE_VIRT_MACHINE(6, 2)
-
-static void virt_machine_6_1_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_6_2_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_6_1, hw_compat_6_1_len);
-    mc->smp_props.prefer_sockets = true;
-    vmc->no_cpu_topology = true;
-
-    /* qemu ITS was introduced with 6.2 */
-    vmc->no_tcg_its = true;
-}
-DEFINE_VIRT_MACHINE(6, 1)
-- 
2.51.0


