Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342C3C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJiZ-0003M4-WE; Thu, 02 Jul 2026 11:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wfJiY-0003Lb-Fq
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 11:52:46 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wfJiW-00043e-8v
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 11:52:46 -0400
Received: from example.com (p50892d29.dip0.t-ipconnect.de [80.137.45.41])
 by linux.microsoft.com (Postfix) with ESMTPSA id 85F0B20B7167;
 Thu,  2 Jul 2026 08:52:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85F0B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783007561;
 bh=W1PIRma9VdMGV7CJDv/Z7U/HiT8rAw/JvBy6iodIcqU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OZgcpp4tIZ2Gnzeflljl7XTC6DPD9qNU+2kslLT2zdmIcqEHqA7uGDUoIN2C8IlfK
 cKAg48W9CprbaZFzoN7FUZF4s3W90Lg41/fsGImEnOVQybJWTFxbHDxB6qxakJwe6Y
 +ojT7FfMiw8FMS4JrQ3HCbxzlz4OpLs17s1CC4g0=
Date: Thu, 2 Jul 2026 17:52:36 +0200
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
Message-ID: <akaJRKS+JdFvgZAM@example.com>
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
> Il ven 17 apr 2026, 12:58 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
> scritto:
> 
> > This mechanism is used to handle more imperative partition-wide steps
> > that have to be taken as part of a migration routine.
> >
> > Currently it's a skeleton that will just pause/resume the partition as
> > part of a migration. It will later be extended with more specific steps
> > like reference time and hypercall pages.
> >
> 
> Sorry, I forgot to reply about this one.

> 
> It is not clear why you need to pause, since this is handled by common
> code. Are you not handling live migration yet? That should be handled at
> levels above QEMU, because users expect migration to be performed while the
> VM runs, and the SaveVMHandler should just fail migration of the VM is
> running.

Oh, good catch, thanks. I misunderstood something about those hooks
apparently. I think this was originally inspired by migration logic in
Cloud-Hypervisor, which freezes/unfreezes a partition during migration
- but only after the pre-copy phase is done.

I assumed the hooks were also called only before the final delta is
transmitted. In tests I was relying on the reported state of the source
from QMP, which probably can not accurately reflect the state of the
partition as the freeze/unfreeze happens out of band (i.e. is is not
orchestrated by the migration framework).

I'll have to research a bit and see if there are more appropriate hooks,
or if we don't need to freeze the source partition at all.

best,

magnus

