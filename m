Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7862BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 03:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4uiR-000088-Ad; Wed, 08 May 2024 23:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s4uiP-00007w-Ic
 for qemu-devel@nongnu.org; Wed, 08 May 2024 23:45:05 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s4uiM-0003FS-9v
 for qemu-devel@nongnu.org; Wed, 08 May 2024 23:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715226302; x=1746762302;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=joleapBE/tDRjEAY8DKFkyHrno8CqOPI5WDEfCYBmRU=;
 b=PQ9XV8Y/bTD8uCAkn6GAhx5mROAixNwSMjZ4qAoeE1pjO4G497yDv8FT
 TgbbzSchEsO8nyoqTzVOfYukKaM+oObkXfDvCVFWCHgdvS8Go5wcuFb44
 LCl4z9qMqYOh6WtrEooYAAs52OO9ODZ7Kivqp5G123jaIY9XlLXk2PFZa
 a9ROjHufGfVY2pOb43gwet+/vcgBy9BspFhiyJ2rMsJSUYRLnRJYAeZPe
 BZWrQBPjULld0PgIoZMCtcOmZ+pB4Z1DFnGuJrFDN34C7B48yHPfpeAHB
 0OPt9vKV2F/WUNEPSA4jOrVY2esCvCAtw1bV4RgTJFryjdh2rV9mRNbtH Q==;
X-CSE-ConnectionGUID: 5T/cyZ1ZTaqBYMkePBSyWw==
X-CSE-MsgGUID: 5y+rKYGdRYSz1yinvT99JA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21792501"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; d="scan'208";a="21792501"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 20:44:58 -0700
X-CSE-ConnectionGUID: 5c0Fyc1DTKSPnKW0PC412A==
X-CSE-MsgGUID: /SEk426/T92AWOsJtiXRNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; d="scan'208";a="29055643"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 08 May 2024 20:44:57 -0700
Date: Thu, 9 May 2024 11:59:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable timestamp
 as WARN
Message-ID: <ZjxKDkZjAitxCasH@intel.com>
References: <20240508043229.3433128-1-zhao1.liu@intel.com>
 <CAJSP0QX0y_J1pu+hgUNhXn7bFJfoAMm9Ux9vq3u+k_UDjwK8Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QX0y_J1pu+hgUNhXn7bFJfoAMm9Ux9vq3u+k_UDjwK8Ww@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 08, 2024 at 02:05:04PM -0400, Stefan Hajnoczi wrote:
> Date: Wed, 8 May 2024 14:05:04 -0400
> From: Stefan Hajnoczi <stefanha@gmail.com>
> Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable
>  timestamp as WARN
> 
> On Wed, 8 May 2024 at 00:19, Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > In some trace log, there're unstable timestamp breaking temporal
> > ordering of trace records. For example:
> >
> > kvm_run_exit -0.015 pid=3289596 cpu_index=0x0 reason=0x6
> > kvm_vm_ioctl -0.020 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> > kvm_vm_ioctl -0.021 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> >
> > Negative delta intervals tend to get drowned in the massive trace logs,
> > and an unstable timestamp can corrupt the calculation of intervals
> > between two events adjacent to it.
> >
> > Therefore, mark the outputs with unstable timestamps as WARN like:
> 
> Why are the timestamps non-monotonic?
> 
> In a situation like that maybe not only the negative timestamps are
> useless but even some positive timestamps are incorrect. I think it's
> worth understanding the nature of the instability before merging a
> fix.

I grabbed more traces (by -trace "*" to cover as many events as possible
) and have a couple observations:

* It's not an issue with kvm's ioctl, and that qemu_mutex_lock/
  object_dynamic_cast_assert accounted for the vast majority of all
  exception timestamps.
* The total exception timestamp occurrence probability was roughly 0.013%
  (608 / 4,616,938) in a 398M trace file.
* And the intervals between the "wrong" timestamp and its pre event are
  almost all within 50ns, even more concentrated within 20ns (there are
  even quite a few 1~10ns).

Just a guess:

Would it be possible that a trace event which is too short of an interval,
and happen to meet a delay in signaling to send to writeout_thread?

It seems that this short interval like a lack of real-time guarantees in
the underlying mechanism...

If it's QEMU's own issue, I feel like the intervals should be randomized,
not just within 50ns...

May I ask what you think? Any suggestions for researching this situation
;-)

Thanks,
Zhao


