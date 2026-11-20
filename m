Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EC606A6DD
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wexQHmR4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUzc-0008PZ-Kk; Fri, 20 Nov 2026 15:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUzI-0008Nq-3A
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:13:37 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUzG-0003xC-F5
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:13:35 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso1046555f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205613; x=1795810413; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xVA4eSJllNhT2+e1ValvpLI+kjPVaRNCOlngOE8rHjs=;
 b=wexQHmR43hBUnBetoKywk0lbYw/APMjPkVh+VHXhdG0IKwInDO2bF+SzZK3fqeTSIu
 DhYrhKEHOCJWslc1sM0+QIdKOYYccnq0PZJ7NO18Q5ZYJmIBgVyxkBrXAmtnId3/7CUt
 9J741JjIp48ABnEewnd6xB2kdMbkUd/VRdnSsiVyfoOBGVVyYENXHYeyOdFaujdDpXVN
 KkCF9fSt+F1xboPu8Pcf4SEx4qNxhA5xZR0rheUEjJv/bvfOLKr5YQuCH4BXFYZFPNkg
 OkqyX//pP/VDb9ndacZPiiqBvnYRqqGfpyTbq2cnG9BmI0ALogEDzRLrTcNx0meo1gVW
 pp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205613; x=1795810413;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xVA4eSJllNhT2+e1ValvpLI+kjPVaRNCOlngOE8rHjs=;
 b=xqH8xdR4aDyrPR9c1CtpvIf6kXNCCM5Danw8i3l0Eb4FGKXPmK4cIVdNX4l+LxGmC2
 Ldg6I4/7LnNtnRSApXJCyGbkwJQU5J+de1foj42Rco+s3fCMEaPXeguGgFU0aNv36UmK
 2V1indklhkkFrb/ASq/W9rQHWuUIi5LJZWAhxFvMHpVsgJ7onholVQVzdLGye7m+Zbdj
 564EbEpl3Q3D3zu4L+WFNgT6B38c/3AvIqU352GIvTZkZHsvFDs8jYNN6Wo/NrvGVDv2
 GdXlCFkbx/X8ybRdqe2CAI0HUvo1tPVwqhYRw9tZKEuO95kFqiVk9rRzz+zPSnBZUMwL
 EIdA==
X-Gm-Message-State: APuU4Z9N6D/ScGrHL5sj6fJvCmM+7eTmvYqpXzuvF4xz1W6zCCPnjH5m
 GQ1j+gzrSZYQeMkdZIgWWWfg701ZitkrZnVMgMPvs7tUiDM2LJBhUwYFtyDZbnVU6oo=
X-Gm-Gg: AZFdTZeJ466TE1xETbX1hZ9SVaL5Dx+3mHuOxMK8x6ar8O6AuUX1kmHIJrLaakIWUiZ
 RGLLsDZYFPhuAggSmwh5RtQA65svewJH81PCF+pLTDErbCEs7y+nlcLa3qO6SxIqFK2iyU37JUq
 fJfVRKcLnPMgrTVa1vJGh/GSCQPXFCSlA3l0+ebpDYLUsLiUXvJuji6rwzuZpRvM3BdLWbm08JU
 hfeMXtXwJ1qJKrqLBTXyDEg4wGn6m4HFrzNX049d4Zx1VcZVwuTJiRDHg9vVivhfWRTyoTkO7cA
 x9l+iwPzh8l13XInx8iicgUD+mcuV2uzPsw3HdUeq5eTkDkjbc4V/aycm+7iqDypMGwBMofZ3DB
 cgx8CbM6GQSAKKZi0ovdQ21Hq4WyjRAhvXvqSmvsB8MGhU5rOyA0F+lxAF/BbOY1ZN6Tk1IGLJV
 MeHRTHQSQz+bmq5kOyeGOOEG3s8VB0loRpelrWkoNfitkLneVVMOFS7JofqEqiOBaTL/Jpbb9tm
 pNA7sPyNOzXOvSMRbPi7urLBYlvFoT8Ty+0TFIqndEqjjsTn9AZ4Uco1iQpIBd6cuBL3N748eA4
 k8cAa6aws+Hwrdx8wzXx7fL18zfR
X-Received: by 2002:a05:6000:490b:b0:491:8462:20be with SMTP id
 ffacd0b85a97d-4abb1baaad9mr8808569f8f.12.1795205613085; 
 Fri, 20 Nov 2026 12:13:33 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b9add26sm7747126f8f.44.2026.11.20.12.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:13:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7E6C95FCA3;
 Fri, 20 Nov 2026 20:05:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 21/22] MAINTAINERS: use consistent capitalisation for Alistair
Date: Fri, 20 Nov 2026 20:05:09 +0000
Message-ID: <20261120200511.822573-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The last emails with capitalisation where in 2019, make it consistent.
We can also tweak .mailmap so this sticks in history as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 10 +++++-----
 .mailmap    |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d1444ff661..456d835ce70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -878,7 +878,7 @@ F: tests/functional/arm/test_canona1100.py
 F: docs/system/arm/digic.rst
 
 Goldfish RTC
-M: Alistair Francis <Alistair.Francis@wdc.com>
+M: Alistair Francis <alistair.francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: hw/rtc/goldfish_rtc.c
@@ -1806,7 +1806,7 @@ F: tests/functional/ppc64/test_fadump.py
 RISC-V Machines
 ---------------
 OpenTitan
-M: Alistair Francis <Alistair.Francis@wdc.com>
+M: Alistair Francis <alistair.francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: hw/riscv/opentitan.c
@@ -1844,7 +1844,7 @@ F: include/hw/riscv/shakti_c.h
 F: include/hw/char/shakti_uart.h
 
 SiFive Machines
-M: Alistair Francis <Alistair.Francis@wdc.com>
+M: Alistair Francis <alistair.francis@wdc.com>
 M: Palmer Dabbelt <palmer@dabbelt.com>
 L: qemu-riscv@nongnu.org
 S: Supported
@@ -4240,7 +4240,7 @@ F: hw/i386/amd_iommu*
 F: tests/qtest/amd-iommu-test.c
 
 OpenSBI Firmware
-M: Alistair Francis <Alistair.Francis@wdc.com>
+M: Alistair Francis <alistair.francis@wdc.com>
 R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Supported
@@ -4341,7 +4341,7 @@ F: tcg/ppc64/
 
 RISC-V TCG target
 M: Palmer Dabbelt <palmer@dabbelt.com>
-M: Alistair Francis <Alistair.Francis@wdc.com>
+M: Alistair Francis <alistair.francis@wdc.com>
 R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
diff --git a/.mailmap b/.mailmap
index bd8bf07feb7..c44990fd3d6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -80,6 +80,7 @@ Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
 Alex Williamson <alex@shazbot.org> <alex.williamson@redhat.com>
 Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
+Alistair Francis <alistair.francis@wdc.com> <Alistair.Francis@wdc.com>
 Andrew Jones <andrew.jones@oss.qualcomm.com> <ajones@ventanamicro.com>
 Andrew Jones <andrew.jones@oss.qualcomm.com> <drjones@redhat.com>
 Ani Sinha <anisinha@redhat.com> <ani@anisinha.ca>
-- 
2.47.3


