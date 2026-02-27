Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BA6FD7F97
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 11:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvw2O-0004eb-33; Fri, 27 Feb 2026 06:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvw2M-0004e5-0u
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:29:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvw2J-0003OK-0j
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772191772;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfZY2aehSx8argFLHd+h4HKZh8oWTRZqwG/c4OqsHv8=;
 b=IFWSfULEAfUouVLPize3wZFeCR07X+KjQKrf+bRCr2noaomrzIcdmFu/h7io7rL/Pkylx4
 +4LyLv+pjl0cDkkXBAAzXhTwljjwCzbM5AyrYijUiKHjsvWKYkaVJgMnlkA1nL8CVIu4do
 9nZWdVVG93WzVM2wYJeNn6MlcUxD4xg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607--kaB2tUBM2-YAtxjxwScHg-1; Fri,
 27 Feb 2026 06:29:28 -0500
X-MC-Unique: -kaB2tUBM2-YAtxjxwScHg-1
X-Mimecast-MFC-AGG-ID: -kaB2tUBM2-YAtxjxwScHg_1772191768
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC33A1800615; Fri, 27 Feb 2026 11:29:27 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.85])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C666E1800297; Fri, 27 Feb 2026 11:29:24 +0000 (UTC)
Date: Fri, 27 Feb 2026 11:29:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 2/4] python: replace avocado tests with pytest
Message-ID: <aaGAEFmarpoe0g-O@redhat.com>
References: <20260225192808.957477-1-jsnow@redhat.com>
 <20260225192808.957477-3-jsnow@redhat.com>
 <aaBYBfryWrYRMT2G@redhat.com>
 <CAFn=p-YsiOiBy0VRdbXS0=PFtWkj_OzaMz+QPeku294=17mHXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-YsiOiBy0VRdbXS0=PFtWkj_OzaMz+QPeku294=17mHXg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Thu, Feb 26, 2026 at 12:51:46PM -0500, John Snow wrote:
> On Thu, Feb 26, 2026 at 9:26 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Feb 25, 2026 at 02:28:06PM -0500, John Snow wrote:
> > > Following suit with the rest of this repository, drop avocado and
> > > replace it with the Python standard "pytest" package.
> > >
> > > In this case, we do not truly need pytest as all we are using it for is
> > > running other python processes formerly launched by shell scripts, but
> > > this matches how the standalone python-qemu-qmp package does things,
> > > which keeps things simple on my end.
> >
> > From the POV of QEMU we don't really want 'pytest' in the loop
> > any more than we want avocado. The desire is for "meson" to be
> > the test harness.
> >
> > If this use of a pytest is just a temporary stepping stone
> > towards fully integrating with meson, then that's acceptable
> > but lets note that this is a temporary solution in the commit
> > message.
> 
> Admittedly I wasn't thinking about just using meson directly, so I
> suppose this *is* just a stepping stone. My only question for meson
> integration is how can I set up the deps so that "make check" will try
> to install the linting deps and run the python tests, but skips these
> tests if we are offline and don't have the deps. i.e. "try to run
> these tests, but don't error out if we can't"
> 
> Hazarding a guess: make the python tests depend on a linter group, add
> a custom target for that linter group, allow failure in that custom
> target (how?), then configure the individual meson test cases to skip
> if the deps are not present.
> 
> (Guess I'll go look at your older series and see how you handled this...)

I didn't handle the complexity of venvs in my old series. IIRC I just
blindly used the host python tools, since it was just PoC quality not
a mergable series.

When doing it for real, we'd end up wanting a selection of different
meson suites. Perhaps a default suite using the same python version
as meson itself, for integration in 'make check' and a set of extra
suites, one per python venv target for SPEED=thorough.

If --disable-download was given and the host tools for the linters
were missing we would have to skip the tests in 'make check', but
with SPEED=thorough we could auto-download everything.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


