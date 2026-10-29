Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD4606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CKlFuw8q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTzq-00012V-IQ; Thu, 29 Oct 2026 13:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMTzp-00012N-Pk
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMTzl-0002Ih-W2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793295175;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DO9J5VhftwD966XqAn3gp9+yQW7Fd5cuIYVt9j0p9Is=;
 b=CKlFuw8q/5XJJWr6jnvY3pE7BtlYecpTVoMYP+2LzcFHum+ngBOlrHcKfeXCl4259ElwEb
 CHnVr1yE+dy25Dmt+C69uBus5BEFxyVoy4H+eyJXtQM9M6okom7nuQBpDDr+4/6vvvwZ2y
 RrMKt48VK8ItX39uu0sYg7kFLbXRyC0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-xLNDQG7AO5y0Ydn9_2mq5Q-1; Thu,
 29 Oct 2026 13:32:52 -0400
X-MC-Unique: xLNDQG7AO5y0Ydn9_2mq5Q-1
X-Mimecast-MFC-AGG-ID: xLNDQG7AO5y0Ydn9_2mq5Q_1793295170
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 668D01956069; Thu, 29 Oct 2026 17:32:50 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5A631955F08; Thu, 29 Oct 2026 17:32:47 +0000 (UTC)
Date: Thu, 29 Oct 2026 17:32:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 00/21] system: introduce a live data recorder facility
Message-ID: <auODPFwxQ0Bc0oi-@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
 <179206655287.744241.865023521920859070.b4-review@b4>
 <atDHwThz_5XPY9Yx@redhat.com>
 <CAMxuvayG8mPvVSagb6EyEH-hhA094qw3LPUWdeL_PJ5qeEk3=g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvayG8mPvVSagb6EyEH-hhA094qw3LPUWdeL_PJ5qeEk3=g@mail.gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 16, 2026 at 11:20:11AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Oct 15, 2026 at 4:32 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, Oct 15, 2026 at 04:15:52PM +0400, marcandre.lureau@redhat.com wrote:
> > > > This series introduces a new facility called 'tldr' which is a
> > > > live data recorder. This is intended to aid support of production
> > > > QEMU deployments, by providing a data collection facility that
> > > > can be left "always on", such that in the event of a QEMU crash
> > > > or guest OS crash, certain important information will be recorded.
> > > >
> > > > The data recorder has to be enabled by adding a "tldr-config"
> > > > object instance with -object / object_add.
> > > >
> > > > With this series, the data recorder collects
> > > >
> > > >  * error_report/warn_report/error_printf messages
> > > >  * QMP events
> > >
> > > It should probably be recorded at emission, not per monitor
> >
> > Opps.
> >
> > > >  * QMP errors
> > > >  * QMP commands, which are not query-XXX/qom-list,
> > > >    or any command associated with a QMP error.
> > > >  * qemu_log output
> > > >
> > > > The last item is intended primarily to be used in combination
> > > > with tracing and its 'log' backend, to have continuous
> > > > recording of certain interesting probes.
> > > >
> > > > Each type of data is collected in a distinct circular
> > > > buffer, such that high volumes of one type of data, does
> > > > not result in overwriting other types of low volume data.
> > > >
> > > > The data recorder is set to trigger on SIGBUS, SIGSEGV,
> > > > SIGILL, SIGFPE and SIGABRT, or manually via QMP 'tldr-dump'.
> > >
> > > Instead of allocating and dumping by a signal handler, why not use a file-backed
> > > mmap or a memfd? We would need to define a small fixed header for the file
> > > layout/buckets.  This would avoid all the issues with signal handlers.
> >
> > That would impose a continuous I/O workload on data recording, which
> > is something I wanted to explicitly avoid, until the time the data is
> 
> Yes, a file-backed mapping shouldn't be the default, but memfd/tmpfs
> should have the same performance.
> 
> > needed to be preserved. This only persists the final data, not any
> > intermediate data that is overwritten as the circular buffer wraps.
> 
> Same design, the reader would handle the ring data
> 
> > Coupling the in-memory layout to the on-disk layout also means that
> > dumps would always be the max size, since we would not have grow-on
> > demand buffers.
> 
> The dump output would not be the raw data, a reader would emit the
> same text format, skipping the unused parts.

IMHO that reader has to be QEMU owned code, as otherwise we're
exposing a private data structure to a 3rd party and that makes
it public ABI/API which is highly undesirable for this.

> mapping reserves address space only, pages are allocated on first write.
> 
> The benefits:
> - no signal handler, no conflict with MCE, ASAN etc

A signal handler is integral to some extent, as captured info about
the signal is itself is an important part of the data record. IOW,
even if moving writing of the dump out of the signal handler in some
manner, I still want to be able to capture several siginfo_t fields.

You can get that info from a core dump, but the working premise
is that a core dump is not guaranteed available, whereas the data
record dumps are something we can more easily acquire.

> - data survives SIGKILL, OOM, or a crash in the dump path itself

Simplifying the signal handler to just stash the siginfo_t would
help.

> - data can be read from a hung QEMU

Data can always be read from a hung QEMU by sending it a signal.
We could wire up a non-fatal signal for this purpose if we want
to read hung QEMUs without killing them.

> Someone needs to hold the memfd to outlive QEMU, otherwise QEMU could
> create a file under a runtime dir on tmpfs

I wonder if QEMU could simply fork a child process itself that just
hangs around waiting for death, and has a shared memory region with
the main QEMU.

We already have a '-run-with async-teardown' comamnd line, which
forks a child process and uses prctl(PR_SET_PDEATHSIG) to get
notified with the parent goes away.  We could expand that child
process to also handle crash dump writing.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


