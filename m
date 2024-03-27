Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A2DC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 07:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpNYZ-0004qw-9p; Wed, 27 Mar 2024 03:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1rpNYW-0004qn-KQ
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:18:40 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1rpNYU-0001Pn-1O
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:18:40 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXnMhAyANmmexMBw--.56847S2;
 Wed, 27 Mar 2024 15:18:24 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwAXpvU2yANmWkYAAA--.246S3;
 Wed, 27 Mar 2024 15:18:15 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: dan.j.williams@intel.com, jonathan.cameron@huawei.com, y-goto@fujitsu.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Date: Wed, 27 Mar 2024 15:18:12 +0800
Message-Id: <20240327071812.955794-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
References: <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAXpvU2yANmWkYAAA--.246S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQARAWYDI2QDSwABs6
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZr47uryDGryrAry5Gr1xZrb_yoWrGF1kpa
 y7Ja43KrykGw1UW3W0qa4kZa4rG3Z5AayUCF9rJw1xu3ZxJF17tF4rtayYqw1agFZ7Wr12
 v3ZYk3Z2g3WkXaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 22, 2023 at 05:11:39PM -0700, Dan Williams wrote:
> Yasunori Gotou (Fujitsu) wrote:
[...]

Hi, all

There was some confusions about CXL device hotplug when I recently
tried to use Qemu to emulate CXL device hotplug and verify the relevant
functions of kernel.

> > Q1) Can PCIe hotplug driver detect and call CXL driver?

[...]

> 
> Yes.
> 
> The cxl_pci driver (drivers/cxl/pci.c) is just a typical PCI driver as
> far as the PCI hotplug driver is concerned. So add/remove events of a
> CXL card get turned into probe()/remove() events on the driver.
> 

1. Can we divide steps of CXL device hotplug into two parts(PCI hotplug & Memory Hotplug)?

PCI Hotplug: the same as the native PCIe hotplug, including initializing cxl.io,
             assigning PCIe BARs, allocating interrupts, etc. And the cxl_pci driver
                         is responsible for this part.

Memory Hotplug: focusing on enabling CXL memory including discovering and Configuring HDM,
                extracting NUMA info from device, notifying memory management, etc.

> > 
> > Q2) Can QEMU/KVM emulate CXL device hotplug?
> > 
> >    I heard that QEMU/KVM has PCIe device hotplug emulation, but I'm not sure
> >    it can hotplug CXL device.
> 
> It can, but as far as the driver is concerned you can achieve the same
> by:
> 
> echo $devname > /sys/bus/pci/drivers/cxl_pci/unbind
> 
> ...that exercises the same software flows as physical unplug.
>

2. What is the difference between "echo $devname > /sys/bus/pci/drivers/cxl_pci/unbind" and
"(qemu) device_del cxl-mem0" ?

According to the test, I found that "(qemu) device_del cxl-mem0" would directly
unplug the device and cause the interrupts on the cxl root port. It seems like this
operation would not only trigger cxl_pci driver but also pcieport driver.

The kernel dmesg is like below:

(qemu) device_del cxl-mem0
# dmesg
[  699.057907] pcieport 0000:0c:00.0: pciehp: pending interrupts 0x0001 from Slot Status
[  699.058929] pcieport 0000:0c:00.0: pciehp: Slot(0): Button press: will power off in 5 sec
[  699.059986] pcieport 0000:0c:00.0: pciehp: pending interrupts 0x0010 from Slot Status
[  699.060099] pcieport 0000:0c:00.0: pciehp: pciehp_set_indicators: SLOTCTRL 90 write cmd 2c0

Then I also tried "echo $devname > /sys/bus/pci/drivers/cxl_pci/unbind"
to check the behaviour of kernel. The kernel dmesg is like below:

# echo 0000:0d:00.0 > /sys/bus/pci/drivers/cxl_pci/unbind
# dmesg
[70387.978931] cxl_pci 0000:0d:00.0: vgaarb: pci_notify
[70388.021476] cxl_mem mem0: disconnect mem0 from port1
[70388.033099] pci 0000:0d:00.0: vgaarb: pci_notify

It seems like this operation would just unbind the cxl_pci driver from the cxl device.

Is my understanding about these two method correct?

3) Can I just use "ndctl/test/cxl-topology.sh" to test the cxl hotplug functions of kernel?

   IIUC, cxl-topology.sh would utilize cxl_test (tools/testing/cxl) which is for regression
   testing the kernel-user ABI.

PS: My qemu command line:
qemu-system-x86_64 \
-M q35,nvdimm=on,cxl=on \
-m 4G \
-smp 4 \
-object memory-backend-ram,size=2G,id=mem0 \
-numa node,nodeid=0,cpus=0-1,memdev=mem0 \
-object memory-backend-ram,size=2G,id=mem1 \
-numa node,nodeid=1,cpus=2-3,memdev=mem1 \
-object memory-backend-ram,size=256M,id=cxl-mem0 \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
-device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
-device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem0 \
-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k \
-hda ../disk/ubuntu_x86_test_new.qcow2 \
-nographic \

Qemu version: 8.2.50, the lastest commit of branch cxl-2024-03-05 in "https://gitlab.com/jic23/qemu"
Kernel version: 6.8.0-rc6

Many thanks
Yuquan


