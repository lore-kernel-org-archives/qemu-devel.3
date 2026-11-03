Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAD606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gL5Swkhi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO3kS-0007w8-WB; Mon, 02 Nov 2026 20:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3kR-0007vO-13; Mon, 02 Nov 2026 20:55:39 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3kP-00063H-ME; Mon, 02 Nov 2026 20:55:38 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D7AF60008;
 Tue,  3 Nov 2026 01:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F6D1F000C1;
 Tue,  3 Nov 2026 01:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793670935;
 bh=qHuitNFI6q6IgtE0Rfvqfvp7MIEYC7sIACNHv8n7Oyo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=gL5Swkhill9Y2dKlGXJh5mPeDfODu2PVDhcKN900Dgp4YHH5e4hgb3mIDZvVZIrz0
 GC7JyjbAm+UO1MP26eebkJOGtYDxJ6cym6xeLPgGR3DLunfZ2FcFMU1O37KosKjk0T
 sikz5T0rrssZEIqI3n7GwlLIE1mceIqPNaU43u7WYJnXliKJkJJHooeiG+tJe4xEyS
 LXIB0+4qJqT1Zlr4TtlB7WCQzkogpLJriQj8aT8OgK6mzHfCCsRiEZv/nukpxBX6Ql
 TIcIrUAHHNv8gwg6BdS1DkjIF0OlPjQW3Lcdvt+9SeXIOLUp4NRquIQtg9rxIvWBzI
 nHABaGjlrZ7AA==
Date: Tue, 3 Nov 2026 01:55:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 19/37] hw/arm/mpam: Add node and interrupt GSIV properties
Message-ID: <20261103015527.0d153f1e@jic23-hlaptop>
In-Reply-To: <tencent_F4EA7DE6EF9866E530AD70A209F1F7565805@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_F4EA7DE6EF9866E530AD70A209F1F7565805@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=tor.source.kernel.org
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
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 18:10:39 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add the qdev properties the board and the ACPI table need: node
> (the NUMA node a memory-side MSC serves, UINT16_MAX = unset) and
> err-gsiv/oflow-gsiv (the wired interrupt GSIVs the board assigned;
> zero means no wired interrupt and the ACPI MPAM table reports it
> as not present).
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Not sure I'd have had this as a stand alone patch, but not
really worth arguing about!

