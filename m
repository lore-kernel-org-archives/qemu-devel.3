Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39709FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABWz-0008Kj-Fj; Tue, 07 Apr 2026 14:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wABTp-0002eY-LJ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wA2te-0003Md-72
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 05:38:59 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376r4lX1584991
 for <qemu-devel@nongnu.org>; Tue, 7 Apr 2026 09:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WxskF6LO3XCdZZOnO3IbldOfc27E8D+GDM32DgLltss=; b=QjgoTHXNks5YzPCo
 TwDKq2GhGe4hP9lwhHAqKnYxHMmef6DKqj8jx4aZGONabrq2+Dt2/XcgOyPEfe7w
 rH2VAyQg3wVt4M6xjLObgEaJzigS3SUkan6PL5S/XsMrpMg0tjFJ4iL/fm1CjAZm
 ZCqaZg5Q8h0luclDz/h1dj61wvDGsyVwitL0Jz4Plt7HsffxoMvzuzpdiFkyTaJS
 6+Q5kNDgrbc2GhgtOZFYGYIL2oMxB+YeO6qT4ikHWl/5zTjmt8UkWAxbcFfAr/E8
 FDcltS9j52o6hSFME2hwt3DZCtibNxMBD+c/S7toYMf2DKmRKQqf6/ji/ce4B9U4
 94119g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr9t3kh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 09:38:56 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12737f276a2so7666340c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554736; x=1776159536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WxskF6LO3XCdZZOnO3IbldOfc27E8D+GDM32DgLltss=;
 b=QDN3aaENor3hiz4VRWI2pjBdV0p5rGG4tY+wmb+SbqnF7gzpW1juStEL0u5EG1+cYe
 TuBH8YzWF7pYOKAuYVG1tfge5X8R3BKNfMzRhzW6/d5vn0FmRUIj78DmpuSI/8L6CGRp
 vDA7v2cIL84d5Rj9Enkjupu3brIFdUFnfUlUkTW+Ez36unnF25QVwIZlPJJaOqI1iSvI
 AivWmMkE+REZ+bk3b8Ch0CaKkXa1llPRU/AQt7DxE8n5xIZNBwrNpuzTP2AnWmrgOhGy
 JSG3pXfv5dqdB8ZyTutDe4pfrffI8sK1Ujlxhmv+frYK3yapB0pQQxaClui6Z+2jk0Cw
 fOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554736; x=1776159536;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WxskF6LO3XCdZZOnO3IbldOfc27E8D+GDM32DgLltss=;
 b=PqN58Pzqqo9mR92b/sdE+MXeiQykY/04tOtisKqHqePSIm7tt5jBi4KYnyCYyE/M5P
 n/SW/zQaA/GoNCr7Nz7NujqSUUaGAdyqfe9Bd7tuOz/wRUs8PdJZMdKOi2nWWnJFAp5D
 +JqSdKhjWPKk7YLUek0oT3IAEHhjkxm9KWMcUxmvADJEPO7MHpbW50hAgiU1XuUhzgUD
 nHZfk761SDAG4O+Mom+dTiFGIPBiOOWLRxTV8kvQIYavc2LpMQsfCRJTPUaXpnyZ5Ucu
 8qrOppAloGzVtmyDcf3qVcJCzqLqeo5vu/Vxpu3Pt4UJDIZEoUf3D3+XYWIQQ55U+iCo
 DU4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/Zv74yma1281ExOfL2L4SLTXP/bFANHV6BxdtzaCI8nFvqIptzgDl0W+y4+/vdrn57y5toZAmfTHq@nongnu.org
X-Gm-Message-State: AOJu0YwaNPZbr39eZzeNJu/Nsi08vHZYMhfAQhElDdLJFDG/oQLvnJB9
 bK6IgL8HXHK+vIfNnc1y6Fdc0mhMUyswnMN5SVnARIbtlE5XpiwKGe92TpgGvk6Bk7SYzWwTP8h
 S+TFJfqmlTjGae5RL/jCUXp3BLYbJiJcoojybkvCypgwWx62fqZvBUyy1kA==
X-Gm-Gg: AeBDietjzu57CoWHgW+Lzc/sW4kU66ZonZhgcbP+GkQhHEnnKlR55NZl2STI3uzNnHT
 IMzdGvMGHxIJurcXbrnfnDnk4eixs9pCercArkZuK7HDkTDjYHetJoQAErXHdtqgDakekYikSTs
 RvWncdPiQ2g/+bi0mpmaWsQK5pMUJszLgALrSfCA79Ry8GrnbVqnZPZn5DQJX0gart3rP++siJ5
 jZjGU6Hi88OiJKKR4Exc36P80wYL3UNz0HMD2ctdLbrUzLbs1CM88wWhwb35tceUvQxYCuztYdO
 j60/j58Jp2BUgVQULlNEB7Rpe8KXPC5O3WuD+5pezxCXrPnICVaSMQNFEUtjoBgcrNu9fDaHvMN
 GJpl2WDM1iUIEP5WrALX5KypFjD2opZMtl5lnFxlI9YXZqRzHVUXdAyNY
X-Received: by 2002:a05:7022:6199:b0:11d:c22e:a131 with SMTP id
 a92af1059eb24-12bfb6edfbbmr7446330c88.3.1775554735949; 
 Tue, 07 Apr 2026 02:38:55 -0700 (PDT)
X-Received: by 2002:a05:7022:6199:b0:11d:c22e:a131 with SMTP id
 a92af1059eb24-12bfb6edfbbmr7446300c88.3.1775554735278; 
 Tue, 07 Apr 2026 02:38:55 -0700 (PDT)
Received: from [192.168.68.100] ([177.18.66.130])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bed93f861sm19353556c88.0.2026.04.07.02.38.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 02:38:54 -0700 (PDT)
Message-ID: <9ae5a77f-38a4-4067-9a16-9493774158fb@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 06:38:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] linux-user/strace: Add a wrapper for read and write
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-3-alistair.francis@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260407043614.372871-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SMdykuvH c=1 sm=1 tr=0 ts=69d4d0b0 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Wg2i10Q8swPuJs8jTFC2sw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8
 a=H3as2Lr20vdLQCbXi_cA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4OCBTYWx0ZWRfX3i35v9merA7N
 HYSISPIqPqkZ8kdq+LE72HQi7znbWQzqDtvQSjwwIbW5uTPZfdB54oLN7apDX9iVtEeg9Nwv4NZ
 ZjHm+asETT8Mign+sn8u6sUHnXCdoAYLz09JWSKrpPUCKzDKSBjKgh14o0hOatLxCmQl4Q50sQq
 dqa4wHTIxcJNkBWtaLgwzWDT/4e/TADoWRY0s4carCEusdHXJhXiFvn4RuxD4dSOUhcE7hn1iyf
 bgqxO8LCFlY/8uFRGpojptah3E9gCM7pTwmf1Y9vb+tLNMo7EDeX41h/TjuDOYBuYW5teOWBftg
 gHUEOAzeMjto5mtIF10MwZ0a3JbuOOeGrHm7rGJEO3WDFVcWjSQBZEo0AWD5URpAk9oiO28rTly
 UaRW8k5b4nT0yzaXJ0zHschGsfBwQDqfTvwEH+qBGSjN4Aqo9KppPDmhShOUprc+o8SgLsg3XI3
 5nwqol4btAj6vckGbYw==
X-Proofpoint-GUID: WmrJX87ZCDa_y87QhrhcLI4SHzWvM519
X-Proofpoint-ORIG-GUID: WmrJX87ZCDa_y87QhrhcLI4SHzWvM519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 4/7/2026 1:36 AM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The stack pointer is being truncated as 32-bits for qemu-riscv64, so
> let's add a print_read_write helper that ensures all of the bits are
> printed.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3238
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


>   linux-user/strace.c    | 14 ++++++++++++++
>   linux-user/strace.list |  4 ++--
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 2cbaf94c89..023173857b 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -4309,6 +4309,20 @@ print_tgkill(CPUArchState *cpu_env, const struct syscallname *name,
>   }
>   #endif
>   
> +#if defined(TARGET_NR_read) || defined(TARGET_NR_write)
> +static void
> +print_read_write(CPUArchState *cpu_env, const struct syscallname *name,
> +        abi_long arg0, abi_long arg1, abi_long arg2,
> +        abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);
> +    print_pointer(arg1, 0);
> +    print_raw_param("%d", arg2, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>   #if defined(TARGET_NR_pread64) || defined(TARGET_NR_pwrite64)
>   static void
>   print_pread64(CPUArchState *cpu_env, const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 35f001fecd..239b9e18b4 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1114,7 +1114,7 @@
>   { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_read
> -{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
> +{ TARGET_NR_read, "read" , NULL, print_read_write, NULL },
>   #endif
>   #ifdef TARGET_NR_readahead
>   { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
> @@ -1674,7 +1674,7 @@
>                        print_syscall_ret_waitpid },
>   #endif
>   #ifdef TARGET_NR_write
> -{ TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
> +{ TARGET_NR_write, "write" , NULL, print_read_write, NULL },
>   #endif
>   #ifdef TARGET_NR_writev
>   { TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },


