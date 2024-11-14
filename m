Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCF0D6A228
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf9A-0000rF-07; Thu, 14 Nov 2024 14:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBf95-0000pW-5V
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:04:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBf91-0004rA-Cj
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731611075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9DGLeFnfYlfnL8X6Xp15IxmQ14tej1WYYffFTO/joeI=;
 b=ip/LIjOtuTY3A1U8gyClu8J57mO606QOEjwEJuT8xeD0hsm5tgKnbS05oqCvl34DHWV17Y
 3xiLqhxxQHH3iewqW/RpYQyW0UpeGpdDEsSSkMe+d8IcYqB7vHzDlaORNpCD9z1d4BBG7K
 GpwVddOxKkYm4hVCIh9FW1vz9YTBhkI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-UubDUDUpMmCq2ohCbNQNhA-1; Thu, 14 Nov 2024 14:04:34 -0500
X-MC-Unique: UubDUDUpMmCq2ohCbNQNhA-1
X-Mimecast-MFC-AGG-ID: UubDUDUpMmCq2ohCbNQNhA
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83b6628a71fso92117339f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731611073; x=1732215873;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9DGLeFnfYlfnL8X6Xp15IxmQ14tej1WYYffFTO/joeI=;
 b=M+j4QuUnGLE/ZvxJSXHIo3EDScBlwz3lqqwzHHljHM9C0nULcTKiKAQXFYghVuR8d/
 3I+x/70S1HBxfim9IuX7bWb9RedsWs5Z4V9yDaMtZce7zQNr9fDhfRRYWcsmbDViyFLQ
 XWaCeijQuxUK6LSGXEfpzGpHCx3nRA4b2pNdmQCQWUv+BcIHxsxY+h5/Cv51bIz0dsSE
 VvstqoYtNO4rX9chn1MDgfqGXAYATsi6t6A/azUYfsJ5WJgb5R02dTLOgPQhTgYug598
 LZ/8cAduMNs2vxfILHh+CgEsoTKun//SlKgZK+T8GysX1VkBQpyKJkHWALAYqyabGxhb
 PvSg==
X-Gm-Message-State: AOJu0YwlH/+ZBIIJ6XqGg6XSsUrxuv/EZexU1FnHH/xltgEjrcwKQYmP
 bdUOFGtxR1T0cUx8lAr07kbQ/p9t3vkNnFJ1b2OpCYKuxA0Uvk+dWfMIhASCJPXF6ryGIrrlXVm
 4e/WRVG/Qp/nIYlSgz6hc1fm0N9ISoN+PRNULkTjhcZ6WpaWjm3bT
X-Received: by 2002:a92:c245:0:b0:3a7:4700:7c1 with SMTP id
 e9e14a558f8ab-3a7470009f9mr1990675ab.12.1731611072958; 
 Thu, 14 Nov 2024 11:04:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9ArCs1Ij7io/DxI6HbGyyj3xvf+q45RajmiNwA07LUDizcryF3L1dK1C8TCIZVGf8d5yfWw==
X-Received: by 2002:a92:c245:0:b0:3a7:4700:7c1 with SMTP id
 e9e14a558f8ab-3a7470009f9mr1990365ab.12.1731611072603; 
 Thu, 14 Nov 2024 11:04:32 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e02fd14876sm390640173.100.2024.11.14.11.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 11:04:31 -0800 (PST)
Date: Thu, 14 Nov 2024 14:04:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
Message-ID: <ZzZJvTldpe3D4EO5@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
 <ZzUg9w0Kvfuleuxk@x1n>
 <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 14, 2024 at 01:36:00PM -0500, Steven Sistare wrote:
> On 11/13/2024 4:58 PM, Peter Xu wrote:
> > On Fri, Nov 01, 2024 at 06:47:50AM -0700, Steve Sistare wrote:
> > > Add the cpr-transfer migration mode.  Usage:
> > >    qemu-system-$arch -machine anon-alloc=memfd ...
> > > 
> > >    start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"
> > > 
> > >    Issue commands to old QEMU:
> > >    migrate_set_parameter mode cpr-transfer
> > >    migrate_set_parameter cpr-uri <uri-2>
> > >    migrate -d <uri-1>
> > 
> > QMP command "migrate" already allows taking MigrationChannel lists, cpr can
> > be the 2nd supported channel besides "main".
> > 
> > I apologize on only noticing this until now.. I wished the incoming side
> > can do the same already (which also takes 'MigrationChannel') if monitors
> > init can be moved earlier, and if precreate worked out.  If not, we should
> > still consider doing that on source, because cpr-uri isn't usable on dest
> > anyway.. so they need to be treated separately even now.
> > 
> > Then after we make the monitor code run earlier in the future we could
> > introduce that to incoming side too, obsoleting -cpr-uri there.
> 
> I have already been shot down on precreate and monitors init, so we are
> left with specifying a "cpr" channel on the outgoing side, and -cpr-uri
> on the incoming side.  That will confuse users, will require more implementation
> and specification work than you perhaps realize to explain this to users,

What is the specification work?  Can you elaborate?

> and only gets us halfway to your desired end point of specifying everything
> using channels.  I don't like that plan!
> 
> If we ever get the ability to open the monitor early, then we can implement
> a complete and clean solution using channels and declare the other options
> obsolete.

The sender side doesn't need to wait for destination side to be ready?
Dest side isn't a reason to me on how we should make sender side work if
they're totally separate anyway.  Dest requires -cpr-uri because we don't
yet have a choice.

Is the only concern about code changes?  I'm expecting this change is far
less controversial comparing to many others in this series, even if I
confess that may still contain some diff. They should hopefully be
straightforward, unlike many of the changes elsewhere in the series.

If you prefer not writting that patch, I am OK, and I can write one patch
on top of your series after it lands if that is OK for you. I still want to
have this there when release 10.0 if I didn't misunderstood anything, so
I'll be able to remove cpr-uri directly in that patch too.

-- 
Peter Xu


