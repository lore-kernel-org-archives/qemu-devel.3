Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42491D59D79
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6rY-0003IL-7v; Fri, 12 Dec 2025 12:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vU6rV-0003Ht-N2
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:23:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vU6rU-0002yQ-4v
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765560202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UhQ3yFK0QRaU98p4nEPmtX8hvDlW65XWZPPT14Prge4=;
 b=JLHuTb3cvoqwh4kSR5dE1LIK44976tqNraxlEUpkLnIEPRIk6yPYz2KP7sBVI38dsdA/0D
 EaWvEozUPgXAj19By2tXLNyYSiGyVpZCx6Il6MeeLym2hOVmoEYA3pCCchwb+p9byBL9Ol
 hntM1+xb7ES19UT26W96z6UFjmgz2kc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-EVKmXqNzOEmS0LYd3pRZuA-1; Fri, 12 Dec 2025 12:23:20 -0500
X-MC-Unique: EVKmXqNzOEmS0LYd3pRZuA-1
X-Mimecast-MFC-AGG-ID: EVKmXqNzOEmS0LYd3pRZuA_1765560200
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88820c4d039so27982706d6.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 09:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765560200; x=1766165000; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UhQ3yFK0QRaU98p4nEPmtX8hvDlW65XWZPPT14Prge4=;
 b=ppRziO0GGHg/6N4D9pZbQHN49zeOXnIgiE6zFHrXV5qOxURyiOamycG9Z0xUAkHmWh
 DUxYIyDhPWw1n9wApoSrph1VW1c3nCrMmqlxQhx9JT1ZNbMsF2T5NFxhxUnUuZc1nsGI
 1hdLPM1+kdr07FHwn4M2Si3U7h1RK+q9teZC08pHOx+6SOFqW08KBgKhJtqJl0x+kMAW
 dZacbxJECn9PTwmgnsM8DuCBplOZk57z33ZeQXHZB6Nt3ZRvXRSkrtQvnCCnfxs9Aa93
 aB1Fnl0qTnOIv9XXF5TgjgPLLKT1sW2YBjWcuFbgxL11lR/JLfn5wS0kfC6RkQo64VYr
 iGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765560200; x=1766165000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhQ3yFK0QRaU98p4nEPmtX8hvDlW65XWZPPT14Prge4=;
 b=HnZlII8k0Q2/pQLw9xnWMQATQaqHh/mKQR6Dy1mpfEDBCYyRKtIP4bbbYrOZOirxxB
 pkfyRLLJ5tgeiKV3H06+CsTiUnLv1XME84Ku1ZJxGNAuEfitQDFL8pEaETpLMT4W/nHE
 13JVA8RNdweyx23+ZNY/jNBWT810wpB5cVqvyLKX4YoZEwpcZMsunV/kw3NgqENuAZSD
 vbJT+pnIy3Od6TB5MHOG3b/e4pWGUFR0u0hNhkcJ8MbXmWVgWc1+ku6qCToiwYCJyiN1
 crPJ0CE6ziBozerGgG/x8qE8OoJrd5Hmjzz6Qnk5l2FQuhsePW9KTrUI5iMfYmQPFe9e
 tXsQ==
X-Gm-Message-State: AOJu0YyvMtYRNNYY+Dk8UIRwQbXxDDygyoeoKg/jezKglgWMel97xcCa
 JX9WbsvpOW8Z+v1YKWekAYQpe5dSRc5PdyNRTVuCDDpD9Zdem9JbRb+jKUPjB8sIICiLvpcoyMF
 7ytnXLkyAbT/b/WEODi8DokLoRqRVyeWVv1FUVglbzTWUFjwY467he7Kd
X-Gm-Gg: AY/fxX47EZpyHqyxuLc+jpBxCKkRRuUCQYsKCNFTwS0AlOPE7y3m1r+Bvf2FcNemPfC
 iep/BBhFS/3yFI3DX6YfKm4QyD0zdMtLouf/1sFJuIyrRLyVOAiF1FCbhQBKku/8Va1dNtZ9ZO0
 HnRZlf6x2T4DY2rksRg7GRr+BhGp9cc8j1yswFvH/W5+MvRByjIIFXQbnM3uFrxbP2nIhKZvcnM
 2m33Bmx97sCQrSGhWczqwmQd4MRSzs7BjWVI9E201RE6G3IAOx5q+DELlhNHJbFiwTCuU/PortR
 NEwkwvX2ayMX+XlUi8NH2C6R4TIzF82OVwIBZ+3QLq5Chut/KVvIekTq3gLRTnT3RZYjW0BR6pF
 8jks=
X-Received: by 2002:a05:6214:310a:b0:87c:f92:a54e with SMTP id
 6a1803df08f44-8887e020304mr49655986d6.4.1765560200260; 
 Fri, 12 Dec 2025 09:23:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOQAXoKQdq7IGg/n6kQdHrMwxzu0w0ClbuWKokGVgQd+p+V3pnNtZWK5+a+ij2ZB4LBbvC1g==
X-Received: by 2002:a05:6214:310a:b0:87c:f92:a54e with SMTP id
 6a1803df08f44-8887e020304mr49655476d6.4.1765560199827; 
 Fri, 12 Dec 2025 09:23:19 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-888818268fasm15344356d6.14.2025.12.12.09.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 09:23:19 -0800 (PST)
Date: Fri, 12 Dec 2025 12:23:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 2/9] kvm: Detect guest-memfd flags supported
Message-ID: <aTxPhhvS2FiW3cgK@x1.local>
References: <20251119172913.577392-1-peterx@redhat.com>
 <20251119172913.577392-3-peterx@redhat.com>
 <a958f847-78fc-4743-80bb-49aae5f37bcf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a958f847-78fc-4743-80bb-49aae5f37bcf@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Dec 12, 2025 at 11:10:23AM +0800, Xiaoyao Li wrote:
> On 11/20/2025 1:29 AM, Peter Xu wrote:
> > Detect supported guest-memfd flags by the current kernel, and reject
> > creations of guest-memfd using invalid flags.  When the cap isn't
> > available, then no flag is supported.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   accel/kvm/kvm-all.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 96c194ce54..f477014126 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -108,6 +108,7 @@ static int kvm_sstep_flags;
> >   static bool kvm_immediate_exit;
> >   static uint64_t kvm_supported_memory_attributes;
> >   static bool kvm_guest_memfd_supported;
> > +static uint64_t kvm_guest_memfd_flags_supported;
> >   static hwaddr kvm_max_slot_size = ~0;
> >   static const KVMCapabilityInfo kvm_required_capabilites[] = {
> > @@ -2787,6 +2788,10 @@ static int kvm_init(AccelState *as, MachineState *ms)
> >       kvm_guest_memfd_supported =
> >           kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> >           kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
> > +
> > +    ret = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
> > +    kvm_guest_memfd_flags_supported = ret > 0 ? ret : 0;
> > +
> >       kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
> >       if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
> > @@ -4492,6 +4497,12 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
> >           return -1;
> >       }
> > +    if (flags & ~kvm_guest_memfd_flags_supported) {
> > +        error_setg(errp, "KVM does not support guest-memfd flag: 0x%"PRIx64,
> 
> I'm thinking if need to add "for current VM" like:
> 
> 	KVM does not support guest-memfd flag: xxx for current VM
> 
> because kvm_guest_memfd_flags_supported is got from VM-scope CAP and varies
> for different VM types.

Sure I can amend it.  Though I plan to change the sentence slightly:

     if (flags & ~kvm_guest_memfd_flags_supported) {
-        error_setg(errp, "KVM does not support guest-memfd flag: 0x%"PRIx64,
+        error_setg(errp, "Current KVM instance does not support "
+                   "guest-memfd flag: 0x%"PRIx64,
                    flags & ~kvm_guest_memfd_flags_supported);
         return -1;
     }

Thanks,

> 
> > +                   flags & ~kvm_guest_memfd_flags_supported);
> > +        return -1;
> > +    }
> > +
> >       fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
> >       if (fd < 0) {
> >           error_setg_errno(errp, errno, "Error creating KVM guest_memfd");
> 

-- 
Peter Xu


