Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22794C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 15:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngAo-0003qS-C7; Thu, 27 Feb 2025 10:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tngAj-0003kG-1n; Thu, 27 Feb 2025 10:51:37 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tngAg-0005Qd-E7; Thu, 27 Feb 2025 10:51:35 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4CBC361133;
 Thu, 27 Feb 2025 15:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE05FC4CEDD;
 Thu, 27 Feb 2025 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740671489;
 bh=PHJN1RpbO9GMEWPKvKo8ZGNRDOt2AAgARtGo6eeodlE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=vI9s8NCSEzDAoFvgPzU1qh5MCL9IOBnnspb+eNUrxnLkhf8JsddPi7oSkjFfPjdI1
 36YsEp8HvfILAwdOPXaN6DLjMezy2xilcZCbXtAeR2VTO2bGL4Vlo5oPsrGw+kjDfH
 2a02Gg/aPOJixzHrYEWwHxo1pG9SL9NFuHTfqLNrf3qeQ4Cw+MRZAO26/K3CBstNGb
 M/Dp6nvD8ugZZS4rF4ZjvIWh7qXSrtMjTIqGI8mSBdlLm4HqHtcxLJQnT3JGPrzb1U
 wS1A9QkcES7PtlX2rGtFKxjWtkDryIF9jLsXaW+NLE9Ee0QB9ZuqdHi05X1ndpA9I6
 I3VH7J7Ec9jwA==
Date: Thu, 27 Feb 2025 16:51:24 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/21] tests/acpi: virt: update HEST table to accept
 two sources
Message-ID: <20250227165124.221ef1b2@foz.lan>
In-Reply-To: <20250227141603.3957e78b@imammedo.users.ipa.redhat.com>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <9d57e2a6ec3f523eb7691347403f05ad40782b94.1740653898.git.mchehab+huawei@kernel.org>
 <20250227141038.28501d73@imammedo.users.ipa.redhat.com>
 <20250227141603.3957e78b@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Em Thu, 27 Feb 2025 14:16:03 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Thu, 27 Feb 2025 14:10:38 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Thu, 27 Feb 2025 12:03:47 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > 
> > squash this patch into the next one
> > 
> > Also at this point there is no visible HEST changes yet, so a soon as you remove
> > white-list without enabling new HEST, the tests should start failing.
> > 
> > I suggest to move 20/21 before this patch,
> > as result one would see dsdt and hest diffs when running tests
> > and then you can use rebuild-expected-aml.sh to generate updated
> > tables and update them in one patch (that's what we typically do,
> > we don't split updates in increments).  
> 
> on top of that,
> it seems the patch doesn't apply for some reason.

Hmm... perhaps the diffstat that I place here (produced by bios-tables-test
output) is causing some confusion when you're trying to apply the patch.

Any suggestions to avoid that?


Thanks,
Mauro

