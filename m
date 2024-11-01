Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC169E6F06F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 17:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6v8e-0002Gp-AJ; Fri, 01 Nov 2024 13:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6v8c-0002GV-HP
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:08:42 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6v8b-00064s-0d
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:08:42 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e4e481692so1979739b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730480919; x=1731085719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=skjO6/KfjbtXR/JUy1d485PhXpXWJNWAEEtdHsUoy5w=;
 b=I0iOPU4h1qJxVYLfJhzj+xIcyjTEgCDn8c2rVOXcuPHAcO+owYZlogu7azm0Cb0Oed
 Rvcuyg7ScCnrMgfrIcIGYRQ9qY3Z6ckxA//tmwl4zDjcGbq4dCr5Lkj+aXq/gkllQleR
 It2GrF+leRg07qQX/OOvwzgr3dlqNxnrTI2NmMZgtFdphzhKPUM83zC5qn+fh8WFaTdK
 t8zycXwaNLv8Zqa0hAzzr2T1B/BXzcFdWMj8GU6LHMBLa0OdUtcDMs070tmpR7piQVI7
 YAmzGGBvb/VB/6bowHa1W7A/PTuME+BcTBfrrZ6o7pYr+rCZr0xB/+9j0Ug9yT4/V4RA
 Z9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730480919; x=1731085719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=skjO6/KfjbtXR/JUy1d485PhXpXWJNWAEEtdHsUoy5w=;
 b=BMKvX2ZmQRRAhVBP7R6BA4oIEzQ1RUzJyrlMO6B5w23pKyrN3Qk4nj7mZlSVObHrbW
 PuESLRH0Qss2RCdtLjqUNpYzOgOW4A2IuOWYdTUyhkeKdghJtoU/nqI54teKs8fcaWKr
 iKa+uaIoH65VLQ909zOdg40RmN/vCbahgk9q3P/G7lBVv9NZ4TjaUDNVePmZRDmbayg6
 x82zMBTtElT2jC/3Hh3UwCWjAEk69XhZRrs3mWTfewmFc9b/6nLez/71SbnbvQCwyFmK
 R/CNbCu/eYtwirh5ACBYRz9bnoEEI+v7xvGMazjRFYj5oR6ng+8AtA6UrdoneHid6NNR
 NArQ==
X-Gm-Message-State: AOJu0Ywn8EHKOwHzQw12EUEKvfHtGWCmmOM4S1NC5phfRRZ6OmOdCXPB
 VgTv1mMk4Wq3pF1u4KEDIIpfhNoPPq7zvc0wrLuCunYBLJgl70t74gnIjwXHL9kxdXvzIsDfxFF
 QuWcdVg==
X-Google-Smtp-Source: AGHT+IFkEk03Y8UOlP2C+T8AuWb2m1VemtHcfCveYPggx59yv30dCWVcECH4hJIuGH6K3gBShXRULg==
X-Received: by 2002:a05:6a21:1584:b0:1d9:61b:960c with SMTP id
 adf61e73a8af0-1dba5215963mr6004692637.9.1730480919069; 
 Fri, 01 Nov 2024 10:08:39 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc1ceea8sm2865818b3a.42.2024.11.01.10.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 10:08:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv: fix build error with clang
Date: Fri,  1 Nov 2024 10:08:33 -0700
Message-Id: <20241101170833.1074954-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

Introduced in 0c54ac, "hw/riscv: add RISC-V IOMMU base emulation"

../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'

  187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)

      |                 ^

D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: note: previous definition is here

  217 | _pext_u64(unsigned long long __X, unsigned long long __Y)

      | ^

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/riscv/riscv-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index feb650549ac..f738570bac2 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -184,7 +184,7 @@ static void riscv_iommu_pri(RISCVIOMMUState *s,
 }
 
 /* Portable implementation of pext_u64, bit-mask extraction. */
-static uint64_t _pext_u64(uint64_t val, uint64_t ext)
+static uint64_t pext_u64(uint64_t val, uint64_t ext)
 {
     uint64_t ret = 0;
     uint64_t rot = 1;
@@ -528,7 +528,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
     int cause;
 
     /* Interrupt File Number */
-    intn = _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
+    intn = pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
     if (intn >= 256) {
         /* Interrupt file number out of range */
         res = MEMTX_ACCESS_ERROR;
-- 
2.39.5


