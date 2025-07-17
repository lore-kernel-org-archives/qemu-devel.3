Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1D4C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLiZ-0006Hg-BY; Thu, 17 Jul 2025 06:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucLiI-0006Bc-PO
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:19:42 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucLiF-0007TP-01
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752747580; x=1784283580;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Vl4K45qQyCqmDOellS7QAxAIusspFV5v7ACz0r3yUUs=;
 b=kV2ZnqODLh+UYqGWu1BDWNxfgn/XaMb3IHhWxolOgdY21gbUsHj2rD/6
 ryvPcURSEb6mXOrZqgy/ldNGv2jOpoqvVrcmCPPrJpKzQQpkE7ShOK9iM
 YzWhOQAmZC8RRsV5x2LrxRM0L9j93hZ0Azh8vwffmHlUOIdzzpiZ3a6qr
 fbjnf4Sk1teiHinI5n/qn4MJ227CRgbMjNudfSawX9UXCbcuCWaPoMjQK
 g0afD7AazwYC6LZZsMXe6hu1NyfZP7mCf6O3F8W/Ia5qfCN18I+gIO7nI
 rHP57hnd8SX+B3EE8tsYR1DrXh0PLPEjw2anokadIMpWWJ0/p6jsIvH99 w==;
X-CSE-ConnectionGUID: 1EbrkvAaSeCB8ah9E85Vcg==
X-CSE-MsgGUID: 98ch76ZPQYWMa3iiIZZ1XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="66466074"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="66466074"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 03:19:29 -0700
X-CSE-ConnectionGUID: t+tsEkq9SwOXbhcRssp6OQ==
X-CSE-MsgGUID: GwHjvpEtQ2aGNiemajeO2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="161787980"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 03:19:27 -0700
Message-ID: <be20d3fd-fde7-4ba3-8444-a02936a468ab@intel.com>
Date: Thu, 17 Jul 2025 18:19:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/77] i386/tdx: handle
 TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250714110406.117772-1-pbonzini@redhat.com>
 <20250714110406.117772-16-pbonzini@redhat.com>
 <CAFEAcA9Hz0K9Z27mVs2fYcXpa-1p=kJvtgWEVjGTg-C+-egnVg@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAFEAcA9Hz0K9Z27mVs2fYcXpa-1p=kJvtgWEVjGTg-C+-egnVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/17/2025 5:46 PM, Peter Maydell wrote:
> On Mon, 14 Jul 2025 at 12:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> Record the interrupt vector and the apic id of the vcpu that calls
>> TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT.
>>
>> Inject the interrupt to TD guest to notify the completion of <GetQuote>
>> when notify interrupt vector is valid.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Link: https://lore.kernel.org/r/20250703024021.3559286-5-xiaoyao.li@intel.com
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Hi; Coverity (CID 1612364) thinks the locking might not
> be right in this code change (though it has a fairly
> simple heuristic so it may be wrong):
> 
> 
>> @@ -1154,6 +1179,9 @@ static void tdx_get_quote_completion(TdxGenerateQuoteTask *task)
>>           error_report("TDX: get-quote: failed to update GetQuote header.");
>>       }
>>
>> +    tdx_inject_interrupt(tdx_guest->event_notify_apicid,
>> +                         tdx_guest->event_notify_vector);
> 
> In this function we access tdx_guest->event_notify_apicid
> and event_notify_vector without taking any lock...
> 
>> +
>>       g_free(task->send_data);
>>       g_free(task->receive_buf);
>>       g_free(task);
> 
>> +void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu, struct kvm_run *run)
>> +{
>> +    uint64_t vector = run->tdx.setup_event_notify.vector;
>> +
>> +    if (vector >= 32 && vector < 256) {
>> +        qemu_mutex_lock(&tdx_guest->lock);
>> +        tdx_guest->event_notify_vector = vector;
>> +        tdx_guest->event_notify_apicid = cpu->apic_id;
>> +        qemu_mutex_unlock(&tdx_guest->lock);
> 
> ...but here when we are setting those fields we take the
> tdx_guest->lock.
> 
> Should we hold the tdx_guest->lock also when we read the
> fields in tdx_get_quote_completion() ?

yeah, I think we should.

I will send a patch to fix it. Thanks for reporting it!

> thanks
> -- PMM


