Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0BEC19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 13:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toj2A-00031S-Kh; Sun, 02 Mar 2025 08:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hemanshu.khilari.foss@gmail.com>)
 id 1toj28-000313-QC; Sun, 02 Mar 2025 08:07:04 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hemanshu.khilari.foss@gmail.com>)
 id 1toj27-00036i-5K; Sun, 02 Mar 2025 08:07:04 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-22385253e2bso24935245ad.1; 
 Sun, 02 Mar 2025 05:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740920821; x=1741525621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I717ThhCHMHXaLzr82CQoevh9Tv9rqnCvSSdwP9fxSI=;
 b=mpqyH67Fs/dBNJFQEcHR2FjXO8cZLRXkoafn5ADK9WLPYADToUOfS9Q9q45sISQ9Yk
 4OMCI5sHMuofOZFzQ2DIl7f53WYPZVXPyFrWhnV/m1wojuNcW7IW3w7aENXpqWfYI0fs
 8dJ2SCQnwMS7B/4uFJBYLJeKQHrKRvjIkz8FtEs8jlVJJhhQkN6BLKgbWGEvD6bvK2KN
 VEk+bGWiNElKrk0AFIpS9CzeraQ2VhdLAell00NLLJpxhNEF/anh9z7vjNwAVom9MCG9
 bmymzrF66KoENtFbZYAWNcGuRVVioDd0d1TKEszXZAVzoSd7cGb3UEKAk8GFMBIv5cWF
 0gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740920821; x=1741525621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I717ThhCHMHXaLzr82CQoevh9Tv9rqnCvSSdwP9fxSI=;
 b=mOkJE+/KfhSzExXXoxHzzxETfeBiTiHpjrSXa40fw2nLeqwxR6aYR11eKeTbs+Roof
 AYTa5kpMFGj7HnOd2lsBYL184dtnrM59ILN2EsADXHizV2DlLZApDcbuCap4eM6SXLMm
 fp+8kwbjy1ofeuTC6SvUTDRHbEBkZwtSvIeXWN6sJAjRU8a/UejuEt3UxlC1hAmT/V90
 Z+WBlG5TVeLktOx0Se6hR37QZqaZCM7DFxoXk0OkhKGL2J/Qfi8/LDNYpAPj6ei4uZBL
 GfgY3+4TMojKq4HQKu45aJkUJ6LkiZhuJZz0CgYdyFzbNXklJVZZ8+WarklGZPdS51RF
 vwxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy3Dig1JpmqpOxV/2dLWk9T26MQ0YKKtC9d238dtIMlj/lJe61XXm5gdR5vwo8qoIlN0/GeeD7Ypc2@nongnu.org
X-Gm-Message-State: AOJu0YzquwyHLrx4ic1MSp+Dp33+L2txqG4w73UITBwqkMtW4EZ28B0N
 aLIrObW+FJgKXd0n6nSSkjQ79NEk65wnZnSmMdr3evA5uiHX+1TcFPEdcb2Fl97id7+9FPE=
X-Gm-Gg: ASbGncuEGySROSveOzvUAV4PIGdr9DYD7x9+eB5H9t2lHYFh6B6Iu/jfMslFEOtRxYK
 GMgec0MzIKXfY5NJOHPWMp+4ahhPe+3A9izV0HUFemRayCrftAfMtjk1htap1BTLOnnT/d4a+HW
 nZPdw9gYumyQyORIWW/P84CW6t9KuMFW7pe059+XleDos2EoR91eyYViCnIcNXceqTfikXyFsy2
 r0ifQcZT4+b/L8GKRmcZPhh391utT9+NWm3H0Ue0/6wf6QlKAvdKgY7HU9aJeaRy+4y9g3nqbFX
 JfUFN5cZTfDLhhHWLED3mbBuZRU8etOcCOwTnA0hYuciSBSuU+kY521+i4Y/0x9tx85EDJOiVw=
 =
X-Google-Smtp-Source: AGHT+IFe8DMPIMW7UG64j0V7tYuoeMZ8Jte1skg00FEr+VFeEWxre93S6nmfdeSBMf4hb6cuTuPNTQ==
X-Received: by 2002:a05:6a00:22d6:b0:736:533b:f6fa with SMTP id
 d2e1a72fcca58-736533bfd92mr691377b3a.13.1740920820770; 
 Sun, 02 Mar 2025 05:07:00 -0800 (PST)
Received: from localhost.localdomain ([160.202.36.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe4894bsm7226071b3a.55.2025.03.02.05.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 05:07:00 -0800 (PST)
From: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, hemanshu.khilari.foss@gmail.com,
 qemu-riscv@nongnu.org
Subject: [PATCH v2] docs/specs/riscv-iommu: Fixed broken link to external risv
 iommu document
Date: Sun,  2 Mar 2025 18:36:19 +0530
Message-ID: <20250302130618.25688-2-hemanshu.khilari.foss@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=hemanshu.khilari.foss@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

The link to riscv iommu specification document is incorrect. This patch
updates the said link to point to correct location.

Cc: qemu-riscv@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2808
Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
---
 docs/specs/riscv-iommu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
index b1538c9ead..772145e8d7 100644
--- a/docs/specs/riscv-iommu.rst
+++ b/docs/specs/riscv-iommu.rst
@@ -4,7 +4,7 @@ RISC-V IOMMU support for RISC-V machines
 ========================================
 
 QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
-version 1.0 `iommu1.0`_.
+version 1.0 `iommu1.0.0`_.
 
 The emulation includes a PCI reference device (riscv-iommu-pci) and a platform
 bus device (riscv-iommu-sys) that QEMU RISC-V boards can use.  The 'virt'
@@ -107,7 +107,7 @@ riscv-iommu options:
 - "s-stage": enabled
 - "g-stage": enabled
 
-.. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
+.. _iommu1.0.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0.0/riscv-iommu.pdf
 
 .. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
 
-- 
2.42.0


