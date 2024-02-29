Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D27C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 03:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfWgl-0002X9-EF; Wed, 28 Feb 2024 22:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangkunkun@huawei.com>)
 id 1rfWgk-0002Wv-Bj
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:02:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangkunkun@huawei.com>)
 id 1rfWgW-0007WU-9w
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:02:26 -0500
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Tlbb26dhyzqjhB;
 Thu, 29 Feb 2024 11:01:18 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
 by mail.maildlp.com (Postfix) with ESMTPS id 666D618002D;
 Thu, 29 Feb 2024 11:01:56 +0800 (CST)
Received: from [10.174.185.210] (10.174.185.210) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 11:01:55 +0800
Subject: Re: [Question] Can I start qemu-system-aarch64 with a vmlinux(ELF
 format)?
To: Peter Maydell <peter.maydell@linaro.org>
CC: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>, Zenghui Yu
 <yuzenghui@huawei.com>
References: <252c0f8d-08cd-2e7b-63b6-1bbf42ff32f8@huawei.com>
 <CAFEAcA81xV6wvBFoaGNpH9=0oAjP=toMBS=MNV_poXm5RPK-iQ@mail.gmail.com>
Message-ID: <c91c1f3d-9ff1-a582-bf03-ecf182c78b1b@huawei.com>
Date: Thu, 29 Feb 2024 11:01:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81xV6wvBFoaGNpH9=0oAjP=toMBS=MNV_poXm5RPK-iQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=jiangkunkun@huawei.com; helo=szxga06-in.huawei.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.14,
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

Hi Peter,

On 2024/2/27 23:28, Peter Maydell wrote:
> On Tue, 27 Feb 2024 at 14:42, Kunkun Jiang via <qemu-devel@nongnu.org> wrote:
>> Hi everybody,
>>
>> I want to start qemu-system-aarch64 with a vmlinux,
>> which is an ELF format file. The arm_load_elf() is
>> implemented in arm_setup_direct_kernel_boot(). So I
>> thought it was supporting the ELF format file.
> No, you can't do this. The hw/arm/boot.c code assumes
> that ELF files are "bare metal" binaries, whereas
> uImage format, AArch64 Image format, and raw binary files
> are Linux kernels. Only the last three kinds of files will
> be started with the boot protocol the Linux kernel expects.
>
> For AArch64, pass the -kernel option the path to the Image
> file, not the vmlinux file.

Yes, it works fine using Image files.
I would also like to ask again, is it because AArch64 does not
support vmlinux, or is it because qemu does not implement
this capability?

Thanks,
Kunkun Jiang


