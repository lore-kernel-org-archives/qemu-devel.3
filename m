Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF71CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUseY-0000gt-3m; Wed, 03 Jun 2026 16:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wUseW-0000gK-B0
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:57:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wUseT-0005ZD-VI
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:57:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653Ebl0K1476841
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PdIYZae1tWvrkLxF4yMuTamUIik0PoI9G5/U2jO3iNM=; b=B00rR9lRLRTm1CiW
 lcPjfJBuAbteTyVlltZ/sk/7oqBYh3IY5jhjHsqjjMjfk0v6GLfb+k4MsQWVHI82
 XuGxjEcqdp34NjD8yt+g7mEgd7nTt1HQfhUw2q9sSgzR9K96BzPF8Yy311TN6GCx
 V1OCWaFTMWg6R66xbeuEoRpZyYdwP2QXje7FaTLabiPSCr+CEHbf51gJHfBqdj3H
 sTfBCFjCRp+gqn3NAOfkzS5jPPdxDsupQ/3wY0GTk4LdEgLhgSydADZGzsvdTBCp
 MeMZnA3mWnq0lgYZBAlmpXdkl76bPif49dOL1ogqoJgfHUH+eK96X0BftiOvGlU7
 s4wi9g==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejp6nsngs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:57:24 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-59eb9191180so2543162e0c.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780520243; x=1781125043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PdIYZae1tWvrkLxF4yMuTamUIik0PoI9G5/U2jO3iNM=;
 b=X1G6xCPElYnaFwwxDFKbfxGCRBL40sTj1+n5XLal8rSugFATU0QL1GK4ditZDnlRfi
 t7BgU+0otPU50cvKKpuIkh/KgoqOQqQ1yiAF6gBiThfBQX4crUwNLhikhSi6Y3A8RGaW
 pPIgl0QgDyBQkZJ2x22fsgMHqCGLHm+UiGzHLVV7RkPRJIHPW90xnqvntXcszLLcZ9F+
 pjveta54WgyOkq4LAMSi28CABiNg17rcpu7AVx/UB1FvdFksYgFWf5wVUyAOko0/C4EI
 PtA3lL2GUP0yIDOopbq3j6tTm/tZGXiU6DlMZ2m7R8BFx/Sjqfz5zg9QG22fSiY9t+oT
 A5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780520243; x=1781125043;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PdIYZae1tWvrkLxF4yMuTamUIik0PoI9G5/U2jO3iNM=;
 b=HnTvYIUgRVSt0V7iUKCkI5CBUyERX3pQ/mGTghjgSy8YUxKWuJJ6cbv28KBA24CK1K
 ohDVpNUP0HJwT9gG7eB/D6XSdyx0+a5+avAdHwtxD15ZYg9mkM+M6BACOn6wXj1egJIm
 ZolvdpOOdE/0TP2x36AuYldbkgHo0P7cTeClR9arzelhuczqsAzv4eqz48b7I+nxBtOj
 UsWU3mkFda+uRtR0Lqjv9bWwyvhcrOCihe29OlkxLgnOqeqiTc1ipSdM3e9pfCyMO8Ve
 qBhoSPLkOqlDbtuILg+fvPi+vFGJjvSmz1J0lwf/judK+2y8u1SZWu4ZszflPz8X0Ufr
 OUyQ==
X-Gm-Message-State: AOJu0YyBBGE7LX0TkoU45yAuPppXugNjl8WZ7GFKYXO7Q4dn+cH1BhGi
 G7K6W6r1iuECagzNKKRaf0ZmDG5vL/fEaJMW8/SyrSw/ykCeasiNGb+frgxZ1S4l3Ez4ipoHqw4
 QzFroN15MTKVfWIGPO7wKkz1WacwZSatjcij9F/N9eDHGpppBVdJAq6lxzA==
X-Gm-Gg: Acq92OGZUZgFxw2jQb447MDBC8efqh9RtFJCQZ5V/wZTaFlok2vL5dSCcFIRtJmSymY
 tjKYKuC/ij05gF8zYONUbawprkUiRSAaZCqNGWqjwaR9K6fTV6w3FziPSgIBd+9plSSPLXFg+vz
 O6JEC1ajlQqbdZXhPNktIspn99gSWpCg1pWqngv9N5MbVmqRXyGbc3aInlyEVSByjwXqQVFffz6
 heoXuvE4F1QsCOgisMfXzYUpe2qPEtCyHjuqithuwFHQWGQgpIcqiizm5aOza6vkaDYQhL65OKn
 xKQA05EvtK/+NNqR/qOEB9M8BWrobk/s3mrpeeuqdS7zXvg1NrjCMTLF/IbqABbPHjQOAGQhSdt
 WIzuIa3sZO/Z1sAePGLisyo33iGIeheZ79Bd4qEJvUy37pzWFaGblN8A+THWBlOOvKrB6
X-Received: by 2002:a05:6102:1487:b0:632:88f6:d6ae with SMTP id
 ada2fe7eead31-6ec460be024mr2688551137.22.1780520242804; 
 Wed, 03 Jun 2026 13:57:22 -0700 (PDT)
X-Received: by 2002:a05:6102:1487:b0:632:88f6:d6ae with SMTP id
 ada2fe7eead31-6ec460be024mr2688526137.22.1780520241048; 
 Wed, 03 Jun 2026 13:57:21 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96414113f10sm2868309241.10.2026.06.03.13.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 13:57:20 -0700 (PDT)
Message-ID: <b063eb61-a246-4f10-bac2-ee9272afcd2f@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 17:57:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] target/riscv: deprecate 'debug' CPU property and
 Debug 0.13
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 Tao Tang <tangtao1634@phytium.com.cn>
References: <20260528131214.2251075-1-daniel.barboza@oss.qualcomm.com>
 <20260528131214.2251075-2-daniel.barboza@oss.qualcomm.com>
 <ahz7-1OomsZTMIz2@ChaodeMacBook-Pro.local>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ahz7-1OomsZTMIz2@ChaodeMacBook-Pro.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9A4uGEs9pW8LyCwc8v0tGZlewPu2sC20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX+Gq0nIuR+v4M
 5kpTmxhIexWx1WQxlNJXrtw9v0U0DW6yyiYQ8OSpy1GOQ2rO0pFd40rBueYEGz87oSmL9ILiKRT
 tfV0xqHZIOV9eB4BWfx0VUdRu4E2TUU2ElMabx1ExCi+rnk0mRbsVsnCms1KG6An5x/ahyPHU6g
 Qjw20Qz2TOVeTgEPGOT7q0iSRDNXcbJsPKZPThyTX02ncORBtinsptbGiarib3anUeLj/nfLEa+
 MLK19CAQ/Ip/ZjNFtRaI6o1XZYWFnLzJZl0s+zaJZGOE9koIkz3or5dGFPIEZFCbXlbCajbAE85
 Ig1I1JNXVzeoEFRfETRhrFG+KYyhbQf1AJ7AHDHFY6SZQPV/qpAbvGy5GvQ3XuhiDz6pxUoWehn
 NRLMZMpoTcdyx/d0nog9vqSyGZw+6/vYF5ST4XQ+utOW2zLNkE5d5hftsm0I48SO4pP1OTRJwgz
 oYbcBw9ltTjKzLQTbMA==
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a209534 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8
 a=eZogcxxPpfSTaTVD1l0A:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-ORIG-GUID: 9A4uGEs9pW8LyCwc8v0tGZlewPu2sC20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030203
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



On 6/1/2026 1:04 AM, Chao Liu wrote:
> Hi Daniel,
> 
> On Thu, May 28, 2026 at 10:12:14AM +0800, Daniel Henrique Barboza wrote:
>> Starting on commit f31ba686a9 ("target/riscv/cpu.c: add 'sdtrig' in
>> riscv,isa') the 'debug' flag has been used as an alias for 'sdtrig' that
>> is, for now, compliant with Debug 0.13 that was ratified 8 years go.
>>
>> We're going to add more debug trigger extensions, e.g. 'sdext' [1].
>> Thing is that 'sdext' and all other extensions that will follow are now
>> adherent to Debug 1.0, ratified Dec 2022.  And so it happens that Debug
>> 1.0 and 0.13 are not compatible with each other.  This makes support new
>> Debug 1.0 extensions like 'sdext' harder because we would need two
>> independent code bases for each.
>>
>> We consider that most of the RVI ecosystem already moved on to Debug
>> 1.0 and is now going towards the extended Debug 1.0 extensions, and we
>> should follow suit.  And the best way to do that is to leave Debug 0.13
>> behind, by deprecating its 'debug' flag and making it an alias for
>> 'sdtrig' that will eventually move on to Debug 1.0.
>>
>> The following changes are made:
>>
>> - 'ext_sdtrig' flag was added in cpu->cfg. 'debug' flag was removed from
>>    cpu->cfg;
>> - All occurrences of cpu->cfg.debug were replaced to 'ext_sdtrig';
>> - Two explicit getters and setters for the 'debug' property were added.
>>    The property will simply get/set ext_sdtrig;
>> - vmstate_debug was renamed to vmstate_sdtrig. We're aware that this
>>    will impact migration between QEMU 10.2 to newer versions, but we're
>>    still in a point where the migration break cost isn't big enough to
>>    justify adding migration compatibility scaffolding.
>>
>> Finally, deprecated.rst was updated to deprecate 'debug' and inform that
>> it will be now interpreted as an alias of 'sdtrig', which is now going
>> to be compliant with Debug 1.0.
>>
> 
> This patch conflicts with Alistair's riscv-to-apply.next branch.
> 
> f71708fedf target/riscv/tcg: disable svnapot if satp_mode < sv39

Based on recent discussions with Alistair (check the "QEMU RISC-V Call" thread)
seems like we're postponing this change because there seems to be interest
in keeping the 'debug' flag around, together with the 'sdtrig' extension that
we need for your 'sdext' extension (and for the riscv-server-ref board).  Seems
like someone is going to send patches making it possible.

We still have a month left before freeze so hopefully we can get all this merged
for 11.1.  For now we'll have to wait ...


Daniel

> 
> ```
>     <<<<<<< HEAD
>     static const VMStateDescription vmstate_debug = {
>         .name = "cpu/debug",
>         .version_id = 3,
>         .minimum_version_id = 3,
>         .needed = debug_needed,
>         .post_load = debug_post_load,
>     =======
>     static const VMStateDescription vmstate_sdtrig = {
>         .name = "cpu/sdtrig",
>         .version_id = 1,
>         .minimum_version_id = 1,
>         .needed = sdtrig_needed,
>         .post_load = sdtrig_post_load,
>     >>>>>>> target/riscv: deprecate 'debug' CPU property and Debug 0.13
> ```
> 
> You probably need to rebase onto and fix it.
> 
> Thanks,
> Chao
> 
>> [1] https://lore.kernel.org/qemu-devel/cover.1768622881.git.chao.liu.zevorn@gmail.com/
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
>> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   docs/about/deprecated.rst         | 19 ++++++++++++
>>   target/riscv/cpu.c                | 50 ++++++++++++++++++++++++++++---
>>   target/riscv/cpu_cfg_fields.h.inc |  2 +-
>>   target/riscv/csr.c                |  2 +-
>>   target/riscv/machine.c            | 24 +++++++--------
>>   target/riscv/tcg/tcg-cpu.c        |  2 +-
>>   6 files changed, 80 insertions(+), 19 deletions(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 97750f5edc..bc872e50ba 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -417,6 +417,25 @@ ABI is long-obsolete. We are therefore deprecating both OABI support
>>   and NWFPE emulation, and they will be removed in a future QEMU
>>   release.
>>   
>> +``debug=true|false`` on RISC-V CPUs (since 11.1)
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +When first introduced this flag enabled/disabled support for the RISC-V
>> +Debug spec version 0.13.  Then, since QEMU 10.1, it became instead an
>> +alias to the ``sdtrig`` extension that still adheres to Debug 0.13.
>> +
>> +We're moving to the new ratified 1.0 Debug spec that will be maintained
>> +long term by RISC-V International, but this new ratified version is not
>> +backward compatible with 0.13.  This means that keeping both implementations
>> +is a maintainership hurdle that impacts the development of new Debug 1.0
>> +extensions like ``sdext``.  And most of the RISC-V ecosystem already
>> +moved on to Debug 1.0.
>> +
>> +For all these reasons, starting on 11.1, QEMU is moving away from Debug
>> +0.13 by deprecating the ``debug`` flag.  Setting it, from now on, will be
>> +be the same as setting ``sdtrig`` version 1.0.  Users that are still using
>> +Debug 0.13 will need to update their software to use Debug 1.0 or use QEMU
>> +11.0 and older.
>>   
>>   Backwards compatibility
>>   -----------------------
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 862834b480..54e8f78a4d 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -226,7 +226,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>> -    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
>> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>>       ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
>>                                   has_priv_1_12),
>>       ISA_INTERNAL_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
>> @@ -807,7 +807,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>>       env->vill = true;
>>   
>>   #ifndef CONFIG_USER_ONLY
>> -    if (cpu->cfg.debug) {
>> +    if (cpu->cfg.ext_sdtrig) {
>>           riscv_trigger_reset_hold(env);
>>       }
>>   
>> @@ -971,7 +971,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>>       riscv_cpu_register_gdb_regs_for_features(cs);
>>   
>>   #ifndef CONFIG_USER_ONLY
>> -    if (cpu->cfg.debug) {
>> +    if (cpu->cfg.ext_sdtrig) {
>>           riscv_trigger_realize(&cpu->env);
>>       }
>>   #endif
>> @@ -1150,6 +1150,14 @@ static void riscv_cpu_init(Object *obj)
>>       cpu->env.vext_ver = VEXT_VERSION_1_00_0;
>>       cpu->cfg.max_satp_mode = -1;
>>   
>> +    /*
>> +     * 'debug' started being deprecated in 11.0, been just a proxy
>> +     * to set ext_sdtrig ever since. It has been enabled by default
>> +     * for a long time though, so we're stuck with setting set 'strig'
>> +     * by default too. At least for now ...
>> +     */
>> +    cpu->cfg.ext_sdtrig = true;
>> +
>>       if (mcc->def->profile) {
>>           mcc->def->profile->enabled = true;
>>       }
>> @@ -2514,8 +2522,42 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>>       NULL
>>   };
>>   
>> +/*
>> + * DEPRECATED_11.0: just a proxy for ext_sdtrig.
>> + */
>> +static void prop_debug_get(Object *obj, Visitor *v, const char *name,
>> +                         void *opaque, Error **errp)
>> +{
>> +    bool value = RISCV_CPU(obj)->cfg.ext_sdtrig;
>> +
>> +    visit_type_bool(v, name, &value, errp);
>> +}
>> +
>> +/*
>> + * DEPRECATED_11.0: just a proxy for ext_sdtrig.
>> + */
>> +static void prop_debug_set(Object *obj, Visitor *v, const char *name,
>> +                         void *opaque, Error **errp)
>> +{
>> +    RISCVCPU *cpu = RISCV_CPU(obj);
>> +    bool value;
>> +
>> +    visit_type_bool(v, name, &value, errp);
>> +    cpu->cfg.ext_sdtrig = value;
>> +}
>> +
>> +/*
>> + * DEPRECATED_11.0: just a proxy for ext_sdtrig.
>> + */
>> +static const PropertyInfo prop_debug = {
>> +    .type = "bool",
>> +    .description = "DEPRECATED: use 'sdtrig' instead.",
>> +    .get = prop_debug_get,
>> +    .set = prop_debug_set,
>> +};
>> +
>>   static const Property riscv_cpu_properties[] = {
>> -    DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
>> +    {.name = "debug", .info = &prop_debug},
>>   
>>       {.name = "pmu-mask", .info = &prop_pmu_mask},
>>       {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
>> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
>> index 734fa079f2..44235bfaa1 100644
>> --- a/target/riscv/cpu_cfg_fields.h.inc
>> +++ b/target/riscv/cpu_cfg_fields.h.inc
>> @@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
>>   BOOL_FIELD(ext_zimop)
>>   BOOL_FIELD(ext_zcmop)
>>   BOOL_FIELD(ext_ztso)
>> +BOOL_FIELD(ext_sdtrig)
>>   BOOL_FIELD(ext_smstateen)
>>   BOOL_FIELD(ext_sstc)
>>   BOOL_FIELD(ext_smcdeleg)
>> @@ -159,7 +160,6 @@ BOOL_FIELD(ext_xlrbr)
>>   
>>   BOOL_FIELD(mmu)
>>   BOOL_FIELD(pmp)
>> -BOOL_FIELD(debug)
>>   BOOL_FIELD(misa_w)
>>   
>>   BOOL_FIELD(short_isa_string)
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index 5514e0f455..17992715ff 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -796,7 +796,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>>   
>>   static RISCVException debug(CPURISCVState *env, int csrno)
>>   {
>> -    if (riscv_cpu_cfg(env)->debug) {
>> +    if (riscv_cpu_cfg(env)->ext_sdtrig) {
>>           return RISCV_EXCP_NONE;
>>       }
>>   
>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> index 6776e7bf5a..4ca5c9c8d7 100644
>> --- a/target/riscv/machine.c
>> +++ b/target/riscv/machine.c
>> @@ -218,14 +218,14 @@ static const VMStateDescription vmstate_kvmtimer = {
>>   };
>>   #endif
>>   
>> -static bool debug_needed(void *opaque)
>> +static bool sdtrig_needed(void *opaque)
>>   {
>>       RISCVCPU *cpu = opaque;
>>   
>> -    return cpu->cfg.debug;
>> +    return cpu->cfg.ext_sdtrig;
>>   }
>>   
>> -static int debug_post_load(void *opaque, int version_id)
>> +static int sdtrig_post_load(void *opaque, int version_id)
>>   {
>>       RISCVCPU *cpu = opaque;
>>       CPURISCVState *env = &cpu->env;
>> @@ -237,12 +237,12 @@ static int debug_post_load(void *opaque, int version_id)
>>       return 0;
>>   }
>>   
>> -static const VMStateDescription vmstate_debug = {
>> -    .name = "cpu/debug",
>> -    .version_id = 2,
>> -    .minimum_version_id = 2,
>> -    .needed = debug_needed,
>> -    .post_load = debug_post_load,
>> +static const VMStateDescription vmstate_sdtrig = {
>> +    .name = "cpu/sdtrig",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = sdtrig_needed,
>> +    .post_load = sdtrig_post_load,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
>>           VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
>> @@ -444,8 +444,8 @@ static const VMStateDescription vmstate_mseccfg = {
>>   
>>   const VMStateDescription vmstate_riscv_cpu = {
>>       .name = "cpu",
>> -    .version_id = 11,
>> -    .minimum_version_id = 11,
>> +    .version_id = 12,
>> +    .minimum_version_id = 12,
>>       .post_load = riscv_cpu_post_load,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
>> @@ -511,7 +511,6 @@ const VMStateDescription vmstate_riscv_cpu = {
>>           &vmstate_kvmtimer,
>>   #endif
>>           &vmstate_envcfg,
>> -        &vmstate_debug,
>>           &vmstate_smstateen,
>>           &vmstate_jvt,
>>           &vmstate_elp,
>> @@ -519,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>>           &vmstate_ctr,
>>           &vmstate_sstc,
>>           &vmstate_mseccfg,
>> +        &vmstate_sdtrig,
>>           NULL
>>       }
>>   };
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index 3e22e7ed53..a6dd864264 100644
>> --- a/target/riscv/tcg/tcg-cpu.c
>> +++ b/target/riscv/tcg/tcg-cpu.c
>> @@ -180,7 +180,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>>                ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
>>       }
>>   
>> -    if (cpu->cfg.debug && !icount_enabled()) {
>> +    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
>>           flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
>>       }
>>   #endif
>> -- 
>> 2.43.0
>>


