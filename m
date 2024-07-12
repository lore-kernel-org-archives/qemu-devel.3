Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A165C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 10:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSDUR-0002fB-E5; Fri, 12 Jul 2024 06:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSDUP-0002eg-Kb
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 06:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSDUJ-0008HB-Hd
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 06:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720780009;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7SBrVYMbpoYop2XL8KvojFExx2GCzkWdy+mgJn0rbI=;
 b=WAJoDlsgrqPMc1hbNTMDxWhvXbxVapMSmciKf62kbAXx4zmHvvqzxex6gVtH3baU7wAyL4
 Yc/EvqOEwIsaNocHMnbPL0WsrzZU6cJS+DAjvZpCvMMxCDwxF/6YdeymVZJj0NRaB5hakS
 bMKi6CeBrxEQJIZ8FSRO13U4kKsb7FM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-BUKAbBTMPzqWy1L-aREXFQ-1; Fri,
 12 Jul 2024 06:26:45 -0400
X-MC-Unique: BUKAbBTMPzqWy1L-aREXFQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDD631955F30; Fri, 12 Jul 2024 10:26:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E9881955E70; Fri, 12 Jul 2024 10:26:40 +0000 (UTC)
Date: Fri, 12 Jul 2024 11:26:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 4/8] tests/pytest: add pytest to the meson build system
Message-ID: <ZpEE3Cs7gpw631Iw@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-5-thuth@redhat.com>
 <ZpDw0CiRvN_DvJqe@redhat.com>
 <154a3249-b99e-4f93-bc45-0f34d08c1c6a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <154a3249-b99e-4f93-bc45-0f34d08c1c6a@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jul 12, 2024 at 12:14:45PM +0200, Thomas Huth wrote:
> On 12/07/2024 11.01, Daniel P. Berrangé wrote:
> > On Thu, Jul 11, 2024 at 01:55:42PM +0200, Thomas Huth wrote:
> > > From: Ani Sinha <ani@anisinha.ca>
> > > 
> > > Integrate the pytest framework with the meson build system. This
> > > will make meson run all the pytests under the pytest directory.
> > 
> > Lets add a note about the compelling benefit of this new approach
> > 
> >    With this change, each functional test becomes subject
> >    to an individual execution timeout, defaulting to 60
> >    seconds, but overridable per-test.
> 
> The avocado runner uses timeouts, too, so it's not really an additional
> benefit that we get here.

At the meson level though, we can't put an overall cap on
the execution time, as there's only 1 huge test visible,
and thus the meson timeout multiplier also won't get
honoured IIUC.

> 
> > For CI purposes we'll need to add 'python3-pytest' to
> > tests/lcitool/projects/qemu.yml, and re-generate the
> > the dockerfiles. Some of the other non-gitlab CI
> > integrations probably need manual additions of pytest
> > packages.
> 
> I'm currently rather looking into getting rid of pytest and to use pycotap
> instead: Using the TAP protocol for running the tests, you get a much nicer
> output from the meson test runner, which can then count the subtests and
> properly report SKIPs for tests that have not been run.
> 
> > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > index d39d5dd6a4..68151717d7 100644
> > > --- a/tests/Makefile.include
> > > +++ b/tests/Makefile.include
> > > @@ -3,12 +3,14 @@
> > >   .PHONY: check-help
> > >   check-help:
> > >   	@echo "Regression testing targets:"
> > > -	@echo " $(MAKE) check                  Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
> > > +	@echo " $(MAKE) check                  Run block, qapi-schema, unit, softfloat, qtest, pytest and decodetree tests"
> > >   	@echo " $(MAKE) bench                  Run speed tests"
> > >   	@echo
> > >   	@echo "Individual test suites:"
> > >   	@echo " $(MAKE) check-qtest-TARGET     Run qtest tests for given target"
> > >   	@echo " $(MAKE) check-qtest            Run qtest tests"
> > > +	@echo " $(MAKE) check-pytest           Run pytest tests"
> > > +	@echo " $(MAKE) check-pytest-TARGET    Run pytest for a given target"
> > 
> > Or name it after the type of test rather than harness ?
> > 
> >   eg  check-functional / check-functional-TARGET
> > 
> > For that matter perhaps also for the dir name ?
> > 
> >     tests/functional/*.py
> 
> I almost expected that discussion again ... (see
> https://lists.gnu.org/archive/html/qemu-devel/2021-05/msg06553.html ) ...
> last time we couldn't really agree on such a name and decided to go with the
> name of the framework...
> 
> I agree that "pytest" is likely not the best name here, especially if
> switching to the pycotap test runner instead of using the "pytest" program,
> but "functional" might trigger the same discussion again as last time ...
> should it rather be "functional" or "validation" or "integration" etc.?

IMHO you can just make an executive decision and pick one of those
three. None of them are terrible, any would be a valid choice.

> Maybe best if we come up with a new fictional name for the "new" test
> framework... something like "pyqe" - PYthon-based Qemu test Environment"?
> ... could be considered as a play on the word "pike", too, i.e. something
> that makes sure that not everything gets in ... ? WDYT?

A wierd acronym isn't really going to tell contributors anything about
what this is, compared to calling it 'functional' or 'integration', etc.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


