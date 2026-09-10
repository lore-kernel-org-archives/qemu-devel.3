Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AA4C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jLk-0000ZS-Bw; Thu, 10 Sep 2026 14:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1x4jLi-0000YV-3U
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:18:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1x4jLf-0007fX-8U
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:18:13 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260910181803epoutp03fcacdbd03390c6464c39bb975ae640d6~UCHywWnw82419324193epoutp038
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 18:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260910181803epoutp03fcacdbd03390c6464c39bb975ae640d6~UCHywWnw82419324193epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789064283;
 bh=OQ0nhEhf/1R8uFnSN5DuKP2tH3ii5rke0Xx19jIH1kk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TKsMv8Sdmb44or+EpYezS8OchnIYTR2858ZyNesBrwL4S/RRwtzbKbBdSYzX4Foyh
 7lNo9E5Sxidd2LeRQhOmUZGzgqstrBF1VHYv6auvNKyTZbKUlAk7QM4li+y2Jw7dtZ
 Z4TmGzDhwI4ZgBU8vAZJTQg4yHKRt1KEZH6EbpDY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20260910181802epcas5p1a3e653ba2ab16e889be7aea053300505~UCHyMCUKs2653226532epcas5p1J;
 Thu, 10 Sep 2026 18:18:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4hgmBL6p4sz6B9m6; Thu, 10 Sep
 2026 18:18:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20260910093751epcas5p34f8f8305b510015bc8f43c0ee7d9a714~T7Bmo1Rf82396323963epcas5p35;
 Thu, 10 Sep 2026 09:37:51 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260910093750epsmtip216a8b0f7cda3290126aecd781fe78389~T7Bk1WdgZ3127631276epsmtip28;
 Thu, 10 Sep 2026 09:37:49 +0000 (GMT)
Date: Thu, 10 Sep 2026 15:07:43 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 dave@stgolabs.net, arun.george@samsung.com, dongjoo.seo1@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com, cpgs@samsung.com,
 gost.dev@samsung.com, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, shrihari.s@samsung.com
Subject: Re: [RFC V2 05/10] hw/cxl: Wire UIO capability into HDM decoder and
 DVSEC registers
Message-ID: <937773018.41789064282938.JavaMail.epsvc@epcpadp2new>
MIME-Version: 1.0
In-Reply-To: <20260830072118.399487-1-junjie.cao@intel.com>
X-CMS-MailID: 20260910093751epcas5p34f8f8305b510015bc8f43c0ee7d9a714
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----sqS1HhdduDW2nLZYQl-nXfubNT0qWDWm0NnJ2DYydRADAyyn=_1c79a_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260910093751epcas5p34f8f8305b510015bc8f43c0ee7d9a714
References: <1646464088.101787732103895.JavaMail.epsvc@epcpadp1new>
 <20260830072118.399487-1-junjie.cao@intel.com>
 <CGME20260910093751epcas5p34f8f8305b510015bc8f43c0ee7d9a714@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=shrihari.s@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

------sqS1HhdduDW2nLZYQl-nXfubNT0qWDWm0NnJ2DYydRADAyyn=_1c79a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 30/08/26 03:21PM, Junjie Cao wrote:
>On the type list itself: 8.2.4.20.1 enumerates UIO Capable for CXL.mem
>devices, USPs and CXL Host Bridges, the Host Bridge case being the one
>that means "all the root ports within this Host Bridge are capable of
>routing UIO requests".  This sets it per root port instead, and
>pci_expander_bridge.c passes uio=false for CXL2_RC unconditionally, so
>the host bridge never advertises it.  On v1 I said a root port may well
>be intended, going off crp->uio_capable in the SVC wiring, but the
>enumeration above doesn't list one.  Is the root port the intended
>carrier?

Hi Junjie,

Thank you pointing this out. I agree that enabling UIO in Host Bridge
(HB) should enable UIO in all the root ports, but the challenge is that
the HB might not know which root port attached to it holds UIO PCIe capability.
That's why the implementation went to root port. Will extend this
capability field to HB (x-uio) in the next version of this patch.
CIIW, Root port is intended to hold the UIO dependent capablites
(SVC, 256b flit), so that eventhough the HB enables UIO HDM field,
the attached root ports can be checked for the PCIe capabilities before
enabling UIO in their respective HDM decoder.

Thanks and regards,
Shrihari

------sqS1HhdduDW2nLZYQl-nXfubNT0qWDWm0NnJ2DYydRADAyyn=_1c79a_
Content-Type: text/plain; charset="utf-8"


------sqS1HhdduDW2nLZYQl-nXfubNT0qWDWm0NnJ2DYydRADAyyn=_1c79a_--


