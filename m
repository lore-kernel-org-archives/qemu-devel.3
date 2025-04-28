Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BB3C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9OOl-0002mV-9M; Mon, 28 Apr 2025 09:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9OOF-0002ib-CG
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 09:19:27 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9OO1-0006nU-34
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 09:19:18 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso819054166b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 06:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745846339; x=1746451139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6gGbxYX549vYcbLIu9HzUb5obTmKnFd3OIrxZDU+kY8=;
 b=ePjAupJud/ZFBI5diA94qhXCqEMUNEM5gRfA84tw/7XUwy3/gxQrE2Ghqu6t7UoVN5
 i4yKLb/bLpvf76qG3KOiuYZypfjZiGcb4fXineX9aSNgwnnFLIlp3yGVff765KIGIt4n
 tGFFits176Y5FFQXFycBsMC9DwFfWzbkaYvN6D/fsECFrkaL3LL9NcZ9EsWLzQ15Vk7c
 oAS/hJnHNt+QrNxRm+B2kVzC1WSY1v07oZ+BF8oidOyhavx1jLrEHsAjOl2Evu+S8UaB
 yfpNSrSUWV0waAQSK75ehEbEtHDsyV8+Qf0Bc/eiR4v0eZjZthAc4EDCGV0Vds3pDYO1
 imBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745846339; x=1746451139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6gGbxYX549vYcbLIu9HzUb5obTmKnFd3OIrxZDU+kY8=;
 b=gxqXKNZhwIiy/lriBdf/BJQ2W0PblND4Cv8RWqGT+X7dPsnObV7/mT6gjPr1CrsysS
 U2g+Uh22O2ObMYhcujm6xBGMtqB9wYo3+25GrCTCL/trBkiAzKsbd0Cf1PoloNr9Rk6C
 WjhqeN91SpSaZdAs4ygOwTlUCHHD1xq/8AircX6cQ8XNA35zkioXBGH04awI/oiRLb1t
 8O6se0Y8eZTk9ejnpNPx2/8wqyJDb03CeBu2CHaZXD+ErYNLf14lzhR2gOIKngLwoWGl
 a3FDe1RTaR34waASs/HyUWpy7vfF1N6OnHU6+k7zxPuwkbXeTWOfd7+Fe8d7cll5vNh+
 hp4w==
X-Gm-Message-State: AOJu0YyJn032Ue+aHPZz88dLUdpbW2M4FaClaDS1ACRUJhzqBZ8P5ITc
 p16+Yf4yxCW00WGxf5YlkqZMRXb5wFOLgyjPryRjqIjuSSzR6A0RqEb/g1AVey8=
X-Gm-Gg: ASbGnct/2/0XvF0/q6iiD1Xn+4VZ/UW+XSCobu6rdAuUvgal/WedCr2ONouAgcmmgxj
 oJPqmNHYGvrI/HprLhkDjM7N9BGXoUqt5UCgJE2gYynGv7omwEECWDz8qfIxgANVgHFU4WhiCjx
 TazCdMoqR/tLiNoW/uP0MufVI8/O6jpqTIqiCrIJAwr7MvuUVDmEOfjdiV9Mkz2H8bPOya0NBB4
 q/NJtNSMn2G2jh34W0fTIWEFnKShin5Mp6z2Ds9M8Bs616fuczUc4Xw6kjEHkhCVWy4gj+Z8FXy
 sly+UczBv8dF6rAbwusjneFfeR0etnlGshMbhv4A2bc=
X-Google-Smtp-Source: AGHT+IFKVqZ+9TI25idN1DlUSXTxXe9o/0cqjt4ldzf376Pf2LOyzXqZHSigoAmWzTKO2ricf11QfA==
X-Received: by 2002:a17:907:26c7:b0:aca:a35e:59fe with SMTP id
 a640c23a62f3a-ace739dce06mr1001707966b.1.1745846339124; 
 Mon, 28 Apr 2025 06:18:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ecf82f9sm618687566b.88.2025.04.28.06.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 06:18:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7AE45F905;
 Mon, 28 Apr 2025 14:18:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, thuth@redhat.com
Subject: [qemu-web PATCH] _posts: fix two typos on the 10.0 release
 announcement
Date: Mon, 28 Apr 2025 14:18:53 +0100
Message-Id: <20250428131853.455851-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We already had EL2 timers, the new ones where for secure mode. Also
fix a transposition on s390x.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 _posts/2025-04-23-qemu-10-0-0.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/_posts/2025-04-23-qemu-10-0-0.md b/_posts/2025-04-23-qemu-10-0-0.md
index f561275..7d4dd87 100644
--- a/_posts/2025-04-23-qemu-10-0-0.md
+++ b/_posts/2025-04-23-qemu-10-0-0.md
@@ -14,7 +14,7 @@ Highlights include:
  * block: virtio-scsi multiqueue support for using different I/O threads to process requests for each queue (similar to the virtio-blk multiqueue support that was added in QEMU 9.2)
  * VFIO: improved support for IGD passthrough on all Intel Gen 11/12 devices
  * Documentation: significant improvement/overhaul of documentation for QEMU Machine Protocol to make it clearer and more organized, including all commands/events/types now being cross-reference-able via click-able links in generated documentation
- * ARM: emulation support for EL2 physical and virtual timers
+ * ARM: emulation support for Secure EL2 physical and virtual timers
  * ARM: emulation support for FEAT_AFP, FEAT_RPRES, and FEAT_XS architecture features
  * ARM: new board models for NPCM8445 Evaluation and i.MX 8M Plus EVK boards
  * HPPA: new SeaBIOS-hppa version 18 with lots of fixes and enhancements
@@ -24,7 +24,7 @@ Highlights include:
  * RISC-V: ISA/extension support for riscv-iommu-sys devices, 'svukte', 'ssstateen', 'smrnmi', 'smdbltrp'/'ssdbltrp', 'supm'/'sspm', and IOMMU translation tags
  * RISC-V: emulation support for Ascalon and RV64 Xiangshan Nanhu CPUs, and Microblaze V boards.
  * s390x: add CPU model support for the generation 17 mainframe CPU
- * s930x: add support for virtio-mem and for bypassing IOMMU to improve PCI device performance
+ * s390x: add support for virtio-mem and for bypassing IOMMU to improve PCI device performance
  * x86: CPU model support for Clearwater Forest and Sierra Forest v2
  * x86: faster emulation of string instructions
  * and lots more...
-- 
2.39.5


