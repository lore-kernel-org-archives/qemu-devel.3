Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47844D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi7Wh-0000X1-FS; Tue, 20 Jan 2026 03:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vi7Wf-0000QM-Gq
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:55:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vi7Wd-0008Gt-QI
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768899346;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXGM5vMN9+J+eSd2oI6Qt07jGOZgqytbwQCN7B0xt48=;
 b=cJP7d09+kA8Ffa0FLQ1l1Jo52Dhg5ddXhJPw7GrGgiuh9Hunu/cHMeHjgpTDkLqARqQxzO
 +wx/rcCQyFvzvblE1VzeOdPBcUGSHOppZupeSjvM2T34zWHUswssEpd60qzuRB3hgK4snx
 0+XQjlj3KllDJYd+GwIDyQO0NQWlzrU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-qp_38r5ON7KVQGDc6cMdmA-1; Tue,
 20 Jan 2026 03:55:42 -0500
X-MC-Unique: qp_38r5ON7KVQGDc6cMdmA-1
X-Mimecast-MFC-AGG-ID: qp_38r5ON7KVQGDc6cMdmA_1768899340
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A142B1956053; Tue, 20 Jan 2026 08:55:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 543C01800577; Tue, 20 Jan 2026 08:55:33 +0000 (UTC)
Date: Tue, 20 Jan 2026 08:55:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Ed Maste <emaste@freebsd.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 08/17] tests/lcitool: add python3 wheel and setuptools
 deps for qemu
Message-ID: <aW9DAktwCICK8dwv@redhat.com>
References: <20260119212744.1275455-1-jsnow@redhat.com>
 <20260119212744.1275455-9-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119212744.1275455-9-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jan 19, 2026 at 04:27:34PM -0500, John Snow wrote:
> Installing local dependencies while offline, without PyPI access,
> requires the python3-setuptools and python3-wheel packages. Most
> distributions have these available anyway for one reason or another, but
> not all of them.
> 
> If you are asking yourself "Wait, aren't these packages guaranteed via
> installation of pip, via the ensurepip module, which mkvenv takes
> immense pains to provide for us?" - Well... since Python 3.13, "pip"
> does not actually come with "setuptools" or "wheel" anymore, and so if
> we want to build and install a python package, we actually need these
> available in the host environment.
> 
> (Note that you don't need these packages just to install a pre-built
> package, you only need them to *build* a package. With cutting edge
> setuptools and pip, all locally installed packages, even in editable
> mode, must be "built" first before being installed. Thus, these
> dependencies are being added specifically to facilitate installing
> qemu.git/python/qemu to the configure-time venv.)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  .gitlab-ci.d/cirrus/freebsd-14.vars     | 2 +-
>  .gitlab-ci.d/cirrus/macos-14.vars       | 2 +-
>  .gitlab-ci.d/windows.yml                | 2 ++
>  tests/docker/dockerfiles/alpine.docker  | 2 ++
>  tests/docker/dockerfiles/centos9.docker | 2 ++
>  tests/lcitool/projects/qemu.yml         | 2 ++
>  tests/vm/generated/freebsd.json         | 2 ++
>  7 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


