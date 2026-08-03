Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73310C55196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 19:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqyCQ-0005Sn-7H; Mon, 03 Aug 2026 15:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1wqyCJ-0005S8-UC; Mon, 03 Aug 2026 15:19:40 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1wqyCH-0002Z9-9K; Mon, 03 Aug 2026 15:19:39 -0400
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 8F7081D000CF;
 Mon,  3 Aug 2026 15:19:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 03 Aug 2026 15:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1785784771; x=1785871171; bh=Bvf/HcXrKf
 REddMnbxJsjJNdEpB04UbsDUV2EVkrMvE=; b=Q1dtj0DR3ig+cdptCOmqeVc3dH
 Ati15NT3Q7UDnGu4cN/gqkmZN9KXOVJ4rJzYFLPr9tuVJbgJ9QQ8E2vrmfF1059V
 6SxWp+y/JVJz6ClE7u7Ar/SKkauYuMFkhHo4+BuJvTTyZXPLOIlseth7Jxq0OhT7
 QIHjfavNCAKzFBd/U7C7OmDh87ad3kp+FeQAB3RyH+FWNGNKIZmU2KagQhpmMBMg
 uq4kzj+Hf2JIXnyTMCBv6AR7BZP2vLwZk7fnKm5cToniquBF3PULfwrZ0dfhTUSn
 V3v+pBvdxjS1dQGZVURS+peQrd4BeaqL4WoCVI9UKlbA3aWJi3RJc7ZSv46w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1785784771; x=1785871171; bh=Bvf/HcXrKfREddMnbxJsjJNdEpB04UbsDUV
 2EVkrMvE=; b=N+Nj+3Q31E5ivW5nslyAePyPYL4YtyMpwSlgAoHy+jIwmLhzf/g
 3UmdHXjl6l0Aq1+Tv7t8R937w4qirP9G6D6CPO8mcjGmUtIFLiKxFOwWsK3mv7Bh
 iOxRIfurFhHtWiCraciTOI+yqvT0uieQLiHYAOIAe7zVEqNL6aIJImgFgSY/VMTw
 rkrYzV+WIKiNgFlVs5jcuAhjD6eSltf3QCbeJyYiO9VleHBqgvQHp356XDw66Yd+
 09j5nZ7HdHsaChC2cIPK4soL1VMzKUQHFH4QP4I72teeN2pWp1c4Kyo1XoackuFe
 DGbUmmyudR8DJX9sJ6jblPCXj1fF82fzcOw==
X-ME-Sender: <xms:wulwahro7aTrFJK6Tvask0J0L49dvC5UpnlPcPXvd5UD37JulL-wdA>
 <xme:wulwasmIx38uyowFLPGtqE8sjIyhfdaCGm0XPmcK6Uiy6Bz9uTA20zVTj7oFvKjop
 2qAXOX7jhrShbBDDGU6y_nlh_-UjoUxYizVL-wTz02M8EuPCVWPKVOM>
X-ME-Received: <xmr:wulwapwbX2q-TD2yzSHJVrP-2jtRvTQI7hEGRoVHfsKGQxQlun9RVdqGqH2zHW0IBtLBfwYcX4ocUnvvZ9Vt>
X-ME-Proxy-Cause: dmFkZTE2xIgYhENYam9QVAqJIHMz/l7bLwUg0TjCZCr1Cg2C8sKcrEp95UVEj3s5oXVFnw
 566DINAkpNBZ6QCb6T2AHlwFg4xRlkutpLyEbxiCABuWGgZ6RQHTjTj8XPkKGYv2+npSfC
 1cJQfsrkkmzePm5VNR2f7VYpt5hcisUY7NcLqgcnhb1eWbwEnvMHB/FjwPDTarAPIoCNZb
 3kh40w5JEM2P/rfEiNNy4/dcpH0MkSpQOzWr4SVHwf4grNhNUylV4JKCc0Am+FEnV2hOss
 lHq5dNHZI33k/KedHpmEBDHnNOqI03+QmH+2WqASInWuTLIMCAT/IbgHZGkJkkE62u46uA
 VZFz0mPoZphAdz88YNTKXcVVXBpLiOedQQZtM33uvmJaB7fKC7f0s/274jqRg+TXIDs+lj
 SKSkxwLaBTdCWJ3Bfii6LyRqNFgLAxlp5Mcdy5Rh007euNajuDrZDeSTmrpCiMHvg/bpAZ
 5VekRgSXiMZGqVoPw2ccL24v+vIv3f84VIW2jUq433ItvDsrC0pX1xhkOnmJ4mTF4iYanI
 CzfQNw1syPQYUwm5Y17OE8MebjPGFKN7NoLJZdfbvB/1k0Drm2/r1cI7UjGlaIfG0lkEnB
 EhraZhMiOK+ZTsmMtSBPqkH/npfgflfNAGh/iA7yK5oRqKfVDSp631lO33bw
X-ME-Proxy: <xmx:wulwas8qjnC8Qpt2-EUN_WdpKtpQ6LylT5erI5d2OyOm6865dZajNQ>
 <xmx:wulwatKOleh_p3oKxc0qClQBb6lA0ahoxx-z3Gq6CkryA25mTk2GJA>
 <xmx:wulwaifrgw-RDwv2r3SJd-PUqqWN6YhIfQn9jICKUjTjg9-tyCQEDw>
 <xmx:wulwas_42SDcvg4qYhgEc5s6BWYi3THpr-G1wj4r9rBHreuEvx-sIQ>
 <xmx:w-lwaiNopEuiZ8aXXnD01qI_vY60bifXNZJk9O7FNFaoJgcLRIeLqeaL>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 15:19:29 -0400 (EDT)
Date: Mon, 03 Aug 2026 19:19:30 +0000
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/nvme: fix leak on copy ranges
Message-ID: <20260803211755.2-foss@defmacro.it>
In-Reply-To: 20260731-fix-copy-ranges-leak-v1-1-a344434c9925@samsung.com
References: 20260731-fix-copy-ranges-leak-v1-1-a344434c9925@samsung.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird
X-OriginalDate: 
Received-SPF: pass client-ip=202.12.124.149; envelope-from=foss@defmacro.it;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



On 2026-07-31T11:26:53+02:00, Klaus Jensen <its@irrelevant.dk> wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> The buffer holding the ranges for the copy command is not correctly
> deallocated.
>
> Fix this.
>
> Cc: qemu-stable@nongnu.org
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4072
> Fixes: 796d20681d9b ("hw/nvme: reimplement the copy command to allow aio cancellation")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index bd6ad64b2000..aa98f7cf8048 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -2811,6 +2811,7 @@ static void nvme_copy_done(NvmeCopyAIOCB *iocb)
>  
>      qemu_iovec_destroy(&iocb->iov);
>      g_free(iocb->bounce);
> +    g_free(iocb->ranges);
>  
>      if (iocb->ret < 0) {
>          block_acct_failed(stats, &iocb->acct.read);
>
> ---
> base-commit: 0345ef676befc1a180d2f63bceaf3fca1d07ee88
> change-id: 20260731-fix-copy-ranges-leak-06242c584712
>
> Best regards,
> -- 
> Klaus Jensen <k.jensen@samsung.com>
>
>
>
From reading the routines operating on NvmeCopyAIOCB, this seems correct.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>



