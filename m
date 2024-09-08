Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35428E6FE49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 10:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snFUW-0006Gq-9L; Sun, 08 Sep 2024 06:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1snFUU-0006GM-65
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 06:49:58 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1snFUR-0002aq-7L
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 06:49:57 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7C7874E60F7;
 Sun, 08 Sep 2024 12:49:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id lnCpOhVdrQUr; Sun,  8 Sep 2024 12:49:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 473C64E6013; Sun, 08 Sep 2024 12:49:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 454A0746F60;
 Sun, 08 Sep 2024 12:49:47 +0200 (CEST)
Date: Sun, 8 Sep 2024 12:49:47 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Kenneth Adam Miller <kennethadammiller@gmail.com>
cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: How to run qemu
In-Reply-To: <CAK7rcp-jQAx3Qr_OntcTeNhfM_nzyoOiLDvSpPj=__FfxhSrcw@mail.gmail.com>
Message-ID: <788db4b3-c9d0-0966-8b76-32c263614b76@eik.bme.hu>
References: <CAK7rcp_qUmp7k6dqo62KqNpAuNgVznWiCxgBrhf4V7PT5=YDhQ@mail.gmail.com>
 <CAK7rcp-jQAx3Qr_OntcTeNhfM_nzyoOiLDvSpPj=__FfxhSrcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 7 Sep 2024, Kenneth Adam Miller wrote:
> I found this:
> https://qemu-project.gitlab.io/qemu/system/linuxboot.html
> and this:
> https://nickdesaulniers.github.io/blog/2018/10/24/booting-a-custom-linux-kernel-in-qemu-and-debugging-it-with-gdb/
>
> So I now have serial output. But I still need to know how to put a binary
> in the image so I can run it.

There are several ways but maybe the easiest is to put the binary in the 
initrd if you can edir that (try 'file ramdisk.img' to find out what 
format it's in) or make an iso from it and use -cdrom option to add it as 
a CD drive that they you can mount it if the kernel has appropriate 
drivers.

Regards,
BALATON Zoltan

