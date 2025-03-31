Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AAFC36018
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 06:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tz8rr-0002XI-Un; Mon, 31 Mar 2025 02:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=N63T=WS=kaod.org=clg@ozlabs.org>)
 id 1tz8q0-0002Mz-HP; Mon, 31 Mar 2025 02:41:36 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=N63T=WS=kaod.org=clg@ozlabs.org>)
 id 1tz8pw-0002uK-Sf; Mon, 31 Mar 2025 02:41:36 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZR1kC6K7Mz4wnp;
 Mon, 31 Mar 2025 17:41:23 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZR1k90fjgz4wcn;
 Mon, 31 Mar 2025 17:41:20 +1100 (AEDT)
Message-ID: <9eca6d79-7910-43df-850a-bc55a701d964@kaod.org>
Date: Mon, 31 Mar 2025 08:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/ppc: Deprecate Power8E and Power8NVL
To: Aditya Gupta <adityag@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250329142641.2502003-1-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250329142641.2502003-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=N63T=WS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/29/25 15:26, Aditya Gupta wrote:
> Power8E and Power8NVL variants are not of much use in QEMU now, and not
> being maintained either.
> 
> Newer skiboot might not be able to boot Power8NVL since skiboot v7.0
> 

It is worth mentioning commit c5424f683ee3 ("Remove support for
POWER8 DD1") too. In fact, I prefer the cover letter section below
for a commit log.

This commit log is not mentioning the introduction of POWERPC_DEPRECATED_CPU.
I suggest adding an extra patch for it.

> Deprecate the 8E and 8NVL variants.
> 
> After deprecation, QEMU will print a warning like below when the
> CPU/Chips are used:
> 
>      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8nvl -nographic
>      qemu-system-ppc64: warning: CPU model power8nvl_v1.0-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
>      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8e -nographic
>      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
>      $ ./build/qemu-system-ppc64 -M pseries --cpu power8e -nographic
>      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...

This is not very useful and it belongs to a patch adding
POWERPC_DEPRECATED_CPU.

  
> Also, print '(deprecated)' for deprecated CPUs in 'qemu-system-ppc64
> --cpu ?':
> 
>      $ ./build/qemu-system-ppc64 --cpu help
>        ...
>        power8e_v2.1     PVR 004b0201 (deprecated)
>        power8e          (alias for power8e_v2.1)
>        power8nvl_v1.0   PVR 004c0100 (deprecated)
>        power8nvl        (alias for power8nvl_v1.0)
>        power8_v2.0      PVR 004d0200
>        power8           (alias for power8_v2.0)
>        power9_v2.0      PVR 004e1200
>        power9_v2.2      PVR 004e1202


ditto.

> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> 
> ---
> Cover Letter
> ============


Why don't you use --cover-letter instead ? The rational would be at
the beginning.

> Power8E and Power8NVL are not maintained, and not useful to qemu, and
> upstream skiboot also has removed support till Power8 DD1.
> Power8NVL CPU doesn't boot since skiboot v7.0, or following skiboot commit
> to be exact:
> 
>      commit c5424f683ee3 ("Remove support for POWER8 DD1")
> 
> No direct way to deprecate the pnv chips, a field like deprecation_note
> could be added, but felt not needed as the chip will only get used if
> the user requests corresponding 8E / 8NVL CPU, which will print
> deprecation warning.
> 
> Also, no separate pnv machine for 8E and 8NVL, user has to pass --cpu,
> which will throw the deprecation warning. So just deprecating CPUs should
> be enough.

Please separate the changes, one patch for POWERPC_DEPRECATED_CPU,
another for PowerNV deprecation. More CPUs could be deprecated.

Also, we have time : the QEMU 10.1 development phase has not started
and the soft freeze should be around July. No rush needed.

Thanks,

C.


> 
> Changelog
> =========
> v2:
>    + add mention to docs/about/deprecated.rst
>    + add '(deprecated)' in output of qemu-system-ppc64 --cpu help
> ---
> ---
>   docs/about/deprecated.rst |  9 +++++++++
>   target/ppc/cpu-models.c   | 17 ++++++++++++++---
>   target/ppc/cpu_init.c     |  7 ++++++-
>   3 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index e2b4f077d453..d6b39db2aaca 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -275,6 +275,15 @@ embedded 405 for power management (OCC) and other internal tasks, it
>   is theoretically possible to use QEMU to model them. Let's keep the
>   CPU implementation for a while before removing all support.
>   
> +Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The Power8E and Power8NVL variants of Power8 are not really useful anymore
> +in qemu, and are old and unmaintained now.
> +
> +The CPUs as well as corresponding Power8NVL and Power8E PnvChips will also
> +be considered deprecated.
> +
>   System emulator machines
>   ------------------------
>   
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index ece348178188..6f2062e2c484 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -32,17 +32,22 @@
>   /* PowerPC CPU definitions                                                 */
>   #define POWERPC_DEF_PREFIX(pvr, svr, type)                                  \
>       glue(glue(glue(glue(pvr, _), svr), _), type)
> -#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
> +#define POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, _is_deprecated) \
>       static void                                                             \
>       glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_class_init)            \
>       (ObjectClass *oc, void *data)                                           \
>       {                                                                       \
>           DeviceClass *dc = DEVICE_CLASS(oc);                                 \
> +        CPUClass *cc    = CPU_CLASS(oc);                                    \
>           PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);                       \
>                                                                               \
>           pcc->pvr          = _pvr;                                           \
>           pcc->svr          = _svr;                                           \
>           dc->desc          = _desc;                                          \
> +                                                                            \
> +        if (_is_deprecated) {                                               \
> +            cc->deprecation_note = "CPU is unmaintained.";                  \
> +        }                                                                   \
>       }                                                                       \
>                                                                               \
>       static const TypeInfo                                                   \
> @@ -63,6 +68,12 @@
>       type_init(                                                              \
>           glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_register_types))
>   
> +#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
> +    POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, false)
> +
> +#define POWERPC_DEPRECATED_CPU(_name, _pvr, _type, _desc)                   \
> +    POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type, true)
> +
>   #define POWERPC_DEF(_name, _pvr, _type, _desc)                              \
>       POWERPC_DEF_SVR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type)
>   
> @@ -722,11 +733,11 @@
>                   "POWER7 v2.3")
>       POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
>                   "POWER7+ v2.1")
> -    POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POWER8,
> +    POWERPC_DEPRECATED_CPU("power8e_v2.1",  CPU_POWERPC_POWER8E_v21, POWER8,
>                   "POWER8E v2.1")
>       POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
>                   "POWER8 v2.0")
> -    POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POWER8,
> +    POWERPC_DEPRECATED_CPU("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10, POWER8,
>                   "POWER8NVL v1.0")
>       POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
>                   "POWER9 v2.0")
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 7decc09aec8f..fade53f7e2d6 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7143,6 +7143,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
>   {
>       ObjectClass *oc = data;
>       PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> +    CPUClass *cc = CPU_CLASS(oc);
>       DeviceClass *family = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
>       const char *typename = object_class_get_name(oc);
>       char *name;
> @@ -7153,7 +7154,11 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
>       }
>   
>       name = cpu_model_from_type(typename);
> -    qemu_printf("  %-16s PVR %08x\n", name, pcc->pvr);
> +    if (cc->deprecation_note) {
> +        qemu_printf("  %-16s PVR %08x (deprecated)\n", name, pcc->pvr);
> +    } else {
> +        qemu_printf("  %-16s PVR %08x\n", name, pcc->pvr);
> +    }
>       for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
>           PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
>           ObjectClass *alias_oc = ppc_cpu_class_by_name(alias->model);


