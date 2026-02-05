Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64827ECD995
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 18:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo3vE-00062x-1l; Thu, 05 Feb 2026 13:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vo3vB-00062f-S5
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vo3v9-0002YY-8b
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770315458;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZL53A1Iv580iBGKwHZ3NIX0S+VvW60cfO9pZES1i18=;
 b=i7omDf3oQRCH+Qp9GPW519M1fe3xjZJK1buhXefiyAVb9nc6K0l/9/7gxopdk2meoNgR9V
 SubFzfndNEVEXnshZRPjokQ7ikBCXKrQ47GshT8H5SqWbyxQETDNyuLmQFk5e1/ctqEUec
 rW/x7DAT98uJ+V0E5iPaoZJRsnPucPI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-TQkbDu-fNMu0a0RCgbdQvQ-1; Thu,
 05 Feb 2026 13:17:35 -0500
X-MC-Unique: TQkbDu-fNMu0a0RCgbdQvQ-1
X-Mimecast-MFC-AGG-ID: TQkbDu-fNMu0a0RCgbdQvQ_1770315454
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C98781955E72; Thu,  5 Feb 2026 18:17:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1551319373D8; Thu,  5 Feb 2026 18:17:30 +0000 (UTC)
Date: Thu, 5 Feb 2026 18:17:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 0/4] tests/docker: improve detection of docker/podman
Message-ID: <aYTethv3y5HcIIt2@redhat.com>
References: <20260107130145.1495219-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107130145.1495219-1-berrange@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping: any thoughts on this series of CI improvements ?

On Wed, Jan 07, 2026 at 01:01:41PM +0000, Daniel P. Berrangé wrote:
> This improves integration such that tests/docker/Makefile.include will
> correctly honour the exact command detected by docker.py's probing
> logic. Currently the probe command gets stripped down to just a bare
> 'podman' or 'docker' command name. This means while commands run via
> 'docker.py' would use 'sudo -n docker', commands run directly from
> Makefile.include would only use 'docker'.
> 
> This series fixes that so that 'docker.py probe' correctly reports the
> full argv, and configure honours that argv untouched.
> 
> With that fixed, we can then also add support for 'podman --remote'
> and 'podman-remote', which allow use of podman when already inside
> podman which is the scenario for my development environment that is
> using 'toolbox'.
> 
> Finally this also improves CI by ensuring that stdout from docker is
> not thrown away, so we can have a chance of diagnosing build failures
> from CI.
> 
> Daniel P. Berrangé (4):
>   tests/docker: improve handling of docker probes
>   tests/docker: allow display of docker output
>   gitlab: ensure docker output is always displayed in CI
>   tests/docker: add support for podman remote access
> 
>  .gitlab-ci.d/base.yml         |  3 +++
>  configure                     | 19 +++++++------------
>  tests/docker/Makefile.include | 23 ++++++++++++++---------
>  tests/docker/docker.py        | 17 +++++++----------
>  4 files changed, 31 insertions(+), 31 deletions(-)
> 
> -- 
> 2.52.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


