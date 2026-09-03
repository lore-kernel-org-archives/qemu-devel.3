Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F7BC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24FM-0000P8-Jm; Thu, 03 Sep 2026 06:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24FK-0000Oj-Ah
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:00:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24FI-0007QH-Jj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:00:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68392W4u4079049
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y0QFIAY1o8u0vQe8S6AN7lPB063jMfGs/KuwoMyJ2G4=; b=biI3vrImSWHh8ilS
 6ntKwb28Yk0+G4hUYxPHKYUbJlS8LLLjYryoennQx5BBWCIUokY7mzQ/T7Z32WMU
 w2z+vbFzb6BW6J2sTlP3TvG3NV6Rp38igsN5ouo/h4CLUsBlCzwPGp5cQdIGK3EO
 pGbVf+MUXyKR4pfOP1gLCuUEzUGcPFltKMBaKItrFZ5nTPq2qx3m/XjQE62L4GEn
 4mb+bfRKmMjZQwxCMTF3c1YAPnVHpAxp97XWDHlD7wH8WCsV44wbVJX3/YiN+ToM
 YqZm/vY6dagMcZ7L8abHe3vypQefQXVGnPtVRWxomDUyHFzRrwhv02HfLoTYqF/a
 boxqRA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdvb9t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:00:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93903622880so152094885a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788429634; x=1789034434; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y0QFIAY1o8u0vQe8S6AN7lPB063jMfGs/KuwoMyJ2G4=;
 b=kq0e8lgoEeAJtopJ9nHeAkH8P7/xpp2C6R6EDWlvPbIZxUyGjc+263fOamUBzt/pil
 LrWKhQUrhyWaVuWywtoVk4vKrGKcLeSh1jMOfqfXI6I91nilIlturcIDGunr4iaAVbet
 BM3ZvigS5XwM6Kr7uuIZo6GYANLS2fWnGOpDFPRK7J1Y1l5coECrx/Zv8/HBBjGyXLW5
 oSiE5Lk4RNwkyOaPrQCqMb2xXyKSmwke/9MHNJTiyBeT6GgnDzfdR/2YYOuRn/tO+Sgs
 HQW/WHhdUBygLAwVG67Z5UIytO+fLQliLIXom3JQs70JzL4a+6p5c7jR5TiRCJJ5x+9M
 omIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788429634; x=1789034434;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y0QFIAY1o8u0vQe8S6AN7lPB063jMfGs/KuwoMyJ2G4=;
 b=TfNL7x+qu9KR3ze8fdsoscrkGjZimPyjTxC/dx0LT0kFDU/0FSYmXv6YQwS8rE2Qct
 hX2sDUcc7gZJ3jrZmS1lEwM5KBURFLpVdPKDtG3wY4JkP/VL4D0Oa/slomIK3V+x17PT
 GknpWa+B52jVRZ4iX0v5zo4OTZ3zCNLHDGHhgvIJ9I7uqBHaTjWXNeGHaA4yMgjt/Lym
 EraQMncpq5n+uunupIICD35qMBmSJDFff0SD2ZQOifXKrD4iEFKVAQC4HpHTZpfyefbQ
 3h5KeS4KaDr3iUt0b5gwqsYM49OPa791jM+LaxwpdxdKfKuKNHIS836kYx8PdIWDK6fD
 4YRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyjc5BVKw+48wqgM7L4FIff/R3e0nXq0yynlVRUwvD9UweGM+ea5jWGB9wiCI+4kN5cwFezAo14ybZ@nongnu.org
X-Gm-Message-State: AFuF++m7NaAs7JTFm7PzV55taJrtupMlf8teHZV8zK9jyMLo3UDK6SYH
 8hXdkwgpW1bPH3l+A2lfwNzSFgiaNK3rdLjJuB7JvTMpyxJ5L0vNPPguRHe7rLMDIvuFMQNlEAM
 tTJX37VfwGhyHRS/R10hYOMD+b+22MMNv+pfrYJDwle+SL9x4vMnGRe3wsTWjK2TQcA==
X-Gm-Gg: AYBFou3XOpUBrMNqYuznyJH8lcwClKxduQ7unehM/mqpibmvPrYlKdQezry1zMUhbHh
 zwd1C8AcxWElOtWyyN9JYasYeCwO4O+8RnmA9gigD4VTbCAc4DFGl7jIZEi+/OQBc9fpTxV/+uj
 uOidoeNabX3JV1s8U7qdDcGQzmWZeNUGsopH79MYt4GLgzuOh0qvgg6DY90ES16umvUaKF3hKaz
 7VfYO74xf7hdHkRU/6eaNcKdJQxnMtakDJT3aNPugb5B8q/YcV0LJ8lI4nLp0DAXDJQd4/H91qk
 EFCod3To8ho4vxVAOgNuY4DQ3zsuQjSIsqdCK7ulZZSkM7otpLuIjRzbQJIunFOATLY8i2h0QUz
 rGCkDyDOEmyMB79+JZOLCDadfyW8DR6Dvpg==
X-Received: by 2002:a05:620a:640f:b0:939:72cb:bae8 with SMTP id
 af79cd13be357-93972cbbc70mr167067885a.31.1788429634118; 
 Thu, 03 Sep 2026 03:00:34 -0700 (PDT)
X-Received: by 2002:a05:620a:640f:b0:939:72cb:bae8 with SMTP id
 af79cd13be357-93972cbbc70mr167061685a.31.1788429633568; 
 Thu, 03 Sep 2026 03:00:33 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3840sm13435892f8f.17.2026.09.03.03.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 03:00:32 -0700 (PDT)
Message-ID: <974719bc-fee1-4ce1-bfcd-068f94d5112b@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:00:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rustfmt: disable wrap_comments
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20260902083624.419157-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260902083624.419157-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a994543 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=R22tBeTbAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=UZTngdDptg4vmoBOAbwA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=71pCXManv-pOE82v44e3:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: UEpmB5v-i9w40Wn33mmWW0gGWPtIegdW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4NiBTYWx0ZWRfX/4++3DoLjYOh
 cK7jnHKozTuAU3TyFudKCmP6URr0ogiG1ozP+GCQHAq63rPmilAJ9+QbLIqbn3hfNW5Eym3ZdMt
 aehz8Z9fJrIFleuKA9tZPjv8DuZT/H121JFdmZj4iU93VT2o5TOdPzn7tBjLn5r4tgSTamHTZxz
 zS8sy4R5lZSe3+8JVZqNBuQDk8zz81hIHg+qu6KWCTOdrBRuFQdDBxUv1WdivRl6P/KrqDHUD5R
 fQxrQizN6i2rWfGJf5hY2k3tdDtEQTIOF3oXIsm8z6c617iwb7o8A5wes/gm0dkNmFawJSeptSQ
 4n7UUvgP/8XICgXAJxAT/R1QRUn2B4w49B0uZo0kpb4LYMMQigI9EzyIyZaOEZGLhjRo80CF8a2
 SdFMNg3ZKU0LzR///e4q67ic/dAfUYbzXM+7vCRUyp67+FC5/owo3oA5TYk6ZqS/5grBhCfVSLr
 N9OFZnYi8zFg8tbQoWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4NiBTYWx0ZWRfXw52v83LYvNUN
 fU4zGGLNJaW3P+9vih47UC8xaTq+SAuC2SywytKzmz8whEBMm0aP9XZEdSIRRCX45WxdVupoxFc
 A08OWYWocSlmsAkzCrxElNJtIR0n8jE=
X-Proofpoint-ORIG-GUID: UEpmB5v-i9w40Wn33mmWW0gGWPtIegdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030086
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

On 2/9/26 10:36, Paolo Bonzini wrote:
> This was in practice not enabled until now, and now that it is
> the results are not great.  Disable it so that the CI job
> check-rust-tools-nightly does not fail gratuitously.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/rustfmt.toml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/rustfmt.toml b/rust/rustfmt.toml
> index ebecb99fe09..a7d610bce21 100644
> --- a/rust/rustfmt.toml
> +++ b/rust/rustfmt.toml
> @@ -4,4 +4,4 @@ format_code_in_doc_comments = true
>   format_strings = true
>   imports_granularity = "Crate"
>   group_imports = "StdExternalCrate"
> -wrap_comments = true
> +wrap_comments = false

Correct per 
https://rust-lang.github.io/rustfmt/?version=v1.10.0&search=#wrap_comments 
so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

and queued to unblock my GitLab CI, thanks.

