Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0A2C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 11:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY1wZ-0001LR-Rr; Wed, 15 Jan 2025 06:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tY1wX-0001L1-DW
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 06:52:17 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tY1wV-0006q4-3C
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 06:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=tdEKNST16Ra+fFytOD0L3Gdtdej3gxaxuycjbwS7RRk=; b=X7PfNbEzAzq5NDtOVWLs5Z1n/c
 XugPbpo/mM3apYnGqbYXOciyrB4ibnn7O3Ns7SfY2+bmUkyzTp9A/wPwqtGq+99P57CWH4znzMWJV
 S86/sjA+2xGsA/L/RVxlO/hyWkQJsES/x+yL/ghPVrjN8ESlmuxOxnRkwOp66Tcxn1UZJxgI2PTzu
 kgiw2mhE/Diiw/IEhGh27woeaOxeMG77H37GvduY8C+eDJb1s3T2xLrCGmvqUPhST+B3/zy244hVQ
 3/Tz2gxdLW8bKiGx7i5XzFJfH3gOvtM1LMWJHvBh+aJ09FGElB0ODCyLH5kzj9AUeYpHjE2S1GD6i
 QQFX6BYoa2/9gkdmUvtKn6lNb/mNRww3M8ua2KJihaz5DWJt9LxEHfPM7uK41pAVCUbMniV6TjWfa
 NcH2zSURU5OAnnhSfQPiJy5wbq7lIhhs1GkET0dZzPsLMRfCwGDk7J3LvwPkYanpCf91nr4A/Qw9e
 BDcdrlUY6qgESAj8hOw5Ea32rE4Uupn2ZQn3ql7R/SBIOCiQO5cVflgEM2Tr+GzrDPfwZHdmgLKsQ
 e34wNsquL9wBDdcDHAAXBq8Nhmrwd3gCHrFmm4SPeMe5vzltcUE1AKk+QMxx3i6yDx+NnBFKwV20J
 nBr75lkMX/xZywoUoQFbvpEssfji4H8wyzoDkJ8lU=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] MAINTAINERS: Mark me as reviewer only for 9pfs
Date: Wed, 15 Jan 2025 12:52:07 +0100
Message-ID: <1993364.ETTWUh3B5s@silver>
In-Reply-To: <20250115100849.259612-1-groug@kaod.org>
References: <20250115100849.259612-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wednesday, January 15, 2025 11:08:49 AM CET Greg Kurz wrote:
> I still review 9pfs changes from time to time but I'm definitely
> not able to do actual maintainer work. Drop my tree on the way
> as I'll obviously not use it anymore, and it has been left
> untouched since May 2020.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

Even though foreseeable, I still acknowledge your step with regret:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Thanks for all your work over the years!

I try to continue your work on 9pfs as far as possible. Let's see how this
evolves, being the last one (somewhat) active on 9pfs.

/Christian

>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8b9d9a7cacbb..adc93ac0f4b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2248,8 +2248,8 @@ F: include/system/balloon.h
>  F: tests/qtest/virtio-balloon-test.c
>  
>  virtio-9p
> -M: Greg Kurz <groug@kaod.org>
>  M: Christian Schoenebeck <qemu_oss@crudebyte.com>
> +R: Greg Kurz <groug@kaod.org>
>  S: Maintained
>  W: https://wiki.qemu.org/Documentation/9p
>  F: hw/9pfs/
> @@ -2257,7 +2257,6 @@ X: hw/9pfs/xen-9p*
>  F: fsdev/
>  F: tests/qtest/virtio-9p-test.c
>  F: tests/qtest/libqos/virtio-9p*
> -T: git https://gitlab.com/gkurz/qemu.git 9p-next
>  T: git https://github.com/cschoenebeck/qemu.git 9p.next
>  
>  virtio-blk
> 



