Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0A8C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 22:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2bzf-0005TT-1j; Fri, 04 Sep 2026 18:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1x2bzT-0005OS-OW; Fri, 04 Sep 2026 18:02:32 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1x2byu-0005XM-NW; Fri, 04 Sep 2026 18:02:31 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 2B31EEC01FA;
 Fri,  4 Sep 2026 17:59:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 17:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1788559152; x=1788645552; bh=gk8xNbQHoI
 V7tRux+shsl6CB5kCKG+aXbxmphDCwsyE=; b=pGUlT/ejrmwcjBndbFpzdoRJaE
 JXMYPdmZnmUcVasHeiCU0Cbo5NHjC7rtvcB1p71A0JKBMNP/B/1aPCMiB6al5aqa
 6dAeuHtLKueV//TDC3eIZyP/Eui2ivEaQzZ3c0JnRsB1KM30YvwHlwlzMciDUZil
 AJPGEtlU9A20RhgezWDRjgdWnmfLV9/8b5lkLgD1Z8kQiZYb9YEY2pBJpdS033pV
 c95JjL6X7Ot+MwY+GtYRneoUGDeA1yjnAknPjiw114angBuFW4iDDzU0W7KZmpmi
 Axv4id/gkXY6EbfxRP9GaCDqrTfA/F+oZKgk5wYl3YdRKuSKEB0Y3F4Q9nMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1788559152; x=1788645552; bh=gk8xNbQHoIV7tRux+shsl6CB5kCKG+aXbxm
 phDCwsyE=; b=n7McXAJaapTOpNtkrOpWwMrXRhJ4CoIU+HSte5KRUZreGhu9x4e
 jYlEcAVi+EU+aswCyghu/EDJrWjjcIjkr57O4KcRP6ELQqZHw8Tc3tWJIgy6AuYF
 +QYEj7ynjz+Tfj5mUknN/l7rXcUKJhwvhk7inAQZp4cPeUWqC4mJBSnymlp9HkyF
 OdV+Mj8wHobu2VzbUDRnfdY7FK/tg52Di/tVZ/Yh0bPKVgEgkzYrSkcreOcCVJ4N
 RSh6a0aGqEbCrIyl1FnR6dQ90TtyFRgHVWoQtt9EmROCfxmdG3muyY39yB704niI
 rn9oWWDS7PZjtoIbj5VD2iym2y4oRmLuMBA==
X-ME-Sender: <xms:MD-bapyc3qD2w0T4WuFT2Sl5-0ShZJSJLm7w3KvLCvq6yUkCjsELJg>
 <xme:MD-bavRNTwAC_Cxpv9SdOssB09gc8V7rMrJC6AlMhyOLfNHMgcFKr3ELkPq9WOCdv
 MJts6uNVIYgw2MXRALYgYdIQdTBYj4LSheb6vcfPSu4aZqFCQuN3s2X>
X-ME-Received: <xmr:MD-bauLRfWqznfG__DnF92Y9R7Hg69EovTJ1zfxpJzgSXE2ZlHrd0Nv8KLlwOl3dbnDatkN_XPmf5rB9grPo>
X-ME-Proxy-Cause: dmFkZTEdF7WX6qAIs/a04DXuIWYzCRbeZGQ8NUHyutdXftzT23jOxtGNs74nJDQYfYXp6M
 wTJgvKzuFwci3HZbFmxJ+QwmKzLmJIRXdIWYRtSx0KCyyuY8VFTiaDpPIB3vTHDkv57REp
 AV0gkFeDRoQLSOxkH7KUm5RKShfrwkAqjNz7/giqoam97wcZqhIke5ZcEi3IsDcHDUq1fR
 lCPRlnqe32xHIz23VTVxgYomcFzlMpPrgWH+YLom/0DXw4MhQM8hRgrs9jutcRqHQsd0lA
 1HZTEB5GraRKhX+ESlBnVC8iB+nUjp4QWXefB++cK7vxYPORK4vqEqMC3rpzGa+imQferR
 o/k4clj4IXo4b41kNnNx/Z0zysLRCQEgZ9YcPq22KBbnmktF+S6qiK+RWiBSW1dWoxB31z
 YNqN2Jrgo7gwKSaEflikYQG2wOm5WUWESj8mBUtqH90Id+aRPR9dRCmdcu/MTYHLS+I/Vr
 s5Kw3mjBF7ZW5NlZxY4+pB0Rxgnie71GXJGv8dej6f+CRm6UP/7EFwWuSUq+f/pV94F5Jh
 C4hFNRQJ29xLYnRJg0uicS2+zXm6jAnRdQIuUoxC/dhQxkLTQDd96mhpq30OxUy0lOdLo0
 LhZC5ZegR5KesfbKaLUaug9XiwHQ7cd+6Egxn8e6uY8+zBvElS1AW8nApecQ
X-ME-Proxy: <xmx:MD-bauV57Zxd_GqinTrOKnPifb5L7HDDgU4yWXAeBrr_xkHBllLfJw>
 <xmx:MD-baqRmN6vkRLjZyKojVOjnDz5mCHo5P9mnwh-ipvMP0Td21Aef4w>
 <xmx:MD-bauCRduaoRjpdvl5Qph5CT-lI6A_Q0cCLBC1RVvBjNPuoa0jHgQ>
 <xmx:MD-bahKgWVnp4SGkywV2xuj746nQeqV9ysl37q3GwHBUv0inT2sJhg>
 <xmx:MD-barG_VKlx5yx5Vospkr3R2ju0vtaXex5YHuzhFQGvSGop0AaZZIXC>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:59:10 -0400 (EDT)
Date: Fri, 4 Sep 2026 23:59:09 +0200
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe Mathieu-Daudé <philmd@mailo.com>, Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org, Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH v2 6/7] hw/nvme: drop DMA-path IOV_MAX guard
Message-ID: <20260904235857.6-foss@defmacro.it>
In-Reply-To: <20260819-align-nvme-mdts-with-linux-v2-6-351ac2dfed64@samsung.com>
References: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
 <20260819-align-nvme-mdts-with-linux-v2-6-351ac2dfed64@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird
Received-SPF: pass client-ip=103.168.172.147; envelope-from=foss@defmacro.it;
 helo=fout-a4-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 2026-08-19T17:24:08+02:00, Daniel Gomez <da.gomez@kernel.org> wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
>
> dma_blk_cb() now chunks at IOV_MAX, so the per-mapping cap on sg->qsg
> in nvme_map_addr() is redundant. Drop it.
>
> Suggested-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  hw/nvme/ctrl.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index a24a674a4c5..7861d8f2521 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -872,10 +872,6 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, NvmeSg *sg, hwaddr addr, size_t len)
>          return NVME_INVALID_USE_OF_CMB | NVME_DNR;
>      }
>  
> -    if (sg->qsg.nsg + 1 > IOV_MAX) {
> -        goto max_mappings_exceeded;
> -    }
> -
>      qemu_sglist_add(&sg->qsg, addr, len);
>  
>      return NVME_SUCCESS;
>
> -- 
> 2.55.0
>
>
>
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>




