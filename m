Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3555ED44D70
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gWf-0006bf-Vn; Wed, 06 Nov 2024 08:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8gWe-0006bI-DV
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:56:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8gWa-0000Gx-S4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730901401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8m+H83mf8SO8gTgYs8kfBy5ooll6r809LA9G0GWmY8A=;
 b=Gtf8QxKsWM6rtDLjrAjL1uLlnnp17pVRgeeLSY1Ub07y4fLCPJYSeC331JIYvjtZjlSokb
 kdWiqRwQMYcb0BHUSKzOcUMpzXkxxW+0VRbkhdKoo5awiI07herhh/PL73hlFSo2gDMMWK
 r50ARfQUULo18Js/kg8upITdcv6Epgs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-wxNqYKmBMqGaXEJOGdXV2Q-1; Wed, 06 Nov 2024 08:56:40 -0500
X-MC-Unique: wxNqYKmBMqGaXEJOGdXV2Q-1
X-Mimecast-MFC-AGG-ID: wxNqYKmBMqGaXEJOGdXV2Q
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso57377855e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 05:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730901399; x=1731506199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8m+H83mf8SO8gTgYs8kfBy5ooll6r809LA9G0GWmY8A=;
 b=JvNwfY1C/+GpP8RR3DJsvHlIBcICJY3bttB+iLneHXQJbtp02GeQJST18+TQJOOiCw
 pcXakaecuM06R8P3KcHaEfOOXwBgMwsf4Y4olbWyjp7BbF8ZtYwf8JBRoUwMPwro2Ind
 popPCAOLuh/GKuelyKyvE3sjnPFn0plEUtQ4ydkb0Vme94GQZLYLBrvjQ1LmQMyR1mFu
 jL4GkQVjTOc2Z+28Be7clszyHkWPjcf+NSZtzCn/ntG2u2R4EgYS7zJb0d22WZyerGpe
 jzxgZDWKV3WLPXZLL3WvA9/n9WOXMfZueasa1O5/tKSIs1cGfg2Njt8xiamjlqt9TGKR
 /W8A==
X-Gm-Message-State: AOJu0Yzqu8ww4/WE5bc0C7ghhEj/qZ+gILsP8f/eizLOyRCx1PRTPvwQ
 hpN+lXApV5U+wBL+wYWb875GlnQ+Qxe4E1BbWYHC8XiGUcXRplqw/w4U1MP9u6gkAFhWk+ztubF
 yaPfqCiDlgs65WLazIDRZRi8IwMuGTK6QCZ6xf1NMr8U7qw8CEvcx
X-Received: by 2002:a05:600c:35cc:b0:42c:bae0:f05f with SMTP id
 5b1f17b1804b1-4328324b30dmr214392985e9.13.1730901399520; 
 Wed, 06 Nov 2024 05:56:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDLYlCzB4fO+tL1y6t7ads5Y1Wd8DlolxSjzr6YkUIx5+ewN3P6QVE4CzcAkO9YHvGEg2SaA==
X-Received: by 2002:a05:600c:35cc:b0:42c:bae0:f05f with SMTP id
 5b1f17b1804b1-4328324b30dmr214392565e9.13.1730901399181; 
 Wed, 06 Nov 2024 05:56:39 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b61c5sm23213075e9.13.2024.11.06.05.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:56:38 -0800 (PST)
Date: Wed, 6 Nov 2024 14:56:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <jonathan.cameron@huawei.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <anisinha@redhat.com>,
 <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <david@redhat.com>,
 <philmd@linaro.org>, <peterx@redhat.com>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <zhao1.liu@intel.com>, <linuxarm@huawei.com>, <gustavo.romero@linaro.org>
Subject: Re: [PATCH 2/3] Fix: Reverse CPUs presence check logic for x86
 backward compatability
Message-ID: <20241106145635.77332d7c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241106130331.205020-3-salil.mehta@huawei.com>
References: <20241106130331.205020-1-salil.mehta@huawei.com>
 <20241106130331.205020-3-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 6 Nov 2024 13:03:30 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Checking `is_present` first can break x86 migration from new Qemu
> version to old Qemu. This is because CPRS Bit is not defined in the
> older Qemu register block and will always be 0 resulting in check always
> failing. Reversing the logic to first check `is_enabled` can alleviate
> below problem:
> 
> -                If ((\_SB.PCI0.PRES.CPEN == One))
> -                {
> -                    Local0 = 0x0F
> +                If ((\_SB.PCI0.PRES.CPRS == One))
> +                {
> +                    If ((\_SB.PCI0.PRES.CPEN == One))
> +                    {
> +                        Local0 = 0x0F
> +                    }
> +                    Else
> +                    {
> +                        Local0 = 0x0D
> +                    }
>                  }
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
'Reported-by' maybe, but certainly not suggested.

After more thinking and given presence is system wide that doesn't change
at runtime, I don't see any reason for introducing presence bit as ABI
(and undocumented on top of that).

Instead changing AML code to account for it would be better,
something like this:

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 32654dc274..4a3e591120 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -55,6 +55,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
 typedef struct CPUHotplugFeatures {
     bool acpi_1_compatible;
     bool has_legacy_cphp;
+    bool always_present_cpus;
     bool fw_unplugs_cpu;
     const char *smi_path;
 } CPUHotplugFeatures;
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5cb60ca8bc..2bcce2b31c 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -452,15 +452,16 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
 
         method = aml_method(CPU_STS_METHOD, 1, AML_SERIALIZED);
         {
+            uint8_t default_sta = opts.always_present_cpus?0xd:0;
             Aml *idx = aml_arg(0);
-            Aml *sta = aml_local(0);
+            Aml *sta = aml_local(default_sta);
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
             aml_append(method, aml_store(idx, cpu_selector));
             aml_append(method, aml_store(zero, sta));
             ifctx = aml_if(aml_equal(is_enabled, one));
             {
-                aml_append(ifctx, aml_store(aml_int(0xF), sta));
+                aml_append(ifctx, aml_or(aml_int(0xF), sta, sta));
             }
             aml_append(method, ifctx);
             aml_append(method, aml_release(ctrl_lock))

then for ARM set
 CPUHotplugFeatures::always_present_cpus = true
to get present flag always enabled

After that revert _all_ other presence bit related changes
that were just merged.
(I did ask to get rid of that in previous reviews but it
came back again for no good reason).

> Message-ID: <20241106100047.18901c9d@imammedo.users.ipa.redhat.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  hw/acpi/cpu.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 23443f09a5..b2f7a2b27e 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -490,22 +490,22 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>              aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
>              aml_append(method, aml_store(idx, cpu_selector));
>              aml_append(method, aml_store(zero, sta));
> -            ifctx = aml_if(aml_equal(is_present, one));
> +            ifctx = aml_if(aml_equal(is_enabled, one));
>              {
> -                ifctx2 = aml_if(aml_equal(is_enabled, one));
> -                {
> -                    /* cpu is present and enabled */
> -                    aml_append(ifctx2, aml_store(aml_int(0xF), sta));
> -                }
> -                aml_append(ifctx, ifctx2);
> -                else_ctx = aml_else();
> +                /* cpu is present and enabled */
> +                aml_append(ifctx, aml_store(aml_int(0xF), sta));
> +            }
> +            aml_append(method, ifctx);
> +            else_ctx = aml_else();
> +            {
> +                ifctx2 = aml_if(aml_equal(is_present, one));
>                  {
>                      /* cpu is present but disabled */
> -                    aml_append(else_ctx, aml_store(aml_int(0xD), sta));
> +                    aml_append(ifctx2, aml_store(aml_int(0xD), sta));
>                  }
> -                aml_append(ifctx, else_ctx);
> +                aml_append(else_ctx, ifctx2);
>              }
> -            aml_append(method, ifctx);
> +            aml_append(method, else_ctx);
>              aml_append(method, aml_release(ctrl_lock));
>              aml_append(method, aml_return(sta));
>          }


