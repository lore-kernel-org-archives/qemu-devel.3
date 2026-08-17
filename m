Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EACC5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvu7W-0003QF-PF; Mon, 17 Aug 2026 05:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvu7U-0003Pt-LD; Mon, 17 Aug 2026 05:59:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvu7S-0001sk-Et; Mon, 17 Aug 2026 05:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786960717; bh=GNxEk2H/mU4dbTcTnsNwida5ojR7xYD95mQHVXATucA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Kz2Q8z98PZILT1cG7pDyaZWptlRpAI/lAjgFZIbtm0vKf8UhHMxOn95TyNNFhYfOD
 WzHdYjg2COdsRu04Ey4qLvxtuJuPAAQAb7oDeukus60v+AzslN8/t9EPrEfs0whio9
 fl7SKMgPeKI2WYERhMA8j3CVPdUc29nxDxdoKN9RCNGRT4Q9CEXeau6slKirKIRA47
 Dpufvx1iWq+bT95CVku4RSwV5C/8/fP+fGc1DAP/fqdGaW+1B1Smo37ZpwSO6WauU+
 uD8iA4ZkhFkL+hx1z6aVwDzvqV3o8o4468AOG9BFe1R1AWQoN8N2paje8T+l3zDpNh
 M3Uuowj3VxeYQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 72C121CBACF;
 Mon, 17 Aug 2026 12:58:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 450C940D16D;
 Mon, 17 Aug 2026 12:58:58 +0300 (MSK)
Message-ID: <6d153b74-265a-462b-934d-cd46b2dd2088@tls.msk.ru>
Date: Mon, 17 Aug 2026 12:58:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu] pc-bios/s390-ccw: Fix off-by-one errors with
 loadparm and boot entries
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, zycai@linux.ibm.com, jjherne@linux.ibm.com,
 borntraeger@linux.ibm.com, jdaley@linux.ibm.com, qemu-stable@nongnu.org
References: <20260728223013.4047042-1-jrossi@linux.ibm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260728223013.4047042-1-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 7/29/26 01:30, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> The loadparm may optionally be used to select a boot entry, with the
> intended range being 0 through 31 inclusive, for a total of 32 entries.
> Previously, MAX_BOOT_ENTRIES was defined as 31, indicating that it was
> intended to correspond to the index of the boot entry rather than the
> count; however, some guards also used MAX_BOOT_ENTRIES as a count of the
> maximum allowed entries, which resulted in a mismatch between the intended
> and actual range such that index 31 could never be used in practice.
> 
> Move the definition of MAX_BOOT_ENTRIES to qipl.h so it is shared and
> change the value to 32, representing a count of the maximum number of
> allowed boot entries and allowing the loadparm to accept values 0 through
> 31 as intended.  Update some instances in the netboot code where
> MAX_BOOT_ENTRIES was used as the max index so that all guards treat
> MAX_BOOT_ENTRIES as a count across all boot methods.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 806315279d5c ("pc-bios/s390-ccw: Remove panics from ECKD IPL path")
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

While this commit suggests that the original issue were introduced in
806315279d5c (which is qemu v9.2.0), it looks like actual bug has
become possible only after a different commit, a4adf071dc7
("pc-bios/s390-ccw: Allow to select a different pxelinux.cfg entry via loadparm"),
which is only qemu v11.0.0.

So I'm not picking this change to 10.0.x stable series (at least not until
a4adf071dc7 is there too, which I don't think is necessary).

Please let me know if I should, instead, pick both of the commits to
10.0.x, or should rework this change to work on 10.0.x instead (which -
it seems - is not necessary).

Thanks,

/mjt

>   include/hw/s390x/ipl/qipl.h |  2 ++
>   pc-bios/s390-ccw/netmain.c  | 11 +++++++----
>   pc-bios/s390-ccw/s390-ccw.h |  2 --
>   3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index 8d3c83a80b..b390f2f112 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -20,6 +20,8 @@
>   #define LOADPARM_LEN    8
>   #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
>   
> +#define MAX_BOOT_ENTRIES  32
> +
>   enum S390IplType {
>       S390_IPL_TYPE_FCP = 0x00,
>       S390_IPL_TYPE_CCW = 0x02,
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 651cedf6ef..791854fce0 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -40,6 +40,9 @@
>   #define DEFAULT_BOOT_RETRIES 10
>   #define DEFAULT_TFTP_RETRIES 20
>   
> +/* Index 0 is reserved for default alias, start PXE cfg indices at 1 */
> +#define PXECFG_MAX              (MAX_BOOT_ENTRIES - 1)
> +
>   extern char _start[];
>   
>   #define KERNEL_ADDR             ((void *)0L)
> @@ -381,13 +384,13 @@ static int net_select_and_load_kernel(filename_ip_t *fn_ip,
>   
>   static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
>   {
> -    struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
> +    struct pl_cfg_entry entries[PXECFG_MAX];
>       int num_ent, def_ent = 0;
>   
>       num_ent = pxelinux_load_parse_cfg(fn_ip, mac, get_uuid(),
>                                         DEFAULT_TFTP_RETRIES,
>                                         cfgbuf, sizeof(cfgbuf),
> -                                      entries, MAX_BOOT_ENTRIES, &def_ent);
> +                                      entries, PXECFG_MAX, &def_ent);
>   
>       return net_select_and_load_kernel(fn_ip, num_ent, def_ent, entries);
>   }
> @@ -470,11 +473,11 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
>            * a magic comment string.
>            */
>           if (!strncasecmp("# pxelinux", cfgbuf, 10)) {
> -            struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
> +            struct pl_cfg_entry entries[PXECFG_MAX];
>               int num_ent, def_ent = 0;
>   
>               num_ent = pxelinux_parse_cfg(cfgbuf, sizeof(cfgbuf), entries,
> -                                         MAX_BOOT_ENTRIES, &def_ent);
> +                                         PXECFG_MAX, &def_ent);
>               return net_select_and_load_kernel(fn_ip, num_ent, def_ent,
>                                                 entries);
>           }
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 1e1f71775e..d0498e2944 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -82,8 +82,6 @@ int menu_get_enum_boot_index(bool *valid_entries);
>   bool menu_is_enabled_enum(void);
>   int menu_get_boot_index(bool *valid_entries);
>   
> -#define MAX_BOOT_ENTRIES  31
> -
>   __attribute__ ((__noreturn__))
>   static inline void panic(const char *string)
>   {


