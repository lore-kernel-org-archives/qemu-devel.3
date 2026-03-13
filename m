Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E3F107BCCB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Eo-0000Ux-24; Fri, 13 Mar 2026 12:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Eg-0000Rf-Tw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:19:41 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Ef-0006bb-B6
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:19:38 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35a03da7bd6so1501571a91.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773418776; x=1774023576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V0imgWP62OQ54qaV45iQePrfF43/q71sq8lKGVv4DA8=;
 b=t4prLzcJu1bpqPINPE3Qcn4u6w++LDwhmfAULZFCQAj/3VeYRs/69NqgW7CRSfURka
 6vOddOGlVz5V4Rq+opTjprG8ZjLuS6DhIshqR/fFt7B8vKZBgPOOezV8hW79N6Mhg1u1
 A8cSyRNOGaJtzhL6l4duTnDkFlh4yaLfdButug25jU3VH7zlZT2LMHr7SSqLEbDGjQtk
 LTbyhhUt0+2fMecKk7I40ZkgKduPyeSylWHG9WAevyVxQ6blOwCgnbJ/6+NKsSVh6EVU
 tcB07Cf+cqpmK5XqyktcFV6wpN4TkdPHUJVPoppzLeVEQQcM2O2t1aodfCxKayKal0gY
 WG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773418776; x=1774023576;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V0imgWP62OQ54qaV45iQePrfF43/q71sq8lKGVv4DA8=;
 b=Hvjgg1l8vNeGURa3TYVwCUGd3roXqJafet3yqVL+pEJxETN7YLlLkBsz152G/4rHbO
 w2JL+a28px+zW0/D4/1GG68tO8qlF0H2S5tDbUpOwPbGq8MQqb70WW5yT5qOzyzKm2lL
 tRt7ABj8eGzjpx9COfqguFmXZL5YdEO5nhd5UfypJD0DOZtrnoWudis9K00E8jUlLLb7
 GTyh0tYxfvyqigqoo3udmf6DYZ9tF3uWmZYJPJ8G1iFcPTnyuck8JrThQQ8iYq1RTi9r
 ap8e8ZYZWC8ddPJlUhtp2gn5En42iZvVAUAS5yElESi+2iHLnLkW8kptsttTuJAPTRXT
 dUnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd91XBiElz3PeohXr3qx+Hf+15pAN1IVKoM6vI4w7v7eZPw2fw24wyAZyBqMz2mAjvDPhNSOe1SXNp@nongnu.org
X-Gm-Message-State: AOJu0YwDtTAkf1o511yy1bpd7COHqHHfz1+/UGo5krvh0KarSMM2YekO
 SukNdWy5AaS1rWcC6esrNnXdMylYRw4TN1fzowPp9j3E6e6zvJpUd12qFxFMVM5vjxY=
X-Gm-Gg: ATEYQzw86TDxYLfLCN836buwTwn/5QAT0kPMk+NUk5aHr3E0Z9uKgKGZ9qpZFEGjrK5
 ltHblE0+BmCyIpEo4Mt654mSMGIxntvIqloYh/LA+awIF3PO/CpIkJTvF3jMuRZ3F73ydE48Kn5
 JDGsGhctyfJZ3YZQrhA5FwnCsCMnNpGNhbGr2EAN4FNxlwf48obnaAdB7HOFW2AD1hGZ9vSCSyN
 +XbnyFcxII7Me1IX1noUcbZaaOCF3y74LJ72KC8k8RskH/k4J1PEtVL37dz9R+d1uykfmfuvhQF
 rb083vNCrxlqfm6Cf2stEkO2P5+Ez74g5wIs2e/P0xxN/gUaNQTUoEaUPlvPF6/71KtU6Wb5Jxu
 JaJqS/UAXghTsDeIMWOxxmsPLsp734DZSe41yzs1tFOwJccjOPaQ8+Vk+CORQWga9CfF+bAGil8
 vTldHJqm8FzdjTBATfsNsxQCAd7jOZdmlCvvPe3SUPyCPvM5iNfDumOIcc0ugkBzoGRGx5
X-Received: by 2002:a17:90a:e7d0:b0:359:b7a5:21a8 with SMTP id
 98e67ed59e1d1-35a21e1b7a7mr3845727a91.5.1773418775564; 
 Fri, 13 Mar 2026 09:19:35 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02fca40bsm12065746a91.10.2026.03.13.09.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:19:35 -0700 (PDT)
Message-ID: <199e5462-12a3-4bb0-ba37-f977e18c3ed1@linaro.org>
Date: Fri, 13 Mar 2026 09:19:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
 hw/vfio/kvm-spapr.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-8-pierrick.bouvier@linaro.org>
 <8904904b-5e91-45dc-aae9-bdb0d2f21349@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <8904904b-5e91-45dc-aae9-bdb0d2f21349@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 3/12/26 8:29 PM, Philippe Mathieu-Daudé wrote:
> On 12/3/26 23:44, Pierrick Bouvier wrote:
>> Since this function needs kvm specific types, we need to extract in
>> another file and link it only for KVM builds.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    hw/vfio/kvm-spapr.h | 12 ++++++++++++
>>    hw/vfio/kvm-spapr.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>>    hw/vfio/kvm-stubs.c |  8 ++++++++
>>    hw/vfio/spapr.c     | 30 ++++-------------------------
>>    hw/vfio/meson.build |  1 +
>>    5 files changed, 72 insertions(+), 26 deletions(-)
>>    create mode 100644 hw/vfio/kvm-spapr.h
>>    create mode 100644 hw/vfio/kvm-spapr.c
>>
>> diff --git a/hw/vfio/kvm-spapr.h b/hw/vfio/kvm-spapr.h
>> new file mode 100644
>> index 00000000000..1a7697a07a8
>> --- /dev/null
>> +++ b/hw/vfio/kvm-spapr.h
>> @@ -0,0 +1,12 @@
>> +/*
>> + * Vfio spapr kvm specific functions
> 
>        "VFIO sPAPR KVM specific functions"
>

I'll update it, thanks.

>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
> 


