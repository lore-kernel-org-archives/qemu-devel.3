Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE55CDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMQ6-0006oO-QS; Wed, 24 Jun 2026 08:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcI3q-0007He-Mw
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:30:15 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcI3m-00077D-9j
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:30:14 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260624073005epoutp03bfd956187060abea6077b5ab1beb8848~789xWF3iY2450124501epoutp03B
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 07:30:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260624073005epoutp03bfd956187060abea6077b5ab1beb8848~789xWF3iY2450124501epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1782286205;
 bh=hxHXRaB9uyp+RYupYTlmB3j4pwxcxTCdmXxtRJMmgmg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=In14pfLIbs3g6klu9QE3UFELYMvaSqlmXBzwPrQuTuSy04Ph6Mk3/3HDQ5ouaHsrB
 Lzg8eyutigVvXsrXtT93Y5lOgGLr1IubxPjdVHnoyAViF98C/XlLjqAj2pUR/JakuG
 H0HKwbYlpzZO/2FCLK12DFImK79iM5sadwKMdkqQ=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20260624073004epcas5p179392006951924f87e3f7b29f26419e1~789w8n06X0504505045epcas5p1F;
 Wed, 24 Jun 2026 07:30:04 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4glYVh5N15z3hhT4; Wed, 24 Jun
 2026 07:30:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20260624072914epcas5p17ddfb515b6bce70cee2a2aa379225330~789Bur0l01803918039epcas5p1i;
 Wed, 24 Jun 2026 07:29:14 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260624072912epsmtip17f7006cc99eb0ef6e7a229081f5a447f~788--YnKs1800818008epsmtip16;
 Wed, 24 Jun 2026 07:29:12 +0000 (GMT)
Date: Wed, 24 Jun 2026 20:48:21 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 7/8] hw/pci: hw/cxl: Wire SVC initialization into port
 realize functions.
Message-ID: <1316557528.121782286204742.JavaMail.epsvc@epcpadp1new>
MIME-Version: 1.0
In-Reply-To: <20260617154521.520191-3-junjie.cao@intel.com>
X-CMS-MailID: 20260624072914epcas5p17ddfb515b6bce70cee2a2aa379225330
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----dRaRfFW49P0MWGzTWjnkSO4RdHzY68Yl_7ceN5kYWmJQ.fIX=_53877_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260624072914epcas5p17ddfb515b6bce70cee2a2aa379225330
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <20260609105836.3702787-8-shrihari.s@samsung.com>
 <20260617154521.520191-3-junjie.cao@intel.com>
 <CGME20260624072914epcas5p17ddfb515b6bce70cee2a2aa379225330@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=shrihari.s@samsung.com; helo=mailout3.samsung.com
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

------dRaRfFW49P0MWGzTWjnkSO4RdHzY68Yl_7ceN5kYWmJQ.fIX=_53877_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 17/06/26 11:45PM, Junjie Cao wrote:
>Hi Shrihari,
>
>On Tue,  9 Jun 2026 16:28:35 +0530, Shrihari E S wrote:
>> +    pcie_config_uio_svc(d, errp);
>>      pcie_cap_arifwd_init(d);
>>      pcie_cap_deverr_init(d);
>>      pcie_cap_slot_init(d, s);
>
>In rp_realize() (and the two xio3130 ports) pcie_config_uio_svc() runs
>before pcie_aer_init().  pcie_svc_cap_init() falls back to offset 0x100
>when no extended capability exists yet, so SVC is placed at 0x100 at
>this point -- and then pcie_aer_init() puts AER at the same 0x100 and
>overwrites it, while dev->exp.svc_cap still points there.
>
>The visible effect is that "-device pcie-root-port,x-uio-svc=on" comes
>up with no SVC capability in the extended config space (the chain is
>just AER -> ACS), and no error is reported, so the request is silently
>dropped.  I reproduced this by walking the extended capability list of
>the root port over ECAM: SVC (0x35) never appears, even though the
>property was set.
>
>> +    rc = pcie_config_uio_svc(pci_dev, errp);
>> +    if (p->flitmode && rc >= 0) {
>> +        crp->uio_capable = true;
>> +    }
>
>On cxl-rp this runs a second time: cxl_rp_realize() first calls the
>parent rp_realize() (which already calls pcie_config_uio_svc() per the
>hunk above) and then calls it again directly.  The first call collides
>with AER at 0x100 as above; the second runs after the extended caps
>exist, so SVC ends up correctly at 0x200.  So cxl-rp happens to work,
>but via a double init.
>
>Just moving the call to after pcie_aer_init() isn't quite enough on
>its own: the CXL ports (cxl-rp/usp/dsp) build their DVSECs at fixed
>offsets and then add SVC themselves at the end, so if the shared
>parent rp_realize() also adds SVC before those DVSECs are built, the
>cxl-rp ends up with its DVSECs off the chain.
>
>What worked for me was to move the SVC call after the ECAP inits in
>the pure-PCIe paths and skip it in the parent when the device is CXL,
>letting the CXL realize functions keep adding it last as they already
>do:
>
>  - rp_realize(): move pcie_config_uio_svc() to after pcie_acs_init(),
>    guarded by if (!pci_is_cxl(d)) so cxl-rp's own call (which runs
>    after build_dvsecs()) remains the one that places SVC.
>  - xio3130_upstream/downstream realize(): move the call to after
>    pcie_aer_init().
>  - cxl-rp/usp/dsp: unchanged, they already add it last.
>
>With that, plain pcie-root-port, the xio3130 switch ports and the CXL
>ports all come up with SVC at 0x200, and cxl-rp keeps its four DVSECs.
>

Hi Junjie,

     Thank you for pointing this bug, got missed in our testing. Will check
     and move the svc_init() function properly in the next version of the patch.

>One thing to note is that this only gets the capability enumerated --
>I haven't verified the SVC behaviour beyond that.  Looking at
>pcie_svc_cap_write_config()/pcie_svc_apply_gating(), writing the SVC
>Enable bit just copies ctrl/status into the shadow struct; no VC
>Resource Status bit (the per-VC negotiation bit, SVC_VC_NEGO) is ever
>set, and the SVC Status register stays zero.  So a guest that enables
>SVC and polls for negotiation wouldn't see anything change.  If the
>data-plane series on top is expected to drive that, fine -- I just
>wanted to flag that as things stand the enable is observationally a
>no-op, in case a driver is expected to key off it.
>
>Many thanks,
>Junjie

Yeah this patch series is meant for enumeration (probe) puprpose only
and yes we have plan to add data plane support as well.

Thanks,
Shrihari


------dRaRfFW49P0MWGzTWjnkSO4RdHzY68Yl_7ceN5kYWmJQ.fIX=_53877_
Content-Type: text/plain; charset="utf-8"


------dRaRfFW49P0MWGzTWjnkSO4RdHzY68Yl_7ceN5kYWmJQ.fIX=_53877_--


