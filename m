Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF05606A322
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=QnwIiqFA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMg6y-0000TO-Kn; Fri, 30 Oct 2026 02:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xMg6s-0000Sy-Ob; Fri, 30 Oct 2026 02:29:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xMg6p-0008Tm-O7; Fri, 30 Oct 2026 02:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793341731; bh=41rW1JU1AalmldNknZz3tMlHY3fw5QoNbMOLn5DnNs8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QnwIiqFA8vk2GQ1Zak63pkNob3mMk9/gsy3IZL+zXC2+JJvkpKJ1+e1dj0xanLsxa
 M/C7drcRXIVbnGi5ekw+RyEdj/isq327yt0A80kKOa6awB+9aAO6sJOj8PAo564NG8
 as/KEgTk9LrCqN/N4E/j3sy+yARTkPMLF9mDdJIxqakd2/UIB3Eg7ALhHkH/D12xoe
 ZSvmMdHSIk7VAveMqTXGHYWgrxWDhjZ/gxlXl3vur8Zt/7fRP5shv7xn+bFfvgxjFQ
 995+xEFoooTXcMBCaVN/vUmGZNgEHF4phje7QievBUGkneggMszG8YWJDbRGrIQFYV
 8Ls2qvN3t/chA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0CE111E2739;
 Fri, 30 Oct 2026 09:28:51 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CC1F144EC54;
 Fri, 30 Oct 2026 09:28:50 +0300 (MSK)
Message-ID: <fe0694c6-383b-4cf2-abc0-c6d73a3d6c3c@tls.msk.ru>
Date: Fri, 30 Oct 2026 09:28:50 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 40/78] pcie_sriov: register user created virtual function
 before realizing it
To: Daniel Paziyski <danielpaziyski@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
References: <cover.1793207602.git.mst@redhat.com>
 <ca7c24b7c8f69c13fef24a31660e1b6ea73686d3.1793207602.git.mst@redhat.com>
 <CANukVxsB2n2GCGxQk3X2SUzNTJQ0M30ZxxmF=oGZtS-OCmbw_A@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CANukVxsB2n2GCGxQk3X2SUzNTJQ0M30ZxxmF=oGZtS-OCmbw_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 20:34, Daniel Paziyski wrote:
> Hello Michael,
> 
> I think you have queued this patch for pulling on accident. There is a bug here,
> which is yet to be solved, as you have pointed out in
> 
> https://lore.kernel.org/qemu-devel/20261028074508-mutt-send-email-mst@kernel.org/T/#mca344ac148a62107cdc298e97e6713b6657b5c55
> 
> Please, hold off this patch for a while, until I come up with a fix soon.
Am I right this buggy version of the patch has just landed in the master branch,
instead of the fixed v2 one?

Here's the difference between what's in current master and the v2:

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d4187293b1f..6242204a52c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2310,10 +2310,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
          pci_dev->cap_present |= QEMU_PCIE_CAP_CXL;
      }

-    pci_dev = do_pci_register_device(pci_dev,
-                                     object_get_typename(OBJECT(qdev)),
-                                     pci_dev->devfn, errp);
-    if (pci_dev == NULL) {
+    if (!do_pci_register_device(pci_dev, object_get_typename(OBJECT(qdev)),
+                                pci_dev->devfn, errp)) {
          pci_unregister_acpi_index(pci_dev);
          return;
      }
@@ -2332,6 +2330,11 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
          }
      }

+    if (!pcie_sriov_check_after_realize(pci_dev, errp)) {
+        pci_qdev_unrealize(DEVICE(pci_dev));
+        return;
+    }
+
      /*
       * A PCIe Downstream Port that do not have ARI Forwarding enabled must
       * associate only Device 0 with the device attached to the bus
~

Thanks,

/mjt

