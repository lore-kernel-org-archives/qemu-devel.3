Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7ED606A327
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcsxvxFP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO3gj-0006VB-Sr; Mon, 02 Nov 2026 20:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3gh-0006UG-T7; Mon, 02 Nov 2026 20:51:47 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3gg-0005PR-Fd; Mon, 02 Nov 2026 20:51:47 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7773560008;
 Tue,  3 Nov 2026 01:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AE01F000C1;
 Tue,  3 Nov 2026 01:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793670705;
 bh=pAt9OY/L0QOe2G9jH/mc1mCqpCegYDx0AzzLQjsUGcw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=bcsxvxFP1onx0dlSj2b9oDMhVSUsh2RTW4B5QxzMs+tDnjSi9uy7n9TlVF4c+ctSE
 Q50AFsnKSMLKAzfG3+/ghuYv9RjlkqU9/o/YwU6EjvyimRoLK58FtgxAeNlZAGMkWx
 kaomVURT337dQjU3K1LbiilKPToucNsJlWtq33gI7Fl5qxU3a31oIA01Z8eJ6z0RT+
 eJDmldgVwtu9KvNywJzLnm1HOt2meI/W1Tpdt9dGlUTJrV/0jA8uSef/UDDimSXjVf
 DzXgC15vD5bXfCXZraZUxhKPSI0cEGnu2euqLsDW+HHW2dACwg5MP4RXA/LZPVy9Tv
 k1Zush0EH8idQ==
Date: Tue, 3 Nov 2026 01:51:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 17/37] hw/arm/virt: Add mpam and mpam-min-msc machine
 properties
Message-ID: <20261103015138.2191fa9b@jic23-hlaptop>
In-Reply-To: <tencent_4A73E52B4D6BC21D11E7564A8A6EA6EF5805@qq.com>
References: <tencent_4A73E52B4D6BC21D11E7564A8A6EA6EF5805@qq.com>
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
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 18:10:35 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add the two MPAM machine properties: mpam=on enables MSC emulation
> for the virt board, and mpam-min-msc=on collapses the per-node
> memory MSCs into a single MSC with one RIS per node.  The state
> fields and the property accessors only; MSC creation arrives with
> the later patches.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

I'm curious to get more viewpoints on the somewhat weird mpam-min-msc
though.  It is kind of handy for testing IIRC but not sure it is realistic.



