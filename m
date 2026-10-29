Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883AF606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PyQfaJfO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMU6Y-0002TT-B6; Thu, 29 Oct 2026 13:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMU6R-0002TF-No
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMU6N-0002x8-Bq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793295586;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSAGoBpTxZNKdh7UlT4O7N5GtiG0beI2H0ayKi0e05Q=;
 b=PyQfaJfO3JLXDwOkOSWSnH49jxLd3yud04UGQHEopWXfGeBErM2X8JxHf96opKxHwzweZE
 KQ0Kys8L+6d3jwXhoOYU/clHaFGpAILWX2etrzSeOwNAmMZp8OK+Fsl+l4CjpwCboLXyHs
 /Hq3vL6rWCDdIodIfMCOuFb7R3GRywo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-rujL-2wFMzuVn6RIO5QhnA-1; Thu,
 29 Oct 2026 13:39:44 -0400
X-MC-Unique: rujL-2wFMzuVn6RIO5QhnA-1
X-Mimecast-MFC-AGG-ID: rujL-2wFMzuVn6RIO5QhnA_1793295583
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A662180074A; Thu, 29 Oct 2026 17:39:43 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DECA6472; Thu, 29 Oct 2026 17:39:39 +0000 (UTC)
Date: Thu, 29 Oct 2026 17:39:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 00/21] system: introduce a live data recorder facility
Message-ID: <auOE2HzQ_o1sq4d5@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
 <e965c91e-cf92-4647-bc18-d10ad39e2025@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e965c91e-cf92-4647-bc18-d10ad39e2025@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 15, 2026 at 10:34:14AM -0700, Pierrick Bouvier wrote:
> Hi Daniel,
> 
> On 10/15/2026 4:20 AM, Daniel P. Berrangé wrote:
> > This series introduces a new facility called 'tldr' which is a
> > live data recorder. This is intended to aid support of production
> > QEMU deployments, by providing a data collection facility that
> > can be left "always on", such that in the event of a QEMU crash
> > or guest OS crash, certain important information will be recorded.
> > 
> > The data recorder has to be enabled by adding a "tldr-config"
> > object instance with -object / object_add.
> > 
> > With this series, the data recorder collects
> > 
> >  * error_report/warn_report/error_printf messages
> >  * QMP events
> >  * QMP errors
> >  * QMP commands, which are not query-XXX/qom-list,
> >    or any command associated with a QMP error.
> >  * qemu_log output
> > 
> > The last item is intended primarily to be used in combination
> > with tracing and its 'log' backend, to have continuous
> > recording of certain interesting probes.
> > 
> > Each type of data is collected in a distinct circular
> > buffer, such that high volumes of one type of data, does
> > not result in overwriting other types of low volume data.
> > 
> > The data recorder is set to trigger on SIGBUS, SIGSEGV,
> > SIGILL, SIGFPE and SIGABRT, or manually via QMP 'tldr-dump'.
> > 
> > There is a open question in one of the patches about SIGBUS
> > handling, since that is already used for MCE capture and I'm
> > unclear if I'm breaking something about KVM MCE reporting.
> > 
> > This series proposes using sigaltstack() to register an
> > alternative signal handling stack. This would mainly be
> > useful if we have a crash from a stack overflow, but the
> > cost is that we have 8k extra per thread, and I'm not
> > entirely convinced that's a beneficial tradeoff. Might
> > be better to just accept stack overflows as a risk.
> > 
> > This series only captures text based info, but as a followup
> > I would like to extend this to capture statistics data from
> > relevant subsystems. For example, the BlockBackend has its
> > own "always on" stats accounting code, which can be queried
> > with QMP. Ideally I would like to figure out a way to dump
> > all the BlockBackend stats in the data recorder output.
> > Likewise perhaps capture NIC stats and/or KVM stats in an
> > "always on" manner for some interesting baseline dataset.
> > The challenge with that is making it safe to access the
> > stats data without taking any mutex locks, since this must
> > run from a signal handler.
> > 
> > A typical recommended usage would be:
> > 
> >  $QEMU  -object tldr-config,id=tldr
> >         -d tldr
> >         -trace events=/var/lib/libvirt/qemu/trace.txt
> > 
> > This leaves dumps to go to QEMU's stderr on crash, but
> > to send them to a file
> > 
> >    -object tldr-config,id=tldr,crash-target=/some/path
> > 
> > The '-d tldr' flag redirects qemu_log() to the TLDR buffer
> > instead of stdout, and the '-trace events' arg defines
> > the "always on" tracepoints we want to capture.
> >
> 
> if I understand correctly, the goal of this new object is to provide a
> per-topic rotating log in memory that will be flushed on disk only when
> we have a specific event (exit, or any signal). That's sounds like a
> good idea!
> 
> Why not refactor exisiting trace/log and provide the same feature
> directly there? This would be transparent, and user could decide to
> either dump the full file (same than before) or benefit from rotating
> memory buffered, with any custom size.
> 
> $QEMU -d category,size=4M -trace events=out,max-size=16M

The data recorder is intended to report more than just textual
log messages. This series already captures signal info, and  as
noted in the cover letter will also be extended to capture
structured data items such as performance statistics. The text
based messages are just the simple first step.

That said I'll think about whether the split of responsibilities
should adjust so that some of the logic is exposed more broadly
into the log system.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


