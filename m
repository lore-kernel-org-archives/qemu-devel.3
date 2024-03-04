Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31600C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh28g-0004JK-HJ; Mon, 04 Mar 2024 01:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rh28e-0004J4-78
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:49:28 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rh28c-0002r5-7X
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709534966; x=1741070966;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=75CHMmQhLeFZPFWEPdNVZdPFWdf6Dz7XDvl1C1fFSeA=;
 b=oBplC6QBWP4j4ooyE63Rk3qPTxyZ0pQlBGdu/z1tOSF8YNC+5eqNHYeu
 IE+fN2IxEbPXZtveT0dVQk+KweDRavd+CAoFXuTCMnDTnmZdujucLSQt0
 Vbg2rDrx9JpOSrywTz5Om6KYhOYoNLdUY6hWLJF2czriZkhXPdNO9bFjG
 utGDItaqy9UeFCnTJnaCfhEbTzihPi30VS9jsv5dDSW+kZHrkquV80UA5
 L5RyseGhONwH7bAhxKy2BSMjwRGndgCb65XW1nlMzKg8wHbNpVW2QawYJ
 t4z/0uRIXE1gg5ocpWlS2gS0PsTAE1ksQGbrWEr65qmD6eZpzTiVveSpD A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="21548653"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; d="scan'208";a="21548653"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2024 22:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8960710"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 03 Mar 2024 22:49:19 -0800
Date: Mon, 4 Mar 2024 15:03:04 +0800
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
Message-ID: <ZeVyKMux7Ysjo/lY@intel.com>
References: <20240304044510.2305849-1-zhao1.liu@linux.intel.com>
 <CAE8KmOxvZFjtKkHiGGREx_b0QgfDjPWZ7Ex3nqAQQbiPKa_wrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOxvZFjtKkHiGGREx_b0QgfDjPWZ7Ex3nqAQQbiPKa_wrQ@mail.gmail.com>
Received-SPF: none client-ip=192.198.163.8;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
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

On Mon, Mar 04, 2024 at 11:23:58AM +0530, Prasad Pandit wrote:
> Date: Mon, 4 Mar 2024 11:23:58 +0530
> From: Prasad Pandit <ppandit@redhat.com>
> Subject: Re: [PATCH] hw/core/machine-smp: Remove deprecated "parameter=0"
>  SMP configurations
> 
> On Mon, 4 Mar 2024 at 10:02, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> > diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> > index 25019c91ee36..96533886b14e 100644
> > --- a/hw/core/machine-smp.c
> > +++ b/hw/core/machine-smp.c
> > @@ -105,8 +105,9 @@ void machine_parse_smp_config(MachineState *ms,
> >          (config->has_cores && config->cores == 0) ||
> >          (config->has_threads && config->threads == 0) ||
> >          (config->has_maxcpus && config->maxcpus == 0)) {
> > -        warn_report("Deprecated CPU topology (considered invalid): "
> > -                    "CPU topology parameters must be greater than zero");
> > +        error_setg(errp, "Invalid CPU topology: "
> > +                   "CPU topology parameters must be greater than zero");
> > +        return;
> >      }
> 
> unsigned maxcpus = config->has_maxcpus ? config->maxcpus : 0;

This indicates the default maxcpus is initialized as 0 if user doesn't
specifies it.

For this case - no user configuration - maxcpus will be re-calculated
as:

    maxcpus = maxcpus > 0 ? maxcpus : drawers * books * sockets * dies *
                                      clusters * cores * threads; (*)

>  ...
>  if (config->has_maxcpus && config->maxcpus == 0)

This check only wants to identify the case that user sets the 0.

> 
> * The check (has_maxcpus && maxcpus == 0) seems to be repeating above,
> maybe we could check if (maxcpus == 0) error_setg().

If the default maxcpus is initialized as 0, then (maxcpus == 0) will
fail if user doesn't set maxcpus.

However, we could initialize maxcpus as other default value, e.g., 

    maxcpus = config->has_maxcpus ? config->maxcpus : 1.

But it is still necessary to distinguish whether maxcpus is user-set or
auto-initialized.

If it is user-set, -smp should fail is there's invalid maxcpus/invalid
topology.

Otherwise, if it is auto-initialized, its value should be adjusted based
on other topology components as the above calculation in (*).

> And same for
> other topology parameters?

Other parameters also have the similar needs to distinguish if they're
set by user. So the check needs to also cover has_* fields.

> * Also a check to ensure cpus <= maxcpus is required I think.
>

Yes, the valid topology needs this. This code block already covers this
case ;-):

    if (maxcpus < cpus) {
        g_autofree char *topo_msg = cpu_hierarchy_to_string(ms);
        error_setg(errp, "Invalid CPU topology: "
                   "maxcpus must be equal to or greater than smp: "
                   "%s == maxcpus (%u) < smp_cpus (%u)",
                   topo_msg, maxcpus, cpus);
        return;
    }

Thanks,
Zhao



