Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4100ECD0423
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 00:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcuTo-00078s-TO; Mon, 05 Jan 2026 18:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vcuTn-00078J-Sb
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 18:59:19 -0500
Received: from k57.kb8c70eb.use4.send.mailgun.net ([204.220.184.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vcuTl-0005pL-47
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 18:59:19 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 f6909b5986bd8126de51b0d4b940ab98c37e1d1bff78a20aeff47d1da81cf6b9 with SMTP id
 695c5051e56432b4cad5f67a; Mon, 05 Jan 2026 23:59:13 GMT
X-Mailgun-Sending-Ip: 204.220.184.57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1767657552;
 bh=qn/IkUAGII4d1bPxvHcWl5tM83FOjppVXziGdn/TZx0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=B7V/IerN5FT9rDc4Qo/TtgPffNu3oiWnpFrON4YBV1b3icGS2WMoTWE/TvAaG+BR0
 cTWxfd8mJfMc4sPQMI60y1Wh2UE2dB2hBdJwhaCPCeeUHcPgkYkyhr/ojDt3d3RxM1
 +ChMixlyUWdjS6g7JHLgMbQTitgdUG0OcYVHcYnCWOeR9zlA9i7pZQ2L8oqVxjlEie
 8l3yC0Raxmmh0nO8b4kyO5nx/OhRcsSQOnNlSU38lUDVk+JyD3K2RhnrC3gzfRiofR
 euCfIEbSRNdBTMPKPWTN1HzQ1jNiioJ6nsk/j95E4pmIpxNIXV/umpojp+rb7IoLfL
 BINf3u9IzUsSA==
Message-ID: <5f4fcf9b-2280-4c4d-bb78-ba6d4c106a5d@yodel.dev>
Date: Mon, 5 Jan 2026 17:59:11 -0600
MIME-Version: 1.0
Subject: Re: [RFC PATCH] tests/functional/x86_64: Add vhost-user-bridge test
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
References: <20251230002604.113632-1-yodel.eldar@yodel.dev>
 <648af3ee-5a5b-4c50-9135-6eae776d37a8@redhat.com>
 <CAJ+F1CK78wLaYcjZPoU-9rufDM8pa6wWntn0hToQoF7syA2r3w@mail.gmail.com>
 <e54c0922-2134-4195-a9e2-bce3a295efe5@yodel.dev>
 <20260105154755-mutt-send-email-mst@kernel.org>
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
In-Reply-To: <20260105154755-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.57;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k57.kb8c70eb.use4.send.mailgun.net
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


On 05/01/2026 14:53, Michael S. Tsirkin wrote:
> On Mon, Jan 05, 2026 at 02:28:53PM -0600, Yodel Eldar wrote:
>> + MST + Stefano
>>
>> Hi!
>>
>> On 05/01/2026 05:21, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Mon, Jan 5, 2026 at 2:36 PM Cédric Le Goater <clg@redhat.com> wrote:
>>>>
>>>> + Marc-André
>>>>
>>>> (I don't know who maintains this test)
>>>
>>> oh vhost-user-bridge is unmaintained...
>>>
>>
>> And, it's not covered by MAINTAINERS.
>>
>> Is vhost-user-bridge in tests/ instead of contrib/vhost-user-bridge/,
>> because it preceded libvhost-user and the first contrib/vhost-user-*
>> (vhost-user-scsi), or is tests/ really the best home for it?
> 
> I don't remember really.
> 
> 

It's served the community for quite a while! Uniting it with its younger
cousins seems correct, so I'll propose the move in the forthcoming RFC.

>> If there's interest, I can submit an RFC moving it and this functional
>> test and creating a section for it in MAINTAINERS along these lines:
>>
>>      diff --git a/MAINTAINERS b/MAINTAINERS
>>      index cca9b57c02..742f865a7e 100644
>>      --- a/MAINTAINERS
>>      +++ b/MAINTAINERS
>>      @@ -2774,0 +2775,5 @@ F: hw/display/vhost-user-*
>>      +vhost-user-bridge
>>      +S: Orphan
>>      +F: contrib/vhost-user-bridge/
>>      +F: tests/functional/x86_64/test_vhost_user_bridge.py
>>      +
> 
> I'd rather add it with rest of vhost-user not mark it orphan.
> 

Thanks for catching this early! I wrongly assumed a move to contrib/
would necessitate the creation of a dedicated section.

If we move vhost-user-bridge to contrib/vhost-user-bridge/, then it'll
automatically be covered by MAINTAINERS; otherwise, I could revise the
RFC to add it with its current location and this functional test as
individual files under the vhost-user section instead.

>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>>
>>>> On 12/30/25 01:25, Yodel Eldar wrote:
>>>>> This introduces a functional test of vhost-user-bridge.
>>>>>
>>>>> The test runs vhost-user-bridge and launches a guest VM that connects
>>>>> to the internet through it. The test succeeds if and only if an attempt
>>>>> to connect to a hard-coded well-known URL succeeds.
>>>>>
>>>>> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
>>>>> ---
>>>>>
>>>>> This patch introduces a functional test of vhost-user-bridge by
>>>>> automating the testing described in its initial commit, 8e3b0cbb72,
>>>>> with adjustments like using hubports (formerly the vlan parameter) and
>>>>> memfd for the memory backend; hugepages are also omitted to avoid
>>>>> requiring root privileges on the host.
>>>>>
>>>>> The test configures networking within the guest by invoking udhcpc, then
>>>>> makes an http request via wget to a well-known URL, example.org, that
>>>>> has a low risk of requiring https for connections (a limitation of the
>>>>> the test). An assert on the retcode of wget determines success/failure.
>>>>>
>>>>> Please let me know if there are objections to the use of wget's retcode
>>>>> as the test's condition; determining wget success through its output is
>>>>> straightforward ("remote file exists"), but out of concern of some
>>>>> unknown failure message (besides "bad address") locking up the test,
>>>>> I've resorted to checking the retcode instead; perhaps, this violates
>>>>> some convention?
>>>
>>> Imho, the test shouldn't need internet connectivity. It could possibly
>>> send custom crafted IP packets instead. wdyt?
>>>
>>>
>>
>> That certainly alleviates concerns about depending on example.org to be
>> up! The guest can ping the udhcpc-assigned gateway at 10.0.2.2, so that
>> the test checks ping's output in the guest and for the guest's MAC
>> address and the ping payload (with its -p option) in the vubr log. How
>> does that sound? I'm open to other ideas.
> 
> 
> The whole idea with vhost user bridge is to use slirp and not
> depend on anything expernal.
> 

Thanks for the insight! I figured connecting to example.org would
provide a more comprehensive log but was concerned about introducing
such an external dependency to the test; I'm glad we could forgo it by
pinging the slirp-assigned gateway obtained by udhcpc instead.

>>>>>
>>>>> Also, I figured checking for memfd support on the host was unnecessary
>>>>> in 2026 for the intended users of the test, but perhaps not?
>>>>>
>>>>> The guest's kernel contains an integrated initramfs and was built with
>>>>> buildroot; an attempt to ensure bit-for-bit reproducibility was made by
>>>>> building it via Containerfile based on a snapshot container image and
>>>>> use of the BR2_REPRODUCIBLE option of buildroot, but the latter feature
>>>>> is "experimental," so future builds may differ slightly (though the
>>>>> image in the repo will be left untouched). The image and associated
>>>>> build files are hosted on my personal account here:
>>>>>         https://github.com/yodel/vhost-user-bridge-test
>>>>> and will continue to be well into the future, but if there's some other
>>>>> preferred location for the asset, please let me know?
>>>
>>> Do we need a new kernel asset? I like the reproducible from scratch
>>> way, maybe we should try to consolidate other tests around it. That's
>>> just some thoughts.
>>>
>>
>> I'm glad you like it! The kernel is significantly stripped of features,
>> and has a minimally viable initramfs, so it may need some extending to
>> be usable by the plethora of tests we've got.
>>
>> If you meant informing the community about a preferred approach to image
>> generation, I can add documentation in the manual to gently persuade
>> folks to use a similar approach.
>>
>> On the other hand, if we want to use the same image for all applicable
>> tests, it may be beneficial to have the image/build files in-tree,
>> because I anticipate folks will want to make changes to it as needed. If
>> there's interest in that, I can prepare an RFC proposing it, though I'd
>> look to the community for long-term maintenance of it.
>>
>> Or, was there another option you had closer to mind?
>>
>> Thanks,
>> Yodel
>>
>>>>>
>>>>> Lastly, special thanks to Cédric for inspiring me to write the test in
>>>>> "<11454796-30d2-4a57-85a5-d42ff0dce2e6@redhat.com>".
>>>>>
>>>>> Thanks,
>>>>> Yodel
>>>>>
>>>>>     .../x86_64/test_vhost_user_bridge.py          | 124 ++++++++++++++++++
>>>>>     1 file changed, 124 insertions(+)
>>>>>     create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py
>>>>>
>>>>> diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/functional/x86_64/test_vhost_user_bridge.py
>>>>> new file mode 100755
>>>>> index 0000000000..61afdbceec
>>>>> --- /dev/null
>>>>> +++ b/tests/functional/x86_64/test_vhost_user_bridge.py
>>>>> @@ -0,0 +1,124 @@
>>>>> +#!/usr/bin/env python3
>>>>> +#
>>>>> +# Copyright (c) 2025 Software Freedom Conservancy, Inc.
>>>>> +#
>>>>> +# Author: Yodel Eldar <yodel.eldar@yodel.dev>
>>>>> +#
>>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>>> +"""
>>>>> +Test vhost-user-bridge (vubr) functionality:
>>>>> +
>>>>> +    1) Run vhost-user-bridge on the host.
>>>>> +    2) Launch a guest VM:
>>>>> +        a) Instantiate a unix domain socket to the vubr-created path
>>>>> +        b) Instantiate a vhost-user net backend on top of that socket
>>>>> +        c) Expose vhost-user with a virtio-net-pci interface
>>>>> +        d) Instantiate UDP socket and user-mode net backends
>>>>> +        e) Hub the UDP and user-mode backends
>>>>> +    3) Run udhcpc in the guest to auto-configure networking.
>>>>> +    4) Run wget in the guest and check its retcode to test internet connectivity
>>>>> +
>>>>> +The test fails if wget returns 1 and succeeds on 0.
>>>>> +"""
>>>>> +
>>>>> +import os
>>>>> +import subprocess
>>>>> +from qemu_test import Asset, QemuSystemTest, which
>>>>> +from qemu_test import exec_command_and_wait_for_pattern
>>>>> +from qemu_test import is_readable_executable_file
>>>>> +from qemu_test import wait_for_console_pattern
>>>>> +from qemu_test.ports import Ports
>>>>> +
>>>>> +class VhostUserBridge(QemuSystemTest):
>>>>> +
>>>>> +    ASSET_KERNEL_INITRAMFS = Asset(
>>>>> +        "https://github.com/yodel/vhost-user-bridge-test/raw/refs/heads/main/bzImage",
>>>>> +        "3790bf35e4ddfe062425bca45e923df5a5ee4de44e456d6b00cf47f04991d549")
>>>>> +
>>>>> +    def configure_vm(self, ud_socket_path, lport, rport):
>>>>> +        kernel_path = self.ASSET_KERNEL_INITRAMFS.fetch()
>>>>> +
>>>>> +        self.require_accelerator("kvm")
>>>>> +        self.require_netdev("vhost-user")
>>>>> +        self.require_netdev("socket")
>>>>> +        self.require_netdev("hubport")
>>>>> +        self.require_netdev("user")
>>>>> +        self.require_device("virtio-net-pci")
>>>>> +        self.set_machine("q35")
>>>>> +        self.vm.set_console()
>>>>> +        self.vm.add_args(
>>>>> +            "-cpu",      "host",
>>>>> +            "-accel",    "kvm",
>>>>> +            "-kernel",   kernel_path,
>>>>> +            "-append",   "console=ttyS0",
>>>>> +            "-smp",      "2",
>>>>> +            "-m",        "128M",
>>>>> +            "-object",   "memory-backend-memfd,id=mem0,"
>>>>> +                         "size=128M,share=on,prealloc=on",
>>>>> +            "-numa",     "node,memdev=mem0",
>>>>> +            "-chardev", f"socket,id=char0,path={ud_socket_path}",
>>>>> +            "-netdev",   "vhost-user,id=vhost0,chardev=char0,vhostforce=on",
>>>>> +            "-device",   "virtio-net-pci,netdev=vhost0",
>>>>> +            "-netdev",  f"socket,id=udp0,udp=localhost:{lport},"
>>>>> +                        f"localaddr=localhost:{rport}",
>>>>> +            "-netdev",   "hubport,id=hub0,hubid=0,netdev=udp0",
>>>>> +            "-netdev",   "user,id=user0",
>>>>> +            "-netdev",   "hubport,id=hub1,hubid=0,netdev=user0"
>>>>> +        )
>>>>> +
>>>>> +    def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rport):
>>>>> +        vubr_args = []
>>>>> +
>>>>> +        if (stdbuf_path := which("stdbuf")) is None:
>>>>> +            self.log.info("Could not find stdbuf: vhost-user-bridge "
>>>>> +                          "log lines may appear out of order")
>>>>> +        else:
>>>>> +            vubr_args += [stdbuf_path, "-o0", "-e0"]
>>>>> +
>>>>> +        vubr_args += [vubr_path, "-u", f"{ud_socket_path}",
>>>>> +                      "-l", f"127.0.0.1:{lport}", "-r", f"127.0.0.1:{rport}"]
>>>>> +
>>>>> +        return vubr_args
>>>>> +
>>>>> +    def test_vhost_user_bridge(self):
>>>>> +        prompt = "~ # "
>>>>> +
>>>>> +        vubr_path = self.build_file("tests", "vhost-user-bridge")
>>>>> +        if is_readable_executable_file(vubr_path) is None:
>>>>> +            self.skipTest("Could not find a readable and executable "
>>>>> +                          "vhost-user-bridge")
>>>>> +
>>>>> +        with Ports() as ports:
>>>>> +            sock_dir = self.socket_dir()
>>>>> +            ud_socket_path = os.path.join(sock_dir.name, "vubr-test.sock")
>>>>> +            lport, rport = ports.find_free_ports(2)
>>>>> +
>>>>> +            self.configure_vm(ud_socket_path, lport, rport)
>>>>> +
>>>>> +            vubr_log_path = self.log_file("vhost-user-bridge.log")
>>>>> +            self.log.info("For the vhost-user-bridge application log,"
>>>>> +                         f" see: {vubr_log_path}")
>>>>> +
>>>>> +            vubr_args = self.assemble_vubr_args(vubr_path, ud_socket_path,
>>>>> +                                                lport, rport)
>>>>> +
>>>>> +            with open(vubr_log_path, "w") as vubr_log, \
>>>>> +                 subprocess.Popen(vubr_args, stdin=subprocess.DEVNULL,
>>>>> +                                  stdout=vubr_log, stderr=subprocess.STDOUT):
>>>>> +                self.vm.launch()
>>>>> +
>>>>> +                wait_for_console_pattern(self, prompt)
>>>>> +                exec_command_and_wait_for_pattern(self, "udhcpc -nt 1", prompt)
>>>>> +                exec_command_and_wait_for_pattern(self,
>>>>> +                    "wget -qT 2 --spider example.org", prompt)
>>>>> +
>>>>> +                try:
>>>>> +                    exec_command_and_wait_for_pattern(self, "echo $?", "0", "1")
>>>>> +                except AssertionError:
>>>>> +                    self.log.error("Unable to confirm internet connectivity")
>>>>> +                    raise
>>>>> +                finally:
>>>>> +                    self.vm.shutdown()
>>>>> +
>>>>> +if __name__ == '__main__':
>>>>> +    QemuSystemTest.main()
>>>>
>>>>
>>>
>>>
> 
> 


