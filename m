Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBABDC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHZ1-0006nT-3U; Thu, 02 Jul 2026 09:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHYv-0006hQ-0A
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:34:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHYs-0000Zj-Ow
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:34:40 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0ZT0417183
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AWRFLBauA8HFuSFJXNqt9BAMj8IHs/m01L7KeAk+u20=; b=RZtvJRd8KwpktuUI
 mcm8IoHGXuQr/Vo5oAdkNNuSWfAcZ360B0VEdDuaVB6Cl5a1/Tp4F80iP/6pB1aB
 IpC3Bb9Dmnyu3lpS4u1QX4117KPF84m/UW8LLN0aZpgK8uvCb9OtX+Y9ipuY1298
 ID7L8dXbOSN3BnMbikcEhLRbDZIACrbAWVYidFHjfALAXOxUpGLNIPc4WZ0mXKQH
 Hdt6w0gyTtRyJsFEpZO348syYXZiPfxoovcKxjvAOl91GhSqVx3PZvAeErNxCiC+
 jxEYXqKSwnwb4m9rvBQ17mEbBeGjgyJAa1bQ40SxRkKBHdioBvF4GcDxInNvOKfq
 MF1YQg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bgy3s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:34:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso19613771cf.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782999276; x=1783604076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AWRFLBauA8HFuSFJXNqt9BAMj8IHs/m01L7KeAk+u20=;
 b=AbizvMD1xa7icwpSdcEodF7aWyZ98OYGa6gE2s1fZIQ6gI3Vuc7PROr29cM1g5Fb1u
 OWtjauA63C+5PqTr9cMKwB+2IKURJzbm3KnC590nQqbMa6tDDKrUpLQOMqJjHnZ5iX6y
 XurK6ArzFOeSWHyjSHF8pJRcIXMT5EyUorsG9Dnp+PhpfPOySZiHLmaEohiKxPrkKt3p
 5WniZyNCte8mbsw6kViJLeWrqUGKbubn5pU4KWn0G/kBwVwar5q8K/ya1VXsj1QGpEOo
 1XonlBelhCvjM0Ka3Nla7sOK397L6TP9muNB9OyJoqpkzCrzFQ3dtG5EDAwsbcMT57kn
 bASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782999276; x=1783604076;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AWRFLBauA8HFuSFJXNqt9BAMj8IHs/m01L7KeAk+u20=;
 b=kO7ZAjOwnS/tj/+gmK6RJRutsIBUkFqo5PGr0dOKbFE89bliulKn/RXkP5oDNsJPwt
 UUi39Qk2/xcCLUPU25UZ/AJ3yRHgLBsyxk+6yaUNUvQSRDrPxzEA5PYNqjBqKEPrLcop
 HT8qAs5GqozIJltIVeapqgJME0dWn/rd6iGkngm9viqckx1C9+qyVNPqzHHlRnt50+d5
 Moqb2jWpXdMkLNv8gYOr2vDmWQaTLh/yzUF9bFHz4Rn5OHbWZXqfZZfk4VNLDX1S22Wl
 JjqmlHW446DOiqkBcx3IhRz+BaUw0p3MOYUtNQV0kiMpS1jbzh2n3NmSZ3OpLoebONWr
 HdLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RDPp3KblHc55Xe8A29aTyiTQ/id6FQk9l87NleBkyaIMwcBJtLmxBNQ+/FqC7npMHhH89Tm5Apj8t@nongnu.org
X-Gm-Message-State: AOJu0YxB/gloul6OxUdZiMmjqvFVvWsbzb1ocapd4aFIeSTfCoQdQUQC
 0bMXsqph4qpFCKweK+hekte0Oj9uiUBC4KvU/Pyq8tmgpW+S5RA3SVKGyEHq+LV7mgVzZMQ63s5
 qekR5HQY4ga/Yh7n5N8mMmSl7voBVyEu5eV0biU6oi8f3RirOBBKgZLC58g==
X-Gm-Gg: AfdE7clFbbOqCb6FbyrIDrZ/wbRPt3nkssm+Q5Lm3xt1t9hiAi8agFBboTY4Q9rSm8D
 0zJoSCWXX6+J+V5CBKk9OdjISZRmwmjlCWfctLaDXTC5wWtpi9riNhUzyMRSY+cLeCVojx1o4kG
 buZzUqpLTT3j2HRvZ4LFSmuxsjktOtbUo5dIg0BM6IhWPWPv9h+mSKrgAX/Ob/N5rMJfz6swF5+
 2almL6gfTk0gpO5kohH1p/mdOcvSdUR4PpiGSCmaUFhi7sEOq8wo2DoC9Iu+hWJGVTCLF+kVWke
 cLzc8QbspQtg+rtNm739VXUvPdd3uAmie/xRif9c+DhNy5+LHYmojCj1ullnhwRRh+rR9HBeGrf
 enudYOAPxx0oFOCAc5Nni44+va1XKJuDSrfIezu+srgtr
X-Received: by 2002:a05:622a:4205:b0:51c:25da:9045 with SMTP id
 d75a77b69052e-51c26a5383amr90002741cf.3.1782999276078; 
 Thu, 02 Jul 2026 06:34:36 -0700 (PDT)
X-Received: by 2002:a05:622a:4205:b0:51c:25da:9045 with SMTP id
 d75a77b69052e-51c26a5383amr90002201cf.3.1782999275535; 
 Thu, 02 Jul 2026 06:34:35 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c30af2f46sm14624571cf.3.2026.07.02.06.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:34:35 -0700 (PDT)
Message-ID: <1bb7193b-a024-4ea2-a23c-b77402dabaab@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:34:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/33] accel/tcg: Improve docstrings around
 TCGCPUOps::*watchpoint* handlers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-29-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-29-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cqpyTTp8Y5_IGzMR8YrE_U5OvMmTi8S8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MiBTYWx0ZWRfX1Y2T7nY5IOAf
 D0aKCw606vm9SF/GvggeHQelNTbpKChgnf/dXFzhBa4mfLsaQMxupkFtkJT/wSPu0m+p06KNrl6
 Xwj/2JigO9yCNgq08hzUZpPyFRd/4lQ=
X-Proofpoint-GUID: cqpyTTp8Y5_IGzMR8YrE_U5OvMmTi8S8
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a4668ed cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=OZ9AnKJkQF7RGHyG2EkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MiBTYWx0ZWRfXzpiZ3JDf06Z1
 wb35jEBnQCYvicKs1Lkm5B4DGbEoBrd4Wh7AlM1AXln5XDRvDS1xD+Dm7/DbcVAiApDQOHI7iWm
 vFFVRA2RNjTnOJtwC7bSTUxmva2Pw+X8UDAE0CFz9fw8X4oupPGse4B0L8bE3OacoH45nXVHVi+
 kkEqP/RtkQ3erHh1Oy4ZoW1F5OM6wI+Jlk82l7rGOzUHYWiNwaItFRj+zuaUA3KL8XX/prqnEeW
 1Kwva3m3lxvhEdAdLe6S/tcUqknIabZ8wTSvBtEU3BY1vs8bOwCmAyQu93eMQkoIoYxLS+ghpO3
 SPp6cI4opRJT2ZiUYcO8ON4OYrCPou7HA3jtYdz4lmtgxItQ5TVuOy35z25UWvBWiJ+9eufr+jv
 SP+1/jLqsqcaD46IyM47lbSi/JjHbMKgH9N5sk/CjKD0coytApV7xDebg3dsD1MTDlHaoLwCsnG
 FLwNklHMGUAKXrdTwVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020142
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Commit d5ee641cfc5 ("target/ppc: Implement watchpoint debug facility
> for v2.07S") also implemented TCGCPUOps::debug_check_watchpoint for
> PPC: make the comment generic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/accel/tcg/cpu-ops.h | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
> index f64d94b2b50..568d82cdd32 100644
> --- a/include/accel/tcg/cpu-ops.h
> +++ b/include/accel/tcg/cpu-ops.h
> @@ -250,14 +250,13 @@ struct TCGCPUOps {
>                                              int mmu_idx, uintptr_t retaddr);
>   
>       /**
> -     * @adjust_watchpoint_address: hack for cpu_check_watchpoint used by ARM
> +     * @adjust_watchpoint_address: hack for cpu_check_watchpoint (used by ARM)
>        */
>       vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
>   
>       /**
>        * @debug_check_watchpoint: return true if the architectural
> -     * watchpoint whose address has matched should really fire, used by ARM
> -     * and RISC-V
> +     * watchpoint whose address has matched should really fire.
>        */
>       bool (*debug_check_watchpoint)(CPUState *cpu, CPUWatchpoint *wp);
>   


