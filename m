Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3494AD3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nvR-0005io-Iq; Tue, 29 Oct 2024 11:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nsA-0000os-N5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:09 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns3-0007j3-09
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:06 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso73109255e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214657; x=1730819457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t1ofx0L3R12Y3Qfk5twMRKrNngXzbSoAXzZlWcI4ZBk=;
 b=vgm/JWXIWfYS1U68XdgB528xBrv/DBHGqUiIzoHP93RPyU43F9xD3bQyIbzpuihs3g
 1OzeuXC0NKgs8ujnC4VSqAhG39Y7d5tOHqIAFHixP3b+VQCQSCiEzzeDprj3CuW/jkJs
 QIDqjY+PN4KuanUUcLSBodzGVwg32R4jDHUF1SpQDJn52LrMfsNVooJZoKfBa8/u+TMt
 U5Uf04FYNvSPjp5inpfXjhPT1AJ/DkIOp80dgIBZGo8EnYPDhzgNDYFB1w7S33oiorpr
 dx85ut6BFzHQfVuVUncuIMwDfMH0oSAbm9Wu7MUHgyuQjVNPEW87DLzKWX7TtI4KB+B/
 vpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214657; x=1730819457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1ofx0L3R12Y3Qfk5twMRKrNngXzbSoAXzZlWcI4ZBk=;
 b=Bv1B+eNQvlgkPF7EBfaHze+uzxnJ4Y/uoMkQHALHqhT5BsBFSd0AMzW++1gYFrdVkV
 bI0Ba0RjIlRF7JwufoRe7UgtQaE7/IxJbMigRPPMKaMw1S1nh7i3k0terHRI77ARfjOr
 vmT3HgSmrssJ371qqtQfzTnRZcvRioVT+PQxsq25/lrIGKjkMiz5mPOsLVQHUoty/PIl
 n0nVHVHFa4x5+IbHeUkpcuYEnPGPMu9Pkb5qb+qnMhEqwZKszsH10rEb8CZZtaKMmwFg
 z2N2wezGPde+t+l9/kuwTrbq6mA6wZ83dRBoAQeOF1VXMiraF7MPAxKkpISiiiYcA6iz
 C68A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXebe4IRULmj2vUhSIIKDcC+lxZIdcHXNCjKXPk8fplhjvodNMO7Vl2sEPobqaZfa3NsU5r0wDBc0RW@nongnu.org
X-Gm-Message-State: AOJu0YwdRbHSlFDvMdJfVDy6M0bhVQBprHwRups9AFadeTpPJ+JoYqkK
 i6b+4uX3VhlCE2a9P05Z8PXrB/V7x9YbvU8DJacR7Z8ubiT2aogQkPkHdPPwKoQ=
X-Google-Smtp-Source: AGHT+IEhIZ0FKHQDbPf3PTcCdVQCu7AWtY8kYPVxwfWAhSoE/P99YHMpWrkgsdxZEgKQk1O5N4rw0w==
X-Received: by 2002:a05:600c:358e:b0:42f:75e0:780e with SMTP id
 5b1f17b1804b1-4319ac9a68cmr140317295e9.10.1730214657109; 
 Tue, 29 Oct 2024 08:10:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 14/18] docs/system/arm: Add placeholder docs for mcimx6ul-evk
 and mcimx7d-sabre
Date: Tue, 29 Oct 2024 15:10:44 +0000
Message-Id: <20241029151048.1047247-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Add placeholder docs for the mcimx6ul-evk and mcimx7d-sabre boards.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20241018141332.942844-7-peter.maydell@linaro.org
---
 MAINTAINERS                       | 2 ++
 docs/system/arm/mcimx6ul-evk.rst  | 5 +++++
 docs/system/arm/mcimx7d-sabre.rst | 5 +++++
 docs/system/target-arm.rst        | 2 ++
 4 files changed, 14 insertions(+)
 create mode 100644 docs/system/arm/mcimx6ul-evk.rst
 create mode 100644 docs/system/arm/mcimx7d-sabre.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 66c7572c27b..1e88b5738cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -791,6 +791,7 @@ F: hw/arm/fsl-imx6ul.c
 F: hw/misc/imx6ul_ccm.c
 F: include/hw/arm/fsl-imx6ul.h
 F: include/hw/misc/imx6ul_ccm.h
+F: docs/system/arm/mcimx6ul-evk.rst
 
 MCIMX7D SABRE / i.MX7
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -804,6 +805,7 @@ F: include/hw/arm/fsl-imx7.h
 F: include/hw/misc/imx7_*.h
 F: hw/pci-host/designware.c
 F: include/hw/pci-host/designware.h
+F: docs/system/arm/mcimx7d-sabre.rst
 
 MPS2 / MPS3
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/docs/system/arm/mcimx6ul-evk.rst b/docs/system/arm/mcimx6ul-evk.rst
new file mode 100644
index 00000000000..8871138ab3e
--- /dev/null
+++ b/docs/system/arm/mcimx6ul-evk.rst
@@ -0,0 +1,5 @@
+NXP MCIMX6UL-EVK (``mcimx6ul-evk``)
+===================================
+
+The ``mcimx6ul-evk`` machine models the NXP i.MX6UltraLite Evaluation Kit
+MCIMX6UL-EVK development board. It has a single Cortex-A7 CPU.
diff --git a/docs/system/arm/mcimx7d-sabre.rst b/docs/system/arm/mcimx7d-sabre.rst
new file mode 100644
index 00000000000..c5d35af1d44
--- /dev/null
+++ b/docs/system/arm/mcimx7d-sabre.rst
@@ -0,0 +1,5 @@
+NXP MCIMX7D Sabre (``mcimx7d-sabre``)
+=====================================
+
+The ``mcimx7d-sabre`` machine models the NXP SABRE Board MCIMX7SABRE,
+based an an i.MX7Dual SoC.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index ace36d1b17d..1f806cf4a46 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -97,6 +97,8 @@ undocumented; you can get a complete list by running
    arm/nrf
    arm/nuvoton
    arm/imx25-pdk
+   arm/mcimx6ul-evk
+   arm/mcimx7d-sabre
    arm/orangepi
    arm/raspi
    arm/collie
-- 
2.34.1


