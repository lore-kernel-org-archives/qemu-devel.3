Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34DAECD6C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCsZ-0000d3-Qw; Wed, 11 Feb 2026 11:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqCsL-0000cS-95
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:15:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqCsI-0000HE-Tx
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770826533;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uqKI6IL9iDhC4MEd+O7BfnlEFVBtF1ipIPQcec4x0Lk=;
 b=bT5FDiZruu3gqPETo9WwmQh35uMXyh8nISwHk9JROdUHuYoUiXXHc64Jx1JMiEJAKStWwr
 zMSAThMrMdt4accBcy2JiCKABiVTS9Ao5agDnexcDaFyxyn/nSDMnVmFB9/MSJRiBOEBHP
 GOX51aA1svHrxVvjWM7qBskqgURo0uI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-IKTjcSfLPMSqKdf_G7lEhg-1; Wed,
 11 Feb 2026 11:15:28 -0500
X-MC-Unique: IKTjcSfLPMSqKdf_G7lEhg-1
X-Mimecast-MFC-AGG-ID: IKTjcSfLPMSqKdf_G7lEhg_1770826527
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73EBE1955DD4; Wed, 11 Feb 2026 16:15:27 +0000 (UTC)
Received: from redhat.com (unknown [10.45.227.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1218300DDA5; Wed, 11 Feb 2026 16:15:25 +0000 (UTC)
Date: Wed, 11 Feb 2026 16:15:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] python/setup.py: Drop version checking via
 pkg_resources
Message-ID: <aYyrGiqBeD1EcHp-@redhat.com>
References: <20260211161154.740256-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260211161154.740256-1-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Wed, Feb 11, 2026 at 05:11:54PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> pkg_resources has been dropped from setuptools v82.0 and newer,
> so our setup.py script is currently failing there, breaking our CI.
> To fix it, switch to a direct version check instead.
> While we're at it, also bump the minimum version of setuptools
> to v44 now since that is the minimum that might still be in use
> on the distros we care about according to:
>  https://repology.org/project/python%3Asetuptools/versions
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  No clue whether that version check is fine with all versions of
>  setuptools, thus I marked the patch as RFC. At least it survives
>  the CI:
>  https://gitlab.com/thuth/qemu/-/pipelines/2319359396
> 
>  python/setup.py | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

This works so:

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


but the other option discussed on IRC was to remove the
existing version check entirely on the basis that all our
supported platforms will have sufficient version by default
and we don't need to spend time checking for the benefit of
unsupported platforms.

> 
> diff --git a/python/setup.py b/python/setup.py
> index c5bc45919a4..ae242ac95ac 100755
> --- a/python/setup.py
> +++ b/python/setup.py
> @@ -7,7 +7,6 @@
>  import setuptools
>  from setuptools.command import bdist_egg
>  import sys
> -import pkg_resources
>  
>  
>  class bdist_egg_guard(bdist_egg.bdist_egg):
> @@ -30,8 +29,8 @@ def main():
>      QEMU tooling installer
>      """
>  
> -    # https://medium.com/@daveshawley/safely-using-setup-cfg-for-metadata-1babbe54c108
> -    pkg_resources.require('setuptools>=39.2')
> +    if int(setuptools.__version__.split('.')[0]) < 44:
> +        raise ModuleNotFoundError('version of setuptools is too old')
>  
>      setuptools.setup(cmdclass={'bdist_egg': bdist_egg_guard})
>  
> -- 
> 2.53.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


