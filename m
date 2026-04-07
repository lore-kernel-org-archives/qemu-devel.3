Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6BFFF513B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 21:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wADWc-0004Ms-2u; Tue, 07 Apr 2026 16:59:54 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wADWa-0004MK-01
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 16:59:52 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wADUR-0000wD-9m
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 16:57:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A4C02600AC;
 Tue,  7 Apr 2026 20:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3F1C116C6;
 Tue,  7 Apr 2026 20:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775595451;
 bh=4+gNC0s2qQJ4oL9xsc/4G09+rjiF+z+Me6wgkXsSwOE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oqQBoGwDYIQpySY8tjqHqNbhjdtvBDo30jMD/NIWJkrlBEX9SAG6bWv8XVfW/mUDK
 ysE0YFCYHeMSY7/2cfG0CN7fLsCl7Um9FCeGKUxQxODSekJs0FQ78HValqdW41D52w
 pgpO4mPjG6SfXNTls9zzTuPw4sFn5NX40sx33ax7J5LVoEQd+WrYc0Tf8jCXRh5zEP
 NdxEVLRIaQW4wT2pYkljImZSBV0a8EHjX98czmeNa0oFrRnB+yn1IxvDco5D52p9me
 +k3V6l/DvJG16ItpYt/FCyIDuQqpNYtBeTEugFolWFlfC43p+NwA9bXAwKJB8SB1G9
 S9+7G8YnrMJdQ==
Date: Tue, 7 Apr 2026 22:57:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 0/5] monitor: add dynamic QMP monitor hotplug support
Message-ID: <20260407-notprogramm-wohlfahrt-be7393963311@brauner>
References: <20260407-work-qmp-monitor-hotplug-v3-0-cb259800fffb@kernel.org>
 <adTj1iWPZYTD0CF1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adTj1iWPZYTD0CF1@redhat.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=brauner@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 07, 2026 at 12:00:38PM +0100, Daniel P. Berrangé wrote:
> On Tue, Apr 07, 2026 at 09:32:44AM +0200, Christian Brauner wrote:
> > QEMU supports runtime hotplug for chardevs, devices, block backends,
> > and netdevs. Monitors are the only major subsystem that lacks this --
> > all QMP monitors must be configured at launch via -mon or -qmp CLI
> > options.
> > 
> > This series adds monitor-add, monitor-remove, and query-monitors QMP
> > commands so that management tools can create independent QMP sessions
> > on demand at runtime.
> > 
> > I've implemented a QMP-to-Varlink bridge in systemd. This allows
> > systemd-vmspawn to control virtual machines and containers through a
> > unified Varlink interface. Varlink allows protocol upgrades. For
> > example, it is possible to switch from Varlink to say http. I'm
> > allowing Varlink clients to upgrade from the Varlink interface to the
> > native QMP interface. Such clients get a new monitor assigned that
> > allows them to manage the virtual machine directly via QMP. The main
> > monitor remains unaffected and tied to the generic Varlink interface. We
> > can't pre-allocate monitors as we have no control over how many protocol
> > upgrades we actually get but it won't just be one. And having unused
> > monitors around really isn't ideal either.
> > 
> > Having the ability to hotplug monitors would really be helpful. I'm not
> > yet super well-versed in qemu internals so this might be done wrong but
> > testing works so far.
> 
> Can you say if AI agents/LLMs were used in creating these patches ? 

In exploring the QEMU codebase and how the QMP protocol is used in other
code-bases. So specifically I used it to research:

* Does monitor hotplug already work?
* Has the idea of monitor hotplug been discussed before?
* Is there an obvious fundamental reason this cannot work?
* What does the lifetime of a monitor look like?
* I used it to review the code I wrote and point out bugs that I then
  fixed myself.
* I had various research questions around how io-thread interactions
  work and common synchronization primitives in the codebase.

The code hasn't been written by any coding tool in line with what is
requested in the contribution guidelines. I used it to speed up my
understanding of what's going on and to debug things without using the
output.

