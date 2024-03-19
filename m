Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBD0C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 19:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmf5q-000151-Qf; Tue, 19 Mar 2024 15:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmf5n-00014F-8i
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmf5l-00069Y-5F
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710876343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xc4jid4owSQ6Oa6jkXAb8nVmZAq7P3L/Qc5U7Ks48Y=;
 b=d4qXFEyc9YrIVMIZcxGuVepaevVcFH+GNX3coLhpXSyU2f8pROOFVcCJ5y8sWRGTVMuUT4
 Bwzz2iYHAT/9INuqi9+f7Ftg85xWE0c1sdr+dPujrH/nqwF52V5Ie5+l39WRJC/85dfsby
 i1kJd/jUYHQeUKc9gPDYU92Y3FKTei0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-PAhyEQspOCW7QpVYMuUIpg-1; Tue, 19 Mar 2024 15:25:42 -0400
X-MC-Unique: PAhyEQspOCW7QpVYMuUIpg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-60a03d166d7so11038667b3.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 12:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710876322; x=1711481122;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9xc4jid4owSQ6Oa6jkXAb8nVmZAq7P3L/Qc5U7Ks48Y=;
 b=oCWknRPIb58Wr+BHtU11+2YXa1IZu5Lf93eX9ioGMoWARhfqKRMYaTlkXWNAcR28y1
 6iC0AGhZlP/ykoto13j9a+4Rt93vzGxJPH/cAo+tQHHJjE4UMZwL89HjQHs3QXrmsY6F
 nBNq3XyYYB8X3cKaevQWCcHPC/8RsZSrPHK7ZVQjVh2+7x73nOqaC/oeO259p0Ugraz8
 gMTBuyysgevFQuVSDl3JeqaYyuCe0xQgfLCEefD9sQWTHfHY9mACqGsNG9/8O8LOnyds
 Rc3QIE7kYbOrMAPnWDRNnUKmf959S/8TCfw+ilvCUWgnw+md4E7RIqZrD2ifEYXaeF6s
 69XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZaWMemS6ZWgkGBqWHyU3mVarve6UhWfUbmGOpEonYh/fYiW9T/idEVPYuEKWNZpyRR40ZwJSrYTXvIbLJNgVPIG+2TuI=
X-Gm-Message-State: AOJu0Yw3ynfRYIAz8zDWprGF2JuCpknMtbpWlqlMcUHmNkuOdjR2qpsA
 153ogXXYmjYanOVz1Sp4Wk4yh/UtE5WR/JpGWCKhQU6DKS/s7YOo8ahitP8l2FU94blhCLjnkee
 aW5L0eXcqOo+ub/5/258E1Nsn+YCHKPT/0y9F3YBSmqLveZhroOEV
X-Received: by 2002:a0d:d708:0:b0:610:e756:ffde with SMTP id
 z8-20020a0dd708000000b00610e756ffdemr1870130ywd.3.1710876321719; 
 Tue, 19 Mar 2024 12:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwP9+28RegU1+x4Oca7fdrl7uORrYA+4VJTCfP/KmipRcYN146XoPdYIxMo8eUD/k8fbAeTA==
X-Received: by 2002:a0d:d708:0:b0:610:e756:ffde with SMTP id
 z8-20020a0dd708000000b00610e756ffdemr1870111ywd.3.1710876321128; 
 Tue, 19 Mar 2024 12:25:21 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ff16-20020a05622a4d9000b00430cacfe532sm3239934qtb.79.2024.03.19.12.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 12:25:20 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:25:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH v3 3/3] migration: Add fd to FileMigrationArgs
Message-ID: <Zfnmni5bZ7q_UQcx@x1n>
References: <20240315032040.7974-1-farosas@suse.de>
 <20240315032040.7974-4-farosas@suse.de>
 <ZfQNDv--4BnN5zYx@redhat.com> <ZfRxwml7m0DQVO2b@x1n>
 <87y1aj74t6.fsf@suse.de> <ZfS1g8YvZ7if9j5M@x1n>
 <Zfm8fCqyNMfkq9Jw@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zfm8fCqyNMfkq9Jw@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On Tue, Mar 19, 2024 at 04:25:32PM +0000, Daniel P. Berrangé wrote:
> On Fri, Mar 15, 2024 at 04:54:27PM -0400, Peter Xu wrote:
> > On Fri, Mar 15, 2024 at 03:01:09PM -0300, Fabiano Rosas wrote:
> > > Peter Xu <peterx@redhat.com> writes:
> > > 
> > > > [I queued patch 1-2 into -stable, leaving this patch for further
> > > >  discussions]
> > > >
> > > > On Fri, Mar 15, 2024 at 08:55:42AM +0000, Daniel P. Berrangé wrote:
> > > >> The 'file:' protocol eventually calls into qemu_open, and this
> > > >> transparently allows for FD passing using /dev/fdset/NNN syntax
> > > >> to pass in FDs. 
> > > >
> > > > If it always use /dev/fdsets for files, does it mean that the newly added
> > > > SOCKET_ADDRESS_TYPE_FD support on mapped-ram will never be used (so we can
> > > > drop them)?
> > > 
> > > We already have SOCKET_ADDRESS_TYPE_FD + file since 8.2 when the
> > > MigrationAddress was added. So this:
> > > 
> > > 'channels': [ { 'channel-type': 'main',
> > >                 'addr': { 'transport': 'socket',
> > >                 'type': 'fd',
> > >                 'str': 'fdname' } } ]
> > > 
> > > works without multifd and without mapped-ram if the fd is a file or
> > > socket.
> > > 
> > > So yes, you're correct, but given we already have this^ it would be
> > > perhaps more confusing for users to allow it, but not allow the very
> > > same JSON when multifd=true, mapped-ram=true.
> > 
> > I don't think the fd: protocol (no matter the old "fd:", or the new JSON
> > format) is trivial to use. If libvirt didn't use it I won't be surprised to
> > see nobody using it.  I want us to avoid working on things that nobody is
> > using, or has a better replacement.
> > 
> > So even if Libvirt supports both, I'm wondering whether /dev/fdset/ works
> > for all the cases that libvirt needs.  I am aware that the old getfd has
> > the monitor limitation so that if the QMP disconnected and reconnect, the
> > fd can be gone.  However I'm not sure whether that's the only reason to
> > have add-fd, and also not sure whether it means add-fd is always preferred,
> > so that maybe we can consider obsolete getfd?
> 
> Historically libvirt primariily uses the 'fd:' protocol, with a
> socket FD. It never gives QEMU a plain file FD, since it has
> always added its "iohelper" as a MITM, in order to add O_DIRECT
> on top.
> 
> The 'getfd' command is something that is needed when talking to
> QEMU for any API that involves a "SocketAddress" QAPI type,
> which is applicable for migration.
> 
> With the introduction of 'MigrationAddress', the 'socket' protocol
> is backed by 'SocketAddress' and thus supports FD passing for
> sockets (or potentally pipes too), in combination with 'getfd'.
> 
> With the 'file' protocol in 'MigrationAddress', since it gets
> backed by qemu_open(), then /dev/fdset/NN and 'add-fd' provide
> passing for plain files.

I see.  I assume it means we still have multiple users of getfd so it's
still in use where add-fd is not yet avaiable.

But then, SOCKET_ADDRESS_TYPE_FD is then not used for libvirt in the whole
mapped-ram effort, neither do we need any support on file migrations over
"fd", e.g. fd_start_incoming_migration() for files. So we can drop these
parts, am I right?

Thanks,

-- 
Peter Xu


