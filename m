Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B85C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXMF-0007Br-K2; Mon, 24 Aug 2026 12:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXME-0007Bj-BX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:17:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXMC-0008Fz-3V
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:17:10 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFmh8X3994122
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4zs4d4WtYfcS0AphH/4z0vBV0GAFHVOgr2ReRGEk0A0=; b=aa86ZClZmMZ63JVT
 4Y/7WKeGVya9TayyhoS/iMN8qMfM1KIr8zK28uyepQ6SI74+p2PzJSL0Olowvqry
 SZDaImQYuSGwCRf4TCQaBV8VHEYL0+WFJNZbEQcEXOMNpPIDGAa3P+TmW56nBTA7
 p5YN1GI7xvTQetzNt9NDeMBWVd04QKc9ft0njgQM6R4sni2KbSA4xx7Xr5499JQ5
 V5WaPixWrp4jgNURsD6KXYiEb/RGW7H2KGC1E7ONdpD6Ninfy1dfkAj+uTqW2JGz
 0Wua4e5Y1rIsjdV/mTGZR9p/G13axwf235DYsUbQVZ80nDD4cobatHPW1JNAsES1
 m4Z/sg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk24gr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:17:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccb6823efcso29838025ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787588224; x=1788193024; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4zs4d4WtYfcS0AphH/4z0vBV0GAFHVOgr2ReRGEk0A0=;
 b=ev8Xqs2UzAnTgxTlqp/tuCkopo0hOnJR1Be1qvtmTMJ0wkgyLUBl04rU0nNtIIwFNP
 BVwmXy7pYJzbqVskreeVXmdAeGeycNfvy0ndf3e9ddy2IaPN24Z4Q9ttLDs1NERHL822
 gpfz1ODAnp1ZcvNBC0Q5YxAvVJqE1WxfYgCveEqm0Fhd++bRZ/YbNX71fzZFhaPckIMi
 QHjiYL8m0xlwFeTpfJ1QlEbJkq9BC0zoIugFnEW8Qm1cSk0Fxf/jfwu88iZydKrjxA8E
 8EsArBFU6dA7zl604ZNGQYuGyckLqyMaj/FH4PUkfDCDJRcDXoVOCglJz5jJ2IkQ9o/k
 vQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588224; x=1788193024;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4zs4d4WtYfcS0AphH/4z0vBV0GAFHVOgr2ReRGEk0A0=;
 b=XT8cYQ26WnvDswcEXv0Zq+c4oUdEfed36z0sVDf2j212GUIGC6heTYcs4MJYUQdJ+3
 o3qgB216oACBgKnnVouab8qpO5FsMjEnnAJLFR91BHugLB6mAoRrqmz3hiZZfW+KDMAC
 bJi9AL28eYEvH1AfPR/PFl8QFEgTpqmQEfn1RFuUuDygH73m/FBAyj8KMdjHgkXHcvdI
 nkuad9CJNV7qHXZ0P/2t4tD2EwvvV3fKDfbFwln4D0LMmOwVD4adIuUKkTVoeZxTmZWg
 DHhGa9SwtAKCxHe/riDXnbzsGnH0YzcB5D9v5G3UONkosHEXMnB7bV0byWO0LAkKB+Hq
 LqhA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsrNd/PNKOxdkYKAq+H93fQIda2d2CqydAgvy/yJFVaqQqWxDe7KRzMWBaGauh/70lA/2+DXPXkjrU@nongnu.org
X-Gm-Message-State: AFuF++majvkVgrAka0p/EJ5QvrRfpT5U4DxSzvG1bWZziqlng50TlW06
 JIcjg54gpPGmbzQUb8JRvXvfl56HflhQ48k9mb9LlNIy9n/vfV/HMOCGbLEV6HZUf8vB5VBBk/Z
 uZAfYObkBQlK5Q3OymW8Py05/MLU/a2M9cmFtFgZhyPoeDHkFa7seYpG/KA==
X-Gm-Gg: AR+sD12n3nMNj6RD2aMQ2SEHELnZcmJNeQmZMhakR7XWq0N22psLgMO2Ios/+FOEQd8
 vP5VwJZq4jk6WHu18D51ZoWeNzNe4/ja8DWaWZ+6v1Dhom0cdr+Me9oOMZQFD7ijibiTKVMxuz+
 MS5ehiQMzgCu9+DU0Ak8nCbYS5g29sC7pqXVD85aAvT/cZ9j/+uElpjQAuPdOYSbNJucIW/1Od6
 7W+Q0sSvg7ld435VAJtEAEZQ9S5m6idjISQlbt1Ty+zDeQ9N3BUcIymTJnT7u30gYccmhxN64VL
 LBRjiac5P4ORmTEN0Rp2RWCI6LTb2UjaWPpbe8M20mIcKwEYfW0qX6ihJHKLGbU0W7bhFv2s3el
 xE+12je/e93OUaoQ7TQsmMuKdTveK+DMQQG7BT3k7Wq6r9a9BCI3Kkw3QscUFL35CKcVW
X-Received: by 2002:a17:903:fa6:b0:2d6:5beb:8692 with SMTP id
 d9443c01a7336-2d670bb5042mr394092815ad.6.1787588224243; 
 Mon, 24 Aug 2026 09:17:04 -0700 (PDT)
X-Received: by 2002:a17:903:fa6:b0:2d6:5beb:8692 with SMTP id
 d9443c01a7336-2d670bb5042mr394091105ad.6.1787588223664; 
 Mon, 24 Aug 2026 09:17:03 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f925190fsm47147145eec.31.2026.08.24.09.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 09:17:02 -0700 (PDT)
Message-ID: <f97cdb7a-2afa-42ac-8742-1113af636266@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:17:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qom/object: add available_if field to TypeInfo
To: luoyonggang@gmail.com
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
 <20260821235112.193381-2-pierrick.bouvier@oss.qualcomm.com>
 <230c2fe0-94f8-46e7-a574-9d036ced67b8@linaro.org>
 <6daaa4b7-4f84-44f3-9cc7-a70935da11b2@oss.qualcomm.com>
 <CAE2XoE_feFKfLRk7_2eiAW5rmKCgx7ZQAk_uLtDY_0+rxo_PeQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_feFKfLRk7_2eiAW5rmKCgx7ZQAk_uLtDY_0+rxo_PeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Rj6FiFh-3AkoejhJPGqy82r3g1hWLvgE
X-Proofpoint-GUID: Rj6FiFh-3AkoejhJPGqy82r3g1hWLvgE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNyBTYWx0ZWRfX0i7D+EWgOZgF
 G4yPxLUCtNvxy1wfxq0JdPK6HBMKUGJk6C/N51OlOnBywAVeuybKcFDBi6H/OHN4s6hYBYJMNzL
 98+5VBJK5pdeXDxPTGT5G7XCz/EEVqw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNyBTYWx0ZWRfX+fYe8HeZzKr8
 FCo7EAkfiAgkKXoPeAXxA1fI2JvmjVOHAJD99SNmDHZO+7OnYUoBAVp+Knhs+OyazFhyRjZsBh8
 6+Ek+npp6bHt2F7nMc/rdGh0PRzdyqi92cVlBKgzXYCkW++RKd0vCRsN8wIdcf5myJV/Wq1lRL9
 8q8vG4I5y7wEG5fDTzyHTi7xxPdFJ9+uPJtUw4IjHw47eyxP1iXiOHI0kgtY9AhL1v0DcoHn1UF
 aiux/4dtUT8kM68YbEyLoK8V0iT3pVzuNjpYf1atzqXytI/0iXOlEtK4UNmENw8/CLBSXNVDVR2
 mxc/sCKKWbvOUSOLdEcxqiEWGqSpRAdFYt+ypmMdbozeBB1VKlbTQ3Jn40C8AoCRfk84rZmxWd5
 hxgCmNykoxHFxOi0XBAROogy795nF6o0OjQ3SnVVJPCH8qvaG0oYW4o/N8mlOTPV/soPLCqnH0G
 UaaFXhutI6LYRBd5dXw==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8c6e81 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=GaQpPoNlAAAA:8 a=pGLkceISAAAA:8 a=oun5vsI0rCssSFROv98A:9
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240137
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

On 8/24/2026 1:39 AM, Yonggang Luo wrote:
> 
> 
> On Mon, Aug 24, 2026 at 2:54 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>
>> On 8/22/2026 7:23 AM, Richard Henderson wrote:
>> > On 8/21/26 16:51, Pierrick Bouvier wrote:
>> >> With the single-binary, we start mixing types for different targets,
>> >> that may or may not be available for current one.
>> >>
>> >> Previously, we implemented an approach based on interfaces, but it
>> >> proved to be too limited. It requires duplication between
>> >> machines/cpus/devices, and does not handle specific cases where a type
>> >> should be available based on a target configuration (Kconfig).
>> >>
>> >> To solve this, we add a new field, available_if, to TypeInfo.
>> >> It is an array containing a list of requirements for type to be
>> >> available.
>> >>
>> >> For now, we have only targets as requirements, but later we'll add
>> >> specific target config entries also.
>> >>
>> >> We also add a TARGET_REQS macro, to declare a list of requirements. For
>> >> sanity sake, we don't use a complex variadic macro prefixing each
>> >> parameter. It requires a lot of macro boilerplate in C, and prevent
>> >> readers to jump easily to definition for each parameter.
>> >>
>> >> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>>
>> >> ---
>> >>   include/qemu/target-info.h | 11 +++++++++++
>> >>   include/qom/object.h       |  5 +++++
>> >>   qom/object.c               | 10 ++++++++++
>> >>   rust/qom/src/qom.rs        |  1 +
>> >>   stubs/meson.build          |  1 +
>> >>   stubs/target-info.c        | 11 +++++++++++
>> >>   target-info.c              | 13 +++++++++++++
>> >>   7 files changed, 52 insertions(+)
>> >>   create mode 100644 stubs/target-info.c
>> >>
>> >> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>> >> index 6c5b714288e..6379e65bbcf 100644
>> >> --- a/include/qemu/target-info.h
>> >> +++ b/include/qemu/target-info.h
>> >> @@ -50,6 +50,17 @@ const char *target_cpu_type(void);
>> >>    */
>> >>   bool target_big_endian(void);
>> >>   +typedef enum TargetReq {
>> >> +    /* 0 is reserved for end of array */
>> >> +    TARGET_REQ_BASE_ARM = 1,
>> >> +    TARGET_REQ_AARCH64,
>> >> +    TARGET_REQ_ARM,
>> >> +} TargetReq;
>> >> +
>> >
>> > Is there a reason you're inventing Yet Another Enum, especially when
>> > target_base_arm etc are based on SysEmuTarget, which itself is used to
>> > create bitmasks of targets?
>> >
>>
>> Mostly because we'll have to add CONFIG as TARGET_REQ. (CONFIG_NITRO for
>> instance, please see v1), in additions to targets.
>> My original implementation was using an interface with a callback, and I
>> offered to have this callback as part of TypeInfo. Daniel insisted on
>> having a list of constraints for (future) introspection purpose. I think
>> it's solving a problem we don't have yet, but need to move on on this
>> series, and happy to implement anything that satisfy the community.
>>
>> In all cases, I'm open to other ideas if you have something to suggest,
>> which can represent both target and config knobs, with a simple and
>> concise solution. Enum was the best compromise for me, price being
>> duplication with existing SysEmuTarget.
>>
>> >
>> > r~
>> >
>>
>>
> 
> I've implement single binary for arm/riscv at https://patchew.org/
> QEMU/20260823150731.896-1-luoyonggang@gmail.com/ <https://patchew.org/
> QEMU/20260823150731.896-1-luoyonggang@gmail.com/>
>

Thanks for giving it a try.

> I do not see why this is needed yet.
>

Try running -cpu help, or -device help after applying your series,
you'll notice it accidentally exposes all cpus/devices for all targets,
so it breaks the fundamental promise to keep existing command line
exactly as it is for current binaries.

That's why we're trying to solve this filtering issue for all QOM types
(machines, cpus and devices) *before* sending the series adding build
system for qemu-system + -target option (which I have, waiting on my
personal repo).

The v2 is a result of a discussion with Daniel on v1, you can read it
for details.

> My patches is based on  https://patchew.org/
> QEMU/20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com/
> <https://patchew.org/QEMU/20260724000948.234657-1-
> pierrick.bouvier@oss.qualcomm.com/>
> ```
> +
> +static TargetCpuOps target_cpu_ops;
> +
> +void target_info_register_cpu_op(const char *cpu_type, size_t offset,
> +                                 void *impl)
> +{
> +    const TargetInfo *ti = target_info();
> +    void **slot;
> +
> +    g_assert(ti);
> +    g_assert(offset + sizeof(void *) <= sizeof(TargetCpuOps));
> +    g_assert((offset % sizeof(void *)) == 0);
> +
> +    if (strcmp(cpu_type, ti->cpu_type)) {
> +        return;
> +    }
> +
> +    slot = (void **)((char *)&target_cpu_ops + offset);
> +    if (*slot) {
> +        error_report("TargetCpuOps already registered for type
> '%s' (offset %zu)",
> +                     cpu_type, offset);
> +        return;
> +    }
> +    *slot = impl;
> +}
> +
> +const TargetCpuOps *target_info_cpu_ops(void)
> +{
> +    return &target_cpu_ops;
> +}
> ````
> 
> To see different func for different arch
> 
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo

Regards,
Pierrick

