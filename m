Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B08CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFtrT-0002Ul-KH; Mon, 03 Nov 2025 07:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vFtrJ-0002Sr-CU; Mon, 03 Nov 2025 07:40:29 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vFtr9-0000p7-HD; Mon, 03 Nov 2025 07:40:27 -0500
Received: from ZEVORN-PC (unknown [114.88.97.170])
 by APP-03 (Coremail) with SMTP id rQCowADHQemhoghphSM7AQ--.13961S2;
 Mon, 03 Nov 2025 20:40:02 +0800 (CST)
From: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
To: dbarboza@ventanamicro.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
Subject: [RFC v1 0/1] add virtio bus for rvsp-ref board
Date: Mon,  3 Nov 2025 20:39:54 +0800
Message-ID: <cover.1762172539.git.chao.liu.riscv@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADHQemhoghphSM7AQ--.13961S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWxtrykWFW8KFyrKF17KFg_yoW5Gw4rpF
 45GF15Gr1UXF17Xr13JryrJF15Zr18Gr1UGry3tr1UJr4UJr1UJr1UJr48CryUtr1UGr15
 Kr47Gry5ur4UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
 U==
X-Originating-IP: [114.88.97.170]
X-CM-SenderInfo: pfkd0hholxh2hlvf4qplvuuh5lvft2wodfhubq/1tbiDAYPAGkIkuwp6wAAsY
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=chao.liu.riscv@isrc.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi, Daniel.

This patch series adds an always present virtio bus for the rvsp-ref board.

You are free to use this patch, and if possible, please include it in the v4
version.

Based on this set of patches and the results of our previous discussions,
I can successfully boot OpenEuler RISC-V 25.09, which is an operating system
distribution that supports rvsp-ref spec 1.0.

like this:

```
[root@localhost ~]# fastfetch 
                 `.cc.`
             ``.cccccccc..`
          `.cccccccccccccccc.`
      ``.cccccccccccccccccccccc.``
   `..cccccccccccccccccccccccccccc..`
`.ccccccccccccccc/++/ccccccccccccccccc.`
.cccccccccccccccmNMMNdo+oso+ccccccccccc.
.cccccccccc/++odms+//+mMMMMm/:+syso/cccc
.cccccccccyNNMMMs:::/::+o+/:cdMMMMMmcccc    root@localhost
.ccccccc:+NmdyyhNNmNNNd:ccccc:oyyyo:cccc    --------------
.ccc:ohdmMs:cccc+mNMNmyccccccccccccccccc    OS: openEuler 25.09 riscv64
.cc/NMMMMMo////:c:///:cccccccccccccccccc    Host: riscv-rvsp-ref,qemu
.cc:syysyNMNNNMNyccccccccccccccccccccccc    Kernel: Linux 6.6.0.oe2509.riscv64
.cccccccc+MMMMMNyc:/+++/cccccccccccccccc    Uptime: 56 mins
.cccccccccohhhs/comMMMMNhccccccccccccccc    Packages: 306 (rpm)
.ccccccccccccccc:MMMMMMMM/cccccccccccccc    Shell: bash 5.2.37
.ccccccccccccccccsNNNNNd+cccccccccccccc.    Cursor: Adwaita
`..cccccccccccccccc/+/:cccccccccccccc..`    Terminal: vt220
   ``.cccccccccccccccccccccccccccc.``       CPU: rv64gcvh (8)
       `.cccccccccccccccccccccc.`           Memory: 277.14 MiB / 7.50 GiB
          ``.cccccccccccccc.``              Swap: Disabled
              `.cccccccc.`                  Disk (/): 1.32 GiB / 37.11 GiB
                 `....`                     Local IP (eth0): 10.0.2.15/24
                                            Locale: en_US.UTF-8
```

It should be added that booting OpenEuler still requires modifying the default
CPU type of the rvsp-ref board to TYPE_RISCV_CPU_MAX.

If using the RVSP_REF CPU type inherited from TYPE_RISCV_VENDOR_CPU, the kernel
cannot be booted;

If using the RVSP_REF CPU type inherited from TYPE_RISCV_BARE_CPU, EDKII cannot
be booted.

About the second problem, I've checked it a little bit first. I found the
issue is still because some extensions turned on in the profile are different.

Once I figure out which specific extensions are causing this problem,
I'll try to send a fix patch to the upstream.

Also, I want to ask:

Right now, EDKII is still compiled based on QEMU virt. Do we need to add a
configuration for rvsp-ref in EDKII? Even though our rvsp-ref is made from virt.


Thanks,
Chao

Chao Liu (1):
  hw/riscv/server_platform_ref.c: add virtio bus

 hw/riscv/server_platform_ref.c | 42 ++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

-- 
2.51.0


