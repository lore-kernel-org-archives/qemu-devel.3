Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7186E67496
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 03:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXWvu-0000UV-HF; Sun, 21 Dec 2025 22:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vXWvo-0000Tl-62; Sun, 21 Dec 2025 22:50:00 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vXWvl-0004gy-2Y; Sun, 21 Dec 2025 22:49:59 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAX+CTZv0hp7ZfuAQ--.59544S2;
 Mon, 22 Dec 2025 11:49:45 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwB30O3Nv0hpQr4NAA--.25887S2;
 Mon, 22 Dec 2025 11:49:40 +0800 (CST)
Message-ID: <8a97dd61-bbb5-4992-a486-5f89d7403d77@phytium.com.cn>
Date: Mon, 22 Dec 2025 11:49:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: 13824125580@163.com
Subject: Is there any manuals or page to show how to setup a nest translation
 environment with stage1 and stage2 page tables on intel-iommu ?
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB30O3Nv0hpQr4NAA--.25887S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQALBWlHAyMBKQABso
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxuryDCry7Xr1UAF45WF4kZwb_yoW5uF13pF
 ZIkFyagrWDJr48W34kZw1UZw1IqrWkJ343Cr1DGrs8GFs09a42yFWSkryYya4SvFZ3AF10
 va90qryDW345A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi zlcao,

> Hi guys:
>     I want to learn about how Intel IOMMU second-level translation 
> works. Does anyone have any materials or pages on this topic, such as 
> WIP repositories, operational guides, etc.? Thanks!
> BRs
> zlcao.


 From my experience, the best approach to learn this is to setup a 
nested virtualization environment, find the senario that can trigger 
second-level translation, and then trace all Intel IOMMU events or use 
gdb to trace line by line in hw/i386/intel_iommu.c. Also you may need to 
get Intel IOMMU spec and find the related chapter which describes 
second-level translation.


I worked in SMMU these days and had the same problem with you and found 
that setup a nested virtualization environment then passthrough a PCIe 
device from TCG Host VM into KVM Guest VM could be a good way to debug 
IOMMU implementation. This link [1] show how it works in Arm SMMU.

[1] 
https://lore.kernel.org/qemu-devel/20250806151134.365755-1-tangtao1634@phytium.com.cn/


......

Non-Secure Regression: To ensure that existing functionality remains
intact, I ran a nested virtualization test. A TCG guest was created on
the host, with iommu=smmuv3 and with an emulated PCIe NVMe device assigned.
Command line of TCG VM is below:

qemu-system-aarch64 \
-machine virt,virtualization=on,gic-version=3,iommu=smmuv3 \
-cpu max -smp 1 -m 4080M \
-accel tcg,thread=single,tb-size=512 \
-kernel Image \
-append 'nokaslr root=/dev/vda rw rootfstype=ext4 iommu.passthrough=on' \
-device pcie-root-port,bus=pcie.0,id=rp0,addr=0x4.0,chassis=1,port=0x10 \
-device pcie-root-port,bus=pcie.0,id=rp1,addr=0x5.0,chassis=2,port=0x11 \
-drive if=none,file=u2204fs.img.qcow2,format=qcow2,id=hd0 \
-device virtio-blk-device,drive=hd0 \
-qmp unix:/tmp/qmp-sock12,server=on,wait=off \
-netdev user,id=eth0,hostfwd=tcp::10022-:22,hostfwd=tcp::59922-:5922 \
-device virtio-net-device,netdev=eth0 \
-drive if=none,file=nvme.img,format=raw,id=nvme0 \
-device nvme,drive=nvme0,serial=deadbeef \
-d unimp,guest_errors -trace events=smmu-events.txt -D qemu.log -nographic

Inside this TCG VM, a KVM guest was launched, and the same NVMe device was
re-assigned to it via VFIO.
Command line of KVM VM inside TCG VM is below:

sudo qemu-system-aarch64  \
-enable-kvm  -m 1024  -cpu host  -M virt \
-machine virt,gic-version=3 \
-cpu max -append "nokaslr" -smp 1 \
-monitor stdio \
-kernel 5.15.Image \
-initrd rootfs.cpio.gz \
-display vnc=:22,id=primary \
-device vfio-pci,host=00:01.0

The KVM guest was able to perform I/O on the device
correctly, confirming that the non-secure path is not broken.

......



I'm not familiar with Intel IOMMU so I'm not enable to help with the 
right options that apply PCIe passthroughing on Intel IOMMU.


BTW, I have submitted a patch series introducing iommu-testdev [2] , 
which allows testing IOMMU functionality purely with QTest, without 
setting up a complex software stack. Once you have a clear understanding 
of the second-level translation, you are very welcome to share your 
findings and help improve the Intel IOMMU implementation in iommu-testdev.


[2] 
https://lore.kernel.org/qemu-devel/20251206155203.3015881-1-tangtao1634@phytium.com.cn/


Regards,

Tao


