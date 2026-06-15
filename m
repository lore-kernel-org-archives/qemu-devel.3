Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B2DCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ3Fa-0008Mm-6K; Mon, 15 Jun 2026 05:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wZ3FZ-0008MV-6B; Mon, 15 Jun 2026 05:04:57 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wZ3FX-0007JP-ML; Mon, 15 Jun 2026 05:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=/KyJnBTQqlFv7GxUAny/E8BiXNeKtz2qjURNadVFz/M=; b=GX1ZJ9AuDUqucCeJLTeBN7x6vs
 M27qQfFue3sea0iFbB/dGUhgEK7LmvZxc+6axNm2Tu/SUlGGLePdENOoz7gysG/6GbhLVd+Uwi5TA
 L1tPX/5VDOQYy//jA3VhFUJ/Qswzxgl3FISVAcDzsirD2SrHNtki81BRkNG5MBSfFE9qO8iqAtNib
 kMS9pUo1kXjFjA+Wa/Mu3oaTcUolh8/N5YLRGr3mqFLjE97zOUKslTjZzKTCaVlH1K7SDG3NRCfXs
 bg/G23q5LN1KXzO/Cp6AiHjGWBjAFLTWylliXC52yOBMxtPplb2Y+bX0/UKrjzB1S5dhU7/caCNcf
 2n1ij+5UJ9twkpv+EzDmjJwqvmeC6J1LAG+pvxRwdsJKmuDwmef5I6LKT7S52liZnt2FIy2yzAPu+
 K/jHxEqy6K9YuhRDL+qxlDtxIrFaIkqewUivuYlgurE9UWb1cDoWQsHxYKUvs4OwZdBYRY49cdv5p
 V7PyPI1FxMIhFczTfi2o5G5dv8BWmhT2UfdLc6L/CuihpdnbCsxP1uhlU5WNj+4yskmGytvK/SLVW
 glH/kZXZBTIcivfp5nCDOMiy4aygy/WfaNx9vnb7SS3mYmgaj/43tGh7I1i6MD3StQMlv5p84NNrS
 V3h8Njg8oKzoVvuqb1VmRKM40ObrXO4fZc8gBX2Ds=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH 0/3] 9pfs: fix illegal names with Twstat rename
Date: Mon, 15 Jun 2026 11:04:50 +0200
Message-ID: <2835535.mvXUDI8C0e@weasel>
In-Reply-To: <cover.1780072238.git.qemu_oss@crudebyte.com>
References: <cover.1780072238.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, 29 May 2026 18:30:38 CEST Christian Schoenebeck wrote:
> This series fixes a guest-triggerable assertion fault (DoS) caused by
> sending an illegal new name with the legacy Twstat rename handler.
> 
>  - Patch 1: This is the core fix that prevents the DoS vulnerability.
> 
>  - Patch 2: Additionally rejects "." and ".." as new names with Twstat
>    rename operations (not being a vulnerability though).
> 
>  - Patch 3: Consolidates the name validation logic spread multiple
>    times over multiple request handlers.
> 
> Christian Schoenebeck (3):
>   hw/9pfs: fix abort due to illegal name with Twstat rename
>   hw/9pfs: reject . and .. in Twstat rename
>   hw/9pfs: consolidate name validation with check_name()
> 
>  hw/9pfs/9p.c | 97 +++++++++++++++++++++++-----------------------------
>  1 file changed, 42 insertions(+), 55 deletions(-)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



