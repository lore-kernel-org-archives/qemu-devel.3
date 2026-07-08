Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE38CC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whNUx-000331-Od; Wed, 08 Jul 2026 04:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whNUw-00032f-OM
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whNUv-0004WY-0u
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783498752;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=o2llFRgv0N0WDUaVpnK9z7f/5wqW7d23dt1Kv45JrwU=;
 b=XZszjw8jNgolGJgDRJttJ7ayKCwZf/PXOzN1wfx8mYO83woS5ve0iHYuxEPDjAQQefH3hk
 HROl5dWBoexf5xJh1ylV9Z4iQ6qzQEOnLZhe0ciOc58lwdm+U8nwKa5e2T7ugs7/A+2m89
 PCx+pb2PSIZthnSiXzFIHXGBVwLbNjU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-0P03_ZkSM1musCwmHv2OKQ-1; Wed,
 08 Jul 2026 04:19:09 -0400
X-MC-Unique: 0P03_ZkSM1musCwmHv2OKQ-1
X-Mimecast-MFC-AGG-ID: 0P03_ZkSM1musCwmHv2OKQ_1783498747
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EDA01955F3B; Wed,  8 Jul 2026 08:19:07 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AAB61956056; Wed,  8 Jul 2026 08:19:04 +0000 (UTC)
Date: Wed, 8 Jul 2026 09:19:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk,
 richard.henderson@linaro.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, mjt@tls.msk.ru
Subject: Re: [PATCH 2/4] tests/docker/dockerfiles/ubuntu2404.docker: add
 missing apt update
Message-ID: <ak4H9Tn-t5rRH3oJ@redhat.com>
References: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260707214655.1138626-3-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707214655.1138626-3-pierrick.bouvier@oss.qualcomm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 07, 2026 at 02:46:53PM -0700, Pierrick Bouvier wrote:
> RUN statements should always use apt update && apt install together:
> https://docs.docker.com/build/building/best-practices/#apt-get
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/ubuntu2404.docker | 3 ++-
>  tests/lcitool/refresh                      | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
> index 26bc2dd94f4..27992e34fd9 100644
> --- a/tests/docker/dockerfiles/ubuntu2404.docker
> +++ b/tests/docker/dockerfiles/ubuntu2404.docker
> @@ -160,7 +160,8 @@ ENV RUSTC=/usr/bin/rustc-1.83
>  ENV RUSTDOC=/usr/bin/rustdoc-1.83
>  ENV CARGO_HOME=/usr/local/cargo
>  ENV PATH=$CARGO_HOME/bin:$PATH
> -RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +RUN apt update && \
> +  DEBIAN_FRONTEND=noninteractive eatmydata \
>    apt install -y --no-install-recommends cargo
>  RUN cargo install --locked bindgen-cli
>  # As a final step configure the user (if env is defined)
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 1fdd37440c9..bbbc6d3c46a 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -157,7 +157,8 @@ ENV RUSTC=/usr/bin/rustc-1.83
>  ENV RUSTDOC=/usr/bin/rustdoc-1.83
>  ENV CARGO_HOME=/usr/local/cargo
>  ENV PATH=$CARGO_HOME/bin:$PATH
> -RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +RUN apt update && \
> +  DEBIAN_FRONTEND=noninteractive eatmydata \
>    apt install -y --no-install-recommends cargo
>  RUN cargo install --locked bindgen-cli

So lcitool already ran 'apt update' earlier, but if we're trying to
avoid caching issues, I guess running it again is needed. Should we
also run 'apt dist-upgrade' though, as already installed content in
the cached layer can be outdated.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


