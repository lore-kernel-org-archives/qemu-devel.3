Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FD4C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfE2y-0004Sd-9E; Thu, 02 Jul 2026 05:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wfE2u-0004SK-SN
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:49:24 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wfE2t-0003py-3U
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:49:24 -0400
Received: from example.com (unknown [167.220.208.73])
 by linux.microsoft.com (Postfix) with ESMTPSA id 9550B20B7167;
 Thu,  2 Jul 2026 02:49:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9550B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1782985758;
 bh=kLkylU6zCdWK6DFk7N+SawUDN3b6D/pxpOUEbBGRxhA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Utua5IQdYG3LAfiztJNTN9CJkfEg3a86hguSfSv8ZkyorWwXP37EZxfluNBkN7UKj
 UPI/+4/S2fTU/O51q4ktu+FEH6C6OUhUjJ+v4NlheVHc8hl3yJwVITWCqQQbs+bPXd
 PQgu0+FfCNzhKDHLOCQq6sdYKTGMzA+OCIyksTfA=
Date: Thu, 2 Jul 2026 11:49:14 +0200
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
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
Message-ID: <akY0Gpd/GHj3Pdun@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
 <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>
 <akUyiNahX3LnFPhn@example.com>
 <CABgObfbQTUOaiMYApABTettYa0D3WasGs1NjQrWvo4tmAZpazg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbQTUOaiMYApABTettYa0D3WasGs1NjQrWvo4tmAZpazg@mail.gmail.com>
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

On Thu, Jul 02, 2026 at 10:51:35AM +0200, Paolo Bonzini wrote:

> What are the additional fields that aren't covered (i.e. cannot be copied
> from hv_lapic_state to the struct and back) by the common APIC state?
>

that would be those:

    uint32_t apic_version;
    uint32_t apic_lvt_lint0;
    uint32_t apic_lvt_lint1;
    uint32_t apic_lvt_cmci;
    uint32_t apic_error_status;
    uint32_t apic_counter_value;
    uint32_t apic_remote_read;

Reference struct is this: hv_local_interrupt_controller_state

https://gitlab.com/qemu/qemu/-/blob/master/include/hw/hyperv/hvgdk_mini.h

Notably we have to do this for lvt_lint0+1. We cannot use the respective
fields in the common APIC state, because writing to those has a side effect
in QEMU: If unmasked, it will trigger a chain of events,

pic_irq_request() => apic_accept_pic_intr() => apic_deliver_pic_intr()

For MSHV (and WHPX afaiu) we're currently not able to trigger legacy
interrupts from userspace in this fashion. Hence we roundtrip
lint0/lint1 in a dedicated mshv struct.

best,

magnus

