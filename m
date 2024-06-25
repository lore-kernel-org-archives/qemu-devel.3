Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8967CC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7nt-0001tY-OX; Tue, 25 Jun 2024 11:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7ns-0001sj-II
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:09:52 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7nq-0006Zc-HJ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:09:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-701b0b0be38so4715152b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719328188; x=1719932988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmQd1XYOjtrz6GVJ8DgvhIvqtRGpPGZCjPKcIxlbjuY=;
 b=R/dlbnriKxbaTTkzNry5kldSEbM3bfsLirydCWeLUHeP3FFbM/1JOHW5cj73ChJ4Pv
 DzP79EQs3R9x76NR+3IhlbsSCmsrrhokAcA3KyQoepa6w5E5N1SnQHFOvQvYjqMM4Hiw
 S7JRV7ueGDFsYOdjdX0abcPxJ1fkpP30IN9tR9wASxtVDM07cIG8oKhIjyRT4nwT2J/k
 qB4GWD7kyOGgOW4RmU8NiPysPIlFI8RUZSOGcJNSltgnslBC7eBNkXtIOwsV4YZ5lS5I
 ogqMwhV+Aa7eWyEC6mKOeo279L4yR33P8t2NBRbRnTNtMmveYFbaP2CXXuqcSKym7Cyt
 lAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719328188; x=1719932988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmQd1XYOjtrz6GVJ8DgvhIvqtRGpPGZCjPKcIxlbjuY=;
 b=f0nmcXtbWW/0vQ3BpyO9rCilpSe9740BLTJKT2RJNwspRA/IZJ8OSex4YDGEgobhkT
 Zmez4Rar5XwRLqo5IzfqZ22MCb33NpixJN9kV70XF0kLsW9qM6WhqWOYVf1xlhmdqqIy
 fsrRTcXSLZGIjGthxUXEcrWznao2FHojqkFzs1GQ5XO+pU2fDMyUsfwipZYpkrgxCo3d
 CadkVWDAt8qc/sv2vHtTqel8WJsxACnkDCtarTEx4GqIToXAs84nwprPFxyefusx5ly4
 BHIqCHxVO3rXi84J81axrzjn4Lbq0tsIiQvF6zizogYQsqiS76Giwp6FB5la9N9q4nGz
 U5JQ==
X-Gm-Message-State: AOJu0YzPNXnVssJgTQ6me/Nsg1EcmPGyo9Otld0KLIIwqJyHNJAaUh2X
 DRXhb692Y7mY+sMPRDs5nWhgD8WfoSk3GtD9g9pcBZ/kngDCJ0UTcpXHg7c/pL211rxoUksRnDV
 S
X-Google-Smtp-Source: AGHT+IHlL6t6rDHiy42GOZuz73OBMe6T5W5dGgL2t2zaRflAMtlUEcfIgFRsTBrMGUy6i6jU0uHGCg==
X-Received: by 2002:a05:6a20:3a96:b0:1b4:4568:4c40 with SMTP id
 adf61e73a8af0-1bcf7e36a3dmr7473835637.12.1719328188238; 
 Tue, 25 Jun 2024 08:09:48 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70681722219sm4142636b3a.73.2024.06.25.08.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 08:09:47 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 10/16] tests/data/acpi/virt: Move ARM64 ACPI tables under
 aarch64/${machine} path
Date: Tue, 25 Jun 2024 20:38:33 +0530
Message-Id: <20240625150839.1358279-11-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

Same machine name can be used by different architectures. Hence, create
aarch64 folder and move all aarch64 related AML files for virt machine
inside.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/data/acpi/{ => aarch64}/virt/APIC             | Bin
 .../data/acpi/{ => aarch64}/virt/APIC.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/APIC.topology    | Bin
 tests/data/acpi/{ => aarch64}/virt/DBG2             | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT             | Bin
 .../data/acpi/{ => aarch64}/virt/DSDT.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.pxb         | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.topology    | Bin
 tests/data/acpi/{ => aarch64}/virt/FACP             | Bin
 tests/data/acpi/{ => aarch64}/virt/GTDT             | Bin
 .../data/acpi/{ => aarch64}/virt/HMAT.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/IORT             | Bin
 tests/data/acpi/{ => aarch64}/virt/MCFG             | Bin
 tests/data/acpi/{ => aarch64}/virt/NFIT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/PPTT             | Bin
 .../data/acpi/{ => aarch64}/virt/PPTT.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/PPTT.topology    | Bin
 tests/data/acpi/{ => aarch64}/virt/SLIT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/SPCR             | Bin
 .../data/acpi/{ => aarch64}/virt/SRAT.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/SRAT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/SRAT.numamem     | Bin
 tests/data/acpi/{ => aarch64}/virt/SSDT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/VIOT             | Bin
 25 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/data/acpi/{ => aarch64}/virt/APIC (100%)
 rename tests/data/acpi/{ => aarch64}/virt/APIC.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/APIC.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DBG2 (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.pxb (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/FACP (100%)
 rename tests/data/acpi/{ => aarch64}/virt/GTDT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/HMAT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/IORT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/MCFG (100%)
 rename tests/data/acpi/{ => aarch64}/virt/NFIT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SLIT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SPCR (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.numamem (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SSDT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/VIOT (100%)

diff --git a/tests/data/acpi/virt/APIC b/tests/data/acpi/aarch64/virt/APIC
similarity index 100%
rename from tests/data/acpi/virt/APIC
rename to tests/data/acpi/aarch64/virt/APIC
diff --git a/tests/data/acpi/virt/APIC.acpihmatvirt b/tests/data/acpi/aarch64/virt/APIC.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/APIC.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/APIC.acpihmatvirt
diff --git a/tests/data/acpi/virt/APIC.topology b/tests/data/acpi/aarch64/virt/APIC.topology
similarity index 100%
rename from tests/data/acpi/virt/APIC.topology
rename to tests/data/acpi/aarch64/virt/APIC.topology
diff --git a/tests/data/acpi/virt/DBG2 b/tests/data/acpi/aarch64/virt/DBG2
similarity index 100%
rename from tests/data/acpi/virt/DBG2
rename to tests/data/acpi/aarch64/virt/DBG2
diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
similarity index 100%
rename from tests/data/acpi/virt/DSDT
rename to tests/data/acpi/aarch64/virt/DSDT
diff --git a/tests/data/acpi/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/DSDT.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
similarity index 100%
rename from tests/data/acpi/virt/DSDT.memhp
rename to tests/data/acpi/aarch64/virt/DSDT.memhp
diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
similarity index 100%
rename from tests/data/acpi/virt/DSDT.pxb
rename to tests/data/acpi/aarch64/virt/DSDT.pxb
diff --git a/tests/data/acpi/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
similarity index 100%
rename from tests/data/acpi/virt/DSDT.topology
rename to tests/data/acpi/aarch64/virt/DSDT.topology
diff --git a/tests/data/acpi/virt/FACP b/tests/data/acpi/aarch64/virt/FACP
similarity index 100%
rename from tests/data/acpi/virt/FACP
rename to tests/data/acpi/aarch64/virt/FACP
diff --git a/tests/data/acpi/virt/GTDT b/tests/data/acpi/aarch64/virt/GTDT
similarity index 100%
rename from tests/data/acpi/virt/GTDT
rename to tests/data/acpi/aarch64/virt/GTDT
diff --git a/tests/data/acpi/virt/HMAT.acpihmatvirt b/tests/data/acpi/aarch64/virt/HMAT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/HMAT.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/HMAT.acpihmatvirt
diff --git a/tests/data/acpi/virt/IORT b/tests/data/acpi/aarch64/virt/IORT
similarity index 100%
rename from tests/data/acpi/virt/IORT
rename to tests/data/acpi/aarch64/virt/IORT
diff --git a/tests/data/acpi/virt/MCFG b/tests/data/acpi/aarch64/virt/MCFG
similarity index 100%
rename from tests/data/acpi/virt/MCFG
rename to tests/data/acpi/aarch64/virt/MCFG
diff --git a/tests/data/acpi/virt/NFIT.memhp b/tests/data/acpi/aarch64/virt/NFIT.memhp
similarity index 100%
rename from tests/data/acpi/virt/NFIT.memhp
rename to tests/data/acpi/aarch64/virt/NFIT.memhp
diff --git a/tests/data/acpi/virt/PPTT b/tests/data/acpi/aarch64/virt/PPTT
similarity index 100%
rename from tests/data/acpi/virt/PPTT
rename to tests/data/acpi/aarch64/virt/PPTT
diff --git a/tests/data/acpi/virt/PPTT.acpihmatvirt b/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/PPTT.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt
diff --git a/tests/data/acpi/virt/PPTT.topology b/tests/data/acpi/aarch64/virt/PPTT.topology
similarity index 100%
rename from tests/data/acpi/virt/PPTT.topology
rename to tests/data/acpi/aarch64/virt/PPTT.topology
diff --git a/tests/data/acpi/virt/SLIT.memhp b/tests/data/acpi/aarch64/virt/SLIT.memhp
similarity index 100%
rename from tests/data/acpi/virt/SLIT.memhp
rename to tests/data/acpi/aarch64/virt/SLIT.memhp
diff --git a/tests/data/acpi/virt/SPCR b/tests/data/acpi/aarch64/virt/SPCR
similarity index 100%
rename from tests/data/acpi/virt/SPCR
rename to tests/data/acpi/aarch64/virt/SPCR
diff --git a/tests/data/acpi/virt/SRAT.acpihmatvirt b/tests/data/acpi/aarch64/virt/SRAT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/SRAT.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/SRAT.acpihmatvirt
diff --git a/tests/data/acpi/virt/SRAT.memhp b/tests/data/acpi/aarch64/virt/SRAT.memhp
similarity index 100%
rename from tests/data/acpi/virt/SRAT.memhp
rename to tests/data/acpi/aarch64/virt/SRAT.memhp
diff --git a/tests/data/acpi/virt/SRAT.numamem b/tests/data/acpi/aarch64/virt/SRAT.numamem
similarity index 100%
rename from tests/data/acpi/virt/SRAT.numamem
rename to tests/data/acpi/aarch64/virt/SRAT.numamem
diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/aarch64/virt/SSDT.memhp
similarity index 100%
rename from tests/data/acpi/virt/SSDT.memhp
rename to tests/data/acpi/aarch64/virt/SSDT.memhp
diff --git a/tests/data/acpi/virt/VIOT b/tests/data/acpi/aarch64/virt/VIOT
similarity index 100%
rename from tests/data/acpi/virt/VIOT
rename to tests/data/acpi/aarch64/virt/VIOT
-- 
2.40.1


