Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4554D0E6D6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 09:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ohQ-0001v2-Sz; Mon, 21 Oct 2024 05:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2ohO-0001uY-Tv
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 05:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2ohN-0002Qm-2p
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 05:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729502856;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cyUOeU4OT0j+rU3x1fAR9VYhdSHFrm9ljLLRp2UBj4U=;
 b=avfhOONPEJc8bIDqWousJI4sXx/oRG3K5pU0yb9tuEmhm8UBteAA23WWldS/RMCCAvFAO0
 33dRTYwgGR5DYbc0tGKUXtqCUqMiiZp87Z3qLMUzUnTULko3aJRbqhSj6j9zZ8VfyYz5ZH
 ccZPw1uFpHf2LkgzrxPsNbbyZgH0B6g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-2dqxu2WsOUuRhvY3W1Q6GA-1; Mon,
 21 Oct 2024 05:27:32 -0400
X-MC-Unique: 2dqxu2WsOUuRhvY3W1Q6GA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F112B19560A3; Mon, 21 Oct 2024 09:27:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 065FF19560AA; Mon, 21 Oct 2024 09:27:27 +0000 (UTC)
Date: Mon, 21 Oct 2024 10:27:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Brad Smith <brad@comstyle.com>
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Alex Benn_e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud_ <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] tests/vm: update openbsd image to 7.6
Message-ID: <ZxYee2xa-VJjOQSV@redhat.com>
References: <ZwtmfVlWgFRF9G8W@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwtmfVlWgFRF9G8W@humpty.home.comstyle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Oct 13, 2024 at 02:19:41AM -0400, Brad Smith wrote:
> tests/vm: update openbsd image to 7.6
> 
> Remove tomli as Python has been updated to 3.11.
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  tests/vm/openbsd | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 49cab08782..dfd11c93f0 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
>      name = "openbsd"
>      arch = "x86_64"
>  
> -    link = "https://cdn.openbsd.org/pub/OpenBSD/7.5/amd64/install75.iso"
> -    csum = "034435c6e27405d5a7fafb058162943c194eb793dafdc412c08d49bb56b3892a"
> +    link = "https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/install76.iso"
> +    csum = "60cba8cb391b50bba8fa10fc768bd0529636f5345d82133c93e22c798d8e5269"
>      size = "20G"
>      pkgs = [
>          # tools
> @@ -32,7 +32,6 @@ class OpenBSDVM(basevm.BaseVM):
>          "pkgconf",
>          "bzip2", "xz",
>          "ninja",
> -        "py3-tomli",
>  
>          # gnu tools
>          "bash",
> @@ -160,6 +159,7 @@ class OpenBSDVM(basevm.BaseVM):
>  
>          self.print_step("Installation started now, this will take a while")
>          self.console_wait_send("Location of sets",        "done\n")
> +        self.console_wait_send("Time appears wrong.  Set to", "\n")

Have you any idea why this line has suddenly become neccessary ?

Without your patch, I'm seeing OpenBSD VM installs fail with the existing
'install75.iso' image, with the error matching this line

  con recv: Time appears wrong.  Set to 'Mon Oct 21 04:07:03 UTC 2024'? [yes]

The OpenBSD installer can't have changed behind our back, because we've
recorded the original ISO image checksum.

So I'm wondering what other thing has changed to suddenly make this
"Time appears wrong" message appear ?  Have we accidentally broken
something in QEMU ? 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


