Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604A2C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp1W-0006QJ-Tt; Tue, 25 Aug 2026 07:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyp1V-0006QB-T0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyp1U-0005bN-3q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787656134;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=q1SvmVJr5KG0qyt3pLuZjyDkEqcNMiZ/6IGmOzsoM60=;
 b=Ww5iCga4i7J4zbVTsdWUUT1KcrXXcQxa7lvVJnoNLIKWV9G2H6RFK7il63IDRHP/smxk46
 14p68fAO3lsbna4quGHESoWpcwbdsZATy5jCOi04NOJTScB9WiH3RYj3vIDBTeDOxYgeP5
 MQjB7h7+nJfD+B7gJ/G6/xGCyWcZZ6s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-j8izx00lPxi1wU-HiRwWAg-1; Tue,
 25 Aug 2026 07:08:48 -0400
X-MC-Unique: j8izx00lPxi1wU-HiRwWAg-1
X-Mimecast-MFC-AGG-ID: j8izx00lPxi1wU-HiRwWAg_1787656126
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87FEF187BE2A; Tue, 25 Aug 2026 11:08:45 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD5301800643; Tue, 25 Aug 2026 11:08:40 +0000 (UTC)
Date: Tue, 25 Aug 2026 12:08:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Warner Losh <imp@bsdimp.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 02/16] tests: update FreeBSD dependencies
Message-ID: <ao13tT_DZgxA_4Wn@redhat.com>
References: <20260825051441.1562454-1-jsnow@redhat.com>
 <20260825051441.1562454-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825051441.1562454-3-jsnow@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 25, 2026 at 01:14:27AM -0400, John Snow wrote:
> FreeBSD has dropped Python3.11, now defaulting to Python3.12+; upgrade
> the names of the various dependencies to match.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/lcitool/mappings.yml      |  9 +++++++++
>  tests/vm/generated/freebsd.json | 12 ++++++------
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> index 1816556dde4..afe52455235 100644
> --- a/tests/lcitool/mappings.yml
> +++ b/tests/lcitool/mappings.yml
> @@ -11,21 +11,29 @@ mappings:
>  
>    python3-pip:
>      CentOSStream9: python3.11-pip
> +    FreeBSD: py312-pip
>  
>    python3-setuptools:
>      CentOSStream9: python3.11-setuptools
> +    FreeBSD: py312-setuptools
>  
>    python3-sphinx:
>      CentOSStream9:
> +    FreeBSD: py312-sphinx
>  
>    python3-sphinx-rtd-theme:
>      CentOSStream9:
> +    FreeBSD: py312-sphinx_rtd_theme
>  
>    python3-venv:
>      CentOSStream9: python3.11
>  
>    python3-wheel:
>      CentOSStream9: python3.11-wheel
> +    FreeBSD: py312-wheel
> +
> +  python3-numpy:
> +    FreeBSD: py312-numpy
>  
>    meson:
>      # Use Meson from PyPI wherever Rust is enabled
> @@ -38,6 +46,7 @@ mappings:
>      apk:
>      Fedora:
>      Debian12:
> +    FreeBSD: py312-tomli
>  
>    rust:
>      Debian12: rustc-web

This shouldn't be done here.  libvirt-ci.git needs to be updated to
have the new names.  FreeBSD does this annoying package rename every
time a new python version is adopted :-(

I've proposed the required changes:

  https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/582


Once that's merged just updated the tests/lcitool/libvirt-ci git
submodule commit to latest HEAD and run 'make lcitool-refresh'
again in this commit.

> diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
> index dfa8b41a524..ee3402f0d2b 100644
> --- a/tests/vm/generated/freebsd.json
> +++ b/tests/vm/generated/freebsd.json
> @@ -52,12 +52,12 @@
>      "pixman",
>      "pkgconf",
>      "png",
> -    "py311-pip",
> -    "py311-setuptools",
> -    "py311-sphinx",
> -    "py311-sphinx_rtd_theme",
> -    "py311-tomli",
> -    "py311-wheel",
> +    "py312-pip",
> +    "py312-setuptools",
> +    "py312-sphinx",
> +    "py312-sphinx_rtd_theme",
> +    "py312-tomli",
> +    "py312-wheel",
>      "python3",
>      "rpm2cpio",
>      "rust",
> -- 
> 2.55.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


