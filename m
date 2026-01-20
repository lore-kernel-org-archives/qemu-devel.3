Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69970D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi7gN-0001T7-7S; Tue, 20 Jan 2026 04:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vi7gL-0001S6-KK
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:05:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vi7gK-0001T0-4a
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768899946;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9kbL9eNWIFJW7eDyy7Ja8BRpfvE6zYM6pb/LlUjCg5A=;
 b=S7+Cmt57nbZPB1vqEV9GpqEYJTT7rja14UdY5gC2FI/zLdzfyjCl/pvuGXTVkfIDIhDgOV
 utxemDOmFjGihz1hFDPDL2E6Ezm4gBsjKPNuFKFoP2XnenB7nufin4vaRhtM6AB6FtVuHQ
 zJNJPwAohghmtgS6Npaj98FXXMEyZ6I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-E2PpFMs9MdmtsopAPq0-eA-1; Tue,
 20 Jan 2026 04:05:43 -0500
X-MC-Unique: E2PpFMs9MdmtsopAPq0-eA-1
X-Mimecast-MFC-AGG-ID: E2PpFMs9MdmtsopAPq0-eA_1768899941
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2768B195609D; Tue, 20 Jan 2026 09:05:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E67B530001A8; Tue, 20 Jan 2026 09:05:35 +0000 (UTC)
Date: Tue, 20 Jan 2026 09:05:32 +0000
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
Subject: Re: [PATCH v4 16/17] python: update README.rst to reflect qemu.qmp's
 removal
Message-ID: <aW9FXOvNIvKyfYPn@redhat.com>
References: <20260119212744.1275455-1-jsnow@redhat.com>
 <20260119212744.1275455-17-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119212744.1275455-17-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Mon, Jan 19, 2026 at 04:27:42PM -0500, John Snow wrote:
> It is no longer simply possible to just use this directory as if it were
> an installed package now that it has dependencies, so update the README
> to reflect this.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/README.rst | 50 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/python/README.rst b/python/README.rst
> index d62e71528d2..2accfd7760e 100644
> --- a/python/README.rst
> +++ b/python/README.rst
> @@ -3,7 +3,17 @@ QEMU Python Tooling
>  
>  This directory houses Python tooling used by the QEMU project to build,
>  configure, and test QEMU. It is organized by namespace (``qemu``), and
> -then by package (e.g. ``qemu/machine``, ``qemu/qmp``, etc).
> +then by package (e.g. ``qemu/machine``, ``qemu/utils``, etc).
> +
> +These tools and libraries are installed to the QEMU configure-time
> +Python virtual environment by default (see qemu.git/pythondeps.toml
> +"tooling" group), and are available for use by any Python script
> +executed by the build system. To have these libraries available for
> +manual invocations of scripts, use of the "run" script executable in
> +your build directory is recommended.

s/executable//, it is just a "script"

> @@ -61,8 +81,24 @@ invoke them without installation, you can invoke e.g.:
>  
>  ``> PYTHONPATH=~/src/qemu/python python3 -m qemu.qmp.qmp_shell``
>  
> +Or, with the runscript available in the QEMU build directory, simply:

s/runscript/run script/

> +
> +``> $builddir/run qmp-shell``
> +
>  The mappings between console script name and python module path can be
> -found in ``setup.cfg``.
> +found in ``setup.cfg``, but the console scripts available are listed
> +here for reference:
> +
> +* ``qemu-ga-client``
> +* ``qmp-shell``
> +* ``qmp-shell-wrap``
> +* ``qmp-tui`` (prototype urwid interface for async QMP)
> +* ``qom``
> +* ``qom-fuse`` (requires fusepy to be installed!)
> +* ``qom-get``
> +* ``qom-list``
> +* ``qom-set``
> +* ``qom-tree``

Those scripts all exist in $GIT/scripts/qmp/.  Are you saying that
they get installed into the venv now ? If so, should this series
also delete scripts/qmp ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


