Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47880D711BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 16:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDnTG-0005IH-P7; Wed, 20 Nov 2024 11:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xndchn@gmail.com>) id 1tDmQw-00081X-N1
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 10:16:01 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xndchn@gmail.com>) id 1tDmQu-0007GF-Qn
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 10:15:58 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-720c2db824eso2274926b3a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 07:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732115742; x=1732720542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7kyI8I/+qlyfXjZXDNWmYcBkLyqzttbAEYsCm+3pO6Q=;
 b=Nf++KeLh0dCqLvmu+Bf+9OfFAY4PIvRH9B+kzriOGCl078UViXkG0kTqb65WieRwds
 cqEYuZ+yQwh2447+37Goibk14WibCz+3YY3Mp9XePMQH6xEz5emwj2T3hKVjD18ewqTM
 UzdCJmAziwYUDSYLsiWNUMKeeKYO/U7DAzeXwUmUti5iXQY7Ugm+4+RZNl65SX15FjBo
 Jgs8X1icQ2h+2Mudr27ywkExTGMZseHn94p3ERrdaYdLfT6AasuL0wMarIQ88ySdRBVO
 f2Jghjrj5CKxCJJ3P7x1qOr++4FfjdM8OKIzrQZ5ipV6JgNcDchrDH23zQO95ZFWAD+k
 rEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732115742; x=1732720542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7kyI8I/+qlyfXjZXDNWmYcBkLyqzttbAEYsCm+3pO6Q=;
 b=loMkjhzoqlNgr5v/FVgqPM2C0y/wbD/ldVLzWZZoENnMPzXgaFpBizMM2juw8+ovNE
 nV3PNYv2+MR/Eet+1tYeV6AviuoIRCecvURuUEsgv5l1Ieqbrbr5IAcU2jvsD47tH6IK
 KMpeU5HYvH5rCpE8wceJMrOZmi5PeGJ3rA/uKXuk4hW6IqaLxnn2d7TFns2uRuAH7KIO
 fPfoyNPmljzw8Fe0krhfFxUdAnYgac2Rexl03xw6ioK9Eb9/d4H1IN5ao943n4Ks4Srn
 2/WKA4jPCDrd/wM9KzcxmMG+UJVBgu/LKcUTva2JDRDnVCBKAA7gjJSe2TbWwJ9FEJMk
 8+Gg==
X-Gm-Message-State: AOJu0YzxcE+ibppDwj1s6h4AAbQxrRmn7rcE3516nmKusg0zXfFAAKWC
 tQVjmDUML6PuHwTDWj41P9ACSb3/cyNVr3K+MATTnv7CvhCVzxIRQy5/vw==
X-Google-Smtp-Source: AGHT+IG8l9b//ATGV4rO4mm1KKL0iH95PmJ6izMcHyGwBRls+THMBDdd8MLG0ymW1IwyHRjQCAuh5Q==
X-Received: by 2002:a17:903:251:b0:20c:9d8d:1f65 with SMTP id
 d9443c01a7336-2126c11bf0fmr37684745ad.30.1732115742477; 
 Wed, 20 Nov 2024 07:15:42 -0800 (PST)
Received: from localhost.localdomain ([114.254.47.99])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-212583fccc5sm29352465ad.278.2024.11.20.07.15.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:15:42 -0800 (PST)
From: Xiong Nandi <xndchn@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] system/physmem: Fix cpu_memory_rw_debug for armv7m MPU
Date: Wed, 20 Nov 2024 23:15:14 +0800
Message-Id: <20241120151515.56884-1-xndchn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=xndchn@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 20 Nov 2024 11:22:25 -0500
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


The actual page size (region size for MPU) of armv7m may
smaller than TARGET_PAGE_SIZE (2^5 vs 2^10). So we should
use the actual virtual address to get the phys page address.

Since address_space_rw do not check the region protection, so
if we have some region like [0x0020 ~ 0x003F rw], [0x0040 ~ 0x007F --],
we will be able to read out the whole [0x0020 ~ 0x007F] region.
As a debug function, this seems acceptable.

I have make a minimal reproducible demo here:
https://gist.github.com/xndcn/3c534818b6486ecd2414d1cc7925c372

after building main.elf, run:
qemu-system-arm -machine stm32vldiscovery -kernel main.elf -s & 
gdb-multiarch main.elf
(gdb) target remote :1234
(gdb) disas main
Dump of assembler code for function main:
   0x08000040 <+0>:	Cannot access memory at address 0x8000040


