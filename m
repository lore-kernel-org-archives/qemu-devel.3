Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60EFCAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 06:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0wxm-0007OY-8K; Tue, 23 Sep 2025 02:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1v0wxj-0007NS-TA; Tue, 23 Sep 2025 02:57:19 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1v0wxh-00066u-9k; Tue, 23 Sep 2025 02:57:19 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 85C9144185;
 Tue, 23 Sep 2025 06:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5429C4CEF5;
 Tue, 23 Sep 2025 06:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758610631;
 bh=VfTZtweG+rMvO8QkFHrpIA+XRbhzgEaglatdkL/UTEg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SdqHgTb3OIVrTCv0LnuAE1pGpejIaQ+qxYf8/24QryAXFi+MzfS1xYKBc8Z/NQFYN
 vUCLb6AMwKFx9YGCL5VHHielRxDS4rQB1hbDONnuoHnzS/ZnRwuprWsNt4jHs/xU6I
 77zfIeq++Jeto5yVIJ00su/9TH7opv8SejdbGB5o6LSYIthoMbK1C2ANDnIbN4tX9g
 nlh58fNDAku8pUNtoWsdh1UFtQb6D3xh5vBS1JmwXjw8GUmZH1LGglUT1mKcHyCJtM
 Bt/jVc7AIhwmAZueCUBKPhDfRfURg5UAWRvz5CNnUcwc84/IPA7VHBEZhQya3SoEkQ
 Ar8uwzn+RcWuw==
Date: Tue, 23 Sep 2025 08:57:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v11 15/17] tests/acpi: virt: update HEST and DSDT tables
Message-ID: <20250923085706.456ef52b@foz.lan>
In-Reply-To: <20250922065207-mutt-send-email-mst@kernel.org>
References: <cover.1757084668.git.mchehab+huawei@kernel.org>
 <e2c35dc477479eecc895425117b257540b4b74c6.1757084668.git.mchehab+huawei@kernel.org>
 <20250922065207-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Em Mon, 22 Sep 2025 06:52:47 -0400
"Michael S. Tsirkin" <mst@redhat.com> escreveu:

> On Fri, Sep 05, 2025 at 05:09:22PM +0200, Mauro Carvalho Chehab wrote:
> > --- /tmp/DSDT_old.dsl	2025-09-05 15:03:18.964968499 +0200
> > +++ /tmp/DSDT.dsl	2025-09-05 15:03:18.966968470 +0200
> > @@ -5,13 +5,13 @@
> >   *
> >   * Disassembling to symbolic ASL+ operators
> >   *
> > - * Disassembly of /tmp/DSDT_old
> > + * Disassembly of /tmp/DSDT
> >   *
> >   * Original Table Header:
...

> Mauro dumping raw diff in a way that confuses git am is
> not the way to submit patches. I fixed it but take care pls.

Ok, I'm adding a 4 spaces indentation to the description diff.

Thanks,
Mauro

