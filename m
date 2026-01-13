Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1257D2F35C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 19:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfkXb-0001K1-Mq; Tue, 13 Jan 2026 14:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vfkXZ-0001Jp-N9
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:58:57 -0500
Received: from k57.kb8c70eb.use4.send.mailgun.net ([204.220.184.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vfkXX-0007Rl-F5
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:58:57 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 6bc721f332b3570980fb4502250de54b5bbbc1a988391ac6a3e3d6a55059bde7 with SMTP id
 6966a3fc586fde7034534000; Tue, 13 Jan 2026 19:58:52 GMT
X-Mailgun-Sending-Ip: 204.220.184.57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1768334330;
 bh=buVlQdhtFvqDHYdOQN6BVy/aLsSrEL7je1Xb7LnIVq0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=UR1ArO0ezirV8QxT9dh9bmXTTfgiEAoi/5Tb9IzzgHksc5WK88+fSjVAiJb4+OZBj
 Y5oU+kc6jJHQIWpPq2vets8JobTm7Ebnnv7p9j3iok73J+LB1DQyz7PbnthQd9uAn9
 NWEBEoXJ7C1M/VlHZkN4D35e1ydPPWU0Xd0PZBn8putDgp37NowCtRft6gBRNpk1a/
 9whC/HbnfteYtrWgwEmJX1u8lzqhG+PmoaXeY9VS97yhQTCqAHIRPVwZfjhwtjQ4Rf
 I4HrvIB7iN+BCy0/smCK2J1R04T1/taj13NiQyEkrijHdGjLBWfS8bH8f50EKAScgP
 7C0OZ3VQALq/Q==
Message-ID: <3703f711-d96e-40cb-acc7-f73b52272293@yodel.dev>
Date: Tue, 13 Jan 2026 13:58:49 -0600
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 2/3] tests/functional/x86_64: Add vhost-user-bridge
 test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>
References: <20260112230127.99125-1-yodel.eldar@yodel.dev>
 <20260112230127.99125-3-yodel.eldar@yodel.dev>
 <b5d72aff-2847-420c-9c1f-23fc23e1b75d@redhat.com>
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
In-Reply-To: <b5d72aff-2847-420c-9c1f-23fc23e1b75d@redhat.com>
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

On 13/01/2026 02:45, Thomas Huth wrote:
> On 13/01/2026 00.01, Yodel Eldar wrote:
>> Introduce a functional test of vhost-user-bridge and enter it into
>> MAINTAINERS under the vhost section.
>>
>> The test runs vhost-user-bridge as a subprocess, then launches a guest
>> with four backends: a unix domain socket for vhost-user, a UDP socket, a
>> user-mode net, and a hubport to hub the UDP and user backends; only the
>> vhost-user backend is exposed, the rest are deviceless. This
>> configuration mimics the testing setup described in the initial commit
>> of vhost-user-bridge in 3595e2eb0a23.
>>
>> A file containing a hardcoded UUID is created by the test in a scratch
>> file and exposed to the guest via the tftp parameter of the user netdev.
>> The guest requests the file by invoking tftp, and the test verifies its
>> sha256 hashsum.
>>
>> Similarly, a file containing another hardcoded UUID is created in the
>> guest. A call to check_http_download() serves the file via http to the
>> host and verifies integrity with its hashsum.
>>
>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>> Suggested-by: Marc-André Lureau <marcandre.lureau@gmail.com>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
>> ---
> ...
>> +    def test_vhost_user_bridge(self):
>> +        prompt = "~ # "
>> +        host_uuid_filename = "vubr-test-uuid.txt"
>> +        guest_uuid_path = "/tmp/uuid.txt"
>> +        kernel_path = self.ASSET_KERNEL_INITRAMFS.fetch()
>> +
>> +        vubr_path = self.build_file("contrib", "vhost-user-bridge",
>> +                                    "vhost-user-bridge")
>> +        if is_readable_executable_file(vubr_path) is None:
>> +            self.skipTest("Could not find a readable and executable "
>> +                          "vhost-user-bridge")
>> +
>> +        vubr_log_path = self.log_file("vhost-user-bridge.log")
>> +        self.log.info("For the vhost-user-bridge application log,"
>> +                     f" see: {vubr_log_path}")
>> +
>> +        sock_dir = self.socket_dir()
>> +        ud_socket_path = os.path.join(sock_dir.name, "vubr-test.sock")
>> +
>> +        tftpdir = self.scratch_file("tftp")
>> +        shutil.rmtree(tftpdir, ignore_errors=True)
>> +        os.mkdir(tftpdir)
>> +        host_uuid_path = self.scratch_file("tftp", host_uuid_filename)
>> +        with open(host_uuid_path, "w") as host_uuid_file:
> 
> FYI, I just got another test merged that checks the files with pylint 
> now - you might need to add an encoding="ascii" or encoding="utf-8" to 
> that open() call now to avoid that pylint complains.
> 
>> +            host_uuid_file.write(self.HOST_UUID)
>> +
>> +        with Ports() as ports:
>> +            lport, rport, hostfwd_port = ports.find_free_ports(3)
>> +
>> +            self.configure_vm(ud_socket_path, lport, rport, 
>> hostfwd_port,
>> +                              tftpdir)
>> +
>> +            vubr_args = self.assemble_vubr_args(vubr_path, 
>> ud_socket_path,
>> +                                                lport, rport)
>> +
>> +            with open(vubr_log_path, "w+") as vubr_log, \
> 
> dito.
> 
>> +                 subprocess.Popen(vubr_args, stdin=subprocess.DEVNULL,
>> +                                  stdout=vubr_log,
>> +                                  stderr=subprocess.STDOUT) as 
>> vubr_proc:
>> +                self.launch_kernel(kernel_path, wait_for=prompt)
>> +
>> +                exec_command_and_wait_for_pattern(self,
>> +                    f"tftp -g -r {host_uuid_filename} 10.0.2.2 ; "
>> +                    f"sha256sum {host_uuid_filename}", 
>> self.HOST_UUID_HSUM)
>> +                wait_for_console_pattern(self, prompt)
>> +
>> +                exec_command_and_wait_for_pattern(self,
>> +                    f"echo -n '{self.GUEST_UUID}' > 
>> {guest_uuid_path}", prompt)
>> +                self.check_http_download(guest_uuid_path, 
>> self.GUEST_UUID_HSUM)
>> +                wait_for_console_pattern(self, prompt)
>> +
>> +                self.vm.shutdown()
>> +                vubr_proc.terminate()
>> +                vubr_proc.wait()
>> +
>> +if __name__ == '__main__':
>> +    LinuxKernelTest.main()
> 
> With the encoding=... added:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 

Thanks for the review and the heads up. That test_linters is a boon to
the framework.

Adding the encoding='s and a disable=unbalanced-tuple-unpacking on
find_free_ports() for v3.

Thanks,
Yodel


