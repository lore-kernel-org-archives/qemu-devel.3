Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCA5C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkoz9-00017m-P0; Thu, 14 Mar 2024 13:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkoz8-00017b-4A
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkoz6-0001g0-2h
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710437713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=69/+bFrXELODXnyboo96T3ImPDjanXqnbYwlxFlaJK4=;
 b=cLuirk67XDgsDpNwN+wm7AgpmPWaAwJIkgmzWJWmBy8wB6whgmaTJNcxrnN7ahf4/w2POF
 KCFR/2O8gxQYgwdISmxlm6jkf7lFlEzkqTdQ5XOf6f3HgsOo0dmW24WEQ4E9RCrKB+k3uM
 EIi9Kn8zwu2btoT/BPsP2NHcBVM/Xl0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-jPy4LVKSNlaw-YMNW-qPkw-1; Thu, 14 Mar 2024 13:35:12 -0400
X-MC-Unique: jPy4LVKSNlaw-YMNW-qPkw-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5a260237193so259094eaf.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 10:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710437711; x=1711042511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=69/+bFrXELODXnyboo96T3ImPDjanXqnbYwlxFlaJK4=;
 b=IBj0B7XaboQg8YXPiGic79o1Lm2EsCfHKrOGSMVsgWLGe2Km/03Ydccd/bn/npxKnR
 61RsRzO9TOZwy6ixYIP4zDQj2JwebzZPCktx9QSU4BRzdU/qIOYHg39VLVDU/OxoKCiR
 isrPpCJSKnHVAIvheSbct3RzM1SLwOO+ECqQRDHtLaW9vGqC39ej5MTLhTD0eOCmY36b
 3Si1dEtJ+KZBZXPYCJdgdSZqdPuI705UBb7Co3TSqRR2r5KmkBPo0Bk9iipmUNuk0Yqk
 kpCrt/eoRyti7zVkivBx0Srs24dTtkuuhb1TTGVHLrHgzhi29+ltM4STBH1kK48i7s/J
 PE3Q==
X-Gm-Message-State: AOJu0YzBytYH4o+X/J9qhi+ruaeqeeemzIagPwnB8O5T1mI3Nk3eeDfv
 FjmWmkyAGtBcVxqfZJO6ZTVMo6UgxaaZ2NWvhD3i3KkAoNQsmy2hlvSbbw3ncwgxAae2DLNHm3l
 7YazwW+RXv2wTo69dluuceKSqnoVO67idYPBJM721FbNhrArlPRVu
X-Received: by 2002:a05:6820:d02:b0:5a4:5630:93d6 with SMTP id
 ej2-20020a0568200d0200b005a4563093d6mr2394596oob.1.1710437711218; 
 Thu, 14 Mar 2024 10:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOcZ5F1VHVgNf7zbd9PUsmbHfazJldkF+/se5Xb88PpbkT16fK4zLl/9J6p2zVfBaxw+MLxA==
X-Received: by 2002:a05:6820:d02:b0:5a4:5630:93d6 with SMTP id
 ej2-20020a0568200d0200b005a4563093d6mr2394580oob.1.1710437710817; 
 Thu, 14 Mar 2024 10:35:10 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ed6-20020ad44ea6000000b0068fa5e5c245sm716272qvb.84.2024.03.14.10.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 10:35:10 -0700 (PDT)
Date: Thu, 14 Mar 2024 13:35:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/2] migration mapped-ram fixes
Message-ID: <ZfM1TXP87Jw2jZBT@x1n>
References: <20240313212824.16974-1-farosas@suse.de> <ZfMWRBDN4wPQsOWI@x1n>
 <87plvwvjlo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plvwvjlo.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Mar 14, 2024 at 01:55:31PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Mar 13, 2024 at 06:28:22PM -0300, Fabiano Rosas wrote:
> >> Hi,
> >> 
> >> In this v2:
> >> 
> >> patch 1 - The fix for the ioc leaks, now including the main channel
> >> 
> >> patch 2 - A fix for an fd: migration case I thought I had written code
> >>           for, but obviously didn't.
> >
> > Maybe I found one more issue.. I'm looking at fd_start_outgoing_migration().
> >
> >     ioc = qio_channel_new_fd(fd, errp);  <----- here the fd is consumed and
> >                                                 then owned by the IOC
> >     if (!ioc) {
> >         close(fd);
> >         return;
> >     }
> >
> >     outgoing_args.fd = fd;               <----- here we use the fd again,
> >                                                 and "owned" by outgoing_args
> >                                                 even if it shouldn't?
> >
> > The problem is outgoing_args.fd will be cleaned up with a close().  I had a
> > feeling that it's possible it will close() something else if the fd reused
> > before that close() but after the IOC's.  We may want yet another dup() for
> > outgoing_args.fd?
> 
> I think the right fix is to not close() it at
> fd_cleanup_outgoing_migration(). That fd is already owned by the ioc.

But outgoing_args.fd can point to other things if the IOC (along with the
ioc->fd) is released.  Keeping outgoing_args.fd pointing to that fd index
should be dangerous because the integer can be reused.

> 
> >
> > If you agree, we may also want to avoid doing:
> >
> >     outgoing_args.fd = -1;
> 
> We will always need this. This is just initialization of the field
> because 0 is a valid fd value. Otherwise the file.c code can't know if
> we're actually using an fd at all.

I meant avoid setting it to -1 only in fd_start_outgoing_migration().
Using -1 to represent "no fd" is fine.

> 
> @file_send_channel_create:
> 
> int fd = fd_args_get_fd();
> 
> if (fd && fd != -1) {
>     <new IOC from fd>
> } else {
>     <new IOC from file name>
> }
> 
> >
> > We could assert it instead making sure no fd leak.
> >
> >> 
> >> Thank you for your patience.
> >> 
> >> based-on: https://gitlab.com/peterx/qemu/-/commits/migration-stable
> >> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1212483701
> >> 
> >> Fabiano Rosas (2):
> >>   migration: Fix iocs leaks during file and fd migration
> >>   migration/multifd: Ensure we're not given a socket for file migration
> >> 
> >>  migration/fd.c   | 35 +++++++++++---------------
> >>  migration/file.c | 65 ++++++++++++++++++++++++++++++++----------------
> >>  migration/file.h |  1 +
> >>  3 files changed, 60 insertions(+), 41 deletions(-)
> >> 
> >> -- 
> >> 2.35.3
> >> 
> 

-- 
Peter Xu


