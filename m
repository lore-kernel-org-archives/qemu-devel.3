Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A10606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rde5fs67;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JjJzZMdA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzab-0005b2-Au; Fri, 27 Nov 2026 12:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzaV-0005YE-RG
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:18:20 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzaT-0004W9-3m
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:18:19 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFpTAd2211124
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Mz2Wu/slXIfcMfjsH/GFFfGY/EsAXFB2mT5QloN5eyY=; b=Rde5fs67e87/h1V5
 6AzNbtdYtPFyT4r17OnVtKykJOp+ViJb7xk3dILHNCGH2p3SmKZRbp4p1TcVRa7P
 pxxfdv05TDsMgmT4mDUnikdQiEKpHpUutnuK4rc18qTCuo6D3vHMgmRqNb74wl93
 YNncIuWczuRtS7P4iQMtdxJNLJ1zKxO2YbpEnTysuv+6D39w5rhxJ7bux6pmHvUk
 UDuGcNZIbZGjgsQQZY1EhSpVemfzNQMe81TlKwyX941N4pfgd+Uiu2GfQwKvRf2C
 +hkNkc0ce+jJnldSSGiRvuunArfe+3fxn72T8+/AEIB9MZUUJ2NJKhBUVitR26wE
 ykD8MA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u55uxnv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:18:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-386a65fca25so7360556eec.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795799888; x=1796404688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mz2Wu/slXIfcMfjsH/GFFfGY/EsAXFB2mT5QloN5eyY=;
 b=JjJzZMdAy1HiXtwIQxi0O5e6kuP3r4v7P+aVE5gWvkexDvbradR5KQKx1d1L7FjA6q
 jS4tUSz3ffdokti1GSpL2MUi1ry5/DRjLEXtYZZQbhkMZLduWj2HBseRLNBWuw8IosoI
 qs88uC/+pH6/MmFz0ngo6ep2buhVFSi3xZN4wYNPdv2qHhfnzYsh173mH2wQkBETxMq7
 uiQ0iFu2eakI/pzm86eBUrwsaryw1NFQKCZUCLM0gHH89h29/MdVGcFctOOlwaeUp5/6
 yb9zZxuTfG7akxpV92KTvgRj6/0uEHQvoXJrh488j43HWJIy66uBiCfvu+/oL35xpy2Z
 qCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795799888; x=1796404688;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mz2Wu/slXIfcMfjsH/GFFfGY/EsAXFB2mT5QloN5eyY=;
 b=kwpLxYQcF59dQCVk6I+wDyE/jdn0FtwNxbnc0S0TZn12h8oVlJc1RaCKA3upCu4PTT
 B7ecgMi7TwBatWAgQD4tABlRDjavu1zZOTZ+7cDlUWKtFgz/e/50WruWU0EdvT/3zAGU
 Qe3+C4DILwBRhPqXvaPNWDIWAnyDpZ3OSDAOMbdWWIGK26Nw+C184QzRrzGRn6D4Bx0D
 MquOcghY1a7NIiqRKdUGxo9UAi9Pk13Nzn+lylgF5KaTUfEhldcFNw92orJcbTwxGsyZ
 RU1a39C72QRTUXHDtnwpYFZQHwN01LALy6WhH8xDs0E9Z5WxZfncfUFgktHbZRmsDJ5h
 xq8w==
X-Forwarded-Encrypted: i=1;
 AL+hErEUTTjwdS+KegJnnQFv69reoAhkSv6ePPMxN/aqbu5VuEjxsS8GF8huiaZYjPiqLXyWqvQisl+h47Zm@nongnu.org
X-Gm-Message-State: APuU4Z/MqGYjnQrIoal3whSJK8K+XDFVqDAl4ypfZAgY9a5ykA3U99Sl
 Y+oLahbuRSP4OdZTJnBG3j6PSHax0kTaJS7ehaVCUMArx7ai0kSlIp1Pv7Qa01YsH90auOOx3F4
 TXjefE0f5K+iZsTuPfNA/PMdBLVvTkqkamNRCJC95DoWkFc4AYkMZIECIYg==
X-Gm-Gg: AZFdTZehMnNLn0aUrLL+2j9AnjtmW7VjjTx5dkwPrM9QQKluXpMXDNftyMkTZJcS6s2
 uCK1IP+fGvELMDhe6Vr9SJivMPceu293V14RSlrCsYhFYsQ8hqlra3zEepupCVa8O2Mdt78MKau
 vb/PC34IIIenurn9pHL8tKbq6Ttj1F7wQ8BqBQHvW8jM765V+/Qqfq5H3Bgv0jmGwoBjbwFMRrS
 baZammpjz7/j6bUVzsGK78h+E7ANrd6spWYOUkP7MxhzutIE+zVPawbLKjWqwHzN72Oxx/cVM/P
 BNIyop5lFjoGyqTwQOt6yeN8b/epITnRHsir1sj07RDJR/wqwKEzG6EMq855Aaw3k4nho/i6o/R
 WQwXCmXZfnWar6W1LuHG5j6Z7dZZySjdHzyNyOxoBaLNReyE1zDyhIO9sExlVlOLF+6kyr7gq0R
 PPcqHXbxtpBiPNHnl6IwDUqQNVsci5HEoYkUvuXsHRDfs=
X-Received: by 2002:a05:7301:dd83:b0:386:5adb:ac29 with SMTP id
 5a478bee46e88-3865adbb03fmr20939807eec.7.1795799888291; 
 Fri, 27 Nov 2026 09:18:08 -0800 (PST)
X-Received: by 2002:a05:7301:dd83:b0:386:5adb:ac29 with SMTP id
 5a478bee46e88-3865adbb03fmr20939787eec.7.1795799887701; 
 Fri, 27 Nov 2026 09:18:07 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567cafec4sm84052591eec.26.2026.11.27.09.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:18:07 -0800 (PST)
Message-ID: <76a04680-141a-43f0-884b-0ea3fff0379f@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 09:18:06 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] accel/tcg: Do not write qemu_icount from seqlock
 readers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261126222530.62175-1-philmd@oss.qualcomm.com>
 <20261126222530.62175-4-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261126222530.62175-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2OCBTYWx0ZWRfX6VV4baLFOQ7k
 DOqozCu5sRsTvJsnSAbJA5yjF2spHhULzEfVb6QxJN0PKIsMprGP1YRg8WaloAELukthOXeNZ6g
 EA7N5VXoS98Y3LhlO7v+N2/WR6/7PH8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2OCBTYWx0ZWRfX4KdpOi3J0nhq
 EphOCmcUxniPVFRQ3T0GctsvaTZljFTKzzZSXKEXOcBebj0+8zXdXZebhZyDSDpp1HXFmv1nCz3
 AMHfo42YJbKjUkXKsrJN27RgEjm1gztrzCL4h6cB5TTQl9YhN713OEi8HOooBlAruZYUy3uHnDZ
 b6T0MbaEqtN7+7DjnW4PG5bS80b7XH/Gc8PXzPCS0JpEGNn8FfMLFH7SK1d80KwaTZZPN/IRCZl
 MbW53e8GSmhoTvBzXT1czTNsirfso75dutVZ3hBcT8yYHYfel65BVcymyhArSTXDcwKlPoL+U3r
 Y7TTkAqbXrzCPBWg0nQ/n759mZLTQo8r/TA+Gc69rVsjWgtA52yUYuGWL/mbEfvQ0qTX4AiIhfG
 K7gbgf5jQLrC8xPtMGJQ4+QQgJXxs5+hwb9kCpU4E9xRX7OQ+2sPcYPfNEyzgihvKu+i4lAg2Ot
 790ZREuOjYWYwW/Na/A==
X-Proofpoint-ORIG-GUID: HLBTB1hUn7ZnlGPDUb7pz_Sh_F3wvvUi
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6b09bb51 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=atsRmJsrh7j39t9r5rQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: HLBTB1hUn7ZnlGPDUb7pz_Sh_F3wvvUi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/2026 2:25 PM, Philippe Mathieu-Daudé wrote:
> icount_get() and icount_get_raw() updated qemu_icount inside
> the seqlock read section, without vm_clock_lock.
> 
> This fixes a narrow time-skew race in adaptive icount:
> icount_adjust() reads qemu_icount twice under the write lock,
> and a vCPU update in between is lost from QEMU_CLOCK_VIRTUAL
> (up to 0xffff instructions). Reproduced on riscv64 'virt',
> whose cycle/instret CSRs read the clock without the BQL, by
> widening the window with an injected delay.
> 
> Update under the write lock before reading.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  accel/tcg/icount-common.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
> index b52d22f3a1cf..ababf7745b27 100644
> --- a/accel/tcg/icount-common.c
> +++ b/accel/tcg/icount-common.c
> @@ -125,6 +125,7 @@ static int64_t icount_to_virtual_ns(int64_t icount)
>      return qatomic_read(&timers_state.qemu_icount_bias) + icount_to_ns(icount);
>  }
>  
> +/* Callers hold vm_clock_lock (used by REPLAY_CLOCK_LOCKED) */
>  static int64_t icount_get_raw_locked(void)
>  {
>      CPUState *cpu = icount_running_cpu();
> @@ -137,19 +138,28 @@ static int64_t icount_get_raw_locked(void)
>      return qatomic_read(&timers_state.qemu_icount);
>  }
>  
> +/* Callers hold vm_clock_lock */
>  static int64_t icount_get_locked(void)
>  {
>      return icount_to_virtual_ns(icount_get_raw_locked());
>  }
>  
> +/*
> + * Readers never write qemu_icount inside the seqlock read section:
> + * the running vCPU folds in what it has executed under the write lock.
> + */
>  int64_t icount_get_raw(void)
>  {
> +    CPUState *cpu = icount_running_cpu();
>      int64_t icount;
>      unsigned start;
>  
> +    if (cpu) {
> +        icount_update(cpu);
> +    }
>      do {
>          start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
> -        icount = icount_get_raw_locked();
> +        icount = qatomic_read(&timers_state.qemu_icount);
>      } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
>  
>      return icount;
> @@ -158,12 +168,16 @@ int64_t icount_get_raw(void)
>  /* Return the virtual CPU time, based on the instruction counter.  */
>  int64_t icount_get(void)
>  {
> +    CPUState *cpu = icount_running_cpu();
>      int64_t icount;
>      unsigned start;
>  
> +    if (cpu) {
> +        icount_update(cpu);
> +    }
>      do {
>          start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
> -        icount = icount_get_locked();
> +        icount = icount_to_virtual_ns(qatomic_read(&timers_state.qemu_icount));
>      } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
>  
>      return icount;

The patch seems to fix two things at the same time:
- ensure that current icount is read with vm_clock_lock held, that's fine.
- add a new call to icount_update.

Can you please explain why this new call fix things?

Regards,
Pierrick

