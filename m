Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9728CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 08:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utMPn-0000MJ-Jr; Tue, 02 Sep 2025 04:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1utMPk-0000Lw-Nr
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 04:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1utMPh-0007sj-Oc
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 04:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756801845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tFh+qkPTgPpo75hisRfGaOJ/uhICc7aGmqHQZvdb3jk=;
 b=JhTCYoCdMOa4ufT+7HMxdEHeQ3IGNmteNPnE6a9FrvGBz0heiUiI8QQZMcF8Rp+zJYe+Cc
 JwrOVXEbUT4Bek1J/hHfhdpF+2hQa2t6DjEK6jfO53MEW3iGbgXbIVzpMhrVY3eOtiTNn0
 cy6sDsXDzGokc4hZn6qWxGP/xvTf0tI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-rhJJfPysNECdGdZ9veg65g-1; Tue, 02 Sep 2025 04:30:44 -0400
X-MC-Unique: rhJJfPysNECdGdZ9veg65g-1
X-Mimecast-MFC-AGG-ID: rhJJfPysNECdGdZ9veg65g_1756801843
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3cdd69ee330so2239240f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 01:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756801843; x=1757406643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFh+qkPTgPpo75hisRfGaOJ/uhICc7aGmqHQZvdb3jk=;
 b=jplgM8gYnYqgAZ1ympwGA3HRFSqUt3QjkIRaQ4EUnZwW9hraIADvQaudgbaYsjp+d5
 FaokheZmNgDly1m/vFO3qT2X6Ld+B1+VfsF9NnMjQg8fiRAK3Kr4KKxYfyTqwnu193/o
 UM/OtXSF9ESIFFr+ncyV2dC8BwUnxxTxuYIvSINK8Y2VW9bIWPyxnJWofvBG6Ycn1mtf
 qxk1OvjxpdIgWlA2tdkR3aTmS+IRvcTl8wMJIvuTDISz9Uog/YXXcn5nqKwC4teXy+g3
 0Haby/UWzdEip0qr8XzYjw+X+HcN+CPhXvCRhKXmraFqp2+/W0bG9CG/2ej81lxrT+9r
 vRgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLYy52JJKaqr1G5e7E9kc1YUbVPb3n2okufd4kATrSXuupMRNNKuJtOw/DJfG+XZGYcV5EzGnjF9S5@nongnu.org
X-Gm-Message-State: AOJu0YwgF7w0h/mnaV8iziA2idSJ+2jKCAQNZPd4Svv/a1FAGdEXnqHe
 Zei1hchqVi6fXQxsVwYu6tSxVkxKBzhIjwjhuiAAOtJcd/cwWqnDVlpXLsMRfbj67F5zoaHJUMA
 WeAZZL5l3wZhS0kYoseKm0nIU1upquDXq/XksFsR7S98WV/ebksivwMi7
X-Gm-Gg: ASbGncuGj62wigJymKSHuAAIAjVgqMvAt2iEqLz/wBPlRUj5i3wjQOtM5gdde8Qbi00
 pP9wyCGuSjDkg0RE2mkJUYm9/QSLenpY0X+0cgu0TJppLDEciMUyX5Aczd6hNSkub+zOtoYUpiV
 5/uFG4o8p+xeRfQc1TGBF82odrKssklieM340HXRG95KpCiy1yJOprYIbkvJE/z3K+xQCsclAWx
 Dtfm87Hgmoj7KCD8GUTJImZExjVYSG4aeVI+NLQVq/98rNdLJ1TtAXsHmVSzLLspjJcemkJUV2a
 Y9czOlnBGb/TmC1CC0SC1fYIWWcm6PolGCVPYclsZ1dxp7H+vuMFI07CDQ==
X-Received: by 2002:a05:6000:1a8c:b0:3cd:96bb:b948 with SMTP id
 ffacd0b85a97d-3d1df15a131mr7905736f8f.47.1756801843034; 
 Tue, 02 Sep 2025 01:30:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdUQh5eCTJD+TIOQzJAZHMojyFTZP86YQH349Lh58VrosU5d4/BNocoPXI72iyyCk+bdnVXA==
X-Received: by 2002:a05:6000:1a8c:b0:3cd:96bb:b948 with SMTP id
 ffacd0b85a97d-3d1df15a131mr7905705f8f.47.1756801842530; 
 Tue, 02 Sep 2025 01:30:42 -0700 (PDT)
Received: from fedora (78-80-81-60.customers.tmcz.cz. [78.80.81.60])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf8a64fce8sm18397821f8f.34.2025.09.02.01.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 01:30:42 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:30:39 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, 
 qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 0/4] migration: Introduce postcopy-setup capability
 and state
Message-ID: <w6qkokuof6ge2gwajhcwul5boaqf57w6m4yzsbyljpgpnigc64@pw2unqceumjn>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <aJoEJhJw-_rGVBbA@x1.local>
 <xfzgjwld4ba7mymu3xhkxdwpeie7bbjnbei2xchkqncamktk3g@rbafrorlpvcv>
 <aJzOo7P8aA64AfY_@x1.local>
 <xbqqss2yshtjkew5cirlp2bx3dkumxg3grwpduol5ucpx3leqq@irqeo2csi2vg>
 <aJ43_JQct45mnVgV@x1.local> <aLXehgy3S5G6A3ub@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLXehgy3S5G6A3ub@gallifrey>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Dave,

On 2025-09-01 17:57, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Thu, Aug 14, 2025 at 05:42:23PM +0200, Juraj Marcin wrote:
> > > Fair point, I'll then continue with the PING/PONG solution, the first
> > > implementation I have seems to be working to resolve Issue 1.
> > > 
> > > For rarer split brain, we'll rely on block device locks/mgmt to resolve
> > > and change the failure handling, so it registers errors from disk
> > > activation.
> > > 
> > > As tested, there should be no problems with the destination
> > > transitioning to POSTCOPY_PAUSED, since the VM was not started yet.
> > > 
> > > However, to prevent the source side from transitioning to
> > > POSTCOPY_PAUSED, I think adding a new state is still the best option.
> > > 
> > > I tried keeping the migration states as they are now and just rely on an
> > > attribute of MigrationState if 3rd PONG was received, however, this
> > > collides with (at least) migrate_pause tests, that are waiting for
> > > POSTCOPY_ACTIVE, and then pause the migration triggering the source to
> > > resume. We could maybe work around it by waiting for the 3rd pong
> > > instead, but I am not sure if it is possible from tests, or by not
> > > resuming if migrate_pause command is executed?
> > > 
> > > I also tried extending the span of the DEVICE state, but some functions
> > > behave differently depending on if they are in postcopy or not, using
> > > the migration_in_postcopy() function, but adding the DEVICE there isn't
> > > working either. And treating the DEVICE state sometimes as postcopy and
> > > sometimes as not seems just too messy, if it would even be possible.
> > 
> > Yeah, it might indeed be a bit messy.
> > 
> > Is it possible to find a middle ground?  E.g. add postcopy-setup status,
> > but without any new knob to enable it?  Just to describe the period of time
> > where dest QEMU haven't started running but started loading device states.
> > 
> > The hope is libvirt (which, AFAIU, always enables the "events" capability)
> > can ignore the new postcopy-setup status transition, then maybe we can also
> > introduce the postcopy-setup and make it always appear.
> 
> When the destination is started with '-S' (autostart=false), which is what
> I think libvirt does, doesn't management only start the destination
> after a certain useful event?
> In other words, is there an event we already emit to say that the destination
> has finished loading the postcopy devices, or could we just add that
> event, so that management could just wait for that before issuing
> the continue?

I am not aware of any such event on the destination side. When postcopy
(and its switchower) starts, the destination transitions from ACTIVE
directly to POSTCOPY_ACTIVE in the listen thread while devices are
loaded concurrently by the main thread.

There is DEVICE state on the source side, but that is used only on the
source side when device state is being collected. When device state is
being loaded on the destination, the source side is also already in
POSTCOPY_ACTIVE state.

Best regards,

Juraj Marcin

> 
> Dave
> 
> > Thanks,
> > 
> > -- 
> > Peter Xu
> > 
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 


