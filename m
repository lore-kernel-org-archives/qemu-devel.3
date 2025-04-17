Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D28C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LmJ-0001P7-69; Thu, 17 Apr 2025 05:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u5LmF-0001MO-Ad
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u5LmD-0008BM-9J
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744882999;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=F+X4YR5Q2BwMlJTJ9ZR9MXdipcYiTWEU/bP8KqClWO0=;
 b=YVrzlQFkBvQgZKXtfzpm/Qe7/dCu+QdPgFnWz/MpR4TcUkcwM+J06wk3de5ZjUa8s2qbPh
 sNSGHKgKmP4XX5vYlTSjCojYJ1R4JUGz8KamixS02DfRPsYq9zyY+8pYMrE+L4T1UP2Raw
 mks7nlnM7un6OvoVrgcv07UXKs4QS3w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-hwxhfijBM4238Y24Rrzm4Q-1; Thu,
 17 Apr 2025 05:43:15 -0400
X-MC-Unique: hwxhfijBM4238Y24Rrzm4Q-1
X-Mimecast-MFC-AGG-ID: hwxhfijBM4238Y24Rrzm4Q_1744882994
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A15D218001CA; Thu, 17 Apr 2025 09:43:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.151])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E15C1956095; Thu, 17 Apr 2025 09:43:05 +0000 (UTC)
Date: Thu, 17 Apr 2025 10:43:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/2] tests/functional: add skipLockedMemoryTest
 decorator
Message-ID: <aADNJr3eGBJiLt4H@redhat.com>
References: <20250417072244.147510-1-dtalexundeer@yandex-team.ru>
 <20250417072244.147510-2-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250417072244.147510-2-dtalexundeer@yandex-team.ru>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 17, 2025 at 12:22:45PM +0500, Alexandr Moshkov wrote:
> Used in future commit to skipping execution of a tests if the system's
> locked memory limit is below the required threshold.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  tests/functional/qemu_test/__init__.py   |  2 +-
>  tests/functional/qemu_test/decorators.py | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> index af41c2c6a2..6e666a059f 100644
> --- a/tests/functional/qemu_test/__init__.py
> +++ b/tests/functional/qemu_test/__init__.py
> @@ -15,6 +15,6 @@
>  from .linuxkernel import LinuxKernelTest
>  from .decorators import skipIfMissingCommands, skipIfNotMachine, \
>      skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
> -    skipIfMissingImports, skipIfOperatingSystem
> +    skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest
>  from .archive import archive_extract
>  from .uncompress import uncompress
> diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
> index 50d29de533..9f3062d020 100644
> --- a/tests/functional/qemu_test/decorators.py
> +++ b/tests/functional/qemu_test/decorators.py
> @@ -5,6 +5,7 @@
>  import importlib
>  import os
>  import platform
> +import subprocess
>  from unittest import skipIf, skipUnless
>  
>  from .cmd import which
> @@ -131,3 +132,21 @@ def skipIfMissingImports(*args):
>  
>      return skipUnless(has_imports, 'required import(s) "%s" not installed' %
>                                     ", ".join(args))
> +
> +'''
> +Decorator to skip execution of a test if the system's
> +locked memory limit is below the required threshold.
> +Takes required locked memory threshold in kB.
> +Example:
> +
> +  @skipLockedMemoryTest(2_097_152)
> +'''
> +def skipLockedMemoryTest(locked_memory):
> +    ulimit_memory = subprocess.run(
> +        ['bash', '-c', 'ulimit -l'],
> +        capture_output=True,
> +        text=True,
> +    ).stdout

You should be able to use  resource.getrlimit() rather than spawning
a process.

> +
> +    return skipUnless(ulimit_memory == 'unlimited' or int(ulimit_memory) >= locked_memory,
> +                      f'Test required {locked_memory} kB of available locked memory')
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


