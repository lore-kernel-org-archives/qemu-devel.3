Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E305606A8B0
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=mdb8krQQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSFps-0000vD-Cg; Sat, 14 Nov 2026 10:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xSFpm-0000sF-Od; Sat, 14 Nov 2026 10:38:33 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xSFpj-0003TK-Ip; Sat, 14 Nov 2026 10:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794670692; bh=rom3oVrGuMyIZkSEs5sJcCZhkz7TbMeb18DGj1nQihI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mdb8krQQQ/N1YLlVIuUTRocvdigo+GlPgFmrJ8QLdGsdgNXTe1YX38F+7Q7CMeuqI
 LR3V8n2Tth/ve0xXe9ma/9wXi4YK11E6TCpP17T8wohCFsnEJbR6+kl1fBoAkz4HrU
 c9sRoEn/hWjmMISOmaui40hqksCXsDpNzT3K+314L4TR0edqDMNnRleRipiC6G5Ki1
 O//2eUDCvgOaKsCLWlzzBBLERSFW9k8fPOAsEY1tq/uJIQT9OWStu4Qae/abeej/Ui
 2MibipO2VqG8nUSW4QzOMUOxSvZUMTg4SavKcXe6K/CG24NFhM9w5tnyKlvRCc7DEU
 /RvJxNzsooF+w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F36841E66B0;
 Sat, 14 Nov 2026 18:38:12 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E204E45BFE1;
 Sat, 14 Nov 2026 18:38:12 +0300 (MSK)
Message-ID: <de3cf993-74de-4710-8b5d-eacfb96a5a97@tls.msk.ru>
Date: Sat, 14 Nov 2026 18:38:12 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Various virtio-snd fixes again
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 QEMU Stable <qemu-stable@nongnu.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 15:39, Manos Pitsidianakis wrote:
> Some various virtio sound fixes.
> 
> ---
> Changes in v2:
> - Moved fixup hunk to the patch it was meant to fixup
> - Link to v1: https://lore.kernel.org/qemu-devel/20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org
> 
> To: qemu-devel@nongnu.org
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> ---
> Manos Pitsidianakis (6):
>        virtio-snd: convert virtio_error to error_report
>        virtio-snd: add pcm_state_to_str()
>        virtio-snd: reject invalid feats in set_pcm_params
>        virtio-snd: don't allocate pcm_info zero-count buf
>        virtio-snd: cap maximum buffer_bytes to half a GiB
>        virtio-snd: period_bytes divides buffer_bytes
> 
>   hw/audio/virtio-snd.c | 91 ++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 80 insertions(+), 11 deletions(-)
Should we pick something to the stable series perhaps?
Dunno how widely virtio-snd is used, though..

Thanks,

/mjt

