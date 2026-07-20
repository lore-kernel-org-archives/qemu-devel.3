Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D345C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqqS-0004fo-8b; Mon, 20 Jul 2026 12:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wlqqP-0004dG-Ew
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wlqqN-0001n8-QR
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784564871;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRdUvBVdW2JSMvhgyap2ynHQUuKL1QkqeqYGxtQaBNY=;
 b=cYlZiNzcWxEGQoH0GeMotO2X4e8R3Iks9yXX75aWm0WuAxMp/KyEFpG2iKjskS9SarLGmi
 /pJpjrJqcDZCKRT0erLaYGS9ruKgopIwHQM/vrGIQiisAp/loGRFgPoQpok14HbXBBckSS
 aOAGtWrzgaNYve54PgDp7V7RNkjSh2k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-Fcqke1cJPbKLuxVCC0ZmUA-1; Mon,
 20 Jul 2026 12:27:47 -0400
X-MC-Unique: Fcqke1cJPbKLuxVCC0ZmUA-1
X-Mimecast-MFC-AGG-ID: Fcqke1cJPbKLuxVCC0ZmUA_1784564864
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 060791955F1F; Mon, 20 Jul 2026 16:27:44 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 791F8195422C; Mon, 20 Jul 2026 16:27:40 +0000 (UTC)
Date: Mon, 20 Jul 2026 17:27:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 kane_chen@aspeedtech.com, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] tests/functional/aspeed: Fix remaining hostname-specific
 login prompts
Message-ID: <al5MeE5rPlZz4hFA@redhat.com>
References: <20260720162321.3497633-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720162321.3497633-1-clg@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Jul 20, 2026 at 06:23:21PM +0200, Cédric Le Goater wrote:
> Commit b04746bd0d7c unified boot completion detection on the generic
> 'login:' prompt but missed several SDK test files that still matched
> on hostname-prefixed patterns. Apply the same fix.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4059
> Fixes: b04746bd0d7c ("tests/functional/aspeed: unify boot completion detection on 'login:' prompt")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  tests/functional/aarch64/test_aspeed_ast2700a1.py   | 2 +-
>  tests/functional/aarch64/test_aspeed_ast2700a2.py   | 2 +-
>  tests/functional/aarch64/test_aspeed_ast2700fc.py   | 2 +-
>  tests/functional/arm/test_aspeed_ast2500_sdk.py     | 2 +-
>  tests/functional/arm/test_aspeed_ast2500_sdk_515.py | 2 +-
>  tests/functional/arm/test_aspeed_ast2600_sdk.py     | 2 +-
>  tests/functional/arm/test_aspeed_ast2600_sdk_515.py | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


