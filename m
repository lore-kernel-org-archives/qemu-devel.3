Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E4EC624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1rtB-0005Ld-IJ; Wed, 02 Sep 2026 16:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1rt9-0005Jc-Rb
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 16:48:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1rt7-0006Eu-EB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 16:48:55 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHKOg2025608
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 20:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 08sQKBeUS0Q+DiC5YvSIwZRoNWiSVPDShm7quIIK7hs=; b=Q7dIxGvy3xN6np9f
 RWfg8JTh/1Bi6jg42vlu8o3oaRxWwRwehk+5T5FJ4GhjFHbXp/dTfVvI4SqKRZej
 a16E4w1gfomeQShFllZS325RAmdSXX0Dzf5qrdq+4iwaosLRmNhwkQYGjsiU+Qg4
 0BJ5WMDxU0yccTeOoaShoxnAoI5v6PHiB/fY7wc2KsPIu2GsK4r3JF7mBCUnoLwf
 XP8XvDLPTr0EI/jw1HKb2EbL1eB7h9eybycmAgiCt4WjUODa3DJSJfCqJMkWnMxo
 3vx1o+19AEdg0SOV4/SuMFn7Syt9OQRPVAWpTLyz6ZcOinx+I1QKV9QjZazgKPJw
 IEi8mg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemcea0hx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 20:48:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93915f50a5cso64156885a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788382130; x=1788986930; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=08sQKBeUS0Q+DiC5YvSIwZRoNWiSVPDShm7quIIK7hs=;
 b=FQyrGYwZXgbl49omkw9pWOA1xWuHGxXfOxVLjfzPpqRZ8x3h6DkyrAEE1+vxG64Ec+
 jo8yZAFSQpDNe+/QNu9Dxisecqn/1gSJU1X+dz/vPO2kgV+ASHYsR7xATVc931D8iq29
 DwohaAwhqLyjQZ+FnskJEmcvi1tcsYbC99duDOOab67krZk3PumdF0+GGpcp/A+MneAq
 KRBGfI/NGKF0WnJluxauDE3s+78mOt8sWbMwjwXqca0IhpVkPuBgy5svxJj1s6zROcRp
 /Pl0Kr0ymdn/SS74ZgeJm1ObhAXiuk3mEqsHmtWDhX1OoqZoK0TRiZEV1FeVE5Aq6T2C
 8paA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788382130; x=1788986930;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=08sQKBeUS0Q+DiC5YvSIwZRoNWiSVPDShm7quIIK7hs=;
 b=ehOO2sejPd4JGmmEGkVRtoI+6B6murcAI7RN205+RR7BNP8GzHx06UlzSeXp7f5JFK
 v1xpCnJMbNe+ixFgnncUiGJ3buIveYioKlee0ICd5ePqrQaHTyOWyzlay/4gudDk8Mwv
 cesZ3dnGGuU4+aM86MnSVaRePLiG03NBJan4u/OUyFSZ9eC+xeYp211QpvOXXak6rO6I
 juBszwK8SgfwIgQqT8MjIV12zGvcVJ1jK/8yDuFbYAftGAWu3lNIginF+/0ZUmEcZgMF
 AEiYlwa9gRkqD2DlkKEU1a0NHifCZPKXvtb3mCUF3JcvfyrDPiJXxS1R8GAWmgrjc3pX
 7bDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+Z9jHM49b7rVpuZ1g0/JkfXMNrDcQzATEBNPXc4RbgBOcqW/HUdmHW4vIQjiYUJgUCI2zdl41LSUz@nongnu.org
X-Gm-Message-State: AFuF++lnCO3lv53nh69uShpCadafGn+tmryZbJ6YJI0fMehmS7n51tNB
 vvguJYg5fkPiTq/61bGSXTHyrjE3gLAi7bHTqE4XtKmAEfd9Vqjysam5j+jHF8kYXhGsqBERm5o
 xfEQD76NgzzNgT4C/dtQR/s9wGwTVA0rWN83htrI4YL/B836ny3F97+aG+A==
X-Gm-Gg: AYBFou1NluPDtufLN67TQ6cJZh7LyCs+1tXiBrgeA2untSHPHohUTQvGhdGCotuHgw6
 USZT7dZ7npxa2EcU/PXSFJCZ0ZyLVa8JLzQz7nXnFoOYeJ9dgnsBA4lIBfbYHa7GtwDg865U9Qv
 wgFPGkaqfx9BrQVR8vemxz9VLPu7Rea60OdmUJhK82qOrkBndhFr+rWVL3+YAJxFdn5MU5AQe98
 QkzFJT3P6ikc4uksDLWpVS8LoUASwjoBrevFPcZHXAZMXIYQvcA9tCXcVsM8Jb8Iodc7+IXBVjV
 aM/fnRLx9jFGb4WEpUiFOD8UnAkqew0oA5cITKXI4t4hrkYuX+KU2xhoDRwPanfyy9D3jAoh31T
 iWqjcoqO0+Ao7PBJbIBSIqA2L/taWkUbXHw==
X-Received: by 2002:a05:620a:88e:b0:930:9cbc:7121 with SMTP id
 af79cd13be357-9396deacbbdmr203133285a.3.1788382130543; 
 Wed, 02 Sep 2026 13:48:50 -0700 (PDT)
X-Received: by 2002:a05:620a:88e:b0:930:9cbc:7121 with SMTP id
 af79cd13be357-9396deacbbdmr203128885a.3.1788382130074; 
 Wed, 02 Sep 2026 13:48:50 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492ce236sm9890668f8f.35.2026.09.02.13.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 13:48:49 -0700 (PDT)
Message-ID: <08547223-7789-45de-a0a2-251f412cedda@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 22:48:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] accel/tcg: Document do_interrupt() callback
 contract
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-6-philmd@oss.qualcomm.com>
 <1251f0e3-237f-4f31-8d2c-0dae5e9962b5@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <1251f0e3-237f-4f31-8d2c-0dae5e9962b5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4NCBTYWx0ZWRfXwECpxqU6y+ng
 Fob7tz41+R5bmRhd94104IfrxTAknHs4Zg4P4+HVGehnrQBcCAcDh4/NdrR5JbQWTP45+mN1huS
 4wLIxpolbnM57QpjLEpIoMe4pSTslRAc740TqQzy5ARt/rTYsFz2AC77zGNS9tPre9R+vZGfwA/
 lrKXhexj0VMZzkX9TeA+FmYhN2Ixc8BaqA4KskGcjrFa8AxondgNShVloIWyghgGaQbiRA7k5ha
 qG6amufPwLrvl0Dsj0ZnIrAVMxiM23/i0pxX+ijKEV6mpTrebRGPurr5iJstqdGczh0W5AWl/gL
 hpo3Zu22Yy1LxQ97kO1QEfw2n5Y6qpa59FtU4051sAC6Y317i+XaRI50UZnxo1GO2ex9oJqDr66
 zhIE7yiCSOVADWqBVqFGBWl1mnFgkVlfpNk9tPIB+PpKeoRljqQ6k7Zpmxnfu8V8aw+7fHVvCZN
 QZIAGSTidFP+tZwpxeA==
X-Proofpoint-ORIG-GUID: Hce_4_ezRoY0-0T4y1y9WfhvRcefwcHP
X-Authority-Analysis: v=2.4 cv=QfpWeMbv c=1 sm=1 tr=0 ts=6a988bb3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=6ax27t2Q9qs3WTDDNCkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Hce_4_ezRoY0-0T4y1y9WfhvRcefwcHP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4NCBTYWx0ZWRfX+LPLsDW6lgsS
 9N4hH5EKRDv8kV8R/kRHMwTPyLZtWP0OJdOScM7F5Y3QUIQ/E9QT17rfbOABG9oWrMh6+Sk2UWd
 CFNoOay9uAP6Im+Ytly2PDaZGOurAss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020184
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 2/9/26 21:54, Pierrick Bouvier wrote:
> On 9/2/2026 8:20 AM, Philippe Mathieu-Daudé wrote:
>> Expand docstring to clarify the handler is called with BQL held.
>> Add assertion that this callback is mandatory and never NULL, since
>> all targets must implement interrupt handling.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   include/accel/tcg/cpu-ops.h | 11 ++++++++++-
>>   accel/tcg/cpu-exec.c        |  1 +
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
>> index 87850402203..13df70eaa9f 100644
>> --- a/include/accel/tcg/cpu-ops.h
>> +++ b/include/accel/tcg/cpu-ops.h
>> @@ -169,7 +169,16 @@ struct TCGCPUOps {
>>        */
>>       vaddr (*untagged_addr)(CPUState *cs, vaddr addr);
>>   #else
>> -    /** @do_interrupt: Callback for interrupt handling.  */
>> +    /**
>> +     * @do_interrupt: Deliver a pending exception/interrupt to the CPU
>> +     * @cpu: cpu context
>> +     *
>> +     * Called when cs->exception_index contains an exception code to deliver.
>> +     * Updates CPU architectural state (usually before executing a guest
>> +     * exception handler).
>> +     *
>> +     * Called from cpu_handle_exception() with BQL held.
> 
> Would that be clearer to ensure this with an assert instead or relying
> on comment?

This docstring contract is a help to implement callees.

> 
>> +     */
>>       void (*do_interrupt)(CPUState *cpu);
>>   
>>       /**
>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> index 609931a0d6e..2fae2c024b8 100644
>> --- a/accel/tcg/cpu-exec.c
>> +++ b/accel/tcg/cpu-exec.c
>> @@ -1059,6 +1059,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
>>           assert(tcg_ops->cpu_exec_halt);
>>           assert(tcg_ops->cpu_exec_interrupt);
>>           assert(tcg_ops->cpu_exec_reset);
>> +        assert(tcg_ops->do_interrupt);
>>           assert(tcg_ops->pointer_wrap);
>>   #endif /* !CONFIG_USER_ONLY */
>>           assert(tcg_ops->translate_code);
> 
> 


