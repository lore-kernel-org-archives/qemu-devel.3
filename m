Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0878CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMPz-0006mI-MR; Wed, 24 Jun 2026 08:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcHA5-00060y-LK
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:32:37 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcHA3-0003Ww-Mm
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:32:37 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260624063229epoutp03fa1eed6f29d5f7b6022d3c0cd3a761a3~78LfG0E-82911429114epoutp03P
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:32:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260624063229epoutp03fa1eed6f29d5f7b6022d3c0cd3a761a3~78LfG0E-82911429114epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1782282749;
 bh=gCHdlJptgPPRCutW3+PXA89oSW/TTgj5oE//NghhidA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=az+5u/Yo7w0+HYUn+asvfWcAb58uOAOLJCVZh2KmXmQZWpz5CoiNOb9YHJZNVVDiw
 0v6MreaRks2ZrLnTivDOyCzlKyzKO3u2TyMB1tIL85sEjYCjz6bJy2w/4OmXyn9igW
 WsxQhjRW+IasdOwurMQqYgNal79zIjFpkiz2GyX4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20260624063229epcas5p45c6fe4ae66c36bdd7aeb15bb5898de10~78LenQtu32641426414epcas5p42;
 Wed, 24 Jun 2026 06:32:29 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4glXDD28LMz2SSKj; Wed, 24 Jun
 2026 06:32:28 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20260624063227epcas5p4c3143473afa38b85d5eddca403d89ccd~78Ldb8W7A2605926059epcas5p4l;
 Wed, 24 Jun 2026 06:32:27 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260624063225epsmtip1d570a3c9d6de2cb92616bcd7e65ff6e3~78LbmT1MG1927019270epsmtip1I;
 Wed, 24 Jun 2026 06:32:25 +0000 (GMT)
Date: Wed, 24 Jun 2026 19:51:14 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 4/8] hw/cxl: Add Streamlined Virtual Channel (SVC)
 property to CXL ports
Message-ID: <20260624142114.pvrshhaueuaszg7i@arun-B560M-DS3H-V2>
MIME-Version: 1.0
In-Reply-To: <20260616182159.6c618a75@jic23-huawei>
X-CMS-MailID: 20260624063227epcas5p4c3143473afa38b85d5eddca403d89ccd
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53357_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7@epcas5p1.samsung.com>
 <20260609105836.3702787-5-shrihari.s@samsung.com>
 <20260616182159.6c618a75@jic23-huawei>
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

------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53357_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 16/06/26 06:21PM, Jonathan Cameron wrote:
>On Tue,  9 Jun 2026 16:28:32 +0530
>Shrihari E S <shrihari.s@samsung.com> wrote:
>
>> Add Unordered IO (UIO) dependent property SVC to CXL ports
>> (Root, Upstream and Downstream).
>>
>> The following properties are added to CXL ports:
>>     - x-uio-svc: Enable UIO traffic via SVC3 (mandatory path)
>>     - x-uio-svc-opt: Enable UIO traffic via SVC4 (optional path)
>>
>> Note: 256B flit mode property was already added in CXL ports, so reused it.
>>
>> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
>> Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
>> ---
>>  static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
>> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
>> index e82685d1ab..83fb5968b8 100644
>> --- a/hw/pci-bridge/cxl_root_port.c
>> +++ b/hw/pci-bridge/cxl_root_port.c
>> @@ -53,6 +53,7 @@ typedef struct CXLRootPort {
>>      CPMUState cpmu;
>>      MemoryRegion cpmu_registers;
>>      PCIResReserve res_reserve;
>> +    bool uio_capable;
>I'd bring these in with a patch that uses them.
>
>This whole thing is simple enough maybe just have it as part of a commit
>that uses the properties.
>

Hi Jonathan,

   Yeah sure will move this field to the patch that uses it. Thought it would be
   a prep patch for the patch that really uses this feature.

Thanks,

>>  } CXLRootPort;


------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53357_
Content-Type: text/plain; charset="utf-8"


------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53357_--

