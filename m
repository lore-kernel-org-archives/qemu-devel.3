Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD10E6748D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 07:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXa66-0000Jf-8k; Mon, 22 Dec 2025 02:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@ziyao.cc>) id 1vXa62-0000IW-Us
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 02:12:46 -0500
Received: from mail102.out.titan.email ([52.45.239.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@ziyao.cc>) id 1vXa61-0005ua-AA
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 02:12:46 -0500
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dZTqb0cLGz2xBT;
 Mon, 22 Dec 2025 07:12:43 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=mIu+82rc0SeKYeum1ykQmkwpZp0Mog4V9mAAiX7G9Dg=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=references:mime-version:to:in-reply-to:subject:date:from:cc:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
 q=dns/txt; s=titan1; t=1766387563; v=1;
 b=P8uGhV7AWtk5/2lxk6ZXMX3kv6dHgMUFvkhlKt67EODscIN3morwGRt9OfGXbkUdoQ4IhwxE
 AUuPbHmVjDXBHrEpFK6iV6qyBO7FP1VIImFClosUMF+PfanVXiOiuOVAG3pWD/pts0NDmyJnNSi
 yUGu+oLATYGcmL8ppGiYaSNI=
Received: from pie (unknown [117.171.66.90])
 by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dZTqY0Xtrz2xC2;
 Mon, 22 Dec 2025 07:12:40 +0000 (UTC)
Date: Mon, 22 Dec 2025 07:12:33 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/loongarch/virt: Permit bytes/half access to IOCSR
Message-ID: <aUju2fhuuF5rs96H@pie>
References: <20251221122205.56463-2-me@ziyao.cc>
 <ad1e33d6-8568-e050-f7d8-eb656a4af729@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad1e33d6-8568-e050-f7d8-eb656a4af729@loongson.cn>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766387562942027233.27573.846644460579412895@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=6948ef6a
 a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10
 a=zdZPbV0uByiNToNf1MEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22
Received-SPF: pass client-ip=52.45.239.238; envelope-from=me@ziyao.cc;
 helo=mail102.out.titan.email
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 22, 2025 at 11:24:38AM +0800, Bibo Mao wrote:
> 
> 
> On 2025/12/21 下午8:22, Yao Zi wrote:
> > IOCSRs could be accessed in any sizes from 1 to 8 bytes as long as the
> > address is aligned, regardless whether through MMIO or iocsr{rd,wr}
> > instructions. Lower min_access_size to 1 byte for IOCSR memory region to
> > match real-hardware behavior.
> Hi Yao,
> 
> What is the detailed problem you encountered? Or just look through code and
> think that it should be so.

I don't think there's a real use-case for this. However, without the
patch, the behavior of iocsrrd.b differs between real hardware and QEMU,
you could try this diff with Linux kernel for comparing.

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 25a87378e48e..679e311ac654 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -621,3 +621,13 @@ void __init setup_arch(char **cmdline_p)
 	kasan_init();
 #endif
 }
+
+static int __init read_iocsr(void)
+{
+	pr_info("%s: iocsrrd_b(0x10) = 0x%x\n", __func__,
+		__iocsrrd_b(0x10));
+
+	return 0;
+}
+
+late_initcall(read_iocsr);

On QEMU, the error raised by address_space_ldub is silently ignored by
helper_iocsrrd_b(), and thus __iocsrrd_b(0x10) results in zero, while on
real hardware it doesn't.

Ignoring the error returned by address_space_{ld,st}* in helper_iocsr*
could cause more behaviors inconsistent with real LoongArch hardware.
But in the case shown in the diff that a single byte is read from iocsr,
the access shouldn't fail at all, which this patch tries to fix.

Regards,
Yao Zi

> IOCSR supports 1/2/4/8 byte access like MMIO, however here is IOCSR MISC
> device rather than IOCSR bus emulation. What is the usage and scenery to
> read IOCSR MISC device with one byte?
> 
> It is similar with other device emulation with MMIO, such as e1000e with 4
> bytes aligned rather than any byte:
> static const MemoryRegionOps mmio_ops = {
>     .read = e1000e_mmio_read,
>     .write = e1000e_mmio_write,
>     .endianness = DEVICE_LITTLE_ENDIAN,
>     .impl = {
>         .min_access_size = 4,
>         .max_access_size = 4,
>     },
> };
> 
> 
> Regards
> Bibo Mao

