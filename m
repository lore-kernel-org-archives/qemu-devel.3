Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DB3C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn95g-0003Ax-VO; Fri, 24 Jul 2026 02:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn95e-000375-Pd
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:08:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn95c-00088y-Pt
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:08:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lMiL3139593
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TlmosNdSTGoDFEWX01+xe6c8koU0irNm8TVfnwvCTGE=; b=mFgIu/dnvX2XOi1s
 86nxbDeH3SYboZBB18WqS7zthjjqlSE9CiqjcErs41xMw1MnONJiQM2X6aXuh479
 CYJxKV88+tt4IoHqlY0YBGYhlV6+wUu4GGu04qCswlfVwOEXkKvTsDFlLs9Vj/7J
 Q0W2Sk3gAY7EgUrZ0ACgIsgls8cDl6e0+abZs7TrpVZnjh73AfPQKYx6eGcJ8JDG
 ZR+4NOoqXLHs+zYeokyFMmXq3u6L1IrQRcrFXFXTul1nYkGPAGOJJXQak3aWvYWY
 LLqD8Vymg+cx9u2JiwFh+XbMpnZGahfqZoDcFwLz9kHIo6GZGQuMCf7fqVYcKpMR
 Iwoo6g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkn9a327m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:08:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a97644aso1255941cf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784873333; x=1785478133; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TlmosNdSTGoDFEWX01+xe6c8koU0irNm8TVfnwvCTGE=;
 b=ECFW3NVzYDnuf+qZTDR9SfH4ADPChm15jUkjLUXMBujVqhG3JKtU2kXzNpgmuE8xcC
 nQFh/HvnoJBI/qm0Jm71uHtcqXy4AjIXV1zjRX5DVvxofCilfAXPTKFtjfsMt9MAPzj7
 cQ9wsirPeKsvRM3r/os4TfxbCcL5KDoToMVsOLuJY23ML6NJCoZEn5E2ngHcKgzlDQp4
 di3E9EbGx/fe+zIyE2BxjRMikQnvy5+o9AXF/LzoEsZ0pIX8LI45iasHq6XdJfQxztDs
 IR6bCDf3I+KYPAaFZqEr+qQEd5Bdrw0vr9fzkcABk5Oi9bww4bz9a8FqSRug2vU9h5Ky
 cTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784873333; x=1785478133;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TlmosNdSTGoDFEWX01+xe6c8koU0irNm8TVfnwvCTGE=;
 b=IohQxv/yC6jLMKEwqa2fajiieStJ1sFPYO0HJsnVo4DKtGE4fH2bKZ6OXjacr/sa7n
 bZrGtkhVKdCoXWYx0Khqa+31sAkqIA0ByqEEi831Q5N1Cq+Gg1hGOvYvmE2AoHHnPt2Z
 5+VChsycap727U47nssrALl8uNPblbOPtiFiy7TAysO+EeGni7LfFDptLuoJDkwjODGX
 pYi7lJzWJNoWbKUMRLdAchx1FBHtSI3ZWjYOvUGSmiRS4hzlhcopt84DTEvHO7a8qAWg
 NVvcZK0PN1QBveOci4M/GtWqMeoFhgXubleeEq2/Ie94tic1nCdJ/xaDovYk9z1+PFAe
 71Bg==
X-Forwarded-Encrypted: i=1;
 AHgh+RppUy2uwC6N71cGRyG0Yn9SfAPSkKW86j4P8LOMeJeymprCBmYSDRrQcQqPbgQ/tMxhHs+BipIroQ+H@nongnu.org
X-Gm-Message-State: AOJu0Yx+ub0vAd2X0wDlF+FxfIQM6cN5d1ouYD3mDJ1nBTXEySG4UgVQ
 x28JrGPBmhqa3hYtx0FLbuN7IzgE1JqRBrO0M6R2rvnKcJ5D/jA6Anyv3MbNZiQlsGfi1G5vrtc
 gmEZCum83jknW3FBahSG9qC50xJOEeyXd7LDAMVghlt41it4CBKT85JP6zQ==
X-Gm-Gg: AR+sD12cJnvyhmi068a92rtLl1cV2aaPni4eEHW+lCRwQ0bv8hB80HB6NU1vWNGnEw0
 s4lBBbw9v35lfB7jMZ3GS1hGmiIhrT7yoo3cfDFoynKKMx1UGcHyXSuz5EBddzsoOVGH9XZSzk0
 XuS4latLeGrArd2/a3TO+nX5iVFFh4oS6OkWvFSVlxuEA83DjedaBhoyaVaBSoNuIjVR7ExFNK8
 20WNFPHoN/QMGSrArkAN7e8y9prUJcvnyrc9e760DMi/9ldsd6CLNKz1uwfcsSEH9bSL5owwsat
 jWZRIClaxC9p5GDFxYmMbIBKBJtRF4Ygt9r4FqQyvl6BrDOlLNAP+YeIczR/8O29dFoeqalsKSJ
 7G2j5angcDlbajUZnX2kQsLlAfbI=
X-Received: by 2002:a05:622a:580c:b0:51a:8c9c:7f3e with SMTP id
 d75a77b69052e-5283df4fe14mr58042501cf.65.1784873333526; 
 Thu, 23 Jul 2026 23:08:53 -0700 (PDT)
X-Received: by 2002:a05:622a:580c:b0:51a:8c9c:7f3e with SMTP id
 d75a77b69052e-5283df4fe14mr58042261cf.65.1784873332962; 
 Thu, 23 Jul 2026 23:08:52 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af78845sm41730825e9.8.2026.07.23.23.08.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 23:08:52 -0700 (PDT)
Message-ID: <0d09f774-df0d-4f5f-90c0-055cf0cd7fc8@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 08:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
To: =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>
References: <20260715132652.1488991-1-clement.mathieu--drif@bull.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260715132652.1488991-1-clement.mathieu--drif@bull.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1NCBTYWx0ZWRfX6FWlIMWFkThO
 vnQsMlB3TnqiTcZjN6IOp9EOzz9TqCiszoyGx5tugFzYII4cDbSkA2G8UjXf2J5YP4Yc+b7JMxl
 JbLlOYUwNGriEBYrfiQJeHnHGeX1ki8ne5FWzHPtCGDvtpF7a9oYimcCWceA6AVaIo7ewRNFD2l
 ERBt5Pm9PsIkltLjYtOo6Q7S+ySTQirIvBOB8XEFJ3mH6W4hwvyfEDL6MNSCjrbzAuOGLRwtBJV
 0NqVg4iiPFnWwRCTrLUMalF5EMOlJ6IrMH9PgiHlMJpqu9moxBW19RIJL06OUc17DlRdXyXQVP5
 +XUgMm3yocsfKaBwo+de8TUixMUg/DFlJKYaPa60gw34YPIKBqF4r3vLZHryMuP7/lIXbZ6phD1
 arj6Y3DsVg7QCcMPPwzmVbmUugjJAR8g0gn31z5m3454jsE3jhC6FhV3Lo51BAffBf98nrqX9Ed
 ZSIOP8wOWLcG9A7xAOw==
X-Proofpoint-ORIG-GUID: fTl-KW1kV5mF0bOFO5hhJDGcBI2z-jth
X-Proofpoint-GUID: fTl-KW1kV5mF0bOFO5hhJDGcBI2z-jth
X-Authority-Analysis: v=2.4 cv=WOdPmHsR c=1 sm=1 tr=0 ts=6a630176 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=U0voX65BAAAA:8 a=EUspDBNiAAAA:8 a=3t8qKmVOWj_Ho-Xwr7gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=JJL1M1PEHzQJUIl3X1yK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1NCBTYWx0ZWRfXzS7EB4PwYSJ0
 S/c84lUFIp/apU14DDjX9xd1dQBwgAAPgdaYuSnqZjrgSGFW6oVQtCAlU7t1ZqtycrRoMCLEE+j
 of0XGJxJJE/cXlrkmRnjnQkZa3q3zCg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240054
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

On 15/7/26 15:27, ClÃ©ment MATHIEU--DRIF wrote:
> Prevent a buggy driver to execute malformed invalidation operations.
> 
> Add the same assert as in vtd_iotlb_page_invalidate.
> 
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/3619
> Fixes: 6ebe6cf2a066 ("intel_iommu: Process PASID-based iotlb invalidation")
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> ---
>   hw/i386/intel_iommu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index bf4f0f2f6b..c591d1db3f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3021,6 +3021,8 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>   {
>       VTDIOTLBPageInvInfo info;
>   
> +    assert(am <= VTD_MAMV);
> +
>       info.domain_id = domain_id;
>       info.pasid = pasid;
>       info.addr = addr;
> @@ -3060,6 +3062,13 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>   
>       case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
>           am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
> +        if (am > VTD_MAMV) {
> +            error_report_once("%s: invalid piotlb inv desc: hi=0x%"PRIx64
> +                              ", lo=0x%"PRIx64" (am=%u > VTD_MAMV=%u)",
> +                              __func__, inv_desc->val[1], inv_desc->val[0],
> +                              am, (unsigned)VTD_MAMV);

Better use the PRIu64 format instead of this surprising cast, anyway:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +            return false;
> +        }
>           addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
>           vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
>                                      VTD_INV_DESC_PIOTLB_IH(inv_desc));


