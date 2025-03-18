Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE392C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 07:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuRVh-0001vc-L6; Tue, 18 Mar 2025 03:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1tuRVd-0001v6-RF
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 03:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1tuRVX-0005qQ-U4
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 03:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742283421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0i8L8ErIHIcKjhHNLC1JQVz75Bq37QLmHg8dkfMBKIw=;
 b=GwiR5i5Ob4iZSJGNBn7+IXszUuKoJOAme6WpvkLdSelpLWQMD/0SC5WbiEpNzYL8MTEr3r
 psVIx/D9fDJiMRjieJVKgeN9Gequds4sjgXCzOKDi52fmKoUkZH6O/2fCmp3j2zsMs7t6x
 9O9kxdaSL7wGLXNCGJQZZHOBlvaMy6U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-hSiz53i0PfyZhiqZL6npYQ-1; Tue, 18 Mar 2025 03:35:34 -0400
X-MC-Unique: hSiz53i0PfyZhiqZL6npYQ-1
X-Mimecast-MFC-AGG-ID: hSiz53i0PfyZhiqZL6npYQ_1742283333
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-223a2770b75so99379025ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 00:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742283333; x=1742888133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0i8L8ErIHIcKjhHNLC1JQVz75Bq37QLmHg8dkfMBKIw=;
 b=TNp+gO7SFI2htmRyCrssTT0gioq75PIjMfhxiAUebSBQ+yHfp0uE1uhzMumqOJlYUf
 FjoK1UdXaCrszIeHJ6J4mCxjROG3PFDXOf1w1EgL/nvbefVHTMgaJRtCiSXF236373QP
 AJQ6fx/7DwhZvPIfT4xKAkMbRAPunmb3W9J5scfAlgMEVgueOpi2cL/1etr+UHFwq2PT
 GB+HycWsO9T8+R6A3OyTukUNRvgh/APhc0Q8agVbAMdXl3g7L0hDqj0n4Sc9w0xaCNAJ
 EN2Uid9TRbRuo3yRK7kraaAFllQgJ8tsmlBTjgvbPdfqwjeBP7I3deKLSFI0sg7TsWfV
 MWIQ==
X-Gm-Message-State: AOJu0Yxsy7Yr4/T4T4WCM4yNVpZt6eG96+zHeKVbUgXfvtf1mpBpWTRW
 uIcbeGQs8O6hIV146oTrKvWKHmJXb0EZu9PcQJ24AInpH0sAPLNf2JrdAcxYbl9fd+B9T3D092O
 /dzFIOlvNcH6gvE9gOPVcnhtQd+9c6EHotFgpP411q7L15dhDNrL0
X-Gm-Gg: ASbGncu7+ww3j8CnuwPtlnyDQeYZQTH78ruNX1jjR8y8JPgfqrAmDDElcjtVsms8yvn
 i5aWjR1D2/v3NhCvVXZhbKrbSt8BDd3F8fgVIuI1W3XFo56eH0v6MuchDlYcx5HnOCUjZqOl6Lz
 oPyj7t30pcraZMn2XQKpaB5qXFX0akS/cvLwjhDprkxJe9bOVssZG8jDyt4sUe0s350dh/4bbpu
 E68VBjl0k0i+6Q1foIx58bsHX4iZa3TjmXWMST5bAaW5HEobPeJ/sRzCINBuXEQ4klqI7EkEmGC
 /ocr2gAL0AgAtvsPLfv+
X-Received: by 2002:a05:6a00:b95:b0:736:3d7c:2368 with SMTP id
 d2e1a72fcca58-73722353269mr18334334b3a.7.1742283333016; 
 Tue, 18 Mar 2025 00:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMBK6qKus8FijqhGiMuo2MbhTRc59Wm2bEqfErgelC1XdI0dRfHYg9Umo5MnegCAbEJXhSgg==
X-Received: by 2002:a05:6a00:b95:b0:736:3d7c:2368 with SMTP id
 d2e1a72fcca58-73722353269mr18334273b3a.7.1742283332537; 
 Tue, 18 Mar 2025 00:35:32 -0700 (PDT)
Received: from [10.72.116.163] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371152958csm8856772b3a.26.2025.03.18.00.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 00:35:31 -0700 (PDT)
Message-ID: <2fe2a98d-f70f-4996-b04e-d81f66d5863f@redhat.com>
Date: Tue, 18 Mar 2025 15:35:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/5] accel/kvm: Support KVM PMU filter
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20250122090517.294083-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Zhao,

Thanks for your effort to respin the PMU Filter series.

I tried your series on ARM64, but it reports error at compile time, here 
is the error output:

qapi/kvm.json:59:Unexpected indentation.

While I compiled it on x86, everything is ok. Could you please check why 
it failed on ARM64?

By the mean time, I will review and test this series.

Thanks,
Shaoqin

On 1/22/25 5:05 PM, Zhao Liu wrote:
> Hi folks,
> 
> Sorry for the long wait, but RFC v2 is here at last.
> 
> Compared with v1 [1], v2 mianly makes `action` as a global parameter,
> and all events (and fixed counters) are based on a unified action.
> 
> Learned from the discussion with Shaoqin in v1, current pmu-filter QOM
> design could meet the requirements from the ARM KVM side.
> 
> 
> Background
> ==========
> 
> I picked up Shaoqing's previous work [2] on the KVM PMU filter for arm,
> and now is trying to support this feature for x86 with a JSON-compatible
> API.
> 
> While arm and x86 use different KVM ioctls to configure the PMU filter,
> considering they all have similar inputs (PMU event + action), it is
> still possible to abstract a generic, cross-architecture kvm-pmu-filter
> object and provide users with a sufficiently generic or near-consistent
> QAPI interface.
> 
> That's what I did in this series, a new kvm-pmu-filter object, with the
> API like:
> 
> -object '{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","events":[{"format":"raw","code":"0xc4"}]}'
> 
> For i386, this object is inserted into kvm accelerator and is extended
> to support fixed-counter and more formats ("x86-default" and
> "x86-masked-entry"):
> 
> -accel kvm,pmu-filter=f0 \
> -object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","x86-fixed-counter":{"bitmap":"0x0"},"events":[{"format":"x86-masked-entry","select":"0xc4","mask":"0xff","match":"0","exclude":true},{"format":"x86-masked-entry","select":"0xc5","mask":"0xff","match":"0","exclude":true}]}'
> 
> This object can still be added as the property to the arch CPU if it is
> desired as a per CPU feature (as Shaoqin did for arm before).
> 
> 
> Introduction
> ============
> 
> 
> Formats supported in kvm-pmu-filter
> -----------------------------------
> 
> This series supports 3 formats:
> 
> * raw format (general format).
> 
>    This format indicates the code that has been encoded to be able to
>    index the PMU events, and which can be delivered directly to the KVM
>    ioctl. For arm, this means the event code, and for i386, this means
>    the raw event with the layout like:
> 
>        select high bit | umask | select low bits
> 
> * x86-default format (i386 specific)
> 
>    x86 commonly uses select&umask to identify PMU events, and this format
>    is used to support the select&umask. Then QEMU will encode select and
>    umask into a raw format code.
> 
> * x86-masked-entry (i386 specific)
> 
>    This is a special format that x86's KVM_SET_PMU_EVENT_FILTER supports.
> 
> 
> Hexadecimal value string
> ------------------------
> 
> In practice, the values associated with PMU events (code for arm, select&
> umask for x86) are often expressed in hexadecimal. Further, from linux
> perf related information (tools/perf/pmu-events/arch/*/*/*.json), x86/
> arm64/riscv/nds32/powerpc all prefer the hexadecimal numbers and only
> s390 uses decimal value.
> 
> Therefore, it is necessary to support hexadecimal in order to honor PMU
> conventions.
> 
> However, unfortunately, standard JSON (RFC 8259) does not support
> hexadecimal numbers. So I can only consider using the numeric string in
> the QAPI and then parsing it to a number.
> 
> To achieve this, I defined two versions of PMU-related structures in
> kvm.json:
>   * a native version that accepts numeric values, which is used for
>     QEMU's internal code processing,
> 
>   * and a variant version that accepts numeric string, which is used to
>     receive user input.
> 
> kvm-pmu-filter object will take care of converting the string version
> of the event/counter information into the numeric version.
> 
> The related implementation can be found in patch 1.
> 
> 
> CPU property v.s. KVM property
> ------------------------------
> 
> In Shaoqin's previous implementation [2], KVM PMU filter is made as a
> arm CPU property. This is because arm uses a per CPU ioctl
> (KVM_SET_DEVICE_ATTR) to configure KVM PMU filter.
> 
> However, for x86, the dependent ioctl (KVM_SET_PMU_EVENT_FILTER) is per
> VM. In the meantime, considering that for hybrid architecture, maybe in
> the future there will be a new per vCPU ioctl, or there will be
> practices to support filter fixed counter by configuring CPUIDs.
> 
> Based on the above thoughts, for x86, it is not appropriate to make the
> current per-VM ioctl-based PMU filter a CPU property. Instead, I make it
> a kvm property and configure it via "-accel kvm,pmu-filter=obj_id".
> 
> So in summary, it is feasible to use the KVM PMU filter as either a CPU
> or a KVM property, depending on whether it is used as a CPU feature or a
> VM feature.
> 
> The kvm-pmu-filter object, as an abstraction, is general enough to
> support filter configurations for different scopes (per-CPU or per-VM).
> 
> [1]: https://lore.kernel.org/qemu-devel/20240710045117.3164577-1-zhao1.liu@intel.com/
> [2]: https://lore.kernel.org/qemu-devel/20240409024940.180107-1-shahuang@redhat.com/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (5):
>    qapi/qom: Introduce kvm-pmu-filter object
>    i386/kvm: Support basic KVM PMU filter
>    i386/kvm: Support event with select & umask format in KVM PMU filter
>    i386/kvm: Support event with masked entry format in KVM PMU filter
>    i386/kvm: Support fixed counter in KVM PMU filter
> 
>   MAINTAINERS              |   1 +
>   accel/kvm/kvm-pmu.c      | 386 +++++++++++++++++++++++++++++++++++++++
>   accel/kvm/meson.build    |   1 +
>   include/system/kvm-pmu.h |  44 +++++
>   include/system/kvm_int.h |   2 +
>   qapi/kvm.json            | 246 +++++++++++++++++++++++++
>   qapi/meson.build         |   1 +
>   qapi/qapi-schema.json    |   1 +
>   qapi/qom.json            |   3 +
>   target/i386/kvm/kvm.c    | 176 ++++++++++++++++++
>   10 files changed, 861 insertions(+)
>   create mode 100644 accel/kvm/kvm-pmu.c
>   create mode 100644 include/system/kvm-pmu.h
>   create mode 100644 qapi/kvm.json
> 

-- 
Shaoqin


