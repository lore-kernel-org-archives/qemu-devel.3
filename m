Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1809FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHPR6-0002Hi-QS; Mon, 27 Apr 2026 13:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wHPR5-0002HV-Ix
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 13:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wHPR3-0006rY-IF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 13:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777309670;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=emUxdOMyF/TPOIVyq/ATvbwmN72FwX/fWwzd2xRNeio=;
 b=CZhQmRVHlTiEipFkUf2WZcL1S3M5yS6nOvpt88SPFpAaWnoH18q08eFcp5Vq/ZcimIYDkK
 ZigNV3iGQmllGmy+9TBFjvSGl6wGuiTEKMBPIt5iLgN1YehcfOW+RakuvWtoE6mujOBmAS
 28fzsqAmciGJ0w1H1PcL/YoTK14vUyU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-PRWexWhOP2CYwWqZGlDMGA-1; Mon, 27 Apr 2026 13:07:49 -0400
X-MC-Unique: PRWexWhOP2CYwWqZGlDMGA-1
X-Mimecast-MFC-AGG-ID: PRWexWhOP2CYwWqZGlDMGA_1777309668
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-66e6f1b315dso8550093a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 10:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777309668; x=1777914468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emUxdOMyF/TPOIVyq/ATvbwmN72FwX/fWwzd2xRNeio=;
 b=M6NuUS4Od6eyPAmItRox4ZetYtoAH3UelaXKecuE1UGGt1e7cGd3aG+nT+2kpbM7mo
 dES6Oub1v4wVkZeLqyFwC4xnwncV63i7Fju4hv9QQEadgoFRGPRwBgQ0hD128hqtfb9B
 uzsmlcgAO7nQn1cGUHe9uyDZDdTONlgfLNhqk+IE+XV+TUjKORwwizn2ilLALg23OjQB
 nQibls9scKermlJUP4SZHsTTO/Hx12VYDzLzbYSMDtLPDGtvXBRrLFf5HajsxnS7jBC8
 CljKnE1XSATwiV7ilI8JOEgYCk+07fTnJUv816C80OciYHrU9R0lYWUFOj6PSAVfEjDJ
 lwlg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xBpwt+9hWfM45f40WQDHKLJhjc05NukDPqDRig2geqsPgZcnFWnI9r7dihPmsd0Ej/sgZMtOY5hpE@nongnu.org
X-Gm-Message-State: AOJu0YxqwDAvizYbggTUFSCBb+sE/f/DobuPbPoxvqhNOCaCPBcfdLHk
 C0zlPX2UIZKlkIANkHmaedsHYKJ7rXgsv79oPGtvGG9E2wrhVP74pgW06T0R1BBiQ+r2NppODD1
 KtGhuQoFQA96b5a1pgBPbpRlh8tZ18kzKOO9yhUMaGNP2C0vk101QTyNf
X-Gm-Gg: AeBDieu5Fe9lp6YBxSZJtVcholf3bct1IlSZdAYuAcYYHZ76SRGgUGWtrIZhERoYkRl
 QJt/WpL0CT+XGpKaaHcSR9gbmcJ7rHt8cOnmHDnQUjzDZB+ShcFfBJOkDNY1w0HEYLBMJO3XYtB
 iUtdn0Ypz1FhEdawe6Focj+K//WjFZQRzApxLPXlK9edYO7bLLpfuY1f8CIf0Uuu9DPBQ6fo95z
 0q1w+05iGeG81Mv0KDi9MVFS+UwvOGPHDl5gPuMjTpnGkZumSnqH+O9CZ6PeMgfidc66IkMo3Hz
 n6AbiL4SLj58X07mxgNGsKLHwof+my8bydMXDdZPGpLnOeZexSNdfr5/PqcReELW2/USHS1pt/1
 BEhzXCt26RODUxewNPzHQ7yA2Tc42HZrx+/3zgBpLHMY7rXAfbYIfHrhiULW8qjQuATK7UHu+nZ
 occA4b
X-Received: by 2002:a17:907:c302:b0:b96:e593:fd24 with SMTP id
 a640c23a62f3a-ba419658d6fmr2613176466b.15.1777309667826; 
 Mon, 27 Apr 2026 10:07:47 -0700 (PDT)
X-Received: by 2002:a17:907:c302:b0:b96:e593:fd24 with SMTP id
 a640c23a62f3a-ba419658d6fmr2613172566b.15.1777309667014; 
 Mon, 27 Apr 2026 10:07:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba523a90fa0sm1068965866b.31.2026.04.27.10.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 10:07:46 -0700 (PDT)
Message-ID: <d1c0c347-21e0-4877-9e3c-601b6a772578@redhat.com>
Date: Mon, 27 Apr 2026 19:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
References: <20260420140552.104369-1-eric.auger@redhat.com>
 <CAFEAcA_uLzLjqdr5LyLQ3EK2zy-ZoS8FfeDq9VcaobOozO3e2Q@mail.gmail.com>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA_uLzLjqdr5LyLQ3EK2zy-ZoS8FfeDq9VcaobOozO3e2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 4/27/26 11:44 AM, Peter Maydell wrote:
> On Mon, 20 Apr 2026 at 15:06, Eric Auger <eric.auger@redhat.com> wrote:
>> This series introduces an infrastructure to explicitly tolerate
>> some mismatches between cpu cpreg indexes/values on migration.
>>
>> We especially handle failures due to an attempt to migrate
>> more registers than exposed on the destination.
>>
>> Once the infrastructure is in place we can handle the following
>> known issues:
>> KVM:
>> - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
>>   from v6.13 onwards. Causes forward migration failure.
>> - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
>>   register from v6.16 onwards. Causes backward migration failure.
>> TCG:
>> - We can eventually remove AArch32 DBGDTRTX register which was
>>   erroneously defined.
>>
> Applied to target-arm.next, thanks (with an edit to the
> comment in patch 6).

Ack. Many thanks!

Eric
>
> -- PMM
>


