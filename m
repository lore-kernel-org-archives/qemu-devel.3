Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A93606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UUG8VbQ5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRa0I-0007SY-M3; Thu, 12 Nov 2026 13:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRa0F-0007Qh-Qo
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:58:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRa0D-0001as-Pd
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794509907;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AAs2i20KuV4kZ8HkxVukvFQpZk/ZK2KF8XGs5gZvI2M=;
 b=UUG8VbQ58FJsvN1aYTL8Fo/dwcuc76g3ylvJFPLZymw3ARFIWd6FY/Q7pUGRay+2WFcYfz
 /TRG7PerS1XUHpBsz/sMMoE52rbpUW7akFhpBa0eopBbEVngVR/t7ucVYiiDzDNa5zZU0O
 Z500NkEJ/RcDu202MNkxbLxYll3N9Yg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-urpPILScM5i3oLJ4S-JnqA-1; Thu,
 12 Nov 2026 13:58:22 -0500
X-MC-Unique: urpPILScM5i3oLJ4S-JnqA-1
X-Mimecast-MFC-AGG-ID: urpPILScM5i3oLJ4S-JnqA_1794509901
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCF19195605B; Thu, 12 Nov 2026 18:58:20 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52F4C1956087; Thu, 12 Nov 2026 18:58:18 +0000 (UTC)
Date: Thu, 12 Nov 2026 18:58:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Matthew White <mehw.is.me@proton.me>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL 6/6] configure: --disable-containers should prevent
 `docker.py probe`
Message-ID: <avYMRz3P0-4UNpc-@redhat.com>
References: <20261112184513.2324634-1-mjt@tls.msk.ru>
 <20261112184513.2324634-7-mjt@tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261112184513.2324634-7-mjt@tls.msk.ru>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 09:45:09PM +0300, Michael Tokarev wrote:
> From: Matthew White <mehw.is.me@proton.me>
> 
> Upstream commit c4ce04cfb7460d46c0262d437a7f35bb5c5fc449 changed the
> configure file to set container_command regardless of use_containers.
> As a result, it runs `docker.py probe` to detect a Docker-compatible
> application, such as Podman, even when --disable-containers is used.
> 
> On Gentoo, this reopens https://bugs.gentoo.org/732972.  As reported
> in https://bugs.gentoo.org/984747, the `docker.py probe` command can
> trigger SANDBOX ACCESS VIOLATION errors under QEMU v11.1.2:
> 
>  * ACCESS DENIED:  open_wr_creat: /var/lib/rpm/rpmdb.sqlite-wal
>  * ACCESS DENIED:  fchown:        /var/lib/rpm/rpmdb.sqlite-wal
>  ...

I'm puzzled why docker.py probe would touch the RPM database.

As long as the configure script does not break though, having
the system log sandbox warnings is not a bug from QEMU's POV
IMHO.

The probe can be disabled by using --container-command=podman
or probably even --container-command=false would work.

> This patch is to prevent `docker.py probe` from running and to clear
> container_command when --disable-containers is used.

This reintroduces the problem that c4ce04cfb7460d46c0262d437a7f35bb5c5fc449
was fixing, because tests/docker/Makefile will now re-run the docker
probe on every command.

The --disable-containers arg was only intended to disable the use of
cross compilation in containers for the purposes of TCG testsuite.

> 
> Buglink: https://bugs.gentoo.org/984747
> Signed-off-by: Matthew White <mehw.is.me@proton.me>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  configure | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/configure b/configure
> index af14a9c23ef..d38268e340f 100755
> --- a/configure
> +++ b/configure
> @@ -1277,12 +1277,17 @@ fi
>  ##########################################
>  # functions to probe cross compilers
>  
> -if test "$container_command" = ""; then
> -    container_command=$($python "$source_path"/tests/docker/docker.py probe)
> -    test "$container_command" = "no" && container_command=""
> -fi
> -if test $use_containers = "yes" && test "$container_command" != ""; then
> -    docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
> +if test $use_containers = "yes"; then
> +    if test "$container_command" = ""; then
> +        container_command=$($python "$source_path"/tests/docker/docker.py probe)
> +        test "$container_command" = "no" && container_command=""
> +    fi
> +    if test "$container_command" != ""; then
> +        docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
> +    fi
> +else
> +    # the option --disable-containers should override and disable --container-command
> +    container_command=""
>  fi
>  
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
> -- 
> 2.47.3
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


