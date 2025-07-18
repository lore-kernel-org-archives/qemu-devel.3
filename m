Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20448C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 09:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uchIr-0004Mh-Mo; Fri, 18 Jul 2025 05:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uchGt-0001oi-AM
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uchGo-0004kV-BG
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752830443;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6pBhrNTfMsddwGB+laQnyVT5zoSOo4gs6dG+UlZDoYs=;
 b=W+IQ1UOKnsOdoNqAYnKeDTRxEk4mFFO6rb+99M+P3bi+lB5BTNJqAg55whDzfSngeQ5nxL
 3cQWyKUnOAfJXP2WfSl+03srKySeG3/4nNXGJS2r3zMvUWRAKTGcvw5IYUtgzo0Hn4a/sz
 gdWSZtTdUnabfkEgSmqxnR1rIPwmwKs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-d43oB4-zMgCY1zcKY0lVQw-1; Fri,
 18 Jul 2025 05:20:41 -0400
X-MC-Unique: d43oB4-zMgCY1zcKY0lVQw-1
X-Mimecast-MFC-AGG-ID: d43oB4-zMgCY1zcKY0lVQw_1752830440
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36A35195FDD9; Fri, 18 Jul 2025 09:20:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A25D1800D82; Fri, 18 Jul 2025 09:20:37 +0000 (UTC)
Date: Fri, 18 Jul 2025 10:20:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2] tests/functional: add --debug CLI arg
Message-ID: <aHoR4YgTKOgGsZgT@redhat.com>
References: <20250717-functional_tests_debug_arg-v2-1-4f0d991e16f7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717-functional_tests_debug_arg-v2-1-4f0d991e16f7@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 17, 2025 at 01:34:13PM +0300, Manos Pitsidianakis wrote:
> Add argument parsing to functional tests to improve developer experience
> when running individual tests. All logs are printed to stdout
> interspersed with TAP output.
> 
> Example usage, assuming current build directory with qemu source code in
> the parent directory (see docs/devel/testing/functional.rst for details):
> 
>   $ export PYTHONPATH=../python:../tests/functional
>   $ export QEMU_TEST_QEMU_BINARY="$(pwd)/qemu-system-aarch64"
>   $ ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
>   usage: test_aarch64_virt [-h] [-d]
> 
>   QEMU Functional test
> 
>   options:
>     -h, --help   show this help message and exit
>     -d, --debug  Also print test and console logs on stdout. This will
>                  make the TAP output invalid and is meant for debugging
>                  only.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Changes in v2:
> - Store stdout handler in `self` object (thanks Daniel)
> - Deduplicate handler removal code (Daniel)
> - Amend commit description to mention PYTHONPATH (thanks Alex)
> - Link to v1: https://lore.kernel.org/qemu-devel/20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org

You've ignored my v1 review requests that the code for creating
log handlers should be moved into a helper method in util.py, and
likewise that the argparse code moved into util.py, and thus not
called in both main & setUp.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


