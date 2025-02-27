Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D51C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZlf-0000Ie-Sj; Thu, 27 Feb 2025 04:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnZlV-0000Hw-S3
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:01:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnZlS-0002cp-O8
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740646865;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mgg6KjhrYkIcoGwH/ktg3sCvG/7sEtt9Rd9CNLKCkDQ=;
 b=dZXo+bTCJA3MGaHgGNZxvSHW3x6R0ZgQ4jxUqOxMn8GwsZJgQBTPDahpQRVBri7gPygODg
 20+YLnVK7oI9R+GMHM9f21RFwUx+R/shLSXg71ieihoGKPS1GFSbrBrMH4zTtmJ3sxW8iD
 7K17Sdt5bQxQ5wsYOoxb+YwabDk3uBs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-JFGrtdE5PZW3Mo9cRN8ibQ-1; Thu,
 27 Feb 2025 04:01:01 -0500
X-MC-Unique: JFGrtdE5PZW3Mo9cRN8ibQ-1
X-Mimecast-MFC-AGG-ID: JFGrtdE5PZW3Mo9cRN8ibQ_1740646860
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6569B180098D; Thu, 27 Feb 2025 09:00:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7209B180087F; Thu, 27 Feb 2025 09:00:54 +0000 (UTC)
Date: Thu, 27 Feb 2025 09:00:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 2/3] tests/functional: Introduce the dso_suffix() helper
Message-ID: <Z8ApwkWmJygfNfq7@redhat.com>
References: <20250220080215.49165-1-philmd@linaro.org>
 <20250220080215.49165-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220080215.49165-3-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Feb 20, 2025 at 09:02:14AM +0100, Philippe Mathieu-Daudé wrote:
> Introduce a helper to get the default shared library
> suffix used on the host.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/functional/qemu_test/__init__.py | 2 +-
>  tests/functional/qemu_test/cmd.py      | 1 -
>  tests/functional/qemu_test/config.py   | 6 ++++++
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> index 5c972843a6d..45f7befa374 100644
> --- a/tests/functional/qemu_test/__init__.py
> +++ b/tests/functional/qemu_test/__init__.py
> @@ -7,7 +7,7 @@
>  
>  
>  from .asset import Asset
> -from .config import BUILD_DIR
> +from .config import BUILD_DIR, dso_suffix
>  from .cmd import is_readable_executable_file, \
>      interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
>      exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index dc5f422b77d..254e23ef748 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -15,7 +15,6 @@
>  import os
>  import os.path
>  
> -
>  def which(tool):
>      """ looks up the full path for @tool, returns None if not found
>          or if @tool does not have executable permissions.
> diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qemu_test/config.py
> index edd75b7fd06..0eab1baa541 100644
> --- a/tests/functional/qemu_test/config.py
> +++ b/tests/functional/qemu_test/config.py
> @@ -13,6 +13,7 @@
>  
>  import os
>  from pathlib import Path
> +import platform
>  
>  
>  def _source_dir():
> @@ -34,3 +35,8 @@ def _build_dir():
>      raise Exception("Cannot identify build dir, set QEMU_BUILD_ROOT")
>  
>  BUILD_DIR = _build_dir()
> +
> +def dso_suffix():
> +    '''Return the dynamic libraries suffix for the current platform'''
> +    DSO_SUFFIXES = { 'Linux': 'so', 'Darwin': 'dylib', 'Windows': 'dll' }
> +    return DSO_SUFFIXES[platform.system()]

Windows and Darwin are the two odd-ball platforms we target, Linux and
all the BSDs use .so, so it makes sense to use .so as the general
fallback, at which point I'm not sure the lookup table is worthwhile
compared to:

  if platform.system() == "Darwin"
    return "dylib"
  elif platform.system() == "Windows"
    return "dll"
  else
    return "so"

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


