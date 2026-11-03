Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE19C606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnL4465o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO2Bc-0000k0-HL; Mon, 02 Nov 2026 19:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO2Ba-0000jT-BN; Mon, 02 Nov 2026 19:15:34 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO2BY-0004sn-Nk; Mon, 02 Nov 2026 19:15:34 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 112D0600D1;
 Tue,  3 Nov 2026 00:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9931F000C1;
 Tue,  3 Nov 2026 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793664930;
 bh=Y4LFVJVthCWwicc7DwLk1aeU1JFy6TvI4DridiVWqSU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=bnL4465oEj9uh0KkAyI0zxOyVQUmmIckxi0uoTT91W1Ecw6oI8LCdjNNu7Jbc7bab
 2ms7Fl+DLTSrTnbUVUAU5i6IeyJNXJhqTJOuIEsO1gZhjhtBTsOnMHA7QNOKrrbHKj
 MiuWPf6UQqb1v4EgS/v+Zj3gAhMXVcQQswXQytRzScUdp5MnkvQwMY2qGWIrtXBkqu
 6YiPdH+5CM/rTWZtoVHU+0AMCTKcUejhlaqTa4zGGYK1PmK0rNHFnXnbRVkAek4E9S
 3qam40FJO4OjManpn341PbrxZjsvp6Jh/TyYP8onJTxrRnSMgnbPnumw5v34GcQZ46
 b1k1+3oFnQTWA==
Date: Tue, 3 Nov 2026 00:15:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 04/37] hw/acpi: Build PPTT rev 3 with cache IDs for MPAM
 cross-references
Message-ID: <20261103001524.6f182b3d@jic23-hlaptop>
In-Reply-To: <tencent_F9C68A515AC6C40BE2C32DB314E14CCB7106@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_F9C68A515AC6C40BE2C32DB314E14CCB7106@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 17:46:58 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> The MPAM ACPI table points at cache MSCs via a cache_reference that
> the kernel resolves against a PPTT cache node carrying a Cache ID
> (only present in PPTT revision 3, with the Cache ID valid flag).
> Without it, a guest MPAM driver cannot associate cache MSCs with
> caches and rejects them.
> 
> Bump the PPTT to revision 3 and give every cache node an ID derived
> from its type, level and the first CPU of the topology container it
> belongs to. The virt machine's MPAM cache MSC creation uses the same
> topology levels (L3 at socket, L2 at cluster) as the PPTT builder and
> derives the same IDs, so MSC locators resolve to real cache nodes.

Good. We dropped this from the last PPTT revision upgrade on basis
we had no user without MPAM.  Now we do indeed need an upgrade.

PPTT is tested though so you need to add the two wrapping commits
described at the top of tests/qtest/bios-tables-test.c
and upgrade any effect tables in tests/data/acpi/arm/...

Given the implementation defined aspect of this is how the cache
IDs are derived, I'd add a description of that here.


With that stuff tidied up.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>


