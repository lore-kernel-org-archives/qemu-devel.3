Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00772E9DE62
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 08:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAkbe-0006LU-7c; Thu, 09 Apr 2026 04:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wAiSe-0005lq-Bi
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 02:01:52 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wAiSc-0006pI-Lo
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 02:01:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso5267135e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 23:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1775714508; x=1776319308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BQIDX/WNV5Pzl0aC//tD4ssejDFf4jBgsYoG1vBrsEc=;
 b=XuqLuOoNIKtp3/yxPUHMcHk2xeBNzntD3Giza3ASjeeUZRVWxHobogqiHG9OiljI+W
 HD48iOks+JCINi1ly1yFmmA9znLsrRTz6gnAgt4k+jhE376iBtgKJe8y2zPn9x73S98L
 CFtevKlUdlKrKhMLjin8sSQiJ46R4FQmFhz/tBgSjgm6HzMbIjQILUo8XHUG2wP6alnV
 /NUJLyoRejGjh7ismiw1t/wCmhyOOc7K0R6zRxRkwLQs/TzGB4ZcWDjLXLZXG7t/iWQ8
 RiFIotC7IXqYu0q9u6H5b3DJ9Oe5pxBXQrpTfMVvosmC0wdljqoKBeOXKsQH7sTlb316
 hkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775714508; x=1776319308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQIDX/WNV5Pzl0aC//tD4ssejDFf4jBgsYoG1vBrsEc=;
 b=paQI95mXhoZwzIwxkLjocc8+G2T4PjOt5SPH3y6xRVY+61I5o4a4yow17FY6HegoeL
 N9aTmFkoJpSUonNiq1A9ElHvjzXDDE60gV8g2OyzqlQJu/n7tIF98lUnoKGEuMSrk1N8
 R24rBDlzjrlQD3j8/ErVy4NRalB5eil2FTrJ80cG5iHjJvddh0w/979xc45RntlyotrB
 63J3FBN8CpmSSrzs/A2Dsk/juf/0ooPAdNdq6zB82IA8j7e4ThoP6FLSGijRp3c0yRg4
 q8SAv21nHozlQ3OBaQKBa/OZTfb76EyNcXQb+8ygVK6QsSiL+DUTpLVvDTiHFC3WtGjz
 qvsg==
X-Gm-Message-State: AOJu0Yw8guG6YEcxZHwrN59cKrBaTnMHJH0qYqBMx8Mr1A76zuAnAzya
 7dTKkihZla9bemEWWm0V6nk2QV0JptkV/rXlxMd9lwpKyXx7zLHNY/seI1I12kVu5NGf0TifRdx
 k6QyNMRRNO7n/rd4Xj/5EF2mzSwsr6sleCUzULRCgJpuCDTI9uC/InFWg+Q5hxAxeIzNbhb8FLG
 qAOb4z6sDjZLONzEiFHmFhZ24N/oGleaqyvSNirqM=
X-Gm-Gg: AeBDieuTXm7E8ejVKWhHrTgcsLOY5nQi9oH75k7FBlhnzLxPJ7PNDUqs9rYkUpgIvVK
 m2XACMqxvyYVIk6XgiWml9KvzAPijOZUeLGpNpwVjbrd7rT4et/uvmO5LWTt4JjzHXEEvr8y98J
 J9QIKzLBBC1kcylw9LACO+IUWz1BmJ9GqEdqJA/hG0R8hya+X+et+kXcGqxH/8PmgTCvU+vomxl
 lAxrz6lZtH+arH/7RaCuKHKcHLyh7Vc5aVUDAqB5RM3S4BsXbEBDXjhhqe+BNyCzsWi5cEyj4YV
 AGAjFwaPd7oPRyizbOp7gWxMSoCKcEfEiaI0FDAuiybJt1adcwfAdxBSiKDMyzzN3dInP/EOb3Q
 4KXSQsgtYAVGC9EFdxo+4lO2UMFfROUIe+LgCfVC0a1Vba36YjVXBGpLOZjguK+6JKf2aQVaIe1
 X3xJX4p3N/BTrcsJ3ox0mZId0xzF6hOcaqcItpEUHnWRiopCnYSvsqQAGCbesObMnr4IcK+KpvV
 +zHxRmPhg2M4JM4XBtYm8WpqRh9dhReBpz+MEwGvGwXK8OnjXyupXKG2xGWFUL1uJdlw2U/
X-Received: by 2002:a05:600c:358b:b0:485:4135:5c92 with SMTP id
 5b1f17b1804b1-488995cb858mr393204295e9.0.1775714508006; 
 Wed, 08 Apr 2026 23:01:48 -0700 (PDT)
Received: from localhost (2a01cb00141148004df9ec80d3fa1cac.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:4df9:ec80:d3fa:1cac])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488cfa75ae2sm48909875e9.14.2026.04.08.23.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 23:01:47 -0700 (PDT)
From: mr-083 <matthieu@minio.io>
X-Google-Original-From: mr-083 <matthieu@min.io>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: its@irrelevant.dk, kbusch@kernel.org, stefanha@redhat.com,
 mr-083 <matthieu@min.io>
Subject: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Date: Thu,  9 Apr 2026 08:01:52 +0200
Message-ID: <20260409060155.94704-1-matthieu@min.io>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x330.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HK_NAME_MR_MRS=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 04:19:17 -0400
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

This series adds two features that together enable transparent NVMe disk
hot-swap simulation in QEMU, matching the behavior of physical NVMe
drives being pulled and reinserted in the same PCIe slot.

Problem:
Currently, hot-swapping an NVMe disk in QEMU requires removing the
entire NVMe controller via device_del, which causes the Linux guest to
assign a new controller number on re-add (e.g. nvme2 becomes nvme4).
This breaks storage software that tracks drives by device name.

Solution:
Patch 1 adds hotplug support for nvme-ns devices on the NvmeBus, with
proper Asynchronous Event Notification (AEN) so the guest kernel detects
namespace changes. This allows namespace-level hot-swap without removing
the NVMe controller.

Patch 2 adds a drive_insert HMP command that reconnects a host block
device file to an existing guest device after drive_del. This is the
counterpart to drive_del for non-removable devices where
blockdev-change-medium cannot be used.

The recommended hot-swap sequence is:
  1. drive_del <drive-id>          # disconnect backing store
  2. drive_insert <device> <file>  # reconnect backing store
  3. pcie_aer_inject_error <port> SDN  # trigger controller reset

After this sequence, the guest sees the same controller and namespace
names (e.g. /dev/nvme2n1 remains /dev/nvme2n1), and the NVMe driver
recovers transparently via the standard AER recovery path.

Tested with:
- Linux 6.1 guest on QEMU aarch64 with HVF (macOS)
- NVMe subsystem model with multipath disabled
- DirectPV and MinIO AIStor storage stack

mr-083 (2):
  hw/nvme: add namespace hotplug support
  block/monitor: add drive_insert HMP command

 block/monitor/block-hmp-cmds.c | 59 +++++++++++++++++++++++
 hmp-commands.hx                | 18 +++++++
 hw/nvme/ctrl.c                 | 85 ++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c                   |  1 +
 hw/nvme/subsys.c               |  2 +
 include/block/block-hmp-cmds.h |  1 +
 6 files changed, 166 insertions(+)

--
2.50.1 (Apple Git-155)

