Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B43C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHCz-0007d3-Qv; Thu, 02 Jul 2026 09:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wfHCx-0007cp-Sq
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:11:59 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wfHCv-0006Nw-8w
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:11:59 -0400
Received: from example.com (unknown [167.220.208.73])
 by linux.microsoft.com (Postfix) with ESMTPSA id 95F9220B7167;
 Thu,  2 Jul 2026 06:11:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95F9220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1782997913;
 bh=KjWxs47FrqE58lRtkZlQudRjJ8DeMoQhjDC1mCt8QmE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XQpa7uBkUFxCWuuq5e/QgHSyhHNv2e4U8bCh1dfhYWQyPFtEbcLV3Oc/Km0AOxGwq
 KdvgGeAf66YEscsKkUpzhqmkKWOeziMcMyxzpEl0FtFdQ0UPOp7aTEkIFWWLcUjWyO
 6XNIEtsX0fVX2aOnGWeZvRhQNlYdprs08VOKRJ3w=
Date: Thu, 2 Jul 2026 15:11:49 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 kvm <kvm@vger.kernel.org>, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
Message-ID: <akZjldXYFQ7Fchoo@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
 <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>
 <akUyiNahX3LnFPhn@example.com>
 <CABgObfbQTUOaiMYApABTettYa0D3WasGs1NjQrWvo4tmAZpazg@mail.gmail.com>
 <akY0Gpd/GHj3Pdun@example.com>
 <CABgObfZhNwXLG9ip=CnEiVb=p24etvxeodbjG5=Di4hOKvYF8Q@mail.gmail.com>
 <6CBE1CEC-F8F9-488F-95E4-5237F0F7A232@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6CBE1CEC-F8F9-488F-95E4-5237F0F7A232@unpredictable.fr>
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

On Thu, Jul 02, 2026 at 02:38:24PM +0200, Mohamed Mediouni wrote:
> > On 2. Jul 2026, at 13:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > What is the issue? The interrupt won't be triggered either if you use a separate field, or if you use the normal one.
> 
> Hi,
> 
> For injecting LINT0, it’s possible on modern WHPX when using the hw irqchip
>  - starting from Server 2022/Windows 11 only - not before that point.
> 
> How it’s done is though cancelling the vCPU execution, wait until the vm exits
> as a result, set an interrupt window, run the vCPU again and then when it exits
> Manually injecting an event…
> 
> That’s unlike non-legacy interrupts where the request interrupts path actually
> works on Hyper-V.
> 
> > 
> > For LINT1, can you not inject an NMI either?
> 
> The request interrupt path works at least to some extent on LINT1/NMIs unlike LINT0
> but didn’t dig deeper to see if it has more issues…
> 
> I’m convinced that an Hyper-V specific structure is the wrong idea for this though...

Thanks for chiming in Mohamed. Indeed, I think the culprit is that
injecting legacy interrupts is currently not working as expected on
MSHV either, so this behaviour is probably related to Microsoft
Hypervisor itself.

When you refer to "cancelling the vCPU exection", I suspect you mean
manipulating the intercept/explicit suspend registers? I understand that
the mshv driver maintainers would prefer not to expose that particular
knob, since the kernel driver maintains some internal suspend state. Thus
the hvcall is blocked from dom0 userspace currently. I'll have to further
clarify that with the mshv team, though.

Mirroring the LINT0/1 fields in a dedicated MsvhApic structure was
motivated by the legacy interrupt injection path not working and thus
breaking the destination on a migration. Assuming we don't have the option
to make it work without a kernel change (in the short term), what
would be your suggestion?

I can image we can short-circuit this chain for mshv, is that
preferable?

pic_irq_request() => apic_accept_pic_intr() => apic_deliver_pic_intr()

best,

magnus

