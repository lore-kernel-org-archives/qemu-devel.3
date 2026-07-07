Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58044C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7ZY-0001WQ-62; Tue, 07 Jul 2026 11:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wh7ZR-0001WH-Ie
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:18:49 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>) id 1wh7ZB-0007fR-4P
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:18:35 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3P2O+GE1qnNk7AA--.34585S2;
 Tue, 07 Jul 2026 23:18:22 +0800 (CST)
Received: from [192.168.2.6] (unknown [113.246.116.136])
 by mail (Coremail) with SMTP id AQAAf8Dw0XS6GE1qMTsRAA--.29802S2;
 Tue, 07 Jul 2026 23:18:20 +0800 (CST)
Message-ID: <e07b48cb-b183-421b-9c6c-9a12fc03af85@phytium.com.cn>
Date: Tue, 7 Jul 2026 23:18:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/pci/pcie_doe: Check mailbox length for overflows
To: alistair23@gmail.com, alistair.francis@wdc.com, mst@redhat.com,
 qemu-devel@nongnu.org, philmd@oss.qualcomm.com
References: <20260707020750.788960-1-alistair.francis@wdc.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <20260707020750.788960-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dw0XS6GE1qMTsRAA--.29802S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAJBWpMAPoKAQAAsa
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrZw13uFy5Jw1xGF4xWr17KFg_yoWfWFc_CF
 y8uF109a4j9Fs3Xa1UJFWxCrn3Ww1DZF1qka18ur1FgFyYk3Z5ZFn2y390yay7u3y7ursa
 va1agw4ruw13GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 7/7/2026 10:07 AM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>
> It was possible that a guest could overflow the `doe_cap->write_mbox`
> buffer by writing more then PCI_DOE_DW_SIZE_MAX dwords.
> `doe_cap->write_mbox_len` would continue to increment and there were no
> bounds checks on the length when offsetting into doe_cap->write_mbox.
>
> This patch adds a check and reports a guest error if we would overflow.
>
> On an overflow we also silenty discard the entire object as instructed
> to do in the PCIe spec when the length specified in the header
> (up to PCI_DOE_DW_SIZE_MAX dwords) doesn't match the length of the
> object.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3679
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>


