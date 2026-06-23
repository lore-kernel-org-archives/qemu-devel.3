Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893CDCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbynE-0004iU-A7; Tue, 23 Jun 2026 06:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbynC-0004hv-Qo
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:55:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbynA-0005Bk-TT
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:55:46 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NAsdlj3664027
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RdECwY0xKKMkzCz7disWb4/fR2mJrktDo7+b+W5iFXQ=; b=gawnZpEG8pDUJ1el
 N8vizmSMMTgyaI3yiSWhb+kcBIakLmVW6JuIlS0GsLsRCvFsVVJH6P7RCORfU/rU
 WXXO7TnAPGuWk/NPpebAgeAE3H7vxivTVIgMJGmSc6YlSig/eysAmq2LHiVAQsGw
 4weZX3GA0psfKgJxnKFvFbqVtDNfWKZUPVDIK6eBxLM/AB2zJrYBp2qpOOxMhDd4
 2Qbray8Fnt856WV/9h9NLgI1ST/C1uXNxYqB5Mus5lwwzW0FK+jKnRaitj86fojp
 egY4jpl2UPblOp+KSajzxEe0JAL7qlC15q59DdDeq+7cdSPW4+eFFAzgZHZnY5xV
 yFhJow==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29gs7u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:55:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92229624a71so596167485a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 03:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782212141; x=1782816941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RdECwY0xKKMkzCz7disWb4/fR2mJrktDo7+b+W5iFXQ=;
 b=AkMYCS+NH2MVO/gsKH+FEV90kg5CSnrR1wgSN2pOfmLVqzzdyVgkIbQuNzejhcSXsG
 1qRpUq+angJIOlVNw9C5BNe4MUvwTXrvXwj+tzDxfq5eSZfSfbg4KkG+1setW2V4IfMe
 1cWP/835zXOWLdxhNUbgzN0fSGWIKtEJxasrtXMhe6jQCyYy4oykfrgL1+j5N+t1M2FZ
 v/sMwLFnoBqu9l8FZ8x8f5vSQZkkls9G9LbIzHoCKteNtHeFmE0+zLRCUNC6vNeLSmeG
 7WNjFSEv1XHUTZOqKd8ZxpXAJ/gnQdq4iykgoq6u6uYBvR44NDA+RWhCkrwGD6EZP36T
 usIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782212141; x=1782816941;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RdECwY0xKKMkzCz7disWb4/fR2mJrktDo7+b+W5iFXQ=;
 b=lCnX/y+n39Zhg81V5/N4kAoaozCFtX+Tz+Lx8R++8IDoMtw+7w0EYWmr0utnT3mALO
 g8vwS51tiuAl/l0h94sZbxyNLJhh1aaAsy0TgFAyEnEvnTRIvwWPlyi6L7Y4KWz7Fil2
 UuFHNC0SFJKjJkA1B9IJ3R9gCZXrHtc9nLli6clAaL7owzxEuZMuWnLs68yuvrC4Qj7T
 osTd62by3ecmb7AQlG9Gp6r5G8BtP9sdjXMHspgwd8OZ846TK2c7FffsEaQuX9t+6S1c
 MiyxFNKveK3B74tpvClueLCKU9Hv51vIhxOmoalThbxGy/DFHAQgIIIMN2VT7KDhNHLM
 nTKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JPVPE6G+I6fITta6TQ6spPZqIPKWpUVrIXwmU1+fZ4S7ybK8jj+iEpjD5diC8Lsp12bj/m73aexcR@nongnu.org
X-Gm-Message-State: AOJu0Yxnd3e4wEXEpyfs2C+zdXDnDBXLnMMegyP993g5BpCW9tYFtWJY
 apIk2jIdKyJhfdEfEJN40YPvekc6xgv4bE++JfkCDs7ig5dyU0f3GmdL7twetB9zPOMp92MNFe4
 6opeRUXYS7z+Xj6k9/nlZECxUhJZeVpULTe1ExCcAlOJRomZgJYeQwAiQTQ==
X-Gm-Gg: AfdE7cmoODd6LJeqGEDoed2EVdmegXXhCmvBnovuIn93q6kOypvlXlcayWCZRN+qMSu
 CvsaYGxzwDkLlw7e2/Bzgf9ZQnoUXN+Ya/WiWg/yQgL1nxo8E4DLplGDdUI3hUq0kJY6DCn/t23
 GiU81lqR7q7E6o6FcrhGCGZSSgMGno/kABfH9+V9KzUAbnVDJ7EOcuoFeq++w+7da1UNr/4o1jl
 WB3myHcRUSBM710325jEI8TD+VdWr+a3pm3L76HCSZPlCeALP4FB8OI3pcgA1gKn2tKydPmMQ8L
 qcQ55SL5zGUjaSO8xD2YgI1xDNcHAXt6AnHueWS22M3w8hTKeJIYFw97AdFrSuc9S55lvmbRIQT
 IZcSmB5sZxVH7/gN+6QdBnriZEvPMEJM=
X-Received: by 2002:a05:620a:4054:b0:915:9125:e652 with SMTP id
 af79cd13be357-9266994e77emr328438985a.48.1782212141549; 
 Tue, 23 Jun 2026 03:55:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4054:b0:915:9125:e652 with SMTP id
 af79cd13be357-9266994e77emr328435785a.48.1782212141021; 
 Tue, 23 Jun 2026 03:55:41 -0700 (PDT)
Received: from [192.168.69.212] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4666678828dsm34010336f8f.19.2026.06.23.03.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 03:55:40 -0700 (PDT)
Message-ID: <582f27d5-71fd-454d-9bb6-6c2cab574651@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 12:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 016/106] intel_iommu_accel: Handle PASID entry addition for
 pc_inv_dsc request
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1781463125.git.mst@redhat.com>
 <c93b82e7dde2e9c26ab743e80d19050bde988fdf.1781463125.git.mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <c93b82e7dde2e9c26ab743e80d19050bde988fdf.1781463125.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3a662e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=XIN_EfHa7MY0Yi_rO-4A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: wOqWknN4rzKWoCidlcAbrL85bDIQ67Tr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4OSBTYWx0ZWRfX6IHMqWXGab6V
 wPT8n8d5eY7Q71HVYtZ13cgIk0ZtF7Eey149Q1+W/a88BQ0zS8L0PhvogvBEf22veth6F4et1xD
 GBKGRgAGajDZzS/QevS7iTB9zoRU/FE=
X-Proofpoint-ORIG-GUID: wOqWknN4rzKWoCidlcAbrL85bDIQ67Tr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4OSBTYWx0ZWRfXwIK2eI1AV0Ri
 x2iOUJ9awPJyloUBtl4AbG2T8G97lFQgBi4JvjQjJc+wPCwvxSl4hni9gyscOWtCegHdDRjKbYN
 KgWzhy2vXFxmi+HZKebkq39FD3v3Oc1SXtl2Dt7rWXPv2WTqlk265hBstWum9m3oTmuN7qoWt32
 SQdFqvv8W4uiH9qgSw5gPMGvA+ouQRSLp7d+f+oormjpLhm6qzVaeABPnstatTwiMvkjbe/LGyz
 eccpw4wl4UL2W/gdvPUzeDw/19uIalHJGeC0yE4Hn7qUi5XEYjv/JgAiaWzl0/eBLs5y1KDZSjp
 WUuboIJCj3/YbHasvuW6RzFVwJz81lEFAmmGSz5YnUiCtlwflNTQ8V/hvk2uxqpXSdNEArZC3Q5
 qYwT99zHT3MGJvA0PFlJu5ungyZUsKBQCThPMnleddxn4JJCUb5VCwxL6OGS8sw3YgeBAiMx95k
 7uYZf0pwo7XQ65rHItg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230089
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Hi,

On 14/6/26 21:06, Michael S. Tsirkin wrote:
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Structure VTDAddressSpace includes some elements suitable for emulated
> device and passthrough device without PASID, e.g., address space,
> different memory regions, etc, it is also protected by vtd iommu lock,
> all these are useless and become a burden for passthrough device with
> PASID.
> 
> When there are lots of PASIDs used in one device, the AS and MRs are
> all registered to memory core and impact the whole system performance.
> 
> So instead of using VTDAddressSpace to cache pasid entry for each pasid
> of a passthrough device, we define a light weight structure
> VTDAccelPASIDCacheEntry with only necessary elements for each pasid. We
> will use this struct as a parameter to conduct binding/unbinding to
> nested hwpt and to record the current bound nested hwpt. It's also
> designed to support IOMMU_NO_PASID.
> 
> VTDAccelPASIDCacheEntry is designed to only be used in intel_iommu_accel.c,
> similarly VTDPASIDCacheEntry should only be used in hw/i386/intel_iommu.c
> 
> When guest creates new PASID entries, QEMU will capture the pc_inv_dsc
> (pasid cache invalidation) request, walk through each pasid in each
> passthrough device for valid pasid entries, create a new
> VTDAccelPASIDCacheEntry if not existing yet.
> 
> IOMMU_NO_PASID of passthrough device still need to register MRs in case
> guest does not operate in scalable mode. So for IOMMU_NO_PASID, we have
> both VTDPASIDCacheEntry and VTDAccelPASIDCacheEntry.
> 
> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-Id: <20260527054658.1021096-12-zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c          |   3 +
>   hw/i386/intel_iommu_accel.c    | 156 +++++++++++++++++++++++++++++++++
>   hw/i386/intel_iommu_accel.h    |  13 +++
>   hw/i386/intel_iommu_internal.h |   8 ++
>   4 files changed, 180 insertions(+)

Michael, please setup scripts/git.orderfile ;)

> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index e5f0b077b4..c9b1823745 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -12,6 +12,13 @@
>   #define HW_I386_INTEL_IOMMU_ACCEL_H
>   #include CONFIG_DEVICES
>   
> +typedef struct VTDAccelPASIDCacheEntry {
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    VTDPASIDEntry pasid_entry;
> +    uint32_t pasid;
> +    QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
> +} VTDAccelPASIDCacheEntry;

Zhenzhong, this structure should be declared ...

>   #ifdef CONFIG_VTD_ACCEL

... after this guard.

>   bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                             Error **errp);
> @@ -20,6 +27,7 @@ bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
>   void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                                         uint32_t pasid, hwaddr addr,
>                                         uint64_t npages, bool ih);
> +void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
>   void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
>   #else
>   static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
> @@ -49,6 +57,11 @@ static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
>   {
>   }
>   
> +static inline void vtd_accel_pasid_cache_sync(IntelIOMMUState *s,
> +                                              VTDPASIDCacheInfo *pc_info)
> +{
> +}
> +
>   static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
>   {
>   }

