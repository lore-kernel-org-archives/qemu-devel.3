Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3E606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iUCYipAf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gmcfqvbn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLc1-00079H-Ct; Mon, 26 Oct 2026 10:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLLbz-000790-Q0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 10:23:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLLbx-0003sV-O5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 10:23:43 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QCtU853348918
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HSr4kZ5EHm2gmSc1IUNkAfg92+5OyVLzOxGsnBaGnDM=; b=iUCYipAfHzRMYs7J
 AMXVT69MSYo7D9QFoIKCU8GAMVc/XApatbKXmjC+awBZu58OPTuA8CQcLL1w2sKI
 fggbTmsodySGIQW74256Q93IWpdddVVIJcubFX6EDTxbIb0xbol+5/5GRJHXbYQU
 WPpu82g+a72lmlZ3HWE10vnWJVA/B6B9o5DJBpB5OUlHGl7mSRlHPq/urpjF7Qdb
 kXUSBHJIV7Ubt2zmHBg4p4vrEiUJPqdzcT2tzpON9VPk5yPCuC2trpZvp3+L7Qus
 N5UOQSgfUStZP2CjioUcgxkO0XCCtdMqtAp42cku2MvMMFpYpWhu0d8RgsVmvX6l
 c7bkBg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xrbb4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:23:39 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-988bbb0ed9aso2878697241.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793024618; x=1793629418; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HSr4kZ5EHm2gmSc1IUNkAfg92+5OyVLzOxGsnBaGnDM=;
 b=Gmcfqvbnmt3BKQ4plMWqLKZe25l0ixcMoXjw2mz+3BxdiH6g5pjnOUDvJiHYdiu6KL
 dg69AnJ1mo7QFpp8IEY8ulwCAjkK/IaOdR37iaVZeMyVGEn2qrrHXakqmTVFIlJE6Sox
 kAPS7kLT1tBduXtJhD7U6Q7kYv54v87ddetBhAgJQ99SX/bp5i3YwzmfbV5XVY46OTHY
 BlHKn0PHF4yRkCnEL7Robb9tfz4R6wxou7xh3N0m6YIVXOeC91TaYvc7FZ/5p6mGyzng
 ZQOL5S9Y0HNpE1mu78HSG9o8qPrKUd6wDOowLS4D7XnmdmojLMuYnlIZArGduoSDTOMk
 /Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793024618; x=1793629418;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HSr4kZ5EHm2gmSc1IUNkAfg92+5OyVLzOxGsnBaGnDM=;
 b=UBPsnTFobbDzMuCn6VCpfbVdIjE/WfCK8xWr10P8AqSoJDHnDBCFHfeHxDf/Pis+mv
 11szZW5OT5cmNsIW342ZUqm+RT0JYIkuMllex8zQ8EqChQRRBLz/iP9UUG6SFX+z4Q7Z
 bcfKt5rqbDgLwvaVkHTjVWs8cdDaYmFnIcYjwvegDNCQthQ4FCOCbzRU2LkNJdBX8LfT
 8b+ZVS8JAe78zdKa7LUZ2Gtq6debTOkJEDhhny8ZyK2Oty28CVh90N+/jz8v87EBViPS
 /QaSg6HzRIU/MEhvWghGasOrw6siGHOkFw017v75qn/B6F2LQidNm0FiVTb37FusHWLr
 FuLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCMn7X313QpTvplCB/xCB2GY1qYs+ZookA5BeJCY5nMPZj/ZMmXME+LL1/p31bwyPm6xX4JGrMeEit@nongnu.org
X-Gm-Message-State: AFq9FYLRsie/k/qGHv4ANe/auR9AbocdGO3MLTLWydcQ85R2wCmOYMjJ
 7UG/B1GnQwzFrt4SsDaTyugSGLTqDMFKDQ0kdGnBxATocK3S7IrK5njrsgRxKNA0zfRtUi/kUx3
 ShihG/ticBQN0TNUBLva7jix6Z3yzW3m9rNCbdQ2lN9x6NRfbHBnlCXaM9Q==
X-Gm-Gg: AYBFou17JcrBnoyNdy8ytUg5jbOj+ZodIY/AIK/wnDnkUum5YNdU08d73psem/HVjQd
 pAYSjp/8hbETW6siRYlCTjU0wEBsdrDtzMzfQiPoBRsDzjS38GHoDpT6uy6j61qJhpnWlD7cM5d
 4W8Vr7uFJLrJd0/mgQzcDKdUP/yS92n7IdXNBkzxinx9kTn5YyvXm0JTp8OgHMsqjx23jNPaUzC
 VDzO0dpXAX47m2iPsxvqDNvP5lPKjIVWb9ixASdlBJs8U08wC3FDizoy3TnejcJyE/yvm0Yukdp
 ByKYQPwnlGFmilVnZ2q1uVKNQBlKY6wDz3eeuDxU2YQ/r9U0kYW+6fiZjqkzY9XOsbDD34iCGWI
 jp/spUT4Ucmlm3HdHE1CKAn8PyNlVti5P9w==
X-Received: by 2002:a05:6122:6990:b0:5ea:e324:7c15 with SMTP id
 71dfb90a1353d-5ec232ae080mr2384094e0c.15.1793024617888; 
 Mon, 26 Oct 2026 07:23:37 -0700 (PDT)
X-Received: by 2002:a05:6122:6990:b0:5ea:e324:7c15 with SMTP id
 71dfb90a1353d-5ec232ae080mr2384065e0c.15.1793024617436; 
 Mon, 26 Oct 2026 07:23:37 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd47basm18247240f8f.32.2026.10.26.07.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 07:23:36 -0700 (PDT)
Message-ID: <ed8cb4bf-1079-47ab-bc76-732db740c416@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 15:23:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IMOlw6XCpMOvwrxbUEFUQ0hdIGh3L2kzODYvdmFwaWM6IGZpeCBh?=
 =?UTF-8?Q?_deadlock_between_vapic=5Fwrite=28=29_and_machine_reset?=
Content-Language: en-US
To: QingboZhang <qingbozhang@linux.alibaba.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: pbonzini <pbonzini@redhat.com>,
 "richard.henderson" <richard.henderson@linaro.org>,
 mst <mst@redhat.com>, "jan.kiszka" <jan.kiszka@siemens.com>,
 mohamed <mohamed@unpredictable.fr>
References: <20261026100933.12715-1-QingboZhang@linux.alibaba.com>
 <3b1e0087-fd62-4149-b8dc-273885ee9e14@oss.qualcomm.com>
 <99666107-a0ea-44e2-bf99-f7738dc38cdb.qingbozhang@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <99666107-a0ea-44e2-bf99-f7738dc38cdb.qingbozhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GqMJPIWHrEW1CSwlJNUOLnMiJXUh01ly
X-Proofpoint-GUID: GqMJPIWHrEW1CSwlJNUOLnMiJXUh01ly
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6adf626b cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=5KLPUuaC_9wA:10 a=M51BFTxLslgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=a7Q2PLhJvwjAbfjkiekA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NyBTYWx0ZWRfXxVoTDo7X9DJt
 +nhqC0JcC+mto5WP9lQmGRlGJ85PfJq008CmLo9t6rBG/e9BTT8bKOXEuVLVT4kyRuBr9GyAjTr
 h4RRhjtHHqAwIhEwuIbA8uq98dJMlha13LDyNaslxhxmBAGKcGC+eKAC8Oa67XLcMtnomj+0D2x
 +D5Dx4L5Mi36TmWPtKKPGnGOnN+eg/hLs3ude3nLupp96EaXE69uVPpYzb0mLpAHrSN5SpGCWYn
 lHar9KjkBqidHkoJE4W69d39vd4SvnQxAPEBgcyVVrlMMHgFVNGmknrpRUXuDc2QMkXHRHTEfoP
 d3O8GrByPoRi2KGzlIXx4yPbkjD5bss+qjfXG+bk5cOnpF0vfc/A6KhUOVieIiLepX/WXMNhpnU
 Wze0zkEBxT9CCcx7/wc+i7gej6RTTepyejGJ3xCK803DO5HclT++BHEhwwv2qQTWAcMpiQ/ocmR
 q6Ocuw10eqiZwlmKcrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NyBTYWx0ZWRfXzcBwQNrdceng
 1fOJzZwqHIMHpU6LImqo1iYlFgJKNkRUJTV3kC49h2WwSAh91NWq9HHCuBtfSWC6YnDu5RAwRd6
 Eov/0fYXQ8cTzNcgtWNKiAnulSEb6ho=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260057
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26/10/26 15:10, QingboZhang wrote:
> Hi Philippe,
> 
> Thanks for the review!  Brief replies inline.
> 
> On 26/10/2026 11:57, Philippe Mathieu-Daudé wrote:
>>> Fix this by patching on the current vCPU via async_safe_run_on_cpu() [...]
>> Maybe worth citing similar TCG fix in commit cb58a6d3611b.
> 
> Cited in v2.
> 
>>> +static void do_vapic_nop_patch(CPUState *cs, run_on_cpu_data data)
>> Rename as do_patch_trigger_nop? And mention this runs in exclusive section?
> 
> Done in v2 (renamed, and noted it runs in an exclusive section).
> 
>>> +    target_ulong addr = (target_ulong)data.target_ptr;
>> Pre-existing, patch_byte() should take a vaddr, then this cast is not needed.
> 
> Agreed.  I'll address it in a separate follow-up cleanup patch.
> 
>> For non-x86 experts:  /* 2-byte NOP */
> 
> Added in v2.
> 
>>> +            async_safe_run_on_cpu(current_cpu, do_vapic_nop_patch,
>>> +                                  RUN_ON_CPU_TARGET_PTR(ip));
>> Why change on current_cpu, can't we simply use CPU(cpu)? Otherwise:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> Indeed, switched to CPU(cpu) in v2.  I'll carry your Reviewed-by then;
> please tell me if you would rather I drop the tag.  I'll post v2 shortly.

With the comment addressed, keep in in v2 :) Thanks for the quick update!


