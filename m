Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6286C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7KM-0006y7-LZ; Fri, 15 Mar 2024 09:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rl7Jg-0005op-JO
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:45 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rl7Jc-0007f7-7s
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:44 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5e4b775e1d6so1595121a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710508178; x=1711112978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAQMCAkcf2yerNIBkpwIivKLp3a37CUphrsQcm2dnuc=;
 b=jqi07cllaHoVu5Py4dXSyQFVIOXVdw/umPtUtoGA2v12rvXsADTe8ZlElb+SGQO7/a
 qDmD4rBLUuqfI1TPDaJkAnxG2K9/N4NOL/sKvm4qURRj/EP6rZGn4U+n01WIuYmxIJKl
 SGXYiZdT7zTXyDlg09PoiNf5HAJg+Gvs5Qp2LvSINLZ1a1bOtp0BJYUIDUJLL01hie09
 0T8fs2dmbfkpbv123kcnRu2XsQSmxAe0wOKosIqnKPh0MtiIZZKQScHDkD8mI/AFfTEe
 mC9o16A6SeaRqg+LVXhowSFSRj2XC7KprUM9hoVCjaRbGIWiCT8OuzPPENyYUpblZJPw
 VGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508178; x=1711112978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAQMCAkcf2yerNIBkpwIivKLp3a37CUphrsQcm2dnuc=;
 b=H6RkRi+Lc2L7BoVr7CSsT6chqZFY8ci5HgQlRgMTnObqVRoiNL1w5LozBpZGmHuDbp
 sZWRHYGiylD+mze+Ci3B1xkzwxsqL3n1ZBeQoEGplTJmwque1+Z09Nndck2gQD9NJXwO
 XUE8QQ23dP0ccjE3kWCBrlIZhNGml9INOxWmzwUXvMxC8Ym16Josfo/nMgZGutpI9281
 QdR6cZn0mjEi00vQHkAfAF2X6NeN++9I29tsPDpeH10tG3vlmXbOjFssgLEB3/k1XC+o
 EgwbrWs9W4pmg3pME268eTPxzM8cu7Jq7PWQgw0Lal/c+whGoFCLz5kRiwIuXKn1Nhlv
 33uA==
X-Gm-Message-State: AOJu0Yz7QllUfiWPKGftbvDeRoJ2IpJUigI3aLhjxp33uP7InQ4+3RgV
 4snpPJlhLciY509r9zKU0GeuJ1PI8p/vVdY1DTl3tFaCQl/WJP0ZzOXNyNCiM6s/2/4thokHrWF
 5
X-Google-Smtp-Source: AGHT+IEQmoD2w5OZ7AB4AAv4HK54RgP0uDA+rAd17ns9hL8x/0L2a3OUoJvNzAsxRGElxc4yabgUXA==
X-Received: by 2002:a17:90a:db0c:b0:29d:d860:ae59 with SMTP id
 g12-20020a17090adb0c00b0029dd860ae59mr6334494pjv.6.1710508178095; 
 Fri, 15 Mar 2024 06:09:38 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.184.12])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a17090ad40300b0029c68206e2bsm2886663pju.0.2024.03.15.06.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 06:09:37 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 04/12] tests/data/uefi-boot-images: Add RISC-V ISO image
Date: Fri, 15 Mar 2024 18:39:16 +0530
Message-Id: <20240315130924.2378849-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

To test ACPI tables, edk2 needs to be booted with a disk image having
EFI partition. This image is created using UefiTestToolsPkg.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 .../bios-tables-test.riscv64.iso.qcow2          | Bin 0 -> 16896 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2

diff --git a/tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2 b/tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..c720bf99a45fab6d1e21963cca563ee0ea059b82
GIT binary patch
literal 16896
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

literal 0
HcmV?d00001

-- 
2.40.1


