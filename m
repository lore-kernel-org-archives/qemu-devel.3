Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46D5D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RO-0006SW-Fz; Fri, 09 Jan 2026 01:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Qk-0005SH-0b
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:57:09 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Qi-0002xj-7Y
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:57:05 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c2dd0c24e5cso1858828a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941822; x=1768546622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Me4ZBOWrzdKvktUjsLww6TB3oR9WOe6FZHLcDEkUQo=;
 b=W/XlbNOxYGkeYcLPcLOQgVwD61xzqQvlNpCyyac/BR6QfVvHt37e0Xuucjt91zYshw
 5dV/0hC+8+IEMOQHABx3hdSpTlmN+VByp6y62seoV7Hl2+yWZQnEka1vD3sqeRhPE1pV
 65wyNvIoIDfwwQ/yzobVEUnZH87uGyx6D5JGUy/JacVMX2zEDfO/5+b5iwUxFDeF1/Dv
 2W1KW0Dx0qZlZtRGZBoSbXl1HLPNEs6GOvqfoNDe/mIDrXHvm14Cy6UBWkdFy6jANuxx
 VC9l73MfOB+oHc69xCJDtlTvbhXWEaHviegG1T6I7u3eHixwDc7OLr4OpmLGvEONbg31
 wxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941822; x=1768546622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Me4ZBOWrzdKvktUjsLww6TB3oR9WOe6FZHLcDEkUQo=;
 b=cbD7y17GASwSioxU4xeH+9af8KUfH+Pre+fSDliRYbEPH5lJBMD/LMrs2O4bMIT5t+
 RjW5zxgGGZMSAKdS6NEtliUk6EOqRK0Y1H65Z+3LLvBKUCR6uIG2GY8y1Tfk3voColUN
 dcSUIQwGP8Vwok7AunK6zHtnytw/05tPtElVDkwNY06rNsUpjIOZCKsd+MG/Qyewp6lM
 qqkn8AYYqL+1xOTXH0EM5gZ1Wv5K7/IavNiBxnz9N3AwQcX5jAu+OcsMX2jphx3aVwwf
 nLzvzqHt520NRmupYd2TjVqP73FKBNlJNxryEGgrKXeDztKG0XXh0VjZlDxTaLv5RpOh
 jwhQ==
X-Gm-Message-State: AOJu0Yx4sj3cgug49rn2itmSy+FxV7TOfGM8aPvHJswUZAvAlr+hl939
 KLzkxN+ZeugKM34qFuih5hSnnquwPRBKADaKbA1QL9bDZaClqc2HmUdX8L3hdQ==
X-Gm-Gg: AY/fxX4LZb2sgUihRuBBvyFi7piFS+cHtWpqInYdKy3aMizLq2LpDTz4gF6IBL1E304
 CS7f161zHbtFmS/atrzSv/HMFjWD4IFGnPWVLVpQ3mDd+BBxYpOWV/jUHzcCEYxhA5ZMtGG9EnC
 qfImXHNgq5NH1VF7BBICxt0cDQYxePKeLZTMuIyUGrMX5gmJNG1nPbNxQJYYWb1vffxORkyYIVR
 2OE0ZX0cDteVnIQki2oxl9KYPSeoT+7FOim1u/rMxkgZp+FfvRD8ubve1OLnXcshtoQdGpCpvsY
 GhjUqQGeVb9vF7EHdN7dZrjvI59YfkHi0hFgDEWvnmEuJmg3/cFr1S339yoYa2bGPV7tUbcH5wj
 f0EAMxOSR/n2PaYSDh3ZNVNILtE/sLhXqTGhJtABtiF0v3GFTnwS9RBo/zTTwgvw7vzvGkjzHtx
 OsgauyhNzCX0Y8JPBloFzLLNoxwJr8Lb2fMyLjBdxQK88MHgPNmlgP0LGPdxzVhr+oyCeUgzCCH
 WMC5VJFyCj9mLUFLX6gS3g05rt4jQ==
X-Google-Smtp-Source: AGHT+IFMphDaa+YYVImX5ctu0dDOAY96rfa/7okRS9Z/94hQotSxFfrI81s5xiaoFCumesknUaCGWQ==
X-Received: by 2002:a05:6a21:6d8c:b0:35f:6e12:1862 with SMTP id
 adf61e73a8af0-3898f94c400mr8279484637.19.1767941822548; 
 Thu, 08 Jan 2026 22:57:02 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:57:01 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/34] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Date: Fri,  9 Jan 2026 16:54:58 +1000
Message-ID: <20260109065459.19987-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
device emulation, so use an `e1000e` instead.  We place it in
**slot 0, function 1** in order not to conflict with the existing
AHCI device in slot 0 func 0.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20260108134128.2218102-12-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 1d9fa868c8..b90da096ea 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -424,6 +424,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(&ich9->ahci, hd);
 
+    /* Create e1000e using slot 0 func 1 */
+    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NULL,
+                         "00.1");
+    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
+
     if (machine->firmware) {
         fw_size = load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB, NULL);
-- 
2.52.0


