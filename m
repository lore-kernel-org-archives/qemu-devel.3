Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9907DC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 14:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdVXc-0008WU-6q; Thu, 30 Jan 2025 09:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tdVXa-0008WH-4v
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 09:29:10 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tdVXY-0000uR-M0
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 09:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=RZpZFRacvk+wuB2BduunAiB79c6EmWBembpb/uRTqjA=; b=g+Lgrw6fR9KpDp583JjOmHaW4g
 /ub1b/D5PM7F2/m5eNvqF19OvkjNGgxYAM9RQAhAfKZWsmWdFOT3y1RODWPs7SaffTLNLws71syes
 3CCddI+++RMHfdTxSc+ZyiNZFiHJ1YdstxQg8VQtej1EltfiP695/nzwD9dZk559AWMuLcvI05jtb
 UzzCEwNZo42WMhrxt+P7AShuaMZhahkxMrKvAcW2xLitE5hUDIbxE/9BAeVIcaHwL9bmNUniNK4zV
 uvohjKbigW4PRnSYvBCSqBuEvpXiUxtc7WaMsP4JuSmEy+56dENZ/7ebY0Du1KnthsfjoogprJEFJ
 17aNiF4UakxTS+ip4ccgIzaaObA+rd8YwGUkN16qiT7F2IfdOYHtVv8digXTVbQLsy5nwaT3HhQLf
 1wWULWd8DTVVUYqdQUrZfjM4Dfn7gUYy8e0gem43dhGM+TTzszbZPPVDRgJSub7cQFFG4dsLhhDYk
 v3Ji0rqUx6JYR2s0NYo+mBhZng++wYVBstM+sT8hfXUeTvhOaj5GbzdeMypjj8lF8wbClxGeyyVir
 co4KxIpk9jJAd0LlDKoO19GGwpjQoufWWVrF5Cc/OGH1rEhgJFodSM0wvArTFgLJUSGySkbM2mgVn
 vkvlzBp+rpDym6TCyKpO1G5hlYINFRZzPi+NyuskE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] MAINTAINERS: Mark me as reviewer only for 9pfs
Date: Thu, 30 Jan 2025 15:29:06 +0100
Message-ID: <7125417.0ZvzNyXQmR@silver>
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
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!
/Christian



