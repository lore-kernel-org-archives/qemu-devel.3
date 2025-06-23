Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB5EC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThgs-0008CQ-U2; Mon, 23 Jun 2025 09:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThgq-0008BZ-SD
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:28 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThgo-0007Fl-Fh
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:28 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-747fc7506d4so3257370b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750687102; x=1751291902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FjqjwOShSvL5ZiDHvWdQfdLkebsd1QtRSET7cdjduQM=;
 b=iY4sC5A7RGzhl4Tt258Pldie4fo+AL+LvUUsCXd1A06laSx/8qe9zC9xy6aJ5ovjLH
 k79HBP5hlaWz/cYtUrCDzL8hOphygB+MvGLCUbU5Wm60tUwwCAbxzDd2YASHztBrOQG+
 nn8xOX1xIRE40TmqxmyC9Of+L5kp6uW9oM/P7p149iNkMySpTu1yuRTLHk8ThMD4uxYZ
 kBfL5KaAmDYFdQx6dEgLoIeECVgb0C6nI+e/SONJb9fssoGMKOwIa00Eg5Y3ZW4X/TVb
 GUfpWmXFKj8O0EWQxrwtOQCnou1m/N5otnCJseuJOeH2aUymxdmaWbF4Am0bBrger7/r
 jCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750687102; x=1751291902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FjqjwOShSvL5ZiDHvWdQfdLkebsd1QtRSET7cdjduQM=;
 b=gKmnKVbhsQETyOOlNOQ7Fy8uCJWTBLRpUj0k/a3wZGGo3Ecfye5rwPyoEDh27Kx4CX
 aXx+zKNz6yhPuenAU9vbaZK2IuzDEwoPkBVrefkDqhO9MuB+zFFHMcPODz9LKucohmWu
 3iNXnB3DhtqYP+EfatZ5nx6q2gaZBeb3VF6xKDrPBlFKTuSGK7iwjl9WALdGirEnKZa7
 ZMK/hKEFOkdbCKEFLxwrccLgHPeINxhF4QT9ylu7KfgSttBaklxX4hMO9z8fhhLzUt4j
 rlJHTFdT15xSYlDTu53DYRssNUOh168dvrE8dKVDaasrBY1mrXjdGoV0U1sX4CKIr7I/
 06Kw==
X-Gm-Message-State: AOJu0Yydua/PPDdtH2LDzL0Zdn51snE0FN0JRhCUaIWYp+9fZvm0cSxY
 wtDEhdDbzKxmy9IeRhyaJPRW2HrjJTy/n0x1NIJ5ABPkNRyxLODGYhqwsxVXEVJQ2Kjeg6U16ea
 b/VWm
X-Gm-Gg: ASbGncuJ5kgppeqYkytpxfcDZ1u1I7GGjvVkinkGhIT8RfyOjQsRIKTp8mAf2u9GHxt
 Z6ht5ngIkSrm390m/UYx2ZpHvwMVjP8kQgMxFQqN5OlHj3jqY/nEtYsLacleZ8NNdjBKVMMKxlN
 rz9gttMzvrIjl/a9nYP4m5ZFsaJ8sz3HFQuvr2/cUhMztf9+Br7HH2VZwVOzkSlhjSqIcRda1OI
 v+PeeMB3u3fol2u5YY81Utxp6fw7k0jMmsbigYa/OOShuLV/kGV0ima3NJJFNaBiK0/zdfZKT44
 yDc95tTV+jEwkrGFtKU8Jh8+R7Oc9eTe//VifKMHdAAT4HiQZFwZKPQnTeoycPiCfyU=
X-Google-Smtp-Source: AGHT+IHaA3Yci2lOBcHNqVah8h5dJVMn2TwdFADEDLj0ezLFm7ojgfI/ihv3C+IjezMknXl6Qtfe3g==
X-Received: by 2002:a05:6a21:6daa:b0:216:5f67:98f7 with SMTP id
 adf61e73a8af0-22026fb9b57mr16047428637.33.1750687102509; 
 Mon, 23 Jun 2025 06:58:22 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119eb64sm8063490a12.31.2025.06.23.06.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 06:58:21 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH-for-10.1 v5 0/9] hw/arm: GIC 'its=off' ACPI table fixes
Date: Mon, 23 Jun 2025 13:57:40 +0000
Message-Id: <20250623135749.691137-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42e.google.com
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

Since v4:
- Fixed/restored commit authorship and author tags (philmd)
- Factored out create_its_idmaps to clarify how ID ranges that
  go direct to ITS Group node are created (eauger)
- Addressed all remaining minor review comments (eauger)


v1: https://lists.gnu.org/archive/html/qemu-devel/2025-03/msg07080.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00495.html (Patches 6/14 -> 14/14 in the series)
v3: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00567.html
v4: https://mail.gnu.org/archive/html/qemu-devel/2025-06/msg02583.html

Fix ACPI tables for '-M its=off' CLI option and resolve the issue:

https://gitlab.com/qemu-project/qemu/-/issues/2886

Cheers,
Gustavo

Gustavo Romero (6):
  hw/arm/virt: Simplify logic for setting instance's 'tcg_its' variable
  hw/arm/virt-acpi-build: Improve comment in build_iort
  hw/arm/virt-acpi-build: Factor out create_its_idmaps
  qtest/bios-tables-test: Add blobs for its=off test on aarch64
  hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables when its=off
  qtest/bios-tables-test: Update blobs for its=off test on aarch64

Philippe Mathieu-Daudé (3):
  hw/intc/gicv3_its: Do not check its_class_name()
  hw/arm/virt: Simplify create_its()
  qtest/bios-tables-test: Add test for when ITS is off on aarch64

 hw/arm/virt-acpi-build.c                  | 169 ++++++++++++++--------
 hw/arm/virt.c                             |  25 ++--
 include/hw/intc/arm_gicv3_its_common.h    |   2 +-
 tests/data/acpi/aarch64/virt/APIC.its_off | Bin 0 -> 164 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off | Bin 0 -> 172 bytes
 tests/qtest/bios-tables-test.c            |  21 +++
 6 files changed, 143 insertions(+), 74 deletions(-)
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off

-- 
2.34.1


