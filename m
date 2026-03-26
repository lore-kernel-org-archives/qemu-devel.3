Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC58109E53E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5anh-0001oj-Oa; Wed, 25 Mar 2026 22:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1w5anc-0001oR-0O
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:50:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1w5anW-00022s-2U
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:50:19 -0400
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8Axy8LbnsRpQ8keAA--.22435S3;
 Thu, 26 Mar 2026 10:50:03 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJDxD8PWnsRp_pNdAA--.48149S3;
 Thu, 26 Mar 2026 10:49:59 +0800 (CST)
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Song Gao <gaosong@loongson.cn>, =?UTF-8?B?5q+b56Kn5rOi?=
 <maobibo@loongson.cn>, ltp@lists.linux.it, lixianglai@loongson.cn
From: lixianglai <lixianglai@loongson.cn>
Subject: Found that running runltp under the virtual machine caused the
 virtio-blk-pci device to hang!!!
Message-ID: <5fd27042-a6de-4d50-e7e4-c85a227654ed@loongson.cn>
Date: Thu, 26 Mar 2026 10:42:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------C75B4991726336244B71C0F5"
Content-Language: en-US
X-CM-TRANSID: qMiowJDxD8PWnsRp_pNdAA--.48149S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfuw1fZw4Dtry7tw1xur17urX_yoW8tFWrKo
 WUGr1UJr4rGryUGr1UJr17Jr15Jr1UtFnrJr1UJr17JF1UJr1Ut34UtryUJ3y7tF18GryU
 Jr1UJr1UXa4Utr1kl-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrnUUv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYz7kC6x804xWl
 14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwV
 WUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE
 14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aV
 AFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8I
 j28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAv7VC0I7IYx2IY67AKxVWUGVWUXw
 Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx8G
 jcxK6IxK0xIIj40E5I8CrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMx
 C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_JrI_JrWlx2IqxVCjr7xvwVAF
 wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
 vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
 0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
 WUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUFrWrDUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------C75B4991726336244B71C0F5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Everyone:

During the runltp test in the virtual machine, we found that the tpci 
test case had a
small probability of causing the virtio-blk-pci disk in the virtual 
machine to fail to
work properly, resulting in the virtual machine hanging.

The situation seen in the virtual machine is like this:

        /[root@localhost ~]# ps aux | grep " D"//
        //root         689  0.0  0.0      0     0 ?        D 09:42  
        0:00 [kworker/u256:2+flush-253:0]//
        //root        1327  0.0  0.0      0     0 ?        D 09:42  
        0:00 [jbd2/dm-0-8]//
        //root        8533  2.1  0.0 223664     0 pts/0    D+ 09:48  
        0:01 /usr/bin/cp -rvf kvm_install_desktop_6.6.52+
        kvm_install_desktop_6.6.52+-temp//
        //root        8686  0.0  0.0 222992     0 ttyS0    S+ 09:49  
        0:00 grep --color=auto  D//
        //[root@localhost ~]# cat /proc/689/stack //
        //[<0>] rq_qos_wait+0xd0/0x190//
        //[<0>] wbt_wait+0xac/0x168//
        //[<0>] __rq_qos_throttle+0x34/0x58//
        //[<0>] blk_mq_submit_bio+0x184/0x7b0//
        //[<0>] __submit_bio_noacct+0x70/0x288//
        //[<0>] submit_bio_noacct+0x1e8/0x798//
        //[<0>] __block_write_full_folio+0x348/0x608//
        //[<0>] writepage_cb+0x24/0x98//
        //[<0>] write_cache_pages+0x18c/0x450//
        //[<0>] do_writepages+0x120/0x290//
        //[<0>] __writeback_single_inode+0x4c/0x4c8//
        //[<0>] writeback_sb_inodes+0x28c/0x630//
        //[<0>] __writeback_inodes_wb+0x78/0x168//
        //[<0>] wb_writeback+0x308/0x400//
        //[<0>] wb_workfn+0x430/0x580//
        //[<0>] process_one_work+0x16c/0x418//
        //[<0>] worker_thread+0x280/0x498//
        //[<0>] kthread+0xec/0xf8//
        //[<0>] ret_from_kernel_thread+0x28/0xc8//
        //[<0>] ret_from_kernel_thread_asm+0xc/0x88/

        /[root@localhost ~]# lspci//
        //00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge//
        //00:01.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:01.1 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:01.2 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:01.3 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:01.4 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:01.5 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:01.6 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:01.7 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:02.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:02.1 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:02.2 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:02.3 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:02.4 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //00:02.5 PCI bridge: Red Hat, Inc. QEMU PCIe Root port//
        //01:00.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network
        device (rev 01)//
        //02:00.0 USB controller: Red Hat, Inc. QEMU XHCI Host
        Controller (rev 01)//
        //04:00.0 SCSI storage controller: Red Hat, Inc. Virtio 1.0
        block device (rev 01)//
        //05:00.0 Communication controller: Red Hat, Inc. Virtio 1.0
        console (rev 01)//
        //06:00.0 Unclassified device [00ff]: Red Hat, Inc. Virtio 1.0
        memory balloon (rev 01)//
        //07:00.0 Unclassified device [00ff]: Red Hat, Inc. Virtio 1.0
        RNG (rev 01)//
        //08:00.0 Display controller: Red Hat, Inc. Virtio 1.0 GPU (rev 01)/

There will be the following print in dmesg:

    /[  375.532574] LTP: starting tpci//
    //[  375.544269] ltp_tpci: Starting module//
    //[  375.544855] ltp_tpci: device registered//
    //
    //[  375.546348] ltp_tpci: found pci_dev '0000:04:00.0', bus 4,
    devfn 0//
    //[  375.547159] ltp_tpci: Bus number: 4//
    //[  375.547803] ltp_tpci: test-case 12//
    //[  375.548328] ltp_tpci: assign resources//
    //[  375.548793] ltp_tpci: assign resource #0//
    //[  375.549391] ltp_tpci: name = 0000:04:00.0, flags = 0, start
    0x0, end 0x0//
    //[  375.549993] ltp_tpci: assign resource #1//
    //[  375.550409] ltp_tpci: name = 0000:04:00.0, flags = 262656,
    start 0x40c00000, end 0x40c00fff//
    //[  375.551422] ltp_tpci: assign resource #2//
    //[  375.551936] ltp_tpci: name = 0000:04:00.0, flags = 0, start
    0x0, end 0x0//
    //[  375.552756] ltp_tpci: assign resource #3//
    //[  375.553124] ltp_tpci: name = 0000:04:00.0, flags = 0, start
    0x0, end 0x0//
    //[  375.553747] ltp_tpci: assign resource #4//
    //[  375.554104] ltp_tpci: name = 0000:04:00.0, flags = 1319436,
    start 0x40e00000, end 0x40e03fff//
    //[  375.554880] virtio-pci 0000:04:00.0: BAR 4: releasing [mem
    0x40e00000-0x40e03fff 64bit pref]//
    //[  375.555796] virtio-pci 0000:04:00.0: BAR 4: assigned [mem
    0x40e00000-0x40e03fff 64bit pref]//
    //[  375.583052] ltp_tpci: assign resource to '4', ret '0'//
    //[  375.585047] ltp_tpci: assign resource #5//
    //[  375.585407] ltp_tpci: name = (null), flags = 0, start 0x0, end
    0x0//
    //[  375.585941] ltp_tpci: assign resource #6//
    //[  375.586296] ltp_tpci: name = 0000:04:00.0, flags = 0, start
    0x0, end 0x0//
    //[  375.591294] ltp_tpci: device released//
    //
    //[  604.910783] INFO: task kworker/u256:2:689 blocked for more than
    120 seconds.//
    //[  604.911539]       Tainted: G           OE      6.6.52+ #16//
    //[  604.912013] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
    disables this message.//
    //[  604.912659] task:kworker/u256:2  state:D stack:0 pid:689  
    ppid:2      flags:0x00000800//
    //[  604.913353] Workqueue: writeback wb_workfn (flush-253:0)//
    //[  604.913834] Stack : 0000000006d64000 90000000025409a0
    9000000001585af8 0000000000000000//
    //[  604.914505]         0000000000000012 0000000000000000
    90000000016d2220 0000000000000000//
    //[  604.915221]         0000000000000002 e35c7a5dfd2412e2
    9000000122cb4b40 fffffffffffffffd//
    //[  604.916192]         0000000000000080 fffffffffffffffb
    9000000000bd0918 90000001071b7548//
    //[  604.916955]         9000000002341000 90000001071b75f8
    900000012961a080 900000010698f600//
    //[  604.917671]         90000000875db2c8 9000000001585af8
    0000000000000000 9000000001585bf0//
    //[  604.918369]         0000000000000002 9000000000ba9bfc
    9000000122cb4bb8 0000000000000001//
    //[  604.919290]         0000000000000000 9000000000ba93a0
    900000012961a088 900000012961a088//
    //[  604.920960]         900000010698f600 900000012961a080
    9000000000bd0c20 90000001071b75f8//
    //[  604.921992]         0000000000000000 e35c7a5dfd2412e2
    0000100000000001 0000000000000000//
    //[  604.922812]         ...//
    //[  604.923355] Call Trace://
    //[  604.923359] [<9000000001585430>] __schedule+0x318/0x988//
    //[  604.924802] [<9000000001585af4>] schedule+0x54/0xf0//
    //[  604.925606] [<9000000001585bec>] io_schedule+0x44/0x68//
    //[  604.926318] [<9000000000ba9bf8>] rq_qos_wait+0xd0/0x190//
    //[  604.927201] [<9000000000bd0ef4>] wbt_wait+0xac/0x168//
    //[  604.928033] [<9000000000ba963c>] __rq_qos_throttle+0x34/0x58//
    //[  604.928900] [<9000000000b97acc>] blk_mq_submit_bio+0x184/0x7b0//
    //[  604.929785] [<9000000000b82b18>] __submit_bio_noacct+0x70/0x288//
    //[  604.930675] [<9000000000b83398>] submit_bio_noacct+0x1e8/0x798//
    //[  604.931671] [<9000000000653a28>]
    __block_write_full_folio+0x348/0x608//
    //[  604.932769] [<90000000004da37c>] writepage_cb+0x24/0x98//
    //[  604.933611] [<90000000004dcfdc>] write_cache_pages+0x18c/0x450//
    //[  604.934368] [<90000000004de368>] do_writepages+0x120/0x290//
    //[  604.935132] [<900000000063dfe4>]
    __writeback_single_inode+0x4c/0x4c8//
    //[  604.936191] [<900000000063eb04>] writeback_sb_inodes+0x28c/0x630//
    //[  604.937090] [<900000000063ef20>] __writeback_inodes_wb+0x78/0x168//
    //[  604.937973] [<900000000063f478>] wb_writeback+0x308/0x400//
    //[  604.938829] [<9000000000640c18>] wb_workfn+0x430/0x580//
    //[  604.939550] [<9000000000295fb4>] process_one_work+0x16c/0x418//
    //[  604.940390] [<90000000002987a8>] worker_thread+0x280/0x498//
    //[  604.941016] [<90000000002a25b4>] kthread+0xec/0xf8//
    //[  604.941809] [<900000000157e660>] ret_from_kernel_thread+0x28/0xc8//
    //[  604.942720] [<9000000000222084>]
    ret_from_kernel_thread_asm+0xc/0x88//
    //
    //[  604.944135] INFO: task jbd2/dm-0-8:1327 blocked for more than
    120 seconds.//
    //[  604.944785]       Tainted: G           OE      6.6.52+ #16//
    //[  604.945634] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
    disables this message.//
    //[  604.946277] task:jbd2/dm-0-8     state:D stack:0 pid:1327 
    ppid:2      flags:0x00000800//
    //[  604.947254] Stack : 0000000006be4000 90000000025409a0
    9000000001585af8 0000000000000000//
    //[  604.948286]         90000000a6de88c0 0000000000000000
    90000000016d1c20 0000000000000000//
    //[  604.949210]         0000000000000002 e35c7a5dfd2412e2
    0000000000000400 90000000022d9b90//
    //[  604.950130]         0000000000000002 0000000000000001
    90000000022d9b00 9000000002341000//
    //[  604.951084]         0000000000000006 0000000000000090
    0000000000000001 9000000128355c80//
    //[  604.952103]         0000000000000002 9000000001585af8
    0000000000000000 9000000001585bf0//
    //[  604.953150]         ffffff0000b22ec0 90000000004cd71c
    900000011bb39a40 0000000000000001//
    //[  604.954180]         0000000000000005 0000000000000000
    900000012ad87998 90000000022d9b98//
    //[  604.955240]         0000100000000001 0000000000000000
    ffffff0000b22ec0 0000000000000001//
    //[  604.956145]         0000000000000000 9000000128355c80
    90000000004ca560 90000000022d9b98//
    //[  604.956948]         ...//
    //[  604.957460] Call Trace://
    //[  604.957462] [<9000000001585430>] __schedule+0x318/0x988//
    //[  604.958913] [<9000000001585af4>] schedule+0x54/0xf0//
    //[  604.959618] [<9000000001585bec>] io_schedule+0x44/0x68//
    //[  604.960424] [<90000000004cd718>]
    folio_wait_bit_common+0x1d8/0x460//
    //[  604.961336] [<90000000004da560>] folio_wait_writeback+0x48/0xd0//
    //[  604.962097] [<90000000004cba00>]
    __filemap_fdatawait_range+0xb0/0x170//
    //[  604.963284] [<90000000004cbad8>]
    filemap_fdatawait_range_keep_errors+0x18/0x68//
    //[  604.964243] [<90000000007822c8>]
    journal_finish_inode_data_buffers+0xa8/0x278//
    //[  604.965103] [<900000000078348c>]
    jbd2_journal_commit_transaction+0xfd4/0x1d68//
    //[  604.965953] [<9000000000790154>] kjournald2+0x10c/0x3e0//
    //[  604.966804] [<90000000002a25b4>] kthread+0xec/0xf8//
    //[  604.967489] [<900000000157e660>] ret_from_kernel_thread+0x28/0xc8//
    //[  604.968361] [<9000000000222084>]
    ret_from_kernel_thread_asm+0xc/0x88/

 From the above information, you can see that the state of the virtio 
blk device is no longer working properly,
After analysis, it is found that the following reasons may lead to it:
1.There is an item in the tpci test case of runltp that first releases 
pci device memory resources, and then reallocates pci memory 
resources,like this:

    /[  375.553747] ltp_tpci: assign resource #4/
    ///[  375.554104] ltp_tpci: name = 0000:04:00.0, flags = 1319436,
    start 0x40e00000, end 0x40e03fff/
    ///[  375.554880] virtio-pci 0000:04:00.0: BAR 4: releasing [mem
    0x40e00000-0x40e03fff 64bit pref]/
    ///[  375.555796] virtio-pci 0000:04:00.0: BAR 4: assigned [mem
    0x40e00000-0x40e03fff 64bit pref]/
    ///[  375.583052] ltp_tpci: assign resource to '4', ret '0'/

//2.The BAR 4 of Virtio PCI is the Virtio modern memory address space. 
It is the interaction address space between the Virtio driver and the 
Virtio device in the guest.
3.When the address space of bar 4 is released, if the guest is writing 
to the disk on another CPU, the vp_notify function needs to be used to 
interact with the virtio device.
  At this point, the interaction information may be lost, ultimately 
causing the virtio blk device to be blocked.

So here I have a question: Where exactly is the problem? Could it be 
that there was an issue with running the LTP test cases, or is there a 
defect in the virio driver of the virtual machine,
or is there a problem with the Virtio device simulation in QEMU?

I have tested on both x86 and loongarch virtual machines and found this 
problem in both.Here I explain again, this problem should not be related 
to cpu architecture and software version,
because I have tested the latest linux kernel and qemu in the upstream 
community.
Now, I will introduce the x86 environment:

        [root@anolis ~]# lscpu

        Architecture:                x86_64
           CPU op-mode(s):            32-bit, 64-bit
           Address sizes:             46 bits physical, 48 bits virtual
           Byte Order:                Little Endian
        CPU(s):                      20
           On-line CPU(s) list:       0-19
        Vendor ID:                   GenuineIntel
           BIOS Vendor ID:            Intel(R) Corporation
           Model name:                12th Gen Intel(R) Core(TM) i7-12700
             BIOS Model name:         12th Gen Intel(R) Core(TM)
        i7-12700   CPU @ 4.4GHz
             BIOS CPU family:         198
             CPU family:              6
             Model:                   151
             Thread(s) per core:      2
             Core(s) per socket:      12
             Socket(s):               1
             Stepping:                2
             CPU(s) scaling MHz:      18%
             CPU max MHz:             4900.0000
             CPU min MHz:             800.0000
             BogoMIPS:                4224.00
             Flags:                   fpu vme de pse tsc msr pae mce cx8
        apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr
        sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc
                                       art arch_perfmon pebs bts
        rep_good nopl xtopology nonstop_tsc cpuid aperfmperf
        tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl vmx smx est
        tm2 ssse3 sdbg fma
                                       cx16 xtpr pdcm pcid sse4_1 sse4_2
        x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
        lahf_lm abm 3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stib
                                      p ibrs_enhanced tpr_shadow
        flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep
        bmi2 erms invpcid rdseed adx smap clflushopt clwb intel_pt
        sha_ni xsav
                                      eopt xsavec xgetbv1 xsaves
        split_lock_detect avx_vnni dtherm ida arat pln pts hwp
        hwp_notify hwp_act_window hwp_epp hwp_pkg_req hfi vnmi umip pku
        ospke waitpkg g
                                      fni vaes vpclmulqdq tme rdpid
        movdiri movdir64b fsrm md_clear serialize pconfig arch_lbr ibt
        flush_l1d arch_capabilities
        Virtualization features:
           Virtualization:            VT-x
        Caches (sum of all):
           L1d:                       512 KiB (12 instances)
           L1i:                       512 KiB (12 instances)
           L2:                        12 MiB (9 instances)
           L3:                        25 MiB (1 instance)
        NUMA:
           NUMA node(s):              1
           NUMA node0 CPU(s):         0-19
        Vulnerabilities:
           Gather data sampling:      Not affected
           Indirect target selection: Not affected
           Itlb multihit:             Not affected
           L1tf:                      Not affected
           Mds:                       Not affected
           Meltdown:                  Not affected
           Mmio stale data:           Not affected
           Reg file data sampling:    Mitigation; Clear Register File
           Retbleed:                  Not affected
           Spec rstack overflow:      Not affected
           Spec store bypass:         Mitigation; Speculative Store
        Bypass disabled via prctl
           Spectre v1:                Mitigation; usercopy/swapgs
        barriers and __user pointer sanitization
           Spectre v2:                Mitigation; Enhanced / Automatic
        IBRS; IBPB conditional; PBRSB-eIBRS SW sequence; BHI BHI_DIS_S
           Srbds:                     Not affected
           Tsa:                       Not affected
           Tsx async abort:           Not affected
        [root@anolis ~]# cat /etc/os-release
        NAME="Anolis OS"
        VERSION="23.3"
        ID="anolis"
        VERSION_ID="23.3"
        PLATFORM_ID="platform:an23"
        PRETTY_NAME="Anolis OS 23.3"
        ANSI_COLOR="0;31"
        HOME_URL="https://openanolis.cn/"
        BUG_REPORT_URL="https://bugzilla.openanolis.cn/"

        [root@anolis ~]# uname -a
        Linux anolis 6.6.102-5.2.an23.x86_64 #1 SMP PREEMPT_DYNAMIC Thu
        Nov 27 22:47:00 CST 2025 x86_64 x86_64 x86_64 GNU/Linux

The virtual machine environment for x86 is as follows:

        [root@anolis ~]# lscpu
        Architecture:                x86_64
           CPU op-mode(s):            32-bit, 64-bit
           Address sizes:             46 bits physical, 48 bits virtual
           Byte Order:                Little Endian
        CPU(s):                      20
           On-line CPU(s) list:       0-19
        Vendor ID:                   GenuineIntel
           BIOS Vendor ID:            QEMU
           Model name:                12th Gen Intel(R) Core(TM) i7-12700
             BIOS Model name:         pc-i440fx-8.2  CPU @ 2.0GHz
             BIOS CPU family:         1
             CPU family:              6
             Model:                   151
             Thread(s) per core:      1
             Core(s) per socket:      1
             Socket(s):               20
             Stepping:                2
             BogoMIPS:                4224.00
             Flags:                   fpu vme de pse tsc msr pae mce cx8
        apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2
        ss syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtop
                                      ology cpuid tsc_known_freq pni
        pclmulqdq vmx ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe
        popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor
        lahf_l
                                      m abm 3dnowprefetch cpuid_fault
        ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept
        vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid r
                                      dseed adx smap clflushopt clwb
        sha_ni xsaveopt xsavec xgetbv1 xsaves avx_vnni arat vnmi umip
        pku ospke waitpkg gfni vaes vpclmulqdq rdpid movdiri movdir64b fsrm
                                      md_clear serialize flush_l1d
        arch_capabilities
        Virtualization features:
           Virtualization:            VT-x
           Hypervisor vendor:         KVM
           Virtualization type:       full
        Caches (sum of all):
           L1d:                       640 KiB (20 instances)
           L1i:                       640 KiB (20 instances)
           L2:                        80 MiB (20 instances)
           L3:                        320 MiB (20 instances)
        NUMA:
           NUMA node(s):              1
           NUMA node0 CPU(s):         0-19
        Vulnerabilities:
           Gather data sampling:      Not affected
           Indirect target selection: Not affected
           Itlb multihit:             Not affected
           L1tf:                      Not affected
           Mds:                       Not affected
           Meltdown:                  Not affected
           Mmio stale data:           Not affected
           Reg file data sampling:    Mitigation; Clear Register File
           Retbleed:                  Not affected
           Spec rstack overflow:      Not affected
           Spec store bypass:         Mitigation; Speculative Store
        Bypass disabled via prctl
           Spectre v1:                Mitigation; usercopy/swapgs
        barriers and __user pointer sanitization
           Spectre v2:                Mitigation; Enhanced / Automatic
        IBRS; IBPB conditional; PBRSB-eIBRS SW sequence; BHI BHI_DIS_S
           Srbds:                     Not affected
           Tsa:                       Not affected
           Tsx async abort:           Not affected
        [root@anolis ~]# cat /etc/os-release
        NAME="Anolis OS"
        VERSION="23.3"
        ID="anolis"
        VERSION_ID="23.3"
        PLATFORM_ID="platform:an23"
        PRETTY_NAME="Anolis OS 23.3"
        ANSI_COLOR="0;31"
        HOME_URL="https://openanolis.cn/"
        BUG_REPORT_URL="https://bugzilla.openanolis.cn/"
        [root@anolis ~]# uname -a
        Linux anolis 6.6.102-5.2.an23.x86_64 #1 SMP PREEMPT_DYNAMIC Thu
        Nov 27 22:47:00 CST 2025 x86_64 x86_64 x86_64 GNU/Linux


Finally, let me introduce the steps for reproducing the problem:
1.The virtual machine must have multiple vcpus. The issue of a single 
core does not exist.
2.In the virtual machine, the corresponding PCI number of virtio blk can 
be found through the "lspci" command.
3.Modify the tpci test case for runltp so that it only performs tpci 
tests on the virio blk device.
4.Run a file copying program in a virtual machine
5.Run the tpci test case on the virtio blk device
6.Test cases run after using the command/ps aux | grep "D"/ to see if 
there is a long time blocked and unable to restore process,
  if there is problem reappeared, no need to repeat steps 4 and 5 steps, 
until the problem is.


Thanks!
Xianglai.




--------------C75B4991726336244B71C0F5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <tt>Hello Everyone:<br>
      <br>
      During the runltp test in the virtual machine, we found that the
      tpci test case had a<br>
      small probability of causing the virtio-blk-pci disk in the
      virtual machine to fail to<br>
      work properly, resulting in the virtual machine hanging.<br>
      <br>
      The situation seen in the virtual machine is like this:<br>
    </tt>
    <blockquote>
      <blockquote><i><tt>[root@localhost ~]# ps aux | grep " D"</tt></i><i><br>
        </i><i><tt>root         689  0.0  0.0      0     0 ?        D   
            09:42   0:00 [kworker/u256:2+flush-253:0]</tt></i><i><br>
        </i><i><tt>root        1327  0.0  0.0      0     0 ?        D   
            09:42   0:00 [jbd2/dm-0-8]</tt></i><i><br>
        </i><i><tt>root        8533  2.1  0.0 223664     0 pts/0    D+  
            09:48   0:01 /usr/bin/cp -rvf kvm_install_desktop_6.6.52+
            kvm_install_desktop_6.6.52+-temp</tt></i><i><br>
        </i><i><tt>root        8686  0.0  0.0 222992     0 ttyS0    S+  
            09:49   0:00 grep --color=auto  D</tt></i><i><br>
        </i><i><tt>[root@localhost ~]# cat /proc/689/stack </tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] rq_qos_wait+0xd0/0x190</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] wbt_wait+0xac/0x168</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] __rq_qos_throttle+0x34/0x58</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] blk_mq_submit_bio+0x184/0x7b0</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] __submit_bio_noacct+0x70/0x288</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] submit_bio_noacct+0x1e8/0x798</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] __block_write_full_folio+0x348/0x608</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] writepage_cb+0x24/0x98</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] write_cache_pages+0x18c/0x450</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] do_writepages+0x120/0x290</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] __writeback_single_inode+0x4c/0x4c8</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] writeback_sb_inodes+0x28c/0x630</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] __writeback_inodes_wb+0x78/0x168</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] wb_writeback+0x308/0x400</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] wb_workfn+0x430/0x580</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] process_one_work+0x16c/0x418</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] worker_thread+0x280/0x498</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] kthread+0xec/0xf8</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] ret_from_kernel_thread+0x28/0xc8</tt></i><i><br>
        </i><i><tt>[&lt;0&gt;] ret_from_kernel_thread_asm+0xc/0x88</tt></i><br>
        <br>
        <i><tt>[root@localhost ~]# lspci</tt></i><i><br>
        </i><i><tt>00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host
            bridge</tt></i><i><br>
        </i><i><tt>00:01.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:01.1 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:01.2 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:01.3 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:01.4 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:01.5 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:01.6 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:01.7 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:02.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:02.1 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:02.2 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:02.3 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:02.4 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>00:02.5 PCI bridge: Red Hat, Inc. QEMU PCIe Root port</tt></i><i><br>
        </i><i><tt>01:00.0 Ethernet controller: Red Hat, Inc. Virtio 1.0
            network device (rev 01)</tt></i><i><br>
        </i><i><tt>02:00.0 USB controller: Red Hat, Inc. QEMU XHCI Host
            Controller (rev 01)</tt></i><i><br>
        </i><font color="#bb2222"><i><tt>04:00.0 SCSI storage
              controller: Red Hat, Inc. Virtio 1.0 block device (rev 01)</tt></i></font><i><br>
        </i><i><tt>05:00.0 Communication controller: Red Hat, Inc.
            Virtio 1.0 console (rev 01)</tt></i><i><br>
        </i><i><tt>06:00.0 Unclassified device [00ff]: Red Hat, Inc.
            Virtio 1.0 memory balloon (rev 01)</tt></i><i><br>
        </i><i><tt>07:00.0 Unclassified device [00ff]: Red Hat, Inc.
            Virtio 1.0 RNG (rev 01)</tt></i><i><br>
        </i><i><tt>08:00.0 Display controller: Red Hat, Inc. Virtio 1.0
            GPU (rev 01)</tt></i></blockquote>
    </blockquote>
    There will be the following print in dmesg:<br>
    <blockquote><i>[  375.532574] LTP: starting tpci</i><i><br>
      </i><i>[  375.544269] ltp_tpci: Starting module</i><i><br>
      </i><i>[  375.544855] ltp_tpci: device registered</i><i><br>
      </i><i><br>
      </i><i>[  375.546348] ltp_tpci: found pci_dev '0000:04:00.0', bus
        4, devfn 0</i><i><br>
      </i><i>[  375.547159] ltp_tpci: Bus number: 4</i><i><br>
      </i><i>[  375.547803] ltp_tpci: test-case 12</i><i><br>
      </i><i>[  375.548328] ltp_tpci: assign resources</i><i><br>
      </i><i>[  375.548793] ltp_tpci: assign resource #0</i><i><br>
      </i><i>[  375.549391] ltp_tpci: name = 0000:04:00.0, flags = 0,
        start 0x0, end 0x0</i><i><br>
      </i><i>[  375.549993] ltp_tpci: assign resource #1</i><i><br>
      </i><i>[  375.550409] ltp_tpci: name = 0000:04:00.0, flags =
        262656, start 0x40c00000, end 0x40c00fff</i><i><br>
      </i><i>[  375.551422] ltp_tpci: assign resource #2</i><i><br>
      </i><i>[  375.551936] ltp_tpci: name = 0000:04:00.0, flags = 0,
        start 0x0, end 0x0</i><i><br>
      </i><i>[  375.552756] ltp_tpci: assign resource #3</i><i><br>
      </i><i>[  375.553124] ltp_tpci: name = 0000:04:00.0, flags = 0,
        start 0x0, end 0x0</i><i><br>
      </i><i>[  375.553747] ltp_tpci: assign resource #4</i><i><br>
      </i><i>[  375.554104] ltp_tpci: name = 0000:04:00.0, flags =
        1319436, start 0x40e00000, end 0x40e03fff</i><i><br>
      </i><font color="#bb2222"><i>[  375.554880] virtio-pci
          0000:04:00.0: BAR 4: releasing [mem 0x40e00000-0x40e03fff
          64bit pref]</i><i><br>
        </i><i>[  375.555796] virtio-pci 0000:04:00.0: BAR 4: assigned
          [mem 0x40e00000-0x40e03fff 64bit pref]</i></font><i><br>
      </i><i>[  375.583052] ltp_tpci: assign resource to '4', ret '0'</i><i><br>
      </i><i>[  375.585047] ltp_tpci: assign resource #5</i><i><br>
      </i><i>[  375.585407] ltp_tpci: name = (null), flags = 0, start
        0x0, end 0x0</i><i><br>
      </i><i>[  375.585941] ltp_tpci: assign resource #6</i><i><br>
      </i><i>[  375.586296] ltp_tpci: name = 0000:04:00.0, flags = 0,
        start 0x0, end 0x0</i><i><br>
      </i><i>[  375.591294] ltp_tpci: device released</i><i><br>
      </i><i><br>
      </i><i>[  604.910783] INFO: task kworker/u256:2:689 blocked for
        more than 120 seconds.</i><i><br>
      </i><i>[  604.911539]       Tainted: G           OE      6.6.52+
        #16</i><i><br>
      </i><i>[  604.912013] "echo 0 &gt;
        /proc/sys/kernel/hung_task_timeout_secs" disables this message.</i><i><br>
      </i><i>[  604.912659] task:kworker/u256:2  state:D stack:0    
        pid:689   ppid:2      flags:0x00000800</i><i><br>
      </i><i>[  604.913353] Workqueue: writeback wb_workfn (flush-253:0)</i><i><br>
      </i><i>[  604.913834] Stack : 0000000006d64000 90000000025409a0
        9000000001585af8 0000000000000000</i><i><br>
      </i><i>[  604.914505]         0000000000000012 0000000000000000
        90000000016d2220 0000000000000000</i><i><br>
      </i><i>[  604.915221]         0000000000000002 e35c7a5dfd2412e2
        9000000122cb4b40 fffffffffffffffd</i><i><br>
      </i><i>[  604.916192]         0000000000000080 fffffffffffffffb
        9000000000bd0918 90000001071b7548</i><i><br>
      </i><i>[  604.916955]         9000000002341000 90000001071b75f8
        900000012961a080 900000010698f600</i><i><br>
      </i><i>[  604.917671]         90000000875db2c8 9000000001585af8
        0000000000000000 9000000001585bf0</i><i><br>
      </i><i>[  604.918369]         0000000000000002 9000000000ba9bfc
        9000000122cb4bb8 0000000000000001</i><i><br>
      </i><i>[  604.919290]         0000000000000000 9000000000ba93a0
        900000012961a088 900000012961a088</i><i><br>
      </i><i>[  604.920960]         900000010698f600 900000012961a080
        9000000000bd0c20 90000001071b75f8</i><i><br>
      </i><i>[  604.921992]         0000000000000000 e35c7a5dfd2412e2
        0000100000000001 0000000000000000</i><i><br>
      </i><i>[  604.922812]         ...</i><i><br>
      </i><i>[  604.923355] Call Trace:</i><i><br>
      </i><i>[  604.923359] [&lt;9000000001585430&gt;]
        __schedule+0x318/0x988</i><i><br>
      </i><i>[  604.924802] [&lt;9000000001585af4&gt;]
        schedule+0x54/0xf0</i><i><br>
      </i><i>[  604.925606] [&lt;9000000001585bec&gt;]
        io_schedule+0x44/0x68</i><i><br>
      </i><i>[  604.926318] [&lt;9000000000ba9bf8&gt;]
        rq_qos_wait+0xd0/0x190</i><i><br>
      </i><i>[  604.927201] [&lt;9000000000bd0ef4&gt;]
        wbt_wait+0xac/0x168</i><i><br>
      </i><i>[  604.928033] [&lt;9000000000ba963c&gt;]
        __rq_qos_throttle+0x34/0x58</i><i><br>
      </i><i>[  604.928900] [&lt;9000000000b97acc&gt;]
        blk_mq_submit_bio+0x184/0x7b0</i><i><br>
      </i><i>[  604.929785] [&lt;9000000000b82b18&gt;]
        __submit_bio_noacct+0x70/0x288</i><i><br>
      </i><i>[  604.930675] [&lt;9000000000b83398&gt;]
        submit_bio_noacct+0x1e8/0x798</i><i><br>
      </i><i>[  604.931671] [&lt;9000000000653a28&gt;]
        __block_write_full_folio+0x348/0x608</i><i><br>
      </i><i>[  604.932769] [&lt;90000000004da37c&gt;]
        writepage_cb+0x24/0x98</i><i><br>
      </i><i>[  604.933611] [&lt;90000000004dcfdc&gt;]
        write_cache_pages+0x18c/0x450</i><i><br>
      </i><i>[  604.934368] [&lt;90000000004de368&gt;]
        do_writepages+0x120/0x290</i><i><br>
      </i><i>[  604.935132] [&lt;900000000063dfe4&gt;]
        __writeback_single_inode+0x4c/0x4c8</i><i><br>
      </i><i>[  604.936191] [&lt;900000000063eb04&gt;]
        writeback_sb_inodes+0x28c/0x630</i><i><br>
      </i><i>[  604.937090] [&lt;900000000063ef20&gt;]
        __writeback_inodes_wb+0x78/0x168</i><i><br>
      </i><i>[  604.937973] [&lt;900000000063f478&gt;]
        wb_writeback+0x308/0x400</i><i><br>
      </i><i>[  604.938829] [&lt;9000000000640c18&gt;]
        wb_workfn+0x430/0x580</i><i><br>
      </i><i>[  604.939550] [&lt;9000000000295fb4&gt;]
        process_one_work+0x16c/0x418</i><i><br>
      </i><i>[  604.940390] [&lt;90000000002987a8&gt;]
        worker_thread+0x280/0x498</i><i><br>
      </i><i>[  604.941016] [&lt;90000000002a25b4&gt;] kthread+0xec/0xf8</i><i><br>
      </i><i>[  604.941809] [&lt;900000000157e660&gt;]
        ret_from_kernel_thread+0x28/0xc8</i><i><br>
      </i><i>[  604.942720] [&lt;9000000000222084&gt;]
        ret_from_kernel_thread_asm+0xc/0x88</i><i><br>
      </i><i><br>
      </i><i>[  604.944135] INFO: task jbd2/dm-0-8:1327 blocked for more
        than 120 seconds.</i><i><br>
      </i><i>[  604.944785]       Tainted: G           OE      6.6.52+
        #16</i><i><br>
      </i><i>[  604.945634] "echo 0 &gt;
        /proc/sys/kernel/hung_task_timeout_secs" disables this message.</i><i><br>
      </i><i>[  604.946277] task:jbd2/dm-0-8     state:D stack:0    
        pid:1327  ppid:2      flags:0x00000800</i><i><br>
      </i><i>[  604.947254] Stack : 0000000006be4000 90000000025409a0
        9000000001585af8 0000000000000000</i><i><br>
      </i><i>[  604.948286]         90000000a6de88c0 0000000000000000
        90000000016d1c20 0000000000000000</i><i><br>
      </i><i>[  604.949210]         0000000000000002 e35c7a5dfd2412e2
        0000000000000400 90000000022d9b90</i><i><br>
      </i><i>[  604.950130]         0000000000000002 0000000000000001
        90000000022d9b00 9000000002341000</i><i><br>
      </i><i>[  604.951084]         0000000000000006 0000000000000090
        0000000000000001 9000000128355c80</i><i><br>
      </i><i>[  604.952103]         0000000000000002 9000000001585af8
        0000000000000000 9000000001585bf0</i><i><br>
      </i><i>[  604.953150]         ffffff0000b22ec0 90000000004cd71c
        900000011bb39a40 0000000000000001</i><i><br>
      </i><i>[  604.954180]         0000000000000005 0000000000000000
        900000012ad87998 90000000022d9b98</i><i><br>
      </i><i>[  604.955240]         0000100000000001 0000000000000000
        ffffff0000b22ec0 0000000000000001</i><i><br>
      </i><i>[  604.956145]         0000000000000000 9000000128355c80
        90000000004ca560 90000000022d9b98</i><i><br>
      </i><i>[  604.956948]         ...</i><i><br>
      </i><i>[  604.957460] Call Trace:</i><i><br>
      </i><i>[  604.957462] [&lt;9000000001585430&gt;]
        __schedule+0x318/0x988</i><i><br>
      </i><i>[  604.958913] [&lt;9000000001585af4&gt;]
        schedule+0x54/0xf0</i><i><br>
      </i><i>[  604.959618] [&lt;9000000001585bec&gt;]
        io_schedule+0x44/0x68</i><i><br>
      </i><i>[  604.960424] [&lt;90000000004cd718&gt;]
        folio_wait_bit_common+0x1d8/0x460</i><i><br>
      </i><i>[  604.961336] [&lt;90000000004da560&gt;]
        folio_wait_writeback+0x48/0xd0</i><i><br>
      </i><i>[  604.962097] [&lt;90000000004cba00&gt;]
        __filemap_fdatawait_range+0xb0/0x170</i><i><br>
      </i><i>[  604.963284] [&lt;90000000004cbad8&gt;]
        filemap_fdatawait_range_keep_errors+0x18/0x68</i><i><br>
      </i><i>[  604.964243] [&lt;90000000007822c8&gt;]
        journal_finish_inode_data_buffers+0xa8/0x278</i><i><br>
      </i><i>[  604.965103] [&lt;900000000078348c&gt;]
        jbd2_journal_commit_transaction+0xfd4/0x1d68</i><i><br>
      </i><i>[  604.965953] [&lt;9000000000790154&gt;]
        kjournald2+0x10c/0x3e0</i><i><br>
      </i><i>[  604.966804] [&lt;90000000002a25b4&gt;] kthread+0xec/0xf8</i><i><br>
      </i><i>[  604.967489] [&lt;900000000157e660&gt;]
        ret_from_kernel_thread+0x28/0xc8</i><i><br>
      </i><i>[  604.968361] [&lt;9000000000222084&gt;]
        ret_from_kernel_thread_asm+0xc/0x88</i><br>
    </blockquote>
    From the above information, you can see that the state of the virtio
    blk device is no longer working properly,<br>
    After analysis, it is found that the following reasons may lead to
    it:<br>
    1.There is an item in the tpci test case of runltp that first
    releases pci device memory resources, and then reallocates pci
    memory resources,like this:<br>
    <blockquote><i>[  375.553747] ltp_tpci: assign resource #4</i><br>
      <i>
      </i><i>[  375.554104] ltp_tpci: name = 0000:04:00.0, flags =
        1319436, start 0x40e00000, end 0x40e03fff</i><br>
      <i>
      </i><i>[  375.554880] virtio-pci 0000:04:00.0: BAR 4: releasing
        [mem 0x40e00000-0x40e03fff 64bit pref]</i><br>
      <i>
      </i><i>[  375.555796] virtio-pci 0000:04:00.0: BAR 4: assigned
        [mem 0x40e00000-0x40e03fff 64bit pref]</i><br>
      <i>
      </i><i>[  375.583052] ltp_tpci: assign resource to '4', ret '0'</i><br>
    </blockquote>
    <i>
    </i>2.The BAR 4 of Virtio PCI is the Virtio modern memory address
    space. It is the interaction address space between the Virtio driver
    and the Virtio device in the guest.<br>
    3.When the address space of bar 4 is released, if the guest is
    writing to the disk on another CPU, the vp_notify function needs to
    be used to interact with the virtio device.<br>
     At this point, the interaction information may be lost, ultimately
    causing the virtio blk device to be blocked.<br>
    <br>
    So here I have a question: Where exactly is the problem? Could it be
    that there was an issue with running the LTP test cases, or is there
    a defect in the virio driver of the virtual machine, <br>
    or is there a problem with the Virtio device simulation in QEMU?<br>
    <br>
    I have tested on both x86 and loongarch virtual machines and found
    this problem in both.Here I explain again, this problem should not
    be related to cpu architecture and software version, <br>
    because I have tested the latest linux kernel and qemu in the
    upstream community.<br>
    Now, I will introduce the x86 environment:<br>
    <blockquote>
      <blockquote>[root@anolis ~]# lscpu<br>
      </blockquote>
    </blockquote>
    <blockquote>
      <blockquote>Architecture:                x86_64<br>
          CPU op-mode(s):            32-bit, 64-bit<br>
          Address sizes:             46 bits physical, 48 bits virtual<br>
          Byte Order:                Little Endian<br>
        CPU(s):                      20<br>
          On-line CPU(s) list:       0-19<br>
        Vendor ID:                   GenuineIntel<br>
          BIOS Vendor ID:            Intel(R) Corporation<br>
          Model name:                12th Gen Intel(R) Core(TM) i7-12700<br>
            BIOS Model name:         12th Gen Intel(R) Core(TM)
        i7-12700   CPU @ 4.4GHz<br>
            BIOS CPU family:         198<br>
            CPU family:              6<br>
            Model:                   151<br>
            Thread(s) per core:      2<br>
            Core(s) per socket:      12<br>
            Socket(s):               1<br>
            Stepping:                2<br>
            CPU(s) scaling MHz:      18%<br>
            CPU max MHz:             4900.0000<br>
            CPU min MHz:             800.0000<br>
            BogoMIPS:                4224.00<br>
            Flags:                   fpu vme de pse tsc msr pae mce cx8
        apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr
        sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc<br>
                                      art arch_perfmon pebs bts rep_good
        nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni
        pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma<br>
                                      cx16 xtpr pdcm pcid sse4_1 sse4_2
        x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
        lahf_lm abm 3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stib<br>
                                     p ibrs_enhanced tpr_shadow
        flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep
        bmi2 erms invpcid rdseed adx smap clflushopt clwb intel_pt
        sha_ni xsav<br>
                                     eopt xsavec xgetbv1 xsaves
        split_lock_detect avx_vnni dtherm ida arat pln pts hwp
        hwp_notify hwp_act_window hwp_epp hwp_pkg_req hfi vnmi umip pku
        ospke waitpkg g<br>
                                     fni vaes vpclmulqdq tme rdpid
        movdiri movdir64b fsrm md_clear serialize pconfig arch_lbr ibt
        flush_l1d arch_capabilities<br>
        Virtualization features:     <br>
          Virtualization:            VT-x<br>
        Caches (sum of all):         <br>
          L1d:                       512 KiB (12 instances)<br>
          L1i:                       512 KiB (12 instances)<br>
          L2:                        12 MiB (9 instances)<br>
          L3:                        25 MiB (1 instance)<br>
        NUMA:                        <br>
          NUMA node(s):              1<br>
          NUMA node0 CPU(s):         0-19<br>
        Vulnerabilities:             <br>
          Gather data sampling:      Not affected<br>
          Indirect target selection: Not affected<br>
          Itlb multihit:             Not affected<br>
          L1tf:                      Not affected<br>
          Mds:                       Not affected<br>
          Meltdown:                  Not affected<br>
          Mmio stale data:           Not affected<br>
          Reg file data sampling:    Mitigation; Clear Register File<br>
          Retbleed:                  Not affected<br>
          Spec rstack overflow:      Not affected<br>
          Spec store bypass:         Mitigation; Speculative Store
        Bypass disabled via prctl<br>
          Spectre v1:                Mitigation; usercopy/swapgs
        barriers and __user pointer sanitization<br>
          Spectre v2:                Mitigation; Enhanced / Automatic
        IBRS; IBPB conditional; PBRSB-eIBRS SW sequence; BHI BHI_DIS_S<br>
          Srbds:                     Not affected<br>
          Tsa:                       Not affected<br>
          Tsx async abort:           Not affected<br>
        [root@anolis ~]# cat /etc/os-release <br>
        NAME="Anolis OS"<br>
        VERSION="23.3"<br>
        ID="anolis"<br>
        VERSION_ID="23.3"<br>
        PLATFORM_ID="platform:an23"<br>
        PRETTY_NAME="Anolis OS 23.3"<br>
        ANSI_COLOR="0;31"<br>
        HOME_URL=<a class="moz-txt-link-rfc2396E" href="https://openanolis.cn/">"https://openanolis.cn/"</a><br>
        BUG_REPORT_URL=<a class="moz-txt-link-rfc2396E" href="https://bugzilla.openanolis.cn/">"https://bugzilla.openanolis.cn/"</a><br>
        <br>
        [root@anolis ~]# uname -a<br>
        Linux anolis 6.6.102-5.2.an23.x86_64 #1 SMP PREEMPT_DYNAMIC Thu
        Nov 27 22:47:00 CST 2025 x86_64 x86_64 x86_64 GNU/Linux<br>
      </blockquote>
    </blockquote>
    The virtual machine environment for x86 is as follows:<br>
    <blockquote>
      <blockquote>[root@anolis ~]# lscpu<br>
        Architecture:                x86_64<br>
          CPU op-mode(s):            32-bit, 64-bit<br>
          Address sizes:             46 bits physical, 48 bits virtual<br>
          Byte Order:                Little Endian<br>
        CPU(s):                      20<br>
          On-line CPU(s) list:       0-19<br>
        Vendor ID:                   GenuineIntel<br>
          BIOS Vendor ID:            QEMU<br>
          Model name:                12th Gen Intel(R) Core(TM) i7-12700<br>
            BIOS Model name:         pc-i440fx-8.2  CPU @ 2.0GHz<br>
            BIOS CPU family:         1<br>
            CPU family:              6<br>
            Model:                   151<br>
            Thread(s) per core:      1<br>
            Core(s) per socket:      1<br>
            Socket(s):               20<br>
            Stepping:                2<br>
            BogoMIPS:                4224.00<br>
            Flags:                   fpu vme de pse tsc msr pae mce cx8
        apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2
        ss syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtop<br>
                                     ology cpuid tsc_known_freq pni
        pclmulqdq vmx ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe
        popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor
        lahf_l<br>
                                     m abm 3dnowprefetch cpuid_fault
        ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept
        vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
        r<br>
                                     dseed adx smap clflushopt clwb
        sha_ni xsaveopt xsavec xgetbv1 xsaves avx_vnni arat vnmi umip
        pku ospke waitpkg gfni vaes vpclmulqdq rdpid movdiri movdir64b
        fsrm <br>
                                     md_clear serialize flush_l1d
        arch_capabilities<br>
        Virtualization features:     <br>
          Virtualization:            VT-x<br>
          Hypervisor vendor:         KVM<br>
          Virtualization type:       full<br>
        Caches (sum of all):         <br>
          L1d:                       640 KiB (20 instances)<br>
          L1i:                       640 KiB (20 instances)<br>
          L2:                        80 MiB (20 instances)<br>
          L3:                        320 MiB (20 instances)<br>
        NUMA:                        <br>
          NUMA node(s):              1<br>
          NUMA node0 CPU(s):         0-19<br>
        Vulnerabilities:             <br>
          Gather data sampling:      Not affected<br>
          Indirect target selection: Not affected<br>
          Itlb multihit:             Not affected<br>
          L1tf:                      Not affected<br>
          Mds:                       Not affected<br>
          Meltdown:                  Not affected<br>
          Mmio stale data:           Not affected<br>
          Reg file data sampling:    Mitigation; Clear Register File<br>
          Retbleed:                  Not affected<br>
          Spec rstack overflow:      Not affected<br>
          Spec store bypass:         Mitigation; Speculative Store
        Bypass disabled via prctl<br>
          Spectre v1:                Mitigation; usercopy/swapgs
        barriers and __user pointer sanitization<br>
          Spectre v2:                Mitigation; Enhanced / Automatic
        IBRS; IBPB conditional; PBRSB-eIBRS SW sequence; BHI BHI_DIS_S<br>
          Srbds:                     Not affected<br>
          Tsa:                       Not affected<br>
          Tsx async abort:           Not affected<br>
        [root@anolis ~]# cat /etc/os-release <br>
        NAME="Anolis OS"<br>
        VERSION="23.3"<br>
        ID="anolis"<br>
        VERSION_ID="23.3"<br>
        PLATFORM_ID="platform:an23"<br>
        PRETTY_NAME="Anolis OS 23.3"<br>
        ANSI_COLOR="0;31"<br>
        HOME_URL=<a class="moz-txt-link-rfc2396E" href="https://openanolis.cn/">"https://openanolis.cn/"</a><br>
        BUG_REPORT_URL=<a class="moz-txt-link-rfc2396E" href="https://bugzilla.openanolis.cn/">"https://bugzilla.openanolis.cn/"</a><br>
        [root@anolis ~]# uname -a<br>
        Linux anolis 6.6.102-5.2.an23.x86_64 #1 SMP PREEMPT_DYNAMIC Thu
        Nov 27 22:47:00 CST 2025 x86_64 x86_64 x86_64 GNU/Linux</blockquote>
      <br>
    </blockquote>
    <tt>Finally, let me introduce the steps for reproducing the problem:<br>
      1.The virtual machine must have multiple vcpus. The issue of a
      single core does not exist.<br>
      2.In the virtual machine, the corresponding PCI number of virtio
      blk can be found through the "lspci" command.<br>
      3.Modify the tpci test case for runltp so that it only performs
      tpci tests on the virio blk device.<br>
      4.Run a file copying program in a virtual machine<br>
      5.Run the tpci test case on the virtio blk device<br>
      6.Test cases run after using the command<i> ps aux | grep "D"</i>
      to see if there is a long time blocked and unable to restore
      process,<br>
       if there is problem reappeared, no need to repeat steps 4 and 5
      steps, until the problem is.<br>
      <br>
      <br>
      Thanks!<br>
      Xianglai.<br>
      <br>
      <br>
      <br>
    </tt>
  </body>
</html>

--------------C75B4991726336244B71C0F5--


