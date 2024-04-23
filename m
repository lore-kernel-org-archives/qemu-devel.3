Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E46C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 17:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzJZC-0008Fh-4S; Tue, 23 Apr 2024 13:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rzJZA-0008Ez-1c
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 13:04:24 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rzJZ7-0006Zo-Q1
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 13:04:23 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f30f69a958so1717901b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713891860; x=1714496660; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=pHqxdX0YvtEsoi1Rs3ueWXjO84yq8D38zpVlIYbumb0=;
 b=PynSUrFWKPnDsLtkv1LygckJyHpS6boggoeNYb61UEwqkL9pkxC0ByaTcjAUEhcOmF
 ZL2Xw4P795Zyc7i15sMLc+rxYFOjl7johx0ecPdT890FDjOmubBGDxA2btfezuLyketK
 zoZn8XiEpi4DnZ1SA/b53Q1oKdok72kf0KQO4HVIDqu8FSWHvJND6C2Bxo+qUo/3nRaN
 6OhgRI0lnyOvP12oP1jlAv/z3I6uCjZpm/IPMEr3euzJIAfIWtq/k12bJTinYa91xQag
 Y8oyhfCUXI3pQePgXZupu7pUepXOLL1oA3OGgbGFVGh3l/bm9AgISJA0zKxttfVFsByU
 S+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713891860; x=1714496660;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pHqxdX0YvtEsoi1Rs3ueWXjO84yq8D38zpVlIYbumb0=;
 b=ID9+pVjYCOJIRXp3I9Il7sWp/z0LeGCVcJDudVZGbJvOfGJ8/Jdg6jvFqRTe+6Xz8k
 HJnll9YeB2fX9hQRQnO/6QjHM9D40sfX1R0Z3iwdibuBqEpJxpwSDGFC8p78U5jDNh8n
 D37Y9mNMJ/IDwYZNC9fjDzrR3EHMVIlz4v9YEvepAEHLUVQa9S8TbUJ/NSYkl/fKgvPI
 EM6GGmS+C6E5740ScbNA0VnK0HrD2nzEe2MyRjKOhJgohruwZDvssjBVk35jLEvZqnjW
 z0EfDeFrOVHTOZRWpg6smDF+L0Jf5AnsKE/QpRhONHClpmyZtyGYxm0oPOl6mDiQCrlw
 lgFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQPJT5JM6Euc3bqYoKFviBp+Mefgj+cH6hVBSNzkKNmK714UXAuXkCAlEXYS490DwX8yPGIgF8jelmOwzpNCOI8bVh+dk=
X-Gm-Message-State: AOJu0YwZgXPHr5BN3Gr4MadbCc3OJ6nIyJEf/uvVQOSlDu1cFG1LXn9K
 wv9VkSR7KqcXE/vF5CoD/ObjedNNmNtg3efihdJYeKIfoJXkanh5
X-Google-Smtp-Source: AGHT+IExxiXD8KBtKwDmcZcDlgu3XgxY9OqQUa+zINLjizKRF7HM9y9/a2QPmno1yBMllHz7U//GrA==
X-Received: by 2002:a05:6a21:78a5:b0:1a9:c436:c904 with SMTP id
 bf37-20020a056a2178a500b001a9c436c904mr15816486pzc.10.1713891859642; 
 Tue, 23 Apr 2024 10:04:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 kr3-20020a056a004b4300b006ed26aa0ae6sm9841652pfb.54.2024.04.23.10.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 10:04:18 -0700 (PDT)
Date: Tue, 23 Apr 2024 10:04:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Subject: Problems (timeouts) when testing usb-ohci with qemu
Message-ID: <4664cf39-5dfe-4557-959d-149640ca36e1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
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

Hi,

when testing usb-ohci with qemu's pci-ohci emulation, I keep getting
random usb interface timeouts. Sometimes the usb_hub_wq times out.

[    9.555666] Waiting for root device /dev/sda...
[   62.452625] INFO: task kworker/0:2:42 blocked for more than 30 seconds.
[   62.453036]       Tainted: G                 N 6.9.0-rc1-00305-geae7a41d2233 #1
[   62.453393] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   62.453778] task:kworker/0:2     state:D stack:0     pid:42    tgid:42    ppid:2      flags:0x00000000
[   62.454700] Workqueue: usb_hub_wq hub_event
[   62.455137] Call Trace:
[   62.455416] [<c0b47836>] __schedule+0x35c/0xe00
[   62.455708] [<c0b4830c>] schedule+0x32/0x178
[   62.455906] [<c07da782>] usb_kill_urb+0xa8/0xda
[   62.456220] [<c07db53c>] usb_start_wait_urb+0xca/0xe2
[   62.456441] [<c07db5ee>] usb_control_msg+0x9a/0x102
[   62.456648] [<c07d3970>] hub_port_init+0x5de/0xb40
[   62.456851] [<c07d67fe>] hub_event+0xb90/0x1364
[   62.457049] [<c002ead6>] process_one_work+0x200/0x564

Sometimes there is an i/o scheduling timeout such as

[    6.361811] Run /sbin/init as init process
[   93.167039] INFO: task kworker/u4:0:10 blocked for more than 30 seconds.
[   93.167715]       Tainted: G                 N 6.9.0-rc5-00036-gaece0dd54838 #4
[   93.168169] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   93.168607] task:kworker/u4:0    state:D stack:0     pid:10    tgid:10    ppid:2      flags:0x00000000
[   93.169602] Workqueue: scsi_tmf_0 scmd_eh_abort_handler
[   93.170278] Call Trace:
[   93.170584] [<c0b3a70e>] __schedule+0x358/0xd4e
[   93.170904] [<c0b3b136>] schedule+0x32/0x166
[   93.171161] [<c0b41d6c>] schedule_timeout+0xd8/0x10a
[   93.171420] [<c0b3ba0e>] __wait_for_common+0xce/0x1ce
[   93.171604] [<c0b3bb2a>] wait_for_completion+0x1c/0x24
[   93.171716] [<c0810a70>] command_abort_matching.part.0+0x38/0x52
[   93.171841] [<c0810ac0>] command_abort+0x36/0x70
[   93.171946] [<c06970a4>] scmd_eh_abort_handler+0xa6/0x192
...

This is not a new problem; I have seen it forever. Recently I spent some
time trying to understand the problem and found that the linux driver does
not always handle all ohci interupts. Since the interrupt is shared and
thus level triggered, that means that interrupts are still pending when
ohci_irq() exits. The interrupt core in Linux does not re-enter the
interrupt handler, presumably because it is marked as shared interrupt
and returns that the interrupt has been handled.

I found two possible fixes for the problem. One essentially mirrors the
code from ehci_irq(), the other adds a (bad) kludge into qemu. Both "fix"
or work around the problem.

Question is: What is actually wrong ? Something in the generic interrupt
handling code in Linux, something in the Linux usb-ohci driver, or
something in qemu ? Any idea how a proper fix might look like ?

Thanks,
Guenter

---
Linux hack:

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 4f9982ecfb58..48d523e71ea0 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -883,6 +883,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 	 * optimization of checking the LSB of hcca->done_head; it doesn't
 	 * work on all systems (edge triggering for OHCI can be a factor).
 	 */
+retry:
 	ints = ohci_readl(ohci, &regs->intrstatus);
 
 	/* Check for an all 1's result which is a typical consequence
@@ -982,6 +983,14 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 	}
 	spin_unlock(&ohci->lock);
 
+	ints = ohci_readl(ohci, &regs->intrstatus);
+	ints &= ohci_readl(ohci, &regs->intrenable);
+	if (ints) {
+		pr_err("######## Interrupts still pending 0x%x mask 0x%x\n", ints,
+		       ohci_readl(ohci, &regs->intrenable));
+		goto retry;
+	}
+
 	return IRQ_HANDLED;
 }

---
qemu hack:

 hw/usb/hcd-ohci.c | 11 +++++++++++
 hw/usb/hcd-ohci.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index fc8fc91a1d..99e52ad13a 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -267,6 +267,10 @@ static inline void ohci_intr_update(OHCIState *ohci)
         (ohci->intr_status & ohci->intr))
         level = 1;
 
+    if (level && ohci->level)
+        qemu_set_irq(ohci->irq, 0);
+
+    ohci->level = level;
     qemu_set_irq(ohci->irq, level);
 }
 
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
index e1827227ac..6f82e72bd9 100644
--- a/hw/usb/hcd-ohci.h
+++ b/hw/usb/hcd-ohci.h
@@ -52,6 +52,7 @@ struct OHCIState {
     uint32_t ctl, status;
     uint32_t intr_status;
     uint32_t intr;
+    int level;
 
     /* memory pointer partition */
     uint32_t hcca;
-- 
2.39.2


