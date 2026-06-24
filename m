Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99456CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcLdg-0001RJ-6n; Wed, 24 Jun 2026 07:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcLde-0001QZ-N9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:19:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcLdc-0002I9-VS
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:19:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OANb2P1148173
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OVWgMC6Q+RpoXrJzM0oD8D4c/89GWCELuadcBgtwNEU=; b=eUsaNFDnFGLdpQV5
 oVSHfDwJEbqlb0dYRAru8pzZu8KqbTlmO1YVEYLWNJmtAE0rfmAWaTYX2ysd0jYv
 gw8OjVsOZBXLP8YAn8Be2CLKd2zF8SvXycnQWOl9XcPpmWsQR/EOwh3Hbm4joJVY
 UN8WGf9Boj16YX57e15gxOlUkdXZQOF4hCvzu2G5MqmG3pwy7YjJR1StmTCxvA13
 9b/aShl+7mChpexGh4KrFT7vmlMKxz22PnHTRS5d76dl8OZ0pwq4unHtZL1AelNt
 O/jSpkfJNx1YlExPDDKvlzLdKvbP09n9myjI8SLWfoptdF8NjB7gCvhFrsQHapiI
 nEoJGA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f06r31sgh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:19:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so2328202eec.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 04:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782299962; x=1782904762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OVWgMC6Q+RpoXrJzM0oD8D4c/89GWCELuadcBgtwNEU=;
 b=ZLsiE1vxTWuzRJbfBoDdNdUhjq3yBJXxfeQ1CNUNnwGSWSaKI0nxQhDFhRoF0N2Thx
 fgsfzBv+Lk5QUvKiNvzCZskqQyf0qTP09KIuVImfxDeSWiHlCFSudlYRMJzLqL8SLvTM
 AOH4LBFIcW4d+sX0/6RnfuxkkV3mQ0CjCCgLPI048kcDAo6l6GyoJ7R/TshzH7khbOo/
 vs3Kp1TNU0NmJJfPljsihKCHyZZ4G+IBH5/uhlrM1j1eSGElZZQbIJuZXldabjLKKdKb
 3ln9aeV08EMXWMlvWQatZKL7khmvW1ZSklhm5uhRFLLmqNDZEPXnnBW3X21XmhhYaL+5
 /HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782299962; x=1782904762;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OVWgMC6Q+RpoXrJzM0oD8D4c/89GWCELuadcBgtwNEU=;
 b=maMgCt/1gzAvv5Y8/acFZBKpYjkqTUiGz9yPReezJkNJrm7MX67bu8m8vhLdrxWZOG
 wUkmT0dmGMXr/PdZXEgFQj11WPAviFEHqjrk0cQhm1AwXHh91YvuyO7YVKNwuD1KR8Bq
 Dq1oxzShJxORI0gkE+HVFT4goCP7NHhJYlnYBPgmbmo7rATYoxUXTUpCvhe4kPr8GBhA
 oNfs5Y0px2sK2rIlnXR43wPE0qLZeweiJnm+MrRzi6bKsMCHJe18Y+OW5wbSjG7KOkjJ
 g186tCssLDrivHFUoQpXSjUqSGZoV/5qz3iwunPKHWX8KOgqKF+HZVgjox0V4xLSal4n
 Tp+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqrMSwk+5QLncYPsmOlhZTti7nZlnATmsdqXkonx8p2IDtuXik+xjyhKipeDgPublvoZT09TOGc5Y8@nongnu.org
X-Gm-Message-State: AOJu0Yw78/T2kozhWE66RyrgUgpXvPGl9XTkCsC25Ib+b32MiiaJ++RJ
 WbuABkVWU9pV6rV8WU6zx4Fb9KEWmK9IG+WLmRw/VXm4Xi8qUf2tPZrLk7kB/aDVcMxO06pbVgv
 jeNAmkTJOXAuimnu35Nw7q+HgFUKFb23eDUWlIThgZeCTppoHWgBFm5FhzQ==
X-Gm-Gg: AfdE7ckeBFrxhtfh8k7zoeJOLVRzElChlK+/53ei3JwP7RB14osPLZ+36xJ4TrzIOsx
 aeKo8Bd9fhs8zlCQeadgTZXk3wxiVt8iK7V4BHZE2/UdyS42N8TzwlMQ+5NPDiv14+zyerYQDzl
 r7wAF9pe0qmLAi7CUyley8MJ/tHN0/cohDS9fxlvMlGktGZCXrT0I2uxvkxHgVfhOzmaoXY2sYj
 DH6jLatg8RcMTOkZhZ3O+Z6+6s7hA1O9QHJOcUtTQKKAjlAfmIXWWdxr4xyeSd4fC89YXd4VKbS
 uHmVJaOjzEX5ZWRmCCeD2x0R2S0j0noFO+FP+ss5uFVO+R+ZdFzDrFF0IJW+XXHa9RVnr/0bHwV
 12/U7PznDcTDaGu/GemOGbNtvxunpPkS6smmuJ7rpjunh
X-Received: by 2002:a05:7300:2307:b0:30c:38ed:46b0 with SMTP id
 5a478bee46e88-30c692f5606mr2773084eec.16.1782299961771; 
 Wed, 24 Jun 2026 04:19:21 -0700 (PDT)
X-Received: by 2002:a05:7300:2307:b0:30c:38ed:46b0 with SMTP id
 5a478bee46e88-30c692f5606mr2773048eec.16.1782299961099; 
 Wed, 24 Jun 2026 04:19:21 -0700 (PDT)
Received: from [192.168.68.103] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1be4b24esm22364515eec.27.2026.06.24.04.19.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 04:19:20 -0700 (PDT)
Message-ID: <fbf36827-e12e-4d10-8cf3-8284ae903ccb@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 08:19:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] target/riscv/cpu.c: filter TCG only bits in
 riscv_cpu_reset_hold()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-18-daniel.barboza@oss.qualcomm.com>
 <dfcdd6dd-ed02-4225-8238-f9a78636057d@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <dfcdd6dd-ed02-4225-8238-f9a78636057d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX589tuO9eFdfN
 KA9O1VO2TrEyBGJvXGP444delP+aTnLMoXf7W8mAhBUR9KuigNquth8fNUVdTCQegLwMHGum7Iw
 6XWKEej3VBjeV3pLl+Wl4eQh4HOpL+mtpMwPjh2aS5iuk2Pau7kO93XGc6juB9K0TsvhgvApFOc
 +WQT6yBdB47SMJ9beMIt/8YpAnXevLsIoOdN7cq0HGSkaVIBdT6imQDrDFWDvFxd2kip892FRqy
 /tPS3B+bjtCAoRO5/wAaIPxdDllPuwY+lOBuxcvcSDYVbHk5jKKK4j+xWPDmFfa5GlGpGbU5cOm
 fvQY1R5M3kaYCOsrMGRHnP4tDh1PWae2PuJBClAvnce+0rn7Lfz2TNIWNNCPEU8vTV2WiF5AthQ
 tHL/8YkzkVspCS2Qkft+S+myq2vG7YuliOmrScAclrMp9bfs44z7J4sbT3PdqeBerclSHG6e8zJ
 E8ZQhRHn7MFtMMgS6BA==
X-Proofpoint-ORIG-GUID: fwCQEFrNiq8v-dhz-tQk1X77JWO4NISN
X-Authority-Analysis: v=2.4 cv=ZM7nX37b c=1 sm=1 tr=0 ts=6a3bbd3a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=f1OD5SgU-hklIsKGyq4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: fwCQEFrNiq8v-dhz-tQk1X77JWO4NISN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX/I0fxAykNJoU
 hfZLXpJo+3YBKppNUfKCD6ip0FHw8KdRZy5rJU+f5vH1acfzr4chLXYPpE7drdU3gW8Kbtj1NP0
 it71EOVNLEUlNxZqDWoLlLKDL6ASB5w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 6/22/2026 6:13 PM, Philippe Mathieu-Daudé wrote:
> On 22/6/26 21:31, Daniel Henrique Barboza wrote:
>> We have a lot of TCG only initialization in the common cpu_reset_hold
>> callback that prevents --disable-tcg to work.
>>
>> Put a CONFIG_TCG ifdef around those bits to make the build work.
>> Eventually we'll create a TCG specific reset function in tcg-cpu.c but
>> for now this suffices.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   target/riscv/cpu.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> 
>> @@ -1013,6 +1009,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>>                       MENVCFG_ADUE : 0);
>>       env->henvcfg = 0;
>> +#ifdef CONFIG_TCG
>> +    uint8_t iprio;
>> +    int i, irq, rdzero;
>> +
>>       /* Initialized default priorities of local interrupts. */
>>       for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
>>           iprio = riscv_cpu_default_priority(i);
>> @@ -1050,11 +1050,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>>       }
>>       pmp_unlock_entries(env);
>> +#endif /* ifdef CONFIG_TCG */
>>   #else
>>       env->priv = PRV_U;
>>       env->senvcfg = 0;
>>       env->menvcfg = 0;
>> -#endif
>> +#endif /* ifndef CONFIG_USER_ONLY */
> 
>    /* !CONFIG_USER_ONLY */
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Phil I forgot about this ack. My bad :(


I'll make sure to add update it in v3.  Cheers,

Daniel

> 


