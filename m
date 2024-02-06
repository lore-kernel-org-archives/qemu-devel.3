Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85848C48286
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 08:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXGYs-0007go-Vx; Tue, 06 Feb 2024 03:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXGYr-0007gP-8s
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:12:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXGYo-0007Sp-TC
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707207124;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=io2N46QtVIPDdVrPGW5R87CULP6c8TnM17Stnoj1FFA=;
 b=Nh25uaJrXfOx9ViyevbXUjsjETdQf58XsGDatqAQ4oqaPfMvEypb5FHqFWbtCYNlHTIzUC
 q/fbK2laBwHZ20a5Zcz6Gg8Ankjp1VGJSpIAwXfoxdIfMnecCDO7/rm+fnkAfXTllNLpqe
 KrEQT+l7lvtrqao1dhHHsVf8d/rH51o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-kF5P0wpVMC2anzeF9paUvw-1; Tue,
 06 Feb 2024 03:12:01 -0500
X-MC-Unique: kF5P0wpVMC2anzeF9paUvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49E813C000BA;
 Tue,  6 Feb 2024 08:12:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55EC42026D06;
 Tue,  6 Feb 2024 08:12:00 +0000 (UTC)
Date: Tue, 6 Feb 2024 08:11:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
Subject: Re: [PATCH 2/3] ci: Remove tag dependency for build-previous-qemu
Message-ID: <ZcHpzsLYCPwFPMUq@redhat.com>
References: <20240206063151.215986-1-peterx@redhat.com>
 <20240206063151.215986-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206063151.215986-3-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 06, 2024 at 02:31:50PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> The new build-previous-qemu job relies on QEMU release tag being present,
> while that may not be always true for personal git repositories since by
> default tag is not pushed.  The job can fail on those CI kicks, as reported
> by Peter Maydell.
> 
> Fix it by fetching the tags remotely from the official repository, as
> suggested by Dan.
> 
> [1] https://lore.kernel.org/r/ZcC9ScKJ7VvqektA@redhat.com
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 79bbc8585b..df48c9d31d 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -189,6 +189,8 @@ build-previous-qemu:
>      TARGETS: x86_64-softmmu aarch64-softmmu
>    before_script:
>      - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
> +    - git remote add upstream https://gitlab.com/qemu-project/qemu
> +    - git fetch upstream $QEMU_PRRV_VERSION

                              Typo^^^

>      - git checkout $QEMU_PREV_VERSION
>    after_script:
>      - mv build build-previous

With that typo fixed, then

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


