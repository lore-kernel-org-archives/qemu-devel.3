Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EB4C3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSElF-0008KI-90; Fri, 12 Jul 2024 07:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSElB-00087D-Vj
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSEl2-00088h-A9
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720784888;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVZgy3pOxSWpddguKCwoPdV59HT6yV4tr25+emgHKPw=;
 b=eRVP6KnlOBEmaawANzeJYZl47ZDRkKDyskC5aW4JB3q8avVTJMqwEKKsXZr9eEK8CspQIN
 /SG9DQE+/W2lq+HGl5uoTszBElCH7shIWOVy3jog9AwTuGlyVegefiOB53eVBapS1sk23p
 62OEJ/CPxST2Dj2LWWh+OO6bhrJONP8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-GKMZ3ymNPGWfoIZZq5ha3A-1; Fri,
 12 Jul 2024 07:48:07 -0400
X-MC-Unique: GKMZ3ymNPGWfoIZZq5ha3A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6463192DE3E; Fri, 12 Jul 2024 11:48:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 603FF19560AE; Fri, 12 Jul 2024 11:48:02 +0000 (UTC)
Date: Fri, 12 Jul 2024 12:47:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 4/8] tests/pytest: add pytest to the meson build system
Message-ID: <ZpEX7sMLODBuiMBk@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

I've just looked at pycotap and IIUC, there's no command line
tool equivalent to '/usr/bin/pytest' at all. Each test case
is expected to provide a stub for "__main__" to invoke the
tests. As such each individual test is directly executable.
This meshes nicely with what I'd suggested as changes in
patch 1, and eliminating the intermediate runner process is
a nice further simplification. So I'll be interested to see
your next version using pycotap.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


