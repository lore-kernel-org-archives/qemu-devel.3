Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8D606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cQ8SDkYZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2Om-00005e-Q1; Wed, 28 Oct 2026 08:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xM2Ok-000053-Hm
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xM2Oi-0007Ep-8B
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793189089;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zect9sFuS8TiT9GDaR5PLrtYRW9vSR2DcxfVWz560II=;
 b=cQ8SDkYZyXB3Xjlzw2pdKhX+ItbTfAOaAUaZzWbSqLBXvt6N0wc5hC9DfJ0fA7+JIWp8Qh
 yJ7s0S36C66nBtTjaZSMGfuYuvHra/HPSIOKWLGI/3D/LuPU2M+XuAwstR0jD0m9nKJbe9
 EP1XTKePz1U2YO0DrnvAGWaJjNm3mZQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-5hqsDSCvP_Wm9od5T2LHTg-1; Wed,
 28 Oct 2026 08:04:46 -0400
X-MC-Unique: 5hqsDSCvP_Wm9od5T2LHTg-1
X-Mimecast-MFC-AGG-ID: 5hqsDSCvP_Wm9od5T2LHTg_1793189085
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB04C18052D5; Wed, 28 Oct 2026 12:04:44 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D18930002CB; Wed, 28 Oct 2026 12:04:42 +0000 (UTC)
Date: Wed, 28 Oct 2026 12:04:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PULL 51/59] system: Remove deprecated 'debug-threads' option
 for -name
Message-ID: <auHk1xWE-SXnCrPD@redhat.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
 <20261027192341.9197-52-philmd@oss.qualcomm.com>
 <0dab848f-426e-49af-a28e-8165591b9d03@linaro.org>
 <e84af371-8fce-466c-9df6-c74863c127a4@oss.qualcomm.com>
 <auHEv-AQmulcwaad@redhat.com>
 <auHidAzj6lX3Y0CN@zhexu-thinkpadt14gen5.rmtcaon.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auHidAzj6lX3Y0CN@zhexu-thinkpadt14gen5.rmtcaon.csb>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 07:54:28AM -0400, Peter Xu wrote:
> On Wed, Oct 28, 2026 at 09:47:43AM +0000, Daniel P. Berrangé wrote:
> > On Wed, Oct 28, 2026 at 08:32:20AM +0100, Philippe Mathieu-Daudé wrote:
> > > (Cc'ing migration compat and libvirt teams)
> > > 
> > > On 28/10/26 02:01, Richard Henderson wrote:
> > > > On 10/27/26 14:23, Philippe Mathieu-Daudé wrote:
> > > > > 'debug-threads' option for -name was deprecated in v11.0
> > > > > (commit 1b65aeed2a0 "system: unconditionally enable thread
> > > > > naming") thus can now be removed.
> > > > > 
> > > > > Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> > > > > Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> > > > > Reviewed-by: Ján Tomko<jtomko@redhat.com>
> > > > > Reviewed-by: Dr. David Alan Gilbert<dave@treblig.org>
> > > > > Message-Id:<20261018232917.7716-1-philmd@oss.qualcomm.com>
> > > > > ---
> > > > >   docs/about/deprecated.rst             |  7 -------
> > > > >   docs/about/removed-features.rst       |  9 +++++++--
> > > > >   system/vl.c                           | 11 -----------
> > > > >   tests/qtest/migration/framework.c     |  4 ++--
> > > > >   tests/qtest/migration/precopy-tests.c |  2 +-
> > > > >   qemu-options.hx                       |  7 +++----
> > > > >   6 files changed, 13 insertions(+), 27 deletions(-)
> > > > 
> > > > You need to remove this from the testsuite as well:
> > > > 
> > > > https://gitlab.com/qemu-project/qemu/-/jobs/17523155796#L58
> > > 
> > > Hmm I was surprised because the pipeline in my fork passed, but then
> > > looking clearer this job is marked as "allow_failure: true" for me,
> > > why is it blocking on the mainstream repo?
> > 
> > It isn't blocking on upstream repo, it is allow_failure: true there
> > too. Manual inspection of the job shows it is a real bug though.
> > 
> > > Back to the test, this is the migration-compat-x86_64 job running
> > > previous release binary vs latest one, so I'd think this is the
> > > expected behavior, v11.0 and v11.1 have that deprecated option, and
> > > we can not test vs v11.2 which removed it.
> > > 
> > > If we want to change that workflow, then when deprecating on v11.0
> > > we also need to remove the tests coverage, so when we remove the
> > > feature at $deprecation_release+2 the migration-compat test does not
> > > break. Here the question is, do we want to keep testing deprecated
> > > features? Maybe yes in the case of unmaintained area when the
> > > deprecation process triggers new maintainers stepping in and the
> > > deprecation to be cancelled.
> > > 
> > > We could also mark the feature removed but keep it ignored and
> > > undocumented until the next release but we'll likely forget and
> > > miss that in workflow so I don't recommend that way.
> > > 
> > > Maybe there are another ways to resolve that but I'm not seeing
> > > them. Ideas?
> > 
> > 'debug-threads=on' has no relationship to live migration data
> > stream, it merely gives the threads names. Just remove this
> > option from the migration testsuite as it is irrelevant to
> > what is being tested.
> 
> We're testing with the old migration-test for compat, so Phil doesn't have
> an easy way to remove that part:
> 
> .migration-compat-common:
>     ...
>     # Use the migration-tests from the older QEMU tree. This avoids
>     # testing an old QEMU against new features/tests that it is not
>     # compatible with.
>     - cd build-previous
> 
> Intentional to avoid new things not working with old QEMU binaries, but
> then this will be the case things break if we don't have protection of
> 2-release deprecation (where we could have removed the usage in test cases
> 2 releases in advance too when deprecating).
> 
> At least two options I see: (1) for this release, we lose compat
> protection, we'll need to manually guard it, or (2) we provide some way to
> script/patch on top of the build-previous/ build before it builds, in this
> case we only need to remove the string in that test alone.

Or (3) push a change to -stable branches to remove debug-threads usage
from old migration-test and use stable HEAD, not the tagged version.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


