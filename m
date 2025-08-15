Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD24CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 06:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umo2z-0002PI-3Z; Fri, 15 Aug 2025 02:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1umo2v-0002O2-LI
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 02:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1umo2r-0005YG-4F
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 02:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755239765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CQ7u8ptFVYEeGxObkw79wV/aZgWqhIMf01aobj6ObJY=;
 b=V3y3ULyrdu2JutBByOKk8WT/enqkyvZfT8YuDpx58HnP7GeM+BNNQ17n2d18DdLDY0HU6Z
 rfldAq5uJnf7jg6nCX6ZEsRU9rioeQ9KfJaVvFaO+Rr/rE5ha3TivQC3o8GBwcK2LZJjrW
 q2kJYb+2JBb30Pafv9xmCRUM5mw6r98=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-ikS531ELNfiZJeo_e8eZHQ-1; Fri, 15 Aug 2025 02:36:02 -0400
X-MC-Unique: ikS531ELNfiZJeo_e8eZHQ-1
X-Mimecast-MFC-AGG-ID: ikS531ELNfiZJeo_e8eZHQ_1755239762
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70a94f3bbdbso35565236d6.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 23:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755239762; x=1755844562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQ7u8ptFVYEeGxObkw79wV/aZgWqhIMf01aobj6ObJY=;
 b=nick3Vl9k8veGxXlQ6FZ1Hx5p3baLQC8PsJmnXKbYUFy7G57wQGAkWl4KIs5ac/3zH
 fdTQZLaa8Iv3vjD8Rj8NWNyxhLNmNAQV4Fum5YvbkdMq4tlaAJA+iyWfN8Ai0Zk3Vd/M
 8BFdlfmBvyicnRY2sps6//68kRMGc604qdiSHmtmRUwJjIQ3oN6HnrMwXqA0tLjgeHgC
 lvwDMz8VaNDpPjtxs1BmtO8ERlbKOdSWconJIi/nW1mXGOvSUPpU1ySF2QPA4z8LzIDf
 iCCF3WrWl/QAQiJnkUmlM+KzxslSgRxaS9Rp32283sb6Nt7BsqmXvRQ7hy47j2j858FU
 enQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNCGCO/xN8WL9HKfMS3cpyHRkCQEgwFGJA1VzNTC6wTR9wC/1kQ/bZ4lGiExWz8CgvGN2uSBAbXgmj@nongnu.org
X-Gm-Message-State: AOJu0YwEPBw4K1eDErcZ16q1qfdJmtrmWk48J6aLHuP9h/3bYMMAzYyo
 dd+czli5pP1yQ2FZyTOxOKI6cdmsr1WkKV2v5cFUKa5kiCQmFt/B7y5wt8fygUZS0qc0vpKPSVz
 lawJqnGGgkmcgmHxk8NHFYzPArpZTZdZYIKCk2fOm+QjfJw1Dcpx/9gA4
X-Gm-Gg: ASbGnctHFIcgYcONI27BHbfOmPCQYnFiNli4dHMA3qlKKHatoxQ9+qORIjg/xmE7mfd
 fqGLVhlKbdEGU2CR4s7VTD5+4Iltf0yY9VOCE0Rz3vS4O7+NOYxpAdHcKW6Oe6giNbJa12f9QKs
 xylG7AUx0cZkIN1dajmAMcDuvl2j6woyVkccyJx4Pw/M9fptKzVTc3aS/7atoNuMeG8XobqM/3C
 T8NOj8it3l+bXhGZsL5VXaJ4VE2+TrJcYRtCpTJSAxsoNBW7CgOFBRrdSt9QB3izE9ozoM7D2+t
 X+ADmBriUXa0FUH8/JjFQNn0TyS4wmtzm9aruzkcVDWt+2JGpe0OT+F4Zw==
X-Received: by 2002:a05:622a:292:b0:4aa:d487:594b with SMTP id
 d75a77b69052e-4b11e23d22amr9826111cf.35.1755239762119; 
 Thu, 14 Aug 2025 23:36:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCGOqGagId87ZwbY/DhdDX3wujhM7FQvObe4w0DB2k0nF6Thk/y/NBg0MRb0MQPWRYkM2ZeA==
X-Received: by 2002:a05:622a:292:b0:4aa:d487:594b with SMTP id
 d75a77b69052e-4b11e23d22amr9825961cf.35.1755239761739; 
 Thu, 14 Aug 2025 23:36:01 -0700 (PDT)
Received: from fedora (78-80-81-60.customers.tmcz.cz. [78.80.81.60])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b11dc188desm5034291cf.2.2025.08.14.23.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 23:36:00 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:35:57 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Jiri Denemark <jdenemar@redhat.com>, qemu-devel@nongnu.org, 
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 0/4] migration: Introduce postcopy-setup capability
 and state
Message-ID: <dmjzaklp5wclm2huqz6hxla4otwleuyigygkwl4d66x55fwse3@lrhj5wnifc6n>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <aJoEJhJw-_rGVBbA@x1.local>
 <xfzgjwld4ba7mymu3xhkxdwpeie7bbjnbei2xchkqncamktk3g@rbafrorlpvcv>
 <aJzOo7P8aA64AfY_@x1.local>
 <xbqqss2yshtjkew5cirlp2bx3dkumxg3grwpduol5ucpx3leqq@irqeo2csi2vg>
 <aJ43_JQct45mnVgV@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ43_JQct45mnVgV@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025-08-14 15:24, Peter Xu wrote:
> On Thu, Aug 14, 2025 at 05:42:23PM +0200, Juraj Marcin wrote:
> > Fair point, I'll then continue with the PING/PONG solution, the first
> > implementation I have seems to be working to resolve Issue 1.
> > 
> > For rarer split brain, we'll rely on block device locks/mgmt to resolve
> > and change the failure handling, so it registers errors from disk
> > activation.
> > 
> > As tested, there should be no problems with the destination
> > transitioning to POSTCOPY_PAUSED, since the VM was not started yet.
> > 
> > However, to prevent the source side from transitioning to
> > POSTCOPY_PAUSED, I think adding a new state is still the best option.
> > 
> > I tried keeping the migration states as they are now and just rely on an
> > attribute of MigrationState if 3rd PONG was received, however, this
> > collides with (at least) migrate_pause tests, that are waiting for
> > POSTCOPY_ACTIVE, and then pause the migration triggering the source to
> > resume. We could maybe work around it by waiting for the 3rd pong
> > instead, but I am not sure if it is possible from tests, or by not
> > resuming if migrate_pause command is executed?
> > 
> > I also tried extending the span of the DEVICE state, but some functions
> > behave differently depending on if they are in postcopy or not, using
> > the migration_in_postcopy() function, but adding the DEVICE there isn't
> > working either. And treating the DEVICE state sometimes as postcopy and
> > sometimes as not seems just too messy, if it would even be possible.
> 
> Yeah, it might indeed be a bit messy.
> 
> Is it possible to find a middle ground?  E.g. add postcopy-setup status,
> but without any new knob to enable it?  Just to describe the period of time
> where dest QEMU haven't started running but started loading device states.

Yes, as the ping/pong solution doesn't require any changes in the
protocol, there's no need for a new capability and the new state can be
always used.

> 
> The hope is libvirt (which, AFAIU, always enables the "events" capability)
> can ignore the new postcopy-setup status transition, then maybe we can also
> introduce the postcopy-setup and make it always appear.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 


