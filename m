Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63898C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkM1j-00041Q-KT; Thu, 16 Jul 2026 09:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkM1h-000414-UY
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:21:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkM1f-0004jX-Vi
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:21:21 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDJsk92734773
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 13:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y0MCf5pW4xNNdIkgT1T1KQEaBjldhwFlgVHv9j2llvE=; b=phTpw5g3+KdocmP9
 dpkAKYIR8A2KlMx2adDlmMM3um+ZbuNLxlekKmFiA8MvKYgFAz9FA7tyQyQ8fY3m
 pNBIGJVkbT4Btga1aPkIBMToy+CE0XDX+uiXUDugv+MBBLkSnPEvlbNaBYTwjf0L
 gjgvOBqdfDmK8h7eZCnKY7+ua/wSyidww7Coj120M/awrjctm9QIvOO0PknQ0NI5
 oTTF226Y7sdYgCMC7n3hUhaQLynsiUK71SuvMtDo5HFsSwjnq4v2PhToniuOVMgd
 FkFOl6N+ERft5ViAeROt7GPNk4PpNpLoETzT5rfErfGeaOX6Akiz8SwX+3k4sxpe
 apvxYg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv0y6w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 13:21:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso129771011cf.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784208078; x=1784812878; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y0MCf5pW4xNNdIkgT1T1KQEaBjldhwFlgVHv9j2llvE=;
 b=XjqOFRwlKPNuytCeE57GYFkqr+NpGFA4YaRGOpgTFEIgzuYpwqabfA5EA8jeVDvP+m
 VtSaDdCkyHs7lZvqZNp8KaIomy9A5Cbz38X04U8b+J8WPRR8Ros3h8OEj1ti5YcfmjRx
 7LAJAj56avTooJkbbMS4kHCDdE1sE09tcu91Hogu8rJ94p5+mmtzfzjNjJdNtvq1r5Jw
 r/dLEB16TbMYdtqTCvt+DnIio78fyr8IVw3XOkzO/392IMsyB3Bdsn6M1LI09K4pReAK
 KktTfP0uL37r7BZ0VzFvn0oZZ5VZP7MUcP66czYpMthoAgBu7yUSTBJ+GGHGGLlxBUAl
 374w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208078; x=1784812878;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y0MCf5pW4xNNdIkgT1T1KQEaBjldhwFlgVHv9j2llvE=;
 b=k9PCxyffpGyOINAXZpgX4k6ip96w/6aOsnJFWEaa4HKXyOIMnxSbg6asWGv08LLVsw
 ylgAjs6mNLsmwuFCYXnMwv8+/7Eeph176mtemfmLYSf5RvjaE9CGjVWwASu27NbRqkcD
 h5hFPSKkv/GLe4BtCQhybY239ng+DP6c8g6XsUzu/piEQmNuBqpV6GDP7AX82e4JnURI
 pPGyrtZwm4PwCVEHi8PWwMyeNuHJid6pBizh2wNjNNqc+z0lEnbycab09dUhq3pYdHEt
 ZUu4qTt/Wx59/NEdA+5r50h7LfzRjf+yerDwbPt+FehelOYkQGN4VwXs7u8xw3iZG1NC
 qpzA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr92jxWndnlgpb9EnnVU0v6q0siZbNDz1liEPii0lTezsi3asJvvG5fjtdWziQOGSvqSbs5seLku00+@nongnu.org
X-Gm-Message-State: AOJu0YwBWtguxakhbyXgxpDbWR/QQmB3yxcuyb9CmI/IAo0aX2G75v70
 f9JPEb7dmYvi/pqR3KZoTMCWv+f92Vu5wAOsMHDF3eIxuMPN3qa1mJGYS9TwObBTgGCGUdYBH59
 F7pfQ/1UZNGdGKYSbMGyShtgwy3/HCK+M2bydse7IMHxjkzS+EaClfi65Ng==
X-Gm-Gg: AfdE7cmBwu4Xo8+niqELdSFp7cLUQOM24c7nSFCkQtXS1H/71x7u1zrMs7C4BIOtgPm
 RQZlKAaBJVm615yxf0t9jcdqyljTbclNjMOZCXMXzhFcN/mxC4xkzdTtS5nJPASqcbV0gGPTwVe
 yne2Xmk7amdyRRfa0sx+YTGkcWPYT1JFbCtlIsBm17UAt+jRzdtF4VkIDAAsDmKRLgpChLQxlFy
 qRjCcXbr920fX/nZqZKK/TUCfTkXKv/BcCVCuFmdRTgpUZIblFVBJk4oMBUGkGazTC2N4mEsmkW
 RSO9sjIK1NzWZmLQ93bVpXp0oajA4SyDtVtKFtAs5S2p4rLW6xMG8ipA9nTOTObvv7Ee2qIWwkZ
 lezKZkTqPZuCPCUEi70SVp9bkPlEUhmeVCw==
X-Received: by 2002:ac8:5805:0:b0:51c:12bf:d4a3 with SMTP id
 d75a77b69052e-51e3c2cc193mr125319051cf.52.1784208078238; 
 Thu, 16 Jul 2026 06:21:18 -0700 (PDT)
X-Received: by 2002:ac8:5805:0:b0:51c:12bf:d4a3 with SMTP id
 d75a77b69052e-51e3c2cc193mr125318501cf.52.1784208077597; 
 Thu, 16 Jul 2026 06:21:17 -0700 (PDT)
Received: from [192.168.68.105] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caab6e9f4sm158122921cf.2.2026.07.16.06.21.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 06:21:17 -0700 (PDT)
Message-ID: <c06253bf-6e56-4ef8-9fd0-43d8a062190e@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 10:21:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] disas/riscv.c: Correct indent for checkpatch
To: frederic.petrot@univ-grenoble-alpes.fr, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr
References: <20260715190737.1381701-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20260715190737.1381701-4-frederic.petrot@univ-grenoble-alpes.fr>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260715190737.1381701-4-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzNyBTYWx0ZWRfXwZZTeuL5Q9HU
 4StKf7R01hGzDnlV3LY/hTE1pLytg0W4YtLZfnva1GkbQmk2SH51n47HRyoXLIbfd/A8gOYlHto
 ZiUiacmaDHyXZYXWoCMgSArvePKKoHGa/y5QZHgmQU3ZHia1B89hveMZHdcyC+FC0/DRil44UNc
 Mc88jnM33/Aiv8usq9wtfG5rWEzyHGaaMwCAKTJPsIBHtVzu+hnFJJC3EV8aNoEVYxjKmmrZea8
 zzj1ITT/mPRQlmNQmx9ivH5Ao4ulpEr7NxJWmtW8UsLRQGC6bzzUUQ+QkG1wPwQk3B7aFjsXmRc
 zNaGtMK8sox6RQC1KibqV3GMjxhDu0KN8qwvkpdXUn5NIQjpfC7+pTXDhCrIrtfcWxJW2zF1vnZ
 XhjV/HLwVJIHb+3oRALO6A/mKwV766ICxnWcjwB6A0doN66D8iRf+9l6R8tcherON+GbGZZGV/A
 p8bCfUWYEPZ0uAPeLxg==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a58dace cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=a4YAP2N2y8i5vXA3XgsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 7njbdAU5fl5G3GWQgC_zuyyg2cFPH6S2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzNyBTYWx0ZWRfXzGjpGFQxeN42
 AnqIu5uHZ25SAIAVxJMXmOgdbyfUym1mkkdf7f7PaUqwj1kXhKEHP+lFOSk+bDT0u8dDH7972Zc
 t4A5HSHz87mXgwnyF0uLPVRlmkZqZx0=
X-Proofpoint-ORIG-GUID: 7njbdAU5fl5G3GWQgC_zuyyg2cFPH6S2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160137
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 7/15/2026 4:07 PM, frederic.petrot@univ-grenoble-alpes.fr wrote:
> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> 
> Trival indentation patch on the cbo/lq relevant code.
> 
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---

As I said in patch 2 this patch is fixing style issues that patch 2 itself
is introducing.  We want this patch squashed into patch 2.


Thanks,
Daniel

>   disas/riscv.c | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 831ff526ad..27bf4d9954 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2887,25 +2887,25 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>               case 0: op = rv_op_fence; break;
>               case 1: op = rv_op_fence_i; break;
>               case 2:
> -               /*
> -                * 'lq' shares the "(...) 010 ..... 0001111" opcode space
> -                * with 'cbo' insns, but assumes rd != 0.
> -                *
> -                * cbo_inval  0000000 00000 ..... 010 00000 0001111
> -                * cbo_clean  0000000 00001 ..... 010 00000 0001111
> -                * cbo_flush  0000000 00010 ..... 010 00000 0001111
> -                * cbo_zero   0000000 00100 ..... 010 00000 0001111
> -                */
> -               if ((inst >> 7) & 0b11111) {
> -                  op = rv_op_lq;
> -               } else {
> -                  switch (inst >> 20) {
> -                  case 0: op = rv_op_cbo_inval; break;
> -                  case 1: op = rv_op_cbo_clean; break;
> -                  case 2: op = rv_op_cbo_flush; break;
> -                  case 4: op = rv_op_cbo_zero; break;
> -                  }
> -               }
> +                /*
> +                 * 'lq' shares the "(...) 010 ..... 0001111" opcode space
> +                 * with 'cbo' insns, but assumes rd != 0.
> +                 *
> +                 * cbo_inval  0000000 00000 ..... 010 00000 0001111
> +                 * cbo_clean  0000000 00001 ..... 010 00000 0001111
> +                 * cbo_flush  0000000 00010 ..... 010 00000 0001111
> +                 * cbo_zero   0000000 00100 ..... 010 00000 0001111
> +                 */
> +                if ((inst >> 7) & 0b11111) {
> +                    op = rv_op_lq;
> +                } else {
> +                    switch (inst >> 20) {
> +                    case 0: op = rv_op_cbo_inval; break;
> +                    case 1: op = rv_op_cbo_clean; break;
> +                    case 2: op = rv_op_cbo_flush; break;
> +                    case 4: op = rv_op_cbo_zero; break;
> +                    }
> +                }
>               }
>               break;
>           case 4:


