Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BF1C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scMOZ-0002yP-6B; Fri, 09 Aug 2024 05:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1scMOX-0002xu-HH
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1scMOV-0003mR-RZ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723197525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2du+44zhqbEY5/rAg1knZ+d6wjdhRASpwEG8HbK3Fs=;
 b=IBl8cXYRSvS6JYgob9l0mHx2GHH4mm4yU8hefjfomORb82CdX5IaNYkf8OT6FXHk+AK4fT
 JhT+Rx+VFhPaWpV86njQrc2INUosA+7KXx8eAvUB58no69e+105ySlP+6qUHT7znVqZ4kr
 c4Kt8FjfvYr+6aN4kagug8BDeKXFlOo=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-f1FNMdcIOvG8ACc-vxnh1Q-1; Fri, 09 Aug 2024 05:58:43 -0400
X-MC-Unique: f1FNMdcIOvG8ACc-vxnh1Q-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-26106c817baso2606209fac.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 02:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723197523; x=1723802323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f2du+44zhqbEY5/rAg1knZ+d6wjdhRASpwEG8HbK3Fs=;
 b=G3ecW3uZ64qqqCx+Wgpog7/KQFX6l/MRHgIsSresaKttCsm/XwdvGycLBfjW27/mgB
 brbOljJVURk2aSqE2z4CF8QA0Qb5ga6d8/NGEhfDIiRmRdlQR+tr0mBMjQ5+z8a1UWjK
 cHIH0NDpvsZwu8qusJkk/Ti+0nv0Rj/DICvJHsrefacpAjwtwFibciPV2RC98vRvLvKW
 WY1dWKPFITryksi958OlvFmQQ4v1oUw17CcPvGDyZzYZOS9ttMG0hBCOVj7fxl6fdt99
 kOeJ1Yjr7UxpUpGnnIHRpMaoWnlT63h3ZhEV3cmC4wYWU/7bJxdjUzbHogKAxR5H7qRn
 wyKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGqLCvGvw/Ye8Bqb/jBmT+52sr8sCMeD80vB9s4ZhT1OjdziKoLPpNNn2KLK7uXovs63QFyXvuv62Gyt0R8UJ0M5SYQgI=
X-Gm-Message-State: AOJu0YyvpPrpXNyZechtSyR8BA8aZdjwR8sN/HrnT6kaZglniNegmAGt
 9WFsbbu0rTfQoIUevP+SBvDTcj+jT2HMpmix4fX3EbrU2WXXNq8PKPpxUh/kI1q5rzrG8FCiVA4
 I+47wyrgDmtFONca7L54F0rzPFYUkVnBy1OaglQ2yulYn6ezGv5Ms
X-Received: by 2002:a05:6870:d146:b0:260:f054:7774 with SMTP id
 586e51a60fabf-26c62f08840mr1104823fac.13.1723197523169; 
 Fri, 09 Aug 2024 02:58:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGIxQrAhSfnbMQ4k28rqvRWyArJRIxHybPSxGnsv1+bTxsiEiUYr5hNDm1vubqh114KmpoLw==
X-Received: by 2002:a05:6870:d146:b0:260:f054:7774 with SMTP id
 586e51a60fabf-26c62f08840mr1104812fac.13.1723197522921; 
 Fri, 09 Aug 2024 02:58:42 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb2e569dsm2381264b3a.146.2024.08.09.02.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 02:58:42 -0700 (PDT)
Message-ID: <bc15d4c3-65f6-45cf-8069-71eabcb97fc5@redhat.com>
Date: Fri, 9 Aug 2024 19:58:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/arm/virt: Use kvm_arch_get_default_type()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, shan.gavin@gmail.com
References: <20240809035134.699830-1-gshan@redhat.com>
 <20240809035134.699830-4-gshan@redhat.com>
 <CAFEAcA_bfBNFBeJ-cMS+KACaC6Sw2VAAdg_gb5xn6-TE5C-7nA@mail.gmail.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAFEAcA_bfBNFBeJ-cMS+KACaC6Sw2VAAdg_gb5xn6-TE5C-7nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/9/24 6:59 PM, Peter Maydell wrote:
> On Fri, 9 Aug 2024 at 04:52, Gavin Shan <gshan@redhat.com> wrote:
>>
>> kvm_arch_get_default_type() and kvm_arm_get_max_vm_ipa_size() are
>> interchangeable since the type is equivalent to IPA size (bits)
>> with one exception that IPA size (bits) is 40 when the type is zero.
> 
> Well, sort of, but they're conceptually different.
> 
> kvm_arch_get_default_type() is the API for "give me the value
> I need to pass to kvm_ioctl(s, KVM_CREATE_VM, type)"; it's
> architecture independent and different architectures do
> different things. In the future Arm might need to do something
> other than "just pass in the IPA size".
> 
> kvm_arm_get_max_vm_ipa_size() does exactly what it says on the
> tin: it is an Arm specific function that returns the maximum
> supported IPA size.
> 
> I would prefer not to conflate the two.
> 

Agreed. Thanks for the explanation. Lets keep them separate and ignore
this series.

By the way, mc->kvm_type() can be used if one machine (platform) needs
to do more things than kvm_arch_get_default_type(), similar to what we're
doing on 'virt' machine currently.

Thanks,
Gavin





