Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D5CC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk09o-000730-Fe; Tue, 12 Mar 2024 07:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rk09f-00070k-35
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rk09c-0007WB-65
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710242323;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tL/EZnRHTwfKMMozqgHXGwwunY974STts/do7SjV3rs=;
 b=P9BCDdsrdL4D1t2wUUIRrF7XsRQbXYPUknob0ACUQAbgEnF2EFOLPUSoZn5uPlZ4BrABGe
 C/XLr1FAn39e/M0ynApFVh4THYraynyoXnH01NXLYp4f7s7pGYt56pMX8+1pCvq2meU1/N
 +B0ich4FlNqFT6LvK7OmTbltRiNvc5E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-CQDpyML8NBSWBkM7r30_bw-1; Tue,
 12 Mar 2024 07:18:39 -0400
X-MC-Unique: CQDpyML8NBSWBkM7r30_bw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AC2B28C97C9;
 Tue, 12 Mar 2024 11:18:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B1C540C6DAD;
 Tue, 12 Mar 2024 11:18:39 +0000 (UTC)
Date: Tue, 12 Mar 2024 11:18:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] tests: Raise timeouts for bufferiszero and
 crypto-tlscredsx509
Message-ID: <ZfA6Df6jy9AdgnsK@redhat.com>
References: <20240312110815.116992-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312110815.116992-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 12, 2024 at 11:08:15AM +0000, Peter Maydell wrote:
> On our gcov CI job, the bufferiszero and crypto-tlscredsx509
> tests time out occasionally, making the job flaky. Double the
> timeout on these two tests.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2221
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> cc stable just because it probably helps CI reliability there too
> ---
>  tests/unit/meson.build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index cae925c1325..30db3c418fa 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -173,8 +173,9 @@ test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
>  
>  slow_tests = {
>    'test-aio-multithread' : 120,
> +  'test-bufferiszero': 60,
>    'test-crypto-block' : 300,
> -  'test-crypto-tlscredsx509': 45,
> +  'test-crypto-tlscredsx509': 90,
>    'test-crypto-tlssession': 45,

I'd probably suggest bumping this to 90 too, as it is a similar order
to CPU burn complexity to the other tls test - both of them create
a huge number of certs for testing many scenarios.

Either way,

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


