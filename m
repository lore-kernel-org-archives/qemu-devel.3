Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01927C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhae-0000lK-JI; Fri, 03 Jul 2026 13:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wfhac-0000kw-FV
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 13:22:10 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wfhaa-0005hI-Js
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 13:22:10 -0400
Received: from example.com (unknown [167.220.208.73])
 by linux.microsoft.com (Postfix) with ESMTPSA id C722C20B7168;
 Fri,  3 Jul 2026 10:22:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C722C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783099323;
 bh=5468h0Xyk6ddN2jsouLnEHhGWSRplnM5oFZ9ld71cOM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k5KlEpqlaNIJN1ta+sH7yK85jKJQOSZfT3xFtOyKtj6p2Lopqe55Fnw5SzIfXBEmI
 9dLWIwLPm4/xc5GvMRw1b+JgV1pJbv/nuEYuwgywp5dB5+LY5llPYbp0RlCdDuhNz7
 rOSuWkIOAT61MeoUFvjNAYdJf71K3OUxY8yoIl7M=
Date: Fri, 3 Jul 2026 19:21:59 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <liuwe@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 26/34] accel/mshv: introduce SaveVMHandler
Message-ID: <akfvt0nTdVKZFOmJ@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-27-magnuskulke@linux.microsoft.com>
 <CABgObfbS988oSPNOV4qLMcT1CPLAyu-NigwYPgZSgZq1ZY7fxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbS988oSPNOV4qLMcT1CPLAyu-NigwYPgZSgZq1ZY7fxA@mail.gmail.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 02, 2026 at 10:50:17AM +0200, Paolo Bonzini wrote:
> Sorry, I forgot to reply about this one.
> 
> It is not clear why you need to pause, since this is handled by common
> code. Are you not handling live migration yet? That should be handled at
> levels above QEMU, because users expect migration to be performed while the
> VM runs, and the SaveVMHandler should just fail migration of the VM is
> running.
> 
> Paolo
> 

Hey Paolo,

I spent some time looking at this. it's a bit twisted. The un/pause()
calls are unfortunately named, they are merely freezing the progress of
the reference timer, which for any real-world workload is in fact
pausing the guest b/c if the timer doesn't progress an os would mostly
stall, waiting for ticks.

We want to freeze the timer though during the last phase of the
migration on the source and on the destination (can't set the reference
time if the vcpu time is not frozen). But currently it's the wrong
place. I'll find some more fitting place to perform this ceremony.

Curiously the time-frozen source was obscuring another potentially more
serious bug. The mshv vcpu dispatch loop currently does not honor a
cpu->exit_request, like it is currently set after precopy:

migration_completion_precopy()
  migration_stop_vm()
    vm_stop_force_state()
      vm_stop()
        do_vm_stop()
          pause_all_vcpus()
            cpu_pause()
              cpu_exit()
                qatomic_store_release(&cpu->exit_request, true)

The two bugs were sort of cancelling each other out. Since the source
guest was not busy, migrations were still succeeding, even though the
the vcpus were not actually "stopped" on the vcpu.

I'll rework this a bit, and submit a revised version.

best,

magnus

