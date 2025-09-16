Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A33CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQtN-0004mT-Nm; Tue, 16 Sep 2025 04:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyQtI-0004bZ-W9
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyQtF-00048e-70
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758010693;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7AWTmib5mN1EOk7e63FiKsVri4qwmkD86mB7UV/mwYs=;
 b=a2AujgKTo/dMtESrdnFAolKqMcviDpLjd1L4pHIHs6g5WCfM/Y+merm1JSVktlq6tnf33k
 aNIuuU1GHoMDiGqphJc9U/UQsd9hMW2uOaWY4DYYYwQTVZPI5klg34Xts6eR+iHLw4s8IU
 GILrrv8AoLBY+4tYiOrG/vycsA1VXtA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-W7j9yYxPMAmF4JOJPr3unQ-1; Tue,
 16 Sep 2025 04:18:08 -0400
X-MC-Unique: W7j9yYxPMAmF4JOJPr3unQ-1
X-Mimecast-MFC-AGG-ID: W7j9yYxPMAmF4JOJPr3unQ_1758010686
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18E661800378; Tue, 16 Sep 2025 08:18:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1C561955F79; Tue, 16 Sep 2025 08:18:00 +0000 (UTC)
Date: Tue, 16 Sep 2025 09:17:57 +0100
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
Message-ID: <aMkdNbA3MJ8gTs-8@redhat.com>
References: <20250908140653.170707-1-stefanha@redhat.com>
 <CAFEAcA_jB-5wmRXUijcr_+hpto3huMZQnKzZA5rHFwS5ZWDSkw@mail.gmail.com>
 <CAJSP0QWumdKVQWknYQkXw_G18RJ93q_jrmPoUsDD-CN_B=PU-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QWumdKVQWknYQkXw_G18RJ93q_jrmPoUsDD-CN_B=PU-g@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It was unhappy with spawning child processes on Windows for reasons
that I've been unable to diagnose. Since the purpose of the test is
simply to match the generated code output  against reference output,
I decided to just disable it on Windows, and sent a v5 wit that.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


