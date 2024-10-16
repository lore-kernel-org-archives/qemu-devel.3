Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECACD1AD35
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 09:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t10Mv-0006VD-5j; Wed, 16 Oct 2024 05:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t10Mu-0006V5-Ci
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 05:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t10Ms-0002cz-G5
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 05:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729071057;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DHSIvXqPAfmaUCm9uydRM3LXJx5OOQFCrvQmnAkDaR8=;
 b=Ff8pcXt6SDv8IyiQfsQ49gU6x0Zuz2kmPYmFcutosilWK8fXedvqjLb9goaT8/Oo/l/HCD
 /eVxz2b3+Rqge4+G27Mf7iBzzZ0jHalnksICEYj6a4nnF5PFkMKNV0OopT9GA6wUXaES5M
 r9nM21dvISvzWH74n0fzl7zYMkYdZ1w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-XRGil9cnMwSjfpKZPos3GQ-1; Wed,
 16 Oct 2024 05:30:53 -0400
X-MC-Unique: XRGil9cnMwSjfpKZPos3GQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C988F19560B1; Wed, 16 Oct 2024 09:30:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B927F30001A6; Wed, 16 Oct 2024 09:30:44 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:30:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/functional: Convert most Aspeed machine tests
Message-ID: <Zw-HwHsGaO0W2fbc@redhat.com>
References: <20241016090741.2026630-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016090741.2026630-1-clg@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Oct 16, 2024 at 11:07:41AM +0200, Cédric Le Goater wrote:
> This is a simple conversion of the tests with some cleanups and
> adjustments to match the new test framework. Replace the zephyr image
> MD5 hashes with SHA256 hashes while at it.
> 
> The SDK tests depend on a ssh class from avocado.utils which is
> difficult to replace. To be addressed separately.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  tests/avocado/machine_aspeed.py     | 252 --------------------------
>  tests/functional/meson.build        |   2 +
>  tests/functional/test_arm_aspeed.py | 269 ++++++++++++++++++++++++++++
>  3 files changed, 271 insertions(+), 252 deletions(-)
>  create mode 100644 tests/functional/test_arm_aspeed.py
> 
> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
> new file mode 100644
> index 000000000000..2f9a90f64d8f
> --- /dev/null
> +++ b/tests/functional/test_arm_aspeed.py
> @@ -0,0 +1,269 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED SoCs with firmware
> +#
> +# Copyright (C) 2022 ASPEED Technology Inc
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import time
> +import subprocess
> +import tempfile
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +from qemu_test import exec_command_and_wait_for_pattern
> +from qemu_test import interrupt_interactive_console_until_pattern
> +from qemu_test import exec_command
> +from qemu_test import has_cmd
> +from qemu_test.utils import archive_extract
> +from zipfile import ZipFile
> +from unittest import skipUnless
> +
> +class AST1030Machine(QemuSystemTest):
> +
> +    def test_ast1030_zephyros_1_04(self):
> +        asset_url = Asset(
> +            ('https://github.com/AspeedTech-BMC'
> +             '/zephyr/releases/download/v00.01.04/ast1030-evb-demo.zip'),
> +            '4ac6210adcbc61294927918707c6762483fd844dde5e07f3ba834ad1f91434d3')

Don't instantiate assets inline to test code, as this makes them
invisible to the logic that pre-downloads assets prior to running
tests. As a result you're liable to have test timeouts if the
on-the-fly asset download takes too long.

Instead You should use a class level varible with an "ASSET_" name
prefix eg

   ASSET_<BLAH> = Asset(....)

See other converted tests for examples of the pattern.

> +        kernel_name = "ast1030-evb-demo/zephyr.elf"
> +        zip_file = asset_url.fetch()
> +        with ZipFile(zip_file, 'r') as zf:
> +                     zf.extract(kernel_name, path=self.workdir)
> +        kernel_file = os.path.join(self.workdir, kernel_name)
> +
> +        self.set_machine('ast1030-evb')
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_file, '-nographic')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, "Booting Zephyr OS")
> +        exec_command_and_wait_for_pattern(self, "help",
> +                                          "Available commands")
> +

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


