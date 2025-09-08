Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2260FCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uveH1-0007ma-V8; Mon, 08 Sep 2025 11:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uveGx-0007lo-4b
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uveGk-0008Pu-Tv
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757347135;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PXxoAEODr4qLJnWEJWlnG1FDjrxNM0b3AVJFBsC8ulg=;
 b=EeqNRnPqHGEMQNOhLu806F8R/MalSC55I0+WhH56lA8v9p+X3RfY7SvEcsMpIqtNqT26wb
 edD67r3Djw3x8jypxgdCLW2bFQCCfRcvk9/aHUiRmpbmk5JxoXPLnSO+zERRBn/du+2zuw
 FAJjyKoLqa5qbAKILJ32dSXrC9b4dFo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-L5kvDdZ7Mviwje2m5K1pEw-1; Mon,
 08 Sep 2025 11:58:51 -0400
X-MC-Unique: L5kvDdZ7Mviwje2m5K1pEw-1
X-Mimecast-MFC-AGG-ID: L5kvDdZ7Mviwje2m5K1pEw_1757347130
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 690CD1956095; Mon,  8 Sep 2025 15:58:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1685F1800576; Mon,  8 Sep 2025 15:58:45 +0000 (UTC)
Date: Mon, 8 Sep 2025 16:58:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 peterx@redhat.com, mst@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v3 9/9] tests/functional: add test_x86_64_tap_fd_migration
Message-ID: <aL79MidaXn4KpK_h@redhat.com>
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
 <20250905135039.2202924-10-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905135039.2202924-10-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Sep 05, 2025 at 04:50:39PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add test for a new feature of local TAP migration with fd passing
> through unix socket.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  .../test_x86_64_tap_fd_migration.py           | 345 ++++++++++++++++++
>  1 file changed, 345 insertions(+)
>  create mode 100644 tests/functional/test_x86_64_tap_fd_migration.py
> 
> diff --git a/tests/functional/test_x86_64_tap_fd_migration.py b/tests/functional/test_x86_64_tap_fd_migration.py
> new file mode 100644
> index 0000000000..a38dba39fe
> --- /dev/null
> +++ b/tests/functional/test_x86_64_tap_fd_migration.py
> @@ -0,0 +1,345 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that tests TAP local migration
> +# with fd passing
> +#
> +# Copyright (c) Yandex
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import time
> +import subprocess
> +from subprocess import run
> +import signal
> +from typing import Tuple
> +
> +from qemu_test import (
> +    LinuxKernelTest,
> +    Asset,
> +    exec_command_and_wait_for_pattern,
> +)
> +from qemu_test.decorators import skipUnlessPasswordlessSudo
> +
> +GUEST_IP = "10.0.1.2"
> +GUEST_IP_MASK = f"{GUEST_IP}/24"
> +GUEST_MAC = "d6:0d:75:f8:0f:b7"
> +HOST_IP = "10.0.1.1"
> +HOST_IP_MASK = f"{HOST_IP}/24"
> +TAP_ID = "tap0"
> +TAP_MAC = "e6:1d:44:b5:03:5d"
> +
> +
> +def del_tap() -> None:
> +    run(
> +        ["sudo", "ip", "tuntap", "del", TAP_ID, "mode", "tap", "multi_queue"],
> +        check=True,
> +    )
> +
> +
> +def init_tap() -> None:
> +    run(
> +        ["sudo", "ip", "tuntap", "add", "dev", TAP_ID, "mode", "tap", "multi_queue"],
> +        check=True,
> +    )
> +    run(["sudo", "ip", "link", "set", "dev", TAP_ID, "address", TAP_MAC], check=True)
> +    run(["sudo", "ip", "addr", "add", HOST_IP_MASK, "dev", TAP_ID], check=True)
> +    run(["sudo", "ip", "link", "set", TAP_ID, "up"], check=True)
> +
> +
> +def parse_ping_line(line: str) -> float:
> +    # suspect lines like
> +    # [1748524876.590509] 64 bytes from 94.245.155.3 \
> +    #      (94.245.155.3): icmp_seq=1 ttl=250 time=101 ms
> +    spl = line.split()
> +    return float(spl[0][1:-1])
> +
> +
> +def parse_ping_output(out) -> Tuple[bool, float, float]:
> +    lines = [x for x in out.split("\n") if x.startswith("[")]
> +
> +    try:
> +        first_no_ans = next(
> +            (ind for ind in range(len(lines)) if lines[ind][20:26] == "no ans")
> +        )
> +    except StopIteration:
> +        return False, parse_ping_line(lines[0]), parse_ping_line(lines[-1])
> +
> +    last_no_ans = next(
> +        (ind for ind in range(len(lines) - 1, -1, -1) if lines[ind][20:26] == "no ans")
> +    )
> +
> +    return (
> +        True,
> +        parse_ping_line(lines[first_no_ans]),
> +        parse_ping_line(lines[last_no_ans]),
> +    )
> +
> +
> +def wait_migration_finish(source_vm, target_vm):
> +    migr_events = (
> +        ("MIGRATION", {"data": {"status": "completed"}}),
> +        ("MIGRATION", {"data": {"status": "failed"}}),
> +    )
> +
> +    source_e = source_vm.events_wait(migr_events)["data"]
> +    target_e = target_vm.events_wait(migr_events)["data"]
> +
> +    source_s = source_vm.cmd("query-status")["status"]
> +    target_s = target_vm.cmd("query-status")["status"]
> +
> +    assert (
> +        source_e["status"] == "completed"
> +        and target_e["status"] == "completed"
> +        and source_s == "postmigrate"
> +        and target_s == "paused"
> +    ), f"""Migration failed:
> +    SRC status: {source_s}
> +    SRC event: {source_e}
> +    TGT status: {target_s}
> +    TGT event:{target_e}"""
> +
> +
> +@skipUnlessPasswordlessSudo()
> +class VhostUserBlkFdMigration(LinuxKernelTest):
> +
> +    ASSET_KERNEL = Asset(
> +        (
> +            "https://archives.fedoraproject.org/pub/archive/fedora/linux/releases"
> +            "/31/Server/x86_64/os/images/pxeboot/vmlinuz"
> +        ),
> +        "d4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129",
> +    )
> +
> +    ASSET_INITRD = Asset(
> +        (
> +            "https://archives.fedoraproject.org/pub/archive/fedora/linux/releases"
> +            "/31/Server/x86_64/os/images/pxeboot/initrd.img"
> +        ),
> +        "277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b",
> +    )
> +
> +    ASSET_ALPINE_ISO = Asset(
> +        (
> +            "https://dl-cdn.alpinelinux.org/"
> +            "alpine/v3.22/releases/x86_64/alpine-standard-3.22.1-x86_64.iso"
> +        ),
> +        "96d1b44ea1b8a5a884f193526d92edb4676054e9fa903ad2f016441a0fe13089",
> +    )
> +
> +    def setUp(self):
> +        super().setUp()
> +
> +        init_tap()
> +
> +        self.outer_ping_proc = None
> +
> +    def tearDown(self):
> +        del_tap()
> +
> +        if self.outer_ping_proc:
> +            self.stop_outer_ping()

Wrap the del_tap() and onwards in a 'try' clause and then
use 'finally' to run the parent tearDown, so we're more
robust if anything throws an exception

> +
> +        super().tearDown()

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


