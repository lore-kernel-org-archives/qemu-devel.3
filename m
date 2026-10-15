Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DFDC2D0A6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtr-00046M-JW; Thu, 15 Oct 2026 14:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHPto-0003wx-NC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHPtl-000132-IA
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FG5V7G3492972
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G25OUVfUb7q+X5BPeLgfx5+4zt2p9XcidGBu3sLX5Ks=; b=WiL0jRSlUVwd2XdA
 d970bKVCUV6S40gVieCGU3pMFBrlbEFWrffCitVyPbpzPwcJZE9ujWFdXBvPh4oz
 LJaZ0yxxyACNDQu4RTlQ6ndEC9bgVKlAqpdwY2CN/P0fhuDlZiGS+bCfs8U3EkBL
 n6NtLZX49mOpCfKcTHt4tKP85Fx2NdxcR3yznG2tahci+Ta7fLDIknEZ7olDDxl+
 Z5j9W59mThRZxHK5ZHLYYP/jZzsr34WWYu7Z+bXxdJzwUb3YV2mfYTbFL2NMkg/k
 zAWfm8/xCI8cCC1MIwa/uS1cOU5sgHH4vG++qthFgfe4j/sq8zvUTJC2cGCuNucU
 OjotSA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb21wrg4j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:09:46 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-147be78cd56so21758204c88.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792087786; x=1792692586; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G25OUVfUb7q+X5BPeLgfx5+4zt2p9XcidGBu3sLX5Ks=;
 b=aVIk4s19EYXp/+m2oov7e52tJjQYmBOAi7J0pnOppDlJc/bVPZUh6uACSxO/HPWk/7
 N5hAhvCLztkQ/hkfbS/sw5XTQmiJpWHngD2WVWX++aCC5IFbJ71Y4qQBZUULFBr304mb
 1zBLZL+CrE7eGM4gpZjCm7hPA+YxHYh+DLnylA2Qsa2RXQAnZoHuB+avlS45ugS7gsu1
 uuC9Ih7+K4kUWHod0TTcCSA+qfCiwYVZqcQ4+J93Wl6T72YlGHdzAnNnda7rlR7gjh1X
 fjhY2OubkQVXxUzRRg5RtsGXJo5G6JqjpkwsADQ90Pi/RVF+flSdhgvyhOED0yN6tncQ
 aYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087786; x=1792692586;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G25OUVfUb7q+X5BPeLgfx5+4zt2p9XcidGBu3sLX5Ks=;
 b=N3HNMUru+ha5bm86OBikP3Cto7x6Xm+ZqjbGI8d/Fi5LPBFqmCPBFE96+NU3xS0eiM
 BlTI8dDNouWSX1eBR4cJ+5INDWGtVBHt7Yd2ElqkxwzqF/DJymcaTRyyIXNWOy1dMhhL
 8N6GO0RrnY8p+EOh0eS2y8MgGra8YeKERMHb1vw/PJTWPWWnvaBXshBHfpkFZ3HhVadR
 uDLXDPZ2s4vkhthQ3Uf56By4DnfzfKOGAb4FddpgKbYpBB3kkEAmV1nYGhT7ipTd/yQO
 GhcrSeBWipvQwDITqqPLueK8zwN71FqBgwRxY4VhVdCgo8h9isuVd275LJvPC0X0KvSH
 YSMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9l+xzel0BtyH/YAmvikAFBfcWxn37BQMSKE21FaUxqK49HVwA9IeR98KV6266p7lhPA1VNFGlHN5v@nongnu.org
X-Gm-Message-State: AFq9FYLZamAt4hvHddEpe22d2t1OWQJw4JehPNTyCrZSSlaV5D5XhYuK
 bWzYKeTqEiHYfJAvWLOKUVDNoHoNcGHken+asKuopZKstiyWyhbFR+qwmV8XsRNR/oRckiJH/EL
 /E3aYcK382cgFGu8zGDDsA1kQbym06B5HxVbkDt8Q1ay9inxbJD8O40IxIg==
X-Gm-Gg: AYBFou0UwCqMjPjkMMvdWUaYOv/x6kE/6cIG/6BCUNnxtkkkizseNOV224uLpMka29f
 HAMXfd47lGhZ80t8Xt6BiznBFXY5Cfr+fuSeqQ63PjeCWyJ7EpVWcn4xDU44upT0H0zcYa9OunS
 j5n+lHiPNCnyelJcWtodtISltjhBp/hzo18Yno8bmEwfodIkR51jXy9SqvqrnNBEtpMupDxdNDT
 UFA1dwSONHzpBI3bjVrjR9LRjW3wamvVc83tBu6o+S1/dlJqvv9FTpUwQQkzGM6QJShlAY0NZGz
 g4eoGpaaYn/rd6bSJXFeqvG8eAnUp8+BNF9bQPjhjuTe+DbkXlMSi4lKOJruyZCdkjIPow1BTeb
 IkUVKeScTgsm79CO2DL6HEvbGaqxAU0VLMNDHaK02PcpVYTJvUObBok0PrIvk8jJSX1jb8A==
X-Received: by 2002:a05:7022:7f0d:b0:150:c9c5:1ca1 with SMTP id
 a92af1059eb24-16a62600f1cmr31091631c88.18.1792087785756; 
 Thu, 15 Oct 2026 11:09:45 -0700 (PDT)
X-Received: by 2002:a05:7022:7f0d:b0:150:c9c5:1ca1 with SMTP id
 a92af1059eb24-16a62600f1cmr31091590c88.18.1792087784987; 
 Thu, 15 Oct 2026 11:09:44 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-182a5a2fb99sm605539c88.5.2026.10.15.11.09.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 11:09:44 -0700 (PDT)
Message-ID: <7bd455f9-b26a-4fc3-813b-d4fec6b6a03d@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:09:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] target/riscv/cpu: constify cpu parameter for
 riscv_cpu_mxl
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com>
 <b99355a2-a424-41b2-978b-8938de06cbda@oss.qualcomm.com>
 <9218a003-b19d-480e-ae11-cf3ed2b9e592@oss.qualcomm.com>
 <56883c4c-dd87-41f2-8e71-1bb8fb65844d@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <56883c4c-dd87-41f2-8e71-1bb8fb65844d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6agDDqslG8-fmfnb1XJEs6mo1gXW_nbF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3MiBTYWx0ZWRfX6/4/D/czlu/1
 LK87pCdnBNZ+VJkRHsgIE9hKhbDiALavyZ8u4TF8zPqYXUTPGM0bffcA+mw6MDWcyGPVCeaeHqx
 LMrvETGOIGKzF+lPAG4GkifOWxLoI26KNGDQ5grWU6L3gP+zruekk9W+nR8ynKiJbRXL2xK/kyQ
 +g+e1UOgPtJ40HiUzsfcv2XfsqO1BuBwBSkIYZncDVP3g3MVAzGeD0TAjlRtwSjQUAbTcWuo2lr
 bFObDVUL2aSwMfkRZbLwRSXWP2heO4foRzrQeQ1v2UUeeBCscqGyaCCXBSJOjRZqOpA07NTUy/T
 s8xqliQcYdP5PaKv1psbu0wLsY2EW2pFbUzhJ7MlW0TN/m+ZS5bkH7g5tMJJTVIpPXtfl9roMJd
 Y4I8WLMyrj9upUchPySm3hyUGxxpQJnhWk9c4TPnH+TwTSPFx9e4a7j1WY/De5yGBv0rCY4cnD8
 rX142+L3S0ZPI8CVnYw==
X-Proofpoint-GUID: 6agDDqslG8-fmfnb1XJEs6mo1gXW_nbF
X-Authority-Analysis: v=2.4 cv=R5qWitRX c=1 sm=1 tr=0 ts=6ad116ea cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Re4n30zx4HbT9UJsfYcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3MiBTYWx0ZWRfX49DNdR1VGEuN
 yOn+5IsV7WRhdj/qj5Mgt86HFaw1Huw1ShbdyckraFMP3atqkzOwoo5cnAol5/Xq5myXFXlWeFj
 vLxz7K+Fd1duCXD7gqqEG5MunlYGpp8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/15/2026 10:48 AM, Philippe Mathieu-Daudé wrote:
> On 15/10/26 19:42, Pierrick Bouvier wrote:
>> On 10/15/2026 10:37 AM, Philippe Mathieu-Daudé wrote:
>>> On 14/10/26 23:05, Pierrick Bouvier wrote:
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>    target/riscv/cpu.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>>> index 8c8ffe94cd8..00650a66dcb 100644
>>>> --- a/target/riscv/cpu.h
>>>> +++ b/target/riscv/cpu.h
>>>> @@ -755,7 +755,7 @@ FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
>>>>    #ifdef TARGET_RISCV32
>>>>    #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
>>>>    #else
>>>> -static inline RISCVMXL riscv_cpu_mxl(CPURISCVState *env)
>>>> +static inline RISCVMXL riscv_cpu_mxl(const CPURISCVState *env)
>>>>    {
>>>>        return env->misa_mxl;
>>>>    }
>>>
>>> Reviewed 6 weeks ago and in Alistair riscv-next queue IIRC:
>>> https://lore.kernel.org/qemu-devel/20260901095229.72018-17-
>>> philmd@oss.qualcomm.com/
>>>
>>> Anyway,
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>
>>
>> Did you flush the rest, or is it going through all submaintainers trees?
>>
>> I feel that system wide series like this should be sent on their own at
>> once to avoid having a state spread across multiple people with
>> different latencies.
> 
> No, Alistair queued patches I'm depending on, and I consider a
> maintainer sending the "patch queued" message a lock on the
> patch. I'm stuck waiting for preliminary riscv-related patches
> to get merge to reduce conflict with Alistair tree. Meanwhile
> my tree grows so I'm not sure anymore it is a good process,
> maybe I should have posted a PR and let Alistair deal with
> the rebase conflicts. We still have 10 days until the freeze
> so I guess we are still in time.

As long as the patch is strictly unmodified, the sub maintainer or top
maintainer (merging the PR) won't see a conflict, since it's all done
using git, and not email patches.

In case there is a conflict, I would say it's definitely a
submaintainer's problem since their tree is the one with a local state
fixing conflicts between multiple series: probably a strong hint it
should have been flushed quicker.
As long as they don't have to deal with conflict, by keeping an
invisible "lock" on this subtree, there is no reason for the workflow to
change.

I understand your situation though, there is no good way to deal with a
series that depends on another in flight series: either avoid this, or
repeat the required patches in your own.

Regards,
Pierrick

