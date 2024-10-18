Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF9CD30013
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1nuN-0002DK-15; Fri, 18 Oct 2024 10:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t1nuL-0002D4-Sl
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t1nuI-0000FW-NG
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729261485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIB7KuZSSWkTQLub4v9O07wAXHZMt+FjPvQsi1A2fIk=;
 b=iKgq15cpLukmk9kJ56QAHzQjniOG0VvLvopWNSbU1RAWeeRCwKCEgtOR31R2a1myhwl1qc
 Rv65BHvEVpekMfCQ6OT5UJH1vrPxvuISx3Bj9dlBvYQlhpx6JYaRNXpVggedm0kVp/6GK5
 tz5AVV7OGW8Y923NbxqnzAoY8c7nWL0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-XDBEcMx9PHK028qe06VkKg-1; Fri, 18 Oct 2024 10:24:43 -0400
X-MC-Unique: XDBEcMx9PHK028qe06VkKg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316655b2f1so1208195e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729261481; x=1729866281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIB7KuZSSWkTQLub4v9O07wAXHZMt+FjPvQsi1A2fIk=;
 b=JEd4Plj+PxJsZjK3nun/KY9ylsIXj8UpyfyctAs5JUhA27DShFOlW/50NNujiQecZ7
 tAsyO6GryR2d+egFL/6SnICS3vJjgLaxLsDrjBQ7p2aB6uJMEY1eoCi+zCZKUoN0ROhY
 YcDurwHGUlJzoBFdLHEdMtcf5LLYFCgTTql/GZhConkeRPsJ9ReGdbWseyE4/PHjeQLF
 FF6PK+uTu8qHvaAR46DUpvVgGRVnjK655HMh8w9nGnvHGyFeoWWetbnrX9znPt4Mj+Mn
 DrcNHRchH3A1q8P5Fo4kCrOfQ5KCidJJnGT4QPSVBP8Lq8XyEk5lEo2GvNkDF5NEZQbr
 bS1w==
X-Gm-Message-State: AOJu0YwE7MnP9jmZrHkDBQOkzpzP+5CUYUzPFEVcPGyq1fedrmYRchor
 2hWg4k5PNi13lbr361M7Bumw3/PkB3tSz/qbcMRWeDJ2KIAoz3lNjP/h14R+8zNCQtjP2dlltmo
 r4Hbr4++z5Y+lLVsiyfAHNFH/cln1U7Fnmtb2jZ8kBOez3K4AqFoU
X-Received: by 2002:a05:600c:1554:b0:431:58b3:affa with SMTP id
 5b1f17b1804b1-43161642df5mr23413055e9.9.1729261481491; 
 Fri, 18 Oct 2024 07:24:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHatJEZ1DuxNt3TGASv/x5ksA2Noqvw5kQwO5mJykV3tQZPcxX8pGE8OJ173JdkCuhvdl7Zkw==
X-Received: by 2002:a05:600c:1554:b0:431:58b3:affa with SMTP id
 5b1f17b1804b1-43161642df5mr23412765e9.9.1729261480988; 
 Fri, 18 Oct 2024 07:24:40 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316067de15sm28867275e9.5.2024.10.18.07.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:24:40 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:24:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <andrew.jones@linux.dev>, <david@redhat.com>, <philmd@linaro.org>,
 <eric.auger@redhat.com>, <will@kernel.org>, <ardb@kernel.org>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <gshan@redhat.com>,
 <rafael@kernel.org>, <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>,
 <npiggin@gmail.com>, <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <shahuang@redhat.com>, <zhao1.liu@intel.com>,
 <linuxarm@huawei.com>, <gustavo.romero@linaro.org>
Subject: Re: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
 states in ACPI _STA.{PRES,ENA} Bits
Message-ID: <20241018162437.782c12c1@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241014192205.253479-4-salil.mehta@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-4-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 14 Oct 2024 20:22:04 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> Reflect the ACPI CPU hotplug `is_{present, enabled}` states in the `_STA.PRES`
> (presence) and `_STA.ENA` (enabled) bits when the guest kernel evaluates the
> ACPI `_STA` method during initialization, as well as when vCPUs are hot-plugged
> or hot-unplugged. The presence of unplugged vCPUs may need to be deliberately
> *simulated* at the ACPI level to maintain a *persistent* view of vCPUs for the
> guest kernel.

given questionable future of is_present/is_enabled fields,
it probably premature to review this part.
The only thing, I have to say here is repeating spec/doc
update patch describing how it should work should come 1st,
so that we could compare this impl. with it. 

> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  hw/acpi/cpu.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 700aa855e9..23ea2b9c70 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -63,10 +63,11 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
>      cdev = &cpu_st->devs[cpu_st->selector];
>      switch (addr) {
>      case ACPI_CPU_FLAGS_OFFSET_RW: /* pack and return is_* fields */
> -        val |= cdev->cpu ? 1 : 0;
> +        val |= cdev->is_enabled ? 1 : 0;
>          val |= cdev->is_inserting ? 2 : 0;
>          val |= cdev->is_removing  ? 4 : 0;
>          val |= cdev->fw_remove  ? 16 : 0;
> +        val |= cdev->is_present ? 32 : 0;
>          trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
>          break;
>      case ACPI_CPU_CMD_DATA_OFFSET_RW:
> @@ -376,6 +377,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
>  #define CPU_REMOVE_EVENT  "CRMV"
>  #define CPU_EJECT_EVENT   "CEJ0"
>  #define CPU_FW_EJECT_EVENT "CEJF"
> +#define CPU_PRESENT       "CPRS"
>  
>  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>                      build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
> @@ -436,7 +438,9 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
>          /* tell firmware to do device eject, write only */
>          aml_append(field, aml_named_field(CPU_FW_EJECT_EVENT, 1));
> -        aml_append(field, aml_reserved_field(3));
> +        /* 1 if present, read only */
> +        aml_append(field, aml_named_field(CPU_PRESENT, 1));
> +        aml_append(field, aml_reserved_field(2));
>          aml_append(field, aml_named_field(CPU_COMMAND, 8));
>          aml_append(cpu_ctrl_dev, field);
>  
> @@ -466,6 +470,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          Aml *ctrl_lock = aml_name("%s.%s", cphp_res_path, CPU_LOCK);
>          Aml *cpu_selector = aml_name("%s.%s", cphp_res_path, CPU_SELECTOR);
>          Aml *is_enabled = aml_name("%s.%s", cphp_res_path, CPU_ENABLED);
> +        Aml *is_present = aml_name("%s.%s", cphp_res_path, CPU_PRESENT);
>          Aml *cpu_cmd = aml_name("%s.%s", cphp_res_path, CPU_COMMAND);
>          Aml *cpu_data = aml_name("%s.%s", cphp_res_path, CPU_DATA);
>          Aml *ins_evt = aml_name("%s.%s", cphp_res_path, CPU_INSERT_EVENT);
> @@ -494,13 +499,26 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          {
>              Aml *idx = aml_arg(0);
>              Aml *sta = aml_local(0);
> +            Aml *ifctx2;
> +            Aml *else_ctx;
>  
>              aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
>              aml_append(method, aml_store(idx, cpu_selector));
>              aml_append(method, aml_store(zero, sta));
> -            ifctx = aml_if(aml_equal(is_enabled, one));
> +            ifctx = aml_if(aml_equal(is_present, one));
>              {
> -                aml_append(ifctx, aml_store(aml_int(0xF), sta));
> +                ifctx2 = aml_if(aml_equal(is_enabled, one));
> +                {
> +                    /* cpu is present and enabled */
> +                    aml_append(ifctx2, aml_store(aml_int(0xF), sta));
> +                }
> +                aml_append(ifctx, ifctx2);
> +                else_ctx = aml_else();
> +                {
> +                    /* cpu is present but disabled */
> +                    aml_append(else_ctx, aml_store(aml_int(0xD), sta));
> +                }
> +                aml_append(ifctx, else_ctx);
>              }
>              aml_append(method, ifctx);
>              aml_append(method, aml_release(ctrl_lock));


