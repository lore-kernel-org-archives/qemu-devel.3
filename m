Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FEBC79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jLk-0000ZC-CV; Thu, 10 Sep 2026 14:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1x4jLi-0000Yd-EI
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:18:14 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1x4jLf-0007fT-8k
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:18:14 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260910181802epoutp02abd71ad860b00b880b499043b395c1c1~UCHyHEbu22105021050epoutp02K
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 18:18:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260910181802epoutp02abd71ad860b00b880b499043b395c1c1~UCHyHEbu22105021050epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789064282;
 bh=JLqdIAbN1Bz2zKeRYXAzqEzNmSDag8J0W93emDNj8vs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KsUOdCtoTgLBAG/RNXqsSvey2k+91TV5mbBq8uUMI5mWaWu5p7N64i8dJEJLEeQMJ
 QbsdFzxwPvYqd+mIlXVJT+1Cqb6VNCeOgJ6ShmoI9SiyACfY+ZEULBOhHroLv+Q0KS
 bTIBmlRjlf276T3jAvXrnp18jEue+vZYJ5quanxo=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20260910181802epcas5p1136725a4f34fd60baf66310cef23609b~UCHxvJElr2654026540epcas5p1G;
 Thu, 10 Sep 2026 18:18:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4hgmBL3LlLz6B9m6; Thu, 10 Sep
 2026 18:18:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20260910082255epcas5p3ebf61712e1937a736ee854929f2e8134~T6ALc28UU2183821838epcas5p3o;
 Thu, 10 Sep 2026 08:22:55 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260910082254epsmtip2fc2403fbe0c89aff55a044934a0cc61e~T6AJufHmL2871328713epsmtip2P;
 Thu, 10 Sep 2026 08:22:54 +0000 (GMT)
Date: Thu, 10 Sep 2026 13:52:50 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 dave@stgolabs.net, arun.george@samsung.com, dongjoo.seo1@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com, cpgs@samsung.com,
 gost.dev@samsung.com, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [RFC V2 0/9] hw/pci: hw/cxl: Add UIO support in CXL and PCIe
 stack.
Message-ID: <1742920067.01789064282454.JavaMail.epsvc@epcpadp2new>
MIME-Version: 1.0
In-Reply-To: <20260830071953.399414-1-junjie.cao@intel.com>
X-CMS-MailID: 20260910082255epcas5p3ebf61712e1937a736ee854929f2e8134
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----KR5HVoSumO1REEIZ3EVwq6Eiu41rIw6slb8fC.K-NNProunu=_1c4e7_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260910082255epcas5p3ebf61712e1937a736ee854929f2e8134
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
 <1212772528.01787732102473.JavaMail.epsvc@epcpadp1new>
 <20260830071953.399414-1-junjie.cao@intel.com>
 <CGME20260910082255epcas5p3ebf61712e1937a736ee854929f2e8134@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=shrihari.s@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

------KR5HVoSumO1REEIZ3EVwq6Eiu41rIw6slb8fC.K-NNProunu=_1c4e7_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 30/08/26 03:19PM, Junjie Cao wrote:
>Hi Shrihari,
>
>On Wed, 26 Aug 2026 11:04:00 +0530, Shrihari E S wrote:
>> This series is written on top of:
>>
>> Base commit: 3c99db7705c1a885c795b7c14f751c7a3ba29ed8
>> Repository: https://gitlab.com/jic23/qemu
>> Branch: cxl-2026-01-09-draft
>
>Applies clean there and builds; x86_64 cxl-test still passes.  I
>booted the patch-10 example topology and walked the extended
>capability chains and the HDM decoder registers: the v1 SVC/AER
>collision is fixed.  Two things are broken, both on 7/10: the
>switch USP never advertises HDM UIO -- its uio gate reads a flitmode
>field that nothing sets -- so the example topology can't advertise UIO
>end to end, and "-device ioh3420,x-svc=on" aborts QEMU.  Per-patch
>comments on 2, 3 and 5 through 10.
>
>Testing point 3 looks at whether existing configurations still work;
>the compat question is whether they still look the same to a guest.
>2/10 moves x-256b-flit onto pcie-root-port with the default left on,
>so every pcie-root-port on q35 comes up in flit mode with no compat
>entry -- an inbound migration already fails at that patch, I tried
>it -- and 7/10 shifts the CXL DVSEC offsets whether or not x-svc is set.
>
>Worth adding the PCI maintainers on v3 -- eight of the ten patches
>touch files under their entry, and both new capabilities land in
>hw/pci.
>
>I'll re-run the topology once the USP gate is settled.
>
>Many thanks,
>Junjie

Hi Junjie,

Thank you for the detailed review and testing. Your feedback helped
catch several issues that were missing in this patch series
(particularly the derived ports abort scenario). Will address your
comments in the next version of this patch series.

Thanks and regards,
Shrihari


------KR5HVoSumO1REEIZ3EVwq6Eiu41rIw6slb8fC.K-NNProunu=_1c4e7_
Content-Type: text/plain; charset="utf-8"


------KR5HVoSumO1REEIZ3EVwq6Eiu41rIw6slb8fC.K-NNProunu=_1c4e7_--


