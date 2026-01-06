Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920FCCDC183
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 12:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd5vF-0007oD-6V; Tue, 06 Jan 2026 07:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vd5uk-0007iH-QL
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 07:11:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vd5uh-0000A9-Oo
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 07:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767701508;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OvqQG7cv/+tQUL82ixBtqnfmZqQgXOvYoay0fGolrBA=;
 b=cjg9ldPKlnfEErpfYLfXQ2g2ieu1sreREH1MGpiKVzlIqtGFElqJrH1Yejns5gkTDC9Jsf
 xITwmlwdq+L8lda8aG3uAbTbrVHq/g7jC0RP6u2/Yj+1AdOnOM9qo8D3/v1FITFCr/s0N7
 nGMtZIDBFVzjgNzyX5jgXlYRHRlQ2HM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-EVF9absTNRmoEn-RTWZjMg-1; Tue,
 06 Jan 2026 07:11:44 -0500
X-MC-Unique: EVF9absTNRmoEn-RTWZjMg-1
X-Mimecast-MFC-AGG-ID: EVF9absTNRmoEn-RTWZjMg_1767701503
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DF2D195FCED; Tue,  6 Jan 2026 12:11:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.217])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18E8A30001A8; Tue,  6 Jan 2026 12:11:38 +0000 (UTC)
Date: Tue, 6 Jan 2026 12:11:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 03/15] python/mkvenv: add 'checktests' and 'functests'
 dependency groups
Message-ID: <aVz792X-D_14Ka4f@redhat.com>
References: <20251205060058.1503170-1-jsnow@redhat.com>
 <20251205060058.1503170-4-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251205060058.1503170-4-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Dec 05, 2025 at 01:00:45AM -0500, John Snow wrote:
> 'checktests' contains depedencies *required* to run "make check", and as
> such, we promise that these dependencies can be sourced from the user's
> distribution repository or from vendored packages so that "make check"
> can be executed offline in an isolated build environment.
> 
> In contrast, pygdbmi is only needed for functional tests and not tests
> in general; we do not make the same offline/isolated guarantees for
> functional tests, and this dependency group is allowed to fetch
> dependencies from PyPI at runtime.
> 
> For the time being, Amend the "check-venv" target to install both
> dependency groups, to avoid a duplicate dependency between them.

We now have the 'run' script concept merged, so we can do
"./run ..." and it'll "do the right thing" executing with
the python venv in $PYTHONPATH, and locally built binaries
in $PATH, etc.

What I think is missing is to ensure that qemu.qmp is *always*
available in the venv.

The split of python deps between vendored and non-vendored
pieces makes sense, but the association of 'qemu.qmp' with
tests is overlooking that qemu.qmp is used for more than
just the tests - it is also a dep of qmp-shell which is a
developer tool. Given this I think tieing install of qemu.qmp
to 'make check' (via 'make check-venv') is a mistake. Instead
we should unconditionally install it when configure is run.

We have precedent for that in --enable-rust unconditionally
installing all vendored Rust crates.  Since we vendor qemu.qmp
there's no download penalty, and timing the venv creation
shows it takes about 1 second which is insignificant in the
context of everything else configure does. 

Anyway, if we move the 'checktests' group install to configure,
then combined with the new 'run' script we would eliminate the
main behaviour regression from removing qemu.qmp from git.


Leaving the 'functests' group to be lazy installed is OK, since
as a developer if you're running a functional test directly,
that is pretty likely to be after you already had run the
'make check-functional' command and saw a failure. IOW the
venv will be populated with the needed deps.

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  pythondeps.toml        | 10 +++++++++-
>  tests/Makefile.include |  2 +-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index 1657953ff65..14ceb4e7787 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -31,6 +31,14 @@ meson = { accepted = ">=1.9.0", installed = "1.9.0", canary = "meson" }
>  sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
>  sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>  
> -[testdeps]
> +# This test group is for dependencies required to run "make check"
> +# successfully, and should only include depedencies that can be
> +# guaranteed via configure from system packages, or python packages we
> +# vendor.
> +[checktests]
>  "qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
> +
> +# This test group is for functional tests, and can include dependencies
> +# fetched from PyPI.
> +[functests]
>  pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d4dfbf3716d..40b114bd158 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -98,7 +98,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
>  
>  $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
>  	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> -	$(MKVENV_ENSUREGROUP) $< testdeps
> +	$(MKVENV_ENSUREGROUP) $< checktests functests
>  	$(call quiet-command, touch $@)
>  
>  check-venv: $(TESTS_VENV_TOKEN)
> -- 
> 2.51.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


