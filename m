Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EF41091914
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3WCy-0006d3-N7; Fri, 20 Mar 2026 05:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w3WCw-0006cl-3z; Fri, 20 Mar 2026 05:31:54 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w3WCs-0007Oz-Fn; Fri, 20 Mar 2026 05:31:53 -0400
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fcckw6nYHzHnH8T;
 Fri, 20 Mar 2026 17:31:20 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 2B7CF40584;
 Fri, 20 Mar 2026 17:31:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 09:31:45 +0000
Date: Fri, 20 Mar 2026 09:31:45 +0000
To: Gustavo Romero <gustavo.romero@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <alex.bennee@linaro.org>,
 <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH 5/7] hw/arm/virt: Add machine option 'mec'
Message-ID: <20260320093145.000020e1@huawei.com>
In-Reply-To: <c04a5077-e122-4784-91ad-259055c0f63b@linaro.org>
References: <20260319022335.22523-1-gustavo.romero@linaro.org>
 <20260319022335.22523-6-gustavo.romero@linaro.org>
 <20260319094642.00007696@huawei.com>
 <c04a5077-e122-4784-91ad-259055c0f63b@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
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

On Thu, 19 Mar 2026 14:27:57 -0300
Gustavo Romero <gustavo.romero@linaro.org> wrote:

> Hi Jonathan,
> 
> On 3/19/26 06:46, Jonathan Cameron wrote:
> > On Wed, 18 Mar 2026 23:23:33 -0300
> > Gustavo Romero <gustavo.romero@linaro.org> wrote:
> >   
> >> Add new machine option 'mec' that enables and sets the memory used by
> >> FEAT_MEC.
> >>
> >> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>  
> > 
> > Drive by comments only. I'm curious enough to read the patches
> > but no idea if this is how people would like to see this implemented!  
> 
> Thanks for taking a look at it and for you comments.
> 
> In which sense do you mean exactly? Do mind to elaborate a bit more on 
> it? If it's about the whole implementation, would it be about not
> really encrypting data or something else? Please help me to understand it :)
> 
> I'm not sure if you're talking about just this patch or the whole 
> FEAT_MEC design.

I was failing to express that this is fine for me but out of my area of expertise
wrt to QEMU so would leave the questions of 'is this the best way to do it?'
for others!

> 
> 
> Cheers,
> Gustavo
> 
> > Jonathan
> >   
> >>   static void create_secure_ram(VirtMachineState *vms,
> >>                                 MemoryRegion *secure_sysmem,
> >>                                 MemoryRegion *secure_tag_sysmem)
> >> @@ -2267,6 +2288,8 @@ static void machvirt_init(MachineState *machine)
> >>       MemoryRegion *secure_sysmem = NULL;
> >>       MemoryRegion *tag_sysmem = NULL;
> >>       MemoryRegion *secure_tag_sysmem = NULL;
> >> +    MemoryRegion *pseudo_encrypted_page = NULL;
> >> +    MemoryRegion *tuple_memory = NULL;
> >>       int n, virt_max_cpus;
> >>       bool firmware_loaded;
> >>       bool aarch64 = true;
> >> @@ -2495,6 +2518,28 @@ static void machvirt_init(MachineState *machine)
> >>               }
> >>           }
> >>   
> >> +        if (vms->mec) {
> >> +            if (tcg_enabled()) {
> >> +                if (tuple_memory == NULL) {
> >> +                    /* XXX(gromero): Add object_property_find(cpuobj, "tuple-memory", ...) here. */
> >> +
> >> +                    tuple_memory = g_new(MemoryRegion, 1);
> >> +                    memory_region_init(tuple_memory, OBJECT(machine), "mec", UINT64_MAX / 32);
> >> +
> >> +                    pseudo_encrypted_page = g_new(MemoryRegion, 1);
> >> +                    memory_region_init(pseudo_encrypted_page, OBJECT(machine), "mec-page", 4 * 1024 /* 4 KiB */);
> >> +                }
> >> +
> >> +                object_property_set_link(cpuobj, "mec",  OBJECT(tuple_memory), &error_abort);
> >> +                object_property_set_link(cpuobj, "mec-page",  OBJECT(pseudo_encrypted_page), &error_abort);  
> > Trivial but some bonus spaces.
> >   
> >> +
> >> +                } else {  
> > 
> > Indent seems off.
> >   
> >> +                    /* Check for other accels here. */
> >> +                    error_report("MEC requested, but not supported");
> >> +                    exit(1);
> >> +                }
> >> +        }
> >> +
> >>           qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> >>           object_unref(cpuobj);
> >>       }  
> > 
> >   
> 
> 


