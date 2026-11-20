Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E9606A32A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJ8vyF4K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xURL8-0003E5-Ro; Fri, 20 Nov 2026 11:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xURL4-0003Dc-K3
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:19:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xURL2-0000Fg-Qq
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795191587;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+dxrruj7qYl+jA1UH/oLRafbrQv4O3MNoHOI40ZwGAo=;
 b=WJ8vyF4K/T4srdcqxJHnIu7zYKe8LKO2JFABjzlYNRm8w7DTsnPBcYrBwq0rrnPvqUVDXL
 4amn0W6KRKafadslRfGqKI7jtyG48jwfMiBbaWeVxBhCxbop71+BbOWPPe8tINt19X64p/
 O5nnQXpnCdN+H7kzadrwKRBNB7ysUVE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-f0shbSDDNRyR6bSRRxPW9g-1; Fri,
 20 Nov 2026 16:19:42 +0000
X-MC-Unique: f0shbSDDNRyR6bSRRxPW9g-1
X-Mimecast-MFC-AGG-ID: f0shbSDDNRyR6bSRRxPW9g_1795191581
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC6221955BEF; Fri, 20 Nov 2026 16:19:40 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 662A31956049; Fri, 20 Nov 2026 16:19:38 +0000 (UTC)
Date: Fri, 20 Nov 2026 16:19:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH 02/10] oslib: add qemu_debugger_attached()
Message-ID: <awBzF9i3fo1KRGMk@redhat.com>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-3-den@openvz.org>
 <CAFEAcA-Bc_Lev19s7=UjokZKjxTgDkZRYO-hbPMexj9BXqs2xQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Bc_Lev19s7=UjokZKjxTgDkZRYO-hbPMexj9BXqs2xQ@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Tue, Nov 17, 2026 at 02:38:44PM +0000, Peter Maydell wrote:
> On Tue, 15 Sept 2026 at 21:36, Denis V. Lunev <den@openvz.org> wrote:
> >
> > From: Denis V. Lunev <den@openvz.org>
> >
> > Code that watches for a hang has to tell a hang apart from a debugger
> > stop, because under a debugger every thread stops and whatever liveness
> > signal the watcher samples stops changing with them.
> >
> > Linux reports the tracer in /proc/self/status and Windows has
> > IsDebuggerPresent(). Answer false elsewhere, which leaves the caller
> > behaving as it did before the check.
> >
> > Match the Linux field at the start of a line. The Name: line holds
> > fifteen characters of comm, enough to spell the field name and appear
> > ahead of the real one.
> 
> Should we have a mechanism for the user to force this to
> claim "no debugger present" ? You might want to debug the
> watchdog mechanism itself, for instance, or maybe you're
> running QEMU under something that looks like a debugger or
> process tracer but which isn't going to do user-controlled
> "stop for arbitrary time" (e.g. does the record-and-replay
> tool "rr" appear as a tracer for these purposes?)

"strace" is going to be detected as a debugger this way, but it does
not  halt execution of the program, merely slow it down a bit.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


