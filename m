Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B919CC5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPF7-0003qB-LI; Tue, 05 Mar 2024 02:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhPEn-0003lD-4P
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:29:24 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhPEj-0004RO-34
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709623758; x=1741159758;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hHWJ4wliT2zqlRJCUZ4iaQ7U9nvHb62eTPrAtUOqRB0=;
 b=VF5oz4R6ek4z5WFljbbLqODkCPdSz7zY7H7/V+yooEBNTouSOkKIc/2l
 nePc/wsrEypoI9sO4s99Sc7CBQCOYIzFqXAopX4dDqPcWHJbc2g0Umf46
 1X/q4ckpCTejJQAvu5I9qA0zON409KosiMBNa+JgUE9h833baFVcxOFW7
 qjCNMDxgZ532ABly3a6VmgO8qxb4TKQqQpES/yQmwj1FjZ2uHUoB6r7u3
 FKrWimeOCthE0FnMT6faInYxVKA4aHh6VGOnDfBGcQKk3ZgfNzMshaGVB
 Xx3E+2a8c/7Sm0mYOWrYIFakgr7im+pNMhf34n4Xwrutao0kp3HpCYEhf A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4317140"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4317140"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 23:29:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; d="scan'208";a="40160157"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 04 Mar 2024 23:29:10 -0800
Date: Tue, 5 Mar 2024 15:42:55 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] hw/core/machine-smp: Remove deprecated "parameter=0" SMP
 configurations
Message-ID: <ZebM/2for1NVjeuc@intel.com>
References: <20240304044510.2305849-1-zhao1.liu@linux.intel.com>
 <CAE8KmOxvZFjtKkHiGGREx_b0QgfDjPWZ7Ex3nqAQQbiPKa_wrQ@mail.gmail.com>
 <ZeVyKMux7Ysjo/lY@intel.com>
 <CAE8KmOxJECe7oNkB1Oiuk-+_4J4drmdJTL2mBzQz+Zu+6XpxrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOxJECe7oNkB1Oiuk-+_4J4drmdJTL2mBzQz+Zu+6XpxrQ@mail.gmail.com>
Received-SPF: none client-ip=198.175.65.17;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Prasad,

> On Mon, 4 Mar 2024 at 12:19, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> > > unsigned maxcpus = config->has_maxcpus ? config->maxcpus : 0;
> >
> > This indicates the default maxcpus is initialized as 0 if user doesn't
> > specifies it.
> 
> * 'has_maxcpus' should be set only if maxcpus > 0. If maxcpus == 0,
> then setting 'has_maxcpus=1' seems convoluted.

After simple test, if user sets maxcpus as 0, the has_maxcpus will be
true as well...I think it's related with QAPI code generation logic.

> > However, we could initialize maxcpus as other default value, e.g.,
> >
> >     maxcpus = config->has_maxcpus ? config->maxcpus : 1.
> ===
> hw/core/machine.c
>  machine_initfn
>     /* default to mc->default_cpus */
>     ms->smp.cpus = mc->default_cpus;
>     ms->smp.max_cpus = mc->default_cpus;
> 
>    static void machine_class_base_init(ObjectClass *oc, void *data)
>    {
>        MachineClass *mc = MACHINE_CLASS(oc);
>        mc->max_cpus = mc->max_cpus ?: 1;
>        mc->min_cpus = mc->min_cpus ?: 1;
>        mc->default_cpus = mc->default_cpus ?: 1;
>    }
> ===
> * Looking at the above bits, it seems smp.cpus & smp.max_cpus are
> initialised to 1 via default_cpus in MachineClass object.

Yes.

The maxcpus I mentioned is a local virable in
machine_parse_smp_config(), whihc is used to do sanity-check check.

In machine_parse_smp_config(), when we can confirm the topology is
valid, then ms->smp.cpus and ms->smp.max_cpus are set with the valid
virables (cpus and maxcpus).

> >>  if (config->has_maxcpus && config->maxcpus == 0)
> > This check only wants to identify the case that user sets the 0.
> > If the default maxcpus is initialized as 0, then (maxcpus == 0) will
> > fail if user doesn't set maxcpus.
> >
> > But it is still necessary to distinguish whether maxcpus is user-set or
> > auto-initialized.
> 
> * If it is set to zero(0) either by user or by auto-initialise, it is
> still invalid, right?

The latter, "auto-initialise", means user could omit "cpus" and "maxcpus"
parameters in -smp.

Even though the local variable "cpus" and "maxcpus" are initialized as
0, eventually ms->smp.cpus and ms->smp.max_cpus will still have the
valid values.

> > If it is user-set, -smp should fail is there's invalid maxcpus/invalid
> > topology.
> >
> > Otherwise, if it is auto-initialized, its value should be adjusted based
> > on other topology components as the above calculation in (*).
> 
> * Why have such diverging ways?
> * Could we simplify it as
>    - If cpus/maxcpus==0, it is invalid, show an error and exit.

Hmm, the origial behavior means if user doesn't set cpus=*/maxcpus=* in
-smp, then QEMU will auto-complete these 2 fields.

If we also return error for the above case that user omits cpus and
maxcpus parameters, then this change the QEMU's API and we need to mark
feature that the cpus/maxcpus parameter can be omitted as deprecated and
remove it out. Just like what I did in this patch for zeroed-parameter
case.

I feel if there's no issue then it's not necessary to change the API. Do
you agree?

>    - If cpus/maxcpus > 0, but incorrect for topology, then
> re-calculate the correct value based on topology parameters. If the
> re-calculated value is still incorrect or unsatisfactory, then show an
> error and exit.

Yes, this case is right.

> * Saying that user setting cpu/maxcpus=0 is invalid and
> auto-initialising it to zero(0) is valid, is not consistent.
>

I think "auto-initialising it to zero(0)" doesn't means we re-initialize
ms->smp.cpus and ms->smp.max_cpus as 0 (these 2 fields store actual basic
topology information and they're defult as 1 as you said above).

Does my explaination address your concern? ;-)

Thanks,
Zhao


