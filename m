Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAD2C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf0Pf-0003Z6-2b; Mon, 03 Feb 2025 12:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tf0Pd-0003Yw-44
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:39:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tf0Pb-0006a9-AS
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738604345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0sOeY9C/eWdQmQOVDE5YfWqVrx1bXKYnXEDyV+uaeno=;
 b=afxbVu7VI8YG5A/ElI1JdtG3qg4oq6zrEGChLt4K40YMAcLFOSTPbJMtgdLM5nzzrMBfwZ
 fk0D/uR32mDWcmYL+nEv+h+8mOEaelaclxMpVmBrms4LALJFF1UDvAtHePBmqxcVRAfzQD
 FRD+6Lnxa5YdGPsFXAF53A7jl/Faa5I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-sKEtKwtnNsuFwYX25EjAUw-1; Mon, 03 Feb 2025 12:39:04 -0500
X-MC-Unique: sKEtKwtnNsuFwYX25EjAUw-1
X-Mimecast-MFC-AGG-ID: sKEtKwtnNsuFwYX25EjAUw
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d3ff3c1b34so5332999a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 09:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604341; x=1739209141;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0sOeY9C/eWdQmQOVDE5YfWqVrx1bXKYnXEDyV+uaeno=;
 b=mh5oNjYATC3T8uAyiEGoAx+GqPYT/7xYmi8DsyP/KkhTOJ/hbtUTK8MGKWe5VTqOCz
 6dXLi8lnylNB0JP4U/aYJalk4RAh+GkDoycV5CwD5WbrK01T9joKmSvD+Hf5YhXRXaCz
 /IRL0+ZmZHMtrfdD1fFv7+ml4j3rOX2MsLn3DZNItyM6hOQ0BllO5vBtCgG2K6/0wtOt
 /z2xN+SRq/1qkvJECLd8pTJ7NHDu6v1Txf9MYXrjRxpgJtzT0RaGdyVvy8CFc3H9NsEe
 iwUA86h4yMNZXHqIOSr65c7RvLRrGTtT8yozqL8lfwa40A8AKcZEnyzY9au0yONIE0NI
 qI+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMcTNP16SiOi/mdqHArpVRnp8mrdD3pYVmzRRnKjXyKggyd9oFUGXva86qB29ea3DKfwAQ07M5Jwvn@nongnu.org
X-Gm-Message-State: AOJu0YzzPbnL25pvOvWe+wltpcnRkYfKWjlt1i0JD2fj17bfmP+Dmyla
 +vCOPEmUlF0TIue2XebzlR360eBY07h3iQg2xlZdlIgJsCpWgDXiE/F+BUZTuYAXnTzI3C7n4Cu
 j2WDnFUhQ2iEkhQ/5/3DN8shKNOp4Myy1IhcDwVbSSmIwyldRAKO5
X-Gm-Gg: ASbGnctIiuVpcsjbdgCqLFm03xnLFVP2Mig4hOuKsJMquvHKTO73y2OrvGQSBWcxjrw
 NTz4+vdQqbOw++XmGsbhY9E5zocmLg4oqSvGql1Yl7lA6kpzlBRvr7zsT87ddeZ0n10JUEQbG/x
 nqaV46gK7sb3SYp1xxyT6HTtT79J6KPqjvUOjd/AP5aedXAdAbnjifgz5oDDA/yhFSi36MfylQq
 vNlX0esYGXQTNiG2HxylNJhPp/I55nNXyHL6InxFNvGWQzFG8XbLRQ70DEN/gbIgI/Wwf5qWr7U
 XB0JH9fAtBwJfJOAptI79bzjqD+ZPEJkjSFp
X-Received: by 2002:a05:6402:51cf:b0:5da:7f7:b9b2 with SMTP id
 4fb4d7f45d1cf-5dc5efc68fcmr28072792a12.18.1738604341343; 
 Mon, 03 Feb 2025 09:39:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/FwYia9m8SMp2137ZqS89NKyLAPiyAlIgOqJ73WRuwMpZFBCZ/7/0p6Vi6KRS2pD3T6L9yg==
X-Received: by 2002:a05:6402:51cf:b0:5da:7f7:b9b2 with SMTP id
 4fb4d7f45d1cf-5dc5efc68fcmr28072773a12.18.1738604340974; 
 Mon, 03 Feb 2025 09:39:00 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc7240608dsm8305068a12.47.2025.02.03.09.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 09:39:00 -0800 (PST)
Message-ID: <62edb7e7-5f3f-4f7a-825d-59291117e032@redhat.com>
Date: Mon, 3 Feb 2025 18:38:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] accel/stubs: Expand stubs for TCG
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-8-richard.henderson@linaro.org>
 <cb6859a5-f4fc-4f7a-8e32-5aa2be3ee7be@redhat.com>
 <cfed8291-a3eb-464a-94a6-4d962c46d17a@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <cfed8291-a3eb-464a-94a6-4d962c46d17a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 03/02/2025 17.43, Richard Henderson wrote:
> On 2/3/25 02:22, Thomas Huth wrote:
>> On 03/02/2025 04.18, Richard Henderson wrote:
>>> Add tcg_allowed, qmp_x_query_jit, qmp_x_query_opcount.
>>> These are referenced when CONFIG_TCG is enabled globally,
>>> but not for a specific target.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   accel/stubs/tcg-stub.c | 24 ++++++++++++++++++++++++
>>>   1 file changed, 24 insertions(+)
>>>
>>> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
>>> index 7f4208fddf..9c2e2dc6e1 100644
>>> --- a/accel/stubs/tcg-stub.c
>>> +++ b/accel/stubs/tcg-stub.c
>>> @@ -13,6 +13,18 @@
>>>   #include "qemu/osdep.h"
>>>   #include "exec/tb-flush.h"
>>>   #include "exec/exec-all.h"
>>> +#include "qapi/error.h"
>>> +
>>> +/*
>>> + * This file *ought* to be built once and linked only when required.
>>> + * However, it is built per-target, which means qemu/osdep.h has already
>>> + * undef'ed CONFIG_TCG, which hides the auto-generated declaration.
>>
>> So why don't we only build this file once?
> 
> I think we'd have to create a static library for it.
> It didn't seem worth the effort at the time.
> I can re-investigate if you like.

I think something like this might work:

diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -1,6 +1,9 @@
  system_stubs_ss = ss.source_set()
-system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
  system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
+system_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
+
+specific_stubs_ss = ss.source_set()
+specific_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
+specific_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
+specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: specific_stubs_ss)

-specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)

?

  Thomas


