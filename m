Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F33CD6E56
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smFoe-0002WH-AA; Thu, 05 Sep 2024 12:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smFob-0002KZ-FZ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smFoZ-0005LP-3X
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725555513;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QsRnToFN2uYlaO3MYajvoKyTWPvqdGQTGSoMfS9fwoU=;
 b=M7U4PpJQj4+lwJJneW6EN7yVUyp/Yjq4cY/BtyWOAcRUhuNTBO4fykVDnK2bi1mw/UyKdk
 wKe8N80r2FsSbTOIXt9xnJEe3/58diSuSaKFkmwKsxnbrnFFzVGRP+zLPqUumviI9v3kWg
 /44j3lqlybXYSuPtOYFFBaVPz6+BGpE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-GlQpiCz2OQO9OU4AX62ULA-1; Thu,
 05 Sep 2024 12:58:31 -0400
X-MC-Unique: GlQpiCz2OQO9OU4AX62ULA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA4251955BE1; Thu,  5 Sep 2024 16:58:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F0BC1955F45; Thu,  5 Sep 2024 16:58:27 +0000 (UTC)
Date: Thu, 5 Sep 2024 17:58:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] tests/qtest: Add missing qtest_quit() to stm32 tests
Message-ID: <ZtnjL5fTVJWJ0Owj@redhat.com>
References: <20240905165554.320577-1-peter.maydell@linaro.org>
 <20240905165554.320577-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240905165554.320577-2-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Sep 05, 2024 at 05:55:53PM +0100, Peter Maydell wrote:
> In the dm163-test and stm32l4x5_usart-test, a couple of subtests are
> missing the qtest_quit() call.  The effect of this is that on hosts
> other than Linux and FreeBSD the test will timeout after executing
> all the tests:
> 
> 242/845 qemu:qtest+qtest-arm / qtest-arm/dm163-test                               TIMEOUT         60.04s   3 subtests passed
> 100/845 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_usart-test                     TIMEOUT        600.02s   5 subtests passed
> 
> This happens because the qemu-system-arm binary which the test
> starts does not exit, and because it shares the stdout with the
> test binary, the overall meson test harness thinks the test is
> still running. On Linux and FreeBSD we have an extra safety net
> set up in qtest_spawn_qemu() which kills off any QEMU binary that
> ends up without a parent. This is intended for the case where
> QEMU crashed and didn't respond to a SIGTERM or polite request
> to quit, but it also sidestepped the problem in this case.
> However, OpenBSD doesn't have a PDEATHSIG equivalent, so we
> see the timeouts when running a 'make vm-build-openbsd' run.
> 
> Add the missing qtest_quit() calls.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Many thanks to Dan Berrangé for diagnosing the cause of this hang...
> Dan also suggested on IRC that we should support g_autoptr for
> the QTestState, so you don't need to manually qtest_quit(). But
> for the immediate fix, I just add the missing calls.
> ---
>  tests/qtest/dm163-test.c           | 2 ++
>  tests/qtest/stm32l4x5_usart-test.c | 2 ++
>  2 files changed, 4 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


