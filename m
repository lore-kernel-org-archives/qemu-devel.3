Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C442CC87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 08:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujZNG-0005nw-Bg; Wed, 06 Aug 2025 04:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1ujZN4-0005kO-T6
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:19:39 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1ujZN1-0006a0-GL
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:19:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c43:4603:0:640:d209:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id F1A0E80D36;
 Wed, 06 Aug 2025 11:19:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:732::1:3a] (unknown
 [2a02:6bf:8080:732::1:3a])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RJcYfLBGpeA0-c7qupYGt; Wed, 06 Aug 2025 11:19:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1754468367;
 bh=6C36zAA/1KcXt+an+3NxMTGU+RL7WBaalRSZJR98uZ8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MODQ9WlMsfrGH7ITYDljtEHrHCNVBx1dNoXkvPjug4w2sEmkfau3OpN5V6wp1m6D1
 O34OcP20NCx4OqcCC2Lcg5Q4xAKRAioQeB2imKWzIr1rVlNyshSAQDy/yYrlEZohMa
 aZnKfRTJ55hGlesQj7svVgcDpWqvNFtDwcZejzL0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <007eb550-2f6f-4116-8dc1-9f7151575656@yandex-team.ru>
Date: Wed, 6 Aug 2025 11:19:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/smbios: allow clearing the VM bit in SMBIOS table 0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
References: <20250724195409.43499-1-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20250724195409.43499-1-d-tatianin@yandex-team.ru>
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

Ping :)

On 7/24/25 10:54 PM, Daniil Tatianin wrote:
> This is useful to be able to freeze a specific version of SeaBIOS to
> prevent guest visible changes between BIOS updates. This is currently
> not possible since the extension byte 2 provided by SeaBIOS does not
> set the VM bit, whereas QEMU sets it unconditionally.
>
> Allowing to clear it also seems useful if we want to hide the fact that
> the guest system is running inside a virtual machine.
>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>
> After talking to Michael:
> Supersedes: <20250723090128.977364-1-d-tatianin@yandex-team.ru>
>
> v2:
> - Add the new option to qemu-options.hx
>
> ---
>   hw/smbios/smbios.c           | 11 ++++++++++-
>   include/hw/firmware/smbios.h |  2 +-
>   qemu-options.hx              |  2 +-
>   3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 1ac063cfb4..13e21a9c43 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -179,6 +179,10 @@ static const QemuOptDesc qemu_smbios_type0_opts[] = {
>           .name = "uefi",
>           .type = QEMU_OPT_BOOL,
>           .help = "uefi support",
> +    },{
> +        .name = "vm",
> +        .type = QEMU_OPT_BOOL,
> +        .help = "virtual machine",
>       },
>       { /* end of list */ }
>   };
> @@ -574,10 +578,14 @@ static void smbios_build_type_0_table(void)
>   
>       t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
>       t->bios_characteristics_extension_bytes[0] = 0;
> -    t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
> +
> +    t->bios_characteristics_extension_bytes[1] = 0x04; /* TCD/SVVP */
>       if (smbios_type0.uefi) {
>           t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
>       }
> +    if (smbios_type0.vm) {
> +        t->bios_characteristics_extension_bytes[1] |= 0x10; /* |= VM */
> +    }
>   
>       if (smbios_type0.have_major_minor) {
>           t->system_bios_major_release = smbios_type0.major;
> @@ -1405,6 +1413,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>               save_opt(&smbios_type0.version, opts, "version");
>               save_opt(&smbios_type0.date, opts, "date");
>               smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
> +            smbios_type0.vm = qemu_opt_get_bool(opts, "vm", true);
>   
>               val = qemu_opt_get(opts, "release");
>               if (val) {
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index f066ab7262..3ea732f4e6 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -22,7 +22,7 @@ extern GArray *usr_blobs_sizes;
>   
>   typedef struct {
>       const char *vendor, *version, *date;
> -    bool have_major_minor, uefi;
> +    bool have_major_minor, uefi, vm;
>       uint8_t major, minor;
>   } smbios_type0_t;
>   extern smbios_type0_t smbios_type0;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ab23f14d21..11204c47eb 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2693,7 +2693,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>       "-smbios file=binary\n"
>       "                load SMBIOS entry from binary file\n"
>       "-smbios type=0[,vendor=str][,version=str][,date=str][,release=%d.%d]\n"
> -    "              [,uefi=on|off]\n"
> +    "              [,uefi=on|off][,vm=on|off]\n"
>       "                specify SMBIOS type 0 fields\n"
>       "-smbios type=1[,manufacturer=str][,product=str][,version=str][,serial=str]\n"
>       "              [,uuid=uuid][,sku=str][,family=str]\n"

