Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B885F3ED6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 01:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBja0-0005Ts-8a; Sat, 11 Apr 2026 21:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBjZy-0005Oj-8X
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 21:25:38 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBjZw-0007OK-JR
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 21:25:38 -0400
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8a032383008so37885616d6.1
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 18:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775957135; x=1776561935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9DlI/ZrsuY1NbY1z1QalxQt4tL1QzIzqJUQli057T2o=;
 b=RQRlJCKXZhWHeOXBjAqFUFyDNecbby8IYq07J6B7YRNVlLFZ5P5GvixLDcwdI0Rttv
 n+WraY67OhMVMh3+CCUQ9A1RMVyAtZSIRpspSQf09dN1tZdaqJdX8t7ygOaI/tT1asUL
 5QIYhkpp4B2Tqeu0Xmr2z3wWFQk7/D6y9ZIibbnctnFp4dqWLN17RjaZJ3Lj4D1GvDBi
 8x/fwkuOyW0yXu/ab5oXTEDISDuZSs6SqgPLIbPpn9N8Jvq482/BHvnQARpVx2nwegml
 ngKmPzzeZAq53bhAJY0DI7hiGCdBouru7E3YmyLtTtxF2jAt6JY4QRE4Y9jxVmH5BEku
 EjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957135; x=1776561935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9DlI/ZrsuY1NbY1z1QalxQt4tL1QzIzqJUQli057T2o=;
 b=cu1t3kk8gWOT9cTWTCCHJPh0zXoS7PKokD2Kt8aXjG9KEMN401XaFNxPOvNVbk+sRi
 0QK6rZf8fxp/G3YheRWjEjYgv++oWxR0ViTORYstROZn2x4gFbVLpdFYy1I0pduBtOAu
 nhoNoNq82IPvjIyE9xN7Yb98g4kGQq46XgqboGgF4mc7fEv27JCV4/qS4Q+QVZBlKfuk
 CHhF7KVWbjcUrfkU7zzGV8WRdV4ckrYQv/SXbl3MfFndMJ2/swtGMLlX+hvOIDiEG1p/
 DiMInn9WOTc3ElGW5U7ZXVadoPkEXyWsgIZlirK2ZNEgbyqmTIetNL3XsLflHMbanlFc
 zVSg==
X-Gm-Message-State: AOJu0YwK1nn6OHsXQYc3AGNMxNBzchJMacvUx3sFrzz6ClB9FIn6/Rml
 0hSIECJMgxxA8xdVlAK6SKDDAPGDbexadK+wUrP8AHWSNqEEVV1nZtMb
X-Gm-Gg: AeBDieuEYUIiL6YM9852UeQ4ZKRweallI0s+SeffIwfqdtOlowglA9gYLEqXzhkBbcT
 xeobcek8UlDtnFQ8aJLDfwuXQdtIAy4+A29G12qKpw7O5S0M9LzpTNPBd5i7yXi08GnFSwYnhjN
 +Z62kyDK0XjFsWWttsZ+oPZbTgakt/tqZqEisrnza45SWVqhmPIP2ZwUVbQOsTx4Lc4aUOE7gnJ
 tsTDWtp0wawS+eiyFXSyUp2f0rMSJuEYs3/ZGms5ZX4+HC0N7VzJXMH0BAlUfH1ZCo9/hOFZ8ja
 UKmdb3C0t4kvKTVOd4jWupTz+N9Yv5UujAwLF7ZSlePDQwi/qhY0MlyOGAu8U+7U2DNPFuhEikc
 JzKt+mRQxHO3fzKKDPaViONwzy+MClT6+AUVrDQdQ2xF/9gqT1nmdt37y1Y3C/Im54uVNmackA/
 7O3LPT7GDXSCD3hPiMUeiBYr9cyJO06NsnpKDeK/cGFbcCE5+3hImK4VrNdd7RkbkUytXs
X-Received: by 2002:a05:6214:4011:b0:89c:c3f6:69e9 with SMTP id
 6a1803df08f44-8ac86156a48mr131391726d6.5.1775957135215; 
 Sat, 11 Apr 2026 18:25:35 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac8449e664sm59632706d6.0.2026.04.11.18.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:25:34 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, tangtao1634@phytium.com.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v1] tests/data/acpi: Update SPCR golden-ref for RISC-V virt
Date: Sun, 12 Apr 2026 09:25:01 +0800
Message-ID: <20260412012501.1808602-1-chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf41.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update the expected SPCR binary to match the corrected field
sequence after the Terminal Type and Language fields were swapped
back to their proper order.

This fixes the qtest-riscv64/bios-tables-test CI failure:
  https://gitlab.com/TaoTang/qemu/-/jobs/13879552268

Fixes: 977c6fefcd04 ("hw/acpi: correct field sequence in SPCR table")
Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 tests/data/acpi/riscv64/virt/SPCR | Bin 90 -> 90 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd0294c18bc6301e208a 100644
GIT binary patch
delta 10
Rcma!wnqbGo%rMbG3IGpM0&@TW

delta 10
Rcma!wnqbGoz&z1G3IGpJ0&@TW

-- 
2.53.0


