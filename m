Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7C7E9B37D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 13:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3R4-0007zQ-77; Mon, 02 Mar 2026 08:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx3Qy-0007y0-RY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:35:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx3Qw-0007i9-NH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772458537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/GISxKOzfIFMyWXuvgpoI9IfddefC5JS/w9UHWgEpuU=;
 b=B7yd0Y5Bm955QVwa1jUWAJxv840Fi1M3P+2RDMUOJisfHBdoHzwWngN1VatKTafTW+G0hs
 6P4jGs3Rpb2K16pOcCtvBB/wnuvPoGqHvZmnZJw/nDuLkNnpL8T7thnnPUQQkZcifxTGZW
 rGzc6eLZVcu8XEFSyi2Eo0au7X/B+vM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-qcHGgA5nNoOwMfTC_FZ1uQ-1; Mon,
 02 Mar 2026 08:35:35 -0500
X-MC-Unique: qcHGgA5nNoOwMfTC_FZ1uQ-1
X-Mimecast-MFC-AGG-ID: qcHGgA5nNoOwMfTC_FZ1uQ_1772458533
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D701195608F; Mon,  2 Mar 2026 13:35:33 +0000 (UTC)
Received: from [10.45.224.162] (unknown [10.45.224.162])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 417141800370; Mon,  2 Mar 2026 13:35:26 +0000 (UTC)
Message-ID: <8fe43e9c-45de-467f-89c0-241f87c5e716@redhat.com>
Date: Mon, 2 Mar 2026 14:35:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 28/30] tests/functional/s390x: Add secure IPL
 functional test
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-29-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260212204352.1044699-29-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/02/2026 21.43, Zhuoying Cai wrote:
> Add functional test for secure IPL.

Thanks for adding it! Some comments below...

> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   tests/functional/s390x/meson.build        |   2 +
>   tests/functional/s390x/test_secure_ipl.py | 142 ++++++++++++++++++++++
>   2 files changed, 144 insertions(+)
>   create mode 100644 tests/functional/s390x/test_secure_ipl.py
> 
> diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/meson.build
> index 70cd36e291..cb050f3c01 100644
> --- a/tests/functional/s390x/meson.build
> +++ b/tests/functional/s390x/meson.build
> @@ -2,6 +2,7 @@
>   
>   test_s390x_timeouts = {
>     'ccw_virtio' : 420,
> +  'secure_ipl' : 280,
>   }
>   
>   tests_s390x_system_quick = [
> @@ -12,6 +13,7 @@ tests_s390x_system_thorough = [
>     'ccw_virtio',
>     'pxelinux',
>     'replay',
> +  'secure_ipl',
>     'topology',
>     'tuxrun',
>   ]
> diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
> new file mode 100644

chmod a+x please, so we can also run this test directly, without the meson 
test harness.

> index 0000000000..c95553e4e9
> --- /dev/null
> +++ b/tests/functional/s390x/test_secure_ipl.py
> @@ -0,0 +1,142 @@
> +#!/usr/bin/env python3
> +#
> +# s390x Secure IPL functional test: validates secure-boot verification results
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import exec_command_and_wait_for_pattern, exec_command
> +from qemu_test import wait_for_console_pattern, skipBigDataTest
> +
> +class S390xSecureIpl(QemuSystemTest):
> +    ASSET_F40_QCOW2 = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/'
> +         'fedora-secondary/releases/40/Server/s390x/images/'
> +         'Fedora-Server-KVM-40-1.14.s390x.qcow2'),
> +        '091c232a7301be14e19c76ce9a0c1cbd2be2c4157884a731e1fc4f89e7455a5f')
> +
> +    def __init__(self, *args, **kwargs):
> +        super().__init__(*args, **kwargs)
> +        self.root_password = None
> +        self.qcow2_path = None
> +        self.cert_path = None
> +        self.prompt = None
> +
> +    # Boot a temporary VM to set up secure IPL image:
> +    # - Create certificate
> +    # - Sign stage3 binary and kernel
> +    # - Run zipl
> +    # - Extract certificate
> +    def setup_s390x_secure_ipl(self):
> +        temp_vm = self.get_vm(name='sipl_setup')
> +        temp_vm.set_machine('s390-ccw-virtio')
> +
> +        self.qcow2_path = self.ASSET_F40_QCOW2.fetch()
> +
> +        temp_vm.set_console()
> +        temp_vm.add_args('-nographic',
> +                         '-accel', 'kvm',
> +                         '-m', '1024',
> +                         '-drive',
> +                         f'id=drive0,if=none,format=qcow2,file={self.qcow2_path}',

Assets are stored as read-only in the cache, so this should fail? Did you 
maybe copy the asset manually into your cache?

Anyway, I think you certainly want to operate on a "copy" of your asset 
instead (done with "qemu-img -b ..." to use the original asset as backing 
file), so you don't alter the original asset while running the test.

> +                         '-device', 'virtio-blk-ccw,drive=drive0,bootindex=1')
> +        temp_vm.launch()
> +
> +        # Initial root account setup (Fedora first boot screen)
> +        self.root_password = 'fedora40password'
> +        wait_for_console_pattern(self, 'Please make a selection from the above',
> +                                 vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self, '4', 'Password:', vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self, self.root_password,
> +                                          'Password (confirm):', vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self, self.root_password,
> +                                    'Please make a selection from the above',
> +                                    vm=temp_vm)
> +
> +        # Login as root
> +        self.prompt = '[root@localhost ~]#'
> +        exec_command_and_wait_for_pattern(self, 'c', 'localhost login:', vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:', vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self, self.root_password, self.prompt,
> +                                          vm=temp_vm)
> +
> +        # Certificate generation
> +        exec_command_and_wait_for_pattern(self,
> +                                          'openssl version', 'OpenSSL 3.2.1 30',
> +                                          vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self,
> +                            'openssl req -new -x509 -newkey rsa:2048 '
> +                            '-keyout mykey.pem -outform PEM -out mycert.pem '
> +                            '-days 36500 -subj "/CN=My Name/" -nodes -verbose',
> +                            'Writing private key to \'mykey.pem\'', vm=temp_vm)
> +
> +        # Install kernel-devel (needed for sign-file)
> +        exec_command_and_wait_for_pattern(self,
> +                                'sudo dnf install kernel-devel-$(uname -r) -y',
> +                                'Complete!', vm=temp_vm)
> +        wait_for_console_pattern(self, self.prompt, vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self,
> +                                    'ls /usr/src/kernels/$(uname -r)/scripts/',
> +                                    'sign-file', vm=temp_vm)
> +
> +        # Sign stage3 binary and kernel
> +        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-file '
> +                    'sha256 mykey.pem mycert.pem /lib/s390-tools/stage3.bin',
> +                    vm=temp_vm)
> +        wait_for_console_pattern(self, self.prompt, vm=temp_vm)
> +        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-file '
> +                    'sha256 mykey.pem mycert.pem /boot/vmlinuz-$(uname -r)',
> +                    vm=temp_vm)
> +        wait_for_console_pattern(self, self.prompt, vm=temp_vm)
> +
> +        # Run zipl to prepare for secure boot
> +        exec_command_and_wait_for_pattern(self, 'zipl --secure 1 -VV', 'Done.',
> +                                          vm=temp_vm)
> +
> +        # Extract certificate to host
> +        out = exec_command_and_wait_for_pattern(self, 'cat mycert.pem',
> +                                                '-----END CERTIFICATE-----',
> +                                                vm=temp_vm)
> +        # strip first line to avoid console echo artifacts
> +        cert = "\n".join(out.decode("utf-8").splitlines()[1:])
> +        self.log.info("%s", cert)
> +
> +        self.cert_path = self.scratch_file("mycert.pem")
> +
> +        with open(self.cert_path, 'w', encoding="utf-8") as file_object:
> +            file_object.write(cert)
> +
> +        # Shutdown temp vm
> +        temp_vm.shutdown()
> +
> +    @skipBigDataTest()
> +    def test_s390x_secure_ipl(self):
> +        self.require_accelerator('kvm')

Could this test also be run with TCG?

  Thomas


> +        self.setup_s390x_secure_ipl()
> +
> +        self.set_machine('s390-ccw-virtio')
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-nographic',
> +                         '-machine', 's390-ccw-virtio,secure-boot=on,'
> +                         f'boot-certs.0.path={self.cert_path}',
> +                         '-accel', 'kvm',
> +                         '-m', '1024',
> +                         '-drive',
> +                         f'id=drive1,if=none,format=qcow2,file={self.qcow2_path}',
> +                         '-device', 'virtio-blk-ccw,drive=drive1,bootindex=1')
> +        self.vm.launch()
> +
> +        # Expect two verified components
> +        verified_output = "Verified component"
> +        wait_for_console_pattern(self, verified_output)
> +        wait_for_console_pattern(self, verified_output)
> +
> +        # Login and verify the vm is booted using secure boot
> +        wait_for_console_pattern(self, 'localhost login:')
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
> +        exec_command_and_wait_for_pattern(self, self.root_password, self.prompt)
> +        exec_command_and_wait_for_pattern(self, 'cat /sys/firmware/ipl/secure', '1')
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()


