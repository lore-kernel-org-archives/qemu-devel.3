Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A6606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mKChgxMT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fU5itpcC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXcm-0006vW-4Z; Mon, 09 Nov 2026 17:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQXcl-0006uB-91
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:13:59 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQXci-0001qU-9W
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:13:59 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9LA2pl2376535
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 22:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GDUerUJMyyyRZNDd9ojhdW8P69NKNWh08hh2ZbTp8yU=; b=mKChgxMTnzplFJ85
 oxPOC/0PRIPg4P5DB/kFur+PTzbFjw2Pm+tJMs0N+rrbxGBozDH4YZ5w8aemsaMB
 AH6Gv6qpVOUW5a13oBFpxCDX20Sk0KvS3wsOZdAntLALEVEQqcdiipjXLz+2ZYh4
 77K0dhSVWaZI6nBXY8iLppj+o7m8/3qNCtNercyxbzMhUGyuBcgNhk+akDGldemz
 9dQfsDD0Bq6A+xUr69FzA/Om4Nld1Ra7AyI11leHwlxDW623s1+oROieWe7q8St+
 4V6HV2OICkytcF/pTnC74P2qDvPj99dp1+pTfm3POriYd9A9ymvj0J+7br/qHtod
 jA3BJA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0qt44n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 22:13:48 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc36b97a77so253850137.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794262427; x=1794867227; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GDUerUJMyyyRZNDd9ojhdW8P69NKNWh08hh2ZbTp8yU=;
 b=fU5itpcCJ2wpeCGGVyRR/Sc2d7WGhY2H1XOOsdu4LimFww8LT/0zL+//3z5kWnKQbq
 iCWrsihqXR/Prt0ccORcZruyg5NCeq9foChOMjaZQAmbHdH5fnF6gorYMV2Q4YvaajFp
 uiOJdWHBqR02KYCCWg3RzohC+qJztKyU9jFTMVYrH9yY1Hiv/zD1MoapH28hSOQ4roPt
 gCruMwzpuPZn+ZAwtimj2nLacJCWtkN5Y+HcoXY2eN1ipmr34PXNr+LJe4z0TbBVpGH1
 SYrQ2ESTYxy+FxvVb9VyU0H9vBxb6p2xosQMfeaQBAyvRbwtDTIfCOeZjLJ+JIU9YLGi
 1FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794262427; x=1794867227;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GDUerUJMyyyRZNDd9ojhdW8P69NKNWh08hh2ZbTp8yU=;
 b=tOi+VzFMYWpT8cODb7p2EDlwP2MaUb1ZfokGe7hLBjGVijYexUXG7LdGwzMJcVOL6L
 SzVs2CUs9TBj9AcDY2Vv699x6CZL+DYQreuZz5uh676Kloq0WyC06+zv3Mvd8arFbHWx
 gWPsHLdgCfr+M1QTM6gsO/D/REVsdYU9oXWMmYxvRb9KsrK+5uxSGH8qJlQF2HTIt1Sg
 X/M2AXIDJsM/audEHDeakDufEkr61HA+J01jOIPmkjQgqYK/jUvVzLDXttmcA2e9V28P
 vrWpcx1zrL/hodZ7pRdSjeVUJ9/TpwWyh+5f2y2GK8JgTIP9UPCWIWhrB1/ETf9HJi8M
 rDfw==
X-Forwarded-Encrypted: i=1;
 AL+hErGrB0qDIVjhvcfUduu4BltSdshCoK4Mz8k0uSLg4TjhjEbuXr/UgFv4TTzvdJ5o0s8VxA2KrZ8X8PU2@nongnu.org
X-Gm-Message-State: APuU4Z8BM1LL78I867r9f2873HvzLMAwb8VludURCmoQySBmWJLya511
 LgagnDX3FNerzGvWjdaqo8gmAVaGV67ynew3G1qK2q2+MMLf9hiCL1ey0Lxlk7Vh2LQCNWc2tMh
 zT2/cjyaOqlY7o9/Ir4MVH+ARe5hBdLkYVyZwiF8fjVOLIb1Wc7O0nBadxfam97jJzQ==
X-Gm-Gg: AYBFou3gI82JS5M8R5t2PB883bE5bK8T2r5UOmjgrp1OVnvOdOwsJM9C4QmSE3cz/he
 Q/nKhbsZM1X1aOwz+tZ3DqfeB+v89/18Hsok5xUJi6R37zMk8splgHop56dDm1X3XuzIDL2OYCg
 W4/dXNb5gfO+t5GN8qof50VB1EF7wbIDrmmI6uMvHKAGl6fK9J/ivDNMEfJ8Fi4aozaP5TH8gp/
 mngyQ66SecG13baSo8HtKIGjxTCU68l+Vm1vyLkVRsXSabRj36kO3AHOJbQ3/3o3Vo18JPdSHr/
 bfIRK6/rQxjjepEpYzhaZByDTMc6PfvKy/0TdRwvbiGaqfkcBGyEzOENIzGyXkVaoiSSs+PN47f
 gvpzAutWzUTk+7YVJIqBAHDKirm8JhAytvPaHQX4HzcKmXzekJL59gNH6TOBSAszmynKu79V+40
 DcizAqSg==
X-Received: by 2002:a05:6102:2922:b0:7cc:2cd0:e73c with SMTP id
 ada2fe7eead31-7d301c05c86mr242304137.25.1794262427331; 
 Mon, 09 Nov 2026 14:13:47 -0800 (PST)
X-Received: by 2002:a05:6102:2922:b0:7cc:2cd0:e73c with SMTP id
 ada2fe7eead31-7d301c05c86mr242300137.25.1794262426861; 
 Mon, 09 Nov 2026 14:13:46 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe61e6sm17991305e9.6.2026.11.09.14.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 14:13:46 -0800 (PST)
Message-ID: <14393e41-27eb-4d94-b2aa-8d377cf6a5eb@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 23:13:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] replay: Explicitly require round-robin TCG
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20261105131549.42175-1-philmd@oss.qualcomm.com>
 <20261105131549.42175-2-philmd@oss.qualcomm.com>
 <37a58cfc-93a6-41a4-a512-67c7f8bd9054@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <37a58cfc-93a6-41a4-a512-67c7f8bd9054@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4OCBTYWx0ZWRfX/S7OHGqLgp1T
 3EsJyGQRZ2lHKmwRODle1u47OkQlxKJlfgO/qOtjjYgX1EaUPQKmNOjEFi3vK2eON2R629fpfea
 04kdvV+i5tfy1dYjKUdv9cf+Hu6OVYvpOwQMa5z4F4qFTgVHHxA15liSKtqYYE+q1BRAys5W1z3
 FKOeYAbrykQBu8Hc9nwcG2q+vS+jsQtf0Qkw3CavDt5W14H0IK5KailaEn0sV5vsSmldrLUeqyI
 7WUa5l7zPz/MO3JyZ+kNDDzDSrdtkTSbplfuTSJK8DpqhzUUH8cH/gYjAl5gm1DDKCVufPyjy+C
 YpGqXQ03VRBT+BV5/ncCQ2LDTP6Sd1Y3Ovk3ePuyOMS+He+6lSNsMAHv+HnJJhXaIl7hlGDgcFF
 dm7WhP9QqWwL94rJgV7VtMGxGrz60KWgEasb73BQtWmQs2WT5GIwyr0fMl0helspaeXOChH4tYP
 nhnNTN9G4USWpzAdulQ==
X-Authority-Analysis: v=2.4 cv=DZuCOftW c=1 sm=1 tr=0 ts=6af2459c cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=aEEsTtAsO1tSP1lrS18A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: W4rXRRBy3Ni7QAE4NswGbTz4kwLlNW8d
X-Proofpoint-ORIG-GUID: W4rXRRBy3Ni7QAE4NswGbTz4kwLlNW8d
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4OCBTYWx0ZWRfX0fN1sb3rORnR
 +P8/ppWMhcPas2RsHcImNaj3ZckXM6BeEjLzmGlbvFHCxQKmrTrqYmdlHb5ndq0rVjUEpcduA+1
 Q6JQHuWrj6oKgP/zoiJ9a5LqAfTOwqo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090088
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/11/26 17:41, Richard Henderson wrote:
> On 11/5/26 05:15, Philippe Mathieu-Daudé wrote:
>> Record/replay needs a single deterministic instruction stream,
>> which only round-robin TCG provides. This was enforced only
>> implicitly, through icount being incompatible with MTTCG.
>>
>> Reject thread=multi in tcg_set_thread() and tcg_init_machine()
>> when record/replay is active, with a message mentioning record/replay,
>> never auto-select MTTCG then, and add a final check in replay_start().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   accel/tcg/tcg-all.c | 13 +++++++++++--
>>   replay/replay.c     |  6 ++++++
>>   2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
>> index bbc733a7070b..6ffe04649072 100644
>> --- a/accel/tcg/tcg-all.c
>> +++ b/accel/tcg/tcg-all.c
>> @@ -125,7 +125,8 @@ static int tcg_init_machine(AccelState *as, 
>> MachineState *ms)
>>            * there is one remaining limitation to check:
>>            *   - The guest can't be oversized (e.g. 64 bit guest on 32 
>> bit host)
>>            */
>> -        if (mttcg_supported && !icount_enabled()) {
>> +        if (mttcg_supported && !icount_enabled()
>> +                            && replay_mode == REPLAY_MODE_NONE) {
>>               s->mttcg_enabled = ON_OFF_AUTO_ON;
>>               max_threads = ms->smp.max_cpus;
>>           } else {
>> @@ -133,6 +134,11 @@ static int tcg_init_machine(AccelState *as, 
>> MachineState *ms)
>>           }
>>           break;
>>       case ON_OFF_AUTO_ON:
>> +        if (replay_mode != REPLAY_MODE_NONE) {
>> +            error_report("MTTCG is not supported with record/replay, "
>> +                         "use round-robin TCG (thread=single)");
>> +            return -1;
>> +        }
>>           if (!mttcg_supported) {
>>               warn_report("Guest not yet converted to MTTCG - "
>>                           "you may get unexpected results");
>> @@ -195,7 +201,10 @@ static void tcg_set_thread(Object *obj, const 
>> char *value, Error **errp)
>>       TCGState *s = TCG_STATE(obj);
>>       if (strcmp(value, "multi") == 0) {
>> -        if (icount_enabled()) {
>> +        if (replay_mode != REPLAY_MODE_NONE) {
>> +            error_setg(errp, "No MTTCG with record/replay, "
>> +                             "use round-robin TCG (thread=single)");
>> +        } else if (icount_enabled()) {
>>               error_setg(errp, "No MTTCG when icount is enabled");
>>           } else {
>>               s->mttcg_enabled = ON_OFF_AUTO_ON;
> 
> This part looks good.
> 
>> diff --git a/replay/replay.c b/replay/replay.c
>> index 14437b32566b..d7d5ddc5a326 100644
>> --- a/replay/replay.c
>> +++ b/replay/replay.c
>> @@ -14,6 +14,7 @@
>>   #include "exec/icount.h"
>>   #include "system/replay.h"
>>   #include "system/runstate.h"
>> +#include "system/tcg.h"
>>   #include "replay-internal.h"
>>   #include "qemu/main-loop.h"
>>   #include "qemu/option.h"
>> @@ -447,6 +448,11 @@ void replay_start(void)
>>           error_report("Please enable icount to use record/replay");
>>           exit(1);
>>       }
>> +    if (tcg_enabled() && qemu_tcg_mttcg_enabled()) {
>> +        error_report("Record/replay requires round-robin TCG, "
>> +                     "not MTTCG");
>> +        exit(1);
>> +    }
>>       /* Timer for snapshotting will be set up here. */
> 
> This part looks redundant.
> Surely all of replay_start is covered by the accel/tcg bits above.
> I would expect this to be as simple as
> 
> {
>      if (replay_mode == REPLAY_MODE_NONE) {
>          return;
>      }
> 
>      assert(tcg_enabled());
> 
>      if (replay_blockers) {
>          error_reportf_err(replay_blockers->data, "Record/replay: ");
>          exit(1);
>      }
> 
>      /* Timer for snapshotting will be set up here. */
> 
>      replay_enable_events();
> }
Indeed; I dropped that replay/replay.c change, thanks.

