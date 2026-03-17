Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6201FB5EAD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2VeC-0008GJ-CE; Tue, 17 Mar 2026 10:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1w2Ve0-0008EJ-Rk; Tue, 17 Mar 2026 10:43:45 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1w2Vdy-0001Wr-LY; Tue, 17 Mar 2026 10:43:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 42E8343C5C;
 Tue, 17 Mar 2026 14:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B450AC4CEF7;
 Tue, 17 Mar 2026 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773758600;
 bh=RZsNYxV2xPVAYbu8DJL1kdvHKgawd2EITYzU6G2thrY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qb7oNemWWHyj7bn0j2FiQT8YBlcjkFsghvdoujMDnuMLNmNfb+/gToygT6UUCiKSt
 HNmMDhK1OKjCTxrw59sa0llh1mxNMJA7iBP0AtbIXGMAeiOkR/syyZtQ+VDMq/+/uX
 M50Fa73Gkd56a+RZnMNQy91+VW/6FSdkNmVOo26cF1xXOKx3kOJ54R9XdqBq3XTICP
 Ips/c8zR/iZM/cw6b4QDqK4zcYJYzsiMeMSiSJyKhczLojygXDGCRqUm/6J+IJR08H
 2ofgWP/bUsaluPgF7uXfMrfhIkmcsbywW03mUdlwHgwEa9belY0q+NdetE+JbSGNpp
 fTnO9h6u4lwBg==
Date: Tue, 17 Mar 2026 08:43:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC 0/2] hw/nvme: support mdts above 9
Message-ID: <ablohaUgShQOUa8Z@kbusch-mbp>
References: <20260317-lift-iovmax-dma-limit-v1-0-38729170683f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317-lift-iovmax-dma-limit-v1-0-38729170683f@samsung.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=kbusch@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 17, 2026 at 09:48:56AM +0100, Klaus Jensen wrote:
> In commit 53493c1f836f ("hw/nvme: cap MDTS value for internal
> limitation"), the max value of MDTS was restricted to ensure that the
> device will not report internal device errors when hitting the internal
> IOV_MAX limit of the block layer.
> 
> This series attempts to lift the IOV_MAX restrictions, by splitting I/O
> in the dma helpers.

Nice, this was simpler than I thought! Looks good to me:

Acked-by: Keith Busch <kbusch@kernel.org>

