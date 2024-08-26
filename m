Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A89C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 03:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siQ9c-0006iL-90; Sun, 25 Aug 2024 23:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1siQ9a-0006gS-2q; Sun, 25 Aug 2024 23:12:26 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1siQ9Y-00038S-6G; Sun, 25 Aug 2024 23:12:25 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E6940A40C60;
 Mon, 26 Aug 2024 03:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3608DC32782;
 Mon, 26 Aug 2024 01:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724637229;
 bh=ebMyJy8EwG4eBNP+/2Ms59r287zOgET9dUx6Qw6/Jkg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=N5ps/gICmyo/YFf2tf8GtWWGdzv0Of5jVXGPEYqZgIQGZ0IOA9hnVxQaBE5h2fjBR
 FplQ7OSzQZpTNiJvJBwvExcBlGw9LLbD0BwON6dTLrdpLJydmem7Gie9OMN/Xvqsty
 koraxE3fQP9rUjrhruBqpQR/1y19ZirU6pY1/jiYrp2BnJ1o5lgBvDEocOHA30Wtza
 kgA1lGHcwNKkimze5QpjCDTaHuHXNpLzSfxG5JbwmwTAzukF7p2tKjZwrJjD11V4Jy
 lrj1cfSajLh9jBZ9IFM183HqxVfChoibrswzkwa/qSHYkV+x2o1LKvb7VRB0mqBg2Y
 M9dt9obqND2bA==
Date: Mon, 26 Aug 2024 03:53:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 11/12] target/arm: add an experimental mpidr arm cpu
 property object
Message-ID: <20240826035324.6b1edcc7@sal.lan>
In-Reply-To: <CAFEAcA-OaQ1ypa7LXz5nOs+6+fjmYNHzNL0VVgapoXEHU=rHnQ@mail.gmail.com>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
 <b88fe895e6f71711387ca153f4f1b3fbb0aa2176.1724556967.git.mchehab+huawei@kernel.org>
 <CAFEAcA-OaQ1ypa7LXz5nOs+6+fjmYNHzNL0VVgapoXEHU=rHnQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Em Sun, 25 Aug 2024 12:34:14 +0100
Peter Maydell <peter.maydell@linaro.org> escreveu:

> On Sun, 25 Aug 2024 at 04:46, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Accurately injecting an ARM Processor error ACPI/APEI GHES
> > error record requires the value of the ARM Multiprocessor
> > Affinity Register (mpidr).
> >
> > While ARM implements it, this is currently not visible.
> >
> > Add a field at CPU storing it, and place it at arm_cpu_properties
> > as experimental, thus allowing it to be queried via QMP using
> > qom-get function.  
> 
> >  static Property arm_cpu_properties[] = {
> >      DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
> > +    DEFINE_PROP_UINT64("x-mpidr", ARMCPU, mpidr, 0),
> >      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
> >                          mp_affinity, ARM64_AFFINITY_INVALID),
> >      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),  
> 
> Why do we need this? 

The ACPI HEST tables, in particular when using GHESv2 provide
several kinds of errors. Among them, we have ARM Processor Error,
as defined at UEFI 2.10 spec (and earlier versions), the Common
Platform Error Record (CPER) is defined as:

   https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html?highlight=ghes#arm-processor-error-section

There are two fields that are part of the CPER record. One of them is
mandatory (MIDR); the other one is optional, but needed to decode another
field.

So, basically those errors need them.

> Why is it experimental? 

This was a suggestion from Igor. As for now the QAPI for external
error injection is experimental, It makes sense to me to keep it
experimental as well.

> The later patch
> seems to use it via QMP, which I'm not super enthusiastic
> about -- the preexisting mpidr and mp-affinity properties are
> there for code that is creating CPU objects to configure
> the CPU object, not as a query interface for QOM.

I saw that. Basically the decoding by OS guest depends on MPIDR,
as explained at the description of Error affinity level field:

	"For errors that can be attributed to a specific affinity level, 
	this field defines the affinity level at which the error was 
	produced, detected, and/or consumed. This is a value between 0
	and 3. All other values (4-255) are reserved

	For example, a vendor may choose to define affinity levels as
	follows:
	Level 0: errors that can be precisely attributed to a specific CPU
	(e.g. due to a synchronous external abort)
	Level 1: Cache parity and/or ECC errors detected at cache of affinity
	level 1 (e.g. only attributed to higher level cache due to 
	prefetching and/or error propagation)

	NOTE: Detailed meanings and groupings of affinity level are chip 
	and/or platform specific. The affinity level described here must 
	be consistent with the platform definitions used MPIDR. For
	cache/TLB errors, the cache/TLB level is provided by the cache/TLB
	error structure, which may differ from affinity level."

Regards,
Mauro

