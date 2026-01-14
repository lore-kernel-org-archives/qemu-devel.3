Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4B2D37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg11d-00050U-MJ; Wed, 14 Jan 2026 08:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vg11N-0004we-N1
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:34:50 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vg11K-0001Gy-BK
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:34:49 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260114133437epoutp04e18e0279793ec4d6f6ddee7fa4c86717~KnFGEHPSR2088520885epoutp048
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 13:34:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260114133437epoutp04e18e0279793ec4d6f6ddee7fa4c86717~KnFGEHPSR2088520885epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1768397677;
 bh=etVFenIhIxSsHEzltnL7HAxnnWzjPlQugjOs0XYHjeA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=E7jdGEtsO7W6IEM8npsZEZnEz3PzhM1RSvkmtRhFUoqCk4QckBTybaVoSQkDvf+Hv
 dLUTE46HH2Ley+C++u9Q9bh4zfyaV29tT62ifCXaKo2Jf9G8UR53XqRGUS/W01da/q
 MZpotWDbWI0pwNXjJ26JSQKC629qg98OLmZcCRME=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20260114133437epcas5p18526dbc9e3bb973369e1d82a5ab8025c~KnFFvaxle1496614966epcas5p15;
 Wed, 14 Jan 2026 13:34:37 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.90]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4drnCc29GPz6B9m6; Wed, 14 Jan
 2026 13:34:36 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20260114133434epcas5p377118eb1a39e8fd591ec44b0bd9e56e0~KnFDam6c80773107731epcas5p3Q;
 Wed, 14 Jan 2026 13:34:34 +0000 (GMT)
Received: from test-System-Product-Name (unknown [107.99.41.85]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260114133433epsmtip21d66f9174c90a385f2b04635fd3daf4a~KnFCLzECD0906409064epsmtip2u;
 Wed, 14 Jan 2026 13:34:33 +0000 (GMT)
Date: Wed, 14 Jan 2026 19:01:51 +0530
From: Ashish Anand <ashish.a6@samsung.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, saurabh@samsung.com,
 y.kaushal@samsung.com, vishwa.mg@samsung.com, ashish.anand202@gmail.com
Subject: Re: [PATCH] target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M
Message-ID: <yytwea73bmlkyi32l47wdkbqe4d2we5qe6edevity5uymntu22@vzzwz7cpgwfv>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Ok=yT_t1kTLSnw8fiG1i5fZXZfKB-Bb=Lw5MeAjA7hQ@mail.gmail.com>
X-CMS-MailID: 20260114133434epcas5p377118eb1a39e8fd591ec44b0bd9e56e0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----Rvty6Ov.E7w8fqTiecbGSIlWaDZOz3Joz9WFZpHBwcJNCC2Q=_f8a40_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251223120242epcas5p44b454df5afd0d517a4562a545ad11218
References: <CGME20251223120242epcas5p44b454df5afd0d517a4562a545ad11218@epcas5p4.samsung.com>
 <20251223120012.541777-1-ashish.a6@samsung.com>
 <CAFEAcA9Ok=yT_t1kTLSnw8fiG1i5fZXZfKB-Bb=Lw5MeAjA7hQ@mail.gmail.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=ashish.a6@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

------Rvty6Ov.E7w8fqTiecbGSIlWaDZOz3Joz9WFZpHBwcJNCC2Q=_f8a40_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 13/01/26 03:21PM, Peter Maydell wrote:
>On Tue, 23 Dec 2025 at 12:02, Ashish Anand <ashish.a6@samsung.com> wrote:
>>
>> From: "ashish.a6" <ashish.a6@samsung.com>
>>
>>     Currently, QEMU implements the 'Wait For Event' (WFE) instruction as a
>>     a simple yield. This causes high host CPU usage because Guest
>>     RTOS idle loops effectively become busy-wait loops.
>>
>>     To improve efficiency, this patch transitions WFE to use the architectural
>>     'Halt' state (EXCP_HLT) for M-profile CPUs. This allows the host thread
>>     to sleep when the guest is idle.
>
>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 39f2b2e54d..44433a444c 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -639,6 +639,7 @@ typedef struct CPUArchState {
>>          uint32_t nsacr;
>>          uint32_t ltpsize;
>>          uint32_t vpr;
>> +        uint32_t event_register;
>>      } v7m;
>
>One more small thing that I thought of -- although we're only
>implementing WFE support for M-profile here, the concept of the
>event register is the same for A-profile. So we should put the
>field in the top level of the CPU state struct, not inside the v7m
>sub-struct. That way it's available for us to use and share
>if and when we ever do it for A-profile.
>
>> +static bool m_event_needed(void *opaque)
>> +{
>> +    ARMCPU *cpu = opaque;
>> +    /* Only save the state if the event register is set (non-zero) */
>> +    return cpu->env.v7m.event_register != 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_m_event = {
>> +    .name = "cpu/m/event",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = m_event_needed,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT32(env.v7m.event_register, ARMCPU),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>
>...and so similarly the migration handling should not have
>anything M-profile specific to it.
>
>thanks
>-- PMM

Hi Peter,

Thanks for the detailed review. I acknowledge the comments and will incorporate the suggested changes and send a v2 shortly.


Regards,
Ashish

>

------Rvty6Ov.E7w8fqTiecbGSIlWaDZOz3Joz9WFZpHBwcJNCC2Q=_f8a40_
Content-Type: text/plain; charset="utf-8"


------Rvty6Ov.E7w8fqTiecbGSIlWaDZOz3Joz9WFZpHBwcJNCC2Q=_f8a40_--

