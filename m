Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D557C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLDG-0005NI-Lc; Wed, 12 Mar 2025 08:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsLDF-0005Mr-8u
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsLDD-0002DL-D4
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741782566;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+deCsvQ3dHA9VrothVMyh9MngnHzgP7FPzbBFyHs2Q=;
 b=jLO4rrff+IKTcRAFU+UJM1qYnIY3FfTe7KcTBy2Y6XOPSdopJTj6ZofNDO0Efc2kgRunCg
 lnBb9thM0/NKvTgd7IXK3cl+6hokzYbb/B7ZvBdm39dtwnqb4VVdQZbBs17bD4bYwDEJiA
 TMgTWpFlqAeLq5oghWFDeKiZE7Zzt2k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-HMpxjDjLM7OzcxyKOoDUGQ-1; Wed,
 12 Mar 2025 08:29:24 -0400
X-MC-Unique: HMpxjDjLM7OzcxyKOoDUGQ-1
X-Mimecast-MFC-AGG-ID: HMpxjDjLM7OzcxyKOoDUGQ_1741782563
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB0EF180882E; Wed, 12 Mar 2025 12:29:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E8701801751; Wed, 12 Mar 2025 12:29:21 +0000 (UTC)
Date: Wed, 12 Mar 2025 12:29:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/3] tests/functional/asset: Add AssetError exception
 class
Message-ID: <Z9F-H3xPQfM2_51t@redhat.com>
References: <20250312122559.944533-1-npiggin@gmail.com>
 <20250312122559.944533-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250312122559.944533-4-npiggin@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Mar 12, 2025 at 10:25:58PM +1000, Nicholas Piggin wrote:
> Assets are uniquely identified by human-readable-ish url, so make an
> AssetError exception class that prints url with error message.
> 
> A property 'transient' is used to capture whether the client may retry
> or try again later, or if it is a serious and likely permanent error.
> This is used to retain the existing behaviour of treating HTTP errors
> other than 404 as 'transient' and not causing precache step to fail.
> Additionally, partial-downloads and stale asset caches that fail to
> resolve after the retry limit are now treated as transient and do not
> cause precache step to fail.
> 
> For background: The NetBSD archive is, at the time of writing, failing
> with short transfer. Retrying the fetch at that position (as wget does)
> results in a "503 backend unavailable" error. We would like to get that
> error code directly, but I have not found a way to do that with urllib,
> so treating the short-copy as a transient failure covers that case (and
> seems like a reasonable way to handle it in general).
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  roms/skiboot                        |  2 +-
>  tests/functional/qemu_test/asset.py | 43 +++++++++++++++++++----------
>  tests/lcitool/libvirt-ci            |  2 +-
>  3 files changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/roms/skiboot b/roms/skiboot
> index 24a7eb35966..785a5e3070a 160000
> --- a/roms/skiboot
> +++ b/roms/skiboot
> @@ -1 +1 @@
> -Subproject commit 24a7eb35966d93455520bc2debdd7954314b638b
> +Subproject commit 785a5e3070a86e18521e62fe202b87209de30fa2


> diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> index 18c4bfe02c4..b6a65806bc9 160000
> --- a/tests/lcitool/libvirt-ci
> +++ b/tests/lcitool/libvirt-ci
> @@ -1 +1 @@
> -Subproject commit 18c4bfe02c467e5639bf9a687139735ccd7a3fff
> +Subproject commit b6a65806bc9b2b56985f5e97c936b77c7e7a99fc

Two accidents here, with those removed

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


