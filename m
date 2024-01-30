Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADD0C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 06:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUhuC-0005iP-5Z; Tue, 30 Jan 2024 01:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rUhu8-0005iF-9M
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 01:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rUhu1-0001OG-Nr
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 01:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706597230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FO2jTTe9iw26yzYpnml8mvi2aCRHyt9dHaPIFvIehvk=;
 b=gtq1VBpGbEHP94zarB+saORjhZVvfJurZghrZ4Xj545mtFHDSgizuf3+WgYaToZzSZEjtG
 cBPmIBTRv9WJRz71tcadDZC4M33KiPt5nanzbtty4NfeZDLjiLS/ZbYnN+77rAaUVt9SaO
 6y8r9eGsXIcUiBFMNV+dA9lWUEIYpZ4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-krqD4IRHNqWxqLuZQVBdGg-1; Tue, 30 Jan 2024 01:47:08 -0500
X-MC-Unique: krqD4IRHNqWxqLuZQVBdGg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-55f31e773aaso373049a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 22:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706597227; x=1707202027;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FO2jTTe9iw26yzYpnml8mvi2aCRHyt9dHaPIFvIehvk=;
 b=eRdqi1o86fP0S8a5Cb6QHqtywlsGHdUNDouQOrrXL8FjpCc1WluMJmlX65TyzE3buX
 kVEam7r10hcnyRKLHIYfon61MfDKh5KwfyZ5+tn/lD8vMjYH/4QT1iRFiE2g1K783ZmY
 v6eOJd0oAN0bRHWGmmR4oLJV1lrEsNx9ia7Xtxga5RDOpW6YYC7bB3RLVXAonW94I+G7
 s1UEHZNRto57Vm5MCzIYXXqqt4f5tV6QGfOlN/5Kl0bDS2OHk9ncs9VOzoQzERxFzEcj
 lSwotM8iHFJP7tIcWGk8b1PFkepBnV2Sc4HDhjkTNCkvbmjmscBSWd64RkIw+foCnJ9X
 3Y0w==
X-Gm-Message-State: AOJu0YxneshvZDdSQkDSG9Hu+4XIQMewUMiKygIaFPad6kZntbeQS8WC
 Pr6KU7dMZIPjHM0OkIMfJ8uLjS8No8u8f9E43HfLt70aXUV3lZcVAaJ6ooVupcWTfMLEk9O8hzq
 wdcJDdxkH7OucX5ZERpWMNa5gxUwtWUWHwcinCDciCNapHLn+qEGD
X-Received: by 2002:a05:6402:268c:b0:55d:3007:96c0 with SMTP id
 w12-20020a056402268c00b0055d300796c0mr7393945edd.0.1706597227390; 
 Mon, 29 Jan 2024 22:47:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUZn8F77E8Krl4mn2WaTwILevMQwrc+cPJnDguG0CgkOXRIyFLYMKr41A7tNs6OwJqfG5Ahw==
X-Received: by 2002:a05:6402:268c:b0:55d:3007:96c0 with SMTP id
 w12-20020a056402268c00b0055d300796c0mr7393936edd.0.1706597227082; 
 Mon, 29 Jan 2024 22:47:07 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 cq16-20020a056402221000b0055f02661ae2sm1744274edb.78.2024.01.29.22.47.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 22:47:06 -0800 (PST)
Message-ID: <7313b8b5-7ebc-44e7-b4b0-e8c339483124@redhat.com>
Date: Tue, 30 Jan 2024 07:47:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hyperv: Include missing headers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Kagan <rvkagan@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-block@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240129170028.74012-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240129170028.74012-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 29/01/2024 18.00, Philippe Mathieu-Daudé wrote:
> Include missing headers in order to avoid when refactoring
> unrelated headers:
> 
>    hw/hyperv/hyperv.c:33:18: error: field ‘msg_page_mr’ has incomplete type
>      33 |     MemoryRegion msg_page_mr;
>         |                  ^~~~~~~~~~~
>    hw/hyperv/hyperv.c: In function ‘synic_update’:
>    hw/hyperv/hyperv.c:64:13: error: implicit declaration of function ‘memory_region_del_subregion’ [-Werror=implicit-function-declaration]
>      64 |             memory_region_del_subregion(get_system_memory(),
>         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    hw/hyperv/hyperv.c: In function ‘hyperv_hcall_signal_event’:
>    hw/hyperv/hyperv.c:683:17: error: implicit declaration of function ‘ldq_phys’; did you mean ‘ldub_phys’? [-Werror=implicit-function-declaration]
>     683 |         param = ldq_phys(&address_space_memory, addr);
>         |                 ^~~~~~~~
>         |                 ldub_phys
>    hw/hyperv/hyperv.c:683:17: error: nested extern declaration of ‘ldq_phys’ [-Werror=nested-externs]
>    hw/hyperv/hyperv.c: In function ‘hyperv_hcall_retreive_dbg_data’:
>    hw/hyperv/hyperv.c:792:24: error: ‘TARGET_PAGE_SIZE’ undeclared (first use in this function); did you mean ‘TARGET_PAGE_BITS’?
>     792 |     msg.u.recv.count = TARGET_PAGE_SIZE - sizeof(*debug_data_out);
>         |                        ^~~~~~~~~~~~~~~~
>         |                        TARGET_PAGE_BITS
>    hw/hyperv/hyperv.c: In function ‘hyperv_syndbg_send’:
>    hw/hyperv/hyperv.c:885:16: error: ‘HV_SYNDBG_STATUS_INVALID’ undeclared (first use in this function)
>     885 |         return HV_SYNDBG_STATUS_INVALID;
>         |                ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> BTW who maintains this code?
> 
> $ ./scripts/get_maintainer.pl -f hw/hyperv/hyperv.c
> get_maintainer.pl: No maintainers found, printing recent contributors.
> get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
> ---
>   hw/hyperv/hyperv.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 57b402b956..6c4a18dd0e 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -12,6 +12,7 @@
>   #include "qemu/module.h"
>   #include "qapi/error.h"
>   #include "exec/address-spaces.h"
> +#include "exec/memory.h"
>   #include "sysemu/kvm.h"
>   #include "qemu/bitops.h"
>   #include "qemu/error-report.h"
> @@ -21,6 +22,9 @@
>   #include "qemu/rcu_queue.h"
>   #include "hw/hyperv/hyperv.h"
>   #include "qom/object.h"
> +#include "target/i386/kvm/hyperv-proto.h"
> +#include "target/i386/cpu.h"
> +#include "exec/cpu-all.h"
>   
>   struct SynICState {
>       DeviceState parent_obj;

Reviewed-by: Thomas Huth <thuth@redhat.com>


