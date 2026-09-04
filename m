Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB2DC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 22:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2c35-0000E0-Uc; Fri, 04 Sep 2026 18:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1x2c33-0000Ci-US; Fri, 04 Sep 2026 18:06:13 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1x2c32-0006fp-33; Fri, 04 Sep 2026 18:06:13 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 392DE1400167;
 Fri,  4 Sep 2026 17:57:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 04 Sep 2026 17:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1788559040; x=1788645440; bh=H7gRpELXyR
 tqzjZP8db3opsxYaJeawADv4HM5dbO/qs=; b=p/vLzUFNml/kUNw2OtBSXJHT7G
 Xn7XEbBeNispeSJkyy2LarCIPISIgk8yCpQJ1GDa34hkFnmfG6nlrQUIaupnbz2F
 sLcbaQVj+/ibgiyltLoNxqgKRku07OGGB7u5yH8Q0cktFGTiGo5n8ZiUmlb5rKwG
 AONlpB6vS/qvxHCGpmT0pXcEOdtaKcY2ouzVlOGqgHVRjzthOsetkD4MSsDZvnch
 go20SRcrUHIG+mH84k3HW8Ct/Z2aCnoLw9YKOcTWuI4PPv4Uairu2uM4QguugYc8
 f+S0NpnDi9th8S46ZMKmg2cOu8+/F0exHPtNIadT8SSHrFBS39A+lKERdM2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1788559040; x=1788645440; bh=H7gRpELXyRtqzjZP8db3opsxYaJeawADv4H
 M5dbO/qs=; b=bNo3ugiSpQELKTIM2Oe3vMph/TjEZdHXDsBSS1aB23DcF5GXZ1k
 vuEf6cGUnZd6Nmi4/0nhhDlKVe1wp6LQD/Dfw6Hb02zda6pUB+nDE5mSGnyE6Fsr
 ZU86xLSP+p8J2/AvpGDO9+rjpVsEAXvv+la7s/5SmkUC6vOWMakbCEp7BZeNSPqO
 ik3R2Kce8tiaPI0/GX6uw6lqUx9pcwkSxpIhafBKi4sy09sJStgCIfrMyrUoENvq
 cexl/d4FVwQ5PkI6Q9r0K57OkSf60l7NVb5cUFpYbhmeYPGU5/cLgAcYg9pwqyZk
 VAMHl+OoazU6+nw3rv/sMsmkD93qxl9jqHA==
X-ME-Sender: <xms:vz6bapYDe4tUkDhK_3LbyaY6j4aecf2Jv7TiZQeulGjy-fYbV_TwzA>
 <xme:vz6bambC4yOJE5Jb251odF21nFENAlQA1MaoempOT_5My32nPF_sSmKc_CTyzZONV
 MIAiPirW8xQz3vlZTvsOMmWiKEtDTSy15HsY6C8Ia2TVFWOJnQqcXrJ>
X-ME-Received: <xmr:vz6bamzSaSZgCPy4p6FSw9JfHJYwLXd6f0ioIVXm46SoPITYhUPcBBpZ6QDyvoURJ-K-B4feT7PDbx4dd7Oc>
X-ME-Proxy-Cause: dmFkZTEdF7WX6qAIs/a04DXuIWYzCRbeZGQ8NUHyutdXftzT23jOxtGNs74nJDQYfYXp6M
 wTJgvKzuFwci3HZbFmxJ+QwmKzLmJIRXdIWYRtSx0KCyyuY8VFTiaDpPIB3vTHDkv57REp
 AV0gkFeDRoQLSOxkH7KUm5RKShfrwkAqjNz7/giqoam97wcZqhIke5ZcEi3IsDcHDUq1fR
 lCPRlnqe32xHIz23VTVxgYomcFzlMpPrgWH+YLom/0DXw4MhQM8hRgrs9jutcRqHQsd0lA
 1HZTEB5GraRKhX+ESlBnVC8iB+nUjp4QWXefB++cK7vxYPORK4vqEqMC3rpzGa+imQfeDg
 6eeEUwFVgwBnGq5a5NoLQ2oPU979WBkELfG+Slco/qwSW0vDg6SbuotmeS0rH0bpotyhUv
 pQdN2qFPN9ZIRQVXlBzr5ggHHBGsKpJAaqCXcpJCwSSRy1v6fJ9XzvQ3H0qxdq7RTrUqzc
 /4hytap4HETOCjOp2jUCFol0seDPemgwFF1HbyEvNY/UokgECPspGRxJPR53nNKSvGA3Fr
 lUAiBkeMj898wG2v7/2fMt2752ommjnJ8mD5XtEMQoZBMN9/Oiiq8jTBSa1tuEQ7LtDoIC
 VR+uxcbpvpJJJhuIfy45AUzA2vFzuOvXY81K+KKWi3t529tseHBMvVF3vGWw
X-ME-Proxy: <xmx:vz6baqewHdTl3ogzMbZJQupEBftH3Aq7t_gRNj-WjSKN2WxWPihKwg>
 <xmx:vz6baj4DyTLQQeDR9FhxJMev-FezVuam2Ny20XW6cLsKC-R6Xk_Faw>
 <xmx:vz6banKbIFxViWnUOw9QWCGlFpKhLJaAT51XzRbna6ESUraaQSimBA>
 <xmx:vz6bajzf8KXRQ3RjRVsY5tR26ru2SDjfpPSHcB0CFyrT36qGO6q67Q>
 <xmx:wD6baqN2qoctWlCU1uiLvJEZO41S_e6xmOd3KqckSajZjxwn6lRlyBJN>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:57:17 -0400 (EDT)
Date: Fri, 4 Sep 2026 23:57:16 +0200
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe Mathieu-Daudé <philmd@mailo.com>, Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org, Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH v2 1/7] dma-helpers: fix unaligned discard_back
Message-ID: <20260904235516.2-foss@defmacro.it>
In-Reply-To: <20260819-align-nvme-mdts-with-linux-v2-1-351ac2dfed64@samsung.com>
References: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
 <20260819-align-nvme-mdts-with-linux-v2-1-351ac2dfed64@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird
Received-SPF: pass client-ip=103.168.172.154; envelope-from=foss@defmacro.it;
 helo=fhigh-a3-smtp.messagingengine.com
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



On 2026-08-19T17:24:03+02:00, Daniel Gomez <da.gomez@kernel.org> wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
>
> Commit 99868af3d0 ("dma-helpers: explicitly pass alignment into DMA
> helpers") replaced the sub-sector remainder with the aligned size as the
> amount passed to qemu_iovec_discard_back(), effectively discarding the
> wrong chunk. Go back to discarding the tail bytes of unaligned IO.
>
> It was found while chunking dma_blk_cb() at IOV_MAX to batch large IO:
> a chunk boundary that is not a multiple of the alignment lands here and
> dma_blk_cb() submits the wrong bytes.
>
> Reproducer (with dma_blk_cb() chunked at IOV_MAX and mdts >= 10):
> fio --name=demo --filename=/dev/nvme0n1 --rw=write --bs=8M --direct=1 \
>     --iomem_align=4 --size=64M --verify=crc32c --do_verify=1
>
> Logs:
> demo: (g=0): rw=write, bs=(R) 8192KiB-8192KiB, (W) 8192KiB-8192KiB, (T) 8192KiB-8192KiB, ioengine=psync, iodepth=1
> fio-3.41
> Starting 1 process
> crc32c: verify failed at file /dev/nvme0n1 offset 0, length 8388608 (requested block: offset=0, length=8388608, flags=88)
>        Expected CRC: db932ec1
>        Received CRC: d3b6f2dc
> fio: pid=2755, err=84/file:io_u.c:2280, func=io_u_sync_complete, error=Invalid or incomplete multibyte or wide character
>
> Fixes: 99868af3d0 ("dma-helpers: explicitly pass alignment into DMA helpers")
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  system/dma-helpers.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/system/dma-helpers.c b/system/dma-helpers.c
> index 0d592f64680..8ee83ce9e75 100644
> --- a/system/dma-helpers.c
> +++ b/system/dma-helpers.c
> @@ -174,8 +174,7 @@ static void dma_blk_cb(void *opaque, int ret)
>      }
>  
>      if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
> -        qemu_iovec_discard_back(&dbs->iov,
> -                                QEMU_ALIGN_DOWN(dbs->iov.size, dbs->align));
> +        qemu_iovec_discard_back(&dbs->iov, dbs->iov.size % dbs->align);
>      }
>  
>      dbs->acb = dbs->io_func(dbs->offset, &dbs->iov,
>
> -- 
> 2.55.0
>
>
>

It is obviously locally correct.

(I am more confused by the code, broadly. How come the IO isn't rejected
if unaligned?).

Acked-by: Jesper Wendel Devantier <foss@defmacro.it>




