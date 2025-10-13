Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619E5CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8IQ1-0001dY-Mk; Mon, 13 Oct 2025 09:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8IPy-0001dL-A4
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8IPt-0003ts-Eq
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760361397;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SndHR+205Co8LrX0FzcavjOlZCepUuwZO1v3kwYoL+4=;
 b=GU4RtMvabvDBCG46cLNo66EwFhmxTXVX9KkbFBc+y6t+0+xTXaZHDMSB8cPiFQAjGLZRik
 uvshGiet+18RyHvMqSKqtGeFNIp9hQc5xvcVtFJ2DFL3NvH7yLreeAH1Ou04fguoJpAs2o
 xHMwYolLAEgN7QefZ4ZB2TLMrvFRuaA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-_kxel-C-PWaaUevqCadTxw-1; Mon,
 13 Oct 2025 09:16:34 -0400
X-MC-Unique: _kxel-C-PWaaUevqCadTxw-1
X-Mimecast-MFC-AGG-ID: _kxel-C-PWaaUevqCadTxw_1760361393
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9126195410A; Mon, 13 Oct 2025 13:16:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F24E195410A; Mon, 13 Oct 2025 13:16:30 +0000 (UTC)
Date: Mon, 13 Oct 2025 14:16:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 1/2] tests/functional: Set current time stamp of
 assets when using them
Message-ID: <aOz7q1wv1vGM_-iG@redhat.com>
References: <20251013121720.34552-1-thuth@redhat.com>
 <20251013121720.34552-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013121720.34552-2-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Oct 13, 2025 at 02:17:18PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We are going to remove obsolete assets from the cache, so keep
> the time stamps of the assets that we use up-to-date to have a way
> to detect stale assets later.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/qemu_test/asset.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index f666125bfaf..d5c4ad04bb5 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -10,6 +10,7 @@
>  import os
>  import stat
>  import sys
> +import time
>  import unittest
>  import urllib.request
>  from time import sleep
> @@ -113,6 +114,18 @@ def _wait_for_other_download(self, tmp_cache_file):
>          self.log.debug("Time out while waiting for %s!", tmp_cache_file)
>          raise
>  
> +    def _save_time_stamp(self):
> +        '''
> +        Update the time stamp of the asset in the cache. Unfortunately, we
> +        cannot use the modification or access time of the asset file itself,
> +        since e.g. the functional jobs in the gitlab CI reload the files
> +        from the gitlab cache and thus always have recent file time stamps,
> +        so we have to save our asset time stamp to a separate file instead.
> +        '''
> +        with open(self.cache_file.with_suffix(".stamp"), 'w',
> +                  encoding='utf-8') as fh:
> +            fh.write(f"{int(time.time())}")

Realized we can simplify that too

   self.cache_file.with_suffix(".stamp").write_text(f"{int(time.time())}")

The 'encoding' arg is redundant because we're only writing an integer
time value which is identical in every encoding.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


