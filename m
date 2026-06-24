Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D952CDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMPw-0006lW-23; Wed, 24 Jun 2026 08:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcH73-0005PV-Io
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:29:30 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcH6y-00032D-EE
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:29:29 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260624062917epoutp01fea531f4f03540d16d6def62344830cc~78IshfYgt0120801208epoutp01g
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:29:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260624062917epoutp01fea531f4f03540d16d6def62344830cc~78IshfYgt0120801208epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1782282557;
 bh=bMS8K56VmMhlkYOs76iSLytYgBZfJhEXGAFPnTRB858=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=STU/FO3mr8eaLYLhYWgDgpIWfZPNyBp9pmsk7cLKX6+to7cE04HXzXrapkkP8Lrdz
 3lz8EgR4SLoRpulX4nRDAjb3qzXpei6rD3ZzQ3VvCGViE1bHblLJJ/kaaar9ZbnHaH
 rXUWO8nK1DK8COyGGIsJQRNFKdWB9vmzFKRpkUOI=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20260624062917epcas5p4aa00448c504e08879ab7c408a69e99de~78Ir45e3N0934509345epcas5p4n;
 Wed, 24 Jun 2026 06:29:17 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.87]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4glX8X3Dwvz6B9m8; Wed, 24 Jun
 2026 06:29:16 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20260624062915epcas5p39f8859af5665acb4dc7b8ba7beb3bd43~78IqvVnvm1577415774epcas5p3Y;
 Wed, 24 Jun 2026 06:29:15 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260624062914epsmtip24934ac2d15482865c5fcc6b3fcdc6c02~78IpPNfJT1926719267epsmtip2V;
 Wed, 24 Jun 2026 06:29:14 +0000 (GMT)
Date: Wed, 24 Jun 2026 19:48:06 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 3/8] hw/pci: Add SVC capability and UIO properties to PCIe
 ports
Message-ID: <20260624141806.5g4yub6kby6cnsh7@arun-B560M-DS3H-V2>
MIME-Version: 1.0
In-Reply-To: <20260616182029.3dc0af33@jic23-huawei>
X-CMS-MailID: 20260624062915epcas5p39f8859af5665acb4dc7b8ba7beb3bd43
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53308_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104517epcas5p222b4fc4a5fd8671b47a68abc785a6422
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104517epcas5p222b4fc4a5fd8671b47a68abc785a6422@epcas5p2.samsung.com>
 <20260609105836.3702787-4-shrihari.s@samsung.com>
 <20260616182029.3dc0af33@jic23-huawei>
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

------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53308_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 16/06/26 06:20PM, Jonathan Cameron wrote:
>On Tue,  9 Jun 2026 16:28:31 +0530
>Shrihari E S <shrihari.s@samsung.com> wrote:
>
>> From: Dongjoo Seo <dongjoo.seo1@samsung.com>
>>
>> Implement the Streamlined Virtual Channel (SVC) extended capability
>> for PCIe ports (Root, Upstream, and Downstream). This capability is
>> mandatory for enabling Unordered IO (UIO) traffic as per PCIe 6.4
>> specification [1].
>>
>> UIO functionality depends on two key prerequisites:
>>   1. SVC support (SVC3 mandatory, SVC4 optional)
>>   2. 256-byte Flit mode support
>>
>> This patch adds the following experimental properties to PCIe ports:
>>   - x-uio-svc: Enable UIO traffic via SVC3 (mandatory path)
>>   - x-uio-svc-opt: Enable UIO traffic via SVC4 (optional path)
>
>That doesn't feel like naming that will stand the test of time.
>I think it needs to mention svc4 in the name.  Or I suppose we could
>do something with a single x-uio-svc parameter taking values.
>
>

Hi Jonathan,

We thought, 
   - it would be more technical if we add svc3 and svc4 in the
     emulation parameters and
   - would be readable if we advertise the field as UIO mandatory
     SVC (x-uio-svc) and UIO optional SVC (x-uio-svc-opt).

cool will change those to "x-uio-svc3" and "x-uio-svc4" in the
upcoming version.

Thanks.

>>   - x-256b-flit: Enable 256B flit mode required for UIO
>>
>> Helper functions are included to manage UIO traffic gating and SVC
>> configuration. This change lays the groundwork for UIO emulation in
>> QEMU.
>>
>> [1]: PCIe 6.4 Specification, Table 2-46 (Streamlined Virtual Channel)
>
>I'm currently out of the loop for PCIe specs. So if someone else could
>review against spec that would be great.
>
>>
>> Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
>> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
>> ---
>>  static const TypeInfo xio3130_upstream_info = {
>> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
>> index 1bcc734649..a6b1b8a6cf 100644
>> --- a/include/hw/pci/pcie_port.h
>> +++ b/include/hw/pci/pcie_port.h
>> @@ -37,8 +37,29 @@ struct PCIEPort {
>>
>>      /* pci express switch port */
>>      uint8_t     port;
>> +
>> +    /*
>> +     * This field declares Streamlined Virtual Channel (SVC) capability.
>> +     * Per PCIe 6.4 specification section 7.9.29, a pcie port supports
>> +     * upto 8 SVCs, in that SVC0 is a default one, SVC3 is for UIO traffic
>> +     * and SVC 4 is shared by both UIO and non-UIO traffic.
>
>What actually goes in there?  Is this literally the SVC capability content?
>

Yes, this is the SVC capability of the port and is a bitmap which will be
populated based on the emulation parameters of the port.

>> +     */
>> +    uint32_t    svc;
>>  };
>>
>> +#define UIO_MANDATORY_SVC 3
>> +#define UIO_OPTIONAL_SVC 4
>> +
>> +static inline bool get_uio_mandatory_svc(PCIEPort *port)
>> +{
>> +    return (port->svc >> UIO_MANDATORY_SVC) & 1;
>
>Could just define the field mask given I don't think you ever care about them
>being the numeric values themselves. If you need the value defines later, then
>fair enough.
>
>If you do switch to defining fields.
>	return port->svc & UIO_MANDATORY_SVC;
>and rely on boolean cast from non 0 to be true.
>
>Also, do we want to route those two defines through the kernel uapi/linux/pci_regs.h
>and then just make use of them in QEMU?
>

Actually these are not registers, just a macro definition used to denote SVC3
and SVC4. These definitions are used to enable/verify the bitmap declared
above (uint32_t svc) and I guess routing from linux/pci_regs.h is not
required.

>I kind of assume you have some kernel patches as well as this qemu support so
>it would form part of that?
>

Yeah, we are peparing kernel patches and will be sent out shortly.



------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53308_
Content-Type: text/plain; charset="utf-8"


------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53308_--

