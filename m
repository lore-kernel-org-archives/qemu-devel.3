Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D05C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 09:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZoCk-0004AT-K4; Fri, 02 Aug 2024 05:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1sZoCj-00048m-GB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 05:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1sZoCh-0003iB-KZ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 05:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722589441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lrdj9yuORukWqUYUIt3IAzaQyJKJfeEL5MPERDg4KCU=;
 b=BCTCVLL9aPrqE2u+MOjG/bgQtfw39BInImEZAFtm1IvtJ2hr9UbtEcIBndl+GzLiPavjh1
 dRlcshE1qO9WbICz44hHNTigEFvBPbT9/JyunJx92de4MgekHj4VPOo/OWl/zsyufKANy3
 BOGsSQmv1Bf7GOUWnFXdws92hPpJGdU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-PH480xLrO-WohTgjbwXvrQ-1; Fri, 02 Aug 2024 05:01:56 -0400
X-MC-Unique: PH480xLrO-WohTgjbwXvrQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1fd0000b1a8so4784545ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 02:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722589315; x=1723194115;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lrdj9yuORukWqUYUIt3IAzaQyJKJfeEL5MPERDg4KCU=;
 b=vBNHOAgmsv9rN7FodUKXFkTWZWuz4c6hoz25jhaqY9Z6wALwORpCi6wFpAEJBms3HK
 Uk7O7nqtTcPsnwc89Lo1ZmKyHC8kR8HU8QGj2Mki7N6AYXhsazEOHLdnVlijplc/XI45
 7ysNHi8KX5uHHpmqsVpx+ieKcmJpIMbjgBG6jaLy/0OZ3hzFahKV0IWIF3Lisad0KOrv
 /a0hTsk+3GXB3sb1cTcc+FTlf6wPa0S3NS0yF1wDtVbNTp9HiptJo/sOH+YzwC3KnVnr
 kWSCbFU2MlJhWHEHp8dTC27hL6feh9/ykp3EG8DpPgE4XcbFm9TE8Xc3qVzCDfbEqjE0
 GkGQ==
X-Gm-Message-State: AOJu0Yyr52xdrvmrP11p0tyBg/6tqvtk4CWJmHpKyKiqdeqWGj1CGFNI
 ICnGwN+pMhgIBc4hypo8ibZZfcUcCtKuPDPSxMxBAkdAgvlJVkp5exYMzt821KJzsh+A+QURHba
 b/rPIwcAQmzLDKi++h0BQb0hFbESk2bIrg8AMN4BPYIFTBvbH+lbW
X-Received: by 2002:a17:902:e811:b0:1fc:7180:f4af with SMTP id
 d9443c01a7336-1ff572930a2mr22180965ad.1.1722589314879; 
 Fri, 02 Aug 2024 02:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG83ug/+5OWUKSIB0OxELPn/6j7oB17exTQCTqxhWN+mNRltC1UBqKTPNHP3ntOVXe0x9CatQ==
X-Received: by 2002:a17:902:e811:b0:1fc:7180:f4af with SMTP id
 d9443c01a7336-1ff572930a2mr22180715ad.1.1722589314400; 
 Fri, 02 Aug 2024 02:01:54 -0700 (PDT)
Received: from [10.72.116.40] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905ff1asm12222005ad.180.2024.08.02.02.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 02:01:53 -0700 (PDT)
Message-ID: <b10545d1-8e81-44f0-8e13-eee393ea4d1b@redhat.com>
Date: Fri, 2 Aug 2024 17:01:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] accel/kvm: Support KVM PMU filter
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
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yuan Yao <yuan.yao@intel.com>, Xiong Zhang <xiong.y.zhang@intel.com>,
 Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>
References: <20240710045117.3164577-1-zhao1.liu@intel.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20240710045117.3164577-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/10/24 12:51, Zhao Liu wrote:
> Hi QEMU maintainers, arm and PMU folks,
> 
> I picked up Shaoqing's previous work [1] on the KVM PMU filter for arm,
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
> -object '{"qom-type":"kvm-pmu-filter","id":"f0","events":[{"action":"allow","format":"raw","code":"0xc4"}]}'
> 
> For i386, this object is inserted into kvm accelerator and is extended
> to support fixed-counter and more formats ("x86-default" and
> "x86-masked-entry"):
> 
> -accel kvm,pmu-filter=f0 \
> -object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","x86-fixed-counter":{"action":"allow","bitmap":"0x0"},"events":[{"action":"allow","format":"x86-masked-entry","select":"0xc4","mask":"0xff","match":"0","exclude":true},{"action":"allow","format":"x86-masked-entry","select":"0xc5","mask":"0xff","match":"0","exclude":true}]}'

What if I want to create the PMU Filter on ARM to deny the event range 
[0x5,0x10], and allow deny event 0x13, how should I write the json?

Thanks,
Shaoqin

> 
> This object can still be added as the property to the arch CPU if it is
> desired as a per CPU feature (as Shaoqin did for arm before).
> 
> Welcome your feedback and comments!
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
> In Shaoqin's previous implementation [1], KVM PMU filter is made as a
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
> 
> [1]: https://lore.kernel.org/qemu-devel/20240409024940.180107-1-shahuang@redhat.com/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (5):
>    qapi/qom: Introduce kvm-pmu-filter object
>    i386/kvm: Support initial KVM PMU filter
>    i386/kvm: Support event with select&umask format in KVM PMU filter
>    i386/kvm: Support event with masked entry format in KVM PMU filter
>    i386/kvm: Support fixed counter in KVM PMU filter
> 
>   MAINTAINERS                |   1 +
>   accel/kvm/kvm-pmu.c        | 367 +++++++++++++++++++++++++++++++++++++
>   accel/kvm/meson.build      |   1 +
>   include/sysemu/kvm-pmu.h   |  43 +++++
>   include/sysemu/kvm_int.h   |   2 +
>   qapi/kvm.json              | 255 ++++++++++++++++++++++++++
>   qapi/meson.build           |   1 +
>   qapi/qapi-schema.json      |   1 +
>   qapi/qom.json              |   3 +
>   target/i386/kvm/kvm.c      | 211 +++++++++++++++++++++
>   target/i386/kvm/kvm_i386.h |   1 +
>   11 files changed, 886 insertions(+)
>   create mode 100644 accel/kvm/kvm-pmu.c
>   create mode 100644 include/sysemu/kvm-pmu.h
>   create mode 100644 qapi/kvm.json
> 

-- 
Shaoqin


