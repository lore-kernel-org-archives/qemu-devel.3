Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA32CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwz8y-0006Fn-IS; Fri, 12 Sep 2025 04:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwz8j-0006ED-Ou
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwz8a-0003M8-LU
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757665685;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVd8UnWkCDeuK0wEZLjFLChWez1p9pZgr7eRTJHPM5s=;
 b=Pj4zOLQoHWfcvjAwzt9K4UprvoN3TI3winpmtXK3JQUuf6oZZgt5mMT4UArHuSqBlOr2tM
 a7WBznlgq9HLTV+rClMWaufp9Hj6g6jIcHHy1xCUKRwZwzTAa1RvYdekL4137vR9mFlEeF
 93W3DyqdFyCtOGIoTGAR80G0dzcyOdg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-UdGMpRL_O3Wc_Wdpqp6hUg-1; Fri,
 12 Sep 2025 04:28:01 -0400
X-MC-Unique: UdGMpRL_O3Wc_Wdpqp6hUg-1
X-Mimecast-MFC-AGG-ID: UdGMpRL_O3Wc_Wdpqp6hUg_1757665680
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44F5C1953945; Fri, 12 Sep 2025 08:28:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 924471944CCA; Fri, 12 Sep 2025 08:27:55 +0000 (UTC)
Date: Fri, 12 Sep 2025 09:27:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Michael Roth <michael.roth@amd.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 0/8] Tracing patches
Message-ID: <aMPZhyHHKlV-5xGi@redhat.com>
References: <20250908140653.170707-1-stefanha@redhat.com>
 <CAFEAcA_jB-5wmRXUijcr_+hpto3huMZQnKzZA5rHFwS5ZWDSkw@mail.gmail.com>
 <CAJSP0QWumdKVQWknYQkXw_G18RJ93q_jrmPoUsDD-CN_B=PU-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QWumdKVQWknYQkXw_G18RJ93q_jrmPoUsDD-CN_B=PU-g@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 11, 2025 at 04:49:57PM -0400, Stefan Hajnoczi wrote:
> On Thu, Sep 11, 2025 at 7:40 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Mon, 8 Sept 2025 at 15:10, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > The following changes since commit 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8:
> > >
> > >   Merge tag 'pull-tcg-20250905' of https://gitlab.com/rth7680/qemu into staging (2025-09-05 09:51:27 +0200)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
> > >
> > > for you to fetch changes up to b91cbf4e691b397510584b04fd6197284f55b52c:
> > >
> > >   tracetool-test: allow to run in parallel (2025-09-08 09:48:10 -0400)
> > >
> > > ----------------------------------------------------------------
> > > Pull request
> > >
> > > Daniel Berrangé's tracetool test suite and Marc-André Lureau's test suite fix.
> > >
> > > ----------------------------------------------------------------
> >
> > I ran this as a combined merge test with a couple of other
> > pullreqs, but I'm assuming this one is the cause of this
> > msys2-64bit job failure:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/11318561687
> >
> > # [WinError 2] The system cannot find the file specified:
> > 'C:/GitLab-Runner/builds/qemu-project/qemu/build/tests/tracetooldmg99xan/dtrace.c'
> > not ok 1 - dtrace.c (set QEMU_TEST_REGENERATE=1 to recreate reference
> > output if tracetool generator was intentionally changed)
> > # [WinError 2] The system cannot find the file specified:
> > 'C:/GitLab-Runner/builds/qemu-project/qemu/build/tests/tracetooldmg99xan/dtrace.h'
> >
> > and other similar errors.
> 
> Hi Daniel,
> Looks like Windows is not happy with the new tracetool test suite.
> Please take a look at
> https://gitlab.com/qemu-project/qemu/-/jobs/11318561687.

Yep, will investigate and get back to you.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


