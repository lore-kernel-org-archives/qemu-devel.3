Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77273CCFA04
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 07:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGXnC-0002WB-Dt; Wed, 05 Nov 2025 02:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jerry.zhangjian@sifive.com>)
 id 1vGXn5-0002Tr-9M
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 02:18:48 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jerry.zhangjian@sifive.com>)
 id 1vGXn3-0000dG-Bs
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 02:18:47 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-29555415c5fso53050455ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 23:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1762327123; x=1762931923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MlG5rnOvUQA75NWfv4D3M3eKo3Ku1ZTp/yqLDnLUGQA=;
 b=Q4lKJAScPO10oN4jIfLuCvfthxrwMnIEdl5vcT6I0N1ErhIlpKRJBcMMM2INung5k8
 tP2TCNvM9lgFIzyVLDCQmUC33lTfk4t5mpQFRvpZI/HyV5onjk/YWTGFO9GCp/GQv97p
 VW4Ao2cj+lpd27PL9Obd/h8MHz/aFi3DApyx+T6RtINCG5pKnqPdtlcC9Q+6ypud/VR8
 1REjZfJFjHKb8yUdsswnwEP7eAlpdtNiUgRvQVAsygtV8qArJMfzgQo4PPoojCHB/dJ/
 x2wa6FiHlBGbyQRMz2VXr5Aly2gZJGD5gBbS/mROPK3d7pmceseDM3y2EGrPxuxQ6U21
 586g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762327123; x=1762931923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MlG5rnOvUQA75NWfv4D3M3eKo3Ku1ZTp/yqLDnLUGQA=;
 b=P2h2DVgp1etm/7/mArV9xY2XPxojGx35/KAEDEOTdjFXIgtFtbouXX93qGg6yDQ6kV
 oR9yqza/8krRu828US8kJC+ueG0Us0sL5L2qfuP4h3AVaK/vkUBgDXh5n49psRkWo+EX
 7/HUYgt8wzxmXtbjT4CdTN3vM25LbI/wwoCoU+mX70bMhgb8w45zxshoxRyhxBVaFo3a
 dEBFoNE09IhqNCuLItuQv49yxc3wHqLqw/auorKlUezbTC7E8e5NR6dTLbj6hwg7wMYS
 KzKPxCpS7lv4SLd1P12bsuGJw3/rTTUip6glUBZteqoigSiZegR2p/0GjRt57RFpyECw
 t+qw==
X-Gm-Message-State: AOJu0YwyD0m24N092Q4ioZOLpSvdrnPkk41mpbY/Jb34KM6GuPSSQAP3
 A/5M+lwFEFA4bsLa3ZDuiNRmRajDHKLsb5GeeS9MpyXJYe+X6GpogSAsVGGtE9H8TfFmPPVmRZt
 91Ez/zT8qImlGlTleGMwOSTfboC3l65X0oq/8xML9HbWgBKdaMamX2Um0ocEhmrfkJp6AgPy7Od
 ahjb7H9g8RQbP2eAqALuINJRKg2A1T0YthWWUeYxIc5OO+Oq/MGJ5NfJle
X-Gm-Gg: ASbGnct7weNKFTurlVRt9v31c9xrs2RWau4St69b3TFLULsH2uoAeq541XOsCddqwaH
 3K607kXdAGWggEr9+uZjz9RGm9sECSlIolucsctKSNKTWoRitsjtmxfwFBVPDzZE5/fFb75P/0n
 8Omf5SuSpmcNOiKJuIgSV/RN6Dq3/dpgHmovgnBk0VOr6S7EsFD0uw645wdq5Oj7adgsshM5+2W
 pDJhlV8pqDz8KMHEXScMXAUcm8iU0XcLSpepfJcg2VBzef3ZVhNcuibO8gQbKQdpUt70ksUJDjc
 k9vyrSpD3nQA++8Mjp6v+z8yHqt4uCtoTM7FTpO09o+9URYv2K/AB6tSXO17YspkJg1bcQqQD8c
 m4y+zcEgCVEttAZtYgMa1IsaR8242Ni6W+afUoe3SRNZO1uObmU8HHHRbNuXCZ98M4FgaAujkby
 AR5OmT+EqJUZiKxLG+wIUKJYE=
X-Google-Smtp-Source: AGHT+IHJntEwTcX6/7fTPo2BtkxbxCQp100jH5FoEsAJ52HMWGiy3hcrGH656V5IZaBl/ivf08qIUQ==
X-Received: by 2002:a17:902:d505:b0:290:c0ed:de42 with SMTP id
 d9443c01a7336-2962ada2117mr35771225ad.36.1762327122701; 
 Tue, 04 Nov 2025 23:18:42 -0800 (PST)
Received: from sw08.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29601a741e3sm49708465ad.98.2025.11.04.23.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 23:18:42 -0800 (PST)
From: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, qemu-riscv@nongnu.org, kito.cheng@gmail.com,
 frank.chang@sifive.com, Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Subject: [PATCH] target/riscv: Add bfloat16 and half-float support to GDB stub
Date: Tue,  4 Nov 2025 23:18:30 -0800
Message-ID: <20251105071830.946163-1-jerry.zhangjian@sifive.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jerry.zhangjian@sifive.com; helo=mail-pl1-x62b.google.com
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

Add bfloat16 and ieee_half fields to the RISC-V FPU register unions
in the GDB target description XML files. This allows GDB to access
FPU registers as BFloat16 or IEEE half-precision floating-point values
in addition to the existing single and double precision formats.

For 64-bit FPU (riscv-64bit-fpu.xml):
- Add bfloat16 field to riscv_double union
- Add half (ieee_half) field to riscv_double union

For 32-bit FPU (riscv-32bit-fpu.xml):
- Create new riscv_single union with bfloat16, half, and float fields
- Update all 32 FPU registers to use riscv_single type instead of
  ieee_single

This enables GDB users to inspect and modify FPU registers using
different floating-point formats:
  (gdb) print \.bfloat16
  (gdb) print \.half
  (gdb) print \.float
  (gdb) print \.double

This change corresponds to the GDB-side support for these formats:
https://sourceware.org/pipermail/gdb-patches/2025-November/222353.html

Signed-off-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
---
 gdb-xml/riscv-32bit-fpu.xml | 70 ++++++++++++++++++++-----------------
 gdb-xml/riscv-64bit-fpu.xml |  2 ++
 2 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/gdb-xml/riscv-32bit-fpu.xml b/gdb-xml/riscv-32bit-fpu.xml
index 24aa087031..f0439c626e 100644
--- a/gdb-xml/riscv-32bit-fpu.xml
+++ b/gdb-xml/riscv-32bit-fpu.xml
@@ -7,36 +7,42 @@
 
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
 <feature name="org.gnu.gdb.riscv.fpu">
-  <reg name="ft0" bitsize="32" type="ieee_single"/>
-  <reg name="ft1" bitsize="32" type="ieee_single"/>
-  <reg name="ft2" bitsize="32" type="ieee_single"/>
-  <reg name="ft3" bitsize="32" type="ieee_single"/>
-  <reg name="ft4" bitsize="32" type="ieee_single"/>
-  <reg name="ft5" bitsize="32" type="ieee_single"/>
-  <reg name="ft6" bitsize="32" type="ieee_single"/>
-  <reg name="ft7" bitsize="32" type="ieee_single"/>
-  <reg name="fs0" bitsize="32" type="ieee_single"/>
-  <reg name="fs1" bitsize="32" type="ieee_single"/>
-  <reg name="fa0" bitsize="32" type="ieee_single"/>
-  <reg name="fa1" bitsize="32" type="ieee_single"/>
-  <reg name="fa2" bitsize="32" type="ieee_single"/>
-  <reg name="fa3" bitsize="32" type="ieee_single"/>
-  <reg name="fa4" bitsize="32" type="ieee_single"/>
-  <reg name="fa5" bitsize="32" type="ieee_single"/>
-  <reg name="fa6" bitsize="32" type="ieee_single"/>
-  <reg name="fa7" bitsize="32" type="ieee_single"/>
-  <reg name="fs2" bitsize="32" type="ieee_single"/>
-  <reg name="fs3" bitsize="32" type="ieee_single"/>
-  <reg name="fs4" bitsize="32" type="ieee_single"/>
-  <reg name="fs5" bitsize="32" type="ieee_single"/>
-  <reg name="fs6" bitsize="32" type="ieee_single"/>
-  <reg name="fs7" bitsize="32" type="ieee_single"/>
-  <reg name="fs8" bitsize="32" type="ieee_single"/>
-  <reg name="fs9" bitsize="32" type="ieee_single"/>
-  <reg name="fs10" bitsize="32" type="ieee_single"/>
-  <reg name="fs11" bitsize="32" type="ieee_single"/>
-  <reg name="ft8" bitsize="32" type="ieee_single"/>
-  <reg name="ft9" bitsize="32" type="ieee_single"/>
-  <reg name="ft10" bitsize="32" type="ieee_single"/>
-  <reg name="ft11" bitsize="32" type="ieee_single"/>
+  <union id="riscv_single">
+    <field name="bfloat16" type="bfloat16"/>
+    <field name="half" type="ieee_half"/>
+    <field name="float" type="ieee_single"/>
+  </union>
+
+  <reg name="ft0" bitsize="32" type="riscv_single"/>
+  <reg name="ft1" bitsize="32" type="riscv_single"/>
+  <reg name="ft2" bitsize="32" type="riscv_single"/>
+  <reg name="ft3" bitsize="32" type="riscv_single"/>
+  <reg name="ft4" bitsize="32" type="riscv_single"/>
+  <reg name="ft5" bitsize="32" type="riscv_single"/>
+  <reg name="ft6" bitsize="32" type="riscv_single"/>
+  <reg name="ft7" bitsize="32" type="riscv_single"/>
+  <reg name="fs0" bitsize="32" type="riscv_single"/>
+  <reg name="fs1" bitsize="32" type="riscv_single"/>
+  <reg name="fa0" bitsize="32" type="riscv_single"/>
+  <reg name="fa1" bitsize="32" type="riscv_single"/>
+  <reg name="fa2" bitsize="32" type="riscv_single"/>
+  <reg name="fa3" bitsize="32" type="riscv_single"/>
+  <reg name="fa4" bitsize="32" type="riscv_single"/>
+  <reg name="fa5" bitsize="32" type="riscv_single"/>
+  <reg name="fa6" bitsize="32" type="riscv_single"/>
+  <reg name="fa7" bitsize="32" type="riscv_single"/>
+  <reg name="fs2" bitsize="32" type="riscv_single"/>
+  <reg name="fs3" bitsize="32" type="riscv_single"/>
+  <reg name="fs4" bitsize="32" type="riscv_single"/>
+  <reg name="fs5" bitsize="32" type="riscv_single"/>
+  <reg name="fs6" bitsize="32" type="riscv_single"/>
+  <reg name="fs7" bitsize="32" type="riscv_single"/>
+  <reg name="fs8" bitsize="32" type="riscv_single"/>
+  <reg name="fs9" bitsize="32" type="riscv_single"/>
+  <reg name="fs10" bitsize="32" type="riscv_single"/>
+  <reg name="fs11" bitsize="32" type="riscv_single"/>
+  <reg name="ft8" bitsize="32" type="riscv_single"/>
+  <reg name="ft9" bitsize="32" type="riscv_single"/>
+  <reg name="ft10" bitsize="32" type="riscv_single"/>
+  <reg name="ft11" bitsize="32" type="riscv_single"/>
 </feature>
diff --git a/gdb-xml/riscv-64bit-fpu.xml b/gdb-xml/riscv-64bit-fpu.xml
index d0f17f9984..7d6a44e145 100644
--- a/gdb-xml/riscv-64bit-fpu.xml
+++ b/gdb-xml/riscv-64bit-fpu.xml
@@ -9,6 +9,8 @@
 <feature name="org.gnu.gdb.riscv.fpu">
 
   <union id="riscv_double">
+    <field name="bfloat16" type="bfloat16"/>
+    <field name="half" type="ieee_half"/>
     <field name="float" type="ieee_single"/>
     <field name="double" type="ieee_double"/>
   </union>
-- 
2.51.0


