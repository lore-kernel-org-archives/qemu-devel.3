Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280B4C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCg6J-0003d0-9M; Thu, 30 May 2024 09:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCg6I-0003cO-Bo; Thu, 30 May 2024 09:45:50 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCg6F-0005VC-JL; Thu, 30 May 2024 09:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717076747; x=1748612747;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HYmRgL95rnL5I4sazCVOH+MQqPURl3cWjMGPjI8wfrE=;
 b=Z7j5xySIs4dhixW8yET646fvKF1eaOX6RaFCwZvoE7pDQ69FuJGowNzI
 tGFswybVJcRjpyM+b5xKIoi0mnsxpuvZX8VOaCDwyns6hJA03SQ78hoau
 13u/u/oWHefkIukzENS4OSX6YLYoXt4qxyUo01w0L2t476xe7iwEfI71X
 XMRdohb5TR3azC+UJypyLD++3NiPy1qa8b9q+GoU84p4s0YTWPPadVevB
 6WIN5ENmCjs3AkXFtydOmOFUNrdL8V9RPhxXmC6gBNMgW/mPmYW/7heVH
 H7N4Qf8IlHgRJwmI9PlOEoTtTfLHW9zND/Xc9cVJSSs9si/oyEWZcaRMk w==;
X-CSE-ConnectionGUID: qO58X6GGT/yeecwt7a9Z/g==
X-CSE-MsgGUID: qq05+HQ6SaKXwTCQKWAang==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24172645"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="24172645"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 06:45:42 -0700
X-CSE-ConnectionGUID: De7S8QHlR6ukqok0PVx89A==
X-CSE-MsgGUID: rUrmNaspSzG9SS4tC+adLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="35762246"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 30 May 2024 06:45:41 -0700
Date: Thu, 30 May 2024 22:01:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mst@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, qemu-trivial@nongnu.org
Subject: Re: [PATCH V2 1/3] vl: Allow multiple -overcommit commands
Message-ID: <ZliGoM9Hy3Q2qthQ@intel.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240524200017.150339-2-zide.chen@intel.com>
 <e86c1913-a1ff-4c31-9915-d66c269b7e10@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e86c1913-a1ff-4c31-9915-d66c269b7e10@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27, 2024 at 07:19:56AM +0200, Thomas Huth wrote:
> Date: Mon, 27 May 2024 07:19:56 +0200
> From: Thomas Huth <thuth@redhat.com>
> Subject: Re: [PATCH V2 1/3] vl: Allow multiple -overcommit commands
> 
> On 24/05/2024 22.00, Zide Chen wrote:
> > Both cpu-pm and mem-lock are related to system resource overcommit, but
> > they are separate from each other, in terms of how they are realized,
> > and of course, they are applied to different system resources.
> > 
> > It's tempting to use separate command lines to specify their behavior.
> > e.g., in the following example, the cpu-pm command is quietly
> > overwritten, and it's not easy to notice it without careful inspection.
> > 
> >    --overcommit mem-lock=on
> >    --overcommit cpu-pm=on
> > 
> > Fixes: c8c9dc42b7ca ("Remove the deprecated -realtime option")
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Zide Chen <zide.chen@intel.com>
> > ---
> > 
> > v2:
> > 
> > Thanks to Thomas' suggestion, changed to this better approach, which
> > is more generic and can handle situations like: "enabled the option in
> > the config file, and now you'd like to disable it on the command line
> > again".
> > 
> >   system/vl.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/system/vl.c b/system/vl.c
> > index a3eede5fa5b8..dfa6cdd9283b 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -3545,8 +3545,8 @@ void qemu_init(int argc, char **argv)
> >                   if (!opts) {
> >                       exit(1);
> >                   }
> > -                enable_mlock = qemu_opt_get_bool(opts, "mem-lock", false);
> > -                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", false);
> > +                enable_mlock = qemu_opt_get_bool(opts, "mem-lock", enable_mlock);
> > +                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
> >                   break;
> >               case QEMU_OPTION_compat:
> >                   {
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Hi Thomas,

BTW, do you think it's a good idea to define the overcommit via QAPI way
(defined in a json file)? ;-)

My rough understanding is that all APIs are better to be defined via
QAPI to go JSON compatible.



