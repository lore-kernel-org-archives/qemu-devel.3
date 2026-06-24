Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD4CCDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMQ4-0006nG-Lt; Wed, 24 Jun 2026 08:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcHxC-0005ti-8n
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:23:23 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcHx1-00067J-Oz
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:23:22 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260624072304epoutp04bc0b261d6659c31488e26dc97fa1b3a3~783p4Ab-q0397603976epoutp04I
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 07:23:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260624072304epoutp04bc0b261d6659c31488e26dc97fa1b3a3~783p4Ab-q0397603976epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1782285784;
 bh=Zx+GK9SEZ82lWmgsSqYliXVinMXaugcnvdzvMvb0uuY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=msljClRianM1i7iLAkGDaotg4OBBIBRSFKa5jVPES0BBik2be5XfPo2MOKMGgeXES
 s/IHlVzzQCFu1jHWIHx80M7VrIayvz/1KoDGlHjGd1SJEWp17CK8xyGkQYRnEtGYiu
 M8HuiAcJZJoBy85JPZhQze7FSezfXqC6q736kugc=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20260624072304epcas5p1c318f3f3b57b6a52cdbece56e6614b8e~783pLAPBQ2269122691epcas5p1F;
 Wed, 24 Jun 2026 07:23:04 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4glYLc0dw2z3hhTD; Wed, 24 Jun
 2026 07:23:04 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20260624072046epcas5p10787cf7e14b0b8e72d4d11fb782b3ca1~781o3-WPM1059310593epcas5p1N;
 Wed, 24 Jun 2026 07:20:46 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260624072044epsmtip2ef2cbfeba78fb7c84ddc1fd3ef3be652~781nA6DXa2004820048epsmtip2h;
 Wed, 24 Jun 2026 07:20:44 +0000 (GMT)
Date: Wed, 24 Jun 2026 20:39:52 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 6/8] hw/pci: Add PCIe Streamlined Virtual Channel (SVC)
 capability.
Message-ID: <1987169128.61782285784075.JavaMail.epsvc@epcpadp2new>
MIME-Version: 1.0
In-Reply-To: <20260617154521.520191-2-junjie.cao@intel.com>
X-CMS-MailID: 20260624072046epcas5p10787cf7e14b0b8e72d4d11fb782b3ca1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_53c69_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260624072046epcas5p10787cf7e14b0b8e72d4d11fb782b3ca1
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <20260609105836.3702787-7-shrihari.s@samsung.com>
 <20260617154521.520191-2-junjie.cao@intel.com>
 <CGME20260624072046epcas5p10787cf7e14b0b8e72d4d11fb782b3ca1@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=shrihari.s@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 24 Jun 2026 08:09:17 -0400
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

------8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_53c69_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 17/06/26 11:45PM, Junjie Cao wrote:
>Hi Shrihari,
>
>On Tue,  9 Jun 2026 16:28:34 +0530, Shrihari E S wrote:
>>      if (flitmode) {
>> -        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
>> +        uint32_t pos = dev->exp.exp_cap;
>> +
>> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
>>                                     PCI_EXP_LNKSTA2_FLIT);
>> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
>> +                                   PCI_EXP_FLAGS_FLIT);
>
>Following up on Jonathan's observation here -- I'd also noticed a
>bogus Interrupt Message Number on a plain flit-mode root port, so I
>checked what the stray write actually does to the Flags register.
>The impact is wider than just UIO:
>
>The first set_mask writes PCI_EXP_LNKSTA2_FLIT (0x0400) into
>PCI_EXP_FLAGS (cap offset 0x02) instead of PCI_EXP_LNKSTA2 (0x32).
>0x0400 falls in the Interrupt Message Number field (bits 13:9) of the
>Flags register, so a flit-mode port ends up reporting a nonzero
>Interrupt Message Number (it reads back as 2).
>
>pcie_cap_fill_lnk() runs for every flit-mode port, and x-256b-flit
>defaults to on for pcie-root-port, so even a plain
>"-device pcie-root-port" comes up with the corrupted field.
>
>The second line (PCI_EXP_FLAGS_FLIT into Flags) looks correct and
>should stay.  The first one looks like a typo in the destination
>register -- it was PCI_EXP_LNKSTA2 before this series (visible in the
>hunk above), so I'd restore it there rather than drop it.
>pcie_cap_flit_write_config() does maintain the LNKSTA2 flit bit, but
>only on guest LNKCTL writes; it doesn't run at realize/reset, so
>dropping the line would leave LNKSTA2 flit status reading 0 at reset
>instead of its pre-series value.
>
>Many thanks,
>Junjie

Hi Junjie,

   Yeah, it's a typo. The destination register should be "PCI_EXP_LNKSTA2".
   Thank you for pointing this out. We will rectify it in the next version.

Thanks,


------8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_53c69_
Content-Type: text/plain; charset="utf-8"


------8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_53c69_--


