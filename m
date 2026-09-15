Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFACC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6X9V-0001gY-B5; Tue, 15 Sep 2026 13:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1x6X9S-0001gH-TU
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:41:02 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1x6X9R-0001R3-DP
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:41:02 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79EBB40F1D;
 Tue, 15 Sep 2026 17:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9071F000FF;
 Tue, 15 Sep 2026 17:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789494058;
 bh=BWiGRzKycO1RLpLU0xZUnZv/IK3wipnLxthVoAjJyc8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cXmDMPcPUTLqpONzqxVxsVlbOPgTA7/Ihmb8naMspjtjbaLjkvPehhyDAmW5Ev6Pf
 13TzEcouUv1MuwU+KaXOYjwaXfjvQUkK5FLeBauG9ovJTWapLKVPI052BXTUpDM1Vz
 R+h3UTsUKEdRUmQW1v38suH5FSPKS3leL4nPkvUFbATkpMt31pIOw3bxUx3GX8SxPi
 Jvzc6+AqYYNUXFy7qm59Lp2TkequncjKnHB5BEbA3J50WPIb1LNRopPGlatqOzIUg4
 QEj5h75WTz7VNJEdD7AEiNxZMBpJZf5vcmktUbFdLYwLWuAS1dpQD2rfje6jmgtWPh
 JdRp9ebkMpL4A==
Date: Tue, 15 Sep 2026 18:40:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com,
 jonathan.cameron@oss.qualcomm.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Junjie Cao as CXL reviewer
Message-ID: <20260915184056.44f30b8e@jic23-hlaptop>
In-Reply-To: <20260908042310.493882-1-junjie.cao@intel.com>
References: <20260908042310.493882-1-junjie.cao@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue,  8 Sep 2026 12:23:10 +0800
Junjie Cao <junjie.cao@intel.com> wrote:

> I have been reviewing, testing and contributing to hw/cxl for the past
> few months, and would like to be Cc'd on incoming CXL changes to help
> with review.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

Apologies for slow reply but for the record.
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Thanks for helping out!

I'm jumping through hoops to get a CXL staging tree up under new employer's
github.

Just waiting on what I think is final step so maybe have that done today.

Jonathan

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7183babd6a..bbabcf8cca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3328,6 +3328,7 @@ F: docs/devel/migration/CPR.rst
>  
>  Compute Express Link
>  M: Jonathan Cameron <jic23@kernel.org>
> +R: Junjie Cao <junjie.cao@intel.com>
>  L: linux-cxl@vger.kernel.org
>  S: Supported
>  F: hw/cxl/


