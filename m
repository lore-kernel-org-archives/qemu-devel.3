Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD791C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfrv-0007M2-JX; Tue, 19 Mar 2024 16:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmfrt-0007FI-EX
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmfrr-0006fg-5q
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710879325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3Km3zthjTJ2X4w4a9sXT7ieqazOORF+q9x8wTj8Jsw=;
 b=i8Kv5nh08vfvJwNye3SH35Sg7R27+vgBjSftM9GPl046TZTGnpS5Jb8bVifZSirjHYD5ea
 hOSVDoTNfZMD+G139NW3ujNhSjr/wP2OGAWdv5TE+MVenG452si78dAYRo0uklgIBwgOtC
 Si1tsXRSC6arBqPBf2dhJqKOLogJ6W0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-B7FDdgerNcubVFEj1N8-1Q-1; Tue, 19 Mar 2024 16:15:23 -0400
X-MC-Unique: B7FDdgerNcubVFEj1N8-1Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-69120b349c9so15737436d6.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 13:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710879323; x=1711484123;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d3Km3zthjTJ2X4w4a9sXT7ieqazOORF+q9x8wTj8Jsw=;
 b=gt6nZo+J7OE12voh9eoAWLmqhuhetL9glRwh1iaqIZIhvHqawbuL/AFizunJ8aPqiW
 n2ftGwNewLmeTwwdfR4NtFuj+Oa3gw/8Erh/EfOg3EH3XdFpqcPLxumzwhJEuJ0kufmN
 QSoxB3YGGQ8/HaRk0fM65tcN36kJOpIvE9hvivV4HlUBBgYAAlNhj2pRLela63wVVV6A
 4AzdWUr06OKT+6hVGBDktJWmrtjdxa+N8cAchcNIfQ2iHdFTyrLXcPi5s8W8RjbL/hys
 dp7a4t5e9IpiKwcHRqslSogG+9aR2BWXdrlEaPIGFCgSjZsEXP9mpl/LfeJtcam6lMgQ
 emog==
X-Forwarded-Encrypted: i=1;
 AJvYcCURr5j33pU95hd7IE4feltECc/2l8yovnvM7vqwVyAanOrLa0Cklzl5OxuO+sVukHgsjOwkk6lEj54H/xkBrexo63Fcr2w=
X-Gm-Message-State: AOJu0YxMX8xnhs1/iNEeH0K14l6REYwUw1TexizOV5kMg0GB8oFVOcPA
 YIwuB6mMGb9tceJHHD0poZ5xIVNoROYyNN1fmnusrKVS62EsWVUIIZbQtj2raZ9dA402BBEfNN1
 RzunDYriiWdbUqEsBK5w75dpZvNVSTuVdfqamVWh3v3f/npzBdsZg
X-Received: by 2002:a05:6214:5409:b0:691:402f:510a with SMTP id
 ql9-20020a056214540900b00691402f510amr3789211qvb.0.1710879323322; 
 Tue, 19 Mar 2024 13:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ1RLSUMsM1bkTVj+gBNpcRtNoE2uqsH/ClYIiDPIle8ACMSil5qBehmfBPGWLnufsCjSJ/g==
X-Received: by 2002:a05:6214:5409:b0:691:402f:510a with SMTP id
 ql9-20020a056214540900b00691402f510amr3789184qvb.0.1710879322818; 
 Tue, 19 Mar 2024 13:15:22 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 iu10-20020ad45cca000000b006914cd7a8b1sm6847700qvb.48.2024.03.19.13.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 13:15:22 -0700 (PDT)
Date: Tue, 19 Mar 2024 16:15:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH v3 3/3] migration: Add fd to FileMigrationArgs
Message-ID: <ZfnyWHh1MWRKFaOH@x1n>
References: <20240315032040.7974-1-farosas@suse.de>
 <20240315032040.7974-4-farosas@suse.de>
 <ZfQNDv--4BnN5zYx@redhat.com> <ZfRxwml7m0DQVO2b@x1n>
 <87y1aj74t6.fsf@suse.de> <ZfS1g8YvZ7if9j5M@x1n>
 <Zfm8fCqyNMfkq9Jw@redhat.com> <Zfnmni5bZ7q_UQcx@x1n>
 <ZfntD00Mz3i9vOky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfntD00Mz3i9vOky@redhat.com>
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

On Tue, Mar 19, 2024 at 07:52:47PM +0000, Daniel P. Berrangé wrote:
> On Tue, Mar 19, 2024 at 03:25:18PM -0400, Peter Xu wrote:
> > On Tue, Mar 19, 2024 at 04:25:32PM +0000, Daniel P. Berrangé wrote:
> > > On Fri, Mar 15, 2024 at 04:54:27PM -0400, Peter Xu wrote:
> > > > On Fri, Mar 15, 2024 at 03:01:09PM -0300, Fabiano Rosas wrote:
> > > > > Peter Xu <peterx@redhat.com> writes:
> > > > > 
> > > > > > [I queued patch 1-2 into -stable, leaving this patch for further
> > > > > >  discussions]
> > > > > >
> > > > > > On Fri, Mar 15, 2024 at 08:55:42AM +0000, Daniel P. Berrangé wrote:
> > > > > >> The 'file:' protocol eventually calls into qemu_open, and this
> > > > > >> transparently allows for FD passing using /dev/fdset/NNN syntax
> > > > > >> to pass in FDs. 
> > > > > >
> > > > > > If it always use /dev/fdsets for files, does it mean that the newly added
> > > > > > SOCKET_ADDRESS_TYPE_FD support on mapped-ram will never be used (so we can
> > > > > > drop them)?
> > > > > 
> > > > > We already have SOCKET_ADDRESS_TYPE_FD + file since 8.2 when the
> > > > > MigrationAddress was added. So this:
> > > > > 
> > > > > 'channels': [ { 'channel-type': 'main',
> > > > >                 'addr': { 'transport': 'socket',
> > > > >                 'type': 'fd',
> > > > >                 'str': 'fdname' } } ]
> > > > > 
> > > > > works without multifd and without mapped-ram if the fd is a file or
> > > > > socket.
> > > > > 
> > > > > So yes, you're correct, but given we already have this^ it would be
> > > > > perhaps more confusing for users to allow it, but not allow the very
> > > > > same JSON when multifd=true, mapped-ram=true.
> > > > 
> > > > I don't think the fd: protocol (no matter the old "fd:", or the new JSON
> > > > format) is trivial to use. If libvirt didn't use it I won't be surprised to
> > > > see nobody using it.  I want us to avoid working on things that nobody is
> > > > using, or has a better replacement.
> > > > 
> > > > So even if Libvirt supports both, I'm wondering whether /dev/fdset/ works
> > > > for all the cases that libvirt needs.  I am aware that the old getfd has
> > > > the monitor limitation so that if the QMP disconnected and reconnect, the
> > > > fd can be gone.  However I'm not sure whether that's the only reason to
> > > > have add-fd, and also not sure whether it means add-fd is always preferred,
> > > > so that maybe we can consider obsolete getfd?
> > > 
> > > Historically libvirt primariily uses the 'fd:' protocol, with a
> > > socket FD. It never gives QEMU a plain file FD, since it has
> > > always added its "iohelper" as a MITM, in order to add O_DIRECT
> > > on top.
> > > 
> > > The 'getfd' command is something that is needed when talking to
> > > QEMU for any API that involves a "SocketAddress" QAPI type,
> > > which is applicable for migration.
> > > 
> > > With the introduction of 'MigrationAddress', the 'socket' protocol
> > > is backed by 'SocketAddress' and thus supports FD passing for
> > > sockets (or potentally pipes too), in combination with 'getfd'.
> > > 
> > > With the 'file' protocol in 'MigrationAddress', since it gets
> > > backed by qemu_open(), then /dev/fdset/NN and 'add-fd' provide
> > > passing for plain files.
> > 
> > I see.  I assume it means we still have multiple users of getfd so it's
> > still in use where add-fd is not yet avaiable.
> > 
> > But then, SOCKET_ADDRESS_TYPE_FD is then not used for libvirt in the whole
> > mapped-ram effort, neither do we need any support on file migrations over
> > "fd", e.g. fd_start_incoming_migration() for files. So we can drop these
> > parts, am I right?
> 
> Correct, libvirt hasn't got any impl for 'mapped-ram' yet, at least
> not something merged.
> 
> Since this is new functionality, libvirt could go straight for the
> 'file' protocol / address type.
> 
> At some point I think we can stop using 'fd' for traditional migration
> too and pass the socket address to QEMU and let QEMU open the socket.

Thanks for confirming this, that sounds good.  I quickly discussed this
with Fabiano just now, I think there's a plan we start to mark fd migration
deprecated for the next release (9.1), then there is a chance we drop it in
migration for 9.3.  That'll copy libvirt list so we can re-check there.

Fabiano will then prepare patches to remove the "fd:" support on file
migrations; that will be for 9.0.

Thanks,

-- 
Peter Xu


