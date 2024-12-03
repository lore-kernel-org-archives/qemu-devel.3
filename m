Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177BAE64AB6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUUn-0003f9-TQ; Tue, 03 Dec 2024 10:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tIURt-0000rW-Fy; Tue, 03 Dec 2024 10:04:26 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tIURr-0003kb-1u; Tue, 03 Dec 2024 10:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733238263; x=1764774263;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DE4+dOjQ45mKpx+SGSiTtcFl4U3w/A8oLOD6qVGAH5I=;
 b=G5Wr0eDyKSZ1izJLveH55OW4VQMLFYIL5G1+p6kT2hLI9+U/AAfL6IoS
 OPGj+Q98A3r1nF09DmulvtAn7tj5//IaXWHakY1KV3cOx3oWt3l+QcwmB
 UVIr7Z2I3g3J2ApXavdTaKTvOtMyW8stP8NJjyxixyFJQrDStBfFjBtSc
 cq/53dS5B+SAlrXRTF0Q8Au+Y4V68eDx2sh7aL4WI7cL5VojPjSfVxHgF
 kdMWACu+QavrFH7TwCm8x+mjFPt/CAHcXJjwkmdu1iYo/wbKehR0B4Hul
 zPjXS54LrcTOuO1H7+khrHDF6w/cQB/OTzLGkRi4eYlZMxE3rRymVyFH4 w==;
X-CSE-ConnectionGUID: 9vaSujR6Soexa2iRxncuDw==
X-CSE-MsgGUID: m8YAXukVQECUnwqucs8Aqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33379121"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; d="scan'208";a="33379121"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2024 07:04:17 -0800
X-CSE-ConnectionGUID: Fi1G/R6ZTVOXe2JnSjkx2A==
X-CSE-MsgGUID: dCFSEyLqRC6h5BFdARuGgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; d="scan'208";a="93802196"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2024 07:04:15 -0800
Message-ID: <f59cd973-b38b-4ee6-8baf-70019c26122e@intel.com>
Date: Tue, 3 Dec 2024 23:04:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, pbonzini@redhat.com,
 imammedo@redhat.com, xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
 qemu-stable@nongnu.org, Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, qemu-devel@nongnu.org
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
 <cc83fc31-7a77-4e32-a861-3c1dc8592a04@intel.com>
 <2f6b952d-4c21-4db5-9a8a-84a0c10feca8@bytedance.com>
 <a48fcd78-d1c4-4359-bc18-d04147a93f50@intel.com> <ZwyRsq4EIooifRvb@intel.com>
 <bbcfcbbd-1666-4e97-ae18-f47202d89009@intel.com> <ZxDS4L8vSr3HfFIh@intel.com>
 <b43557f7-49ff-43bb-8a8c-887b8220e1e8@intel.com> <Z060VQVV6ONK9Qd2@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z060VQVV6ONK9Qd2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.826, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/3/2024 3:33 PM, Zhao Liu wrote:
>> However, back to the patch, I think we cannot change it as this patch
>> directly. Instead, we need a compat_props for the changed behavior, because
>> this isn't a bug fix and it introduces guest-visible differences.
> 
> This is a fix, not a new feature, so compat_props is not needed.

Fix what? QEMU behaves as it for so many years and if the guest OS uses 
the algorithm recommended by SDM, there is no issue.

>> For ancient Intel CPUs, EBX[23:16] did represent the number of Logical
>> processor per package. I believe this should be the reason why QEMU
>> implemented it as is:
>>
>>    - on SDM version 013, EBX[23:16]: Number of logical processors per
>> physical processor; two for the Pentium 4 processor supporting
>> Hyper-Threading Technology.
>>
>>    - on SDM version 015, it changed to: Number of initial APIC IDs reserved
>> for this physical package. Normally, this is the number of logical
>> processors per physical package.
>>
>>    - on SDM version 016, it changed to: Maximum number of logical processors
>> in this physical package.
>>
>>    - finally, starting from SDM version 026, it changed to what reads now:
>> Maximum number of addressable IDs for logical processors in this physical
>> package.
> 
> And this is an architecturally defined CPUID, so SDM ensures backward
> compatibility.

SDM ensure the backwards compatibility by recommending to round the 
number up to the power-of 2 when using it to calculate the topology with 
legacy method.

> Regards,
> Zhao
> 


