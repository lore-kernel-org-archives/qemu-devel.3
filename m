Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CDAC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSC4b-0003al-HF; Fri, 12 Jul 2024 04:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSC4Z-0003ZA-6H
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSC4V-0005Sf-CO
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720774564;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHIiNm6c8Kt/uxS5SiZJsB8lfUoeD6DFDMmN4Q2/urE=;
 b=HkiSUEPpUEpJbwJeM446JFqGz/xUkDu9HxlA2bTtBplMK8RsFQSTutTTHm8bFLJow0jITW
 H86lPuFVn0Xtj2Meivi3CHWmcU79qH2JDgv9Orf9qc2oVXiDHlZlMV88D9bq4JB7RNeFT5
 neu7PUMn9MwLpEFS8aP9QWe+ZL9oxos=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-AgD-QFr7OzWWIZtsP8Z7zQ-1; Fri,
 12 Jul 2024 04:55:59 -0400
X-MC-Unique: AgD-QFr7OzWWIZtsP8Z7zQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C749196CE01; Fri, 12 Jul 2024 08:55:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1228D19560AA; Fri, 12 Jul 2024 08:55:52 +0000 (UTC)
Date: Fri, 12 Jul 2024 09:55:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 3/8] tests/pytest: Convert info_usernet and version
 test with small adjustments
Message-ID: <ZpDvleVBH8wWx2Qx@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-4-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711115546.40859-4-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 11, 2024 at 01:55:41PM +0200, Thomas Huth wrote:
> These two simple tests can be converted to a pytest quite easily,
> we just have to set the machine to 'none' now manually since we
> don't support the avocado tags here yet.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .../info_usernet.py => pytest/test_info_usernet.py}       | 6 ++----
>  tests/{avocado/version.py => pytest/test_version.py}      | 8 +++-----
>  2 files changed, 5 insertions(+), 9 deletions(-)
>  rename tests/{avocado/info_usernet.py => pytest/test_info_usernet.py} (91%)
>  rename tests/{avocado/version.py => pytest/test_version.py} (82%)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> diff --git a/tests/avocado/version.py b/tests/pytest/test_version.py
> similarity index 82%
> rename from tests/avocado/version.py
> rename to tests/pytest/test_version.py
> index c6139568a1..2d16b4075d 100644
> --- a/tests/avocado/version.py
> +++ b/tests/pytest/test_version.py
> @@ -9,15 +9,13 @@
>  # later.  See the COPYING file in the top-level directory.
>  
>  
> -from avocado_qemu import QemuSystemTest
> +from qemu_pytest import QemuSystemTest
>  
>  
>  class Version(QemuSystemTest):
> -    """
> -    :avocado: tags=quick

I was going to suggest we expose 'quick' in the meson.build a suite,
but it seems we've barely used this tag, only 2 other examples, so
its pointless.

> -    :avocado: tags=machine:none
> -    """
> +
>      def test_qmp_human_info_version(self):
> +        self.machine = 'none'
>          self.vm.add_args('-nodefaults')
>          self.vm.launch()
>          res = self.vm.cmd('human-monitor-command',
> -- 
> 2.45.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


