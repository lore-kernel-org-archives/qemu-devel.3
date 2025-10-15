Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45341CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 10:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8yor-0007px-5b; Wed, 15 Oct 2025 06:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v8yon-0007pO-CH
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:33:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v8yoi-0001OG-Jf
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:33:17 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2680cf68265so50018985ad.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760524387; x=1761129187; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=4zbkmXFLSqPzJlU8mSU9LIH8QqbaVuBG6z2zddCuK0Q=;
 b=OW77pNUv3cl0AncAsZvTM2j+/xbIy0nDITe1qfXOKoeBltSjQwjN6C4xQ5wgIBXHYX
 MzZPtLUZc56YsNbBONDKtVNXcUcxCWtOcEp2lA+o/GQNncMFnDw20/qYGdafVqxqPMOp
 tzfgI0r+LWxVt6Qeyeq8xM/ZrhQrBX/rhnz2Bo93mEmUXomxAyjgzhw6Q2P8jJitviUF
 uIc7KmEsvWPhDA65MwnJ9dsRYDCPqURRe8L61ddSLg9B4YeoBt8y7aYak7XG7l6mqsgT
 buxuB3e7iIa5Qch89iWBz4/ddeh26R1K7xc3N/vCMH1Xnz82uwLe/sqT4UtBSxKew16m
 HH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760524387; x=1761129187;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4zbkmXFLSqPzJlU8mSU9LIH8QqbaVuBG6z2zddCuK0Q=;
 b=hToDx5V7I0LH1rLKT0ad0JGRsmEmKoV9sdFUixiB1ZIwf81bgkVsjrWrgtvhYuYrkV
 uRs8Icc9lvQxZC1aggu9g6VD/vv5q5r/IysmiiSjrTw34vJiaZ2h6Z9HDNfR/ViGov6e
 5Dqru27E3weJoptKef4EPLzCKyShVoG7yirZOQ1ge3H+7LQBjo9LEHPyjIea1ypaHV2r
 2C+t4FJCxnkqdSkYZM3rf7AqOxq1P5o75kRhQ/w7GjGpjqIkRWO0PuTLDCX4I0iw6EMx
 T+gumaGcqz3+PtzZAtXNgGyPMZE8tVjyRe4hDmEoyrhz2hQFVxF4pSwfUXJH/eb/rPmc
 4g7Q==
X-Gm-Message-State: AOJu0Yyh4IHbJXTjN1GUr6Q1xcLMwomnkk6QynBoCa/ZyywZzXfoMCwV
 oYBffRlpob34GLEfnQOlsJa039D5XJA4Gts8jx5JMx+G/lmHAWt1zsYsN/jx6w==
X-Gm-Gg: ASbGncvBXTKkzr/sn5Y5LQJWN6w5eHCZeGDzV+BUnaVommRMHwV1LG7AzU+rLlBBNir
 y/yz9GKGkfySQb3hpfwqBcwP11ct95Zm1r63Ql5PmwauPCHQlrqLzYGiFhU1iHvBldMjajVN3xw
 hcD5nnjmV3KHnbQabMVU8SeH3bzO5FCtmHfe2jH4UHmbjBlfcJAydkGug9oCB2ghsgxGFcu7AgP
 jk/xX3fNTtxtOlsyGsmc5tKSBo8oHSFGMUZexjt0Ig8UC4zjPmJRESe/rdjeN8a0ot+cKhjOt1m
 2Nf3h8eDY5h2CV3wLc/2BKUC22CeWrBakKA+L+kg4lixCOZ/4VZUXTklu0wwjGsUEj4vXczFcpm
 ro8uMY/wq16otScH82mC5MvT0xZTlNMIv2K8bZnhhmrSFJR8lBIebPKH1N2cpH0Am
X-Google-Smtp-Source: AGHT+IHRYCv8U6C2hkx5M/ty26b7Nklj8GIOYfdCJ326cm72SJAAp2QThEXdYF75f3pamf5NN4fQJw==
X-Received: by 2002:a17:903:2ecf:b0:263:3e96:8c1b with SMTP id
 d9443c01a7336-290272c259bmr331018845ad.33.1760524387113; 
 Wed, 15 Oct 2025 03:33:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034de6c07sm192859985ad.1.2025.10.15.03.33.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 03:33:06 -0700 (PDT)
Date: Wed, 15 Oct 2025 03:33:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Subject: Reverts needed to get qemu 10.1.1 and 10.0.5 working for me
Message-ID: <cf07f156-6d93-4631-8f8b-6bdaae488519@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi all,

I lost track what exactly I reported, so here is a summary of reverts and
patches I needed to get qemu 10.1.1 and 10.0.5 working for me.

Guenter

---
v10.1.1:

commit b1adefa3cf40df5b1e72c77eab80284831344aba
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Tue Oct 14 15:41:04 2025 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Tue Oct 14 15:44:23 2025 -0700

    Revert "scsi-disk: Advertise FUA support by default"
    
    This reverts commit 5562e214e82ae4bcb0b642cc52b304bdc78a58c3.
    
    Triggers
    
    [   30.688576] sd 0:2:0:0: [sda] tag#413 UNKNOWN(0x2003) Result: hostbyte=0x04 driverbyte=DRIVER_OK cmd_age=0s
    [   30.689126] sd 0:2:0:0: [sda] tag#413 CDB: opcode=0x2a 2a 08 00 00 00 02 00 00 02 00
    [   30.689431] I/O error, dev sda, sector 2 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 2
    [   30.689667] Buffer I/O error on dev sda, logical block 1, lost sync page write
    [   30.690052] EXT4-fs (sda): I/O error while writing superblock
    mount: mounting /dev/root on / failed: I/O error
    
    when trying to boot from megasas/megasas2 on riscv systems, and subsequently
    hangs in scsi code when trying to shut down.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 7a7e0ff6552fd5ca60d31d302fde492c7194208b
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Sun Oct 12 20:26:29 2025 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Oct 12 20:37:24 2025 -0700

    Revert "hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response"
    
    This reverts commit 4474802b0cd59fa14b603b953fa0bc8cc92783c0.
    
    The patch seems innocent but causes net-cdc connection failures.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 193a0b3f3cdbba3605e6c0be6bf81e5ebf54e5ba
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Sun Oct 12 11:31:40 2025 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Oct 12 11:31:40 2025 -0700

    Revert "target/sh4: Use MO_ALIGN for system UNALIGN()"
    
    This reverts commit eb978e50e42f3439e7a7a104e76aafc81bc4a028.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit a0698826d4a652257d315efc758c6f8f68d52ef1
Author:     Richard Henderson <richard.henderson@linaro.org>
AuthorDate: Sat Oct 4 12:24:14 2025 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Oct 12 11:23:02 2025 -0700

    accel/tcg: Hoist first page lookup above pointer_wrap
    
    For strict alignment targets we registered cpu_pointer_wrap_notreached,
    but generic code used it before recognizing the alignment exception.
    Hoist the first page lookup, so that the alignment exception happens first.
    
    Cc: qemu-stable@nongnu.org
    Buglink: https://bugs.debian.org/1112285
    Fixes: a4027ed7d4be ("target: Use cpu_pointer_wrap_notreached for strict align targets")
    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 84762d228175b9c24ec4a7a48420722ec3dfb978
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Sat Oct 4 12:41:40 2025 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Wed Oct 8 14:58:53 2025 -0700

    Revert "hw/riscv: Make FDT optional for MPFS"
    
    This reverts commit 0c2ca9e4d139acc762325d994614a42dba31be6a.
    
    Prevents kernel command line from being accepted.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 82421bc6a895d679a6c4a7c0c4570e2f4c644261
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Sat Oct 4 12:41:05 2025 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Wed Oct 8 14:58:53 2025 -0700

    Revert "hw/riscv: Allow direct start of kernel for MPFS"
    
    This reverts commit 6dd6f11710c713bd21ac67ab93f6db33169c6b4d.
    
    Prevents kernel command line from being accepted.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

---
v10.0.5:

commit 312b9248ace2e795a0f513a2aec26176a5036c70 (v10.0.5-local)
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Sun Oct 12 20:26:29 2025 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Oct 12 20:36:45 2025 -0700

    Revert "hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response"

    This reverts commit 4474802b0cd59fa14b603b953fa0bc8cc92783c0.

    The patch seems innocent but causes net-cdc connection failures.

    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

