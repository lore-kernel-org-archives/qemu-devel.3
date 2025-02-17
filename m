Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A072AC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 03:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjs98-00009W-Q7; Sun, 16 Feb 2025 22:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tjs97-000061-K2
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 22:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tjs95-0006JB-HT
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 22:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739764209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ygw7WIDZJrA8UQDfE5udyUyyNV78KT9W3tjyhghz9k=;
 b=bkxiNbJIjuS7q5psFD84Jui6lTfljPRn5GOT0qMBeV2bQHqW77tiXWeSl3mwfNvEAeFe2B
 TUntutA3RmnjkmLLh3n8wlnB+JwIw62FCiwGIsQmQjRC7nsNbjm093RlfBnA2wWy7sh9dX
 jHKD3ayM3fJVwMYZqkV9CxDNQSQ9fD8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-ZHsUOztdN6mceqe_n3eC-g-1; Sun, 16 Feb 2025 22:50:02 -0500
X-MC-Unique: ZHsUOztdN6mceqe_n3eC-g-1
X-Mimecast-MFC-AGG-ID: ZHsUOztdN6mceqe_n3eC-g_1739764201
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-220caea15ccso139319145ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 19:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739764201; x=1740369001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ygw7WIDZJrA8UQDfE5udyUyyNV78KT9W3tjyhghz9k=;
 b=st3VokYMYP/8fxAmnL8iQjpeaSYSvBLw6f+MpzQBngNC1YyYv9MPxzew2WzUCa8j+A
 qPgTxMeSH/fJMfTwCJRg6yiK6AaZCHipbyK0bkcxlal9s2PJSOmAobibdbEQ+l9XkTT6
 wQtuuNG/PYlgwUqOSs3odq4V3Qg17hKYKTjczoSCU3qRjf4p3ZRT+z0JKVYB6Hy2ADKq
 +6QC1KQ2GEHYHbMDKX6praGiDh8grTfxprTzxGR/h24O0r6h17wJOvjW32ik7ce5xXo1
 Rbtr2P3MEza2e6u5um8Pwy5+rqYmqPFPgQ0gjBvRaeSs4EqWpHoOEDyTejnTLECJ2dVK
 b4tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZUpiDnGuBz6HjHYKpFBuL4mVdShW0PxIds9QrRAeSSAMgKycBRp8tghhcyGS0sqqvHkb3ib5qapfm@nongnu.org
X-Gm-Message-State: AOJu0YxinFY+VGeVGz/hV/M2g4HhI2W9rC9uAmw4eFlUevO3xT2yM59s
 vmQhr0H00uqhVul4DZ1xsv+mjX1wQiLQsOtMjId3nvfaHA9WvWY6r0ho96BhoceVCpNvTSAR0AN
 rA1TksWAS3xC29dAchLRppvJQHQyBI2CKFF+QXII9EFaMnlSb8il8
X-Gm-Gg: ASbGncvraSoR5OOVFtg2h7Jqa3hMSFrRbJXF/kYJwWpNpLZ8wdlfbtFa8pSZDGKJ+TJ
 BvqKuds8dE8eWyhOeBGKUNclBtc6PokGxSg61ayfsFnLA75GFXJXjalN/AmQaTQvuIBNV5sHEo2
 F4oyUg0GD6mUbsjsWjxVoIN7hSVuqEvrhEhfuuKaBLt7MYYCogMkKpB+clsERdjdhe/pRn/4eMb
 8miIVrf+vl4/M9+xrp1D1ytTUeY+GvdxUJonvtSmStFusg6jcaK07zLcXmYpjkBd0kciDqL2zS2
 9j37GA==
X-Received: by 2002:a17:903:27ce:b0:21f:89e5:2712 with SMTP id
 d9443c01a7336-221040ab970mr94464685ad.39.1739764200987; 
 Sun, 16 Feb 2025 19:50:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpxHI7t7LL7t2HeOdXmSr41ECCGNcT+mR/LFdCGt/f81Gjo+Yb1Hz2ndNb76P4xAE/R490rw==
X-Received: by 2002:a17:903:27ce:b0:21f:89e5:2712 with SMTP id
 d9443c01a7336-221040ab970mr94464555ad.39.1739764200686; 
 Sun, 16 Feb 2025 19:50:00 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.64])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57d542f1sm6505740a12.2.2025.02.16.19.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 19:50:00 -0800 (PST)
Message-ID: <e0250e0d-2af8-4b2a-adfb-3f5a01e0f03c@redhat.com>
Date: Mon, 17 Feb 2025 13:49:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/arm: Improvement on memory error handling
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, gengdongjiu1@gmail.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, shan.gavin@gmail.com
References: <20250214041635.608012-1-gshan@redhat.com>
 <20250214101158.00004f69@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250214101158.00004f69@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/14/25 8:12 PM, Jonathan Cameron wrote:
> On Fri, 14 Feb 2025 14:16:31 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> Currently, there is only one CPER buffer (entry), meaning only one
>> memory error can be reported. In extreme case, multiple memory errors
>> can be raised on different vCPUs. For example, a singile memory error
>> on a 64KB page of the host can results in 16 memory errors to 4KB
>> pages of the guest. Unfortunately, the virtual machine is simply aborted
>> by multiple concurrent memory errors, as the following call trace shows.
>> A SEA exception is injected to the guest so that the CPER buffer can
>> be claimed if the error is successfully pushed by acpi_ghes_memory_errors(),
>> Otherwise, abort() is triggered to crash the virtual machine.
>>
>>    kvm_vcpu_thread_fn
>>      kvm_cpu_exec
>>        kvm_arch_on_sigbus_vcpu
>>          kvm_cpu_synchronize_state
>>          acpi_ghes_memory_errors         (a)
>>          kvm_inject_arm_sea | abort
>>
>> It's arguably to crash the virtual machine in this case. The better
>> behaviour would be to retry on pushing the memory errors, to keep the
>> virtual machine alive so that the administrator has chance to chime
>> in, for example to dump the important data with luck. This series
>> adds one more parameter to acpi_ghes_memory_errors() so that it will
>> be tried to push the memory error until it succeeds.
> Hi Gavin,
> 
> If the ultimate aim is to support multiple memory errors why not
> just do that?  Been a while since I look at how that works, but
> the spec definitely allows it.  I think by just queuing up the errors
> and updating the Error Status Address as each one is handled.
> I think that's what GHESv2 ack is all about as it prevents the
> RAS firmware updating the error record until it is acknowledged
> at which point the RAS firmware can report the next one.
> 
> Or... Given the usecase above of a 64KiB host page and 4KiB guest
> can we inject a single error record with multiple CPER entries and
> just handle it all in one go?
> 
> Set the Error record header -> section count to 16 and provide
> 16 Memory Error Sections or equivalent.
> 
> Doesn't help with multiple errors in unrelated memory addresses but
> maybe removes one problem case.
> 
> I've not checked all the information makes it to the right places
> however or that we don't end up with a deadlock when multiple vCPU
> involved.
> 
> If doing the more significant surgery this would involve, I'd
> love to see Mauro's series land first as it cleans up a lot of
> how HEST is handled etc.
> 

Jonathan, thanks for review and comments. It's just an example that a problematic
64k host page can affect 16 4k guest pages. The errors aren't raised at the same
time because the SIGBUS signal is received by QEMU when the corresponding 4k guest
page is accessed. If all those errors are queued up and delivered at once, the
problem is when all those queued errors are delivered?

Besides, the problematic 64k host page affecting 16 4k guest page is an example.
when host/guest has same page size (e.g. 4KB), it's possible that two problematic
pages are detected by SIGBUS signals. It's also possible that one CPER error
is being delivered, but not acknowledged. A followup CPER error is raised to be
delivered. In this case, abort() is triggered either. So the problem isn't specific
64k host page size + 4k guest page size.

Thanks,
Gavin


