Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A98D75E34
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 19:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFIVp-0004t7-Ka; Sun, 24 Nov 2024 14:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFIVn-0004su-Gn; Sun, 24 Nov 2024 14:43:15 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFIVm-00051E-9q; Sun, 24 Nov 2024 14:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Cyttboq5yaKfwNLRCDTvOUZaG/n6XgJW55BT1uTHTHY=; b=uLdLwxeYqLBfKaTLe25xbAL7x/
 PXmQ5WpRxArTJKf5nK1F45HD+Au7Ncsafj3MG2RGy2HLS/9Dib9PDIDMUkEeLFfY+/ue4/4+dBr9z
 sOqKkpWPxgMREYwa7qI5evnsKMa19bUpBXsfNOEIwFbQdqiJ/PmnbidsGM41YwCpuW2K6zeM3NpL3
 Mg+MRsb8628iY88fBL22Spb7JC7O552dCMbLuBo9Sp6j6Bl6m9cFh5nlrTkzfO31YUySG85R3+4fa
 P6XeluWWsqMmmgVX8PbT4WAbeqsL848n/WchBJ3pXDQV8SF6eW8FQajX1xqRjKy1Zyz2r2Z84KbqO
 fmQb7318OJ3CFgyua4dN0qs17Iu5BX/Fb4dtNSJJNOLDGL6UwlDmVP1Gp3e9DkOtwRtt/pxH0L4lB
 FYc6lZby1nnnk0x5W++RAiXbB8lO3A8jEqrqPW84IrlBuRh77WmnkgMZ6wwStFH5hMAQ8KQPqKul6
 6s/Cw6n4+sFmkzf6yOePMR/YhyUIo/79CFzpUoBM8ufJdKLJA+15i58kKivRcpkZAp7riCNdZvtvu
 BoE9xiU63QSXaqz4yBevZGHJyQjD963rMzJbhMCJBd032j9pjjkDFh/RDl/pd8q7pYQqMV7UZ/alB
 uGdkT1CmS7V5x1U3MnRLnwhBa/ShSTvX43zU/riWg=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 4/6] 9pfs: remove obsolete comment in v9fs_getattr()
Date: Sun, 24 Nov 2024 20:43:12 +0100
Message-ID: <2650498.nBfJRbF7cO@silver>
In-Reply-To: <fb364d12045217a4c6ccd0dd6368103ddb80698b.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <fb364d12045217a4c6ccd0dd6368103ddb80698b.1732465720.git.qemu_oss@crudebyte.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sunday, November 24, 2024 4:06:40 PM CET Christian Schoenebeck wrote:
> The comment claims that we'd only support basic Tgetattr fields. This is
> no longer true, so remove this comment.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Fixes: e06a765efbe3 ('hw/9pfs: Add st_gen support in getattr reply')

>  hw/9pfs/9p.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 9a291d1b51..851e36b9a1 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1596,10 +1596,6 @@ static void coroutine_fn v9fs_getattr(void *opaque)
>          retval = -ENOENT;
>          goto out_nofid;
>      }
> -    /*
> -     * Currently we only support BASIC fields in stat, so there is no
> -     * need to look at request_mask.
> -     */
>      retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
>      if (retval < 0) {
>          goto out;
> 




