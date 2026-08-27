Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB7FC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzW2x-00050K-A4; Thu, 27 Aug 2026 05:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzW2v-0004zr-JA
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:05:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzW2t-0003eo-RB
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:05:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6RNlI088541
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lu8eda5DXtuIC41BqAWcaA1SZrGs5Vgu5GNoflxcgP8=; b=Wo6m/mopxeb34VjE
 +ZractZgcDt30ggyk0a/PBIlTCtl3ly3tdwRPZU4Rph0X7nG/TX9a/fRFfTI/Ytp
 QOcUWkgTyCi/jH5OwBTkW+G6KIfl+F+NzhYotT3XJd0F+3FZPKNpZzC+IPPswGsL
 jo1n1ou2pX10QnJqN7iCX2YQqHfZMwo4+QGtJRnErpPjLqBel7RB4BgbwoxnZJVW
 5ds1C2z3YaWS80DwnkIC+SqVKvIf0/jJLER7Pt1cP8Cj4QwpYO6JBjR128PeKh9Q
 EZgCzEygJOit1DcRNr1yFQFMXOt0C9XoafxzHWAEsAJL2H9WJVC/0F1PGBRBiLCl
 ld6cIg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5hyd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:05:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52827090cc5so8779841cf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787821513; x=1788426313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lu8eda5DXtuIC41BqAWcaA1SZrGs5Vgu5GNoflxcgP8=;
 b=RmZJa4c82OGHlhymfoFhusUL0xcVWC0G9cEx0U2r3Y8ThLqHGVgBLu+mVMwBsLVaWD
 VgRxxGt1s9ANaYUEAo0AUK4vCqMyl6Z/Wox3F8PHJUDRsHFIYnFID2VMqpraRJk5ViM0
 RPS5fDn3YXQZhXLDAW3soXD6u47mMviInKRi0RAuQbPMY0CFAGig1u3qQEU4pZkLwE/5
 BrEwfT+a4sUqAeuZOYpyh2iytvRmm3aNBuDcbB3/7jIw8Ckg11VkJUEoobVLJTchfoDp
 Yx/QjbBv+KoK/hq7vTDh+WjgIahyeiC63j7aS56BjiNzSoU1XAJLYYhCHmpjUbMNNHWF
 gw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787821513; x=1788426313;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lu8eda5DXtuIC41BqAWcaA1SZrGs5Vgu5GNoflxcgP8=;
 b=AmXVjxs9VCZfyKotl2nusbSzYyxxGfBu0fRzALjMtbjNTNF7D8xi8k0Jazz45EdmyH
 2Js37TLUjdaXj4BQ0x/DFkP/DFQPcbwSMeY1xY0lgHG/yW7yF0Rz6kMySGsapWvGgz5u
 Js9aKC9Hyu7cLlN080gV6uE1SuwHb/TPByT7EBiuPabT7z2G9Z0GX6CKWFXvKVC3FcTx
 2tdVb9KexVgoe66fQVbbu2L5CFfekZ8Ty7K6AeF7EbaK5doQQgZWTvu5ICZ9DF+xA/G1
 DG6rFVf2aeofGx88zA1qA1ZnJdRcr375+Ak/vjZC5TGgFhWIVov9p6iRWrQiGHJVn6O6
 Zy9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYwzkd6OEmyikxvNEo6nm8IheD/93/BDXPFHYD8qJrOnFjf07izcPryx+Pn2qRnKSrkuEbfQ+r90KF@nongnu.org
X-Gm-Message-State: AFuF++nBgzmoHXDp8T7XiORHsREuTWKmXaa1c9+Fi6ow1Sfo3b5QdAeB
 vR4KbLLVFZmQHjTfC1abFbz/e9E8kmQ5pdFroqc332h3MbhTyvjvEQjc+sIh8uYtJ0aT9pYdqdd
 q4u1zsvGcpi/1wVUucfxsu76WxrVRhidX2//mpMZNNVChoN+CP+hz+yT6Fn7uiVKovw==
X-Gm-Gg: AR+sD131DHa/ZuCOoisQR/gU/w1+d4iXztvoWO/KfjLUtD0GC/eKanuCG+xranb1amz
 ESZz/HkFwKQH7vM580F9GcAmn9SI6s/CzLMI03SKb2+YAkxHnS+SOGW2nEB/5UAcrP7DH/16/Tc
 bqu/sdzVuc/MQ97u9qSifSaYQoSpZVbQTi/5kPIUL9/uhnb/pLOq3rsH0KC8Pm3keRMsMyfNs0d
 Dtvyvi7YZQrmI85l16FGS+cw2HWu4CUYgVKR54gKH1XRsrhWKC4Fn+grXAtruji4x6TgiHhlU7l
 lcFXalMtHOZcO6M9xE8jJpdAEXCEqRc+t5KiZOj44GZ4nEC1tp5Wi33naCHjr1mHdQ4G09tIAJX
 0TzIsGD84w/axnX64pP9b669uWhVMJ62Tw6Lyvhz5RYtvgj1h
X-Received: by 2002:a05:622a:4291:b0:52d:9cfa:663c with SMTP id
 d75a77b69052e-52fa185dc9amr55912061cf.0.1787821513443; 
 Thu, 27 Aug 2026 02:05:13 -0700 (PDT)
X-Received: by 2002:a05:622a:4291:b0:52d:9cfa:663c with SMTP id
 d75a77b69052e-52fa185dc9amr55911691cf.0.1787821512947; 
 Thu, 27 Aug 2026 02:05:12 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e279ec3esm7790116f8f.3.2026.08.27.02.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 02:05:12 -0700 (PDT)
Message-ID: <bdd7d788-5f73-42c4-b6b0-b189c35b8402@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 11:05:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/vapic: unref MemoryRegion if
 vapic_map_rom_writable fails
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260826181552.848617-1-pbonzini@redhat.com>
 <20260826181552.848617-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826181552.848617-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -gd3nrpkcZq7tK0fPsvsHfdhteJCM72p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3NCBTYWx0ZWRfX1mnxoBMhtSNc
 mfzxnRs4Bqp0rlVCRvWTlhqkLL6oZSawtuSGcOLABXsqw7NZSS0wqPyBZ3w4wU5y66IM52h017W
 eT1tBctyY+wHT5W6m1KUAbl5K+LzcEw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3NCBTYWx0ZWRfX95i8NcVIhQAl
 +igpsRF10buY8GVZj2VYbDlxqxctwMqT9a01P5/cgijk1rLEVCTw2JAAQkWfOhdk6NfORW+yON6
 Li9gEYtzIXZIrTVl2UFa1n7yA+SW1oD4e51qv6S/MWbt7njvsS11UdxlZaMpqR1K3gLEM2qaSVe
 R99iZmy6U5g5C3tXpFlUUmXuUJrBkUGPvuAMcx/HYPYcrJAj96PUn0aWLmpE4fu+E7MV/r7Fyi9
 1iypdNINChl7dHDFUTjVwQBCpy6gvLR0minmnum9MYD62dru+L4Y4V3D6RqsW7cCaiv/T3pBuLV
 UwnR7sWmq5QE04KvMMcBGDBJaLSvuT4AEF96uNmr9+f01LHcdW9WIwpkA7b/D5kloMJJyf4VnGQ
 hUWHZ5qui3o6Sh+eS+xLW5uUWBaSuyelTGn64XLgHQUaAZ3WNFMeYT4Ctk95lzbLK+c+Lnbxfoy
 l4OmuTI6Oqo+VxgFyHA==
X-Proofpoint-GUID: -gd3nrpkcZq7tK0fPsvsHfdhteJCM72p
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a8ffdca cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=j_WgXOFb61mMXyCt7JIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270074
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

On 26/8/26 20:15, Paolo Bonzini wrote:
> memory_region_find returns the memory region with an elevated
> reference count.  Drop the reference count also if the memory
> region cannot be mapped writable.

Maybe another one in kvm_get_xen_state().

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/i386/vapic.c | 2 ++
>   1 file changed, 2 insertions(+)

