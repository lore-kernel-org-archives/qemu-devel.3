Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8FDD0D14C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 17:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdXPH-0003HB-E1; Wed, 07 Jan 2026 12:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vdXPA-0003GV-St
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:33:08 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vdXP6-0001d3-VW
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:33:08 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 2591d5dfeb307badb4fc5137921c875198689a94ac73bc8fb6dcf4e2cf171e6a with SMTP id
 695e98cdbad0d7fe9504123a; Wed, 07 Jan 2026 17:33:01 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1767807180;
 bh=aFVqrRnnvCj/da+KXocFfgKyoUaJDMU/dbnUO1CkZ9w=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:X-Mailgun-Dkim:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:From:
 Reply-to:Subject:Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=WLEBUQcjUUYFmsrAJCrfTvh4qykYhGOis/bIJQRwLtEsP93qPhgp6Yn/3n+CE3go8
 yPIvILihpF0cPAdgew0pXvBnlO2ZFakyJfPgbPL6Aq8slx12fx69qN2Z8I9BOBxeY3
 rzmtWiX789abQX34YD//KejrkkyTfA34BD9YojCkXen0S0y3YIf32If5qG4SwRGKFH
 nownF0yNTUuNEg1WsSYtihOfiMNVxffJM1orylZ22zDIkjLM0CMVcFjWrUkkh49UwY
 Z9HpIM9IA+z+M+smrFyhlf238l7h/tLc/5zmnEsx09RV5kJQWDVcup3bFGeCUKn10H
 UMSN3cYq4otHQ==
Message-ID: <93fe1ce9-6dc4-4c19-840d-9b1ad613c31c@yodel.dev>
Date: Wed, 7 Jan 2026 11:32:58 -0600
MIME-Version: 1.0
Subject: Re: [RFC PATCH] tests/functional/x86_64: Add vhost-user-bridge test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251230002604.113632-1-yodel.eldar@yodel.dev>
 <6157618c-5454-457e-b65e-d9c16c428aaf@redhat.com>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <6157618c-5454-457e-b65e-d9c16c428aaf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 06/01/2026 22:52, Thomas Huth wrote:
> On 30/12/2025 01.25, Yodel Eldar wrote:
>> This introduces a functional test of vhost-user-bridge.
>>
>> The test runs vhost-user-bridge and launches a guest VM that connects
>> to the internet through it. The test succeeds if and only if an attempt
>> to connect to a hard-coded well-known URL succeeds.
>>
>> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
>> ---
>>
>> This patch introduces a functional test of vhost-user-bridge by
>> automating the testing described in its initial commit, 8e3b0cbb72,
>> with adjustments like using hubports (formerly the vlan parameter) and
>> memfd for the memory backend; hugepages are also omitted to avoid
>> requiring root privileges on the host.
>>
>> The test configures networking within the guest by invoking udhcpc, then
>> makes an http request via wget to a well-known URL, example.org, that
>> has a low risk of requiring https for connections (a limitation of the
>> the test). An assert on the retcode of wget determines success/failure.
>>
>> Please let me know if there are objections to the use of wget's retcode
>> as the test's condition; determining wget success through its output is
>> straightforward ("remote file exists"), but out of concern of some
>> unknown failure message (besides "bad address") locking up the test,
>> I've resorted to checking the retcode instead; perhaps, this violates
>> some convention?
>>
>> Also, I figured checking for memfd support on the host was unnecessary
>> in 2026 for the intended users of the test, but perhaps not?
>>
>> The guest's kernel contains an integrated initramfs and was built with
>> buildroot; an attempt to ensure bit-for-bit reproducibility was made by
>> building it via Containerfile based on a snapshot container image and
>> use of the BR2_REPRODUCIBLE option of buildroot, but the latter feature
>> is "experimental," so future builds may differ slightly (though the
>> image in the repo will be left untouched). The image and associated
>> build files are hosted on my personal account here:
>>     https://github.com/yodel/vhost-user-bridge-test
>> and will continue to be well into the future, but if there's some other
>> preferred location for the asset, please let me know?
>>
>> Lastly, special thanks to Cédric for inspiring me to write the test in
>> "<11454796-30d2-4a57-85a5-d42ff0dce2e6@redhat.com>".
>>
>> Thanks,
>> Yodel
>>
>>   .../x86_64/test_vhost_user_bridge.py          | 124 ++++++++++++++++++
>>   1 file changed, 124 insertions(+)
>>   create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py
>>
>> diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/ 
>> tests/functional/x86_64/test_vhost_user_bridge.py
>> new file mode 100755
>> index 0000000000..61afdbceec
>> --- /dev/null
>> +++ b/tests/functional/x86_64/test_vhost_user_bridge.py
>> @@ -0,0 +1,124 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Copyright (c) 2025 Software Freedom Conservancy, Inc.
>> +#
>> +# Author: Yodel Eldar <yodel.eldar@yodel.dev>
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +"""
>> +Test vhost-user-bridge (vubr) functionality:
>> +
>> +    1) Run vhost-user-bridge on the host.
>> +    2) Launch a guest VM:
>> +        a) Instantiate a unix domain socket to the vubr-created path
>> +        b) Instantiate a vhost-user net backend on top of that socket
>> +        c) Expose vhost-user with a virtio-net-pci interface
>> +        d) Instantiate UDP socket and user-mode net backends
>> +        e) Hub the UDP and user-mode backends
>> +    3) Run udhcpc in the guest to auto-configure networking.
>> +    4) Run wget in the guest and check its retcode to test internet 
>> connectivity
>> +
>> +The test fails if wget returns 1 and succeeds on 0.
>> +"""
>> +
>> +import os
>> +import subprocess
>> +from qemu_test import Asset, QemuSystemTest, which
>> +from qemu_test import exec_command_and_wait_for_pattern
>> +from qemu_test import is_readable_executable_file
>> +from qemu_test import wait_for_console_pattern
>> +from qemu_test.ports import Ports
>> +
>> +class VhostUserBridge(QemuSystemTest):
>> +
>> +    ASSET_KERNEL_INITRAMFS = Asset(
>> +        "https://github.com/yodel/vhost-user-bridge-test/raw/refs/ 
>> heads/main/bzImage",
>> +        
>> "3790bf35e4ddfe062425bca45e923df5a5ee4de44e456d6b00cf47f04991d549")
>> +
>> +    def configure_vm(self, ud_socket_path, lport, rport):
>> +        kernel_path = self.ASSET_KERNEL_INITRAMFS.fetch()
>> +
>> +        self.require_accelerator("kvm")
>> +        self.require_netdev("vhost-user")
>> +        self.require_netdev("socket")
>> +        self.require_netdev("hubport")
>> +        self.require_netdev("user")
>> +        self.require_device("virtio-net-pci")
>> +        self.set_machine("q35")
>> +        self.vm.set_console()
>> +        self.vm.add_args(
>> +            "-cpu",      "host",
>> +            "-accel",    "kvm",
>> +            "-kernel",   kernel_path,
>> +            "-append",   "console=ttyS0",
>> +            "-smp",      "2",
>> +            "-m",        "128M",
>> +            "-object",   "memory-backend-memfd,id=mem0,"
>> +                         "size=128M,share=on,prealloc=on",
>> +            "-numa",     "node,memdev=mem0",
>> +            "-chardev", f"socket,id=char0,path={ud_socket_path}",
>> +            "-netdev",   "vhost- 
>> user,id=vhost0,chardev=char0,vhostforce=on",
>> +            "-device",   "virtio-net-pci,netdev=vhost0",
>> +            "-netdev",  f"socket,id=udp0,udp=localhost:{lport},"
>> +                        f"localaddr=localhost:{rport}",
>> +            "-netdev",   "hubport,id=hub0,hubid=0,netdev=udp0",
>> +            "-netdev",   "user,id=user0",
>> +            "-netdev",   "hubport,id=hub1,hubid=0,netdev=user0"
>> +        )
>> +
>> +    def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, 
>> rport):
>> +        vubr_args = []
>> +
>> +        if (stdbuf_path := which("stdbuf")) is None:
>> +            self.log.info("Could not find stdbuf: vhost-user-bridge "
>> +                          "log lines may appear out of order")
>> +        else:
>> +            vubr_args += [stdbuf_path, "-o0", "-e0"]
>> +
>> +        vubr_args += [vubr_path, "-u", f"{ud_socket_path}",
>> +                      "-l", f"127.0.0.1:{lport}", "-r", f"127.0.0.1: 
>> {rport}"]
>> +
>> +        return vubr_args
>> +
>> +    def test_vhost_user_bridge(self):
>> +        prompt = "~ # "
>> +
>> +        vubr_path = self.build_file("tests", "vhost-user-bridge")
>> +        if is_readable_executable_file(vubr_path) is None:
>> +            self.skipTest("Could not find a readable and executable "
>> +                          "vhost-user-bridge")
>> +
>> +        with Ports() as ports:
>> +            sock_dir = self.socket_dir()
>> +            ud_socket_path = os.path.join(sock_dir.name, "vubr- 
>> test.sock")
>> +            lport, rport = ports.find_free_ports(2)
>> +
>> +            self.configure_vm(ud_socket_path, lport, rport)
>> +
>> +            vubr_log_path = self.log_file("vhost-user-bridge.log")
>> +            self.log.info("For the vhost-user-bridge application log,"
>> +                         f" see: {vubr_log_path}")
>> +
>> +            vubr_args = self.assemble_vubr_args(vubr_path, 
>> ud_socket_path,
>> +                                                lport, rport)
>> +
>> +            with open(vubr_log_path, "w") as vubr_log, \
>> +                 subprocess.Popen(vubr_args, stdin=subprocess.DEVNULL,
>> +                                  stdout=vubr_log, 
>> stderr=subprocess.STDOUT):
>> +                self.vm.launch()
>> +
>> +                wait_for_console_pattern(self, prompt)
>> +                exec_command_and_wait_for_pattern(self, "udhcpc -nt 
>> 1", prompt)
>> +                exec_command_and_wait_for_pattern(self,
>> +                    "wget -qT 2 --spider example.org", prompt)
> 
> If you've got python in the guest, you could maybe also do it the other 
> way round and host a httpd server in the guest, and download something 
> to the host. See check_http_download in tests/functional/qemu_test/ 
> linuxkernel.py for the helper function. That way you don't depend on any 
> external host.
> 
>   Thomas
> 

Thanks for the suggestion and that gem of a helper; I had missed that
module when going over the framework.

I switched to using a ping pattern and checking vhost-user-bridge's log
for the payload, but I don't like how brittle that is, because even
though the log prints are hard-coded on right now, they might not be
later, so having the guest serve a file's a welcome option, although the
guest currently lacks python (and just about everything else).

Thanks,
Yodel

