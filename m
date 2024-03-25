Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C17DC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 18:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rooe5-0008S3-2O; Mon, 25 Mar 2024 14:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1roodt-0008Ra-Nz; Mon, 25 Mar 2024 14:01:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1roodq-0002ek-Uu; Mon, 25 Mar 2024 14:01:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7720658D16;
 Mon, 25 Mar 2024 21:03:11 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D4AF9A2A7F;
 Mon, 25 Mar 2024 21:01:42 +0300 (MSK)
Message-ID: <604bf457-23a7-4d06-b59f-a7b46945c626@tls.msk.ru>
Date: Mon, 25 Mar 2024 21:01:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial for-9.0] hw/i386/fw_cfg.c: fix non-legacy smbios
 build
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20240325130920.349521-1-mjt@tls.msk.ru>
 <20240325162049.46c2a758@imammedo.users.ipa.redhat.com>
Content-Language: en-US
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
In-Reply-To: <20240325162049.46c2a758@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

25.03.2024 18:20, Igor Mammedov wrote
> On Mon, 25 Mar 2024 16:09:20 +0300
> Michael Tokarev <mjt@tls.msk.ru> wrote:
> 
>> When building qemu with smbios but not legacy mode (eg minimal microvm build),
>> link fails with:
>>
>>    hw/i386/fw_cfg.c:74: undefined reference to `smbios_get_table_legacy'
>>
>> This is because fw_cfg interface can call this function if CONFIG_SMBIOS
>> is defined.  Made this code block to depend on CONFIG_SMBIOS_LEGACY.
> 
> stub supposedly should have handled that
> what configure options do you use to build 'minimal microvm'?

This is a custom build, not only configure options but also custom
devices.mak: https://salsa.debian.org/qemu-team/qemu/-/blob/master/debian/microvm-devices.mak

================== cut ==========================
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
================== cut ==========================

Relevant configure options:
https://salsa.debian.org/qemu-team/qemu/-/blob/master/debian/rules#L293-308

		../../configure ${common_configure_opts} \
		--extra-cflags="${extra-cflags} -DCONFIG_MICROVM_DEFAULT=1" \
		--without-default-features \
		--target-list=x86_64-softmmu --enable-kvm --disable-tcg \
		--enable-pixman --enable-vnc \
		--enable-attr \
		--enable-coroutine-pool \
		--audio-drv-list="" \
		--without-default-devices \
		--with-devices-x86_64=microvm \
		--enable-vhost-kernel --enable-vhost-net \
		--enable-vhost-vdpa \
		--enable-vhost-user --enable-vhost-user-blk-server \
		--enable-vhost-crypto \

I dunno how relevant these are, - it come from ubuntu and I haven't
looked there for a long time.  The idea was to have a build especially
for microvm with minimal footprint, as light as possible, for fastest
startup time etc.

Enabling (selecting) CONFIG_SMBIOS does not help since it is already
enabled by something, but not SMBIOS_LEGACY (which should not be
enabled in this case).

I still think it is better to avoid pcmc->smbios_legacy_mode variable
(field) entirely.

Thanks,

/mjt

>>
>> Fixes: b42b0e4daaa5 "smbios: build legacy mode code only for 'pc' machine"
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>>   hw/i386/fw_cfg.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
>> index d802d2787f..d5e78a9183 100644
>> --- a/hw/i386/fw_cfg.c
>> +++ b/hw/i386/fw_cfg.c
>> @@ -70,6 +70,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
>>       /* tell smbios about cpuid version and features */
>>       smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
>>   
>> +#ifdef CONFIG_SMBIOS_LEGACY
>>       if (pcmc->smbios_legacy_mode) {
>>           smbios_tables = smbios_get_table_legacy(&smbios_tables_len,
>>                                                   &error_fatal);
>> @@ -77,6 +78,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
>>                            smbios_tables, smbios_tables_len);
>>           return;
>>       }
>> +#endif
>>   
>>       /* build the array of physical mem area from e820 table */
>>       mem_array = g_malloc0(sizeof(*mem_array) * e820_get_num_entries());
> 
> 


