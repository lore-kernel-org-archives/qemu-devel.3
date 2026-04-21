Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A89F327BF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF60s-0005GS-8I; Tue, 21 Apr 2026 03:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF60q-0005Fm-TP
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:59:16 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF60p-0007vO-EF
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:59:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ad9a9be502so24647135ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 00:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776758353; x=1777363153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DqMH4Xv2/m4RHc+5iMKPfGbCupIP9EBYR06TzgMYx0k=;
 b=fmKj/8hpf7OgEWYCqToE8VckCc3iXjjnyv0cUBtZd17lens5gxx4o2KUZRvJQ3uWwz
 KUiY38k+/9kau4TSVmzwhBAVUOz5ug3nxdXvAHW2+bjjZwyM7VzY1HJKo1PYPiEyhIQV
 QgnC7NJ51tPkZhe555Yidf9Q84BGutzYYS+1qw6Af8pQPKbsX2h5LQZ0H7FT3QTf7jys
 NsLqEInYxUOyPrnRdyy91aOlZtpc0KXqF1+Iu295LlvY0cFKycY2A9gDpMkH9avybZIU
 i/HWayNiP/hUjwJcF6+m3uSKeiiZ7mu9o0H3Vclq+Z7HBzU3yVQD83kGqyuabXgcyKfa
 ys3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758353; x=1777363153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqMH4Xv2/m4RHc+5iMKPfGbCupIP9EBYR06TzgMYx0k=;
 b=KPnQBSkWRion+nHBw3taaCJPkV+fY5W3iMFW2Td6+7Bg4tNTDLujxnF9E+QKoAI2gJ
 9j/2CSgvrBpbWETndHaKFI35WM2aRK7Fs22jU9wD4qZbF4GGN/VVAFb1N3rBOnrPSd6G
 qCDSfBoocE1/2MtzIGV2rhbLLnOKySWxQzrLnGVFphsW9vGEGXYtBalf1hl3cfyov1HH
 wxQmH+4fyTufwMJ57nO0wngnosfwDgOimO9Hp9+ISsxgMKE4i6X0xUQV3ji65HwWo84p
 jSej+1Ql2kOALO72CTMwEWlx/4Zlh6yvsjm6YycqwIDSCqEwyZj8Oab3Sd6xxorWw6xb
 XF4A==
X-Gm-Message-State: AOJu0YwQjNw90Dr1q790ybDPoxfLO313M36gY0XyrTTIo1YwINaqJkp/
 SGvm5X8IUtXw2mr18UH9rWnBQRin9h8EM35N3co/W7Ma3Rbf2q6wmYAHtCvcvao5ULKP0amUhuG
 mavNBG8hco/fgfn1TqIKv8I9KHD15wvHL07v0CP0oeqp7MKRi7dndIv+X49XqDEEWeqimh+Jy7U
 wRrAYVeah7Kud2x8hg3wOc3hrEPu4bvohJVXU3C9vFzbBduWCB
X-Gm-Gg: AeBDiesG16nUKnC8MSv/D2WURwwrLxTUnmm5/l2YSV9l3koFXTgRnnfO+DlUCi1UaeT
 ybOIgWbSOuOJkQ7Ji8fUn9q+l7EXVTYtp9Cef7lbgbNyHQAApws5t5Kmh5Ym7vxlSdUsmJUBdp+
 EnmHC2EDzMFIziSGDcmc7Nukn5MpX+Mez5l7UrsfkpJfVLdWK2qrO/ags8yC2TGyL+01wa40lAm
 l1SaIhFaSwtIy3eVEvwMUj/TlKXUMtzATmk8ji7aF50W5VqFOKmyNGF7skSxvxOTS/lREAgWC0p
 qzXDwYhbCAOM6wj5DL2WdjH6bBRkrMxyBKZaVuGbvPXjeDx+lwOqBSPd5oWJVM9/DI04/U2EjHv
 PqHypQEw6TZvDmZU8aZQWvp4HwSqhCbykpDDQjC7zRiA/OrrleOnugjOxMewMCL0elCkdowhnC7
 SsWsVEOZYBUYDBVyw6lqnaeh5uVXwABwomDeyppXQOCDmUxYbrtAes31se1/W4
X-Received: by 2002:a17:903:2c0f:b0:2b4:678c:5f25 with SMTP id
 d9443c01a7336-2b5f9d671bcmr164739625ad.0.1776758352704; 
 Tue, 21 Apr 2026 00:59:12 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff729sm155605695ad.15.2026.04.21.00.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 00:59:12 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 0/2] Set MISA.[C|X] based on the selected extensions
Date: Tue, 21 Apr 2026 15:59:04 +0800
Message-ID: <20260421075906.2928317-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x631.google.com
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

From: Frank Chang <frank.chang@sifive.com>

MISA.C and MISA.X should be set when the following extensions are
selected:

MISA.C:
  * Zca and not F.
  * Zca, Zcf and F (but not D) is specified (RV32 only).
  * Zca, Zcf and Zcd if D is specified (RV32 only).
  * Zca, Zcd if D is specified (RV64 only)

MISA.X:
  * When there are any non-standard extensions enabled.

This patchset sets MISA.[C|X] bits based on the selected extensions.

Changelog:
  * v3: Rebase to the latest to-apply.next branch.
  * v2: Fix the missing parentheses bug.

Frank Chang (2):
  target/riscv: Update MISA.C for Zc* extensions
  target/riscv: Update MISA.X for non-standard extensions

 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 47 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

--
2.43.0


