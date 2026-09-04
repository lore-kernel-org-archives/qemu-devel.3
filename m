Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3032BC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 22:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2bze-0005Sj-Dx; Fri, 04 Sep 2026 18:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1x2bzU-0005OV-LH; Fri, 04 Sep 2026 18:02:33 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1x2byv-0005Vj-5e; Fri, 04 Sep 2026 18:02:32 -0400
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 44E0B140011C;
 Fri,  4 Sep 2026 17:57:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Fri, 04 Sep 2026 17:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1788559077; x=1788645477; bh=JULn1pQ3g0
 16lP9KflhikXh1kelN4wh2Hr/FRZs/rLA=; b=Br8RXo1QPvTvPGqVCntRX4C6vK
 ETHRo2vibLjmqGfARXBmgZxeoCNto8JaR4IDsoCd9BgrgmT8NYZFCzuF6aEfXwqk
 E045trfbZIYf4LfSh/XiH9yVKp+PWeOijMdzEZgRA7XwNSP+MIJXQg6hG2TbPOPt
 4fwFy8iMAzrC4cmW57eS6YgIX132tHAghn+VRsfpixifbzKtGOfEbIJGu6jLffNQ
 9T1sdqnVpZsc/tTN7RAI4EbBYYCPFjFFh6y116OcYtUrjaEhjFZXSkFHbCeLy2v7
 XF7DJ2MZyQJh1fsDE8B+/7CJNFGEaffJcMid3vyX58SlUaSJ/fBdbdUdGbmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1788559077; x=1788645477; bh=JULn1pQ3g016lP9KflhikXh1kelN4wh2Hr/
 FRZs/rLA=; b=wsHoNtisGwB7XKEIpFYyyWGk9hghdx1F/h+YsaBLo6xpNINmvHC
 H67wfCKZ9yC9yPk06BKvCOqJY+BZ49aAKBctN/YAVq0i1bo9N/OXgVt09b3p/kMA
 Mz+ndcHCps+wBsunQjHB/yrRQc8T3h8tnXIvHj2JSUr+I7uY3iwpsScDUCGNrhvX
 R1KDslQJujz50PrhasFdmf3qwPRRbOBcQ+JpUzjn3ctoK/xRFMD5YbSD0Xios4nS
 fhk/uS7AORfsLE+R5sGpDl7emorIRgzQdIk6/BaULWmHBxkoNZ0Js15M4AqGGgfD
 +uNavPuTylzK0WOHYaKuS7F0kGR2Dol0DDQ==
X-ME-Sender: <xms:5D6bal4Z2Jy1wsxzwVAvcnP44tcMOmFEHJsa9trkwMCa_qnPfPIdpw>
 <xme:5D6bao64d65W8nzxmVidrZ_sON4qkSnmE6XWcOzICX_EIApydEoYJjv5eVoHQy-99
 Tw3octR28gtbR-6iN7iGvpMooJ322KNe88AIo8HFRhNe2Kr0t8H-X0b>
X-ME-Received: <xmr:5D6banSRcbN9rI6jjKMO5eP5b3jNY31I9A08c6uEohgfdcjJleoal5_OgryFGg0MvNNIN_RADpCCQnE6vxN->
X-ME-Proxy-Cause: dmFkZTGnpJEDpAUDyEWGnYqjIyIctXAAWSEzrFPeYeX9PLC/nLkOOh22zNFBpTK6J7aV8b
 1q2ruumK1Gk3GygC2p19mCDFRSfgwEJ0ZoV4/33hNMaCyNUW8xCEyDubh92h8jLAkOL+tu
 M51sCYXGkB98/MbFJPe8hErgMpXNaNfBTdGgA2XrVZgU+WxchghhLvE4LQ11xWnUdzH1rY
 OnGUpt3CZoTmKqSS4ER++MxIPrfYHaY3d4kkipgq/mEXmRRV0BYRim4kAzJPNp8sRfraKv
 6PZUI2xiA03Vgr0DgW8lWcMHSpIMjL7EQwlAJozgd2A7hwWRl4gC3NG3LX+6lb1fysJqTy
 e6CN0jhMC5z5QAWXXvQU8Tc58G3ukIryFLdclxb63nWxUNaryMI4LLRWNLqmdD8j8hAaLS
 yaZ9rFdIB5UtDiOTmrJjh7QSmnAxqnh+P51eOwkrPn/zb3136gNO4iQGRoVVDaPvrSGa68
 4ffoQxqp3JXqA48j5gKzaSW7Sf521RAyECQmwnKIRR9da1VUUuH9hp9XxkRYW1/e8UnKnh
 2ejaC8urFGA+TwBZnI7p8Z2mV7lXjlVIpYrlMxBRgvuDLNASTeiR6MCQl2zZFSttlWw+zB
 4eIteyUssuDFebWOp0htQgs8dAvCnb2EhOYcdjhRexY7/k44ZViwouMhurDg
X-ME-Proxy: <xmx:5D6bag83a-FVQKWmvRjy1d5W7QQEGN2ZhOa6_4usiOV-oz2JoP0brQ>
 <xmx:5D6baoatbJvj5_t05bsCu3yH0OQXY16usvp6BkCJp7351wa6ObDs4g>
 <xmx:5D6bahrMLF_Jyv4aRtv6tRDC4iFl7ToHMZY_gLzJpvaC0-DZhzr_bg>
 <xmx:5D6basSGuHA4Hfhb6LaAAT2HDJle3VypoQMKvccAB9eN-wNpRSvoIg>
 <xmx:5T6battq63itaeH9_BPAN2qeYGra2l-dqieR8grIRS4Y28AbXkjhVAA_>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:57:55 -0400 (EDT)
Date: Fri, 4 Sep 2026 23:57:53 +0200
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe Mathieu-Daudé <philmd@mailo.com>, Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org, Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH v2 3/7] dma-helpers: cap iovec allocation at IOV_MAX
Message-ID: <20260904235729.3-foss@defmacro.it>
In-Reply-To: <20260819-align-nvme-mdts-with-linux-v2-3-351ac2dfed64@samsung.com>
References: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
 <20260819-align-nvme-mdts-with-linux-v2-3-351ac2dfed64@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird
Received-SPF: pass client-ip=103.168.172.158; envelope-from=foss@defmacro.it;
 helo=fhigh-a7-smtp.messagingengine.com
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



On 2026-08-19T17:24:05+02:00, Daniel Gomez <da.gomez@kernel.org> wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
>
> Cap the initial iovec allocation at IOV_MAX instead of sizing it for the
> whole sg list, which over-allocates for large IO where the number of sg
> entries exceeds IOV_MAX.
>
> This is preparatory work for chunking dma_blk_cb() at IOV_MAX to batch
> large IO: once chunked, dbs->iov never holds more than IOV_MAX iovecs.
>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  system/dma-helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/system/dma-helpers.c b/system/dma-helpers.c
> index 9004ad50ae3..d4fd33a3d4c 100644
> --- a/system/dma-helpers.c
> +++ b/system/dma-helpers.c
> @@ -242,7 +242,7 @@ BlockAIOCB *dma_blk_io(
>      dbs->io_func = io_func;
>      dbs->io_func_opaque = io_func_opaque;
>      dbs->bh = NULL;
> -    qemu_iovec_init(&dbs->iov, sg->nsg);
> +    qemu_iovec_init(&dbs->iov, MIN(sg->nsg, IOV_MAX));
>      dma_blk_cb(dbs, 0);
>      return &dbs->common;
>  }
>
> -- 
> 2.55.0
>
>
>
Sensible, given the next patch in the series.

Acked-by: Jesper Wendel Devantier <foss@defmacro.it>




