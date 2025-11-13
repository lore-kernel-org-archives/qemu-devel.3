Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FCACD98E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 21:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJet7-00073u-6f; Thu, 13 Nov 2025 16:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJeW5-0000ax-BU
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:06:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJeW3-0005Zj-U5
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763067962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JL/v6J68lg2RvncxWRrbXTogTIMVK670L6+8XYBdfc4=;
 b=FSnuaSVV4RfnZgn8c1oGODf24opS5zEQ07V/0Cy8/erE4mW2mgEyu6pCdLYC2ttQ67pT2G
 aelTZqDX1CoTBvfyl7/a4Q+FCKtbflIx/WF/F85qmBM3KDcI5woCYcIMpajoMCb/zYtRvC
 YOiQjprWtthTdszhCcriVXBEGKXY8HY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-twtmKbz6Nr6kwKLsavvrfQ-1; Thu, 13 Nov 2025 16:06:00 -0500
X-MC-Unique: twtmKbz6Nr6kwKLsavvrfQ-1
X-Mimecast-MFC-AGG-ID: twtmKbz6Nr6kwKLsavvrfQ_1763067960
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-89eb8ee2a79so766447985a.2
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 13:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763067960; x=1763672760; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JL/v6J68lg2RvncxWRrbXTogTIMVK670L6+8XYBdfc4=;
 b=p5x5VIcLVZaU8xS+2HjC/GXJ5MMIVfH8CZr6xdeojz8rSCajFK0nblDZrAfk8067jx
 M05JRgA4BdAgh/5V9gyfeAEheAFc70q//Mzj6jEAJO7XAHX5tM2nXxoULyjW0HxH2wb9
 IWJRcKXvusTfRpcUw0BUKjTcimM43ONA2nAJuL0EH6E+qZyTL10PNfg1bHWh33zU4FGI
 hOjYO8YjQ5ibY6k6z4qbiRNHTD8soss+W4UqwZatBq/67kALtnWjvZv68IdkIHEyqVT0
 Hl9bs3prL0QqLEsN/RsnPnEHTNJr6WctIFZwRr9k/HDV835pWLofPfWB5z9+qzg0HBC/
 4qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763067960; x=1763672760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JL/v6J68lg2RvncxWRrbXTogTIMVK670L6+8XYBdfc4=;
 b=CcswDMXPAdylGf5BPMp0CfQ0pyT8rPIAC4bioTxi4YCfNsyQ5N8xw8lof8HivsOQv7
 1eMi39rQ6nR+e1bIv9Dggd2cwBSFM6Buc2ijNZAwi6j+I+D4MatgdtCY7cY85Bd37wWq
 ByLZUcafuR6nlRT1ROf2TtmXClfS/fWJ9BPTL/K/d8+OKBIpFMzjN4jU5fMNVvobeoii
 yLvz7R3Ui6RVJGrKPEiwr4PvOuk/rQO8IQz/vAUrygOpn0SLbwZDTRdkSn+jwVqWnfZP
 iotDP57soA0HpBiGPhxlrjNgbUY0FQKuvvRrdPSfmLXiOjv3p1wYlsm3tM8V13Xl4vfj
 jCRg==
X-Gm-Message-State: AOJu0Yye9eN/8j7nSPMG5BV0HmCWqFBz9NMPSMkLx0vOJNgoZlonqoGQ
 V24TcX9AtjhyZE+tQLaNvGQZfxTfpQhiW9qO3l9HTdZrQwLqpxQnBH2QaPo07HAFRagSZsKQugn
 TIPZ8XE0zO+zlWT1cgvjTqLQpqyHWwH+8AkT2Qvdu9naMjNrsMuKGaCVG
X-Gm-Gg: ASbGnctxHAush8IAOggNtM3hD0rfRQq9TDw/Qoh4CXvMoFNDJC1WNUolQAruEIk5XRB
 AQ7Dlo0WDvWnM9GutxV7tC3DPZEWDgmUokocD+NOsYgoUcz5R4C/++40o1doH4WBMOijWBapckJ
 gGzFq4ecbTO0nn1ELcsWhcMQsDBpVOb3dpjLthhX1D0kK9FgLlSzN13ej43BfuRSYIMPIktrcIW
 LBW/UjnK+AOZgITXxozeR7vRYdkQV4NqL0+ZSixcbHXb0G/d225kASk/xPnUf7V/jVPKaEa1SnP
 UXk8G4/sQV2gAa93+4Lngvucusv2jdjOKVgVGGGcXR05kXbsQBD6U0GjVi9Kh4WbtyOPUlOQxRm
 /IQ==
X-Received: by 2002:a05:620a:1708:b0:864:48eb:356 with SMTP id
 af79cd13be357-8b2c315b9ffmr104922885a.25.1763067960194; 
 Thu, 13 Nov 2025 13:06:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpCw0YE7k3OOHTOSawkwOsg8ZVBdxfqqck/KM58R3ks/aOKEISHE/JSKhKDRCVG5QIgzD1eg==
X-Received: by 2002:a05:620a:1708:b0:864:48eb:356 with SMTP id
 af79cd13be357-8b2c315b9ffmr104917385a.25.1763067959720; 
 Thu, 13 Nov 2025 13:05:59 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2bd0bfc23sm105605985a.17.2025.11.13.13.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 13:05:59 -0800 (PST)
Date: Thu, 13 Nov 2025 16:05:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 2/8] kvm: Allow kvm_guest_memfd_supported for non-private
 use case
Message-ID: <aRZIM9baerzcuxOi@x1.local>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-3-peterx@redhat.com>
 <9614d727-97bf-4a50-be13-6754952bec96@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9614d727-97bf-4a50-be13-6754952bec96@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 24, 2025 at 10:30:19AM +0800, Xiaoyao Li wrote:
> On 10/24/2025 2:59 AM, Peter Xu wrote:
> > Guest-memfd is not 100% attached to private, it's a VM-specific memory
> > provider.  Allow it to be created even without private attributes, for
> > example, when the VM can use the guest-memfd memory completely shared.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   accel/kvm/kvm-all.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index f9254ae654..1425dfd8b3 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -2779,10 +2779,8 @@ static int kvm_init(AccelState *as, MachineState *ms)
> >       }
> >       kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
> > -    kvm_guest_memfd_supported =
> > -        kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> > -        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
> > -        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> > +    kvm_guest_memfd_supported = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> > +        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
> >       kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
> >       if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
> 
> 
> The check on KVM_MEMORY_ATTRIBUTE_PRIVATE is dropped silently. But using
> guest memfd to serve as private memory does requires the support of
> KVM_MEMORY_ATTRIBUTE_PRIVATE.
> 
> My version of the patch was

Your version looks good, I'll fetch yours to replace mine.  Thanks.

-- 
Peter Xu


