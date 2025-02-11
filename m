Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D299FC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 21:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thy7f-0004bJ-B5; Tue, 11 Feb 2025 16:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thy52-0000rB-Dk
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thy50-0005zj-G8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739310365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PgX+573L61jAZ+NGLaGL4AkiU3yn8kRPpAQyDAW3KPU=;
 b=B6joXj44OeS6cSy92P6nAh0wisIBelnkRpSnjAGQ/yfJ1JXTpG6+u6rm+8OEzd2+3eJBdj
 jLxjLlqJtxmQyD/m4DWHRbypjAzdF7tqoPwSl+dJhzimuRQpMWQjsxjfrBkFIts2RYoGHg
 VHeEbIM4Pnlxrxk8YlCWISd4Z+I2QZw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-vHBaHIHlOm6HjcJ_kpLPQQ-1; Tue, 11 Feb 2025 16:46:03 -0500
X-MC-Unique: vHBaHIHlOm6HjcJ_kpLPQQ-1
X-Mimecast-MFC-AGG-ID: vHBaHIHlOm6HjcJ_kpLPQQ_1739310362
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3f3b8f794e1so2046379b6e.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 13:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739310362; x=1739915162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgX+573L61jAZ+NGLaGL4AkiU3yn8kRPpAQyDAW3KPU=;
 b=o/W9MPA7YNFRaxrXJyw2aGgPZJWNvRLe9WSr9uWCzWqb+mWlaP1MgTNqmaPQ0Ctr3n
 NGLe60lmkblb+h4waxOcijt6J4VoGiInd1NDjVxo57Q0ksxnCI8YTpztbuE6UZWDWxS+
 iG4Pi8V3BLhRkpDXEkeZtFv/t2+U279fopgQp3ffxZPC7I3R1OVnioFKVLDe+AXxI0xG
 /Pa12wphfsSeeH6lY44bUM7G2hxjlw4njsSMCFsLSkdBtE7jbUv3R8JqJDWKJZQUO1qb
 d0JmlrvJoEDbMQArsb4RoUqjmTr9QAV1KUGLpS6Rr5XEd0mZpPsbKTzc/J22p5ceXMwe
 PILg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLhgXmke365MDaWcqFgLWVlDslALS6uilBkvpo+IMhk66c6IOmArjI5Auj4L2l/5fCpI0vCCf7YBlW@nongnu.org
X-Gm-Message-State: AOJu0YwzG5WT8/v4QG9rALoVRokRRfFknDRRSUhpWIcz/JkSOQArnt4t
 fkh0X4Pbih9zKYBovIf7r/3SfnT5rs7hZlV2ISpsqvfBf0N7Gjg59tSemTDCsZ9rAXwHtnZnwWT
 /kNM6dhmM7LvwnU7gRMevm/qMKG40fgE1JERX6KW9ZhhzKx/BuWIx
X-Gm-Gg: ASbGncubFsyyZkG4M1pPTxcqSR9y43kZn6LHhyeZvoDdeZ8rqTudDIV8ecOSrXk4txP
 ACliNtZrOePr38FQqMjO91GabImEs4U+ZDDacLpMM4hL1OVCTQ+XwmgM5nHIeg0r/h+vmdwrXnt
 HvQJsPfBDMEZnO5pVcZDA1Xxw/Xpi1otkxaBjbNUs2yVpw14sr04VnGBdIT0ehT97Mq8AqvxrqF
 xWbgN6ZHK1jMvWSYAAYlgVTz78LhBK9C+hGrBhKVXH3ivPj+xFLvhfYvcI=
X-Received: by 2002:a05:6808:1454:b0:3eb:6db7:f787 with SMTP id
 5614622812f47-3f3cefdd936mr302523b6e.11.1739310362156; 
 Tue, 11 Feb 2025 13:46:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYnOD2BAMH3w3POLOCBd11WZ3vPq9hbLjN/niZU4pJlfl+Gy6RLvr7Z7LkVcpTulQy+mpdcA==
X-Received: by 2002:a05:6808:1454:b0:3eb:6db7:f787 with SMTP id
 5614622812f47-3f3cefdd936mr302509b6e.11.1739310361858; 
 Tue, 11 Feb 2025 13:46:01 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f389ea91acsm3500233b6e.8.2025.02.11.13.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 13:46:01 -0800 (PST)
Date: Tue, 11 Feb 2025 16:45:55 -0500
From: Peter Xu <peterx@redhat.com>
To: William Roche <william.roche@oracle.com>
Cc: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v7 3/6] accel/kvm: Report the loss of a large memory page
Message-ID: <Z6vFEwS6EjDXHsFc@x1.local>
References: <20250201095726.3768796-1-william.roche@oracle.com>
 <20250201095726.3768796-4-william.roche@oracle.com>
 <Z6JH_OyppIA7WFjk@x1.local>
 <3f3ebbe8-be97-4827-a8c5-6777dea08707@oracle.com>
 <Z6Oaukumli1eIEDB@x1.local>
 <2ad49f5d-f2c1-4ba2-9b6b-77ba96c83bab@oracle.com>
 <Z6ot7eVxaf39oWKr@x1.local>
 <6c891caf-fbc0-4f5e-8e21-e87c3348c9fa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c891caf-fbc0-4f5e-8e21-e87c3348c9fa@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 11, 2025 at 10:22:38PM +0100, William Roche wrote:
> On 2/10/25 17:48, Peter Xu wrote:
> > On Fri, Feb 07, 2025 at 07:02:22PM +0100, William Roche wrote:
> > > [...]
> > > So the main reason is a KVM "weakness" with kvm_send_hwpoison_signal(), and
> > > the second reason is to have richer error messages.
> > 
> > This seems true, and I also remember something when I looked at this
> > previously but maybe nobody tried to fix it.  ARM seems to be correct on
> > that field, otoh.
> > 
> > Is it possible we fix KVM on x86?
> 
> Yes, very probably, and it would be a kernel fix.
> This kernel modification would be needed to run on the hypervisor first to
> influence a new code in qemu able to use the SIGBUS siginfo information and
> identify the size of the page impacted (instead of using an internal
> addition to kvm API).
> But this mechanism could help to generate a large page memory error specific
> message on SIGBUS receiving.

Yes, QEMU should probably better be able to work on both old/new kernels,
even if this will be fixed.

> 
> 
> > > > 
> > > > I feel like when hwpoison becomes a serious topic, we need some more
> > > > serious reporting facility than error reports.  So that we could have this
> > > > as separate topic to be revisited.  It might speed up your prior patches
> > > > from not being blocked on this.
> > > 
> > > I explained why I think that error messages are important, but I don't want
> > > to get blocked on fixing the hugepage memory recovery because of that.
> > 
> > What is the major benefit of reporting in QEMU's stderr in this case?
> 
> Such messages can be collected into VM specific log file, as any other
> error_report() message, like the existing x86 error injection messages
> reported by Qemu.
> This messages should help the administrator to better understand the
> behavior of the VM.

I'll still put "better understand the behavior of VM" into debugging
category. :)

But I agree such can be important information.  That's also why I was
curious whether it should be something like a QMP event instead.  That's a
much formal way of sending important messages.

> 
> 
> > For example, how should we consume the error reports that this patch
> > introduces?  Is it still for debugging purpose?
> 
> Its not only debugging, but it's a trace of a significant event that can
> have major consequences on the VM.
> 
> > 
> > I agree it's always better to dump something in QEMU when such happened,
> > but IIUC what I mentioned above (by monitoring QEMU ramblock setups, and
> > monitor host dmesg on any vaddr reported hwpoison) should also allow anyone
> > to deduce the page size of affected vaddr, especially if it's for debugging
> > purpose.  However I could possibly have missed the goal here..
> 
> You're right that knowing the address, the administrator can deduce what
> memory area was impacted and the associated page size. But the goal of these
> large page specific messages was to give details on the event type and
> immediately qualify the consequences.
> Using large pages can also have drawbacks, and a large page specific message
> on memory error makes that more obvious !  Not only a debug msg, but an
> indication that the VM lost an unusually large amount of its memory.
> 
> > > 
> > > If you think that not displaying a specific message for large page loss can
> > > help to get the recovery fixed, than I can change my proposal to do so.
> > > 
> > > Early next week, I'll send a simplified version of my first 3 patches
> > > without this specific messages and without the preallocation handling in all
> > > remap cases, so you can evaluate this possibility.
> > 
> > Yes IMHO it'll always be helpful to separate it if possible.
> 
> I'm sending now a v8 version, without the specific messages and the remap
> notification. It should fix the main recovery bug we currently have. More
> messages and a notification dealing with pre-allocation can be added in a
> second step.
> 
> Please let me know if this v8 version can be integrated without the prealloc
> and specific messages ?

IMHO fixing hugetlb page is still a progress on its own, even without any
added error message, or proactive allocation during reset.

One issue is the v8 still contains patch 3 which is for ARM kvm.. You may
need to post it separately for ARM maintainers to review & collect.  I'll
be able to queue patch 1-2.

Thanks,

-- 
Peter Xu


