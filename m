Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11C2C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyeG-00049x-LR; Tue, 27 Feb 2024 09:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangkunkun@huawei.com>)
 id 1reyeD-00048z-Ft
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:41:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangkunkun@huawei.com>)
 id 1reye9-0001Oj-Kp
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:41:33 -0500
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tkg9264tQz1h0cF
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 22:39:02 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
 by mail.maildlp.com (Postfix) with ESMTPS id E64681A016B
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 22:41:16 +0800 (CST)
Received: from [10.174.185.210] (10.174.185.210) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 22:41:16 +0800
Subject: [Question] Can I start qemu-system-aarch64 with a vmlinux(ELF format)?
To: "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>, Zenghui Yu
 <yuzenghui@huawei.com>
Message-ID: <252c0f8d-08cd-2e7b-63b6-1bbf42ff32f8@huawei.com>
Date: Tue, 27 Feb 2024 22:41:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------7670B12933272A222E311338"
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=jiangkunkun@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Kunkun Jiang <jiangkunkun@huawei.com>
From:  Kunkun Jiang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--------------7670B12933272A222E311338
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi everybody,

I want to start qemu-system-aarch64 with a vmlinux,
which is an ELF format file. The arm_load_elf() is
implemented in arm_setup_direct_kernel_boot(). So I
thought it was supporting the ELF format file.
But there's no output.
Here is my command line:

> qemu-system-aarch64 -machine virt,gic-version=3 -enable-kvm -smp 4 -m 
> 1G -cpu host -kernel vmlinux -initrd fs -append "xxx"

Am I using it the wrong way?
Looking forward to your reply.

Thanks,
Kunkun Jiang


--------------7670B12933272A222E311338
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><font face="monospace">Hi everybody,<br>
        <br>
        I want to start qemu-system-aarch64 with a vmlinux,<br>
        which is an ELF format file. The arm_load_elf() is<br>
        implemented in arm_setup_direct_kernel_boot(). So I<br>
        thought it was supporting the ELF format file.  <br>
        But there's no output.<br>
        Here is my command line:<br>
      </font>
      <blockquote type="cite"><font face="monospace"><span style="color:
            rgb(59, 64, 69); font-size: 15px; font-style: normal;
            font-variant-ligatures: normal; font-variant-caps: normal;
            font-weight: 400; letter-spacing: normal; text-align: left;
            text-indent: 0px; text-transform: none; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; white-space: normal;
            background-color: rgb(255, 255, 255);
            text-decoration-thickness: initial; text-decoration-style:
            initial; text-decoration-color: initial; display: inline
            !important; float: none;">qemu-system-aarch64 -machine
            virt,gic-version=3 -enable-kvm -smp 4 -m 1G -cpu host
            -kernel vmlinux -initrd fs -append "xxx"<br>
          </span></font></blockquote>
      <font face="monospace"><br>
        Am I using it the wrong way?<br>
        Looking forward to your reply.<br>
        <br>
        Thanks,<br>
        Kunkun Jiang</font><br>
    </p>
  </body>
</html>

--------------7670B12933272A222E311338--

