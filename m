Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4292ECCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 21:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIuzY-000890-G5; Fri, 01 May 2026 17:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wIuzO-00087n-3q
 for qemu-devel@nongnu.org; Fri, 01 May 2026 17:01:38 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wIuzK-0007Ok-Pt
 for qemu-devel@nongnu.org; Fri, 01 May 2026 17:01:33 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id E751A240027
 for <qemu-devel@nongnu.org>; Fri,  1 May 2026 23:01:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu; s=2017;
 t=1777669286; bh=SXp3lqNottE16XwA+SbILwJnDouUeIfZ8Pmh8bmucgM=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=ijsq7bh3E+IuJpMeSl3Mwfk37x+6/p8eR5NPa9AaFR3TYwV0+AH9++LcRvOKsg7/u
 EsebkSz3Rn7OdPxirQm0SnEIFZiYMyIZJi49CKqGywluwks3FqXUX0bIKfhVaMVOjh
 /Ux6Ewc0vwVdryy+r2cHNPTS2L2z+hsCq0hVlmg4TAow3QvUA0vezpqR/L46Eans+V
 ZNlxnAt+6CmaskvoLn55JlxuUUr2NvyejHagmb8D87j4Kb2mD8pIk0sHsSgIYqEEBy
 9rjKz+GWeXDf84MjsZ2pf9/8Mt43OW0HrUyImGqNSKuT98Lb6URSGqo0nTY+meFf45
 4ggQHohFWmwKQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4g6k3n5YzLz9rxB;
 Fri,  1 May 2026 23:01:24 +0200 (CEST)
Date: Fri, 01 May 2026 21:01:26 +0000
From: Thomas Huth <th.huth+qemu@posteo.eu>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>
Subject: Re: [PATCH] tests/functional/qemu_test/asset.py: Don't use setxattr
 when it doesn't exist
Message-ID: <20260501230124.19b10492@tpx1>
In-Reply-To: <20260501115506.3792110-1-peter.maydell@linaro.org>
References: <20260501115506.3792110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth+qemu@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am Fri,  1 May 2026 12:55:06 +0100
schrieb Peter Maydell <peter.maydell@linaro.org>:

> The Python os.setxattr() API is Linux-specific, so trying to use
> it on other OSes triggers a failure:
> 
>   File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
> line 227, in fetch
>     os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
>     ^^^^^^^^^^^
> AttributeError: module 'os' has no attribute 'setxattr'
> 
> Since we only set the attributes here for informational
> purposes, skip them when os.setxattr() isn't available.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 9903217a4ed013 ("tests/functional: add a module for handling asset download & caching")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/functional/qemu_test/asset.py | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index 51a434b2b7..0abd89e0a3 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -223,11 +223,14 @@ def fetch(self):
>              raise AssetError(self, "Download retries exceeded", transient=True)
>  
>          try:
> -            # Set these just for informational purposes
> -            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> -                        self.url.encode('utf8'))
> -            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
> -                        self.hash.encode('utf8'))
> +            # Set these just for informational purposes. Note that
> +            # setxattr is Linux-only; as this is only informational
> +            # we can simply skip it on other platforms.
> +            if hasattr(os, "setxattr"):
> +                os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> +                            self.url.encode('utf8'))
> +                os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
> +                            self.hash.encode('utf8'))
>          except OSError as e:
>              self.log.debug("Unable to set xattr on %s: %s", tmp_cache_file, e)
>  

Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>

