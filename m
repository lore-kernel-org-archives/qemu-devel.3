Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8C5CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcaI-0008Jy-EG; Tue, 28 Oct 2025 01:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vDca4-0008H7-PX
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vDca0-0003jX-Os
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761630550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/2DiDnn5h61WikogYnnTD+nav6KqwXzmFdekQ30C9M=;
 b=Z0OQYtd1fcwp6f1hqO5+UeGKBphnwJpcRzu6/BtsR5jsSf9v2EmZ2+V9coJSZjsWDUELg/
 1OFPKNmHKMJOCS8QXkLKZRxCyjcIsXd30I9j8DiDI3JAmmLHYQLC7G0DQ909TpKPKJEbnq
 8m/mf0+mF/Wylo8ytKboRdmbOBJ+mTM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-83_oboZvPCelhSnvs7RkXQ-1; Tue, 28 Oct 2025 01:49:09 -0400
X-MC-Unique: 83_oboZvPCelhSnvs7RkXQ-1
X-Mimecast-MFC-AGG-ID: 83_oboZvPCelhSnvs7RkXQ_1761630548
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3307af9b55eso4206486a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630548; x=1762235348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V/2DiDnn5h61WikogYnnTD+nav6KqwXzmFdekQ30C9M=;
 b=Cz7wy5OkIOvO/wwpyijaerFxFoPLdqnm3HLHwsnFkLRzz6lFzZWw4UVEP5Si5pucE5
 534QLJHFw7vlN2W+O1yq7d9viJBFOAd1uvYag7uJXPg3LyDsCBtdO52P2zmaXKGSZd1e
 D6jHAsfqzzMMp1FNVaVPiX2Bng05Yfs8wHDiNYV/FwUeGkVyBBlNYEFeFI+dMqWArv1B
 3F6TVcN1IK49OkER7KlyHqDLt10iLnibBDOMi/n2FjzZ45kN+BVdOdNFa0KHwap9Bhpz
 gmcNDYOQ24j6KNLOIUPmKTZCCju3HYxFT7qcmxUwh/D/v1P1Op8FugVI57oZeiEJvsWD
 Ms0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIPe3AsSb/HoDFoMFI+Q1Ylj8piSoKziJ5AKvCHzx64+1GhVKWdyuj9MVPWaKzfgQgjUPKYZEH9Rdq@nongnu.org
X-Gm-Message-State: AOJu0YxD8Cu+kIZT6RqXsyNFCgvajZGJSb54wzOK2WbIkFszjkpEiwnp
 qkzu4APwNPSXYxBTTHIuW6F9G2bAs4OEmj10/eP+llT/E0aTNFeyfc8sLrkYCJ5v8myZSMupSLM
 tGnSF49eICO+dO3b7yYDHIIrjLJ1UG/HxF1PXhJvRmwRn3/z2GJnlRFYz
X-Gm-Gg: ASbGncsj/9riYCFTlfcxOY9L25QkSdXtw6yWXBFD1lJxC03s00Rk3WQYWP+xI5KtzIJ
 ppTFQ1gXpLMkdkk6R265ZGJDYM6AUNujiJZ7S0V9KC9+2ogGOREz3isvE2fqOkM7j4CRZhV9Mi+
 BJ5BT9wbk8SFktlBx6hswz1s301O7WcNaqBlG02yOeC3NIC6k/zMWVatv6hlbGxTWAPoiSSKdPH
 65WkuI3wG35pfAVggheY6ljByCEgsgKKk17RarCIYJBh2xSBrGiQZHmf4nz5Ob5o+nOpkhRPAZL
 x4iuI6zKdQlCqGFxRsW+I/TAeSJwRBR5Hzp5Jt/I/olc+/e/CF9aAxXYr+YP90Yo1FD/plrIZi2
 Qru9f5DPKMlEuaTUtMPRYMp8GqrdhrTlP4C98I2w=
X-Received: by 2002:a17:90b:2dc5:b0:32e:f1c:e778 with SMTP id
 98e67ed59e1d1-340279e5b49mr2328522a91.3.1761630547701; 
 Mon, 27 Oct 2025 22:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU5UMU2CSl16vMXPwcEvjIhSaCnvER1iqVBXwyJkmWPhrQXjwhhw50WJsDng/KdXUh5ovGng==
X-Received: by 2002:a17:90b:2dc5:b0:32e:f1c:e778 with SMTP id
 98e67ed59e1d1-340279e5b49mr2328488a91.3.1761630546935; 
 Mon, 27 Oct 2025 22:49:06 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33fed80df16sm10567413a91.15.2025.10.27.22.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 22:49:06 -0700 (PDT)
Message-ID: <45c63b0a-dc38-4ec0-9228-111a367eeacc@redhat.com>
Date: Tue, 28 Oct 2025 15:48:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V6 02/24] hw/core, qemu-options.hx: Introduce
 'disabledcpus' SMP parameter
To: salil.mehta@opnsrc.net, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, imammedo@redhat.com,
 armbru@redhat.com, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-3-salil.mehta@opnsrc.net>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251001010127.3092631-3-salil.mehta@opnsrc.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Salil,

On 10/1/25 11:01 AM, salil.mehta@opnsrc.net wrote:
> From: Salil Mehta <salil.mehta@huawei.com>
> 
> Add support for a new SMP configuration parameter, 'disabledcpus', which
> specifies the number of additional CPUs that are present in the virtual
> machine but administratively disabled at boot. These CPUs are visible in
> firmware (e.g. ACPI tables) yet unavailable to the guest until explicitly
> enabled via QMP/HMP, or via the 'device_set' API (introduced in later
> patches).
> 
> This feature is intended for architectures that lack native CPU hotplug
> support but can change the administrative power state of present CPUs.
> It allows simulating CPU hot-add–like scenarios while all CPUs remain
> physically present in the topology at boot time.
> 
> Note: ARM is the first architecture to support this concept.
> 
> Changes include:
>   - Extend CpuTopology with a 'disabledcpus' field.
>   - Update machine_parse_smp_config() to account for disabled CPUs when
>     computing 'cpus' and 'maxcpus'.
>   - Update SMPConfiguration in QAPI to accept 'disabledcpus'.
>   - Extend -smp option documentation to describe 'disabledcpus' usage and
>     behavior.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/core/machine-smp.c | 24 +++++++-----
>   include/hw/boards.h   |  2 +
>   qapi/machine.json     |  3 ++
>   qemu-options.hx       | 86 +++++++++++++++++++++++++++++++++----------
>   system/vl.c           |  3 ++
>   5 files changed, 89 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 0be0ac044c..c1a09fdc3f 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -87,6 +87,7 @@ void machine_parse_smp_config(MachineState *ms,
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>       unsigned cpus    = config->has_cpus ? config->cpus : 0;
> +    unsigned disabledcpus = config->has_disabledcpus ? config->disabledcpus : 0;
>       unsigned drawers = config->has_drawers ? config->drawers : 0;
>       unsigned books   = config->has_books ? config->books : 0;
>       unsigned sockets = config->has_sockets ? config->sockets : 0;
> @@ -166,8 +167,13 @@ void machine_parse_smp_config(MachineState *ms,
>           sockets = sockets > 0 ? sockets : 1;
>           cores = cores > 0 ? cores : 1;
>           threads = threads > 0 ? threads : 1;
> +
> +        maxcpus = drawers * books * sockets * dies * clusters *
> +                    modules * cores * threads;
> +        cpus = maxcpus - disabledcpus;
>       } else {
> -        maxcpus = maxcpus > 0 ? maxcpus : cpus;
> +        maxcpus = maxcpus > 0 ? maxcpus : cpus + disabledcpus;
> +        cpus = cpus > 0 ? cpus : maxcpus - disabledcpus;
>   
>           if (mc->smp_props.prefer_sockets) {
>               /* prefer sockets over cores before 6.2 */
> @@ -207,12 +213,8 @@ void machine_parse_smp_config(MachineState *ms,
>           }
>       }
>   
> -    total_cpus = drawers * books * sockets * dies *
> -                 clusters * modules * cores * threads;
> -    maxcpus = maxcpus > 0 ? maxcpus : total_cpus;
> -    cpus = cpus > 0 ? cpus : maxcpus;
> -
>       ms->smp.cpus = cpus;
> +    ms->smp.disabledcpus = disabledcpus;
>       ms->smp.drawers = drawers;
>       ms->smp.books = books;
>       ms->smp.sockets = sockets;
> @@ -226,6 +228,8 @@ void machine_parse_smp_config(MachineState *ms,
>       mc->smp_props.has_clusters = config->has_clusters;
>   
>       /* sanity-check of the computed topology */
> +    total_cpus = maxcpus = drawers * books * sockets * dies * clusters *
> +                modules * cores * threads;
>       if (total_cpus != maxcpus) {
>           g_autofree char *topo_msg = cpu_hierarchy_to_string(ms);
>           error_setg(errp, "Invalid CPU topology: "

It's enforced that total_cpus is equal to maxcpus. The followup check
"if (total_cpus != maxcpus)" becomes unnecessary. Also, does this makes
"-smp maxcpus=x" unnecessary?

Thanks,
Gavin

> @@ -235,12 +239,12 @@ void machine_parse_smp_config(MachineState *ms,
>           return;
>       }
>   
> -    if (maxcpus < cpus) {
> +    if (maxcpus < (cpus + disabledcpus)) {
>           g_autofree char *topo_msg = cpu_hierarchy_to_string(ms);
>           error_setg(errp, "Invalid CPU topology: "
> -                   "maxcpus must be equal to or greater than smp: "
> -                   "%s == maxcpus (%u) < smp_cpus (%u)",
> -                   topo_msg, maxcpus, cpus);
> +                   "maxcpus must be equal to or greater than smp[+disabledcpus]:"
> +                   "%s == maxcpus (%u) < smp_cpus (%u) [+ offline cpus (%u)]",
> +                   topo_msg, maxcpus, cpus, disabledcpus);
>           return;
>       }
>   
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index f94713e6e2..2b182d7817 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -361,6 +361,7 @@ typedef struct DeviceMemoryState {
>   /**
>    * CpuTopology:
>    * @cpus: the number of present logical processors on the machine
> + * @disabledcpus: the number additional present but admin disabled cpus
>    * @drawers: the number of drawers on the machine
>    * @books: the number of books in one drawer
>    * @sockets: the number of sockets in one book
> @@ -373,6 +374,7 @@ typedef struct DeviceMemoryState {
>    */
>   typedef struct CpuTopology {
>       unsigned int cpus;
> +    unsigned int disabledcpus;
>       unsigned int drawers;
>       unsigned int books;
>       unsigned int sockets;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 038eab281c..e45740da33 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1634,6 +1634,8 @@
>   #
>   # @cpus: number of virtual CPUs in the virtual machine
>   #
> +# @disabledcpus: number of additional present but disabled(or offline) CPUs
> +#
>   # @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
>   #     machine
>   #
> @@ -1657,6 +1659,7 @@
>   ##
>   { 'struct': 'SMPConfiguration', 'data': {
>        '*cpus': 'int',
> +     '*disabledcpus': 'int',
>        '*drawers': 'int',
>        '*books': 'int',
>        '*sockets': 'int',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ab23f14d21..83ccde341b 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -326,12 +326,15 @@ SRST
>   ERST
>   
>   DEF("smp", HAS_ARG, QEMU_OPTION_smp,
> -    "-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets]\n"
> -    "               [,dies=dies][,clusters=clusters][,modules=modules][,cores=cores]\n"
> -    "               [,threads=threads]\n"
> -    "                set the number of initial CPUs to 'n' [default=1]\n"
> -    "                maxcpus= maximum number of total CPUs, including\n"
> -    "                offline CPUs for hotplug, etc\n"
> +    "-smp [[cpus=]n][,disabledcpus=disabledcpus][,maxcpus=maxcpus][,drawers=drawers][,books=books]\n"
> +    "               [,sockets=sockets][,dies=dies][,clusters=clusters][,modules=modules]\n"
> +    "               [,cores=cores][,threads=threads]\n"
> +    "                set the initial number of CPUs present and\n"
> +    "                  administratively enabled at boot time to 'n' [default=1]\n"
> +    "                disabledcpus= number of present but administratively\n"
> +    "                  disabled CPUs (unavailable to the guest at boot)\n"
> +    "                maxcpus= maximum total CPUs (present + hotpluggable)\n"
> +    "                  on machines without CPU hotplug, defaults to n + disabledcpus\n"
>       "                drawers= number of drawers on the machine board\n"
>       "                books= number of books in one drawer\n"
>       "                sockets= number of sockets in one book\n"
> @@ -351,22 +354,49 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
>       "      For a particular machine type board, an expected CPU topology hierarchy\n"
>       "      can be defined through the supported sub-option. Unsupported parameters\n"
>       "      can also be provided in addition to the sub-option, but their values\n"
> -    "      must be set as 1 in the purpose of correct parsing.\n",
> +    "      must be set as 1 in the purpose of correct parsing.\n"
> +    "                                                          \n"
> +    "      Administratively disabled CPUs: Some machine types do not support vCPU\n"
> +    "      hotplug but their CPUs can be marked disabled (powered off) and kept\n"
> +    "      unavailable to the guest. Later, such CPUs can be enabled via QMP/HMP\n"
> +    "      (e.g., 'device_set ... admin-state=enable'). This is similar to hotplug,\n"
> +    "      except all disabled CPUs are already present at boot. Useful on\n"
> +    "      architectures that lack architectural CPU hotplug.\n",
>       QEMU_ARCH_ALL)
>   SRST
> -``-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets][,dies=dies][,clusters=clusters][,modules=modules][,cores=cores][,threads=threads]``
> -    Simulate a SMP system with '\ ``n``\ ' CPUs initially present on
> -    the machine type board. On boards supporting CPU hotplug, the optional
> -    '\ ``maxcpus``\ ' parameter can be set to enable further CPUs to be
> -    added at runtime. When both parameters are omitted, the maximum number
> +``-smp [[cpus=]n][,disabledcpus=disabledcpus][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets][,dies=dies][,clusters=clusters][,modules=modules][,cores=cores][,threads=threads]``
> +    Simulate a SMP system with '\ ``n``\ ' CPUs initially present & enabled on
> +    the machine type board. Furthermore, on architectures that support changing
> +    the administrative power state of CPUs, optional '\ ``disabledcpus``\ '
> +    parameter specifies *additional* CPUs that are present in firmware (e.g.,
> +    ACPI) but are administratively disabled (i.e., not usable by the guest at
> +    boot time).
> +
> +    This is different from CPU hotplug where additional CPUs are not even
> +    present in the system description. Administratively disabled CPUs appear in
> +    ACPI tables i.e. are provisioned, but cannot be used until explicitly
> +    enabled via QMP/HMP or the deviceset API.
> +
> +    On boards supporting CPU hotplug, the optional '\ ``maxcpus``\ ' parameter
> +    can be set to enable further CPUs to be added at runtime. When both
> +    '\ ``n``\ ' & '\ ``maxcpus``\ ' parameters are omitted, the maximum number
>       of CPUs will be calculated from the provided topology members and the
> -    initial CPU count will match the maximum number. When only one of them
> -    is given then the omitted one will be set to its counterpart's value.
> -    Both parameters may be specified, but the maximum number of CPUs must
> -    be equal to or greater than the initial CPU count. Product of the
> -    CPU topology hierarchy must be equal to the maximum number of CPUs.
> -    Both parameters are subject to an upper limit that is determined by
> -    the specific machine type chosen.
> +    initial CPU count will match the maximum number. When only one of them is
> +    given then the omitted one will be set to its counterpart's value. Both
> +    parameters may be specified, but the maximum number of CPUs must be equal
> +    to or greater than the initial CPU count. Product of the CPU topology
> +    hierarchy must be equal to the maximum number of CPUs. Both parameters are
> +    subject to an upper limit that is determined by the specific machine type
> +    chosen. Boards that support administratively disabled CPUs but do *not*
> +    support CPU hotplug derive the maximum number of CPUs implicitly:
> +    '\ ``maxcpus``\ ' is treated as '\ ``n + disabledcpus``\ ' (the total CPUs
> +    present in firmware). If '\ ``maxcpus``\ ' is provided, it must equal
> +    '\ ``n + disabledcpus``\ '. The topology product must equal this derived
> +    maximum as well.
> +
> +    Note: Administratively disabled CPUs will appear to the guest as
> +    unavailable, and any attempt to bring them online must go through QMP/HMP
> +    commands like 'device_set'.
>   
>       To control reporting of CPU topology information, values of the topology
>       parameters can be specified. Machines may only support a subset of the
> @@ -425,6 +455,24 @@ SRST
>   
>           -smp 2
>   
> +    Examples using 'disabledcpus':
> +
> +    For a board without CPU hotplug, enable 4 CPUs at boot and provision
> +    2 additional administratively disabled CPUs (maximum is derived
> +    implicitly as 6 = 4 + 2):
> +
> +    ::
> +
> +        -smp cpus=4,disabledcpus=2
> +
> +    For a board that supports CPU hotplug and 'disabledcpus', enable 4 CPUs
> +    at boot, provision 2 administratively disabled CPUs, and allow hotplug of
> +    2 more CPUs (for a maximum of 8):
> +
> +    ::
> +
> +        -smp cpus=4,disabledcpus=2,maxcpus=8
> +
>       Note: The cluster topology will only be generated in ACPI and exposed
>       to guest if it's explicitly specified in -smp.
>   ERST
> diff --git a/system/vl.c b/system/vl.c
> index 3b7057e6c6..2f0fd21a1f 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -736,6 +736,9 @@ static QemuOptsList qemu_smp_opts = {
>           {
>               .name = "cpus",
>               .type = QEMU_OPT_NUMBER,
> +        }, {
> +            .name = "disabledcpus",
> +            .type = QEMU_OPT_NUMBER,
>           }, {
>               .name = "drawers",
>               .type = QEMU_OPT_NUMBER,


