Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587CEC79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 22:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2bzf-0005Ti-JJ; Fri, 04 Sep 2026 18:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1x2bzd-0005S5-Bs; Fri, 04 Sep 2026 18:02:41 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1x2bzR-00064h-DT; Fri, 04 Sep 2026 18:02:40 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id B476FEC021E;
 Fri,  4 Sep 2026 18:02:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 04 Sep 2026 18:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1788559346; x=1788645746; bh=aGoiGLyK/h
 WyQAVDuFzgVKHoVlpkB0cLwxNABP3GZWM=; b=eJ7N2ryG4V3jlaYaJJ/JTUvqQE
 Unue83G9P3iEZXQV408nBrYo3NbjyUjcPYYV+6ImqROiRAwRjSoy4Fb3o/XnF7xi
 JxaLOQhNNyk7gi8Qlf53bKlXYVHhvZRkVGgdlngfz/cn5OCJNty0Ck3XziTc/2/r
 E99xZHwe225IDrkAfBFaitIOQOhpLvOP8Rfn+h0PKGK3A+004yOOGGnH4kBzY1wc
 kFDyynXY65c5rlaxKLj1nLHcwKGagMJ0oKecQOrPRJncVfeysHjdXqg73s8o2ZEz
 pw46bLs47qjNBKNPrVrLFDKwNoZCUjbJAL8LJkSvtb+gg0q38RFYP9eP3O6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1788559346; x=1788645746; bh=aGoiGLyK/hWyQAVDuFzgVKHoVlpkB0cLwxN
 ABP3GZWM=; b=faYN9Px571qPyNCUPrc+BAOQBqxLQpV07qQaTN2uANLHp9J2NJi
 AWyzshkbXubZmr7pyI8yQCbqo9O5m7FO3VMyGzNLZHwZEgvem/qycUB1Not3Mjd8
 XmoRXeJcMRYXL8Mk5rdQFiYRSTRwj9jK+YV2gDijsOiOG5gZWJ+HSGHPfEnSw84T
 hM/F97lCJ0zfkxIvhAbAxCI3gwvSfl7rM79PTj6WpvEfsb9qTww1edH48HIEuRTD
 JeBsT9EEc0cjjKWGF1ss4eU98Qa+/mEpAy07mllhG9z7d/lN5hSYPVGT1GjCtW/U
 SnCaSjh2AbXwTNcGSPEqXpTfuocRd9DtsYQ==
X-ME-Sender: <xms:8T-basN4d_P5rUFaUiHDjKhp-LGBQkf_EPzY5KeoeVYR7FtAyDEFFA>
 <xme:8T-bao8UJEebwCIby0dus8wSN6eA-CaTGpI58M_mV9JdhB_Ft57O6gizwV6i-lcaO
 nYGEM_x9a-LrOvGCrqTrT_5o5V7YqspO-xi0k1Zk5XSfb24NGPnX9_f>
X-ME-Received: <xmr:8T-bauGjaT6opMDDwpQNK7yOxIOjgRnaNQAlrJLPvvf8UhwdbLY8qx7G5lEFEOQd0wcj8qae4DZ8yhAVY4qw>
X-ME-Proxy-Cause: dmFkZTGKx6LcTYJU85B0c3u9Sy3JbKedjQQ6b/xZ1xDaeHcJ+NQVKCCh2OZSw9FAzexe8f
 SOGuZcOucvs85rwZDP6oidIxzvha6bZzJAb3XOdUxBYVxaaomumPmqgSA5p25y9h9466sk
 KAMI05ztFjlqc2XZ/j8h3NWYJRkeU0BDwfa7j9v7KuTwwhVbGNFkkb2BLxumJZK3FtmZb7
 m1U5wIemAXLH9V573yso9XLhLozi5A3doFoKz5BHY9hADNZ0DZksNdd9PZeWAxkqgEBWF8
 Cm3g9NFddG7MQMUMnc7kYIo++4mUR0AsquuTVkmaqdbCbba/5pZLkA0oPca7MzYOonDktZ
 5lwN1GS5b2YUtKXxWO7GwsHR1QS+NIQsmVo4V/OoYFFy9qse/2KXkTPzYAiPC3Kp0OqsPG
 xn58xLe0IOKt5rEy2fGENDx6C6rPFcvAfYUL0l0VIF+fvIsUknzRRHelU11ywsxKQ3/7/H
 8n2dkcLTld1E2q7o6pXvosDnWbgpoKjR8P5z79oGbLS8GClBsq5c7VnmEknE3XXUUBoeet
 FaD+jNgwqOisb6HWN6I6Uy+lStGe5iJqyV4izyu9Np/jfeZtVHvhw/90z/SB/0VH+WkKHm
 1nNSbtVgybQ1csoQlEl+5q/EUTkk9e/m4hhCuTgIMnaqMsOYe/nvvsfr4vAg
X-ME-Proxy: <xmx:8T-banj9FHC509-auDeWl7ZbnTQDXvwSzz2_a1ZvDES3ULlaxKbY6w>
 <xmx:8T-bajt-xNjUji-1iHmUx1-DL7YEc-A-9AEWsnTzdw8U6KMmoFkwkg>
 <xmx:8T-baitH77-2zCGBX8UtQpTlkFZFYm5gw7urV3FIBn8tBEa7ptJdSA>
 <xmx:8T-bagEzxI8ySagl4EfWhTM8uZAkuFSc_kpKq_ewuiOdu4l9CaDqAQ>
 <xmx:8j-bagy27sEZwPyletWyT9WYL_9cq_DX4195KeTK5r9LPxN34M2iYk4w>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 18:02:24 -0400 (EDT)
Date: Sat, 5 Sep 2026 00:02:22 +0200
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe Mathieu-Daudé <philmd@mailo.com>, Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org, Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH v2 7/7] hw/nvme: cap mdts for CMB/PMR-only
Message-ID: <20260904235915.7-foss@defmacro.it>
In-Reply-To: <20260819-align-nvme-mdts-with-linux-v2-7-351ac2dfed64@samsung.com>
References: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
 <20260819-align-nvme-mdts-with-linux-v2-7-351ac2dfed64@samsung.com>
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



On 2026-08-19T17:24:09+02:00, Daniel Gomez <da.gomez@kernel.org> wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
>
> Commit 53493c1f83 ("hw/nvme: cap MDTS value for internal limitation")
> capped MDTS so the worst-case PRP count would fit in IOV_MAX, leaving
> transfers limited to 2 MiB.
>
> Now that dma_blk_cb() can batch IOs up to IOV_MAX instead of limiting
> to IOV_MAX, remove it, except for CMB/PMR-only where the limit still
> applies.
>
> In addition, fix UB when mdts >= 31 by dropping the shift and making the
> cap explicit. Fixes error with ubsan:
>     ../hw/nvme/ctrl.c:8638:33: runtime error: shift exponent 32 is too
>     large for 32-bit type 'int'
>
> Suggested-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  hw/nvme/ctrl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 7861d8f2521..ff7e4a055b8 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8802,8 +8802,10 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
>          host_memory_backend_set_mapped(n->pmr.dev, true);
>      }
>  
> -    if (!n->params.mdts || ((1 << n->params.mdts) + 1) > IOV_MAX) {
> -        error_setg(errp, "mdts exceeds IOV_MAX");
> +    /* 2^mdts + 1 must fit IOV_MAX */
> +    if ((n->params.cmb_size_mb || n->pmr.dev) &&
> +        (!n->params.mdts || (params->mdts > 9))) {
> +        error_setg(errp, "mdts=%u is incompatible with CMB/PMR", params->mdts);
>          return false;
>      }
>  
>
> -- 
> 2.55.0
>
>
>

I generally agree except for a single nit-pick, if you will permit me.

(params->mdts > 9) -- it seems a bit indirect and could break if,
for some reason, IOV_MAX is different.

 ```c
   static inline uint64_t nvme_mdts_max_iovs(uint8_t mdts)
   {
       return mdts >= 64 ? UINT64_MAX : (1ULL << mdts) + 1;
   }
 ```

 Then the check becomes
 ```c
   if ((params->cmb_size_mb || n->pmr.dev) &&
       (!params->mdts || nvme_mdts_max_iovs(params->mdts) > IOV_MAX)) {
       error_setg(errp, "mdts=%u is incompatible with CMB/PMR", params->mdts);
       return false;
   }
 ```

?



