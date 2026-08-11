Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094BDC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtmxU-0001a1-Kh; Tue, 11 Aug 2026 09:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtmxT-0001Zc-ID
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 09:55:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtmxR-0004kI-Hb
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 09:55:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDX3Yh462323
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 13:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vQX8GFfoGQyKmI8T8Del13ugd9QTp/Um4gOkszhpidk=; b=kmhH937iL/63tNe+
 0lgpKTqQWheWqmnscyMqkiqTiuL3KEkRpKWJHZUVf14Knzs3uMQMXVk7zfCnNnX7
 DHcSKymYXzbV3ga+z6nyIXXo6Ry36w/5qhfE9NALhkufmmQ/2HxilJpG5Vfmj9So
 jVosrKXWi8mgxQWHMdIlBSnmGujG90Z1qFLR4YXVAdvxvXhTpNaZy/5ygyvhwK+a
 DisK4nI49u0n0v+0sBKtEwphM6r4KtY9hwpGyYNScrvW8CLefwSghwwE+VhUcf64
 ID2xzYleOc/1JYFAMCJpyLNO7xRtdyKoz2jYMLKt3HMiaSvbmE1mFZ05aOipd0rh
 XUMgog==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mg7m3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 13:55:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5283fa0656dso13491711cf.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786456555; x=1787061355; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vQX8GFfoGQyKmI8T8Del13ugd9QTp/Um4gOkszhpidk=;
 b=DKwho+o9fLToWTyU3oS3X0BZpVb7jeDascptdLPGn7DW/jf8yWMeLvyU8fuwZZbP0j
 4z1oDEsGla5vAZ7PL7nr3JRIfGDZTtKggBswr3f64xC9RpONLBvtnjublGPP/L1oqc/z
 TI6TKGwOLoSVqNn7Z9utDDopIFc4LQLJAKEnxqqVf7LgOHQvdQlNl6mJjK0Auwy6z7+9
 GH2NSn32YGC9RCWjEIuWbE1/2g+dK1tebsCRqwZIw0QinBs9kDtfTqDHJGOyJWS3a10Y
 sk5FaWH9cmIuKx636DX0b/opnx8OENGkDmwgFD3B560ntktYuwNntSSbifErhyjdmEdD
 rqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786456555; x=1787061355;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vQX8GFfoGQyKmI8T8Del13ugd9QTp/Um4gOkszhpidk=;
 b=b4FlXfpzFHcOacn8ouPLM9ulI9MNgkWbkdvRsz+SkUQ/c6PQAnOICACDvenCn1ssMP
 p99CnToiETIPT9hR4htTLfVzPbT4AldkTxYNX8aEn2Sv29BYzp6k6WWiC5OP0YsRD40g
 PTOyH+HdgCS7pf0pVKzcEjhsA0kzPxPzDGp/uohKiYriApkIKu0wtZVqOz24C3ijp7Jp
 riiqbhyWYVqvgIbby7pv4b85ukVfJbWbvh+U4mv3xGa5y10xII0P1n2yyzQyw9n6JoDz
 YhGepgv10WRvcunDogaDwoSTnrkDrqPsSSpY+qpS+T31o6x6WtTDt6gSMwBVSAu5/Z4q
 sIOA==
X-Gm-Message-State: AOJu0YyLMI5WMMOcTli8e4RlIf4v6fO/hmVRAKXFntNwH+p0TWzf4NFs
 /wE4noNA1i2RyL5gGD3Zw0KAcMjq2DOX4jhSbbvXRHXu+eOP6DRWfW3/iVgYtFYBCFSNGld+0fc
 jOvRpYtl3/J3QVPWuf1Cwm5+8r5cAzOOEKzV5HzYHMStbJ1XE2yoNc/T7JA==
X-Gm-Gg: AR+sD138tvmpOc0OJp1VitU5G1YoRGvVJgKiGC/iV9YM0PQ50FukAe/XLIkVThd2guM
 iwhQGzf+ARsZH/nHJUa/Ywqn0JHZa4rsIOkK36NtQJN/DaKvzVIr+S5ESl96nSTSF7Iz8IE03PO
 yrvNVmhQRQ1lZbVxtjk0gCrcPy393NBPoKBsh3LHJvn3IS6prkMJj258HoBqeSGeh1MtBS8eYdd
 RJIQdVUZrMzb/vKgLNNr7P3rnHypXZhR5NZtLAM5Kc+EwKF+VDZK+l2mgufpwsNWVfj21oKdf6Y
 mPY4gjYtbKLESCHrwtZl3fqsP8r1By8fSoqZUlDyDQBcv+jh3hvsvyd061pj4R3VE8tDo5Jp1/E
 yGnFvABeGCy+9rMRXd4FRkkRYLIypXaM05J64IIQ6
X-Received: by 2002:a05:622a:2505:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-52d601b392cmr5214351cf.2.1786456555049; 
 Tue, 11 Aug 2026 06:55:55 -0700 (PDT)
X-Received: by 2002:a05:622a:2505:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-52d601b392cmr5213711cf.2.1786456554559; 
 Tue, 11 Aug 2026 06:55:54 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a5be110sm4788745f8f.10.2026.08.11.06.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 06:55:53 -0700 (PDT)
Message-ID: <2f897e89-1549-4d46-aceb-ccf1a86721f1@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 15:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] hw/nmi: Remove @cpu_index argument from
 nmi_trigger()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <minyard@acm.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
 <20260811105425.7429-5-philmd@oss.qualcomm.com>
 <CAMxuvay+TjVoNb0PgmnVj1TmTMHAj7+j7Xm+sTkN58XVUgZ6Hw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAMxuvay+TjVoNb0PgmnVj1TmTMHAj7+j7Xm+sTkN58XVUgZ6Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X6umD-8AQPOg02P1-sw4b42TsM1Pzhr0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExNiBTYWx0ZWRfX3pU4kLOiQ8I5
 7fhTMUg0wavW5vsL/Y6ObiwPj1xZ6R3iFn+h7Z3cUWFRulw8BSimlqXEldEOyMxZGZpJKNeHUa3
 JSRgeVLBh61IppzKJAuhQkavTKVi1Thkj3ID5Kq6yY9x23Qv1JD43xIQKk8lyoIUPdJn5Si16vb
 /FLeXm0gFKCtCjDF02w7cFlkv4mfCViLdT+eUw/O3AptXs04uZsK1NbbWvNTUWcNb8PuJJwHG+e
 V3K5Blm2cQJU0qTS4NS+6fxjNmMwEicmxp8EiXGkoL8NLWw0Zg3XcKrNK1Y6S6z34h1UIJdVF8W
 EpcIQV2jYope+wzNYAp+QmRLpaRGasEc3xbRonI5nvdBVsZLjcmYla0CBzDlcxG1qw01gpv1BL8
 a65YIN39rIO8B5WzSFCE59E3VSjMQDMxe2+q+DG8Jqiq5aLh37+dAO0c6JcrSNI+iqbU/fJ1rln
 goOWAv4iN1HvuyH6htQ==
X-Proofpoint-ORIG-GUID: X6umD-8AQPOg02P1-sw4b42TsM1Pzhr0
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7b29eb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=RL9MCpvF642aKd2_VhEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExNiBTYWx0ZWRfX0xIegHS9Tt90
 B4OXy7Vz1om7m7ne/y4stIIZbcmHHnD27Gq6IcMhYnEwAPYUE+bPEWHApIuGts+to3qTlUzq7Om
 WCm/CcEUosxA4m/WWPnTpt3Lptx5vLs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110116
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 11/8/26 13:10, Marc-AndrÃ© Lureau wrote:
> Hi
> 
> On Tue, Aug 11, 2026 at 2:55 PM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> nmi_monitor_handle() is not related to the monitor, rename
>> it as nmi_trigger().
>>
>> Return a boolean value indicating success / failure as
>> recommended by the Error API since commit e3fe3988d7
>> ("error: Document Error API usage rules").
>>
>> The 'cpu_index' argument is not used, remove it.
>>
>> Document nmi_trigger() as suggested by Peter Maydell in
>> https://lore.kernel.org/qemu-devel/CAFEAcA-yALySmCJLbitCmYpiZKUXJNOavGJG9RYeo8fKqz7gcw@mail.gmail.com/.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   include/hw/core/nmi.h  | 25 ++++++++++++++++++++++++-
>>   hw/core/nmi.c          |  9 ++++-----
>>   hw/ipmi/ipmi.c         |  3 +--
>>   hw/watchdog/watchdog.c |  2 +-
>>   system/cpus.c          |  2 +-
>>   5 files changed, 31 insertions(+), 10 deletions(-)


>> -void nmi_monitor_handle(int cpu_index, Error **errp);
>> +/**
>> + * nmi_trigger: Trigger an NMI, in a machine-specific way
>> + * @errp: pointer to error object
>> + *
>> + * This function triggers an NMI, in a machine-specific way. The
>> + * intention is that this should typically trigger a guest kernel
>> + * dump or reboot, and might happen as a result of user request
>> + * from the monitor, watchdog timeouts, and similar events.
>> + * (For example on the x86 PC it triggers an NMI on all CPUs,
>> + * and on s390 it triggers the RESTART interrupt on the first CPU.)
>> + *
>> + * The NMI is triggered by looking for QOM objects which
>> + * implement the TYPE_NMI interface, and calling their nmi_handler
>> + * method. Usually it is the machine model class that implements
>> + * this interface.
>> + *
>> + * Not all machines implement NMI handling; this function
>> + * will return an error if used on a machine which does not
>> + * implement NMIs.
>> + *
>> + * On success, return %true.
>> + * On failure, store an error through @errp and return %false.
>> + */
>> +bool nmi_trigger(Error **errp);


>> -void nmi_monitor_handle(int cpu_index, Error **errp)
>> +bool nmi_trigger(Error **errp)
>>   {
>>       struct do_nmi_s ns = {
>> -        .cpu_index = cpu_index,
>>           .err = NULL,
>>           .handled = false
>>       };
>>
>>       if (nmi_children(object_get_root(), &ns)) {
>>           error_propagate(errp, ns.err);
>> +        return false;
>>       } else if (!ns.handled) {
>>           error_setg(errp, "machine does not provide NMIs");
>> +        return false;
>>       }
>> +    return true;
>>   }
>>
>>   static const TypeInfo nmi_info = {
>> diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
>> index 74818ff3cea..444af726d75 100644
>> --- a/hw/ipmi/ipmi.c
>> +++ b/hw/ipmi/ipmi.c
>> @@ -59,8 +59,7 @@ static int ipmi_do_hw_op(IPMIInterface *s, enum ipmi_op op, int checkonly)
>>           if (checkonly) {
>>               return 0;
>>           }
>> -        /* We don't care what CPU we use. */
>> -        nmi_monitor_handle(0, NULL);
>> +        nmi_trigger(NULL);
>>           return 0;
>>
>>       case IPMI_SHUTDOWN_VIA_ACPI_OVERTEMP:
>> diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
>> index 0842fe373ae..026768e9fb2 100644
>> --- a/hw/watchdog/watchdog.c
>> +++ b/hw/watchdog/watchdog.c
>> @@ -81,7 +81,7 @@ void watchdog_perform_action(void)
>>
>>       case WATCHDOG_ACTION_INJECT_NMI:
>>           qapi_event_send_watchdog(WATCHDOG_ACTION_INJECT_NMI);
>> -        nmi_monitor_handle(0, NULL);
>> +        nmi_trigger(NULL);
>>           break;
>>
>>       default:
>> diff --git a/system/cpus.c b/system/cpus.c
>> index 97e5a5edee2..5c0a192c01e 100644
>> --- a/system/cpus.c
>> +++ b/system/cpus.c
>> @@ -926,6 +926,6 @@ exit:
>>
>>   void qmp_inject_nmi(Error **errp)
>>   {
>> -    nmi_monitor_handle(monitor_get_cpu_index(monitor_cur()), errp);
>> +    nmi_trigger(errp);
>>   }
> 
> This officially drops the current CPU for HMP command too. Just
> acknowledge it in the commit message, and remove the "*cpu*"
> documentation in hmp-commands.hx?

Ack.

> 
> Also, can we use one word for "deliver", "trigger", "inject"? or is
> there any distinction I am missing?

Hmm indeed from the monitor perspective we "inject" a NMI.

Watchdog seems to also "inject" with WATCHDOG_ACTION_INJECT_NMI
(here my understanding is "raise", but whatever).

I suppose IPMI devices also "raise", but "inject" is acceptable.

$ git grep deliver_nmi
hw/i386/x86.c:159:            apic_deliver_nmi(cpu->apic_state);
hw/intc/apic_common.c:122:void apic_deliver_nmi(APICCommonState *s)
include/hw/i386/apic.h:10:void apic_deliver_nmi(APICCommonState *s);

The NMIClass handler then "route" or "deliver" it.


I'll rename as 'nmi_inject' I suppose, better to keep in pair with
the QMP command name.

