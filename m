Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5F606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXHlSDm8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO39e-0005qg-77; Mon, 02 Nov 2026 20:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO39c-0005qA-FV; Mon, 02 Nov 2026 20:17:36 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO39b-0002Uo-3Z; Mon, 02 Nov 2026 20:17:36 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0475960008;
 Tue,  3 Nov 2026 01:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D031F000C1;
 Tue,  3 Nov 2026 01:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793668653;
 bh=oDCh0V6h7zIvGD8hSBKim/GAb8yStjoM/fkjCvD2UBE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=RXHlSDm81sK4ZQ/22s/BRrA02bN4OkEl106kdqZJUMM9j/VUaz/Xq5s/VwPEmXHEW
 aPnh4/KyaWQD5sStjjrG6Xw90wwL/lEdB05A9omygwAkLU6ocXqZRlhOjw3HXB3MpZ
 V2OEFj6ax3xm75UMSx91UQYxreCTUlSwdeAW+PMdG2fC4D/pJij4OOTwuaJBah0vQ3
 WKgUnCwYJ03TAgPurdOlanQyHzjokhmar33SKKIzcT7PlHYhF1hLai5+yvH8eRXY4f
 Mxr5Q0fQ9VJrv+0H+5Uk06C2rFaOhO6FhCe5TybuqvsjaDGb5pdOcwN45yvaBBJ8uo
 AJroMVpCKZkww==
Date: Tue, 3 Nov 2026 01:17:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 10/37] hw/arm/mpam: Add per-RIS partition config storage
Message-ID: <20261103011727.59bf68cd@jic23-hlaptop>
In-Reply-To: <tencent_EC6CDAD1841362E72DB694D10CF7B1D80A06@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_EC6CDAD1841362E72DB694D10CF7B1D80A06@qq.com>
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
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 17:47:04 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add the per-internal-PARTID configuration storage: MpamfPerNrwId
> holds every partition's CPBM bitmap, bandwidth, priority and
> capacity settings, allocated per RIS at realize together with the
> request-to-internal PARTID indirection table.  mpam_get_nrw_id()
> resolves the currently selected partition for the configuration
> register accesses: with INTERNAL selection the selector addresses
> the internal PARTID space directly, otherwise the indirection
> table maps the request PARTID.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


