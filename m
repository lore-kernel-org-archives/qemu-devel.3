Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC24C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2024 02:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa4WH-0003Og-HC; Fri, 02 Aug 2024 22:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1sa4WG-0003OC-KB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 22:29:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1sa4WE-00076V-F8
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 22:29:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 601C380B91;
 Sat,  3 Aug 2024 05:28:47 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2933811ACA6;
 Sat,  3 Aug 2024 05:29:13 +0300 (MSK)
Message-ID: <7762115d-cf9d-4505-a3c7-6782433e2521@tls.msk.ru>
Date: Sat, 3 Aug 2024 05:29:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/63] hw/virtio: move stubs out of stubs/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240423150951.41600-1-pbonzini@redhat.com>
 <20240423150951.41600-12-pbonzini@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <20240423150951.41600-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

23.04.2024 18:08, Paolo Bonzini wrote:
> Since the virtio memory device stubs are needed exactly when the
> Kconfig symbol is not enabled, they can be placed in hw/virtio/ and
> conditionalized on CONFIG_VIRTIO_MD.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20240408155330.522792-12-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c | 0
>   hw/virtio/meson.build                                | 2 ++
>   stubs/meson.build                                    | 1 -
>   3 files changed, 2 insertions(+), 1 deletion(-)
>   rename stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c (100%)

FWIW, this broke a minimal microvm build for debian:

/usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_pc.c.o: in function `pc_machine_device_pre_plug_cb':
./b/microvm/hw/i386/pc.c:1377: undefined reference to `virtio_md_pci_pre_plug'
/usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_pc.c.o: in function `pc_machine_device_unplug_request_cb':
./b/microvm/hw/i386/pc.c:1427: undefined reference to `virtio_md_pci_unplug_request'
/usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_pc.c.o: in function `pc_machine_device_unplug_cb':
./b/microvm/hw/i386/pc.c:1443: undefined reference to `virtio_md_pci_unplug'
/usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_pc.c.o: in function `pc_machine_device_plug_cb':
./b/microvm/hw/i386/pc.c:1413: undefined reference to `virtio_md_pci_plug'
collect2: error: ld returned 1 exit status


../configure --disable-install-blobs \
	--without-default-features \
	--target-list=x86_64-softmmu --enable-kvm --disable-tcg \
	--enable-pixman --enable-vnc \
	--enable-virtfs \
	--enable-linux-aio --enable-linux-io-uring \
	--enable-numa \
	--enable-attr \
	--enable-coroutine-pool \
	--audio-drv-list="" \
	--without-default-devices \
	--with-devices-x86_64=microvm \
	--enable-vhost-kernel --enable-vhost-net \
	--enable-vhost-vdpa \
	--enable-vhost-user --enable-vhost-user-blk-server \
	--enable-vhost-crypto \
	--enable-seccomp \
	
with the following contents of microvm-devices.mak:

# see configs/devices/i386-softmmu/default.mak
# for additional devices which can be disabled
#
CONFIG_PCI_DEVICES=n

# we can't disable all machine types (boards) as of 6.1
# since the resulting binary fails to link
#CONFIG_ISAPC=y
#CONFIG_I440FX=y
CONFIG_Q35=y
CONFIG_MICROVM=y

CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_SERIAL=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_INPUT_HOST=y
CONFIG_VHOST_USER_INPUT=y
CONFIG_VIRTIO_NET=y
CONFIG_VIRTIO_SCSI=y
CONFIG_VIRTIO_RNG=y
CONFIG_VIRTIO_CRYPTO=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MEM=y
CONFIG_VIRTIO_PMEM=y
CONFIG_VIRTIO_GPU=y
CONFIG_VHOST_USER_GPU=y


> diff --git a/stubs/virtio-md-pci.c b/hw/virtio/virtio-md-stubs.c
> similarity index 100%
> rename from stubs/virtio-md-pci.c
> rename to hw/virtio/virtio-md-stubs.c
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index d7f18c96e60..621fc65454c 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -87,6 +87,8 @@ specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
>   system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
>   system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
>   system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
> +system_ss.add(when: 'CONFIG_VIRTIO_MD', if_false: files('virtio-md-stubs.c'))
> +
>   system_ss.add(files('virtio-hmp-cmds.c'))
>   
>   specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 45616afbfaa..60e32d363fa 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -57,7 +57,6 @@ if have_system
>     stub_ss.add(files('fw_cfg.c'))
>     stub_ss.add(files('semihost.c'))
>     stub_ss.add(files('xen-hw-stub.c'))
> -  stub_ss.add(files('virtio-md-pci.c'))
>   else
>     stub_ss.add(files('qdev.c'))
>   endif

-- 
GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D98 ECDF 2C8E
Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0A0 8044 65C5
Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt


