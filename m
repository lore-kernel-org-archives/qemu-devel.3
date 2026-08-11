Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E742C5CFD9
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjY4-00050q-Mj; Tue, 11 Aug 2026 06:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtjXz-000507-VV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:17:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtjXx-0003ci-4v
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:17:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67B6v9EC2252636
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TS9UX0Me5aWJDRPKzVaog3xIjd6Y36d4CbiDMA4XNbM=; b=IqHBgb4mY3HtAA9y
 55KAi6CNYGtbw1qgmh6RYyYmh4WNxuJahyvN2BJzzX/RigceYlybPXQW1awYpkcJ
 8v6roGngpOp8PS6YKD8JHxQcBftPhIhEUQvnOie3DkD6cQNwRtR2NWmbthjzmHpb
 NNg1QeRN1C3KFNb0NcFexTxCG3AdhnJ+9jn3FthXSpZ2QS0blwNvbzxvyZCmjSlP
 BTS5SNiZm8Ksz2N2wfz82LpoNwcrwc/z3kiDPRMUmrSbIJQL31og9lQ84MJYX6HJ
 VFl2XetuaLFxJoX+wUUhHQGxIDvu+hBoDkp/ac9oGgv+HIHxdZUgN2C0WYtuNN39
 rCB36w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk7bnff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:17:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bff5c7035so56664571cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786443441; x=1787048241; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TS9UX0Me5aWJDRPKzVaog3xIjd6Y36d4CbiDMA4XNbM=;
 b=UBkfzOheV/NdtS+h4gPIEBC8hwtfwon4un/EvdAgyo3v4S6Ppln6wCWkNWsryfL0O9
 cu6cgPIaItS7aYtGJLBWO1c0+bjBlzMqmTIND+3dD0cfYtXUXoHe5lQPHh+7c8N7CqyP
 b2+8tCABA+uHy3HvCq5DYDSOB/xxAkoyfl6zB60xb4kWNDhN25RQPljJDcazmG6z5+Y7
 boVNE2O6G69qC4Fe5Ut8R0lIYfZypWQP5u1BIQYWr73TRjNnSPmH2DzoM8D8USQmr9/T
 EqCJDJKJjlD7D7zAxbDePNUTaFyXhlfEi5YK569KdBc3zNLycoQpgnNj8vaJw7hv8/tg
 WFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786443441; x=1787048241;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TS9UX0Me5aWJDRPKzVaog3xIjd6Y36d4CbiDMA4XNbM=;
 b=kTk8Km4rUcqDy2OkquQcAKRvVK0fsJRSI2ApJkiOFvdbDuWhM461uYzd93rPLcsxki
 Zt+AQZUPt91lBFE57zH6z0zalYDO8twgH/1cBFqaXsavs9oviBgtyQadMxnRuTDHhRJz
 mZcKr+4rW5hPy3MRboTNBqi8oTXHnreiDoHSw9PuInscWZwr7p+3qYTBh3liQqjj63x5
 qRyiVWdcw1xQKrv/D/EMKF7NMpnT79sGcFAaTCYZcmh/sQb6EH3HJI2Y83m+R5cRgsjn
 9Hm6fPhDZBeZ4rDcvVcPNhn0p8B8HVbHXgxwlP7qU2zoG+pM3MP7iJbH55a1Wjv7kh0y
 WgWQ==
X-Gm-Message-State: AOJu0Yxkxll+DNITJSyYbmQLXrpTvrvgeGGcKzRI5jgqSrLLR8o72R8Z
 bdJdHuKdJ0J3X50uN9FeZVIQr9exa+4y61hYLBSAlDKwO98PG+cv23O2cylOtvmZLgun/PUKJZH
 yiMpbUkavha/bUYwoDE+liopZtVgSzYlhyHEHgTX/Jspl5iy1SOJugUmyWA==
X-Gm-Gg: AR+sD11zZ9XGh0UDBepccwXTDVFBmrn0XvYbhumBjScXcCiG2Ucm/IdAgizDDOf8hiu
 eU7kBQUgWLSLxNje9ZYom7QGB5a/n7IKPKNKxDPi0Xmc7nd7s8ewMXw7etOB/dF5kcL8gctHi1X
 uwieJg/US3xIfBn4/sBR61SnHmzxCeSYmaFWuId7REg0DWAWaWj8xKA/KRKjQ9CF1r7nHNBwetX
 c+hlfw0mGlNVzlrKd53DuEinOrrmVMhx3n/FtctNSWuFRO+bsPFkO8a9E7NNcidh32ErgYSzSD0
 hR7nGjnSBl77lWkKqUwiNUfBduVfwVbP9xpVl3wIUn3KLs7AgO1fG8MGWRWw3++MYoSa6Ya282P
 MrIkGgQTtHV6zdD8HwSJwQ1ISXe0+SPl11USE503J
X-Received: by 2002:a05:622a:5905:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-52d58495872mr16757371cf.1.1786443441273; 
 Tue, 11 Aug 2026 03:17:21 -0700 (PDT)
X-Received: by 2002:a05:622a:5905:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-52d58495872mr16756961cf.1.1786443440897; 
 Tue, 11 Aug 2026 03:17:20 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a5ac691sm3439559f8f.3.2026.08.11.03.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 03:17:20 -0700 (PDT)
Message-ID: <d0ad382b-9fe1-4ba2-a7f5-0bbb05daabe5@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 12:17:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/nmi: Remove @cpu_index argument from nmi_trigger()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Corey Minyard <minyard@acm.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240220150833.13674-1-philmd@linaro.org>
 <20240220150833.13674-5-philmd@linaro.org>
 <CAFEAcA-yALySmCJLbitCmYpiZKUXJNOavGJG9RYeo8fKqz7gcw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-yALySmCJLbitCmYpiZKUXJNOavGJG9RYeo8fKqz7gcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yus/gYYX c=1 sm=1 tr=0 ts=6a7af6b2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=TuDfYeBIR2I6H_eFPGAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0_EJe9Kuo3K1IJ9p4xYgnIsy2r8Runn4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA4NSBTYWx0ZWRfXwOPZ9tisW+Cj
 jz4wgg89Iv6t9Javgh/IFpZvZ5hKY2OCNghUb5YSB/RVWsTOXlMLkvLfqdBUBakdETGTnrrTvye
 f1xaaIqrleaDTg4DkYJQy3sHXgHwEV00xsK/MDC/iFZKa2oLidAyE24qsd3hQBcFtYk6zj9nAiW
 IEIrhDr2MBQhORn7wlLe9qZy8WGjo7yK7vN8szOsjxXxJyano5LDA6g9a6ZqxwJeNznsrvrWx1e
 lSKiez94W81jiUIgxOHYq6SgLUZQMVlKB+CC1bg+/PloCkBlCaNEEbiJJ1wwwxQZ9sArMYR29Of
 wudVtpCYVS77ErFeWrVXHU5nrRZQ0nSExKwCBaQfwhxpjGTO/xJdLL1VCegdp3Xp2Q0ug2v48eP
 48+Z6H1DJQHGXB/G05T1OO4vIwI19J4Fk0+svO8MQDrLo2AsS2e9DemcinInZncBYOxUwNyH/ZT
 pbo2uMH+yrZhIdViFgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA4NSBTYWx0ZWRfX0zIgtm488Rvw
 Q8UjHhrxN4m3lbGRVRH9NJ0yuz5607sCjQeudfBmORY+emJt+jUPWsUCUG1Q38/hFo4pRn2r2qD
 oEdwjsQjgkmYjs9QWoCdbPc5LXN4Rsw=
X-Proofpoint-GUID: 0_EJe9Kuo3K1IJ9p4xYgnIsy2r8Runn4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110085
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

On 20/3/24 14:34, Peter Maydell wrote:
> On Tue, 20 Feb 2024 at 15:09, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> nmi_monitor_handle() is not related to the monitor,
>> rename it as nmi_trigger().
> 
>> Return boolean value
>> indicating success / failure. The 'cpu_index' argument
>> is not used, remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/nmi.h       | 13 ++++++++++++-
>>   hw/core/nmi.c          |  9 ++++-----
>>   hw/ipmi/ipmi.c         |  3 +--
>>   hw/watchdog/watchdog.c |  2 +-
>>   system/cpus.c          |  2 +-
>>   5 files changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/hw/nmi.h b/include/hw/nmi.h
>> index c70db941c9..32b27067f2 100644
>> --- a/include/hw/nmi.h
>> +++ b/include/hw/nmi.h
>> @@ -49,6 +49,17 @@ struct NMIClass {
>>       bool (*nmi_handler)(NMIState *n, Error **errp);
>>   };
>>
>> -void nmi_monitor_handle(int cpu_index, Error **errp);
>> +/**
>> + * nmi_trigger: Trigger a NMI.
>> + *
>> + * @errp: pointer to error object
>> + *
>> + * Iterate over all objects implementing the TYPE_NMI interface
>> + * and deliver NMI to them.
> 
> I think I would document this something like;
> 
>   * nmi_trigger: Trigger an NMI, in a machine-specific way
>   *
>   * This function triggers an NMI, in a machine-specific way. The
>   * intention is that this should typically trigger a guest kernel
>   * dump or reboot, and might happen as a result of user request
>   * from the monitor, watchdog timeouts, and similar events.
>   * (For example on the x86 PC it triggers an NMI on all CPUs,
>   * and on s390 it triggers the RESTART interrupt on the first CPU.)
>   *
>   * The NMI is triggered by looking for QOM objects which
>   * implement the TYPE_NMI interface, and calling their nmi_handler
>   * method. Usually it is the machine model class that implements
>   * this interface.
>   *
>   * Not all machines implement NMI handling; this function
>   * will return an error if used on a machine which does not
>   * implement NMIs.

Thanks!

> 
> (In an ideal world we would also document per-board what
> the NMI handling is, in the user-facing board docs...)
> 
>> + *
>> + * On success, return %true.
>> + * On failure, store an error through @errp and return %false.
>> + */
>> +bool nmi_trigger(Error **errp);
> 
> Why return a bool here? None of the callsites looks at the
> return value.

Indeed, but again this is the style *recommended* by the Error API
since commit e3fe3988d7 ("error: Document Error API usage rules").

Callers providing a non-NULL errp should check the return value,
but the QMP handlers generated by gen_command_decl() like
qmp_inject_nmi() here don't return anything.

Markus, what would be your preference?


