Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD55CCDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMQ0-0006mv-1Q; Wed, 24 Jun 2026 08:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcGqw-0001Ae-H7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:12:51 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcGqr-00015k-Uq
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:12:50 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260624061232epoutp01d18f5eb506bca95798bcef618d966c58~776EdR9Td1663516635epoutp01E
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:12:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260624061232epoutp01d18f5eb506bca95798bcef618d966c58~776EdR9Td1663516635epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1782281552;
 bh=kY/dxQYx/wRPEf2qC748CpGM1a3g+t0/zv46gOr+qAY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oh3W1FePv07XnqAelEFW8Q1pHVwG+ADlorSBlcPlORMD+FT9ETvo7JJEYRgXh7OZY
 /8KS9rzeonXIOS8vWBeBr7bHSXW+q18fNtzf6aBmnAbpJyAafwRAeeA714I6TT2nZh
 ENonRAj6ASBEBOBgjGdLNn0mfaUlhLPOjKRQm05I=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20260624061232epcas5p43790b4403384ebc55187f2fb90e34c6c~776DwZAjB0689606896epcas5p4N;
 Wed, 24 Jun 2026 06:12:32 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.89]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4glWnC1CKLz3hhTD; Wed, 24 Jun
 2026 06:12:31 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20260624061230epcas5p419894dd4d2e612f7712f1ec7ae940ce0~776ChX7yz3046330463epcas5p4b;
 Wed, 24 Jun 2026 06:12:30 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260624061228epsmtip1b208377c679fed6ea71d1c7e754271e5~776ACMl-O2928929289epsmtip1P;
 Wed, 24 Jun 2026 06:12:27 +0000 (GMT)
Date: Wed, 24 Jun 2026 19:31:03 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 1/8] hw/pci: Refactor flitmode from PCIESlot to PCIEPort.
Message-ID: <20260624140103.thavawn667tfs4tg@arun-B560M-DS3H-V2>
MIME-Version: 1.0
In-Reply-To: <20260616142730.7fb0a465@jic23-huawei>
X-CMS-MailID: 20260624061230epcas5p419894dd4d2e612f7712f1ec7ae940ce0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----LzjFyProJtBlqpjpUA7CxzsXX7e_8S7ToqyYf_kYrViRiBfb=_5314c_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb@epcas5p1.samsung.com>
 <20260609105836.3702787-2-shrihari.s@samsung.com>
 <20260616142730.7fb0a465@jic23-huawei>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=shrihari.s@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
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

------LzjFyProJtBlqpjpUA7CxzsXX7e_8S7ToqyYf_kYrViRiBfb=_5314c_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

>> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
>> index 0ee18ef5c3..df69c5200f 100644
>> --- a/hw/pci-bridge/cxl_root_port.c
>> +++ b/hw/pci-bridge/cxl_root_port.c
>
>>  static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index 1de0b1e4fd..d452199d85 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>> @@ -217,7 +217,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
>>          /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
>>      }
>>
>> -    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->flitmode);
>> +    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->parent_obj.flitmode);
>
>I think we should use a cast to the parent object type rather than going directly
>into s->parent_obj.  PCIE_PORT(s)->flitmode.

Hi Jonathan,

Got your point and it makes sense, will change that in the next version of this patch series. Thanks for the suggestion.

>
>>  }
>

------LzjFyProJtBlqpjpUA7CxzsXX7e_8S7ToqyYf_kYrViRiBfb=_5314c_
Content-Type: text/plain; charset="utf-8"


------LzjFyProJtBlqpjpUA7CxzsXX7e_8S7ToqyYf_kYrViRiBfb=_5314c_--

