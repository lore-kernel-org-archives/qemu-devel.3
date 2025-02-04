Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CE4C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLlN-00043I-NC; Tue, 04 Feb 2025 11:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfLlM-000439-Ls
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:27:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfLlK-00028G-Ht
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738686416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YkRmWBY4iu90yJebV/B9r/1iCKRTGW8Frh7k2O5yXe0=;
 b=RcURGdIQWQ3xE7TL1c7Ug8v9HvCpjDBxnhG3j7RPTo4rw/lFKal5MXIdalX2z1V9u/G2hF
 HJVEVxDFFfMZ94CuA2GdQijBLC+oMNp7cw16ti/arV7AoprwU86gHSK1TQdS6U7UTr+jqh
 aBmRtpM9c/qtq+NIdg3aXrzgEaB/w6w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-MfH7Mb_INu-5l0jWkeX81Q-1; Tue, 04 Feb 2025 11:26:55 -0500
X-MC-Unique: MfH7Mb_INu-5l0jWkeX81Q-1
X-Mimecast-MFC-AGG-ID: MfH7Mb_INu-5l0jWkeX81Q
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6e5c9ef38so939431285a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 08:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738686414; x=1739291214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkRmWBY4iu90yJebV/B9r/1iCKRTGW8Frh7k2O5yXe0=;
 b=kYwNHaroCgudiGzGmAd0QVXR4S3oHeFfs6jPYo+cVoOQeHRtR/9TgTQe2cuv61IMrI
 eAB8Yo4CZwLZSvpcrPiYgJgobfZpcr807PLX0aH1TBNcdxBi6zH6NeNRR+/hOpso7PkY
 sKfm/uE+DpKVVTKa7qjrzJU6JepLjb1GrHmQ3RX2Cpy23c3YsLWSOcIfWcESijurNPC4
 lGs79Ngu/F1wOgIdOrK0ylrO6EPUjdV1HHEayAcwP2jkSTAV+z8N/KfZrB72ls76xchO
 VgXb0WDU5B0rb2MJpvw8HqQk8PzXS98TANvnUAicG/l9jBH04U0fQgpBu+uAhUZK7FOx
 pdBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5CcIK884B5mH/SSkedNmrD6GJnHCw1dxSGubsZSGdrndmKiXHdAxVitPqnXndzYyAS8PFt+iJggYk@nongnu.org
X-Gm-Message-State: AOJu0Yyo9lfIpq6MTL7G1yfmyfqg2BTTafoHh4THCZjnDFUY9nUZv7ld
 Kq4ZfTiNk2ektQ8LWLifxHzvkU2HYcK4F2I3vOFd8YG3x/hDQty7QoFR/JnyDSGkIxLzcItwTc2
 opIdO16hsdg1oTw8IfIDN5Ea+INCkRvrSryfOkWeaJw4qxxrcfOHkoy4qhT4w
X-Gm-Gg: ASbGncuWjWHjav4aGCeyIiXSCiFSuXr+vHA+YeWFOKYSiSYrN1wm4JL4d+YZIuyg2zW
 0sLcaXuv6iP6svp6AEA8lvL0p18OQSH9FhnxvEQpQzxHMDQWfUA3AHKac97Q9Cv69Z6zbJ9MR/H
 bpiuuyEIVHW5H7p7HfinZXqc7Y4OFutyYAwH9vCNr2oif26AWusvg5LkTHV5hy0FrokRbJr6HIu
 3CTkmny5IGkBvhM3H7mHivyZJmACj8P1+OpntubhZvVZIPaXviV2PzuZoegZthfZnJMUS1jCBI3
 hc3O7CBB6GBFZ0qmVKbjGYb2wefv2cDy5/Qcq+lzpU1pkgsX
X-Received: by 2002:a05:620a:2601:b0:7b6:d5b2:e58 with SMTP id
 af79cd13be357-7c02ec5c60emr680669985a.18.1738686414576; 
 Tue, 04 Feb 2025 08:26:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyc/OTn/mPJbUE+byY9nRx4Ox7i4uphGaFGCVWc4vD90wnnAG67+kRIlmTbUzaiaezjzjbuA==
X-Received: by 2002:a05:620a:2601:b0:7b6:d5b2:e58 with SMTP id
 af79cd13be357-7c02ec5c60emr680666985a.18.1738686414212; 
 Tue, 04 Feb 2025 08:26:54 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8bbac4sm652503885a.22.2025.02.04.08.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 08:26:53 -0800 (PST)
Date: Tue, 4 Feb 2025 11:26:52 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 17/42] migration: cpr-transfer mode
Message-ID: <Z6I_zJF1dljLK-YI@x1.local>
References: <20250129160059.6987-1-farosas@suse.de>
 <20250129160059.6987-18-farosas@suse.de>
 <CAFEAcA9q+QLJnyVZDAKLsB0i2iBohNwkTXmycpV5CUsWYWZmFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9q+QLJnyVZDAKLsB0i2iBohNwkTXmycpV5CUsWYWZmFw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Feb 04, 2025 at 01:40:34PM +0000, Peter Maydell wrote:
> On Wed, 29 Jan 2025 at 16:11, Fabiano Rosas <farosas@suse.de> wrote:
> >
> > From: Steve Sistare <steven.sistare@oracle.com>
> >
> > Add the cpr-transfer migration mode, which allows the user to transfer
> > a guest to a new QEMU instance on the same host with minimal guest pause
> > time, by preserving guest RAM in place, albeit with new virtual addresses
> > in new QEMU, and by preserving device file descriptors.  Pages that were
> > locked in memory for DMA in old QEMU remain locked in new QEMU, because the
> > descriptor of the device that locked them remains open.
> >
> > cpr-transfer preserves memory and devices descriptors by sending them to
> > new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
> > be sent over the normal migration channel, because devices and backends
> > are created prior to reading the channel, so this mode sends CPR state
> > over a second "cpr" migration channel.  New QEMU reads the cpr channel
> > prior to creating devices or backends.  The user specifies the cpr channel
> > in the channel arguments on the outgoing side, and in a second -incoming
> > command-line parameter on the incoming side.
> >
> > The user must start old QEMU with the the '-machine aux-ram-share=on' option,
> > which allows anonymous memory to be transferred in place to the new process
> > by transferring a memory descriptor for each ram block.  Memory-backend
> > objects must have the share=on attribute, but memory-backend-epc is not
> > supported.
> >
> > The user starts new QEMU on the same host as old QEMU, with command-line
> > arguments to create the same machine, plus the -incoming option for the
> > main migration channel, like normal live migration.  In addition, the user
> > adds a second -incoming option with channel type "cpr".  This CPR channel
> > must support file descriptor transfer with SCM_RIGHTS, i.e. it must be a
> > UNIX domain socket.
> >
> > To initiate CPR, the user issues a migrate command to old QEMU, adding
> > a second migration channel of type "cpr" in the channels argument.
> > Old QEMU stops the VM, saves state to the migration channels, and enters
> > the postmigrate state.  New QEMU mmap's memory descriptors, and execution
> > resumes.
> >
> > The implementation splits qmp_migrate into start and finish functions.
> > Start sends CPR state to new QEMU, which responds by closing the CPR
> > channel.  Old QEMU detects the HUP then calls finish, which connects the
> > main migration channel.
> >
> > In summary, the usage is:
> >
> >   qemu-system-$arch -machine aux-ram-share=on ...
> >
> >   start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
> >
> >   Issue commands to old QEMU:
> >     migrate_set_parameter mode cpr-transfer
> >
> >     {"execute": "migrate", ...
> >         {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
> >
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > Link: https://lore.kernel.org/r/1736967650-129648-17-git-send-email-steven.sistare@oracle.com
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> Hi; this commit includes some code that has confused
> Coverity (CID 1590980) and it also confused me, so maybe
> it could be usefully made clearer?
> 
> 
> >  void qmp_migrate(const char *uri, bool has_channels,
> >                   MigrationChannelList *channels, bool has_detach, bool detach,
> >                   bool has_resume, bool resume, Error **errp)
> > @@ -2056,6 +2118,7 @@ void qmp_migrate(const char *uri, bool has_channels,
> >      g_autoptr(MigrationChannel) channel = NULL;
> >      MigrationAddress *addr = NULL;
> >      MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
> > +    MigrationChannel *cpr_channel = NULL;
> >
> >      /*
> >       * Having preliminary checks for uri and channel
> > @@ -2076,6 +2139,7 @@ void qmp_migrate(const char *uri, bool has_channels,
> >              }
> >              channelv[type] = channels->value;
> >          }
> > +        cpr_channel = channelv[MIGRATION_CHANNEL_TYPE_CPR];
> >          addr = channelv[MIGRATION_CHANNEL_TYPE_MAIN]->addr;
> >          if (!addr) {
> >              error_setg(errp, "Channel list has no main entry");
> > @@ -2096,12 +2160,52 @@ void qmp_migrate(const char *uri, bool has_channels,
> >          return;
> >      }
> >
> > +    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
> > +        error_setg(errp, "missing 'cpr' migration channel");
> > +        return;
> > +    }
> 
> Here in qmp_migrate() we bail out if cpr_channel is NULL,
> provided that s->parameters.mode is MIG_MODE_CPR_TRANSFER...
> 
> > +
> >      resume_requested = has_resume && resume;
> >      if (!migrate_prepare(s, resume_requested, errp)) {
> >          /* Error detected, put into errp */
> >          return;
> >      }
> >
> > +    if (cpr_state_save(cpr_channel, &local_err)) {
> 
> ...but in cpr_state_save() when we decide whether to dereference
> cpr_channel or not, we aren't checking s->parameters.mode,
> we call migrate_mode() and check the result of that.
> And migrate_mode() isn't completely trivial: it calls
> cpr_get_incoming_mode(), so it's not obvious that it's
> necessarily going to be the same value as s->parameters.mode.
> So Coverity complains that it sees a code path where we
> might dereference cpr_channel even when it's NULL.
> 
> Could this be made a bit clearer somehow, do you think?

That migrate_mode() is indeed tricky, and should only be needed for
incoming side QEMU to workaround current limitation that the migration
parameter "mode" cannot be set as early as when cpr_state_load() happens..

I think we could check s->parameters.mode here before doing
cpr_state_save(), it can also be more readable.

Steve, do you want to send a patch?

-- 
Peter Xu


