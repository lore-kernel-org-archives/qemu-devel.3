Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F15C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f2m-0005fD-Qn; Mon, 21 Sep 2026 10:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8f2i-0005KN-3c
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:30:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8f2g-0000rQ-7q
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:30:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LEGbhV1891162
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y9OO6CTPohkbDZoVhWgc4ePmrWMqq/SXb29vlujd38I=; b=anuSQOAMnx+oxlRI
 w8n3BhXlF2mf734FRVbTdZ4HwQpbV9DJp9GzM0bwQUcA4JT5s+jAfTaUiaNY3nog
 5ElXiibcrW9JjMeNAOrlA+SClwuBMHPZN4UK5SpULzC2dzIHHgW76CsgamhHcLBo
 5V4R1gaFB7MSEF6CC0TDF1QTkXFf0j7U5o1JQ85t+J2sx6wynUG1ghU6olUZAdNT
 u3wRIFmGvG29drZ/DFGtd4ZiMjqc+vwzCEDlZWzXxPOIo6hPlWpOBN+64+fh2dGX
 S8Ft0QZeJl10nzEM8/Mx+Jx/04E5VbiRC3Y65JMRKhVlKpvTW1D6id3P7Liz1tNo
 FJxjOQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01d1qd0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:30:48 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-79cdabf7d89so3249290137.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790001048; x=1790605848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y9OO6CTPohkbDZoVhWgc4ePmrWMqq/SXb29vlujd38I=;
 b=A8+qbmzQ9RYZmukIkunLnRP5qZAhvhZ79vQiY/YtYSci6Im6Q16LN3mtVpN0PDW3NL
 Tysj7TsD3eLHaUFy8aIeRppt3gx9b/45k/NLEYpmLGA0niZDHV3kjcOkC1aL2XksQxrF
 8aagbMrX+B3AbgausJAdlPKW9rMsn1SUC1io7ca27Roo4Fv0uKcgCU/tooM7gS/Wjq96
 RDcGxN2Zn5nb3TFhw396VtFzhMD6TgDktGoiNiFD8n1XNM/4b52YFUqtOurmUwB3mQEp
 A8oLPvxzgpqyKq9944GraBqLhhko0TScSViYqwBmjVBB7diO482I/n4o68BMuQMEP4Ck
 oY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790001048; x=1790605848;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y9OO6CTPohkbDZoVhWgc4ePmrWMqq/SXb29vlujd38I=;
 b=KHIh3ngWNT/pg2JAkGW+X1EUi9lj02vyHv6PuNjUpuBC5cGLB3omXzrjBv/vQ3um1h
 m8ue4izg7VmYsKC4WOwzW/wvnjHzsz5lLrpekPBnUQ98ciZOBG8OGedgWPAeAvEIM3kd
 Gb2TfLm80NDgI0EqCzU/sTLWGbJa2eAv0StXTK0FHjANwwhPHQUTGFdHrd+VkiretmsH
 3TZjBvOx9p095mUvfl4ZxXmRAPsFHigZdVFimOVdb3cD+W5OqBZEABkyCSsIlLGoRfhU
 bHOvemlrvZBDW7D9iOwFhysLiZeyeKYYIen6e3if4oq9kLuCmeU1i7xZiObN2ZJrg8MS
 7C1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSfQfMrDCHjUUTO3Wnx2/b9RJOqr0qO76GLNR2eIT3ImSrEeZI5MGrS+HmpphWbC2AXTYYvIgafA5N@nongnu.org
X-Gm-Message-State: AFuF++n8GpYnfCPmvPYuCXRgys07Pg4fKpf9ROB9bvhwd0aiGhLaL84Q
 rmqWEK2RKYEzqVyIC3McPhXsm0hQ5VuRY/h+sTknqnVVh8TNq5empa0vY8pFsxIqgXLeg6Al5Kg
 ABT/6YGaVY6KE8pEluj/q1WTqXyPj5qETPDk6Q/FCRTcjg8V8iqL96K1QqA==
X-Gm-Gg: AYBFou2T0mwsEQsLQqRhwmHFDxVuw/PoebLLWSiKkLSku800fA8h9prZ10v55kPMFGG
 3BrYRz74KBYAcBMvnN0b4ZmOzzrmrpo+BfKKkL9F+6wnqvUo/R+NfvPm+hWqkMS5C6iLs2QwuuN
 atv3/2o4ZDHhMFfwC4+sMGKgQ8njffipKjH4T6qs+OdbzXY7+3xOCNjSPzPMa7DOvyf8j0DlBk3
 9Hw4doaLFA4woRkG5ti+SMk95Jgo3OwON2O2rL2E5x0sm/fVrf7Awf9hLSRZLKWbKjm6v/wF7XC
 UpQVkiJQtCokUJ+toPShfSTt46zSYsLhI2Y/AYd/b4brT2wYItxJxJx480gLePtxnJ0cpWHcdSh
 Xb9185EVbScX1mmoEorKA
X-Received: by 2002:a05:6102:3711:b0:7a1:84bd:7f50 with SMTP id
 ada2fe7eead31-7a55b036f45mr4575583137.1.1790001046717; 
 Mon, 21 Sep 2026 07:30:46 -0700 (PDT)
X-Received: by 2002:a05:6102:3711:b0:7a1:84bd:7f50 with SMTP id
 ada2fe7eead31-7a55b036f45mr4575201137.1.1790001044203; 
 Mon, 21 Sep 2026 07:30:44 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd8bc15esm190513035e9.1.2026.09.21.07.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 07:30:43 -0700 (PDT)
Message-ID: <2ab01e14-e621-44f1-853e-f3fe159621ea@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] accel/tcg: add cpu_loop_exit_excp
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Yoshinori Sato
 <yoshinori.sato@nifty.com>, Nicholas Piggin <npiggin@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 Bibo Mao <maobibo@loongson.cn>, Chao Liu <chao.liu@processmission.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
 <20260918004225.827-2-luoyonggang@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260918004225.827-2-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pQ6jqMbcaA-tyvtJFdiYTK2Dl4Q55NPq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfX2BatugfXzJBK
 9DOt9sQ37IKDBgNT7ntYmW2hcxraCJGo9thZh4BCsycP5wt7qgkjWcsaRZyfE6RyfohULecci02
 2T7Bqm2EGujhGQV1v/fMS0HqXFPaF50=
X-Proofpoint-GUID: pQ6jqMbcaA-tyvtJFdiYTK2Dl4Q55NPq
X-Authority-Analysis: v=2.4 cv=Ht7jiETS c=1 sm=1 tr=0 ts=6ab13f98 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=btlkdZlGvBFwkIDmIYSHuA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=ViMSs7_4iGOj7njaTlEA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfX4WiTUoFtKFZF
 d3G5Afx34z/FMa4sK2WcCU6pVRodVE244dFXTVrgx4S0fEDbH1365kkE6GXaMoRGNJ/6NqpfsjR
 kMSPEHR+vi/Xg7u3ss4F+Izo/J7IDQDhq/8nQh7MSupLNuyd1ks/1VdgR+JWAUqH7bcdvHuI79U
 iT4wAipEEqiTMbGenD59J2AxdpF7miiisIMtV5F6NxmuuFReHPe5ACH3iKfI8oG4kLT0Qwwo1PI
 vo/iz2rtpEeVkjhv1qQAvYSJZ6I6ZZg60WSCpje2YGr+TWEtLu1eAbn0ze0IgqRyJsBHWHYbdvA
 HaiBXrbqvHWjqUqmeatSqAyAw6PWONFFjZDa8qb2DV4fq1CWwGrjvN2IyNt13JganhT306B4Ica
 CUeN2HmWMi30L3NHUZM2WJczcFakLd+whUQlKcg7ecmLx2LO+MRPtrw/iUFJy+MyNUaOZb5ziMO
 QiU3ZuiAer0NtBLYRcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210211
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2026-09-18 2:42, Yonggang Luo wrote:
> Add cpu_loop_exit_excp next to cpu_loop_exit_restore. Set
> cpu->exception_index then restore and exit the TB. host_pc == 0
> skips restore, matching existing wrappers.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   accel/tcg/cpu-exec-common.c  |  6 ++++++
>   include/accel/tcg/cpu-loop.h | 13 +++++++++++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
> index 44e84344f3b..a33ec922745 100644
> --- a/accel/tcg/cpu-exec-common.c
> +++ b/accel/tcg/cpu-exec-common.c
> @@ -82,6 +82,12 @@ void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
>       cpu_loop_exit(cpu);
>   }
>   
> +void cpu_loop_exit_excp(CPUState *cpu, int exception_index, uintptr_t pc)
> +{
> +    cpu->exception_index = exception_index;
> +    cpu_loop_exit_restore(cpu, pc);
> +}
> +
>   void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
>   {
>       /* Prevent looping if already executing in a serial context. */
> diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
> index f4d38bc2bca..04c14396d93 100644
> --- a/include/accel/tcg/cpu-loop.h
> +++ b/include/accel/tcg/cpu-loop.h
> @@ -65,6 +65,19 @@ G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
>   G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t host_pc);
>   G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t host_pc);
>   
> +/**
> + * cpu_loop_exit_excp:
> + * @cpu: the cpu context
> + * @exception_index: EXCP_* or target trap number
> + * @host_pc: the host pc within the translation, or 0
> + *
> + * Set cpu->exception_index and exit the TB. If @host_pc is in
> + * translated code, restore guest state first (same as
> + * cpu_loop_exit_restore). @host_pc == 0 skips restore.

This comment sounds like implementation detail, why mention that
in the API contract? Otherwise LGTM.

> + */
> +G_NORETURN void cpu_loop_exit_excp(CPUState *cpu, int exception_index,
> +                                   uintptr_t host_pc);
> +
>   /**
>    * cpu_loop_exit:
>    * @cpu: the cpu context


