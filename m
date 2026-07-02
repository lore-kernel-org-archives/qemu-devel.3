Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931A4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHYV-0006Hw-Q9; Thu, 02 Jul 2026 09:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHYT-0006HM-PH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:34:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHYS-0000SL-49
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:34:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0fXM522312
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gcy85P1sZQkX06tQL1VTjqOo+/FWo6oIzWYq1FIGTfU=; b=g7SJDTy7yX2pjjGM
 tIQ6lEO2xcoIr7YWzejKXUHemCeo8uhJ8gofjD3URPtEzM6WU+Jo7ZA4pjJH5ofI
 NAb3j989cFjPV+euFmrLFkBlzj0EaeJjxnc3bYfTf1hQhi83RZXkVYK6yzO54yU+
 WleaTCPnruF1zR97fyAy4SnOHqpuXFoWnv3ELVukeEetTAq347jACQKdC6Sp9SLr
 bR1jXekJ/HDEjWpnmaHIECLc+Sd9zhdBmORLdRXdcvYVRF+Eijwv3PqnXPyMvw/5
 s4Wf7Hx5BrH/yo5DsCkRUS/LLDTs3+b8N1Hzg4t5rCFDWLVZk4QnTuLYRUdL2bG9
 h+Rw0w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc1e15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:34:10 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8e86066fc53so8947996d6.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782999250; x=1783604050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gcy85P1sZQkX06tQL1VTjqOo+/FWo6oIzWYq1FIGTfU=;
 b=PkGAGV1401S8Nj3Td1Wrc0TD3rJ/SmJ5tGhePEEj1NMhVp0IYdAQ1YfHtkALkGEKv4
 SVU2vPJKxxGs53RicITs+es40RZLtJ+fbbo96zj2IiBkq6A+1ZVDIcU7mVGrxxyJNsc5
 Csxc3t5bRpUERjSzY6xmr5WCrsUweriFaZIipFDsaKsRNr3jDl28lI8BVvLQZrDkg/AS
 UCV06TNjN3TUi1+Uf1H6fZd0P9D9pb0BwQLv3E8jEzCw8EuvtmJI6NhshK6eBTh1ZX3o
 js3UUg+iSRo4DSUcV0lM/vsFS+eOQJI+60kxJ+PNgCQ7BNGhS6iSMDaLwpKqJcwbb6Np
 OXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782999250; x=1783604050;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gcy85P1sZQkX06tQL1VTjqOo+/FWo6oIzWYq1FIGTfU=;
 b=O07IXN9+lgm3ctKkuWTZzqHS7sATupxx1ahsbqlUo9MHTXYWMdLwQ52QjnsyRJBZLc
 XUUjoKAGVQxO2uK1TGsY1kUjqzKyScj5kmBLqQ3ayfOuzmMje3EUA314J4DeNbfYS16a
 PQNE/Dpu6hxcDIC09uWTxhr3zvs/EbPdQ3OiAQRv/61SQV6JhiA7BafqO/BEoqZg4KIN
 31RM82OceRFCQL3ZPLJMZynMEDlBMzAL7Lip5be9OUnFGuArRALXwuO8k0wFNRO+LYNX
 whOuUudLE28JyeqfM0DFpCQvcD8YMtztq36E1AHyK1ny03Dh0i/we3PqrBw3oQFrM7Ox
 GxMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLkR5xEr1WNI9ecq0Kh/4QeGjXz1vHH9ug+78xnt36Nxz2eX1SzcRJYiSW3oEZR/ChJlUlGDrlO4u8@nongnu.org
X-Gm-Message-State: AOJu0YwwQVFOeL/VZ7uMcJkt4CFREFNY1Ln7fZnN6x71PbUF63nF3Yme
 o0tHq4mpYW4RilW8WKZku1GlhAHnycVGKpH1gceL+5mVUe4dcJz1B2wbWA0syaaUf0x1rjseiNz
 evVbBHIeshOcqRqfKQZCVZUtEd0p6+sN2mHO1mSW42GJZwOPnieby8Ob+xw==
X-Gm-Gg: AfdE7cl35BMNJQN1U2DatWDWMBGXP3A5CP03QsJtGt4ZULQm+j3TwSDE5kaLMK7pEjF
 c6iS/DHX/sTyUjv8CW5Jk4QDkUITH0CmXk2yW7WiC4u7afJD6N1P/pWp85CYj5uCJJA/Jsw+/Ne
 tUyR0Cw26U2R+dhlk+4IY7CvAlHKHmLJjdxalqLWbWL/v+M7M4OOFD2mHlD6/Qxu0F3IX6OmCJe
 ILwxhNHAJep7xdjrabtEhFrcH6y3lRWToPJVHX8puL++tEO++Y8Gk2h2RCn7kp7gHyYyTXHCsiz
 vtQxkI9crKZ8iC21aZIBhNAZGkpLptoW+vpE4YyLIu4JRtjgfjuFA1dVYzpUDMS47yI8IQ/HyiJ
 9bn2EOFAR0u3Ok5IOKRPcm/mM0SwVaXCRcxEO0myFmqZH
X-Received: by 2002:a05:6214:5902:b0:8ee:d9b8:8538 with SMTP id
 6a1803df08f44-8f3bcdfc8e5mr88580676d6.9.1782999249855; 
 Thu, 02 Jul 2026 06:34:09 -0700 (PDT)
X-Received: by 2002:a05:6214:5902:b0:8ee:d9b8:8538 with SMTP id
 6a1803df08f44-8f3bcdfc8e5mr88580106d6.9.1782999249405; 
 Thu, 02 Jul 2026 06:34:09 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f4726b3201sm26438516d6.46.2026.07.02.06.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:34:08 -0700 (PDT)
Message-ID: <3f3e03c8-761f-45d1-972b-64c3f6a48b83@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:34:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/33] target/ppc: Ensure TCG is used in ppc_update_daw()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-28-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-28-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kuvKhYPhTEwQGILDXuf3E1mM0rEtHqPC
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a4668d2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=LKigP3mzPcWqHH2rOnYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MiBTYWx0ZWRfX2NQVTbEY6axV
 qwQ1FCzwghhKnjupc5Oom0uwAn07aTkoMUSgN21xjsLa90lXV1/XlkIqTLjyvFKmQ5iYQjukZ5q
 n5EneUvHno2ILkL+HAXhIhrmD/UNOeEO+7LrRQcVim33yyssQflvB7M8zfN+UnXKu1nf7kcGsnA
 yuHHQ8Qdzp5XhjKAH2dSR0yaRVVY0XRsf7qtRf/16u4pQnv8OWumTSqDdqcg2lE3GsxvhEOTOzX
 8sr4wbFPeVJpC56NytqjtzRB3b1/LObt2ObR36nCl29gYzbHGzbywXK2JOlUf445CdOIfIWJNyj
 gxGyGNxJB5f6E7cprCjzv6GCiwZjYnVkYGRxsbe+2FQViUiuaXXBmAOUerF4ejoRtv0USDgkNbw
 w7VOAdWUIoCjCxhOGQFoKYlrS6C6H4vYIMfFWcNMRirqig3vUdgb8CZyMLVCiljwxv7e41DnQ6p
 xpQrh7+yFHS/PasGGAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MiBTYWx0ZWRfX0+G7z6DWwozi
 YccF1JBVvnzJx9Sd3AshfHJ2sZYm8ZZBwZ49YGzp7Xb8YtYp52rdxwCUTLZtt5JyJHgV6crKWwG
 2PDQtg00uN/xzHdQDkG3MS0rBREQQ1M=
X-Proofpoint-GUID: kuvKhYPhTEwQGILDXuf3E1mM0rEtHqPC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020142
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Per commit d5ee641cfc5 ("target/ppc: Implement watchpoint debug
> facility for v2.07S"), only TCG is implemented:
> 
>      ISA v2.07S introduced the watchpoint facility based on the DAWR0
>      and DAWRX0 SPRs. Implement this in TCG.
>                       ^^^^^^^^^^^^^^^^^^^^^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

I remember this one, so I feel comfortable giving an ack.


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/ppc/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> index 913920d55b8..36e1209119d 100644
> --- a/target/ppc/cpu.c
> +++ b/target/ppc/cpu.c
> @@ -147,6 +147,8 @@ void ppc_update_daw(CPUPPCState *env, int rid)
>       vaddr len;
>       BreakpointFlags flags;
>   
> +    assert(tcg_enabled());
> +
>       if (env->dawr_watchpoint[rid]) {
>           cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
>           env->dawr_watchpoint[rid] = NULL;


