Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41269C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 09:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueVlu-00086P-93; Wed, 23 Jul 2025 05:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1ueVlp-00082I-CZ
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:28:17 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1ueVll-0005x1-Pc
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:28:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:3c8c:0:640:20c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B89D9C011F;
 Wed, 23 Jul 2025 12:28:08 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:579::1:1b] (unknown
 [2a02:6bf:8080:579::1:1b])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7SP4Ov3GseA0-sHCQBBdh; Wed, 23 Jul 2025 12:28:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1753262888;
 bh=V0AKaWjXtzC/8Hiak9n+DladZfRcF+0htpa2Kr8S5bA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=FoqLtrjlWkXuIR36Kg/4D3NeppScu/Ydc0k+YrHS8e4QfR64ATKD6jMEWgrrAtHwh
 zKhZTW/ta+yWNOj4i5A+AOEDTtpcoGv9oIvs9zpeOXKgEA/4JVGFQ3aeFrRhR3El8k
 4fnax755Seqnr7/6KF71iDzXqmt7SxYtNuAZj4A0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <98c397df-5fd6-4360-86d7-a7cacf2b05ca@yandex-team.ru>
Date: Wed, 23 Jul 2025 12:28:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/smbios: add an ability to set extension bytes in the
 type0 table
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
References: <20250723090128.977364-1-d-tatianin@yandex-team.ru>
 <20250723051334-mutt-send-email-mst@kernel.org>
 <d5f272b4-de89-4748-9b48-1322a36671e4@yandex-team.ru>
 <20250723052216-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20250723052216-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/23/25 12:23 PM, Michael S. Tsirkin wrote:

> On Wed, Jul 23, 2025 at 12:16:08PM +0300, Daniil Tatianin wrote:
>> On 7/23/25 12:14 PM, Michael S. Tsirkin wrote:
>>> On Wed, Jul 23, 2025 at 12:01:28PM +0300, Daniil Tatianin wrote:
>>>> This is useful to be able to indicate various supported features to the
>>>> guest, or freeze a specific version of SeaBIOS to prevent guest visible
>>>> changes between BIOS updates. This is currently not possible since the
>>>> extension bytes indicated by SeaBIOS are slightly different than those
>>>> QEMU sets by default.
>>>>
>>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>>> ---
>>>>    hw/smbios/smbios.c           | 66 +++++++++++++++++++++++++++++++++---
>>>>    include/hw/firmware/smbios.h |  3 ++
>>>>    2 files changed, 64 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>>>> index ad4cd6721e..73699e8a62 100644
>>>> --- a/hw/smbios/smbios.c
>>>> +++ b/hw/smbios/smbios.c
>>>> @@ -178,6 +178,14 @@ static const QemuOptDesc qemu_smbios_type0_opts[] = {
>>>>            .name = "uefi",
>>>>            .type = QEMU_OPT_BOOL,
>>>>            .help = "uefi support",
>>>> +    },{
>>>> +        .name = "extension_byte_1",
>>>> +        .type = QEMU_OPT_NUMBER,
>>>> +        .help = "BIOS characteristics extension byte 1"
>>>> +    },{
>>>> +        .name = "extension_byte_2",
>>>> +        .type = QEMU_OPT_NUMBER,
>>>> +        .help = "BIOS characteristics extension byte 2"
>>>>        },
>>>>        { /* end of list */ }
>>>>    };
>>>> @@ -572,10 +580,23 @@ static void smbios_build_type_0_table(void)
>>>>        t->bios_rom_size = 0; /* hardcoded in SeaBIOS with FIXME comment */
>>>>        t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
>>>> -    t->bios_characteristics_extension_bytes[0] = 0;
>>>> -    t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
>>>> -    if (smbios_type0.uefi) {
>>>> -        t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
>>>> +
>>>> +    if (smbios_type0.have_extension_bytes[0]) {
>>>> +        t->bios_characteristics_extension_bytes[0] =
>>>> +            smbios_type0.extension_bytes[0];
>>>> +    } else {
>>>> +        t->bios_characteristics_extension_bytes[0] = 0;
>>>> +    }
>>>> +
>>>> +    if (smbios_type0.have_extension_bytes[1]) {
>>>> +        t->bios_characteristics_extension_bytes[1] =
>>>> +            smbios_type0.extension_bytes[1];
>>>> +    } else {
>>>> +        t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
>>>> +
>>>> +        if (smbios_type0.uefi) {
>>>> +            t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
>>>> +        }
>>> should we not or these in, anyway?
>> That's fair enough, but I thought since you're specifying the entire byte
>> anyway you don't
>> want a different option modifying your value, that would most likely be a
>> bug IMO.
>
> But specifying uefi on command line is also user's choice.
>
> Maybe we just want flags for all the options. Which ones do
> you actually have a practicall need to tweak, and why?

As far as I can see, QEMU unconditionally sets the VM flag, which 
SeaBIOS doesn't set. I want it cleared to make sure no guest visible 
changes are introduced.
Technically there is 14 feature bits, out of which we already have one. 
Do you think it would be better to just make the one specific bit I want 
customizable?
There might be a need in the future to extend this further, so we will 
have to either introduce all 14 flags, or just allow the user to specify 
the entire value
like this patch does.

>
>
>>>>        }
>>>>        if (smbios_type0.have_major_minor) {
>>>> @@ -1403,7 +1424,42 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>>>>                save_opt(&smbios_type0.vendor, opts, "vendor");
>>>>                save_opt(&smbios_type0.version, opts, "version");
>>>>                save_opt(&smbios_type0.date, opts, "date");
>>>> -            smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
>>>> +
>>>> +            if (qemu_opt_get(opts, "extension_byte_1")) {
>>>> +                uint64_t ex_val;
>>>> +
>>>> +                ex_val = qemu_opt_get_number(opts, "extension_byte_1", 0);
>>>> +                if (ex_val > 0xFF) {
>>>> +                    error_setg(errp, "Invalid extension_byte_1");
>>>> +                    return;
>>>> +                }
>>>> +
>>>> +                smbios_type0.extension_bytes[0] = ex_val;
>>>> +                smbios_type0.have_extension_bytes[0] = true;
>>>> +            }
>>>> +
>>>> +            if (qemu_opt_get(opts, "extension_byte_2")) {
>>>> +                uint64_t ex_val;
>>>> +
>>>> +                ex_val = qemu_opt_get_number(opts, "extension_byte_2", 0);
>>>> +                if (ex_val > 0xFF) {
>>>> +                    error_setg(errp, "Invalid extension_byte_2");
>>>> +                    return;
>>>> +                }
>>>> +
>>>> +                smbios_type0.extension_bytes[1] = ex_val;
>>>> +                smbios_type0.have_extension_bytes[1] = true;
>>>> +            }
>>>> +
>>>> +            if (qemu_opt_get(opts, "uefi")) {
>>>> +                if (smbios_type0.have_extension_bytes[1]) {
>>>> +                    error_setg(errp, "'uefi' and 'extension_byte_2' are "
>>>> +                                     "mutually exclusive");
>>>> +                    return;
>>>> +                }
>>>> +
>>>> +                smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
>>>> +            }
>>>>                val = qemu_opt_get(opts, "release");
>>>>                if (val) {
>>>> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
>>>> index f066ab7262..67b3b28471 100644
>>>> --- a/include/hw/firmware/smbios.h
>>>> +++ b/include/hw/firmware/smbios.h
>>>> @@ -24,6 +24,9 @@ typedef struct {
>>>>        const char *vendor, *version, *date;
>>>>        bool have_major_minor, uefi;
>>>>        uint8_t major, minor;
>>>> +
>>>> +    bool have_extension_bytes[2];
>>>> +    uint8_t extension_bytes[2];
>>>>    } smbios_type0_t;
>>>>    extern smbios_type0_t smbios_type0;
>>>> -- 
>>>> 2.34.1

