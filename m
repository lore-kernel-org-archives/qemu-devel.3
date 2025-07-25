Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571A7C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufIQM-0006Mv-Pb; Fri, 25 Jul 2025 09:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1ufIQI-0006DX-5h
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:25:19 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1ufIQE-000762-E3
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:25:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:d42b:0:640:f3fc:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3F82E80668;
 Fri, 25 Jul 2025 16:25:09 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:82d::1:4] (unknown [2a02:6bf:8080:82d::1:4])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7PV2l25Gwa60-Jo67cp3K; Fri, 25 Jul 2025 16:25:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1753449908;
 bh=8Q/H++GzhMUkxXDXg8StqG+YdJoAlJcGOy0cM44I+J0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=gi6sOwqJ71Kfe7HZ8ndkchd9pbm74ua8EOO05S8Kz4JUThEPMllL3Imp9KLJvTiPd
 /U67pFjLdWEcriFsRkHyctNsh9sBj8uHS+SCVGrktGcADakou3jVnBG75qjWyPSw1f
 Eg0F6otNhCCNMhqUnCK/VT0sqjFlqMv5hpCC8WLg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4d7e4439-5e67-4c5f-aed1-199015329c25@yandex-team.ru>
Date: Fri, 25 Jul 2025 16:25:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/smbios: allow clearing the VM bit in SMBIOS table 0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20250724195409.43499-1-d-tatianin@yandex-team.ru>
 <20250725091651-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20250725091651-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


On 7/25/25 4:20 PM, Michael S. Tsirkin wrote:
> On Thu, Jul 24, 2025 at 10:54:09PM +0300, Daniil Tatianin wrote:
>> This is useful to be able to freeze a specific version of SeaBIOS to
>> prevent guest visible changes between BIOS updates. This is currently
>> not possible since the extension byte 2 provided by SeaBIOS does not
>> set the VM bit, whereas QEMU sets it unconditionally.
>>
>> Allowing to clear it also seems useful if we want to hide the fact that
>> the guest system is running inside a virtual machine.
>>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> ---
>>
>> After talking to Michael:
>> Supersedes: <20250723090128.977364-1-d-tatianin@yandex-team.ru>
>>
>> v2:
>> - Add the new option to qemu-options.hx
>>
>> ---
>>   hw/smbios/smbios.c           | 11 ++++++++++-
>>   include/hw/firmware/smbios.h |  2 +-
>>   qemu-options.hx              |  2 +-
>>   3 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>> index 1ac063cfb4..13e21a9c43 100644
>> --- a/hw/smbios/smbios.c
>> +++ b/hw/smbios/smbios.c
>> @@ -179,6 +179,10 @@ static const QemuOptDesc qemu_smbios_type0_opts[] = {
>>           .name = "uefi",
>>           .type = QEMU_OPT_BOOL,
>>           .help = "uefi support",
>> +    },{
>> +        .name = "vm",
>> +        .type = QEMU_OPT_BOOL,
>> +        .help = "virtual machine",
>>       },
>>       { /* end of list */ }
>>   };
>
> Can/should we just poke at "hypervisor" CPU property?

Well that property is part of the CPUID flags, and this one is part of 
SMBIOS.
Sometimes you may wish to have one set, but the other clear.
For example for SeaBIOS compatibility, like some fields already do here 
(look at the comments for some of them).
SeaBIOS never sets the VM flag at all, so IMO QEMU shouldn't have as 
well, but since that's already the default
we can at least add an option to make it not do that if going for 
SeaBIOS compatibility.

>
> Cc Paolo for comments.
>
>> @@ -574,10 +578,14 @@ static void smbios_build_type_0_table(void)
>>   
>>       t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
>>       t->bios_characteristics_extension_bytes[0] = 0;
>> -    t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
>> +
>> +    t->bios_characteristics_extension_bytes[1] = 0x04; /* TCD/SVVP */
>>       if (smbios_type0.uefi) {
>>           t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
>>       }
>> +    if (smbios_type0.vm) {
>> +        t->bios_characteristics_extension_bytes[1] |= 0x10; /* |= VM */
>> +    }
>>   
>>       if (smbios_type0.have_major_minor) {
>>           t->system_bios_major_release = smbios_type0.major;
>> @@ -1405,6 +1413,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>>               save_opt(&smbios_type0.version, opts, "version");
>>               save_opt(&smbios_type0.date, opts, "date");
>>               smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
>> +            smbios_type0.vm = qemu_opt_get_bool(opts, "vm", true);
>>   
>>               val = qemu_opt_get(opts, "release");
>>               if (val) {
>> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
>> index f066ab7262..3ea732f4e6 100644
>> --- a/include/hw/firmware/smbios.h
>> +++ b/include/hw/firmware/smbios.h
>> @@ -22,7 +22,7 @@ extern GArray *usr_blobs_sizes;
>>   
>>   typedef struct {
>>       const char *vendor, *version, *date;
>> -    bool have_major_minor, uefi;
>> +    bool have_major_minor, uefi, vm;
>>       uint8_t major, minor;
>>   } smbios_type0_t;
>>   extern smbios_type0_t smbios_type0;
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index ab23f14d21..11204c47eb 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -2693,7 +2693,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>>       "-smbios file=binary\n"
>>       "                load SMBIOS entry from binary file\n"
>>       "-smbios type=0[,vendor=str][,version=str][,date=str][,release=%d.%d]\n"
>> -    "              [,uefi=on|off]\n"
>> +    "              [,uefi=on|off][,vm=on|off]\n"
>>       "                specify SMBIOS type 0 fields\n"
>>       "-smbios type=1[,manufacturer=str][,product=str][,version=str][,serial=str]\n"
>>       "              [,uuid=uuid][,sku=str][,family=str]\n"
>> -- 
>> 2.34.1

