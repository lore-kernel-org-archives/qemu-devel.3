Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B21C3ABA9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hKm-00045Y-Bw; Tue, 29 Apr 2025 05:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9hKY-0003rZ-Qk
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:32:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9hKV-0006iY-7r
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745919162;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hc1YMhjquorGUWGRw7AUO/HtnYYROIkN2NEfvlbSnco=;
 b=QpzV83NfGKTdYn4uRsKQyEFzzeZBLJ9a4MwUqztLfJgA8YqAGFl4EnBpXuwo9KfAZ3PMSY
 x0cgLvGSVYVepGJOmtBDkd9aTv9gC0YEc6pCuTYMDoRmKfhMN9djAi4H7wyCblj0DiVv5I
 WkN6mgiOs4wRMAEFZ8JH7h6h9twZ3v8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-9yQRYAxoPqyUAIcyDNVK6A-1; Tue,
 29 Apr 2025 05:32:38 -0400
X-MC-Unique: 9yQRYAxoPqyUAIcyDNVK6A-1
X-Mimecast-MFC-AGG-ID: 9yQRYAxoPqyUAIcyDNVK6A_1745919157
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 081131956094; Tue, 29 Apr 2025 09:32:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.98])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A07491956096; Tue, 29 Apr 2025 09:32:32 +0000 (UTC)
Date: Tue, 29 Apr 2025 10:32:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, jsnow@redhat.com, philmd@linaro.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Message-ID: <aBCcrJxQTOFKoeJQ@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org> <aA9ChuXrkmx1Igy5@angien.pipo.sk>
 <8734dswnm3.fsf@pond.sub.org>
 <2cc27344-8cfd-4435-9d41-79b86f61d537@linaro.org>
 <875xinnzok.fsf@pond.sub.org>
 <3024f643-f4df-4342-8d9f-d5929e3ec2e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3024f643-f4df-4342-8d9f-d5929e3ec2e5@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Apr 29, 2025 at 11:20:59AM +0200, Thomas Huth via Devel wrote:
> On 29/04/2025 10.23, Markus Armbruster wrote:
> ...
> > I don't wish to derail this thread, but we've been dancing around the
> > question of how to best fix the target for some time.  I think we should
> > talk about it for real.
> > 
> > Mind, this is not an objection to your larger "single binary" idea.  It
> > could be only if it was an intractable problem, but I don't think it is.
> > 
> > You want the single binary you're trying to create to be a drop-in
> > replacement for per-target binaries.
> > 
> > "Drop-in replacement" means existing usage continues to work.
> > Additional interfaces are not a problem.
> > 
> > To achieve "drop-in replacement", the target needs to be fixed
> > automatically, and before the management application can further
> > interact with it.
> > 
> > If I understand you correctly, you're proposing to use argv[0] for that,
> > roughly like this: assume it's qemu-system-<target>, extract <target>
> > first thing in main(), done.
> > 
> > What if it's not named that way?  If I understand you correctly, you're
> > proposing to fall back to a compiled-in default target.
> > 
> > I don't think this is going to fly.
> 
> I tend to disagree. For normal users that consume QEMU via the distros, the
> check via argv[0] should be good enough. For developers, I think we can
> assume that they are adaptive enough to use an additional "-target" option
> in case they mis-named their binary in a bad way.

> > Developers rename the binary all the time, and expect this not to change
> > behavior.  For instance, I routinely rename qemu-FOO to qemu-FOO.old or
> > qemu-FOO.COMMIT-HASH to let me compare behavior easily.
> 
> Developers should already be aware that this can cause trouble, since e.g.
> the qtests are deriving the target architecture from the binary name
> already. See the qtest_get_arch() function.

Even if we want to allow developers to rename binaries, we don't have to
allow an arbitrary choice of naming. We could define an accepted pattern
for naming that people must follow.

eg we could allow for clearly distinguished suffixes (ie append '-SUFFIX')
so that

  qemu-system-x86_64-fishfood

is acceptable while

  qemu-system-fishfood
  qemu-system-x86_64fishfood

would be an unsupported scenarios.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


