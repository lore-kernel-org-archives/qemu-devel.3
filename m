Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426E0C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 19:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXPsS-0004RD-Di; Thu, 03 Jul 2025 15:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXPsG-0004Qp-92
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 15:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXPsC-0006xz-NS
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 15:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751571930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3YD7JjAOry+wB3qZhLEdeFTD0ajGvC3eanym7c/av4s=;
 b=gW23tqr9LB1WTtK3oE3T1GpVPRDdSw6YIsYAhr4Bff7ZyVhwnV8DrLLVaE283UiWYtk66i
 ZrRyD6uVkmapbMLvZ5BAPoEteQtVDdXhsUml1gsc8tGtUmf0aFypT4mdrKAvKZ/R5nAqLm
 pvEx6bi0VtA0+hvcVsZ7dWMeJdkwjV4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-frL3zloVM-WHMeCN5mmrSQ-1; Thu, 03 Jul 2025 15:45:28 -0400
X-MC-Unique: frL3zloVM-WHMeCN5mmrSQ-1
X-Mimecast-MFC-AGG-ID: frL3zloVM-WHMeCN5mmrSQ_1751571928
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6114c90e664so65520eaf.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 12:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751571928; x=1752176728;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YD7JjAOry+wB3qZhLEdeFTD0ajGvC3eanym7c/av4s=;
 b=EiMhlwQQtTZzTAh6dp7o1gMJ1ir2PP1Q+RgY2GISwgVaGVi+5M8ciX7oC5RBfy2vUw
 q8EPW+QlK+KbVEH3pRjGK6E0qgMutUiiO4YkAA9prkRjF9r8vHvIXhUoENznnFi/Ryb9
 ii0MZCeKSDf4yffUVInpT6GwEj+RjuuJV0KQndjyda0UQCbEJWTRKlRv7KX7FkrOTfQL
 eZ7O7htLSv9+twA6D6I6dL/KfeHS9M4b80cAnmwExozI72NPoO2tVpMEef4MghzArTLt
 AAFEh1S0RSkZS61EFzOMoYcJb9kInaaB0PB/CNIqL2WTjprXrYkE71jorp4iSX3eAHmZ
 b6bQ==
X-Gm-Message-State: AOJu0YwPCkZkM1+rLo7JB/u1QejcDyh1Yc1bIIigeHxiM7wpips7dTBs
 qFWhkKxPhU4+AXGwelTDdAwDQwG2cG0Rw9MDUlTWK8fReK/zGe3zrSMKWkLmzcWjs+kBF8tLg5s
 kt2arW14OHtuCfQX9ZNs8lsTSRph1FAlIQCqAkF9UVdYHtn6DmC4fjw57
X-Gm-Gg: ASbGnct6t/gVumxPxvj/V/jVzXzQdquDsygwXCj2kqYqOAHd6eZIQfKVXZvBmkskKOI
 Q6Rl0LLUTkx/yrK01yE0K/aYsVqPXX++3ipUu91XsScNwb2ceOOCOp3L7dZPq4k7RjYSGeOJnKA
 TsD2d3BxZ+uZrM90lvgtPtUgJSV20RGeU6BL2+oBOxPT57TMp9Pvah4f7rU9mSuYy/D4/r8Upoh
 bB+s2LWYhCuoxb+4k9XXor2QDjlWOYXjUaVbmJFIAsfrQQz1hfo2IcdvwjknVwcMFe6Jw1krKtN
 Q0RYZOR789S0IA==
X-Received: by 2002:a05:6871:1d1:b0:2d4:ce45:6993 with SMTP id
 586e51a60fabf-2f79206502bmr105273fac.30.1751571927842; 
 Thu, 03 Jul 2025 12:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhZ4UvbhsYn2jpjy5ZwpZOs4Uod7fSmwyNVsvuGcEE9QZ5mHx1TwTPWDAVM1gBcyrdVkIxNA==
X-Received: by 2002:a05:6871:1d1:b0:2d4:ce45:6993 with SMTP id
 586e51a60fabf-2f79206502bmr105244fac.30.1751571927485; 
 Thu, 03 Jul 2025 12:45:27 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f7901a6c1bsm77705fac.26.2025.07.03.12.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 12:45:25 -0700 (PDT)
Date: Thu, 3 Jul 2025 15:45:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH V5 20/38] migration: close kvm after cpr
Message-ID: <aGbd0IgvtiR4EkoH@x1.local>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-21-git-send-email-steven.sistare@oracle.com>
 <9dfc0dae-f048-4d41-9b6e-02b6e7dbc215@oracle.com>
 <aGVYD1GkOC-LuI1T@x1.local>
 <a0487a01-41de-4997-860c-bc555a295643@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0487a01-41de-4997-860c-bc555a295643@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jul 02, 2025 at 03:41:08PM -0400, Steven Sistare wrote:
> The irq producer is not closed, but it is detached from the kvm consumer.
> It's eventfd is preserved in new QEMU, and interrupts that arrive during
> transition are pended there.

Ah I see, looks reasonable.

So can I understand the core issue here is about the irq consumer /
provider updates are atomic, meanwhile there's always the fallback paths
ready, so before / after the update the irq won't get lost?

E.g. in Post-Interrupt context of Intel's, the irte will be updated
atomically for these VFIO irqs, so that either it'll keep using the fast
path (provided by the irqbypass mechanism), or slow path (eventfd_signal),
so it's free of any kind of race that irq could trigger?

I saw that there's already a new version and Cedric queued it.  If possible
add some explanation into commit message, either when repost, or when
merge, would be nice, on explaning irq won't get lost.

Thanks,

-- 
Peter Xu


