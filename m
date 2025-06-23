Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71362C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 13:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThLS-0002bE-2H; Mon, 23 Jun 2025 09:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uThLP-0002al-W0
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uThLN-00041k-9X
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750685774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMvehU0zIb7A+cvzSUINXmaqZdcEyA0XV12mzeR1itw=;
 b=CFvc30DNJE3EfDpWaoWmUyB1HsrsxZTsFbZ7qPSRaUsZyBxHyk4K7ue/O7tmcj9RRh8Jdp
 3u0i9q4ULTU0pYhqp0mdzwA43uFC7RJq5a1fUdWtSSQ6Wz1PJyzqCuJTjPWeLrVxdPTOV7
 tRcKupMCTsd/fHfLc5sGgWN381kfSDI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-s2e-pbM6OSKQO9i6iiSLGA-1; Mon, 23 Jun 2025 09:36:12 -0400
X-MC-Unique: s2e-pbM6OSKQO9i6iiSLGA-1
X-Mimecast-MFC-AGG-ID: s2e-pbM6OSKQO9i6iiSLGA_1750685772
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7425efba1a3so4531236b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750685771; x=1751290571;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMvehU0zIb7A+cvzSUINXmaqZdcEyA0XV12mzeR1itw=;
 b=pAmdyG+GO1y/1oTS6fwq7d5/SRJeniDMBB4ncp8/7KaME1HkGquGmG0Vlvb5EhZBrc
 lxQncIndUTnxcRuM7NACGd4UTMMrcBRH3aDbc1QtXYMOFvHZUPFkEDWr/CSP4FhQAzvv
 im7XBFGbXl/A8v6Rojv1qn6mZbmyap32tQ4xkoHISRGYoijfY/oUdVuLl0aO43XNR8sm
 bojKNMJ9d1qqnjgg9j3W+4WtX/e087oHZHILsg3i0amH0i7yqPJApRI7qaLdYUnVlKGY
 BPPH4Ullx40mTIzO96mSWnymg0HcjtgmCRLGRCjxMVi6nFxhI3dpn7aNJrC8agOs9Tcr
 DHjg==
X-Gm-Message-State: AOJu0YxrYL3okbFuJChJ/HF7YL4nso70QlutMqR0A70Mcbokl+ZYhVPD
 70G0+VJmQQJmgPtHAKFAgRHmMYvxo3xvbulGdeBxN1tLcjGDXTtY4IF9jtLJAHgQdoGvqjtxJgi
 WgfqvPKnKnlfWs4GDJXrO+290lpcMeI7Zpcyr/ISHt91m9cGhqaS/ZXio
X-Gm-Gg: ASbGnct0eDwuFgVr2P3j2gtezk2royLh+UZlfvwVDfaGjT0tziaQoXWbt4GUz3HAX+9
 trXpGMg0oxHYSSqhe5QJ+lv2SOm6IyMcUsQFAz31jUq4YpAFYnIQQ67lyy2ERn6Wj7aHPpJF4g4
 zFmGzF1l2Qlg8PXXhCwA448oN7Ktr+5HtdGudKijG4nR+xoxVPRIAUP37fK/N+GrCYYNpvqT1R2
 DIM3pb0u7dmdc+Q9dpNeq7QjxUPF9hv9l+T8iBDWMuJKLjHuGUnaEtThvNlNkZFodCxt7OZVluF
 UnjeNu29StXpCA==
X-Received: by 2002:a05:6a00:cd4:b0:742:ae7e:7da1 with SMTP id
 d2e1a72fcca58-7490f287c44mr15597746b3a.0.1750685771557; 
 Mon, 23 Jun 2025 06:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGsWwXE/pkpzAjB28ahdXZ8XvOBf/u/X+Ok3na5GVp4SscKnG0xzNxkqyn9uF9c2Pe+wcdvQ==
X-Received: by 2002:a05:6a00:cd4:b0:742:ae7e:7da1 with SMTP id
 d2e1a72fcca58-7490f287c44mr15597720b3a.0.1750685771133; 
 Mon, 23 Jun 2025 06:36:11 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a486a7bsm8476462b3a.39.2025.06.23.06.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 06:36:10 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:36:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, mst@redhat.com,
 anisinha@redhat.com, elena.ufimtseva@oracle.com,
 jag.raman@oracle.com, pbonzini@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: Re: [PATCH 1/3] memory: reintroduce BQL-free fine-grained PIO/MMIO
Message-ID: <aFlYRWc7rRwBGM8S@x1.local>
References: <20250620151418.1166195-1-imammedo@redhat.com>
 <20250620151418.1166195-2-imammedo@redhat.com>
 <aFWR8rM7-4y1R0GG@x1.local> <20250623145146.4462bf59@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623145146.4462bf59@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jun 23, 2025 at 02:51:46PM +0200, Igor Mammedov wrote:
> On Fri, 20 Jun 2025 12:53:06 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Fri, Jun 20, 2025 at 05:14:16PM +0200, Igor Mammedov wrote:
> > > This patch brings back Jan's idea [1] of BQL-free IO access,
> > > with a twist that whitelist read access only.
> > > 
> > > (as BQL-free write access in [1] used to cause issues [2]
> > > and still does (Windows crash) if write path is not lock protected)  
> > 
> > Can we add some explanation on why it would fail on lockless writes?
> > 
> > I saw that acpi_pm_tmr_write() is no-op, so I don't yet understand what
> > raced, and also why guest writes to it at all..
> 
> root cause wasn't diagnosed back then, and I haven't able to
> reproduce that as well. So I erred on side of caution and
> implemented RO only.

Ah OK, I think I got that feeling it can be reproduced as above mentioned
"still does (Windows crash) if write ...".

> 
> Theoretically write should be fine too, but I don't have
> an idea how to test that.

Then the question is how do we justify it will work this time..

If nobody can reproduce it anymore, there's indeed one way to go if we
strongly want to have the optimization, which is to apply it again and wait
for the reproducer to pop up once more.  Just like to double check is this
the case, and we have no way to reproduce?

I also wonder whether it's still a bit late because such experiment might
be better done at the start of release cycle.  Now we have roughly 3 weeks
to soft-freeze (July 15).  I had a look, last time it was pretty late when
reverting the change:

975eb6a547 (tag: v2.6.0-rc4) Update version for v2.6.0-rc4 release
1beb99f787 Revert "acpi: mark PMTIMER as unlocked"

So there's also the question of whether we should land this for this
release or next when open.

Gerd mentioned this in the relevant bz:

        Note: root cause for the initrd issue noted in comment 5 is seabios
        running into problems with ehci -> io errors -> corrupted initrd.
        Sometimes it doesn't boot at all, probably in case the io errors
        happen to hit the kernel not the initrd.

This seems to be the last piece of information we have had that is closest
to the root cause.  I sincerely wished there's still some way to move
forward, as it looks really close, but it might be that it was just too
late for 2.6 so we didn't got time to keep looking back then.

Thanks,

-- 
Peter Xu


