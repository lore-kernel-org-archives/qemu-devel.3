Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7867C1075286
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w39y3-0003VK-EZ; Thu, 19 Mar 2026 05:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w39xz-0003Um-R6; Thu, 19 Mar 2026 05:47:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w39xx-0000K2-3u; Thu, 19 Mar 2026 05:46:59 -0400
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fc16j2KqzzHnHBQ;
 Thu, 19 Mar 2026 17:46:21 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 8CDAB40573;
 Thu, 19 Mar 2026 17:46:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Mar
 2026 09:46:43 +0000
Date: Thu, 19 Mar 2026 09:46:42 +0000
To: Gustavo Romero <gustavo.romero@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <alex.bennee@linaro.org>,
 <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH 5/7] hw/arm/virt: Add machine option 'mec'
Message-ID: <20260319094642.00007696@huawei.com>
In-Reply-To: <20260319022335.22523-6-gustavo.romero@linaro.org>
References: <20260319022335.22523-1-gustavo.romero@linaro.org>
 <20260319022335.22523-6-gustavo.romero@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 18 Mar 2026 23:23:33 -0300
Gustavo Romero <gustavo.romero@linaro.org> wrote:

> Add new machine option 'mec' that enables and sets the memory used by
> FEAT_MEC.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Drive by comments only. I'm curious enough to read the patches
but no idea if this is how people would like to see this implemented!

Jonathan

>  static void create_secure_ram(VirtMachineState *vms,
>                                MemoryRegion *secure_sysmem,
>                                MemoryRegion *secure_tag_sysmem)
> @@ -2267,6 +2288,8 @@ static void machvirt_init(MachineState *machine)
>      MemoryRegion *secure_sysmem = NULL;
>      MemoryRegion *tag_sysmem = NULL;
>      MemoryRegion *secure_tag_sysmem = NULL;
> +    MemoryRegion *pseudo_encrypted_page = NULL;
> +    MemoryRegion *tuple_memory = NULL;
>      int n, virt_max_cpus;
>      bool firmware_loaded;
>      bool aarch64 = true;
> @@ -2495,6 +2518,28 @@ static void machvirt_init(MachineState *machine)
>              }
>          }
>  
> +        if (vms->mec) {
> +            if (tcg_enabled()) {
> +                if (tuple_memory == NULL) {
> +                    /* XXX(gromero): Add object_property_find(cpuobj, "tuple-memory", ...) here. */
> +
> +                    tuple_memory = g_new(MemoryRegion, 1);
> +                    memory_region_init(tuple_memory, OBJECT(machine), "mec", UINT64_MAX / 32);
> +
> +                    pseudo_encrypted_page = g_new(MemoryRegion, 1);
> +                    memory_region_init(pseudo_encrypted_page, OBJECT(machine), "mec-page", 4 * 1024 /* 4 KiB */);
> +                }
> +
> +                object_property_set_link(cpuobj, "mec",  OBJECT(tuple_memory), &error_abort);
> +                object_property_set_link(cpuobj, "mec-page",  OBJECT(pseudo_encrypted_page), &error_abort);
Trivial but some bonus spaces.

> +
> +                } else {

Indent seems off. 

> +                    /* Check for other accels here. */
> +                    error_report("MEC requested, but not supported");
> +                    exit(1);
> +                }
> +        }
> +
>          qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>          object_unref(cpuobj);
>      }



