Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0E1C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBYY-00008V-Ga; Fri, 24 Jul 2026 04:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wnBYO-00006B-JG
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:46:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wnBYM-0004V1-FB
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:46:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lWMD1510175
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iS8LAd5P/peWCH0et4/K+GrM5SNZpyI++NDRKMgyQKY=; b=o7PzJo+wgbBJoECZ
 EIE0G/FBcwMqdRkuIN+LuCQ/73fH5qL5S3LvcYWeaNn81lmtbKswcNeiIKyEQaAk
 lZltnYpA8vPw2Sl4lHjM5htBqMVXOKKJwt9Ai2/jiUHlt8N7bGtI1GRHORKTcGvZ
 6OtkuLgHsaMn8gyOKVieoWYQxxm1saxqIEFTrsdxU7wlHUNh2vAALy92xJ0lOCSE
 Q1ywBccJiHV9VJF5degiXMO5LaNdaF/m6EcU5fd5c8X/MkgHsfF3S6HfcZt/w+dM
 ONeBYwG/JOsrx/bc4tDVGfla0MdOI6zPQLHBBOEaMni8I64FDPQRA8dDHTxknmFk
 9/vkpQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkusrstjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:46:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c12e43b98so3278191cf.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 01:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784882801; x=1785487601; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iS8LAd5P/peWCH0et4/K+GrM5SNZpyI++NDRKMgyQKY=;
 b=IOh7hajX8QOAi4lq54QQMvf+6lbWECbpJ3assA2O/iOzU9DeKb9w7mJw9MH7ezYRLr
 hoa4YytdjagBVY4DLOu/aUTrA41lzv75ixx6U2ASrWxvJ/WIuhQ6I5S9GUNfziZ9uSyB
 P/HEKyo6XUV3GsgAStELHRwLFHUw+KW9Y9zlzD8TeSQfdBq2ZkQ0U1yU5LgnHfbmR6LM
 /zfPzldzv7c7+keoY+UysKu7W4KTT3maJgd01vZGQku28N4lt5GrWULvjXqx3r14WWn4
 o9eO1uCmhdK9TM2/vSq3Fb0T8SfWF/ujoNIilAbyF/DKb+bhnpjwIBhVmj5j0gZvwmi6
 aQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784882801; x=1785487601;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iS8LAd5P/peWCH0et4/K+GrM5SNZpyI++NDRKMgyQKY=;
 b=A405l3KfA9DYbKlRwsVPxVKJZzXQ4eD6IwduHCpjmfPZ1F8FmBjStq4ZCm/i6WdXxZ
 PyD3hDGvNAKPxGQ0vGRRK4P1/evGzZE4EY2hpMjUyqpn5tNQAGH7ejLVI5ueR9m3xdUi
 6TwUuIqMVsSnTX65E8cDIaPPgjzZ8IGUka513Pcwl/luAPe42joLAf604XvhhjK8Io3Z
 HQNTH5DMK2PDL54LvrzI6DJSRyd/ouDdgvo+/CzOdBYM/Wkj64RPEd6nirQp8cTSRlnU
 eo1d9LaLUTy7zVeqLDDS3MIiFPoNzYC3148Y+GTPphgMRvdU4HYqTRf0emXpGEAerIxT
 q77Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9fe8++YT1DqWg/sX/F9ZKfj722QD14Ugfun4BnbBDf7pTRaV1jds4Hhm6jojwvicjjB5ZVSz8FEOa@nongnu.org
X-Gm-Message-State: AOJu0YytWENKmd3+Y8iAiBDTLYXmK0spEaeVj9IxQ+bUo76SvynuzY6l
 BSKEUAvZRWYpk8miwyJqkfysw+ydDWEY90ybJYPOj/Qn+RVeh+NN8ZCczp0fTs7wD1DUmwcLCOG
 uxO+OJBx/NKB7Vd/4Ewp+97h6rzewEq9spAhixfOlrOE8Q2nBXKwHEWFeiQ==
X-Gm-Gg: AR+sD10JLXiJIYiZfG7aIUnTf4MWnv7LpGmQGpetPxQaeSDROHUAiDev+CyT+a7yLLE
 /o23mvhXgYuTjBL2cP5lE/umSWOcnZhv6pzEn8tCdnB1J3vamjf1EoRii7dom+r7nhxrekeHvvI
 noSewNEKs3a1uDifBPDBHuicJECjW25DdYDvTqvQgiqe4Ujxmp6rFlGkx4j5AsMKokp8cmZbz0p
 qlKIAPKGZRqw+d23KqU+CwMrNTm+2f3cdyWA+YSQRSaMLdpQ7AZ/eIN7rzzsTNXyHL0/bo9ao/t
 sKMxrDhPRPtJDZnpyGBKUIlrH3ttFfKDfSp/6r+LvoMdHp7g49EZ9L5LJ8R/3+rVo6npzwy1HgU
 H56mEdXfYyBomIqhNWhQXJg==
X-Received: by 2002:a05:622a:2286:b0:51c:164b:b240 with SMTP id
 d75a77b69052e-5283ddb6b60mr63514401cf.4.1784882801229; 
 Fri, 24 Jul 2026 01:46:41 -0700 (PDT)
X-Received: by 2002:a05:622a:2286:b0:51c:164b:b240 with SMTP id
 d75a77b69052e-5283ddb6b60mr63514191cf.4.1784882800813; 
 Fri, 24 Jul 2026 01:46:40 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63678sm20743463f8f.29.2026.07.24.01.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 01:46:39 -0700 (PDT)
Message-ID: <566eb2de-dd66-44e3-b32e-db345381914a@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 10:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>
References: <20260715132652.1488991-1-clement.mathieu--drif@bull.com>
 <0d09f774-df0d-4f5f-90c0-055cf0cd7fc8@oss.qualcomm.com>
 <20260724042948-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724042948-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3OSBTYWx0ZWRfX22Nwkvmn7RWF
 +QxolHQnqMZybRiR3T4l5zZnT1tMWxYzLmQy1xxUXg+Ab+DD0loqKjoJHcqT4otgcdpouOf+zP5
 dVqQIF8zb8SLkV0V+t7gPlQS5uq42lk=
X-Proofpoint-ORIG-GUID: F-2RZzYtIS4NQZwCmLzPSB_Yb4pYNkrg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3OSBTYWx0ZWRfX672fqdjX7sWh
 bfdznjM02qANyiaY2CkM5aCxjW9Y2gqptvrs3xIS0xs0MZcHpyID9QYmdH8oax98AupEbMRRmus
 c9RWi0p84To9Gi6kHt2gz1laYhKlYkeD5D1OJSsyUeVzMM2wu3keKvq7jMHmfB4ZdzvmFC2DK4M
 rJ9pfmiJjzVoSAGIqOKR353zFM3YQmfP0xeTeVC8iWpdtozi6ZJ7tPb2wQlfAG19eIqQkKBO+IT
 SEPvHBU55BWz/7U/6qgKUBICCg43VFxBUn+OvV21XVrVaDxx4EEDh1xwHzRj6bfqy5xem1G7HgG
 H6TY9sptafveJterW13GbI1Ah8k+hxKIkminlLbeMYZd24YRkgHsHFBYpBk5qT21uHO+HXtHkFw
 gl/ZllKn5MeP67rNPEDOjWxxhy6BevJKqD1lUSX9d7lTOWkEEUTdjLLnY4oJTuTDPRXD6zfXUSF
 PBp00Y4Ihi7n7i1S1zA==
X-Authority-Analysis: v=2.4 cv=PtejqQM3 c=1 sm=1 tr=0 ts=6a632672 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=U0voX65BAAAA:8 a=EUspDBNiAAAA:8 a=zDVQJIeE05bxwBKUC4YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=JJL1M1PEHzQJUIl3X1yK:22
X-Proofpoint-GUID: F-2RZzYtIS4NQZwCmLzPSB_Yb4pYNkrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24/7/26 10:31, Michael S. Tsirkin wrote:
> On Fri, Jul 24, 2026 at 08:08:50AM +0200, Philippe Mathieu-Daudé wrote:
>> On 15/7/26 15:27, ClÃ©ment MATHIEU--DRIF wrote:
>>> Prevent a buggy driver to execute malformed invalidation operations.
>>>
>>> Add the same assert as in vtd_iotlb_page_invalidate.
>>>
>>> Link: https://gitlab.com/qemu-project/qemu/-/work_items/3619
>>> Fixes: 6ebe6cf2a066 ("intel_iommu: Process PASID-based iotlb invalidation")
>>> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
>>> ---
>>>    hw/i386/intel_iommu.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index bf4f0f2f6b..c591d1db3f 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -3021,6 +3021,8 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>>>    {
>>>        VTDIOTLBPageInvInfo info;
>>> +    assert(am <= VTD_MAMV);
>>> +
>>>        info.domain_id = domain_id;
>>>        info.pasid = pasid;
>>>        info.addr = addr;
>>> @@ -3060,6 +3062,13 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>>>        case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
>>>            am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
>>> +        if (am > VTD_MAMV) {
>>> +            error_report_once("%s: invalid piotlb inv desc: hi=0x%"PRIx64
>>> +                              ", lo=0x%"PRIx64" (am=%u > VTD_MAMV=%u)",
>>> +                              __func__, inv_desc->val[1], inv_desc->val[0],
>>> +                              am, (unsigned)VTD_MAMV);
>>
>> Better use the PRIu64 format instead of this surprising cast,
> 
> I think you mean %llu - PRIu64 is for uint64_t

Yes <:)

> 
>> anyway:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>
>>> +            return false;
>>> +        }
>>>            addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
>>>            vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
>>>                                       VTD_INV_DESC_PIOTLB_IH(inv_desc));
> 
> 


