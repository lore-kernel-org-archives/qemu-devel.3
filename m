Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E792E9D800
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 18:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Rs9-0007vV-NX; Sun, 05 Apr 2026 14:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1w9Rs8-0007vA-7F
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 14:06:56 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1w9Rs6-0003dJ-5H
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 14:06:55 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 5FB1F240029
 for <qemu-devel@nongnu.org>; Sun,  5 Apr 2026 20:06:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu; s=2017;
 t=1775412411; bh=jmhmse9x3N7NO6eCDFxe+fhPthnWKL1/n/S2Iarfx4Y=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=Yxj2L9e48eZ1JQnrI+uMmmXd/85O1Wp/KvULILq3eEszew3SUsDccZ0HVAR40PY90
 ab2y6iII2OVO492gRfN6S5owts+df2iBiEbsFzglViuO5eS5+KWTOhpW5+RWrlC6HV
 JY8itOnMFWU0RkUsPMq8ZOxqtSvn/zeSQNDyBKf7YVGjZ4jMq5D08vtL2foTfDvYUi
 UM4s6Or8mn0CI8WgHslM7m8aalPcyuEdrGfFmxfYtrY7TDrZpChy15ij3MA3uC3+rB
 vT9/imZFAbLdQxvzOecnG6l8hPgjBKoia5StzCOyH0sPNJe39J6rf3XJZ1LYRmjatX
 u/iECSYJpBGKg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4fpgQK4lHvz9rxF;
 Sun,  5 Apr 2026 20:06:49 +0200 (CEST)
Date: Sun, 05 Apr 2026 18:06:50 +0000
From: Thomas Huth <th.huth+qemu@posteo.eu>
To: Christian Brauner <brauner@kernel.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake
 <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 5/5] tests/functional: add e2e test for dynamic QMP
 monitor hotplug
Message-ID: <20260405200648.1f7c6a3d@tpx1>
In-Reply-To: <20260402-work-qmp-monitor-hotplug-v1-5-6313a5cdd574@kernel.org>
References: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
 <20260402-work-qmp-monitor-hotplug-v1-5-6313a5cdd574@kernel.org>
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
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 Hi Christian!

Am Thu, 02 Apr 2026 23:19:20 +0200
schrieb Christian Brauner <brauner@kernel.org>:

> Add a functional test that exercises the full monitor hotplug lifecycle
> with a real socket connection:
> 
> 1. Launch QEMU
> 2. chardev-add a unix socket chardev
> 3. monitor-add to attach a QMP monitor to it
> 4. Connect to the socket, receive the QMP greeting, negotiate
>    capabilities, and send a query-version command
> 5. Disconnect, monitor-remove, chardev-remove
> 6. Repeat the entire cycle a second time to verify cleanup and reuse
> 
> This complements the qtest unit tests by verifying that a real QMP
> client can connect to a dynamically-added monitor and exchange messages.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
...
> diff --git a/tests/functional/generic/test_monitor_hotplug.py b/tests/functional/generic/test_monitor_hotplug.py
> new file mode 100644
> index 0000000000..f8f24320c6
> --- /dev/null
> +++ b/tests/functional/generic/test_monitor_hotplug.py
> @@ -0,0 +1,102 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test for dynamic QMP monitor hotplug
> +#
> +# Copyright (c) 2026 Christian Brauner
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.

Please add a SPDX license identifier for new files - otherwise
scripts/checkpatch.pl will complain.

(and bonus points for fixing all warnings from pylint ;-))

> +import os
> +import tempfile
> +
> +from qemu.qmp.legacy import QEMUMonitorProtocol
> +
> +from qemu_test import QemuSystemTest
> +
> +
> +class MonitorHotplug(QemuSystemTest):
> +
> +    def setUp(self):
> +        super().setUp()
> +        # Use /tmp to avoid UNIX socket path length limit (108 bytes).
> +        # The scratch_file() path is too deep for socket names.
> +        fd, self._sock_path = tempfile.mkstemp(
> +            prefix='qemu-mon-', suffix='.sock')

We've got a socket_dir() function in the test framework to create socket
paths ... could you use that one instead?

Apart from that, patch looks fine to me.

 Thomas


