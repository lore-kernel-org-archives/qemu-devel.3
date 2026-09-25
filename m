Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B635BC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAAkT-00016y-Mz; Fri, 25 Sep 2026 14:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xAAkO-00016K-5M
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 14:34:13 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xAAkM-00049P-08
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 14:34:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=ZsYXNOo
 eSEQ5Zz8R5/z7jsHtM6nBlv6O/x+4FrXnsJQbzcPg/IUdtAaMiYiey5wPoRUgT3wF8uT79
 2HyIJs3/frX7vgvKuvyaZTtwLqDVQb0plhpVuYQyS9ZdqW99+DDfQHN3Eu3fGpiabmz0uq
 F7Ond3oDhMM0hwQIGd1n/Kls1y0H9URUX5wNShItUqEwLdS1N1l+n1xq1EtrC8t8mV/7gt
 v/FeyFK7AUc1enXC2LLXcLNS3N5/bOYAA+bag1fDUtlFL9ZpS0pFGbKbpuokjJ9DPCF+4c
 sHDa19yE4Fto+7GzFVLRPtusdKWHnn1SH6oLMah0tFCPd9EvzRTTSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=a
 tVGoxcK8gZnom10CZ0krE6Xvkfj5SYOsffENxthw7Q=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Di4ynQcI/zMjc2Vr+Yrf9KyuFBfE2OkSatmOFEQS3CnezJdd/wxfVY+2Z4giHlXVdqtw
 e482z0sU/Frrr44yYaek8GkJs6nPZ3j+DEY0J2m0Wh8MB/t2poA7yIozRjsvzz2/CrbprC
 GXDmuqjg8HGlKMfIEhf90cXBf3b5Cj+Rv82fuGYO5V7OffXM7Zh0nak7jDTokm1D9ZHl3r
 2aZDw/TojD3CZD3ljr0bwNhBTmnM3Po4V8A+rNcH0h/kn94vrdMoRUVnlbMIeRA5G9aVsx
 D/gw9//eG9+TbkEF65a6GTHu/h6lrnYAlMi1j8xBWk8EyDyKkB0QCZQ7ousHlnVQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=Du2ow80w; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=CqhpT/cy;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=atVGoxcK
 8gZnom10CZ0krE6Xvkfj5SYOsffENxthw7Q=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=Du2ow80w25OkbKG5iv6t/KH56RIGpz
 H5GdgMJha0dfLQ8sUzEa9awz0KlnCYJhBlkB8bFDcTOw2NEnQZ9Kvc4ZZGdZ1akZTKqFd1
 euMpTMGg81w+r6KyulpUlG6Rhkv0RSKZthexlxL9REnYK62QWf2FILjbj3lpVIBd6xSRBt
 fOwWfVxJ1DBWrLd7Zu8o0GoFuPMnvna0lc3CIgYTQZA0BlE+7lvMTObCE7iuxF2pzGQz9S
 4OKIVLXgjd0a9rNEf3qjmEGBdJDzJj2IYZaondKf1iGkrfwyZLiCqHCupXcmONPmdXJvpt
 2DBiMmIxrntAhzCYXeGaBf8W0CBI1JnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=atVGoxcK8gZnom10CZ0krE6Xvkfj5SYOsffENxthw7Q=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=CqhpT/cyY5BZ7ryPEH
 saGo94u+g/hBn40d6FcbxmGY0ZmUlUCg6N2Jd+OQY2PXcMzKioGoMKkRUMIsiP6lT2DA==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id df6edc43
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 25 Sep 2026 20:34:01 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) id 3fdd3eaa;
 Fri, 25 Sep 2026 20:33:57 +0200 (CEST)
Date: Fri, 25 Sep 2026 20:33:57 +0200
Message-ID: <87h5jd5gfe.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,	Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@mailo.com>,	"Michael S. Tsirkin"
 <mst@redhat.com>,	Aurelien Jarno <aurelien@aurel32.net>,	Jiaxun Yang
 <jiaxun.yang@flygoat.com>,	Aleksandar Rikalo <arikalo@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/25] hw/mips: add Octeon III EBB7304 support
In-Reply-To: <bcf359bb-5dde-482c-b1e2-6161f6498c0b@oss.qualcomm.com>
References: <20260903120510.34876-1-kirill@korins.ky>
 <bcf359bb-5dde-482c-b1e2-6161f6498c0b@oss.qualcomm.com>
User-Agent: Wanderlust
Mail-Followup-To: philmd@oss.qualcomm.com, pbonzini@redhat.com,
 philmd@mailo.com, mst@redhat.com, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com,
 qemu-devel@nongnu.org,
 "Kirill A. Korinsky" <kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=ham autolearn_force=no
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

On Thu, 03 Sep 2026 14:18:02 +0200,
Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> 
> Hi Kirill,
> 
> On 3/9/26 14:01, Kirill A. Korinsky wrote:
> > Greetings,
> > 
> > This is resend which includes missed maintainer.
> > 
> > This series adds enough Cavium Octeon III CN73xx and EBB7304 board
> > support for upstream U-Boot 2026.04 to boot OpenBSD/octeon from USB
> > storage or through PCI e1000 and TFTP; the same machine also reaches
> > the prompt of the vendor U-Boot 2013.07 image from the Ubiquiti
> > EdgeRouter Infinity ER-8-XG recovery set. The model intentionally
> > covers the hardware exercised by these firmware and operating system
> > paths.
> I'll be offline until the 21th but I tagged your series for review.
> Please ping me back then in case I forget :)
>

Friendly ping about this series and https://patchew.org/QEMU/20260719215455.96122-1-kirill@korins.ky/

> > Patch layout:
> > 
> >    1. target/mips: make CP0 interrupt state atomic
> >    2. target/mips: fix MIPS64 segment access checks
> >    3. target/mips: drop hidden TLB shadowing for tlbwr
> >    4. target/mips: add Octeon CP0 register state
> >    5. target/mips: add Octeon CN73xx CPU model
> >    6. target/mips: accept Octeon PageMask encodings
> >    7. target/mips: allow Octeon unaligned accesses
> >    8. hw/mips: add empty Octeon III machine
> >    9. hw/mips: add Octeon CPUs and boot memory
> >   10. hw/mips: add Octeon reset controller
> >   11. hw/mips: add Octeon CIU3 CPU control
> >   12. hw/mips: add Octeon CIU3 interrupt routing
> >   13. hw/mips: add Octeon legacy CIU
> >   14. hw/mips: add Octeon CSR window
> >   15. hw/mips: expose Octeon reset CSRs
> >   16. hw/mips: add Octeon MIO boot support
> >   17. hw/mips: wire the Octeon UART
> >   18. hw/i2c: add Octeon TWSI controller
> >   19. hw/mips: add Octeon EMM controller
> >   20. hw/mips: add Octeon LMC controllers
> >   21. hw/mips: add Octeon boot support registers
> >   22. hw/usb: add Octeon USB controller
> >   23. hw/pci-bridge: add Octeon PCI host bridge
> >   24. hw/pci-bridge: add Octeon PCI memory window
> >   25. tests/functional: test Octeon III boot
> (I'm not sure of the usefulness of listing the default series layout)

-- 
wbr, Kirill

