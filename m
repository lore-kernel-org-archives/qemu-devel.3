Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4536EC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUD5-0003cP-NG; Thu, 30 Jan 2025 08:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tdUCy-0003aE-JQ; Thu, 30 Jan 2025 08:03:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tdUCv-0006Zs-RZ; Thu, 30 Jan 2025 08:03:48 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C4F2A5C555C;
 Thu, 30 Jan 2025 13:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C7FC4CED2;
 Thu, 30 Jan 2025 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738242209;
 bh=+Up349YLSg8MuPlubCkn8JkyDzqkqi4ZAU9amDg1JZY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ldiUcwj7+mlSryfXQ8CyCeNyv/WKDJecIQgOcj4+6JQ8JSDmf9ZfDCprPA08mxtps
 FwIu5eu4yozoAuxHIC8Jd7Mnnj5UZak3eJInHEfb7bh73AT1fYR3YLI/0txrgrH3Kx
 V/M4cuVl9XJoNwXaQ9DoXPvDmyKEICL8fh7E6t5BtizTcaZxpC+o+seRccoDWjgiUz
 uf1DqVtPBPNchEc9r6wjZhGd/MqYfKKBwxG5eDd2KHOhdYQs+qVDjn+EX0EPw0HaRf
 4bYjvApIwjR7bF7LzDN8/qWt56reYpajnBKV10GV8tIHIHhQFRE6f+zXcdJXntdFle
 baumsAwstZNEg==
Date: Thu, 30 Jan 2025 14:03:24 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/13] tests/acpi: virt: allow acpi table changes for
 a new table: HEST
Message-ID: <20250130140324.06cdd4bf@foz.lan>
In-Reply-To: <20250129160328.2f66584c@imammedo.users.ipa.redhat.com>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
 <1390b46682f2bac3587239d03a0ba22d18a9a044.1738137123.git.mchehab+huawei@kernel.org>
 <20250129160328.2f66584c@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Wed, 29 Jan 2025 16:03:28 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Wed, 29 Jan 2025 09:04:08 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The DSDT table will also be affected by such change.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> move it right before the patch that would actually make changes to tables (10/13)

Table changes happens on two patches:

- patch 03/13: acpi/ghes: add a firmware file with HEST address

	HEST table was added here

- patch 10/13: arm/virt: Wire up a GED error device for ACPI / GHES 

	DSDT changes happen here.

If the idea is to avoid make check to fail between those two patches,
we need either to split them on 4 patches (one before/one after each
change) or do like I did on this series: whitelist before patch 3,
update after patch 10.

Regards,
Mauro

> 
> 
> > ---
> >  tests/data/acpi/aarch64/virt/HEST           | 0
> >  tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
> >  2 files changed, 2 insertions(+)
> >  create mode 100644 tests/data/acpi/aarch64/virt/HEST
> > 
> > diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
> > new file mode 100644
> > index 000000000000..e69de29bb2d1
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index dfb8523c8bf4..46298e38e7b8 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1 +1,3 @@
> >  /* List of comma-separated changed AML files to ignore */
> > +"tests/data/acpi/aarch64/virt/HEST",
> > +"tests/data/acpi/aarch64/virt/DSDT",  
> 
> the list in not complete so 'make check-qtest' still fails
> [12/13] has complete list of changed files
> 



Thanks,
Mauro

