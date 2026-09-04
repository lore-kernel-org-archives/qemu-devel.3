Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE15C79F89
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 22:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2bzd-0005Rr-AT; Fri, 04 Sep 2026 18:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1x2bzU-0005OW-QY; Fri, 04 Sep 2026 18:02:33 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1x2byv-0005Wi-6n; Fri, 04 Sep 2026 18:02:32 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 655AA140014E;
 Fri,  4 Sep 2026 17:58:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 17:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1788559129; x=1788645529; bh=r287SvwlMK
 jydueLCSxeBjzeYyEhg59+ASxbL6DKT1c=; b=qRv7btsWAnKV8GAC2jPm2XZdiI
 d1Fx/HvVj0Xvm4N6yFtellU7W/yIJ+nZUaEjpHPOcDuMP/s1Zw8meWpR0cXLrZ29
 VAwbm03ZcX1L/sxP6uVJR6xlGezy39Q6ytO9i0PlfzlSdaBhap75ueHr+04UtAh9
 1J2y/TLuC2BRdysJi6f4dMPq051kzsfUxuy9TEb7S0cFaLPCsG+1w1I+rOILiR7o
 rVIgMMgK95eOIzSdHAGuu3Bz3/9KwJxDWG0dS5feGmMjOwvUExEw7/JgXBmWflUb
 QDgbDuo6hIi7bKH5ZXCjepgn5WDeZ5kS+Ba1ElFn5/JiWA/WCP5894ZKYGrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1788559129; x=1788645529; bh=r287SvwlMKjydueLCSxeBjzeYyEhg59+ASx
 bL6DKT1c=; b=nSUGWE+X++Kwqe0rEN72ml1UeiQuNgjZG0c03eqKTC0pENbGbOL
 uw1LuWl+krEfwoGZqcAYhQWY6dcSkG+KikaURHPvO1xYcQmZBmiblVJAG2twk8/+
 EdjKLNY+hcXyvuLSoMF9q++dJKu/ncmLGAiFfWBxUODtujU8RnLRBYQG1U4q7E/3
 F7XtnJoytX8CuR6DZL7GiiP3SOcrTt9n26aNYPYTUhcqvN7vO2zi9NBPv7mRtreP
 Iyq8cqj6rEf12yr5I1xBSzAb2b7Bkk2nI/MsATzLNlOaJVKEdEHV+EBawvQgx0Hh
 F3rYwTNYcBVAG7GituS9CPOqdYu/jmMAI2g==
X-ME-Sender: <xms:GT-baurVFhOiwaGkMCKGP8tDzGVAjKuoT5KFW1tmm3_UsPnSbwXqsQ>
 <xme:GT-bairIo50NLE4t1PjKDt8UKpy5ZVBwNh_OjL9PVbIghhxqgRSUQEXK1Cyds61W1
 HScC9JIgoyGb3vWkwrsDoDqLc0N-nqYXEWyQh4X2p27AHkJC65IxVsq>
X-ME-Received: <xmr:GT-bauBeCsvqLqBvPW3aGrD2mviTdqhWJchl3HTQP4H4MEfddV9h30SJC_13IEFG9jGHAKFUqFxKj-Tm7bxa>
X-ME-Proxy-Cause: dmFkZTEdF7WX6qAIs/a04DXuIWYzCRbeZGQ8NUHyutdXftzT23jOxtGNs74nJDQYfYXp6M
 wTJgvKzuFwci3HZbFmxJ+QwmKzLmJIRXdIWYRtSx0KCyyuY8VFTiaDpPIB3vTHDkv57REp
 AV0gkFeDRoQLSOxkH7KUm5RKShfrwkAqjNz7/giqoam97wcZqhIke5ZcEi3IsDcHDUq1fR
 lCPRlnqe32xHIz23VTVxgYomcFzlMpPrgWH+YLom/0DXw4MhQM8hRgrs9jutcRqHQsd0lA
 1HZTEB5GraRKhX+ESlBnVC8iB+nUjp4QWXefB++cK7vxYPORK4vqEqMC3rpzGa+imQfeUq
 8xvyBrodNNBYhnYK+LIU2ntcOx49wdoetoE0qM/zfJ6gZexo1RvsVh5wXqranSYAel31pD
 pmLh26M4OtVdBeGaA/WC2af1N9jzqy7hqfsCj0wzXVQENXbFWXNBFaSI0Q6O4IRMEd5jPG
 EOemPlqsliziCabI+9X8GUwiL6HCHnxsKZmoY9hvFxs5eGTEbJeAZK3XzSPv+AVzleUqhw
 UHqdbjKAOpacMXQlaQbxqfbGd1NvjzVnaVNJGVcM4fIiWBcpFSLaitWW/tSNxPnQGtCn3Y
 hijh/9gbp61XUF7Nw9bO3M2ScCK2CnEoxiI+qkSH3x0sehnLUCpeUN2ODawA
X-ME-Proxy: <xmx:GT-bagu2mT3jHH0kS955LmiIPDf3Qbkn6ivLljzumtEGr-hrZ5Qc8g>
 <xmx:GT-batImnzmqwCVNezAyZfDm9tibZdMtUIyF9SdyE4YFBo9JcTWeXA>
 <xmx:GT-bana5tM2LAkJI-d_oD2ck8rVNZKlSYA-TXjMQo5b2SbIzEC3ggA>
 <xmx:GT-bavA-qTjnCjy1oxKwJ6XbjSTHRwEh2rSXTnq67z1zx3Oy3Zql5A>
 <xmx:GT-bamfZPQforJcIIwzeB5sKpyMcQnvODV3CG2ajGeAGtpaFDv2tcmz6>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:58:47 -0400 (EDT)
Date: Fri, 4 Sep 2026 23:58:45 +0200
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe Mathieu-Daudé <philmd@mailo.com>, Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org, Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH v2 5/7] hw/nvme: clamp mdts and zasl shifts
Message-ID: <20260904235834.5-foss@defmacro.it>
In-Reply-To: <20260819-align-nvme-mdts-with-linux-v2-5-351ac2dfed64@samsung.com>
References: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
 <20260819-align-nvme-mdts-with-linux-v2-5-351ac2dfed64@samsung.com>
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



On 2026-08-19T17:24:07+02:00, Daniel Gomez <da.gomez@kernel.org> wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
>
> Once dma_blk_cb() chunks at IOV_MAX, a later patch drops the current
> mdts 2 MiB cap, allowing mdts (and zasl, which may be as large as mdts)
> to essentially be 32 or more. Ensure shifting doesn't go out of range
> by adding a static inline helper that clamps to UINT64_MAX when mdts or
> zasl shift operations exceed uint64_t width.
>
> Fixes error with ubsan enabled and large mdts:
> ../hw/nvme/ctrl.c:1685:36: runtime error: shift exponent 32 is too large
> for 32-bit type 'unsigned int'
>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  hw/nvme/ctrl.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 4893cf7e741..a24a674a4c5 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -1713,11 +1713,18 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
>      }
>  }
>  
> +static inline uint64_t nvme_max_data_transfer_size(NvmeCtrl *n, uint8_t exp)
> +{
> +    unsigned shift = n->page_bits + exp;
> +
> +    return shift >= 64 ? UINT64_MAX : 1ULL << shift;
> +}
> +
>  static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len)
>  {
>      uint8_t mdts = n->params.mdts;
>  
> -    if (mdts && len > n->page_size << mdts) {
> +    if (mdts && len > nvme_max_data_transfer_size(n, mdts)) {
>          trace_pci_nvme_err_mdts(len);
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> @@ -3809,7 +3816,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
>              }
>  
>              if (n->params.zasl &&
> -                data_size > (uint64_t)n->page_size << n->params.zasl) {
> +                data_size > nvme_max_data_transfer_size(n, n->params.zasl)) {
>                  trace_pci_nvme_err_zasl(data_size);
>                  return NVME_INVALID_FIELD | NVME_DNR;
>              }
>
> -- 
> 2.55.0
>
>
>

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>




