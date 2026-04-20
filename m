Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ECDF5581D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 11:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEmwT-0006Mu-OT; Mon, 20 Apr 2026 07:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wEmwQ-0006Mb-Ax
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 07:37:28 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wEmwO-0005o3-9w
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 07:37:25 -0400
Received: from example.com (unknown [167.220.208.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id 14E8920B7128;
 Mon, 20 Apr 2026 04:37:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14E8920B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776685037;
 bh=hMztnChoRWBhJVAeBAm1kILl7UPyeglHbYha958D4VI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RDGaNCFNst+wbGoqTqVFYjzbeGbMSVZXWxThgokV0kE43dlDhDeGxIu0ZrhGtjD5n
 kXzw6SnXNzM9rwG2Tz2+R8PbrI8fh+2RS9ogBXEZ5STWwN4H430ykMuaehXHG/wNPM
 41fsjT4o4NeY0aunVC5xso4ApPs5MD8vR5SUzMts=
Date: Mon, 20 Apr 2026 13:37:11 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <liuwe@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
Message-ID: <aeYP5204OgzMUVRO@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
 <E651C54B-3AE5-45B6-A275-26C415EA0582@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E651C54B-3AE5-45B6-A275-26C415EA0582@unpredictable.fr>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 17, 2026 at 01:54:48PM +0200, Mohamed Mediouni wrote:
> 
> 
> > On 17. Apr 2026, at 12:56, Magnus Kulke <magnuskulke@linux.microsoft.com> wrote:
> > 
> > This change implements loading and storing the hyperv lapic state as
> > part of the load/store routines for a vcpu.
> > 
> > The HyperV LAPIC is similar to the the split-irqchip in KVM, it will
> > only handle MSI/X interrupts. PIC and IOAPIC have to be handled in
> > userland.
> > 
> > An opaque blob is added to the APICCommonState, guarded behind a flag,
> > hence it will be covered by a migration, as we declare VMSTATE_BUFFER
> > for the hv_lapic_state field.
> > 
> > In the future we might want to introduce a dedicated class for MSHV, that
> > would require us to wire up an IOAPIC delivery path to QEMU's userland
> > emulation.
> > 
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> 
> Hi,
> 
> Is there a way to make this not opaque in a way that retains the ability to
> Save-restore between KVM and MSHV? 
> 
> Or is that not a wanted goal?
> 

yeah, for the time being it's a non-goal. there might a way to map
hyperv lapic state onto existing state fields, but the mshv crates
(which is the closest to a reference impl for mshv uapi) currently
only expose the state as an opaque buffer.

