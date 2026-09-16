Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE25C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 02:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6fnT-0001SH-DE; Tue, 15 Sep 2026 22:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1x6fnS-0001S4-06
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 22:54:54 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1x6fnQ-0005uE-6T
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 22:54:53 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F333409A4;
 Wed, 16 Sep 2026 02:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8921F000FF;
 Wed, 16 Sep 2026 02:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789527289;
 bh=c2mHanBhFEhMODwSGAnmCdAkH9gL3/SYw7zGHBzQERU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=MPJIAqQmEmaNWy2M0E6V7mPKjfqwhah3OIPmQbfJ/WO73jGVdo7GVwr4/uTc+8s5H
 e7bRUVU8DoTDag9uFsyIRBHAaQSXlrGLaL6bC1wCu5mzIM63NhUnloI0OHe8aZi7L2
 Pevm/Bv83CY0gkcAtdFqZAcLTMvfhpARpABg+Udd0cv6U0//iMiy5jZCSDsJWO+hPg
 HSrt2Sfj+i2G7HddT6+MW70/Ne2OMrk75uDS5PeQiIWp8B55ffsLOLH5lGyTXuWe9q
 VdDfS7W9QKHkDdz092zRuLu+wnnwh1jhMDzLCgjnxmTAzNWXXGOhaSKIZgO7Xa6g2p
 6R1/mA+vkQIJQ==
Date: Wed, 16 Sep 2026 03:54:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anisa Su <anisa.su887@gmail.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, mst@redhat.com,
 junjie.cao@intel.com, dave@stgolabs.net, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: Add Anisa Su as a reviewer for CXL
Message-ID: <20260916035447.1ac74817@jic23-hlaptop>
In-Reply-To: <20260916002143.777233-1-anisa.su@samsung.com>
References: <20260916002143.777233-1-anisa.su@samsung.com>
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

On Wed, 16 Sep 2026 09:21:28 +0900
Anisa Su <anisa.su887@gmail.com> wrote:

> I contributed the FMAPI DCD mailbox command support in hw/cxl and also
> work on the Linux driver side, which is developed and tested against QEMU's
> CXL emulation, so I would like to be Cc'd on incoming CXL changes to help
> with review.
> 
> Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

Welcome on board Anisa!

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Having been more or less absent for too long I'm very happy to
go back to having more people sharing the work on this.

Particularly as if things go according to plan we have a bunch
of hardening work and missing feature support to add to get
this to a state where it can be the basis of emulation needed
for passing DCD supplied memory into VMs.

Let me take this opportunity to thank Junjie Cao and Michael
Tsrikin for moving things forward recently.

Jonathan



> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5bf895732c..14412a6b4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3334,6 +3334,7 @@ F: docs/devel/migration/CPR.rst
>  Compute Express Link
>  M: Jonathan Cameron <jic23@kernel.org>
>  R: Junjie Cao <junjie.cao@intel.com>
> +R: Anisa Su <anisa.su@samsung.com>
>  L: linux-cxl@vger.kernel.org
>  S: Supported
>  F: hw/cxl/
> 
> base-commit: 302c2f2df4d8b2eec81c38ee5d5b04e8e6e40d31


