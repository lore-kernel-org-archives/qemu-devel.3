Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAD3C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 14:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uScYk-0003Te-Ib; Fri, 20 Jun 2025 10:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uScYh-0003TB-Vz
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:17:36 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uScYe-0006zt-Ob
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=fzbOJScgmCiW0uPmyQPiyILV0W5an2tu/+dXt27qHQI=; b=MMUB+SlRDoSP+9oO02DRtHUU6m
 dyEokyEq4LfSpVclWs4WzHxKJ4XhlvC2XPWd9Jo4MBuAFHrpD0rFgNp7jZIlh58GibqKWniFSmwc9
 lnY8Kg7LPLXQbCtLoOg99Jvw7k/nX+MPq4+CZzYEQxH78gxGY1M9Qh/R99dF0M5uUxVOyvaljunq0
 XgBEOnFSEm951uI7qxzxNVvl1TDb8U8whYVwjLSF3cpy2zb2KHeZn29YrvVpvp/tcxWoWc10lKHkm
 VRDqwyHXgcCJIyZRBv0bMu82wd0bBYdFrGpaYToUFv66CgLSwpfNGLhnQW1ZfUjoR92tfyEueiSmB
 TT9NAYJQ1Jt89AvWfYXaplr2kuXU9uezjZjZv3ZnMSkFmjW4/wR5LdtRz542bl9RA8LjW1tvpI3aZ
 ijsyYnSsVcTqrlszd0u5wTqFjHA6NZfU/Vup0xTWHJPiRFeCgMmWhgkGTlz3FQArcIlMgd6FRnYgD
 HipFg6jI7AGPBKsYfu+DkLVycUtKwOwFxoCrhnIRXw0Sf651O7GTR7s8MTMZ8yyBGNwEEsEyvXyf1
 w3OQw1ciLQeyKZLqbRKZkwRj8Wr17E0iwvIxXgG/NcdqFwk2k+2kpidijMsjsN205l75LNMc8NuHo
 VsefMmiD/nTcTcl25siZeQKbfNNDi4fq7Ta9swAss=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, Greg Kurz <groug@kaod.org>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/2] virtio-9p: move G_GNUC_PRINTF to header
Date: Fri, 20 Jun 2025 16:17:28 +0200
Message-ID: <2211604.2JEinP4xG6@silver>
In-Reply-To: <20250613.qemu.9p@sean.taipei>
References: <20250613.qemu.9p@sean.taipei>
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

On Saturday, June 14, 2025 4:07:40 AM CEST Sean Wei wrote:
> v9fs_string_sprintf() and v9fs_path_sprintf() already have
> G_GNUC_PRINTF annotations in their own *.c files, but the
> prototypes in the corresponding headers lack them.  When another
> translation unit includes only the header, -Wformat can no longer
> validate the argument list.
> 
> This series relocates the annotations to fsdev/9p-marshal.h and
> hw/9pfs/9p.h, then drops the now-redundant annotations in
> the *.c files.  There is no functional change.
> 
> I've checked all call sites for these two helper function, all
> of them already passes the correct number of arguments.
> 
> A minimal PoC (sent as the next mail in the thread) demo how
> G_GNUC_PRINTF behaves differently when the attribute is present
> only in code.c or code.h file.
> 
> --
> 
> Sean Wei (3):
>   fsdev/9p-marshal: move G_GNUC_PRINTF to header
>   hw/9pfs: move G_GNUC_PRINTF to header
> 
>  fsdev/9p-marshal.c |  3 +--
>  fsdev/9p-marshal.h |  2 +-
>  hw/9pfs/9p.c       |  3 +--
>  hw/9pfs/9p.h       |  2 +-
>  4 files changed, 4 insertions(+), 6 deletions(-)
> 
>

With code style fix queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Please run scripts/checkpatch.pl next time.

Thanks!

/Christian



