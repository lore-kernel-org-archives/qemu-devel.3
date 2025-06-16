Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CF0C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 13:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR9lO-0001vR-9U; Mon, 16 Jun 2025 09:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9l2-0001sJ-Ap
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9ky-0005Ow-11
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:16 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-236377f00easo59168335ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750080009; x=1750684809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uNf7y+/6ofYgMvYReSu8/5GsERjzD0pnv5R83eoQckY=;
 b=hbYqzn6a+P89hSkZYPjzirT5lWPuv66Hh0wu0e8wZcR6MjOqJ7ImR6kwyZygUFJv6P
 DJzdlnvEZdRvUrbr8OKbN5xIhS925csUFDnHPO1N6h0Xkyu8dG++X6gtVX9mB2fU0dKF
 MVdltHSS0DlIzSGK0ZUAV60FdjQ5hj7Q5unzTAdyaZkDD2qbJVvAAUNPgAyXehtMnJ3Y
 DCcCgq02hfynbNqwPs88y3ZzD7LGCKu503dOPwWX2Qb/2xskVNP6+Sxg9oqP87h7VVLE
 CuRfHvBNY8QgDIG69plYF/zPjBalhUQg7uhszZy3Zp4MPcLU5fsoJsvbuSoSCI57Jikb
 q+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750080009; x=1750684809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uNf7y+/6ofYgMvYReSu8/5GsERjzD0pnv5R83eoQckY=;
 b=L0BgnlM95hy7/qbBEuRcc6s5Rb84tCYEyMT0P2tKvhMolwBKf/z+KD+S590AfYq+BV
 xXh5zN+G0/IcgKmRTxG2CxR188ERzs5x2nltVj5283OhzuJXoACYbRfV/gAv4q842weA
 hgyYM5/ec+Z0yKdhe/4h1fY5hrdmSY/NzuPsidAuRbrVDjIbBl+yY+KcX7fLyKPhpwyh
 JzakC1I022V2Z9DaJyjRThaTvZXKkxOoVOTqqFO8eBwqmVeSl9mtBshd/J4I1MqGYcfx
 YzwI9J8TD1qUFafbretrphGrS5jEl7pJj8p0vztcxbPQ1EeAwYSOruk1sbkC7VB3cGzW
 sHbQ==
X-Gm-Message-State: AOJu0YyRps1zVIZp7MFvz9XXcLPl8Dm8ugWoHx9HJ2Fdj62cD/gNBF22
 Inm2XT2jvoOHIsngrQ7LMIZ+eVI2sT2s+fv41g/8k5MrBAO9cRBV8yp00166qDSBUWzwlsGqitG
 inxPy
X-Gm-Gg: ASbGncsSnHwffoNlZQDBPkTisia3wZ+87384DqYKENtEVeaMdpiaLjbqPoaXAmVvBRy
 sqmMQBNZlhfaPpInOESz2Cix0f1XbaKTBymZ3pARYfzsQixkiwOiDVh/IDRTIx2E0Q78jEAgDI9
 /1j955GxAZ+d/2FvI8QAjpMHaXc3GAgbh75n5TebBcyEmXwazcsU97xTDd3Xbkhi3l+FKQlV6dc
 Ngjrbic1yplmBu29986kgpGiUr5MmlLiuMf8MWxhJQTEkxlCL2WPP41XtVglM8+H7PAQchwFgLu
 n7e7sMuCub5N44SRaTyZJe2X1BozToziujk6FaxHZOOLgMTDtj7FaMF+8Xidkknr5Ww=
X-Google-Smtp-Source: AGHT+IGPR+J8JnQD02BCUXxj6XnYAMDJIcL+Ov/45yfP7Qaz1djmpYnFDujB8TZCPuhD7veCK3Ii4A==
X-Received: by 2002:a17:903:2ac7:b0:235:2403:77b6 with SMTP id
 d9443c01a7336-2366b149bccmr143751185ad.37.1750080009039; 
 Mon, 16 Jun 2025 06:20:09 -0700 (PDT)
Received: from gromero0.. ([186.215.60.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365de781dfsm60848405ad.131.2025.06.16.06.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 06:20:08 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH-for-10.1 v4 0/8] hw/arm: GIC 'its=off' ACPI table fixes
Date: Mon, 16 Jun 2025 13:18:16 +0000
Message-Id: <20250616131824.425315-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
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

Since v2:
- Fixed no_tcg_its inverted logic (rth)

Since v3:
- Fixed remappings in the IORT table when ITS is no present
- Rebased on master and resoled conflics, like no more "no_its"
  flag in VirtMachineClass
- Dropped patch 1/9 because we actually want the instance flags,
  not only the class flags, and the instance flags are the ones
  to be used often when deciding about the presence/absence of a
  machine feature, instead of the negated class flags ("no_*")
- Adapted the other patches that depended on 1/9
- Dropped patch 4/9 in favor of using the instance flag for
  checking if ITS is on or off
- Simplified VM options for the new "its=off" test

v1: https://lists.gnu.org/archive/html/qemu-devel/2025-03/msg07080.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00495.html (Patches 6/14 -> 14/14 in the series)
v3: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00567.html

Fix ACPI tables for '-M its=off' CLI option and resolve the issue:

https://gitlab.com/qemu-project/qemu/-/issues/2886

Cheers,
Gustavo

Gustavo Romero (7):
  hw/intc/gicv3_its: Do not check its_class_name()
  hw/arm/virt: Simplify logic for setting instance's 'tcg_its' variable
  hw/arm/virt: Simplify create_its()
  hw/arm/virt-acpi-build: Fix comment in build_iort
  qtest/bios-tables-test: Add blobs for its=off test on aarch64
  hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables when its=off
  qtest/bios-tables-test: Update blobs for its=off test on aarch64

Philippe Mathieu-Daudé (1):
  qtest/bios-tables-test: Add test for when ITS is off on aarch64

 hw/arm/virt-acpi-build.c                  | 134 +++++++++++++---------
 hw/arm/virt.c                             |  25 ++--
 include/hw/intc/arm_gicv3_its_common.h    |   2 +-
 tests/data/acpi/aarch64/virt/APIC.its_off | Bin 0 -> 164 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off | Bin 0 -> 172 bytes
 tests/qtest/bios-tables-test.c            |  21 ++++
 6 files changed, 113 insertions(+), 69 deletions(-)
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off

-- 
2.34.1


