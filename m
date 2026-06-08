Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1422CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdEd-0003e2-4W; Mon, 08 Jun 2026 12:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWdEa-0003Uw-Jv
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:53:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWdEY-0007qb-SM
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:53:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658FFW1Y3588417
 for <qemu-devel@nongnu.org>; Mon, 8 Jun 2026 16:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1GsNrgRxTDhbBk/dFoxdmC8ACsjju7Jlh4G8J1+yM2I=; b=oXhq6I/gEhqKDc05
 l4mIRNL3Go+PNsFOyy5XpP2vjKZU7EZgi5XyUVmZryoZgfIqQ8enO1QECohtlXZ3
 hvsjkUJMwSZL74IYMCryNAnK0TOCgvahXHHhnCC753Vxhktkvltzk6AHd0rGfLPN
 WAsNDabuh+dGtjdlx1i+bx9H9PJc7Y0sLSkQD59feGwtS+OCvVw/jHUe9gTP9jCQ
 Y7A8xfvXTMVdfceS+QwawE2n5sijEU5gbz0WoJsZyaMlaOxIPxIQ/a+c37b/NSI+
 ZxCyWTyvDtHItzNuuTpPb6Gi9rxI9XHR6Psi/hq3ShYR51Fq7T7h74sflo+/r6HL
 Rgr+5Q==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun41w4u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 16:53:52 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1370417c0bfso4233572c88.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780937632; x=1781542432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1GsNrgRxTDhbBk/dFoxdmC8ACsjju7Jlh4G8J1+yM2I=;
 b=TpfoAwfJiPVHv41HBI3tFjheAQWXd/Bupis+pBhMb4VEnhNiOQHBy4/EsVYYTf54ws
 M7yj0M7T5rmsWFQ0lhxSo05RDDtYaTXgOwKD7Xxn/FTpXUUjyBkWKTdxAWjY5QB1s2l0
 fk69C1busJtRw+mcTJQNkQo3hYgdkOp2HwnvHaoM20NzPnwNWrNeMgNNhRyPBkE8IBaO
 oY6FZc88Ggo5/hAp3mDl0IOam9FidcVqLMOaJSD3F2o45JYGvaIOfs1weIqSzuCvoYGW
 6JDK45Bexp//mNopLgXa6wxeTTuvwyvkwtLyq+D8F0TmDRPRxKkqklJNgpvcEuF4gIex
 iCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780937632; x=1781542432;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1GsNrgRxTDhbBk/dFoxdmC8ACsjju7Jlh4G8J1+yM2I=;
 b=hxws3rZNWi72Vpi0YSqr2LvUA99jmnpDhWTAVgpnfTA3topp83H/f4J3caFtBMIH7a
 zVMpPVuXuVrtPKNpWTBk/bY0ge2JcR0uPyJMIOpJd1Q+APtwxmnd53UTR5yTsiYK4JzN
 281G9yPTlspozUg/qrVsDoNBmfZBfZCXKMdIzcjih9lnKbW+DHsChioiEui9Dzk9D0hC
 Bkpq0KmUtvtZRaKEVTjLAa+1f81GG8QTU+fIn/jivhD/ksKTed/JurmjpQ5dXDlkig7X
 8MiaelAtYsCIB+jcYGQNGyBPqPmPXsPMeJdgZEG0cG/2xJBt8TB6NBfH/pMY0xFJwzBd
 ezfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NJWMY545v0TdA8ZcD4yAfMLfqQSEHr8K9vdRfbW3Ec8n+a/NG6TcmGV8MnjBQptPaVZ2RKSwJnSIA@nongnu.org
X-Gm-Message-State: AOJu0YxkQmeCZwjw7opsEySeuFZh4jC/hewWmPer+ABD2jMRgtJ7Ecws
 pFW1YaJ6PKJ1RXW/u8hkrKFyFzMyS3G7t0Z2cH4VsgxAobqdjlSHDEBUokfkxjIpOIipUfw/0ja
 88RFqoL1vvvZ4C0/5+7y4hoXT0Vqd//WTOgVA8kSd76zFhPBjQhcUiQtWaw==
X-Gm-Gg: Acq92OEh3xJaYr94G5eqbDJohxK0TjyQP0X9cAqiUfrpw/zK8rAgUV5gbmA4z4SB3cq
 UcKFKVitmH/qf2goiF3SiDBpMW82uVk9vA83FudVdjN+6n+LXM0cm5dP1LHNPzSg6UTI9306Qek
 G3JG2rqyIXIPE8sRCWp2d7eEEmsN5pCQKxX26f69CUukXxnkeNfgP2D2I0rjiYQSRmVFMBXJm66
 uTltlsSRBDnmIPdG8DKuA6EdgHJtz+nwX4/EJCwXDObT6j99lUI6YpxNHLf6SC3eGqapVzW/Ulp
 YeBS4LMIUjJcF2DhGvhxutHyzYl+9NyfqWZ8LtIeOhWojgkrGHHY4JyFOFoJb+XgS+pTcW98EV2
 3+e8H9HhjerTMeBwonnKMrnV6r+VmrrOS88Ol7YVVaF03G7YlTWod26O+nk90yuS/09td5cDywu
 Ystw1vuWPqwE/mIHpXdN4EFqHk
X-Received: by 2002:a05:7022:160c:b0:137:ee08:ad37 with SMTP id
 a92af1059eb24-13807d75982mr6845262c88.13.1780937632051; 
 Mon, 08 Jun 2026 09:53:52 -0700 (PDT)
X-Received: by 2002:a05:7022:160c:b0:137:ee08:ad37 with SMTP id
 a92af1059eb24-13807d75982mr6845240c88.13.1780937631478; 
 Mon, 08 Jun 2026 09:53:51 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5539432sm15070003c88.9.2026.06.08.09.53.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 09:53:50 -0700 (PDT)
Message-ID: <ab20e1f1-51b4-45c2-a1f2-f842e828c8d7@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 09:53:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] plugins: bump version
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-2-pierrick.bouvier@oss.qualcomm.com>
 <tgau1a.ktx4pl5etvkk@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tgau1a.ktx4pl5etvkk@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MSBTYWx0ZWRfX1LFdUI+rwHmy
 ORF7lAptXgaB3e5/EfWjseg46xJLo5gSemzAJJuS0FD/dnQHTsMemJx3auwdIygNmP9L+N3fNX8
 d03+2hfHidCG5nUrLnKEZhVimS3b2CrWQTsez3rU0v+KDHDDS/AKkEzeTx9bv88LLyb3f4TcNEX
 L4rVhzy8rxW6Gx1bsBPneQxehmnEowruyX/0w1ib44m1Yo4oZw33xpNtZKiZX3n3nbisB6EkYQ4
 mGzPT7xFVGp+2sYkSepnPE/fimK+B+swpk4FAuPIS5r2JugTH886h50zbFV521M+gD4R2agfSDf
 R4Upa2oPfCvcjI6tH8zenlajPj/7I7B0PrKGbMMSaGaelaQkDBvLBBuUPJ9MeIxdYaO+j1OGRBD
 arQUCLJEgHUC7mDLACmNTEL7VwtkejKqQHVHgxrAai1nr2h2yofFRKttGj+7dtWmz9VLeZRl5FX
 ObOvomMUBKUp3MLJY7A==
X-Proofpoint-ORIG-GUID: 9zJKdQqOglPfc9xY2qhVXGG3oB2G8I7E
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26f3a0 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=k7pgqVW5xrXgoEMQx38A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 9zJKdQqOglPfc9xY2qhVXGG3oB2G8I7E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080161
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 6/7/2026 10:58 PM, Manos Pitsidianakis wrote:
> On Wed, 03 Jun 2026 23:51, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> Next commits will be breaking changes, so bump min version and version
>> accordingly.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
>> include/plugins/qemu-plugin.h | 6 +++++-
>> plugins/plugin.h              | 2 +-
>> 2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-
>> plugin.h
>> index 4eb1d2cd85c..435a14f5a00 100644
>> --- a/include/plugins/qemu-plugin.h
>> +++ b/include/plugins/qemu-plugin.h
>> @@ -80,11 +80,15 @@ typedef uint64_t qemu_plugin_id_t;
>>  * - added disconinuity callback API (for interrupts, exceptions, host
>> calls)
>>  * - added syscall filter callback API, which allows skipping syscalls
>> and
>>  *   setting custom syscall return values
>> + *
>> + * version 7:
>> + * - add userdata to all plugin callbacks, allowing maintenance of state
>> + *   externally, and easing interfacing with other languages.
> 
> You could alternatively add only "version 7" line and add the
> "changelog" lines in the patches that introduce them, but doesn't make a
> big difference.
>

I didn't find a better place for that, since next 22 commits are kind of
an "atomic" step regarding the version bump.
 >>  */
>>
>> extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>>
>> -#define QEMU_PLUGIN_VERSION 6
>> +#define QEMU_PLUGIN_VERSION 7
>>
>> /**
>>  * struct qemu_info_t - system information for plugins
>> diff --git a/plugins/plugin.h b/plugins/plugin.h
>> index 6fbc443b96c..9179da43851 100644
>> --- a/plugins/plugin.h
>> +++ b/plugins/plugin.h
>> @@ -16,7 +16,7 @@
>> #include "qemu/queue.h"
>> #include "qemu/qht.h"
>>
>> -#define QEMU_PLUGIN_MIN_VERSION 2
>> +#define QEMU_PLUGIN_MIN_VERSION 7
>>
>> /* global state */
>> struct qemu_plugin_state {
>> -- 
>> 2.43.0
>>
>>


