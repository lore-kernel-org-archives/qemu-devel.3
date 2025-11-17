Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98491CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 19:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL4ZF-0006iL-7w; Mon, 17 Nov 2025 14:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vL4ZB-0006hl-71
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 14:07:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vL4Z8-0001rB-J5
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 14:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763406425;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kdX5egYQmV0VVdmtgIxnf7ECuNhWF9MpkAIod7hi5Ac=;
 b=LN4o/6iEADzmWVXacJFPtNhGKmWljaXWxq2zRKJ4q1qhb+1KwWmjiJGU89KkIgt7QAFiJt
 QgH5y/Me8xusZH9ZS4VK8n8U9XqgQOfWsQikb/okTYoBnfMMgsWYPPfaKMALnws3UmRTEW
 lfrzpGf4jVH/HvY6xbOQG6NPfCJ/cpE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-SxBkXFPPNBi3PS8KCVrhZQ-1; Mon,
 17 Nov 2025 14:07:02 -0500
X-MC-Unique: SxBkXFPPNBi3PS8KCVrhZQ-1
X-Mimecast-MFC-AGG-ID: SxBkXFPPNBi3PS8KCVrhZQ_1763406421
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB9B518AB423; Mon, 17 Nov 2025 19:07:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 867833003754; Mon, 17 Nov 2025 19:06:57 +0000 (UTC)
Date: Mon, 17 Nov 2025 19:06:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 17/22] tests: forcibly run 'make check-venv' for crash
 tests
Message-ID: <aRtyTkIcuoNazF7L@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-18-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251117185131.953681-18-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 17, 2025 at 01:51:25PM -0500, John Snow wrote:
> In order to convert the existing Makefile target from a manual
> invocation of mkvenv to one that uses the meson dependency system, we
> need to not suppress ninja here.
> 
> I'm not sure if this creates problems I am not aware of; but invoking
> ninja here is no longer spurious but will become necessary.

Yes, this will likely create problems. From the commit message that
introduced NINJA=":"...

  commit 4d3bd91b26a69b39a178744d3d6e5f23050afb23
  Author: Thomas Huth <thuth@redhat.com>
  Date:   Mon Apr 24 10:22:35 2023 +0100

    gitlab-ci: Avoid to re-run "configure" in the device-crash-test jobs
    
    After "make check-venv" had been added to these jobs, they started
    to re-run "configure" each time since our logic in the makefile
    thinks that some files are out of date here. Avoid it with the same
    trick that we are using in buildtest-template.yml already by disabling
    the up-to-date check via NINJA=":".



> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 18d72d3058b..2cb2cf25b4a 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -101,7 +101,7 @@ crash-test-debian:
>      IMAGE: debian
>    script:
>      - cd build
> -    - make NINJA=":" check-venv
> +    - make check-venv
>      - pyvenv/bin/python3 scripts/device-crash-test -q --tcg-only ./qemu-system-i386
>  
>  build-system-fedora:
> @@ -158,7 +158,7 @@ crash-test-fedora:
>      IMAGE: fedora
>    script:
>      - cd build
> -    - make NINJA=":" check-venv
> +    - make check-venv
>      - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-ppc
>      - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-riscv32
>  
> -- 
> 2.51.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


