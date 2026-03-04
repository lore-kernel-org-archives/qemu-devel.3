Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1802CEDEC08
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 04:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxdYt-0000ES-Li; Tue, 03 Mar 2026 23:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vxdYq-0000Bs-Vw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 23:10:13 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vxdYn-0003PY-5I
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 23:10:11 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so41498695ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 20:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772597405; x=1773202205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f14ZCU6c6AO7yoZkyMKUZu8STX3R3Hf8946PIlxv29s=;
 b=aCLZOsCN7YiZRKHrFsJYTyVdafzAzmk2P/ME8siG2KscmbRIHrY/mYjCtEHTu1TUpy
 JSAVatcxrCACitygUyRLeOIU1cJeiduQioU3V7niZncbGUVPDPCnA/tIC3sHXw+IKd27
 yuHb20F3+B15fvjnDjAHAN6xcDC3YYA2ZqySBITR7S1IFIv0D3DfsslR6igWei4D/rAG
 imaLpOocFxWdBHeVWVJL8CPymlursa43r4/7ctbvh7Ui0TuzVAL9aLFvM+l/k8AYFlfw
 XaXg5+vfvsjC1dYAyOrkVZyPo+a+cn14RqdLSHx2XU5AE1iLbwFPTX4dRhc3a0O881en
 sf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772597405; x=1773202205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f14ZCU6c6AO7yoZkyMKUZu8STX3R3Hf8946PIlxv29s=;
 b=Kpo9KcCt1C7ZiVb0WB+qypjqnxQr9YTeEYr4LsLJyQ2s3EXu5R5ZvJNAkeCa9x/Oxy
 7A+09JmG+AvJmB3FaDjFONg+/yi1AGa8GCTpq+jx9XXxRjXp59FbkJgSqNnTEKyDeUXo
 dkW6RSZ3iHRNcAYS22Wf4DsIpPTfUd1Oa7R4PTBCSyIuIIucPIWAoUErlHkeLrK1B/xW
 jKNi+x+WFbQQyQefUau2v0TTRh82NkSNuvJcJg35Jk97+Byt+vOPzctReF27RK6E7+H9
 IFb0V+f7+wQIzxGMBTjiLT2nhzJNf4Q0EkVx7OGznxt9h5N55j3MZvQ+iq0sBxQoJgM4
 00fg==
X-Gm-Message-State: AOJu0Yz0cC3uIU7EAZseQr9C1BUEoEhKJRQigv4SrjBpCxsey3QPUHSw
 Q0Wnyj3CHxELpOjyQqVGLlTc568j0va3z03srcVX9KhSiCvo/kbPg2JCRPbPFFdi9ENFkznx5YC
 iEO0z57xUo8dIdqNgxwvDsPcYmKMGh6ErgZnSxEVhFZn+VYtCVzud8AeaYfEbliTl1+18mZofjh
 xI6nAH8srKdKKDrYJA9Ago1W0KIpGoZs6s8aWd55JAZpQ=
X-Gm-Gg: ATEYQzxHRiRF1knJoDpP2gHkbNbwJfhG/S0ra8fAExX7eSz0LPr94FINTyCtfU0+SdD
 UIPI82SYeXc6J/fNTjQshid4NiBpbHx2GZHSuccFht5WXHEcTlY1IyCZU3Tevu4psWsVg0SUgZc
 LXhoyFWMecQ1RPoxopbJ0TqGUN1InzCYC9qh9vcJxslYyakx5W6N5AHD/Gd41Fo7L+sv0xmhZC+
 sBlTsN0hCFEF6roIL0s33ORkddIV/ybJUMyrxzUSXpCgUOQbtQOqmfD4ukEN5+4fIEECKBT71ap
 2JxKzlcLrHuTh/9wvYN5pnaHqbUYDP17/A5OVA5iBxgeVAToL386MYIMH5WVtmnoDo3gQkU02tQ
 KI+xlo89GF827li57rAAH/zwDAE/x5I/cvdN9FWH9pEPz8g9Pew62BseyXeXUM6hAhqOWGd35Bf
 a7IzuURg372GK1jb7uNdImOU9ojf2u9F8afzjF/tLQx8V3Z+/CwRGrGSXMGuCwxQ==
X-Received: by 2002:a17:903:3c23:b0:2ad:dd69:76a2 with SMTP id
 d9443c01a7336-2ae6aab32a9mr8443055ad.31.1772597404554; 
 Tue, 03 Mar 2026 20:10:04 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae54136b28sm71058815ad.73.2026.03.03.20.10.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Mar 2026 20:10:04 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH 0/2] hw/riscv/riscv-iommu: Bug fixes and IPSR.PMIP support
Date: Wed,  4 Mar 2026 12:09:57 +0800
Message-ID: <20260304040959.47267-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x62b.google.com
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

This series contains two fixes for the RISC-V IOMMU implementation:

1. Fix a bug in the HPM (Hardware Performance Monitor) timer setup where
   irq_overflow_left was not properly reset, causing stale values from
   previous timer setups to affect new timer behavior.

2. Add proper RW1C (Read/Write 1 to Clear) support for the IPSR.PMIP
   (Performance Monitor Interrupt Pending) bit, which was missing from
   the IPSR register implementation.

Jay Chang (2):
  hw/riscv/riscv-iommu-hpm: Fix irq_overflow_left residual value bug
  hw/riscv/riscv-iommu: Add IPSR.PMIP RW1C support

 hw/riscv/riscv-iommu-bits.h | 1 +
 hw/riscv/riscv-iommu-hpm.c  | 1 +
 hw/riscv/riscv-iommu.c      | 4 ++++
 3 files changed, 6 insertions(+)

-- 
2.48.1


