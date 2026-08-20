Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9575C5DF8C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxB8c-0000SV-E9; Thu, 20 Aug 2026 18:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxB8a-0000S4-H6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:21:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxB8Y-0001rx-UT
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:21:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK87a93492496
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HpUn5ZFuY5bpeJdQLOHBubxuC15YQRNurpu7Qj1klgY=; b=j1NrzsIuRUSd5Gjy
 o/V4S4SC7t61SRXaK1IwSRdYItHkVak/ig9gGeqAZKTRs923yZlM0e7+gq3MR1so
 8TkWK9de4T8myMKrNY2ooCZeuQ9V0dQHU1Xihv2XVRJMTvrPlYiaFFNba9pvO7Uk
 YcFSAX5LY8ZHYxt94Za+VHM6p4c6IwJScij5yaTcK899L8k8fkftbTFK37XZFNDj
 z0uXjIIY+BIfo+bzxhnSwx3qkPONxPvnyzCRmczcmD6uWbOletpodbUiwLI2WF+T
 vv4eJFt9Y/dDDCvSW81iP223fx3wioV+KRN9aOOjDr69Ilh8SvhxdASBUAQ/YHB6
 Nwn04A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ytcb42f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:21:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbeeaabcadfso463948a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787264485; x=1787869285; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HpUn5ZFuY5bpeJdQLOHBubxuC15YQRNurpu7Qj1klgY=;
 b=Gz/1YVSxejU0gGrkk5nEn63K/83nfTLl/4sKimxaDkFAjLOY0UmcuwuPuYKU1Cq1aH
 q9MI2FgCjnB3h3BMVGSwVs4w10GCtkh0EdXSydy1DJiP6uiyrIDwrLFpfS8QF6DJPmiN
 fJPdss/jMQK6Lo98sJQe2WIuevSBUQQG63sQ71Qz4bBVx6fIBiRumlQI76aXKMMmC2YN
 jl0dbLRK/5nZZc1XUW1qZDsO7ixt83LrDml7NotZtAggEBDrD9fgRWuv6IEFAXj0nSxH
 xTq9vx3UF6V6Gsj3VIlGuL9l4L+4HH+E6Oc6gKXLmcn6gaSml79qQGqkh8Ea/onJP1RC
 HjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787264485; x=1787869285;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HpUn5ZFuY5bpeJdQLOHBubxuC15YQRNurpu7Qj1klgY=;
 b=SsunpUjr46iN6+2D1aabHJwxMj//yo/Hot72rf+YyArJjYjvZ4eYddqjvkx/V2c+pa
 Lz4aEK/+Ua7OZmGiA81+eCv+QTgHG1+SU//RIGONoLrSz1luoyYWa4dBtApx4cXwPfmY
 qQlWAGOOQP8NrI1grvLUon/xDXXyWz8HxAbYMP9fB789QD/Q9NvIkfFChavL7lAiE8jU
 4tQjPT72G8GNhhS6okIKSH6CLtUIL17CWa24LPgf/ltl4w+KbECMX7H3ccawIZV5IbBD
 w63UMOzHvCdYmXZSHPoNjeqE9J3fer/0gp6SdQ+KHoTi/t7v/Z35mGM+t62FjHUbMYrU
 kvoQ==
X-Gm-Message-State: AOJu0YzSvuFaNeib3o6ZAc2jJenWDRruBnw9WUYpXQFht8CrRhpCX37g
 aUyN3PQT4aD0NPUyi6C8erq3FtMgTrBePPTPPgmnkfDfSdXISkVjbhrImGihes/VyJC1W79XmlW
 ulGSGARnnvbhM43ngnvnHqxUGxt7EIK+ePDJTxGX4K7XueMYpkPC5VOI7uQ==
X-Gm-Gg: AR+sD102KX/VM5gaAseQuZowHMB/15HHypjAgg/rwlovVViI35CSFDFCYgExyUkfzew
 KRA0jGOCNAwUCbEULySk1/X3kCzk2Uu7hswPleKFEY4nhwumFB9t3Thb7YVIB5zyMoi4HZuQfyq
 zn+IugcxqUU4zR/Awf3txq1vk8RPJBMLmhECRY4FnRyE++gNAQiosLfpUdBUYEZoQnEu2M+rh/+
 QS5a3L8LdpKW/We0UkqO9rnR6sXhAyS2zp3idORBfXNKpmpKTxPDLFmWH0P/IMQpz/Zy2S3gyVE
 ohB0H1Z0nahbr6i/hIksRsWD4/hp4k55gRBsjal1wkD9vne1fS9j1hh/oFTmEXvdskK/PswsTHL
 MK4cxSGOrKxl5xt7Ntm701MmNyfhkgqDTSDb6ne84m9E+thQ7g5wrUprmjh6/H6YYjSv9
X-Received: by 2002:a05:6a21:44c8:b0:3c3:6f6c:aa21 with SMTP id
 adf61e73a8af0-3cd2ff85523mr3026138637.11.1787264484760; 
 Thu, 20 Aug 2026 15:21:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:44c8:b0:3c3:6f6c:aa21 with SMTP id
 adf61e73a8af0-3cd2ff85523mr3026071637.11.1787264484305; 
 Thu, 20 Aug 2026 15:21:24 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327d6168e5bsm9389937eec.1.2026.08.20.15.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 15:21:23 -0700 (PDT)
Message-ID: <8fe0e211-fb10-42f4-b123-f7df80877fb8@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 15:21:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 12/28] hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-2-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260813162512.2807281-2-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OqZ/DS/t c=1 sm=1 tr=0 ts=6a877de5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=fgrLqfBXAAAA:8 a=EUspDBNiAAAA:8 a=cVFekQMtQZ8Ej4Tji20A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfX7L2Doe+GaBKf
 6bp1UfKquobe7ZA1BjEjaj8UersW5rHvmY9I/S/4SGrprsrrpDccCbSBT0tPU6SxgCy25tgky8i
 By0Ug3Z+beeliwwiMNZFHEquykV9NpsmgdcvZppxo0hi79dzme6ZfYrVxKExaDat/PLqPQd08dQ
 NBHcPZeoJiRrlJmKcr5+lis7AUHs2KrVIDsVN+ARzc7VajSe7nv0vpXfCVp4XhRM4n0FwKrORvO
 xI9nGTFPnYv1Cap8KhwbKKkspZAa4uKsuDcjCJbE33AndC/9mBhHs2zxhikP1eSpbVyrtrofb+0
 OvcHk5RbQYOw1UpWGQPF0grtl3I7+JQEN7cWznKsxbpSNe1URmV4sCotdXtbAot7FrL+KCt61TW
 jmm2L3IEM0mNbuvqbb6EfpEfwNFGOXdyZNYTHVPClkF2kunj/MSRr+TosZmIkA34svBVmks3n/q
 a7FoUzHtHbypWuegZew==
X-Proofpoint-ORIG-GUID: HWvgAC8Ab8_cLFj4-Ic9PoScJ5TrsDyR
X-Proofpoint-GUID: HWvgAC8Ab8_cLFj4-Ic9PoScJ5TrsDyR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfXyvQjZB6NC4dG
 rynZ05NzniSptFr302H1mVFyToMg3b1DYLG6RFECIyhGIOpzIXtppRgIO1v4wonh9xqjtVApGS7
 s3V48HaEW/rmQA0KgEkOtavheY/ob4M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200166
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 8/13/2026 9:25 AM, Tao Tang wrote:
> To prevent aliasing between translations controlled through the Secure and
> Non-secure programming interfaces, the IOTLB lookup key must incorporate
> SEC_SID.
> 
> This commit:
> - expands SMMUIOTLBKey with SEC_SID field for cache key differentiation
> - extends SMMUIOTLBPageInvInfo with SEC_SID for invalidation filtering
> - updates all IOTLB invalidation helpers (smmu_iotlb_inv_iova,
>   smmu_iotlb_inv_ipa, smmu_iotlb_inv_asid_vmid, smmu_iotlb_inv_vmid,
>   smmu_iotlb_inv_vmid_s1) to accept and filter by SEC_SID
> - plumbs SEC_SID through smmuv3_range_inval for TLB invalidation
> - enhances trace events to include SEC_SID for better debugging
> 
> This ensures that IOTLB entries decoded through the Secure and Non-secure
> programming interfaces are distinct, preventing cache aliasing across
> SEC_SID namespaces.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         | 110 +++++++++++++++++++++++------------
>  hw/arm/smmu-internal.h       |   2 +
>  hw/arm/smmuv3.c              |  47 ++++++++++-----
>  hw/arm/trace-events          |  20 +++----
>  include/hw/arm/smmu-common.h |  32 +++++++---
>  5 files changed, 140 insertions(+), 71 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


