Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E55CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblwJ-0002mg-6p; Mon, 22 Jun 2026 17:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblwH-0002mG-QZ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:12:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblwF-0003qI-Vs
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:12:17 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZi3W1553054
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AaY3Fgtma4pQw3sP4nIl4WKqzyi2etKjZbF3UoGCmJI=; b=kkYkEyJDGIYJf44l
 cQgLjSI9x4p2Cgkjgj68tpLLRgGgGafQAdZWAVCljhRm5HOjp3mRV+PNq4Dkotgf
 Nc7NbAH+D+6G8C57e3vNM7OoBrdKRacOCT8lg0Z+8jVptI3B2P9YASjbJJGfWq1+
 F7sNc2BPJODR9qdDHZOYaFzogETNH9JLG07ztRdEsK67nqQlWipao2VKWV+UJO/8
 WO1qNRRymMAwdR0hDk2rGs7JFgc80AAUWp0vkMrxmOHHx90TyFYmRKB9Q7hAOU2I
 UsjeS1I8EneG4rn0+tg93UgNctrRfcCt9fR/ja4mpoLfNvEr2yYgVa5NsCa7eMYk
 vlrWGg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey729scxg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:12:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91598af506cso469354885a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782162733; x=1782767533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AaY3Fgtma4pQw3sP4nIl4WKqzyi2etKjZbF3UoGCmJI=;
 b=D/LklTK6d3pdlmtR/7thpqxv9nmGAPQpEr1ipuW8yPVjPziHUVc74933nyd/hiMBaW
 913iCgJZaOgFDUta6NICDQ5cUL6fBBxY7JXWcTVf285lyUGznwOuwM7+/7Gu/oPmozd+
 c0syfb7epzrA38Tj1fWYAQvXlglK8I1Lc4AA5mam+VrLRLaQtCr06HWKc7rb0GaAdepF
 3JzxUpLip9NKHuO44EOniJbogy8+Cyvd7vxv9LyVC4FHpF2+KqibP87D2UFT3dHBBAN6
 xZ1E1nljQvtPwP9RYDJ5Whds0UUfb6W3OnzbXAhJuYbEObwNibRIFYuGLfWvsy3OrPOf
 DpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782162733; x=1782767533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AaY3Fgtma4pQw3sP4nIl4WKqzyi2etKjZbF3UoGCmJI=;
 b=lbD18OYdKxV7FExtQXK8mrlc0o0YUG7LcOTNBwCsILK6GqAkMKqEuQ5U9kzm9pCbTA
 tRydSdOKJcB3qA59p3mUh0zhO3mlHWQbZvMakRkwKE3i7cPy3NCKiQOmSCGVQsWPoKk0
 DrGXm7HBhR4eUAJ07MNWnT/QR2lXZQKM+xRikR23tgwAcHVQQySi3bqhtrXb0PJ0kHtO
 I1VoaXJjgl4FjNWCiJ7VkJc0OsDFoXuScI6VVUNDN49qxtYAQ7w+ciJAgSfSIzsTG8iz
 MeJqOYlrIo1g4GxsbsGo0SApc8pKhZz16s/D+jXnFwJF29VFKy89vNtwqPZowbZoY7UB
 pVKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SKNLaVSyNFlo23+GhtC8kGpg/+XrQCDMePZmqCe8DMbyrGoFYMV6kN4ziZ4NosUzS9ZU3LnUzI0R/@nongnu.org
X-Gm-Message-State: AOJu0Ywk16CN7dtg16yLAOD5RGwsN0PrzZyEClebGQnDks1GqZSngdnA
 PcAmnh/lhkzGWTeqwMnzSVCMSYVD+HRKDp0pBvobdgsZbOG286L3F77eEeCezCt7OW1Fp7LyyDm
 Q6hpDVz35F45M8FmBAcwwNcEQ1lx5xYGMVzLBwVK97IEJWKOV5Kt7O7WYmw==
X-Gm-Gg: AfdE7cmOLLKd09epHGnnf4C1r9YKLJmyCWBEf14fQQA53XkucC51jNcf3EnllGHWufQ
 dJYKcE/+7J0jRPi24Ix52IK2PWeOfEcdfK+TUjQyyvv9o6T/vni73W2hrLe1REUbI35U4BkJVsX
 NRZowkjGtSR3JftoglvFcWQsSidpdf8XGjLseHyc/noSEWn33S8sqsPMT9Bqnv63MMB2XvpuwYr
 F2BrZtEinjZ51NoUyYrbhpP4kZ6xrRv2m4EtB4MAIYYhX2ee7Hfc5Univ0XkWlUWKgvcat7L0nU
 QyQ89HEevuLvUEvDk74+1fafa0lvA3XocSqV6vDJH0jA+NdNgXiEL2UPuKiFrRuCBTEUBD4LMJa
 oDVduKv3q8BwX9/XH2LDrS2scm+Mdvjozjt5K/k1bR5s0h/wLKSZ28K6lNPxPaw==
X-Received: by 2002:a05:620a:230f:10b0:921:24d9:a953 with SMTP id
 af79cd13be357-92124d9bddbmr1719558285a.18.1782162732746; 
 Mon, 22 Jun 2026 14:12:12 -0700 (PDT)
X-Received: by 2002:a05:620a:230f:10b0:921:24d9:a953 with SMTP id
 af79cd13be357-92124d9bddbmr1719553085a.18.1782162732224; 
 Mon, 22 Jun 2026 14:12:12 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492492338dasm236220615e9.1.2026.06.22.14.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 14:12:11 -0700 (PDT)
Message-ID: <49c4f746-41bf-4a8c-bd43-00658e101c0f@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 23:12:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] target/riscv: gate riscv_cpu_update_mip with
 tcg_enabled()
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-17-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622193141.1449724-17-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNCBTYWx0ZWRfX9lLcP8RmuyXP
 XlQrz/kkjIpNkZn0hjuX23GhFfnjQw8ntYofZdmJ5zO/M/ds8D8FD1qaqEeSeDsBGqu/De/NIE6
 aS1IP1twUL+YzYnFVfW81yE7++oVdmo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNCBTYWx0ZWRfX2KtSLAM81JeH
 Z5/BD+EDoL/ODPfZnCylVJL8Z1HpoO+QQTQuoNCpjwphPsqQUu0HKi5WfbZEWKBsCfRiSlc+BPR
 33CdK9C6uidlEC6msrGboA6qHeA4a0bVljiAeFmg6QxXSvgj6mVKvX4cbhRS7n6ZggHrKpHb6iV
 ZM2V039Jw82/kPT8XJDgGxeurIsJONojmGj9v6BaAoZI3Qz7ybI935Two60lZ+WJIebBQmbw9bE
 ojH7LFAguKmWkLTbMWs+eTcQ6l6if28z7EUIbtQdidJYJ3rNQhLkk1bFmdso45g1uRjo3pYLqdF
 gBF+DEfQAF7USEWWrTqKVkkLgvt+2IUJW2Dqdo3atcoE1NtFNemWJeu81EJGFaA2upVKsyYW/mf
 T6kL9/UV5BbK5TN915MfqqWJd3rEAoolkS707Q1K/t76QDXVdnd6zKUTD8Ax6/D90JvdZ/aIHkH
 Qz7qng/YTdJuxDYrLYA==
X-Proofpoint-ORIG-GUID: yOuqyxNMGoMfzXtdOpxG1tPOo1vXca34
X-Proofpoint-GUID: yOuqyxNMGoMfzXtdOpxG1tPOo1vXca34
X-Authority-Analysis: v=2.4 cv=eN0jSnp1 c=1 sm=1 tr=0 ts=6a39a52d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=qu7E-j1iDWMFSUb5NQgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220204
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

On 22/6/26 21:31, Daniel Henrique Barboza wrote:
> riscv_cpu_update_mip() is a TCG only call.  Its KVM equivalent is
> kvm_riscv_set_irq().  cpu.c gates the KVM only function with a
> kvm_enabled() check, making it unavailable for TCG only builds.  We need
> to do the same for riscv_cpu_update_mip() otherwise a KVM only build
> will fail because it doesn't know what this function is.
> 
> Use tcg_enabled() for the couple of riscv_cpu_update_mip() calls we have
> unguarded in cpu.c.
> 
> We have way more calls to deal with in time_helper.c which isn't using
> kvm_riscv_set_irq() at all. For this file create a riscv_set_irq() local
> helper that will choose whether to use the KVM or TCG API.
> 
> The reason we're going through all this hassle in time_helper.c is
> because hw/int/riscv_aclint.c uses it, and if we don't do something
> about we won't have riscv_aclint working for KVM.  Whether this is a
> real problem or not and we should remove aclint support for KVM is
> question for another day.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c         | 19 ++++++++++++++-----
>   target/riscv/time_helper.c | 33 +++++++++++++++++++++++++--------
>   2 files changed, 39 insertions(+), 13 deletions(-)


> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
> index 400e917354..2679dbba6c 100644
> --- a/target/riscv/time_helper.c
> +++ b/target/riscv/time_helper.c
> @@ -21,19 +21,34 @@
>   #include "cpu_bits.h"
>   #include "time_helper.h"
>   #include "hw/intc/riscv_aclint.h"
> +#include "kvm/kvm_riscv.h"
> +#include "system/kvm.h"
> +#include "system/tcg.h"
> +
> +static void riscv_set_irq(RISCVCPU *cpu, int irq, int level)

riscv_accel_set_irq? Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +{
> +    if (kvm_enabled()) {
> +        kvm_riscv_set_irq(cpu, irq, level);
> +    }
> +
> +    if (tcg_enabled()) {
> +        riscv_cpu_update_mip(&cpu->env, irq, level);
> +    }
> +}



