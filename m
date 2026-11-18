Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2888A606A32F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=eow60xGb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CFl8tTu7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTef8-00019v-Sl; Wed, 18 Nov 2026 07:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xTef6-00018p-VP
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:21:16 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xTef4-0000WF-8z
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:21:16 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1F05D1400162
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 07:21:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 07:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1795004473; x=
 1795090873; bh=+tHM1iM2czdCZsdKrX+fz1tuGFKAnjdIYei3CaZfc3c=; b=e
 ow60xGb8fMkyG0uvC7RG+N53Nnb1+bfL2M5CGeLdJjp70zAqSLBlLe7AH8SbyO8N
 03qHoqzBeodAYq3FsMjE9+YOIOnXMpnfDSdxeQkiSjIMF1TX/pBUJ1Uryw80xODw
 mo7waGfjSjTioL7M003S6Krns63V8cGQktnAHxD2mo0HwSbOw7rpalsJnsxr1HHm
 Py2qy5+L5OQ3GDeQvU83pADsCpM7JSJxKrTpzkYx0R0/n4Sw7HEoTUqhqsgi3fru
 +W1GSDu71ngoj+JITqsB1fGMJbxDpfObVsEhAimT1+RjaqraetZTrNk8V8nVNSyE
 5fJZMkIbNCvTSKQ4jAA6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:mime-version:references:reply-to
 :subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1795004473; x=1795090873; bh=+tHM1iM2czdCZ
 sdKrX+fz1tuGFKAnjdIYei3CaZfc3c=; b=CFl8tTu7/iWSE/igLXsV+4ly/+bFB
 H2WFWQK+EIUTfru4bd3eJD968pxK4MXrggrqXu24jXEdvwefzlVdABadNz4rb77q
 WF68vd1D49NotUrTbJJvsf6KKniBia/Iyx07RgHhsbWCpDhdWdxQh5qsrtomccWR
 Qve8RGgCewPhu+CYEjxz3td7ybyLKksIWJyOYKUKXAE+/mIB/5aIe/OP7BYJk3kW
 cyAYHdgkuniKW6SUc/US8Wgrj4l6etliVyXY0Y4NWqQLrLMpnCFYgD5wCkO9R4yP
 2c0DaheLE3gfP2n8ynnN6fv6OYi1qyZNPxT1ulwzXfjGIB6faFYjhrtyA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795004473; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:l8/RkXlR3st2I7fBt8/1dmUUEbz/o2zSXPBPa5evPNIReNN
 GLU9A8JdxvyYTOnmVBBtCIv+hB05yB7kqOBPHCzcyoUv49I+ofZ0JckKJNGfpfgo
 eQUwEoic05t5uY0TYV6AAp+Do520FSWmkB8nQCbhQd16T8YA7kduvAf74XSHBhlg
 +qJcuJ+K+fXDehKa3MP+CD7nV/OeOgJz3FN18SXHkHAzxIvVTiWfdWrEGE87bHGt
 nKm4uwRsa+qIh4u8cikYCHEtLKA3CnYPRZ5bJTg8Xk75/84t7xswy/ZKh1mn94Jv
 Os8M5poUQkxxbaB9+y3VMkcNZCv65MoJ6sDoXeQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:R+Y3P3vKyRT1r8/Gn2wvNYL1jlqW95/4v3JQrudpvno=:fL/jjjDn0epICzhff8YDIb7sUbE/W9Uvl8Di3WMccmU=;
X-ME-Sender: <xms:OJj9apeI7tnGbWQ1jj_MNr2nMXzb0H30Wx4RxJi0_zn2nvhRZIU7ng>
 <xme:OJj9agIsePqjkYE5PUqcgjGp2ThOiBrmxO0FZNKkacmCsAD4TMOOR2yZFGbPFQMK-
 t6X9tLpr0YCpURdXePCn-60rd2NqHYT1USiNXftIaHTbaIoK98cB6G8>
X-ME-Received: <xmr:OJj9auHQxUCIgx3nxljropoqd8h7_5lqbN3wfge0i2e1jodBxrF-bYJen1Th>
X-ME-Proxy-Cause: dmFkZTFmB+HaVkJwOn4RLB6b2ah7EBcT8ZbZmX11pWIbeudpxDOEfvOgbEP43kW/CtyvDT
 r0uOu1BwpGM6K0G1YfKCcHpof4Czw7dWwOkGyQlIChQzOwTeraFt3a7aFl9vVGwcQd/VNq
 zax4WXH14L/afsLDzdGyJp5H/Vu3q33EdDo8I8T7iM9zhVKXIdAoEVr2kk0ZKfHkOsUVdx
 6QZBMbdDGJDgb8gZykbDY/tKfjj8vvqrazioJvakpH4U+jUMrndNhFzQzDs7w2LUr3euTx
 oBKIyb1+rhumJRojfTa+JLpZMZVlsKAdOJL+j5xZTQ4tb08/mEb/xXht1EgBuGs4ZI72VT
 FvzCPzfujc0nL3wYcDegNaUVk4dZWQ1pjRWJsALPfJTOeROPDwosFYvdaiuCZAuEd+LFOb
 rVi0euGUdOWvo0xDilj5LNoWzbOEdnX+P0GyAoEVq/eLZ49Vmtrl10Y4yabeT5hQeZfuMT
 ggBuAJ64AzWxwbD2IelV/o4/9I9nGmWffIZl1hoNmlRuIGgJpgz05VZ+2WkIzVBzkEK4+W
 KlqQSNy15PoA2n1OPxQlXymPSb5CAX7nU2FZRjSnjmaSjOudSzH3NH7Jl5IPbnGrHuKhwc
 RkzbEwnpzQIo/E03bGeuIhpUrxUCqUrw84LF6pGBemFhrCZTQM7lkgCh9l0Q
X-ME-Proxy: <xmx:OJj9ajBXwfKZlLbpMk3QuwO2-VqS8fwU-wuodYAjaH0dd6soIlyJ0w>
 <xmx:OJj9ah-aqll5PtN68rlXLtbBWDlWUYbe59qQW1QGu_fBxe-sQqAUSw>
 <xmx:OJj9avDonE5a0TeE5iz1mXDc_v50lG7OzI-peRIQLWfOogOrGsZ8pA>
 <xmx:OJj9amSdzLUjkUSbpM4BNia3QBmyJdpRG6gk_mLtRHwoxsW4gUbB1w>
 <xmx:OZj9asiaxqcZ5boVNdTxg5YE56U1njbCPvN_8O4vpvFHv0idKONBWS1S>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:21:11 -0500 (EST)
Date: Wed, 18 Nov 2026 12:20:51 +0000
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/nvme: report data transfer error on failed dma
Message-ID: <20261118132051.0-foss@defmacro.it>
In-Reply-To: <20261117-fix-4700-v1-1-eaf8920b66cb@samsung.com>
References: <20261117-fix-4700-v1-1-eaf8920b66cb@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0
X-Mailer: neolore
X-OriginalDate: 2026-11-18T13:20:51+01:00
Received-SPF: pass client-ip=103.168.172.158; envelope-from=foss@defmacro.it;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Tue, 17 Nov 2026 12:35:21 +0100, Klaus Jensen <its@irrelevant.dk> wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> nvme_tx discards the MemTxResult returned by dma_buf_read/write and only
> inspects the residual. dma_buf_rw already accounts failed transactions
> against the residual, so a full-length transfer to or from unmapped
> memory results in a zero residual and an apparently successful transfer.
>
> Check the memory transaction result instead and complete the command
> with a Data Transfer Error on error and add a new trace event that
> actually describe the event correctly.
>
> Cc: qemu-stable@nongnu.org
> Fixes: f02b664aad8f ("hw/dma: Let dma_buf_read() / dma_buf_write() propagate MemTxResult")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4700
> Reported-by: Karl Mehltretter
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
> The residual check is effectively dead code. Both nvme_map_prp and
> nvme_map_sgl map exactly the requested length, so the residual is always
> zero. Keep the check there instead of asserting it, keeping the fix
> minimal.
> ---
>  hw/nvme/ctrl.c       | 10 ++++++++--
>  hw/nvme/trace-events |  1 +
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 71c24dc02b67..5e8788a257da 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -1380,11 +1380,17 @@ static uint16_t nvme_tx(NvmeCtrl *n, NvmeSg *sg, void *ptr, uint32_t len,
>      if (sg->flags & NVME_SG_DMA) {
>          const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>          dma_addr_t residual;
> +        MemTxResult res;
>  
>          if (dir == NVME_TX_DIRECTION_TO_DEVICE) {
> -            dma_buf_write(ptr, len, &residual, &sg->qsg, attrs);
> +            res = dma_buf_write(ptr, len, &residual, &sg->qsg, attrs);
>          } else {
> -            dma_buf_read(ptr, len, &residual, &sg->qsg, attrs);
> +            res = dma_buf_read(ptr, len, &residual, &sg->qsg, attrs);
> +        }
> +
> +        if (unlikely(res != MEMTX_OK)) {
> +            trace_pci_nvme_err_data_transfer(res);
> +            return NVME_DATA_TRAS_ERROR;
>          }
>  
>          if (unlikely(residual)) {
> diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
> index f97a6a11f360..7cc4d1975afb 100644
> --- a/hw/nvme/trace-events
> +++ b/hw/nvme/trace-events
> @@ -139,6 +139,7 @@ pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
>  pci_nvme_err_cfs(void) "controller fatal status"
>  pci_nvme_err_aio(uint16_t cid, const char *errname, uint16_t status) "cid %"PRIu16" err '%s' status 0x%"PRIx16""
>  pci_nvme_err_copy_invalid_format(uint8_t format) "format 0x%"PRIx8""
> +pci_nvme_err_data_transfer(int result) "result %d"
>  pci_nvme_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
>  pci_nvme_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
>  pci_nvme_err_invalid_sgl_excess_length(uint32_t residual) "residual %"PRIu32""
>
> ---
> base-commit: 97c88c61d45dee6e1f9bc160a338048189846d28
> change-id: 20261117-fix-4700-111c59d3a60f
>
> Best regards,
> --  
> Klaus Jensen <k.jensen@samsung.com>
>
>
>

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>


