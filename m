Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE066C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZ4A-0003ER-RR; Thu, 27 Aug 2026 08:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzZ49-0003E3-Cj
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:18:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzZ46-0001uZ-Mx
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:18:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCBNec3379789
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 12:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vM9WXoZspk+rVM2C8FVQGX0VGwXrzjayBRNIarztBRQ=; b=ndAnL8XVpSp9aN00
 L2fAnJCId8fsFjhqYnYfbMrKWY76cJ3t0nACa/9GYRZR19h0yGFGY3u3UCbZJiEu
 IcwVFA2Q9rN0ad32Y+W7Z3EZYa8d287pbf56I6ng3Alvim8VjIjBhyzauPoJWM48
 fN/rrCIl60ny2Sg9TRm6Y2VLbFh8rSnGwW2xzMyzrel0bRMcoxMlg4vGdSubEOkN
 S8dXG1Or4I0l+Hwy+bKDwVhy7x9g4i/Lwi5+VQrUqM9urxRgzZcv3pi5yPkHoch0
 cFazXM530H0xLsCQ3KfS/1UCoPrLq0VlL250+6fz86xIVmpQOpViwXhfkhE3z4Hi
 PHHI6A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7r5hr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 12:18:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e4f946461so198471485a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 05:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787833120; x=1788437920; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vM9WXoZspk+rVM2C8FVQGX0VGwXrzjayBRNIarztBRQ=;
 b=dATWntWDbyvJ7+PRLl78LVwRnVD5/sWa7HS7LdpU3BSGGVRigGnW0p9LYszDHbCrto
 +c+gPB+4pr9VrLvujAVWZtwK8qUVSpuxvs9qgNdxXSxOg4FqyXDPiKoxTjflmSbS4uM0
 YF0mP689QH196sIwZPJAXC35+qNPnH25Ud3iQy51Hf/OMIDhRZYFHcVcutU7k3EUKmwQ
 ph3XEABJYxh2GmjjsSteij0CzUXG2bxqtdkg9RKYl940UZ6z2n4/5Z5kQLNvxZW5Jc1q
 iEVbYcEsoMWZhZbfoT0YzoV6p58w7LUtF8wcg5oiuPT/ct/JTlpAXXTrwT+CVZ5Nbs2Y
 LE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787833120; x=1788437920;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vM9WXoZspk+rVM2C8FVQGX0VGwXrzjayBRNIarztBRQ=;
 b=b/TAYsXnOnZB6ZP0Q4TsAPAb42mbs5GorM9KkI4kR6mQD+BW/yxXRSod8+EAxh0obj
 p0SgsOGiA2xT9v7wlJ5QUVyh02L6yJy6CUTzet+CV7xhMwwEExElJETc6watGyr3jX7s
 1gIK0bVYL6bpkiQC7x4+IcUhalP6+w/HgcnWc1JBuTQ1+XSVlQhaSIFHxImWWSqg9jVD
 mYrPRSALNzKZopiiI0BrD5ndN1fMBno5IyfcQdOjwrC2hqBmqwmTrwk1vqOwi5iGS0rB
 UGBY5iX0myYbhAz2FMNSsLDcHLFJ/25lkmvz0gIgI/TLsPO1WgM+cdRzhclEgEW13AJH
 XTBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrU/2/vDWTLlQz2pzpEAU+TF33uD3+EnVR/xifK4jhNoOF8x63e9ybLO0ZmBHl44MoflfTke2tBUMLn@nongnu.org
X-Gm-Message-State: AFuF++mLpDVcm/1hXDWapk07h92jp740UcgHFHH22xyyMCCrHlqO/TqJ
 phCntjkTRYfm7QIcKEFhvRKLnTNLFgQbsaX2pdG/l4Mc8QgbN5lDAaq2Kat8GiB9f9bckw4gaFx
 95aDCfRiPrQ/RHVGhBLJG29WNmfkYbk7tHfHdvLVEQoY/VvupeL6gI6pJmg==
X-Gm-Gg: AR+sD12rZMekIYyaSjjn65hUnyYwHUQQzn/zFrq9x6b0G2ID3Dw/KSrS/udixContQ7
 HFvV6WI/cKyDcfWOVIM22qNM4igZQf+iv46POIZw8TWSJrowEddSl8/51+oN/t7XtgVVBAWFKxW
 r0YcXtpK9smuGWfoHSHWw5+a4QzPOiKIAaOnpqhbEDuXsPw/qILD89fhzOeG99PgxWQCnRfA1FO
 HZWMLwBGw7jSusamhYPDxQZVRVDO8j/bsrDAsor37Db/5CpOX3wMmSFmDULsuYejfNBRsVY+d4g
 BQxFl+5EYhvZrSUpvGS8A6Nlj87CVH5+GUdEehOjoSm+HY0jA8mOQcS737n0M30+f2+VkINvae5
 tFuwF1PwWqdU/3sRclJrys//qtwL7fBw/e1sj
X-Received: by 2002:a05:620a:7004:b0:938:39e7:725 with SMTP id
 af79cd13be357-93839e714bbmr906021585a.32.1787833119395; 
 Thu, 27 Aug 2026 05:18:39 -0700 (PDT)
X-Received: by 2002:a05:620a:7004:b0:938:39e7:725 with SMTP id
 af79cd13be357-93839e714bbmr906012685a.32.1787833118769; 
 Thu, 27 Aug 2026 05:18:38 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e616ed0sm428855285a.25.2026.08.27.05.18.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 05:18:38 -0700 (PDT)
Message-ID: <be675569-27ef-46cf-82bf-563852bbe66e@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 09:18:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] hw/riscv: Add property to hart to allow private
 memory
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>
Cc: Portia Stephens <portias@oss.tenstorrent.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826221154.54577-1-joel@jms.id.au>
 <20260826221154.54577-6-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826221154.54577-6-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwMSBTYWx0ZWRfX1C7jpxPpP8T+
 k+YZ99zXoAcBZz5YuvtPKxruhqBdMwzsp2byfya48mQHV4A0ni1ZeDZ8xZHsVubGt6lZ8NiI5D4
 S5Lecg0AGTcl67R0Le2FAaB05GcNPnN/6Ukf4MkcMIyx9FiXj15ZsOkWFyKDyyWdDaoogg3hver
 AO6AIMbUGKe/F+Y0N9TYv+Z+5+umsimFPOf72cxLK+WzV/njYu5q1EFAxl8ziu5Ize7n0LXzrRE
 KX+nKBSEFrjD2Hk67us2QkrLayh+WplgFjT+PemMGRPR6KcsToXj+Z6fhwpBFSIDIf2FtADPWCi
 6JqpVaUjQcULdhCMAOiCXCiGXLF2lQUM3Lh5xGYIMf2zk5qmUHFpN0ie8ei0bDFfS1K5Ftf8VCU
 9dD2xABqrxPWezjsfjgRuLXxVqGngdaZ0kqShtJsBuo/aFlNhXBvoiSBFUiWrGmWg1buOYxfQFV
 QAg3CGswUYIU6l00ACQ==
X-Proofpoint-GUID: vKFUyv7ZnF6w6EiWaEdpSgC9tNoxpHIJ
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a902b20 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=t9496tuAAAAA:8 a=EUspDBNiAAAA:8 a=fl7gSUuWqnDtph2dS9IA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-ORIG-GUID: vKFUyv7ZnF6w6EiWaEdpSgC9tNoxpHIJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwMSBTYWx0ZWRfX3PHxFOtp7Td4
 kDfXbRPK2xzuVMtCcY9Nd6dN08l2x3m0sPklJb8ycCaHNFVP9fmb5OlLLZQKRlcEDCVWuMBcqUM
 OPqE22cbdqJS3IGeGCdlghHTG9V+Pd8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270101
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 8/26/2026 7:11 PM, Joel Stanley wrote:
> From: Portia Stephens <portias@oss.tenstorrent.com>
> 
> There are platforms where CPUs have different mapping of system memory.
> The global system memory does not allow for this. This adds an optional
> property to assign a specific memory region to a hart. This allows for a
> machine to alias the hart's memory to system memory while the hart only
> views memory from its own memory region.

LGTM but please clarify in the commit msg that the memory region is being
assigned to the hart array, not "to a hart".  A hart is a single hardware
thread.

E.g.:

"(...) This adds an optional property to assign a specific memory region to the
  hart array. This allows for a machine to alias the array's memory to
  system memory while the array only views memory from its own memory region."


With the commit msg change:

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>



> 
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/riscv/riscv_hart.h | 2 ++
>   hw/riscv/riscv_hart.c         | 8 ++++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
> index 197fa1623115..c3cd05a2c877 100644
> --- a/include/hw/riscv/riscv_hart.h
> +++ b/include/hw/riscv/riscv_hart.h
> @@ -42,6 +42,8 @@ struct RISCVHartArrayState {
>       uint64_t *rnmi_irqvec;
>       uint32_t num_rnmi_excpvec;
>       uint64_t *rnmi_excpvec;
> +    /* Optional private memory region for use instead of system memory */
> +    MemoryRegion *memory;
>       RISCVCPU *harts;
>   };
>   
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 747754be6158..32fd39737ff6 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -53,6 +53,8 @@ static const Property riscv_harts_props[] = {
>       DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
>                         num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,
>                         uint64_t),
> +    DEFINE_PROP_LINK("memory", RISCVHartArrayState, memory,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>   };
>   
>   static void riscv_harts_cpu_reset(void *opaque)
> @@ -117,6 +119,12 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
>       object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
>       qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec);
>   
> +    /* Use private memory instead of system_memory if provided */
> +    if (s->memory) {
> +        object_property_set_link(OBJECT(&s->harts[idx]), "memory",
> +                                 OBJECT(s->memory), &error_abort);
> +    }
> +
>       if (s->harts[idx].cfg.ext_smrnmi) {
>           if (idx < s->num_rnmi_irqvec) {
>               qdev_prop_set_uint64(DEVICE(&s->harts[idx]),


