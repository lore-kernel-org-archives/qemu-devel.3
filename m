Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25136C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zvi-0007cb-SN; Tue, 22 Sep 2026 08:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8zvh-0007cL-HW
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:49:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8zvf-0002ed-Qw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:49:01 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MBPVeJ3671725
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zAGev8toVmUOjsDXiKMUnxUNPGbVeclZre3z2NBHCKM=; b=hfjTzLPbFlc0vUb2
 GEyis9Qz8yKahqqS3ILzhcQl+k09sKnA17QuONUPqVsNMpsZN4ImtdDRGkvW7dNO
 svHxlaJqT95BR4Il11rJS/nvny5HWp67BzzfW/oKtU9+amkMG9cbLzzlxNqXn/Rg
 3X2YtvrBUatAH5GlOoKRe+/XucjPLKTFnfQtDqga9f4wuFwSDHs505lC7RncwkUe
 ShmqTAw+DB0YKzgvS142k5MOQSpXxHNOn9e9Co6fb2j8AnUAUasxZs97JwyJdKOp
 3twxIGAx/s/cnRMFxaCoryxgJLtDJnzxu4681Y5BSSFK/T847Zw0pobpL2JYKcDr
 OG+1WQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurnt8ajv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:48:57 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9832d9be02fso1631774241.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 05:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790081337; x=1790686137; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zAGev8toVmUOjsDXiKMUnxUNPGbVeclZre3z2NBHCKM=;
 b=R9M/pmKLmFTOI88iu51SOpc5hNK0vaquHEraDSJLSOVAfV2JJ+u3shY8DCVtdH85kc
 VlpszQYz9CraMQPmSKth10WpHzjNXaXvVSOsm39OZmqvBFCc09e7BMMD3h6aNl4fQoaj
 J/zGENd4QxTmlh0bvVtNa3XCYRkbYoZ1rRWotqxHbu2GmoqCr09gMUKjv0PZvzpM3b0M
 w5YW1pF0DXZztd67UrbTLUuRrNMoFafhp6C5leCh8pZ92q3vhSgyYG74PlykLj8wabo/
 UVhMvf+/QsfJ8tvKybMJvyERDDs0mwd8c4nYl1Xugi7A3sVVaB7uakCfjZnnAn2yrz+f
 VAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790081337; x=1790686137;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zAGev8toVmUOjsDXiKMUnxUNPGbVeclZre3z2NBHCKM=;
 b=QQqNzKsqt/lb0ANBbfUgrL6/FpoTzKBOc0Qqgmp9sGObNjHLXEcuBM4xo0A1XOIxrd
 v9tvO3elOiNj1Y8i1t11s0DM9DyZ6Yso8HuaZS9LxgBB/A8jt+putsy1THs4cqPPypWu
 CUhlQ4qaptxEXVevnPBbulrU8t5g4oMbg/+VD5TGBHgO7FKAagerGejN9n3PKjBGz9s+
 3nucm8wY2Zg/Y1JKUktDgnUEFyM7/8DTzTJ6E/W/nykKkk5uGMGmlkEoxfW07mB0kyAp
 Wzd9Am88RA8hs44Y1w/nkXh5/V2Az2GPywiwNbTW7lPyeurrozbZ6Xe8arlQOmtGbCA1
 oClQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBywD6KuAN1Gjq8JYKoUYDgJgbmK6A69WOxXmfj3jTXjgGpzd/v7YWirF8nflwUnoKQ5mcMOiKPxoljW@nongnu.org
X-Gm-Message-State: AFuF++nx9NxcPUdppkWMXMhXzkLvWkXcaQHzEdzovQKZfBfN/dxgiI39
 Z6ySx5g9uUBxp2Nsgrtzp6Esg4QZZFx5sK5aweRQs1LyhwetAyLufqqz9SISX7F0C7A1mYcg/bh
 H0jLBzehOnZ7pMOpUdBRtEd6PEjL4rxdTVurnms8ljMQqYektyjqFHi5PTw==
X-Gm-Gg: AYBFou0Uft0BW9ys0gYcO1nnAuIDnVhP3JTcQIA0fKhtUa58FwUx0+Eyb0Mb7Df5rVL
 SDcJLxS2nlt//VWKupFW2y7KF3qsShYVNkOxLj4Pc9BOXjfrcIup7clJ85FOwwJRSGRlIPWEIND
 P4PaDSL/QY+xGyQ+JjGCMjd+QAI0Ia/1Mhni5x6TOhcLxLgiRZDcZnxJKKhKeAbhqtRlqRdV90I
 bzb14GcOE4hRty6mOCJS5lp4hsP3gqRgZ6jgXLtS5JPmG+JruywtDjXkW5GiRMGZcLKNn2HmGPH
 ObwtRuOhCF9fu8glFLxW3BljxKHdGxPA3XMtxsdqsADq2lQdQN8hsycjI58Pe9TsiNDaszoEs+0
 hscsyiDeFFOOBaAXpiEE=
X-Received: by 2002:a05:6122:8f8b:b0:5c9:a60c:2732 with SMTP id
 71dfb90a1353d-5c9b58e9e3dmr7540577e0c.10.1790081336722; 
 Tue, 22 Sep 2026 05:48:56 -0700 (PDT)
X-Received: by 2002:a05:6122:8f8b:b0:5c9:a60c:2732 with SMTP id
 71dfb90a1353d-5c9b58e9e3dmr7540541e0c.10.1790081336231; 
 Tue, 22 Sep 2026 05:48:56 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.52])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886277e841sm5540993f8f.19.2026.09.22.05.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 05:48:55 -0700 (PDT)
Message-ID: <25b4032b-d5d0-44ed-8733-cf43d4a3fe26@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 14:48:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/16] s390x: protvirt: Set guest IPL PSW
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20200319131921.2367-1-frankja@linux.ibm.com>
 <20200319131921.2367-11-frankja@linux.ibm.com>
 <3a8d34b6-a0cb-46a4-8ef8-6d8b029bf253@oss.qualcomm.com>
 <a27063ef-f1dc-4560-bf8c-5abf315abd7e@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <a27063ef-f1dc-4560-bf8c-5abf315abd7e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -qggLSY78aG2UDfS3ev2XjNjzEuBX9pz
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab27939 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=QTt6BuOzr45adi7bDCnRgQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=oM9xBGLr6McsaTieOokA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE4NSBTYWx0ZWRfX3uPBgqhjTMnd
 +oXk29kLinlkPTmj87JtksfWDOwcn1+l47Etbqvx6RUe3EeAXlR/kPjuEOzLafiIH+sYGVZsTWf
 fWLQoHpulqquDcCrDQVoHfKZ8tEm76rONCQFXZIs4e7s9fGNpJ/6MdKRF4FY1D4vrYAQMI45Toi
 vS7WjeN09vNGNw0xn0RsXaxZZTZaSWXI4nTWnYkwM3aCl6JtaDThzpYot1WlLpteln4NT3Urj6s
 hxsGYEo7Tz1+iW98aLq7yO9M74XKzciNWapTXxu/vRkUSrR4VDxRXcOpqEcFdIXc85M8U0LJk0k
 AKrlPYC1dIu5kR1OmzL5TW6xq8JNJKYXQRaE8D6M//ijygxfRsyDqGrB0i4bvcKYEEcXKfJBdy8
 0Bp7pmUojiUgQ1xoop7goQLQWLDJRoQ1m1alQnzSJQzczA3K1FdR39tfw/yEYObgNEBaksPkMbF
 IdNqz/+wih2X+W/PnuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE4NSBTYWx0ZWRfX/bFKLquIOl/J
 yohkAmrwnPru352US9n0jM9ykdvKo2badix/TQQkw8tol/GLtI90OrshcTPxeVEbeiMOuroyBh5
 qqMJCg3dOrINk9c+lvIMx7b4Ga63cqI=
X-Proofpoint-GUID: -qggLSY78aG2UDfS3ev2XjNjzEuBX9pz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220185
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

On 2026-09-22 13:16, Janosch Frank wrote:
> On 9/22/26 10:56 AM, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> (old patch committed as 59181010a2ff82c3a97e9b5768ee87c38e4815f1)
>>
>> On 2020-03-19 14:19, Janosch Frank wrote:
>>> Handling of CPU reset and setting of the IPL psw from guest storage at
>>> offset 0 is done by a Ultravisor call. Let's only fetch it if
>>> necessary.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    target/s390x/cpu.c | 26 +++++++++++++++++---------
>>>    1 file changed, 17 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>>> index 961e3ebdc530cfab..71a0c9b3e55d0cbf 100644
>>> --- a/target/s390x/cpu.c
>>> +++ b/target/s390x/cpu.c
>>> @@ -77,16 +77,24 @@ static bool s390_cpu_has_work(CPUState *cs)
>>>    static void s390_cpu_load_normal(CPUState *s)
>>>    {
>>>        S390CPU *cpu = S390_CPU(s);
>>> -    uint64_t spsw = ldq_phys(s->as, 0);
>>> -
>>> -    cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
>>> -    /*
>>> -     * Invert short psw indication, so SIE will report a specification
>>> -     * exception if it was not set.
>>> -     */
>>> -    cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
>>> -    cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
>>> +    uint64_t spsw;
>>> +    if (!s390_is_pv()) {
>>> +        spsw = ldq_phys(s->as, 0);
>>> +        cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
>>> +        /*
>>> +         * Invert short psw indication, so SIE will report a 
>>> specification
>>> +         * exception if it was not set.
>>> +         */
>>> +        cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
>>> +        cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
>>> +    } else {
>>> +        /*
>>> +         * Firmware requires us to set the load state before we set
>>> +         * the cpu to operating on protected guests.
>>> +         */
>>> +        s390_cpu_set_state(S390_CPU_STATE_LOAD, cpu);
>>
>> S390_CPU_STATE_LOAD is overwritten the line above, is that deliberate?
> Yes.
> LOAD is a superset of OPERATING and doing a second OPERATING is 
> therefore a NOP.
> 
> The load isn't a real state in KVM, we only use it for the UV call.
> So we have to do a second change into OPERATING for KVM to track the 
> state if we were in stopped state.

Oh OK now I see the KVM_SET_MP_STATE calls. Since it was not obvious
to me, could the comment be updated to clarify that? (no obligation,
feel free to disregard if you find it clear enough for you).
Thanks for the quick head-up!

Phil.

