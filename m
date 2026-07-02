Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE6BC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHwH-0005a6-8N; Thu, 02 Jul 2026 09:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfHwF-0005Yp-33
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:58:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfHwD-0002XU-Ml
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:58:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D13RS523776
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vdq+3qdw9YyaV9zU3SLJmRbB0Lw9rAQiZyKrtqxhxHA=; b=H6DpKZ3UXkXnoqPg
 NE9q/OfRGQC1T79juLTCeW1fTj+Q3NOtUhoPxOJiPnAIk/GPkSDvLgwFqsl5iQeY
 xtDjxSLE2Hszk2j2Cct/2bw3v0j2kQzYV35iSbIVFBUcsEOQLm5azPYMGO4bLkyO
 iEIjdhHfeACzlqq9YeHhjXZpFS1jaWi8LGWSTOtYHyuqcLS9nddvC7cdptfaYdEK
 v+QOECfT9OChSWtVwNwnil0ubt5f27JnnfXx3zDa7bsgUe4pPvZPwUSLv71Byxxr
 JlbQ6Q4DsJCtsbyIidQce/Kk6EHJTc+gNlnUXaiRl0dfLJt5NJ17+Fmj15EKGYGo
 pQExqw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541w20m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:58:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so218457885a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000723; x=1783605523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vdq+3qdw9YyaV9zU3SLJmRbB0Lw9rAQiZyKrtqxhxHA=;
 b=O3vgcJaCs9zP3lJKCX7EZmJ7UfYwXMPPkexK2Y4MSk3PkwQHxDB2QyiytqsyWhpajY
 Mi0RzVBSW4em0uoLQSinBx1a3w51jbwLlEeV0mDP5YddSKTuNfRzXcxKvQk8UpovfDlU
 tHE2/g7OV8nXNWEEL4Xw3r4kjUm1+GBtXicPp0LpIXJHsLzDn1zWHtD/4rUczD/y9div
 9WgOJGRBRvfmw3YQmTHs4m996o3edOQE+JtvHJ9Y9Q3SOBkZTNwazqoDHMbiazaTgACZ
 AoRYFEF7mf1vc2B5axKkJtPghPDEuqNDEkNlSmQYCpHdcg0RoZGiYCmXBK7nPkHXvl6G
 VlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000723; x=1783605523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vdq+3qdw9YyaV9zU3SLJmRbB0Lw9rAQiZyKrtqxhxHA=;
 b=RXxkQfd87gQs1KRbsamgIMl7uj9EQYO/MyobWaZZ196+3sA+ojJnrQvX6OXSKkSfjh
 J9Z1r9l7J1KzRJxaOtjiOtX4PZ9PnueINYapro1b60HVckXVq+gK7DZWISJwI9X5IYuc
 WfO9K5P2pGcDEbiVLLhR9oraIOYNuJS4a9YxAQF8euVaXHSz+7MIVrycYLW7YnrJmnn7
 mvVSbuwroJhcJaONEApiUV/QhP/KPaLmGzprK8RFz0eUaX6xDH1JO/hkSHRqU1p2oq2V
 Vb2BFxs8cp0b4gqBbF3wbSL/7ka2dY4jX1jeN9KDxD58MCmsMkuoS2tUeynLaCG2Avl2
 W6nQ==
X-Gm-Message-State: AOJu0YxclrHarOaW/DwT6+4kkW7Hcdwt3mZvm4mCgVSojv98t9aQWUta
 p8eBNa+fP/FIM5WJ5NsDdwxQIfBNilCRx2yweKsc4iw1CqpXbNSm1W7sJUtkQDaxGeDxCeqRcAV
 XdoICGPgmzrsXN7mC7ZlDZ6No804OMojwIltKW2Wc4CPus/jewjV5YQSmM4ytJdmdbQ==
X-Gm-Gg: AfdE7ckfL7U+rE38h7QZgtSwUDco2/83CaQ9X/m0T+FDTe4YaFHSarnlF75sc9UTAcO
 iRm9Xi4xsGR8JQAC4Bd5souf7fhDxVRfJfo3fw1/SNUrzu6e9yjrAgjC9C51XbpXNniq6yc0Ghq
 7kIpGDMHEouQqsmEUBq6ff1d9CyT3MVhhsdLGBokfTTjxTRCd7SUPGQZ38M9MkEMPRlCukUsnH6
 rjaN0SerhmtMXGj1lozbhb/L0m8pnMDdnjTUnHzRgqFLGgd9iqnNPJiEuz3rX5GYoga6RqMWiXQ
 YAmQBc6XNu8t7+ujwbJbmvFUgxVnFZsQgttrt0HIZeu3ruutkR3ttqacSAcnVJ7wXW+2vQIGVnW
 TXWNVkO2q18A8Iw/cBWMi/eRp7Rh5ITOJKS9y+NKU6TmYKXv6BXcnJZPtYD/TfQ==
X-Received: by 2002:a05:620a:8805:b0:92b:7420:bd5c with SMTP id
 af79cd13be357-92e781d3781mr829986185a.5.1783000723259; 
 Thu, 02 Jul 2026 06:58:43 -0700 (PDT)
X-Received: by 2002:a05:620a:8805:b0:92b:7420:bd5c with SMTP id
 af79cd13be357-92e781d3781mr829982485a.5.1783000722633; 
 Thu, 02 Jul 2026 06:58:42 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477de3dcf59sm9254554f8f.34.2026.07.02.06.58.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:58:41 -0700 (PDT)
Message-ID: <ff87c1cd-ce47-4eb2-98d3-59efb499a9ea@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 15:58:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] accel: Change gdbstub_supported_sstep_flags() ->
 get_gdbstub_config()
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-11-philmd@oss.qualcomm.com>
 <87pl15sdpr.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <87pl15sdpr.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: p5EIp0LzmcFd2kVKWjoPDKb7rQoTzEum
X-Proofpoint-ORIG-GUID: p5EIp0LzmcFd2kVKWjoPDKb7rQoTzEum
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a466e94 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_x9DxgXTiZu7VHb-0hsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NSBTYWx0ZWRfX8lTz8PxNO1EP
 XdgmmQg6dE1yepi0T7LJhj9DSzf4Ja5gAP2r178EUVN/aJNYcU08FCEhWuFKwZwbgm93cE3tFhk
 DCKGWzoZDeomPxvTtIt7RM0Vdbf6sQsZvEklccq232OHgPyxW6RXdmb2Q55BhU/dA9toe89OSER
 kHVPyPKEpgZbcisYodYdDUv6r1LR/dXyfQm4BL40EVnmFRjTCQDiK4wqPUFLYaZNXuZGgkU/E83
 Qno7nnU+0WAD324tZyRlrjKHhKSQ8iskZcWgJjygpKxINGrciuXUsUzUhQn+7L9+8nNvg//D0+r
 tMWTQEYRy1dNxmylIKW8eKbSCK4LU0QhH4zB4gdfVzHhNKGyPddg7dbcaPjhtUIVNPjsXQxO/C3
 tpdPVtP6GBfLf9Kz0c5WCQoHlQ8YDzKvxpj2/0B1oJynnkLju/DrWC8mfT+wQRRBAQD9UCdGO4s
 eQ1yXGHwSdbpw43dUFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NSBTYWx0ZWRfX+O6mfUKqWGVw
 RybKm4w4bGemlij8Kr/XYkqUNzaoYFcG6iyv7uBpuPKBWdmnflldh+QFvpouJktJkJoVOUan3Fn
 yg8l3KzLtO6RetiJ85vzEEHwQt0j6LI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020145
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2/7/26 15:50, Alex BennÃ©e wrote:
> Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
> 
>> In order to have accelerator return multiple gdbstub parameters,
>> pass @supported_sstep_flags as argument instead of returning it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   include/accel/accel-ops.h |  2 +-
>>   include/qemu/accel.h      |  7 ++++---
>>   accel/accel-common.c      |  9 +++++----
>>   accel/hvf/hvf-all.c       |  6 +++---
>>   accel/kvm/kvm-all.c       | 12 +++++++-----
>>   accel/tcg/tcg-all.c       |  8 ++++----
>>   gdbstub/gdbstub.c         |  2 +-
>>   7 files changed, 25 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
>> index f46492e3fe1..1bc359ff3e5 100644
>> --- a/include/accel/accel-ops.h
>> +++ b/include/accel/accel-ops.h
>> @@ -37,7 +37,7 @@ struct AccelClass {
>>                          hwaddr start_addr, hwaddr size);
>>   
>>       /* gdbstub related hooks */
>> -    int (*gdbstub_supported_sstep_flags)(AccelState *as);
>> +    void (*get_gdbstub_config)(AccelState *as, int
>>       *supported_sstep_flags);
> 
> Is there anything wrong with just returning a structure rather than each
> individual config being passed by reference?

Sure, will update and respin.

> 
> --8<---------------cut here---------------start------------->8---
> modified    include/accel/accel-ops.h
> @@ -15,6 +15,11 @@ struct AccelState {
>       Object parent_obj;
>   };
>   
> +struct AccelGdbConfig {
> +    int supported_sstep_flags;
> +    bool can_reverse;
> +};
> +
>   struct AccelClass {
>       ObjectClass parent_class;
>   
> @@ -38,8 +43,7 @@ struct AccelClass {
>   
>       /* gdbstub related hooks */
>       bool (*supports_guest_debug)(AccelState *as);
> -    void (*get_gdbstub_config)(AccelState *as, int *supported_sstep_flags,
> -                               bool *can_reverse);
> +    struct AccelGdbConfig (*get_gdbstub_config)(AccelState *as);
>   
>       bool *allowed;
> --8<---------------cut here---------------end--------------->8---
> 
> 
>>   
>>       bool *allowed;
>>       /*

