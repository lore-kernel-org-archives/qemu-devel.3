Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F68C25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 06:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBU3A-0003F7-Rr; Mon, 27 May 2024 02:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1sBU2n-00033k-S2
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1sBU2h-0007GD-JO
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716792070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDQ4+f7uSOIPxyxtatT2QjghoY3eF9jP0el/KnAqVDY=;
 b=YlWtgNAHkHllggx3WKwYFhwE+hjJf6JSJwkt/32uBHcv/KAwQDR2IZLhTmBwB+kyMQFb2p
 uwK05Fl/W3A6CppSuW8hymvBMGrpuFwbetQptOamQ1oHxE13UFAqxo/sEmx8c1mHchB/9i
 /7UiZtqksPm/fc+8jXWJ969eOZ+UMzw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-QNVsCJ4XOFa_AFr16VX10g-1; Mon, 27 May 2024 02:41:08 -0400
X-MC-Unique: QNVsCJ4XOFa_AFr16VX10g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2bf59a23985so967875a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 23:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716792067; x=1717396867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GDQ4+f7uSOIPxyxtatT2QjghoY3eF9jP0el/KnAqVDY=;
 b=OqzDrCla+m2bG7Xqi3G8MhrTv4vARrT7NRC0PEpS/o2gphiH/PXHDrSycfWWF/F2au
 GsZIUNHcqXrBQcUvVyGi0lpnt+mUP08l0/QSJ0HRf0rQprxGqatetaV4YfiqDh5OKMc5
 uzoxktmgc4k8sMqDRpq5eRavmKrDqagllBryPgDI+3hEQ+EO6Q3QFZ1nJWlJ7oy5v1+r
 vm6Pj7zTiAOq8YzdORdo81wHPX0xm3QTdgS9qllkCV3e32GGwvRMpzDtgfPwd5u7yPYf
 5Pc+gLv27gipaG7GT9QhFkZEI3vzfsZ8uSxbFFMaTC3v9vbyFCUf26Qo+VUShtnjegBT
 jzpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFswmuf2KB1DaxxIYyeE/7wHIdWQnnUjcHaGMdTToTkBl3zEvmtOCJ7BlZbW31eUOhyw+RWMNHrpdGbTcmwHOQTQfe9Es=
X-Gm-Message-State: AOJu0YwgaqLRJJR9+5mQ/qYLfPpH1bMfo/RB0qjSQU/1b6SdjBAmn9I0
 2Y+77VfIokNEeWoof6gaUpmFdyKge58Kgp6nUiZBqFJVisi0hu56eQDPsWZWEdsJkQncva30Z5T
 53QGpRHnO+vfxnwzy2HwvJtdRiD5N5F1n1/BbVoDTeGbiXosfC3QJ
X-Received: by 2002:a17:90b:24c:b0:2b4:329e:eac5 with SMTP id
 98e67ed59e1d1-2bf5f202ac5mr8055011a91.2.1716792066832; 
 Sun, 26 May 2024 23:41:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL7QRzKtBCyiR8SVB39tTRtC2TtbQpijjse3JQktv824/f92qgYmTQuQaeYz4emWsaV/J+/Q==
X-Received: by 2002:a17:90b:24c:b0:2b4:329e:eac5 with SMTP id
 98e67ed59e1d1-2bf5f202ac5mr8054991a91.2.1716792066333; 
 Sun, 26 May 2024 23:41:06 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bdf1f931c8sm6262050a91.50.2024.05.26.23.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 May 2024 23:41:05 -0700 (PDT)
Message-ID: <d3733e25-eb1e-4c19-b77f-d68e871c9f0f@redhat.com>
Date: Mon, 27 May 2024 14:41:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240409024940.180107-1-shahuang@redhat.com>
 <Zh1j9b92UGPzr1-a@redhat.com> <Zjyb43JqMZA+bO4r@intel.com>
 <ZjyZ1ZV7BGME_bY9@redhat.com> <ZkG4nlwRnvz9oUXX@intel.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZkG4nlwRnvz9oUXX@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Zhao,

Thanks for your proposed idea. If you are willing to take the PMU Filter 
Enabling work, you can do it. I won't update this series anymore due to 
the QAPI restriction. I really appreciate if you can implement that.

Thanks,
Shaoqin

On 5/13/24 14:52, Zhao Liu wrote:
> Hi Daniel,
> 
>> Please describe it in terms of a QAPI definition, as that's what we're
>> striving for with all QEMU public interfaces. Once the QAPI design is
>> agreed, then the -object mapping is trivial, as -object's JSON format
>> supports arbitrary QAPI structures.
> 
> Thank you for your guidance!
> 
> I rethought and and modified my previous proposal:
> 
> Let me show the command examples firstly:
>    * Add a single event:
>      (x86) -object kvm-pmu-event,id=e0,action=allow,format=x86-default,\
>                    select=0x3c,umask=0x00
>      (arm or general) -object kvm-pmu-event,id=e1,action=deny,\
>                               format=raw,code=0x01
>   
>    * Add a counter bitmap:
>      (x86) -object kvm-pmu-counter,id=cnt,action=allow,type=x86-fixed,\
>                    bitmap=0xffff0000
>   
>    * Add an event list (must use Json syntax format):
>     (x86) -object '{"qom-type":"kvm-pmu-event-list","id"="filter0","action"="allow","format"="x86-default","events=[{"select"=0x3c,"umask"=0x00},{"select"=0x2e,"umask"=0x4f}]'
>     (arm) -object '{"qom-type":"kvm-pmu-event-list","id"="filter1","action"="allow","format"="raw","events"=[{"code"=0x01},{"code"=0x02}]'
> 
> 
> The specific JSON definitions are as follows (IIUC, this is "in terms of
> a QAPI definition", right? ;-)):
> * Define PMU event and counter bitmap with JSON format:
>    - basic filter action:
> 
>    { 'enum': 'KVMPMUFilterAction',
>      'prefix': 'KVM_PMU_FILTER_ACTION',
>      'data': ['deny', 'allow' ] }
> 
>    - PMU counter:
> 
>    { 'enum': 'KVMPMUCounterType',
>      'prefix': 'KVM_PMU_COUNTER_TYPE',
>      'data': [ 'x86-fixed' ] }
> 
>    { 'struct': 'KVMPMUX86FixedCounter',
>      'data': { 'bitmap': 'uint32' } }
> 
>    - PMU events (total 3 formats):
> 
>    # 3 encoding formats: "raw" is compatible with shaoqin's ARM format as
>    # well as the x86 raw format, and could support other architectures in
>    # the future.
>    { 'enum': 'KVMPMUEventEncodeFmt',
>      'prefix': 'KVM_PMU_EVENT_ENCODE_FMT',
>      'data': ['raw', 'x86-default', 'x86-masked-entry' ] }
> 
>    # A general format.
>    { 'struct': 'KVMPMURawEvent',
>      'data': { 'code': 'uint64' } }
> 
>    # x86-specific
>    { 'struct': 'KVMPMUX86DefalutEvent',
>      'data': { 'select': 'uint16',
>                'umask': 'uint16' } }
> 
>    # another x86 specific
>    { 'struct': 'KVMPMUX86MaskedEntry',
>      'data': { 'select': 'uint16',
>                'match': 'uint8',
>                'mask': 'uint8',
>                'exclude': 'bool' } }
> 
>    # And their list wrappers:
>    { 'struct': 'KVMPMURawEventList',
>      'data': { 'events': ['KVMPMURawEvent'] } }
> 
>    { 'struct': 'KVMPMUX86DefalutEventList',
>      'data': { 'events': ['KVMPMUX86DefalutEvent'] } }
> 
>    { 'struct': 'KVMPMUX86MaskedEntryList',
>      'data': { 'events': ['KVMPMUX86MaskedEntryList'] } }
> 
> 
> Based on the above basic structs, we could provide 3 new more qom-types:
>    - 'kvm-pmu-counter': 'KVMPMUFilterCounter'
> 
>    # This is a single object option to configure PMU counter
>    # bitmap filter.
>    { 'union': 'KVMPMUFilterCounter',
>      'base': { 'action': 'KVMPMUFilterAction',
>                'type': 'KVMPMUCounterType' },
>      'discriminator': 'type',
>      'data': { 'x86-fixed': 'KVMPMUX86FixedCounter' } }
> 
> 
>    - 'kvm-pmu-counter': 'KVMPMUFilterCounter'
> 
>    # This option is used to configure a single PMU event for
>    # PMU filter.
>    { 'union': 'KVMPMUFilterEvent',
>      'base': { 'action': 'KVMPMUFilterAction',
>                'format': 'KVMPMUEventEncodeFmt' },
>      'discriminator': 'format',
>      'data': { 'raw': 'KVMPMURawEvent',
>                'x86-default': 'KVMPMUX86DefalutEvent',
>                'x86-masked-entry': 'KVMPMUX86MaskedEntry' } }
> 
> 
>    - 'kvm-pmu-event-list': 'KVMPMUFilterEventList'
> 
>    # Used to configure multiple events.
>    { 'union': 'KVMPMUFilterEventList',
>      'base': { 'action': 'KVMPMUFilterAction',
>                'format': 'KVMPMUEventEncodeFmt' },
>      'discriminator': 'format',
>      'data': { 'raw': 'KVMPMURawEventList',
>                'x86-default': 'KVMPMUX86DefalutEventList',
>                'x86-masked-entry': 'KVMPMUX86MaskedEntryList' } }
> 
> 
> Compared to Shaoqin's original format, kvm-pmu-event-list is not able to
> enumerate events continuously (similar to 0x00-0x30 before), and now
> user must enumerate events one by one individually.
> 
> What do you think about the above 3 new commands?
> 
> Thanks and Best Regards,
> Zhao
> 

-- 
Shaoqin


