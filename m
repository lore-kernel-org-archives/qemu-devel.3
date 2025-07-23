Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A684C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 09:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueVaL-0005Kg-3F; Wed, 23 Jul 2025 05:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1ueVaH-0005IS-MH
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:16:22 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1ueVaB-000280-MJ
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:16:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2281:0:640:de44:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7FD1588582;
 Wed, 23 Jul 2025 12:16:10 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:579::1:1b] (unknown
 [2a02:6bf:8080:579::1:1b])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9GPfF33GqKo0-em4suqll; Wed, 23 Jul 2025 12:16:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1753262170;
 bh=cF+0ap7EivSLEIZw/FPL4NgUn8TbCza5fmk4mNYx2eE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=oCjBRPNYmF1gIdeE3EyWuNmdQXPeAaTJ4eWiXcsXh+hdIlGOfgfuknqpWX4oaKfyV
 +CvxZgmc8jCeYi8x0QX2Lg2jXeGozVuoZoP2K33br6w8bA+8awnL5R8c0aDX36A8TC
 VrLWeUD8QzWgfrNI+YstZllJErsg4PbGkcmewGP4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d5f272b4-de89-4748-9b48-1322a36671e4@yandex-team.ru>
Date: Wed, 23 Jul 2025 12:16:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/smbios: add an ability to set extension bytes in the
 type0 table
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
References: <20250723090128.977364-1-d-tatianin@yandex-team.ru>
 <20250723051334-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20250723051334-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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


On 7/23/25 12:14 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 23, 2025 at 12:01:28PM +0300, Daniil Tatianin wrote:
>> This is useful to be able to indicate various supported features to the
>> guest, or freeze a specific version of SeaBIOS to prevent guest visible
>> changes between BIOS updates. This is currently not possible since the
>> extension bytes indicated by SeaBIOS are slightly different than those
>> QEMU sets by default.
>>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> ---
>>   hw/smbios/smbios.c           | 66 +++++++++++++++++++++++++++++++++---
>>   include/hw/firmware/smbios.h |  3 ++
>>   2 files changed, 64 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>> index ad4cd6721e..73699e8a62 100644
>> --- a/hw/smbios/smbios.c
>> +++ b/hw/smbios/smbios.c
>> @@ -178,6 +178,14 @@ static const QemuOptDesc qemu_smbios_type0_opts[] = {
>>           .name = "uefi",
>>           .type = QEMU_OPT_BOOL,
>>           .help = "uefi support",
>> +    },{
>> +        .name = "extension_byte_1",
>> +        .type = QEMU_OPT_NUMBER,
>> +        .help = "BIOS characteristics extension byte 1"
>> +    },{
>> +        .name = "extension_byte_2",
>> +        .type = QEMU_OPT_NUMBER,
>> +        .help = "BIOS characteristics extension byte 2"
>>       },
>>       { /* end of list */ }
>>   };
>> @@ -572,10 +580,23 @@ static void smbios_build_type_0_table(void)
>>       t->bios_rom_size = 0; /* hardcoded in SeaBIOS with FIXME comment */
>>   
>>       t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
>> -    t->bios_characteristics_extension_bytes[0] = 0;
>> -    t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
>> -    if (smbios_type0.uefi) {
>> -        t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
>> +
>> +    if (smbios_type0.have_extension_bytes[0]) {
>> +        t->bios_characteristics_extension_bytes[0] =
>> +            smbios_type0.extension_bytes[0];
>> +    } else {
>> +        t->bios_characteristics_extension_bytes[0] = 0;
>> +    }
>> +
>> +    if (smbios_type0.have_extension_bytes[1]) {
>> +        t->bios_characteristics_extension_bytes[1] =
>> +            smbios_type0.extension_bytes[1];
>> +    } else {
>> +        t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
>> +
>> +        if (smbios_type0.uefi) {
>> +            t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
>> +        }
> should we not or these in, anyway?

That's fair enough, but I thought since you're specifying the entire 
byte anyway you don't
want a different option modifying your value, that would most likely be 
a bug IMO.

>
>>       }
>>   
>>       if (smbios_type0.have_major_minor) {
>> @@ -1403,7 +1424,42 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>>               save_opt(&smbios_type0.vendor, opts, "vendor");
>>               save_opt(&smbios_type0.version, opts, "version");
>>               save_opt(&smbios_type0.date, opts, "date");
>> -            smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
>> +
>> +            if (qemu_opt_get(opts, "extension_byte_1")) {
>> +                uint64_t ex_val;
>> +
>> +                ex_val = qemu_opt_get_number(opts, "extension_byte_1", 0);
>> +                if (ex_val > 0xFF) {
>> +                    error_setg(errp, "Invalid extension_byte_1");
>> +                    return;
>> +                }
>> +
>> +                smbios_type0.extension_bytes[0] = ex_val;
>> +                smbios_type0.have_extension_bytes[0] = true;
>> +            }
>> +
>> +            if (qemu_opt_get(opts, "extension_byte_2")) {
>> +                uint64_t ex_val;
>> +
>> +                ex_val = qemu_opt_get_number(opts, "extension_byte_2", 0);
>> +                if (ex_val > 0xFF) {
>> +                    error_setg(errp, "Invalid extension_byte_2");
>> +                    return;
>> +                }
>> +
>> +                smbios_type0.extension_bytes[1] = ex_val;
>> +                smbios_type0.have_extension_bytes[1] = true;
>> +            }
>> +
>> +            if (qemu_opt_get(opts, "uefi")) {
>> +                if (smbios_type0.have_extension_bytes[1]) {
>> +                    error_setg(errp, "'uefi' and 'extension_byte_2' are "
>> +                                     "mutually exclusive");
>> +                    return;
>> +                }
>> +
>> +                smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
>> +            }
>>   
>>               val = qemu_opt_get(opts, "release");
>>               if (val) {
>> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
>> index f066ab7262..67b3b28471 100644
>> --- a/include/hw/firmware/smbios.h
>> +++ b/include/hw/firmware/smbios.h
>> @@ -24,6 +24,9 @@ typedef struct {
>>       const char *vendor, *version, *date;
>>       bool have_major_minor, uefi;
>>       uint8_t major, minor;
>> +
>> +    bool have_extension_bytes[2];
>> +    uint8_t extension_bytes[2];
>>   } smbios_type0_t;
>>   extern smbios_type0_t smbios_type0;
>>   
>> -- 
>> 2.34.1

