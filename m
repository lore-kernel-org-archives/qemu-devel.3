Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38181C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 06:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfCdK-00058D-FV; Tue, 04 Feb 2025 01:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfCdE-00057Q-0M
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 01:42:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfCdB-0004OC-Vn
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 01:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738651316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q0gpAaSKZTRsawYuomviO+zJuYNQH6GRhBD+ePfv6wU=;
 b=OGVCeYeH/ADNBzm75FaDHf3AfaiAb8oSXU2WyGJSKjv+a0qmmcxm1cSD2VBfbRyy+ZVgyQ
 +Zys8nln8UPnFVcfclvnGND/GEjs1uzoLzIrUXXk5OnmrgRd37nhUDXPZcmUE4kw4ArKea
 veYDWenhxNxsF6JRtHEXiVd7eU+iIgk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-Ers7XXBzMZaQ1qeCiWV24w-1; Tue, 04 Feb 2025 01:41:54 -0500
X-MC-Unique: Ers7XXBzMZaQ1qeCiWV24w-1
X-Mimecast-MFC-AGG-ID: Ers7XXBzMZaQ1qeCiWV24w
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab2e529dc35so525693966b.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 22:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738651313; x=1739256113;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0gpAaSKZTRsawYuomviO+zJuYNQH6GRhBD+ePfv6wU=;
 b=R2sn7KeFHMIzHQ2QGIjrJ1rRU8TnQH8MRONy0x5CWu03KVIKa4MxP1w7ZCXk6U/JmE
 JKo4sPcOGWsX8V25fvvDSHkZbO5HLAts012ca8DItXr0x9jrtcQc5Aj24g6crDtwv31S
 +5eVlYSQxpBfHZDfaJqzJFMibmm0PkdzEnBCPs4JiYVcwspEbetEVcjVIgXY3jhL7WDj
 1MAdmmkzF5IsfGmAZgekqovF4avMxfTcNqBhc9fe0xARgunH/k3fD4fW+rX8AicL/0/l
 Z1B4m7p1s1HaWvheXhGhZnzQfVfF8+5do+auoXPlRKHrf8pOHVu5XfHCUlnEW6BFWmpi
 udfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ/fwsJPrdKLCum+2e8mgwPwBLqyVoiM53+C74TV+R8zOj8BFkPVTKsZR2ubYkVZKEpIGe9Tvros65@nongnu.org
X-Gm-Message-State: AOJu0Ywt+tFTdVT+MfpYVDXDgTejaUwSpJduQEgS6f5WpIf86KtsbucE
 If2zLtXHb7EP1WvIIxQNimfBeYZx1bBKOguwnHJJmf0iotxh7tdaFZ57jXOFzDmpbS41j+icBr+
 MLeVpxRRnQc57qUY2+v3xa1ec7V7IcXjQDcfQrQk5K9nhQL+sqxOR
X-Gm-Gg: ASbGnctjC7Va9kD+eAHer4c91boM0+cdTm9wqwnyuz2GCAibbVEn/1Hr2CCHhLgTxs/
 fixgeMo6NNLM1skeEgGex4rk8I+c4Sm+ueQeL92Gz7iu7eS8vOl2iDfbEJ5YLVOD4KKxg8SOt7D
 ewiVs0mErzZYD1l5XPBou+U47a5rLkEA+322urG8StOPES7D7F7BUfg/ZLEgrcPLysThDbPY7OQ
 Sl3EnNfruLT0e32SIjn8CXm2F1WhMNjbYvrAbt0wjQJjitGyKknm1ustPKrI2xh/EbHELTBKqHj
 CiNF0KBd49JUdGSYLaQzhpiyhJl5yy85l95K
X-Received: by 2002:a17:907:944c:b0:aa6:7220:f12f with SMTP id
 a640c23a62f3a-ab6cfce5fdfmr2494531466b.18.1738651313533; 
 Mon, 03 Feb 2025 22:41:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0aK3Y8ycNTvzQSptbMEJe2uh9F1UW/Fiax133gygpDRwC/Ec8uQhFbjvDt5P1bdj0uD4JTg==
X-Received: by 2002:a17:907:944c:b0:aa6:7220:f12f with SMTP id
 a640c23a62f3a-ab6cfce5fdfmr2494529066b.18.1738651313192; 
 Mon, 03 Feb 2025 22:41:53 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47d27aesm876232466b.60.2025.02.03.22.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 22:41:52 -0800 (PST)
Message-ID: <6a27e3db-9ae5-438d-9065-e74c5eedf86e@redhat.com>
Date: Tue, 4 Feb 2025 07:41:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] meson: Introduce CONFIG_TCG_TARGET
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-5-richard.henderson@linaro.org>
 <5c118b5d-a943-499c-a0ce-f19c74ab7d94@redhat.com>
 <3aa0e508-00c8-477f-b5a8-2cf20afb8efd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <3aa0e508-00c8-477f-b5a8-2cf20afb8efd@linaro.org>
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

On 03/02/2025 17.38, Richard Henderson wrote:
> On 2/3/25 02:08, Thomas Huth wrote:
>> On 03/02/2025 04.18, Richard Henderson wrote:
>>> Use CONFIG_TCG as a project-wide flag to indicate that TCG is enabled
>>> for *some* target.  Use CONFIG_TCG_TARGET to indicate that TCG is
>>> enabled for a specific target.
>>>
>>> Within a specific compilation unit, we can remap CONFIG_TCG based on
>>> CONFIG_TCG_TARGET.  This allows us to avoid changes to the bulk of
>>> the code base.
>>>
>>> Within meson.build, while CONFIG_TCG may be set in config_host_data,
>>> it may not be set within config_target.  Thus all references to
>>> CONFIG_TCG in source_set 'when:' need not be updated.
>>>
>>> For the moment, CONFIG_TCG and CONFIG_TCG_TARGET are identical.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/qemu/osdep.h |  7 +++++++
>>>   meson.build          | 11 +++++++----
>>>   2 files changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>>> index 112ebdff21..1f6f73a148 100644
>>> --- a/include/qemu/osdep.h
>>> +++ b/include/qemu/osdep.h
>>> @@ -34,9 +34,16 @@
>>>   #include "config-host.h"
>>>   #ifdef COMPILING_PER_TARGET
>>>   #include CONFIG_TARGET
>>> +# ifdef CONFIG_TCG_TARGET
>>> +#  undef CONFIG_TCG_TARGET
>>> +# else
>>> +#  undef CONFIG_TCG
>>> +# endif
>>>   #else
>>>   #include "exec/poison.h"
>>>   #endif
>>> +#pragma GCC poison CONFIG_TCG_TARGET
>>
>> Shouldn't that rather go before the "#endif" instead?
>>
>> Also, would it be possible to rather adjust scripts/make-config-poison.sh 
>> instead of poisoning this switch manually?
> 
> No, I want to unconditionally poison it so that no other uses are ever 
> introduced.

Ok, but then I think you should put a comment in front of it, explaining the 
rationale, since it is not so obvious (at least it was not obvious for me 
when I read the patch).

  Thanks,
    Thomas



