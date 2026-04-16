Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423BFF8A171
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 13:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDMJP-00008a-62; Thu, 16 Apr 2026 08:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wDMJK-000086-0m
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:59:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wDMJF-0002pZ-3u
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:59:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G8xwXm4125607
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 12:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v1ppxAUpKd0y4jxXxdC9ndRcIbSfIhD4rIWwx1iYgqs=; b=bsApP8zYNXMhy+lg
 1fCxItj7DLaKvqdp+Tct3OKL7e3uxuHYoHoi9y//fqyNSX33N8V5zC/j/To+pXNS
 /L2JTSbLUVFxuGIhzQTqr2R5Mi70Z5tYkkhJ5bGjF0G2Pvsn0GZZUMFVZ3vn9TrD
 N8PrrVszf3SMnzQwdRaY8atWuMOLTind3wYn6zkZ/RMXXjEIg6sp7UgIoThJmzdr
 h052zeo+nSdnkfw2sq8Z8i6GFpDwm4yK5NU8Ttw9ecZsi+V2e7qPLF5QwhG4j6js
 uaxB8fHyyUUu+aYEE8VVBRAmviLkw1Ao56eCapZWgANgBXigjIMeK7gBV8HL8iHT
 W5LOpA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djvrf8rv8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 12:58:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d984c74a8so189811821cf.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776344337; x=1776949137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v1ppxAUpKd0y4jxXxdC9ndRcIbSfIhD4rIWwx1iYgqs=;
 b=gyrJRS+kP0OqEuJXbdammZeB1sOg+scVJYDZ693znB7EpoiTq2eM+81gdlXVH3sgf7
 XPR8Gh0Vr/T501QEh6HL51jg3Oze+hMWny2f14y3nEQ9S3wN1zzAk7Q/W8pZo99bPhyt
 KQwWTX4SH5fTIpTN/w4wHgeWmW7NXEyMcBbbkbWm/ObCfMdBAmrvQBBMhStAvqSJZ41r
 DT9P0/QJjB+dFOfUso9hhgHisoiTUgjmliYfA8Y6li84S8LnFgQSV+CCjpa/tzyBWS0r
 deHs+4CajDklq+wbzZAgcQaMMsdSH9F95j9Lpl7LQ7wODa89UdW35p7d1UxTyuMl6UK5
 PbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776344337; x=1776949137;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v1ppxAUpKd0y4jxXxdC9ndRcIbSfIhD4rIWwx1iYgqs=;
 b=eSzzgGMGwpXq28xTpAqDOylNRYEVjp/89B6u9YUkhXCEPbTJ9gNpBa4aY19M3VLAi8
 KpPbU9CaW80rr/7l0TSHgtmqKoCZZr9+9wnyNGwHXQ4rGss2USL9pNQQ56RzTiyqZxvg
 Y+uZ0vZ22BEjBKYz+oKXE23aBERlY6jnstLc7Rcpw6BuGgWK1MfLJSvKYCgsjyGVWT7y
 pup+Bq6onhVqbkGKVihY5vG9onCHll4YTsQ/e+bWodg3txEL0m4sTlMsT/CUj+oqPueJ
 UQAFL1IO7G8Kc/N4WYzFZZ9RyTUC97XCn8RYOioXImcZa1J6czmCB8X5zbxZBK7/XzpG
 X2Iw==
X-Forwarded-Encrypted: i=1;
 AFNElJ82SimbCJJbM2Q6R13QM244+HMT3S5YkcCJAeL5uYMT2Ip68OFpUHeDJHUS5RWLd/S/0iHGTEFibXQ0@nongnu.org
X-Gm-Message-State: AOJu0Yz+ouzcc93nE3LPEyj7CFFebMAQrCL4X5MQ5j2faekrZSPFIeLT
 irZU+idN7fFrDcusfxExXHbUy4ijSw//yPeZ+d9DGET9KUNAoo9ouJOKt7utpb3IlWRRVxXkYYV
 riGweoce4HnsbJm8hRgRk8QLyNUsYBv1H6/+WXXaNejsRcozlX2fgM0i7JQ==
X-Gm-Gg: AeBDiev6xK5OINcEKYwJMEC+4PzQpgnssG9v3rSBgr38rpNP0/XxLupm8cDMCUFZQuN
 pPtY72+IACJpfTqSQzYIlhDxFvqBTD/1EutYzBb6C82h3MTnL2VtZWmBuoMFNCArT1zVBUrk8hb
 0bQHw1WKW5MPupoheqkQzzJYX20jpBHC3UPz6x8URXs286/9jp8UTQmNajoXDkiQHCQoRPpiV3+
 bMRd8N8OYAQUxaquQSkKNtZo/ftZxxpwyUPgsuq1z+3Maf2EAdcPGAN+8hukNRaOdQOQIuVQFVF
 o19a1wa1mvpAi8UoMzkJdorPKnOM4hn8Ta5gs9iJ8RT1zAH24MuRxzXHGU5B1LkyqpqwLO/Kw6J
 D+szpnD5emvFdEG9wyei+f+ZALr/xBnDPoPpJPO87uhVZyaMC/TCcGrNy4BxAgYieHnhDejjRVw
 PFkmSnOfe301g4WJA8A4bWtgfzBQ==
X-Received: by 2002:a05:622a:408d:b0:509:25ab:f545 with SMTP id
 d75a77b69052e-50dd5a81499mr380677341cf.11.1776344336539; 
 Thu, 16 Apr 2026 05:58:56 -0700 (PDT)
X-Received: by 2002:a05:622a:408d:b0:509:25ab:f545 with SMTP id
 d75a77b69052e-50dd5a81499mr380676861cf.11.1776344335956; 
 Thu, 16 Apr 2026 05:58:55 -0700 (PDT)
Received: from [192.168.15.39] (189-68-248-239.dsl.telesp.net.br.
 [189.68.248.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93830esm44973566d6.9.2026.04.16.05.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 05:58:55 -0700 (PDT)
Message-ID: <e4b61f26-c0ce-4017-9b6c-cdb8b679d2c0@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 09:58:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] target/riscv: deprecate 'debug' CPU property
To: Alistair Francis <alistair23@gmail.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 tangtao1634@phytium.com.cn, devel@lists.libvirt.org, qemu-riscv@nongnu.org
References: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
 <99f0437cbb0169ffa318af4864ee48af22abeb17.1775959096.git.chao.liu.zevorn@gmail.com>
 <CAKmqyKOMC-kvrxOMYx33m1W7zi1JY8gJoX-oRLDQo4pFRAyhfQ@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKOMC-kvrxOMYx33m1W7zi1JY8gJoX-oRLDQo4pFRAyhfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8pFwNCJI6oF4hGRa6ll6bffCvIXtF3vg
X-Proofpoint-ORIG-GUID: 8pFwNCJI6oF4hGRa6ll6bffCvIXtF3vg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyNCBTYWx0ZWRfX5Vg+Vw/mKo2e
 nN89yMnxyYB4z89ZPa3HWFQuxL9zmxi2mhbr4HOf/XKGfPsCCY16Tb5OFQlTRiYbL20D9NTpdkC
 jHLUj2WKHHn/8VIuuCaKSGgTXyjuhtyFeja9iIiBGVLj3to+HuwYytj7WBWk8jNZdEN2upq46mT
 oRk0r7yZeG0gum47cPrVtYbvSyqvDpUJ5cBxqVZ1PVKoYrxlJvVdrRK2FoQjXPO9XyXZ4uX24ty
 h/KMWvO/FfRrwbD991j3xNtnwDbyGLopU7GeKW4XldC7kglEuP0uv5g4jYhiWeQMkBaNCKVFe+v
 I3MMD+8+8RgMbLEetJuF7iImLLG+Rh/hweTqVoDCZ9MMk3+V91wENnOBVy+OpnGwOPvb+W3uiPe
 qnlcl8sP5SZ0AlvQPveTkb9YSSZinyhwvUhWrUfHMARUODFw7/Ud3AfphlOktt84dzIuUmtcTRJ
 G3zRbEE7bdobLZLvGTA==
X-Authority-Analysis: v=2.4 cv=YtE/gYYX c=1 sm=1 tr=0 ts=69e0dd12 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=5MtUiKxBt8oBE196zZFg1Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=xvfqbYfxAAAA:20 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=fgrLqfBXAAAA:8 a=EiWxHvZ6-CmkmjpfQDAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160124
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 4/15/2026 11:32 PM, Alistair Francis wrote:
> On Sun, Apr 12, 2026 at 12:22 PM Chao Liu <chao.liu.zevorn@gmail.com> wrote:
>>
>> From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>
>> Starting on commit f31ba686a9 ("target/riscv/cpu.c: add 'sdtrig' in
>> riscv,isa') the 'debug' flag has been used as an alias for 'sdtrig'.
>>
>> We're going to add more debug trigger extensions, e.g. 'sdext' [1].  And
>> all of a sudden the existence of this flag is now weird. Do we keep it
>> as a 'sdtrig' only or do we add 'sdext'?
>>
>> The solution proposed here is to deprecate it. The flag was introduced a
>> long time ago as a way to encapsulate support for all debug related
>> CSRs.  Today we have specific debug trigger extensions and there's no
> 
> The flag was originally introduced to support the original debug spec:
> https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vote
> 
> There was no sdtrig back then, so debug was used.
> 
>> more use for a generic 'debug' flag. Users should be encouraged to
>> enable/disable extensions directly instead of using "made-up" flags that
>> exists only in a QEMU context.
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
>> Finally, deprecated.rst was updated to deprecate 'debug' and encourage
>> users to use 'ext_sdtrig' instead.
> 
> The problem (and this is always a problem with the debug spec) is
> there are now two ratified versions and no easy way to support both.
> 
> AFAIK most hardware supports version 0.13, although at some point
> (which might have already happened) that will no longer be true as
> everyone updates to the latest version.
> 
> Generally QEMU tries to support all ratified specs, so we are
> reluctant to remove 0.13. We might have to bite the bullet one day,
> but ideally that would happen when 1.0 is much more commonly used then
> 0.13.
> 
> So, the question is. Do we actually want to depreciate 0.13?

RVA23 is compliant with debug 1.0 only, as so other specifications we want
to support (like RV Server Platform).  Distros are already moving on to RVA23,
and by definition away from debug 0.13 (if they even supported it in the first
place - not sure).  So I think it's highly unlikely that we'll have someone
that cares enough for 0.13 to the point of complaining about this deprecation,
let alone helping us keeping 0.13 alive with 1.0.

And our deprecation process takes time.  At the earliest, if we move on with the
deprecation now, we need to keep supporting this 'debug' flag until August 2027,
and then remove it in December 2027.  There's lots of time for interested parties
to chime in and maybe convince us to not deprecate it.  Which again, I think it's
unlikely.


I believe we should go ahead and deprecate it right now.  Thanks,

Daniel



> 
> Alistair
> 
>>
>> [1] https://lore.kernel.org/qemu-devel/cover.1768622881.git.chao.liu.zevorn@gmail.com/
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
>> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   docs/about/deprecated.rst         |  7 +++++
>>   target/riscv/cpu.c                | 51 ++++++++++++++++++++++++++++---
>>   target/riscv/cpu_cfg_fields.h.inc |  2 +-
>>   target/riscv/csr.c                |  2 +-
>>   target/riscv/machine.c            | 24 +++++++--------
>>   target/riscv/tcg/tcg-cpu.c        |  2 +-
>>   6 files changed, 69 insertions(+), 19 deletions(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index a6d6a71326..cba050334b 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -452,6 +452,13 @@ It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
>>   only with ``-cpu max`` (which does not guarantee migration compatibility
>>   across versions).
>>
>> +``debug=true|false`` on RISC-V CPUs (since 11.0)
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +This option, since QEMU 10.1, has been a simple alias to the ``sdtrig``
>> +extension. Users are advised to enable/disable ``sdtrig`` directly instead
>> +of using ``debug``.
>> +
>>   Backwards compatibility
>>   -----------------------
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 38286b6b40..6208201538 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -210,7 +210,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>> -    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
>> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>>       ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
>>       ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
>>       ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
>> @@ -783,7 +783,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>>       env->vill = true;
>>
>>   #ifndef CONFIG_USER_ONLY
>> -    if (cpu->cfg.debug) {
>> +    if (cpu->cfg.ext_sdtrig) {
>>           riscv_trigger_reset_hold(env);
>>       }
>>
>> @@ -947,7 +947,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>>       riscv_cpu_register_gdb_regs_for_features(cs);
>>
>>   #ifndef CONFIG_USER_ONLY
>> -    if (cpu->cfg.debug) {
>> +    if (cpu->cfg.ext_sdtrig) {
>>           riscv_trigger_realize(&cpu->env);
>>       }
>>   #endif
>> @@ -1126,6 +1126,14 @@ static void riscv_cpu_init(Object *obj)
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
>> @@ -1240,6 +1248,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>>       MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
>>       MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
>>       MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
>> +    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, true),
>>       MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
>>       MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
>>       MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>> @@ -2654,8 +2663,42 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
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
>> index cfd076b368..93b4864933 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -776,7 +776,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>>
>>   static RISCVException debug(CPURISCVState *env, int csrno)
>>   {
>> -    if (riscv_cpu_cfg(env)->debug) {
>> +    if (riscv_cpu_cfg(env)->ext_sdtrig) {
>>           return RISCV_EXCP_NONE;
>>       }
>>
>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> index 09c032a879..62c51c8033 100644
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
>> @@ -425,8 +425,8 @@ static const VMStateDescription vmstate_sstc = {
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
>> @@ -492,13 +492,13 @@ const VMStateDescription vmstate_riscv_cpu = {
>>           &vmstate_kvmtimer,
>>   #endif
>>           &vmstate_envcfg,
>> -        &vmstate_debug,
>>           &vmstate_smstateen,
>>           &vmstate_jvt,
>>           &vmstate_elp,
>>           &vmstate_ssp,
>>           &vmstate_ctr,
>>           &vmstate_sstc,
>> +        &vmstate_sdtrig,
>>           NULL
>>       }
>>   };
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index f3f7808895..0613450691 100644
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
>> 2.53.0
>>
>>


