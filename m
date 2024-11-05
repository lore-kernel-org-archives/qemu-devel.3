Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79866D2B920
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JAq-0007kj-BV; Tue, 05 Nov 2024 08:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8JAe-0007je-4U
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:00:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8JAY-0001d5-3s
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730811623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFKaAT6Xo/YEl+wjdQgg6sD+lLMrpdFD9ysXdXjNAtc=;
 b=YuhYuep795ZpoPJPXXEbPChTZVxqeQY0f5GC9FB4YrvrbfAMbsaRc0IPOoYvjPQ7WOR8I+
 aV8rQfGk9xMSbLC0kPN3iaUB9GApbR8wBdVlE/uVzy3GQ0qd9RA1xaYgd/dGZN4C3NN5qG
 /DV5C5REEVQhwCfMM/3nNfC1DYb7Ljc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-k3Jl9sHaNH2YvbvVHgm42g-1; Tue, 05 Nov 2024 08:00:19 -0500
X-MC-Unique: k3Jl9sHaNH2YvbvVHgm42g-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3e6587f103bso3404889b6e.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811619; x=1731416419;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFKaAT6Xo/YEl+wjdQgg6sD+lLMrpdFD9ysXdXjNAtc=;
 b=bca+wNv5H2jzbH4vr+SbqRt7EGYhfgSuJxSe3SFxoP1QCEa6PWPVjwZ4HLBHeWs6UK
 c0IooIN1QHrMzGubOf3mi+MHg1tUTZD0yMfAVzB13T1uMP3GySxYXeq3KPFKEpvzmWe/
 NNVG4/F2cd+3JlEy84T1BVoJGC7bat9McnnVXq9bF5NDVR6J1Xik0ydMu1knWQWS/cxH
 tRQWOf/1FaA+CjJWYcSHs9qgjVOUsaXpU3THlAmhFFaaBfCSw0E8G9U0WK4nrPRgB45C
 a26gDeIO66d+OCe5OJ4txk3axiJbZua54GEy6y3R2j5tFdhyiPAMd3Liry97kfMdBRLO
 I5Yg==
X-Gm-Message-State: AOJu0Yya6HI/InYd3ptMZ/ZT2tGJ3+kY9GDIkzF6STeqp/+U+X+9OpEw
 5e5aW66HuiLUnMmGGdOoIRM3P6/oAT9tuofV2hoC2QFv6fTO1TpiWkgnb4/LP9ni5YPWm6dZRz7
 D+21SNnu5mqy+KtjSBsDcXUc+6LwkeormbQy1/OzaXuWLOoU7Z9g7
X-Received: by 2002:a05:6808:2223:b0:3e5:f06f:653d with SMTP id
 5614622812f47-3e758c32581mr13942783b6e.22.1730811619013; 
 Tue, 05 Nov 2024 05:00:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2oQtPat45Fk4yMvb9zi8OYmuYiHWfexPRdMtXxuRmrsHjA+6WPG5ELTmwmboy+Y8D500yEA==
X-Received: by 2002:a05:6808:2223:b0:3e5:f06f:653d with SMTP id
 5614622812f47-3e758c32581mr13942737b6e.22.1730811618523; 
 Tue, 05 Nov 2024 05:00:18 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e6611a661dsm2485520b6e.14.2024.11.05.05.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 05:00:17 -0800 (PST)
Date: Tue, 5 Nov 2024 08:00:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
Message-ID: <ZyoW3ue3WTQ3Di1d@x1n>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com>
 <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 05, 2024 at 04:49:23PM +0530, Prasad Pandit wrote:
> On Mon, 4 Nov 2024 at 22:48, Peter Xu <peterx@redhat.com> wrote:
> > Firstly, we'll need a way to tell mgmt that the new qemu binary supports
> > enablement of both multifd + postcopy feature.  That can be done with a
> >
> >   "features": [ "postcopy-with-multifd-precopy" ]
> >
> > Flag attached to the QMP "migrate" command.
> 
> * IIUC, currently virsh(1)/libvirtd(8) sends the migration command to
> the destination to inform it of the migration features to use, whether
> to use multifd or postcopy or none etc. Based on that the destination
> QEMU prepares to accept incoming VM. Not sure how/what above flag
> shall benefit.

See:

https://www.qemu.org/docs/master/devel/qapi-code-gen.html

        Sometimes, the behaviour of QEMU changes compatibly, but without a
        change in the QMP syntax (usually by allowing values or operations
        that previously resulted in an error). QMP clients may still need
        to know whether the extension is available.

        For this purpose, a list of features can be specified for
        definitions, enumeration values, and struct members. Each feature
        list member can either be { 'name': STRING, '*if': COND }, or
        STRING, which is shorthand for { 'name': STRING }.

> 
> > Then, I think we don't need a magic for preempt channel, because new qemu
> > binaries (after 7.2) have no issue on out-of-order connections between main
> > / preempt channel.  Preempt channel is always connected later than main.
> >
> > It means in the test logic of "which channel is which", it should be:
> >
> >   - If it's a multifd channel (check multifd header match), it's a multifd
> >     channel, otherwise,
> >
> >     - if main channel is not present yet, it must be the main channel (and
> >       we can double check the main channel magic), otherwise,
> >
> >     - it's the preempt channel
> >
> > With that, I think we can drop the new magic sent here.
> 
> * Sending magic value on the postcopy channel only makes it consistent
> with other channels. There's no harm in sending it. Explicitly
> defining/sending the magic value is better than leaving it for the
> code/reader to figure it out. Is there a compelling reason to drop it?
> IMO, we should either define/send the magic value for all channels or
> none. Both ways are consistent. Defining it for few and not for others
> does not seem right.

It's a legacy issue as not all features are developed together, and that
was planned to be fixed together with handshake.  I think the handshake
could introduce one header on top to pair channels.

IMHO it is an overkill to add a feature now if it works even if tricky,
because it's not the 1st day it was tricky. And we're going to have another
header very soon..

Thanks,

-- 
Peter Xu


