Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBE1CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 14:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utomW-00006L-Vo; Wed, 03 Sep 2025 10:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1utomR-00005N-GI
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1utomM-0006PI-Dj
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756910884;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=D9MwU7IKA98B3/gJ/+fPueAUtK8byrC29vPHBwx50f0=;
 b=Ym4Ig8Je+Ur91UwdiUcmYq50k7wEwPi9WOUKETZC2aae9GBJV5mozrNF5YVbovAIYyQwZy
 xYiHg3G7B9G7qoCa2R/cH10iimHoti99IJOoyUjQcy+h8KSh9AOcrbVvOHbhlnFKA3apIp
 xGN6JBG2HPRO54kWcWkBWAS0FPIJCPo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-spzhsw-TPpie8ha0yxfBCQ-1; Wed,
 03 Sep 2025 10:48:03 -0400
X-MC-Unique: spzhsw-TPpie8ha0yxfBCQ-1
X-Mimecast-MFC-AGG-ID: spzhsw-TPpie8ha0yxfBCQ_1756910881
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B4D018002C3; Wed,  3 Sep 2025 14:48:01 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.63])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00E5D19560AB; Wed,  3 Sep 2025 14:47:55 +0000 (UTC)
Date: Wed, 3 Sep 2025 16:47:51 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 peterx@redhat.com, mst@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2 8/8] tests/functional: add test_x86_64_tap_fd_migration
Message-ID: <aLhVF3_OFMzKpuUW@redhat.com>
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
 <20250903133706.1177633-9-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903133706.1177633-9-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Wed, Sep 03, 2025 at 04:37:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add test for a new feature of local TAP migration with fd passing
> through unix socket.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  .../test_x86_64_tap_fd_migration.py           | 347 ++++++++++++++++++
>  1 file changed, 347 insertions(+)
>  create mode 100644 tests/functional/test_x86_64_tap_fd_migration.py
> 
> diff --git a/tests/functional/test_x86_64_tap_fd_migration.py b/tests/functional/test_x86_64_tap_fd_migration.py
> new file mode 100644
> index 0000000000..f6d18fe39f
> --- /dev/null
> +++ b/tests/functional/test_x86_64_tap_fd_migration.py
> @@ -0,0 +1,347 @@
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
> +import signal
> +from typing import Tuple
> +
> +from qemu_test import (
> +    LinuxKernelTest,
> +    Asset,
> +    exec_command_and_wait_for_pattern,
> +)
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
> +def run(cmd: str, check: bool = True) -> None:
> +    subprocess.run(cmd, check=check, shell=True)

I don't see need to be using shell here - just use
"check_call()" and pass the argv as an array instead
of a string at which point this 'run' helper can be
removed.

> +
> +
> +def fetch(cmd: str, check: bool = True) -> str:
> +    return subprocess.run(
> +        cmd, check=check, shell=True, stdout=subprocess.PIPE, text=True
> +    ).stdout
> +
> +
> +def del_tap() -> None:
> +    run(f"ip tuntap del {TAP_ID} mode tap multi_queue", check=False)
> +
> +
> +def init_tap() -> None:
> +    run(f"ip tuntap add dev {TAP_ID} mode tap multi_queue")
> +    run(f"ip link set dev {TAP_ID} address {TAP_MAC}")
> +    run(f"ip addr add {HOST_IP_MASK} dev {TAP_ID}")
> +    run(f"ip link set {TAP_ID} up")

$ ip tuntap add dev foo mode tap multi_queue
ioctl(TUNSETIFF): Operation not permitted


The functional tests run as the developer's normal unprivileged user
account, so it doesn't look like this can work ?

Were you testing this as root ?

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
> +
> +        super().tearDown()
> +
> +    def start_outer_ping(self) -> None:
> +        assert self.outer_ping_proc is None
> +        self.outer_ping_log = open("/tmp/ping.log", "w")
> +        self.outer_ping_proc = subprocess.Popen(
> +            ["ping", "-i", "0", "-O", "-D", GUEST_IP],
> +            text=True,
> +            stdout=self.outer_ping_log,
> +        )

Surely outer_ping_log can be closed immediately as the child
process will keep the FD open ?

> +
> +    def stop_outer_ping(self) -> str:
> +        assert self.outer_ping_proc
> +        self.outer_ping_proc.send_signal(signal.SIGINT)
> +
> +        self.outer_ping_proc.communicate(timeout=5)
> +        self.outer_ping_proc = None
> +        self.outer_ping_log.close()
> +
> +        # We need the start, the end and several lines around "no answer"
> +        cmd = "cat /tmp/ping.log | grep -A 4 -B 4 'PING\\|packets\\|no ans'"
> +        return fetch(cmd)

IMHO this can just read the whole of /tmp/ping.log directly into memory
and then the parse_ping_output can jjust match on it with a regex,
avoiding the pre-processing with grep.


> +
> +    def stop_ping_and_check(self, stop_time, resume_time):
> +        ping_res = self.stop_outer_ping()
> +
> +        discon, a, b = parse_ping_output(ping_res)
> +
> +        if not discon:
> +            text = f"STOP: {stop_time}, RESUME: {resume_time}," f"PING: {a} - {b}"
> +            if a > stop_time or b < resume_time:
> +                self.fail(f"PING failed: {text}")
> +            self.log.info(f"PING: no packets lost: {text}")
> +            return
> +
> +        text = (
> +            f"STOP: {stop_time}, RESUME: {resume_time}," f"PING: disconnect: {a} - {b}"
> +        )
> +        self.log.info(text)
> +        eps = 0.01
> +        if a < stop_time - eps or b > resume_time + eps:
> +            self.fail(text)
> +
> +    def one_ping_from_guest(self, vm) -> None:
> +        exec_command_and_wait_for_pattern(
> +            self,
> +            f"ping -c 1 -W 1 {HOST_IP}",
> +            "1 packets transmitted, 1 packets received",
> +            "1 packets transmitted, 0 packets received",
> +            vm=vm,
> +        )
> +        self.wait_for_console_pattern("# ", vm=vm)
> +
> +    def one_ping_from_host(self) -> None:
> +        run(f"ping -c 1 -W 1 {GUEST_IP}")
> +
> +    def setup_shared_memory(self):
> +        shm_path = f"/dev/shm/qemu_test_{os.getpid()}"
> +
> +        try:
> +            with open(shm_path, "wb") as f:
> +                f.write(b"\0" * (1024 * 1024 * 1024))  # 1GB
> +        except Exception as e:
> +            self.fail(f"Failed to create shared memory file: {e}")
> +
> +        return shm_path
> +
> +    def prepare_and_launch_vm(self, shm_path, vhost, incoming=False, vm=None):
> +        if not vm:
> +            vm = self.vm
> +
> +        vm.set_console()
> +        vm.add_args("-accel", "kvm")
> +        vm.add_args("-device", "pcie-pci-bridge,id=pci.1,bus=pcie.0")
> +        vm.add_args("-m", "1G")
> +
> +        vm.add_args(
> +            "-object",
> +            f"memory-backend-file,id=ram0,size=1G,mem-path={shm_path},share=on",
> +        )
> +        vm.add_args("-machine", "memory-backend=ram0")
> +
> +        vm.add_args(
> +            "-drive", f"file={self.ASSET_ALPINE_ISO.fetch()},media=cdrom,format=raw"
> +        )
> +
> +        vm.add_args("-S")
> +
> +        if incoming:
> +            vm.add_args("-incoming", "defer")
> +
> +        vm_s = "target" if incoming else "source"
> +        self.log.info(f"Launching {vm_s} VM")
> +        vm.launch()
> +
> +        self.set_migration_capabilities(vm)
> +        self.add_virtio_net(vm, vhost, incoming)
> +
> +    def add_virtio_net(self, vm, vhost: bool, incoming: bool = False):
> +        netdev_params = {
> +            "id": "netdev.1",
> +            "vhost": vhost,
> +            "type": "tap",
> +            "ifname": "tap0",
> +            "downscript": "no",
> +            "queues": 4,
> +        }
> +
> +        if incoming:
> +            netdev_params["local-incoming"] = True
> +        else:
> +            netdev_params["script"] = "no"
> +
> +        vm.cmd("netdev_add", netdev_params)
> +
> +        vm.cmd(
> +            "device_add",
> +            driver="virtio-net-pci",
> +            romfile="",
> +            id="vnet.1",
> +            netdev="netdev.1",
> +            mq=True,
> +            vectors=18,
> +            bus="pci.1",
> +            mac=GUEST_MAC,
> +            disable_legacy="off",
> +        )
> +
> +    def set_migration_capabilities(self, vm):
> +        capabilities = [
> +            {"capability": "events", "state": True},
> +            {"capability": "x-ignore-shared", "state": True},
> +            {"capability": "local-tap", "state": True},
> +        ]
> +        vm.cmd("migrate-set-capabilities", {"capabilities": capabilities})
> +
> +    def setup_guest_network(self) -> None:
> +        exec_command_and_wait_for_pattern(self, "ip addr", "# ")
> +        exec_command_and_wait_for_pattern(
> +            self,
> +            f"ip addr add {GUEST_IP_MASK} dev eth0 && ip link set eth0 up && echo OK",
> +            "OK",
> +        )
> +        self.wait_for_console_pattern("# ")
> +
> +    def do_test_tap_fd_migration(self, vhost):
> +        self.require_accelerator("kvm")
> +        self.set_machine("q35")
> +
> +        socket_dir = self.socket_dir()
> +        migration_socket = os.path.join(socket_dir.name, "migration.sock")
> +
> +        shm_path = self.setup_shared_memory()
> +
> +        self.prepare_and_launch_vm(shm_path, vhost)
> +        self.vm.cmd("cont")
> +        self.wait_for_console_pattern("login:")
> +        exec_command_and_wait_for_pattern(self, "root", "# ")
> +
> +        self.setup_guest_network()
> +
> +        self.one_ping_from_guest(self.vm)
> +        self.one_ping_from_host()
> +        self.start_outer_ping()
> +
> +        # Get some successful pings before migration
> +        time.sleep(0.5)
> +
> +        target_vm = self.get_vm(name="target")
> +        self.prepare_and_launch_vm(shm_path, vhost, incoming=True, vm=target_vm)
> +
> +        target_vm.cmd("migrate-incoming", {"uri": f"unix:{migration_socket}"})
> +
> +        self.log.info("Starting migration")
> +        freeze_start = time.time()
> +        self.vm.cmd("migrate", {"uri": f"unix:{migration_socket}"})
> +
> +        self.log.info("Waiting for migration completion")
> +        wait_migration_finish(self.vm, target_vm)
> +
> +        target_vm.cmd("cont")
> +        freeze_end = time.time()
> +
> +        self.vm.shutdown()
> +
> +        self.log.info("Verifying PING on target VM after migration")
> +        self.one_ping_from_guest(target_vm)
> +        self.one_ping_from_host()
> +
> +        # And a bit more pings after source shutdown
> +        time.sleep(0.3)
> +        self.stop_ping_and_check(freeze_start, freeze_end)
> +
> +        target_vm.shutdown()
> +
> +    def test_tap_fd_migration(self):
> +        self.do_test_tap_fd_migration(False)
> +
> +    def test_tap_fd_migration_vhost(self):
> +        self.do_test_tap_fd_migration(True)
> +
> +
> +if __name__ == "__main__":
> +    LinuxKernelTest.main()
> -- 
> 2.48.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


