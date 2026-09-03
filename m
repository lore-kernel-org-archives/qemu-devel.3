Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D56AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2ArN-0002Dk-WD; Thu, 03 Sep 2026 13:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x2ArM-0002D5-NC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:04:20 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x2ArH-0004xx-72
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:04:20 -0400
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso23925b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788455053; x=1789059853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/CJ8KzvlazOBKLEVXH1fy9ZNXLYvu4iaL4gRsQwz/YM=;
 b=WRvdzaK2cPxj0Ha5MRtzTzRa9lgN8UEG3kyMxdj+tmzBvIUvZFssysN8adbmOuMCwY
 rElA7b13U0j79/h/1Vyw/n7B3wGpQqDkFGDra1Cktcr0K9Imenrgj+HR9fyO26kbXOMJ
 AEdsO0KxzATySgfEUiovJQzxVWaYOYX2yhcztnQXY9SskuRhGuRIf1rEmWa8Pf2xmo34
 +FwNp/rc+6fWMrIxtsR7kZM+rZCHB7fyIuPlEnShtZ/vRiE+IZv5YgaVhWQ4G37bYUuP
 7eLK32IDsqhKangaqjzvDRWCekC0Z3iFee4QaQtdaZIaokCenfWufl57pY09u1dg/6VH
 dDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788455053; x=1789059853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/CJ8KzvlazOBKLEVXH1fy9ZNXLYvu4iaL4gRsQwz/YM=;
 b=e+xQA++DiA/cXOgPyIOf+7PWofOaWZeUmaMk4fq463V1NV/yX6yPFkrHmhAZRgwazw
 0mQljqMea3X2wSJ9nfoy0SbitxzyfzjCpMKfuOQJCRz86biztAwVbhewMKr2oSRzrsUN
 eQhTkVclNcT+vcrDA7q5UUBz9zZ/Jlc6hY/X94+SJWcrFn2XZf/kB6yyOBsJTvsDU0CQ
 ddGhcEMBhb1yzSqheKoSOdUZgAonvs6zGk6dineQOhEekQ30HhWfl7jBkpasIxhxmKtx
 QaXwbf9wPy6lojGKJaOVE8nPDiruBdWeEq1kQTZsD2Ix1cLBmk/zNyY3s5ifvOhNups7
 z2NQ==
X-Gm-Message-State: AFuF++mA0n1/nWjxuOkPmLkzTtENtGiP7hcj23w1o5y3ydKbKi7DXflc
 WR5EmwHo3onHTw7qm+wn97G1xFD71d8ia5PVCVpy6Ex9Ukpl5JOrDGOITB+GyDnGj9JlJDlClrk
 +73sXE2BnviaKb8VL/38jsBlpmZMjZudP2U4Dyymg8Q42h7Yprr2DHb0BemThIw4AG2L+ywlSJM
 IWYWQ7SgFey/pKvqGxzwdGnqMyDpyC8s/+xC1wC0IygQ==
X-Gm-Gg: AYBFou3tklaC0pCpt6hgDln3FNc3c3dM3gFexUfw43YAeVDg2qzX3eFIAa7QHCOlhqe
 BQ16DpTgoUxFz0jDPmwDDNoCumanQ5wu7pYjnVsvhJL8k8l7AyGQ4J/Vagmu782UQNMmK4XrHBE
 E4ILbpqxakIqvH6BVb9Hs1h5fIpOSnMTn1tk0gbPeVkntHDHa8qsdxO/VxtSkFMNXdMu6DRyXTe
 rMVgC2NWq1V6KZ4UC4bDCkr5uaH/F/nMSAengLTIzYkTy2IuNu8aJj3u71smnLstty1e49vB3gN
 x0h29GUqoHXS6g/0s5/1VHauMs3TWXoub1fcU7U7TRfX4HbEZyfiu50uePUGgXDqDcl561VDAIR
 Vyl5NUAIslFWmMiuPOYn9E/TEZFr52a5UTt5An+AghJsoAUIiakvhsu1Slaw2OLaBmS/B1Rqmgv
 HFsMEloitaaxSeSqXWVwcZxu03f1e+BU3IVPxXF3Q6ps9UrcxRE98x31RQkhjG4YEN08CEAndgn
 /lBckYIm55H4Szg6Y3G6F374qFyZEzZv0/ekt79f4lgqv8EAYxzh3vIANzQyJQFlxaHWGnl5A==
X-Received: by 2002:a05:6a21:115:b0:3d3:adbf:7782 with SMTP id
 adf61e73a8af0-3d9b0012574mr22893038637.23.1788455051517; 
 Thu, 03 Sep 2026 10:04:11 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc43d39e4ddsm1227860a12.5.2026.09.03.10.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 10:04:11 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH 0/2] tcg/riscv64: Fix AUIPC pair range validation
Date: Fri,  4 Sep 2026 01:04:03 +0800
Message-ID: <20260903170405.3632015-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.176; envelope-from=max.chou@sifive.com;
 helo=mail-pf1-f176.google.com
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset tries to fix the AUIPC-pair range checking issue in
current TCG riscv64 backend.

The issue will be triggered in the following example.
---
Assumptions
- AUIPC at       0x00007fff77fa1258
- target call at 0x00007ffff7fa12d6

The direct pc-relative displacement from the AUIPC at 0x00007fff77fa1258
is 0x000000008000007e, so it is already outside the signed 32-bit range.
tcg_out_call_int therefore takes its far-call path: it separates the JALR
immediate (0x2d6) and asks tcg_out_movi to materialize this page-aligned
base:

  target call  = 0x00007ffff7fa12d6
  JALR lo      =              0x2d6
  base         = 0x00007ffff7fa1000
  base - AUIPC = 0x000000007ffffda8

The final value, 0x7ffffda8, is less than INT32_MAX. The current range 
therefore accepts it, but that is not sufficient: the signed low 12-bit
immediate must be removed before the value can be encoded in AUIPC.

The current reloc_call performs that split as follows:

  int32_t lo = sextreg(offset, 0, 12);
  int32_t hi = offset - lo;

For the captured placement, the values required by the split are:

  offset = 0x000000007ffffda8
  lo     = 0xfffffffffffffda8
  hi     = 0x0000000080000000

The lo is representable by the ADDI immediate. But the hi is not
representable by int32_t: narrowing it produces the bit pattern
0x80000000, which is -0x80000000 as a signed 32-bit value.
Thus the int32_t split can accept a wrapped upper value instead of
proving that the positive upper contribution required by AUIPC is
representable.

AUIPC has a 20-bit immediate which it shifts left by 12 and sign-extends.
Consequently, an encoded immediate of 0x80000 means -0x80000000, not the
required +0x80000000. The resulting generated code will be:

  0x00007fff77fa1258: auipc t6,-524288
  0x00007fff77fa125c: addi  t6,t6,-600
  0x00007fff77fa1260: jalr  ra,t6,726

It computes the base as 0x00007ffef7fa1000 and transfers to
0x00007ffef7fa12d6, exactly 4 GiB below the requested callback which is
0x00007ffff7fa12d6.
---

This patchset addresses the issue of AUIPC split checking and applies
the corrected split. It ensures that the split is checked before
emitting AUIPC/ADDI and AUIPC/JALR pairs in tcg_out_[movi|call_int].

rnax

Max Chou (2):
  tcg/riscv64: Validate AUIPC relocation range
  tcg/riscv64: Fall back when AUIPC pairs are out of range

 tcg/riscv64/tcg-target.c.inc | 68 ++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 19 deletions(-)

-- 
2.43.7

