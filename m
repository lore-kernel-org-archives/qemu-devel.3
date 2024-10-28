Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F10D13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 08:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5LGR-0005jd-7z; Mon, 28 Oct 2024 04:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5LGC-0005is-7T
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 04:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5LGA-0002S1-85
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 04:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730104676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RY1ABRLjLkvXF8gaN0ioWPJwQqdicQnkO7mCEKvqIhc=;
 b=HkUwYlXuq4ioGOLOIcbRuz3Xpqp0xUZQkwOe+T/ZLInAxjFTfWTlbhf2iM9L4YhGSABjvJ
 kAtXyXlksTta6FtjW5nyWrAZ6Av+OzOwdWs04I3fyqKQEanXNNRfTjbLhzgpwqZfhyE9zw
 wgVa+gC06O0JlGJ9GEcifVK2duFQ80g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-XmpYYJ8bPrm4EiaYScptjg-1; Mon, 28 Oct 2024 04:37:53 -0400
X-MC-Unique: XmpYYJ8bPrm4EiaYScptjg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539e13b8143so3119891e87.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 01:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730104672; x=1730709472;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RY1ABRLjLkvXF8gaN0ioWPJwQqdicQnkO7mCEKvqIhc=;
 b=EGSAMmHZGrHvtfdvD9xiVV1W2gKrSHye46WMidcXNMJZ5Uy2PRSIfew5UChbDl1tZe
 kRCqXkhmuE8+k4H0FhnYTDxLNr5iFrLmfULTGGhe17Z8YsfmxP7ED5dCXnL4tqpuoSSw
 DOl5FYxh+d+hY/455acYAZ5XbW9QJ008nrqdva/pnLdSAIxemG4tFSpHbYUzfiwEww3T
 RLYRtlxyfIQfSqZWblk+hNxM6PpfTZddjGv0fUSmJ9YN61XMTCMUqMkmZShvjD+BQrU6
 xGaD02dOLnnkf79YyCfun66/URc32393DJrXQzbehv1xaPOidjUHlLX1FfCNzXb71GoB
 H6cQ==
X-Gm-Message-State: AOJu0YwVC2M3GGqjbOM5odtD3Uaah1LZvuhNDZtceKBDzLNYyWGHMalz
 D2q5VfHsZ1RBpfZRflk4AqqVwk0N0GIxQPkJGtNz13OKfSfKOmDA1fTaYU64/COqAo90Xaf555P
 HkXVgBoAWpYmOt6XJ7kKBgwhw8/5rjz9qTBbLtPmOJpaPGmHxafwp
X-Received: by 2002:a05:6512:3b91:b0:52e:e3c3:643f with SMTP id
 2adb3069b0e04-53b348c6ffcmr2321004e87.2.1730104671842; 
 Mon, 28 Oct 2024 01:37:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOq4MiF8TCFj1BNE++QMkF/v8IAqU+DpzD0MN/ig4TzeNEfXQ5RUp0fq3mv4Sk4XWRjqb0pg==
X-Received: by 2002:a05:6512:3b91:b0:52e:e3c3:643f with SMTP id
 2adb3069b0e04-53b348c6ffcmr2320983e87.2.1730104671329; 
 Mon, 28 Oct 2024 01:37:51 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38058b1cc0asm8944578f8f.10.2024.10.28.01.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 01:37:50 -0700 (PDT)
Message-ID: <b4b7abae-669a-4a86-81d3-d1f677a82929@redhat.com>
Date: Mon, 28 Oct 2024 09:37:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] target/i386: Add support for perfmon-v2, RAS bits
 and EPYC-Turin CPU model
To: Babu Moger <babu.moger@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <cover.1729807947.git.babu.moger@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <cover.1729807947.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/25/24 00:18, Babu Moger wrote:
> 
> This series adds the support for following features in qemu.
> 1. RAS feature bits (SUCCOR, McaOverflowRecov)
> 2. perfmon-v2
> 3. Update EPYC-Genoa to support perfmon-v2 and RAS bits
> 4. Support for bits related to SRSO (sbpb, ibpb-brtype, srso-user-kernel-no)
> 5. Added support for feature bits CPUID_Fn80000021_EAX/CPUID_Fn80000021_EBX
>     to address CPUID enforcement requirement in Turin platforms.
> 6. Add support for EPYC-Turin.

Queued, thanks.  I looked at 
https://gitlab.com/qemu-project/qemu/-/issues/2571 and I think it's 
caused by the ignore_msrs=1 parameter on the KVM kernel module.

However, can you look into adding new CPUID_SVM_* bits?

Thanks,

Paolo

> Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
> Link: https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
> ---
> v3: Added SBPB, IBPB_BRTYPE, SRSO_USER_KERNEL_NO, ERAPS and RAPSIZE bits
>      to EPYC-Turin.
> 
> v2: Fixed couple of typos.
>      Added Reviewed-by tag from Zhao.
>      Rebased on top of 6d00c6f98256 ("Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging")
> 
> v2: https://lore.kernel.org/kvm/cover.1723068946.git.babu.moger@amd.com/
>    
> v1: https://lore.kernel.org/qemu-devel/cover.1718218999.git.babu.moger@amd.com/
> 
> Babu Moger (6):
>    target/i386: Fix minor typo in NO_NESTED_DATA_BP feature bit
>    target/i386: Add RAS feature bits on EPYC CPU models
>    target/i386: Enable perfmon-v2 and RAS feature bits on EPYC-Genoa
>    target/i386: Expose bits related to SRSO vulnerability
>    target/i386: Expose new feature bits in CPUID 8000_0021_EAX/EBX
>    target/i386: Add support for EPYC-Turin model
> 
> Sandipan Das (1):
>    target/i386: Add PerfMonV2 feature bit
> 
>   target/i386/cpu.c | 222 +++++++++++++++++++++++++++++++++++++++++++++-
>   target/i386/cpu.h |  27 +++++-
>   2 files changed, 242 insertions(+), 7 deletions(-)
> 


