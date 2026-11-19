Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A72606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=YZXEAHq6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nU04oZmi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0Tr-0001GH-GA; Thu, 19 Nov 2026 06:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xU0Tp-0001Fn-QP
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:39:05 -0500
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xU0To-0005Pn-6b
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:39:05 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9C6B4140015A
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 06:39:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 19 Nov 2026 06:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1795088343; x=
 1795174743; bh=kxl5VqFhETPbowQwMfsHbs5FzK5r6p3tPtjRWm7fr9s=; b=Y
 ZXEAHq6rtG537alRu287k5g6g0jOvTr4vCAvyof40eQrvhNALFMm2Q+ONHJtYyee
 5at/7UkU/WiusTAQpLYAoo8y0tz0mn2ZJ2FAUQxRRFJzeMU9ccm7e4xVApHGxqwe
 NPqqAkaJaiCn5rF3fsy/kAWoOO5S/0ZzgJn42/u7GWhaof0NNz6Nn4BS9Ve19CdP
 yZ/+D/+ZmJ5pHyx1SsIJ3NvvdYLomf6K8/9cRppbyqylip9TjtpeKqQ3742hhPyp
 nCCWlNN5Jx6I9MCqniwTEsdYwRMHaBRGfYwZNTG/8x2eBgcsrstLW5h6vKxGhisu
 M196i4Y1cnNu4PKJ/ZFFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:mime-version:references:reply-to
 :subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1795088343; x=1795174743; bh=kxl5VqFhETPbo
 wQwMfsHbs5FzK5r6p3tPtjRWm7fr9s=; b=nU04oZmi9mknBxWFtbjZDMhDXwVDE
 c8CGx0J2mENjv8KBg8pAJHSDR+C+Fn8Jh9dlcZLb7/gtoHLCT/rsMDaYj6I1ZRQ6
 8gb2UVVgippEy0lxypvWoZeT/UsRQw9UiN4i1B2qd2GPw2eOxjSY/5Xrc+/O3LZb
 29fr9Tkb5jLte18tlboSo+QkYUaSpfEuJEulsMrBUe9SiM0aqVQtTju3E98mp1o9
 Q6Lgc3yJt9WlBjpKDTpTEpm86HuBiag00cgQHlU3GyQgeNtCmqw3Ul6tEJ9i80O3
 DQ/yUkRvxx5E4nyk78VA1kALQPyG+pRFiGDjXu+1kHiMaRLHEDjNgJBNw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088343; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:MkYN9pohQy/VsOAyLNeusNRUMxkq8xGp8+puCuC6Q9Ud7ul
 yBrJ0A93b/E1AD8Vm0ZuND03EXilSd5wmCidldIYfISstohlwVA42r8fbSxVMxV2
 3dYBb3e9iPw+i1XmSeWCOJuPA1nyTRjpDUXou4YJZ4uTus43ee6StYVeNAdp1PJ1
 amW/OEGqt8diVeiPIK9zBm7au2WqDp/2LlCW1v6OjYC61Fs/tKyoqPTHpo3omwCn
 zOkfTJaNLF62l7aiazUobaDe5fpjrT1KHQBGXBRLKkM30pYg2yDeQ/bKP7/yfYDo
 8y+Z6U2kqA35Jc03OubUIPmaYr9v9rCKo1ODu7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:4YqTKX3lkJJDu1/NaIv6x0YFOehTecOP/s3t55kz+YA=:UmZIffjbskhLQg58nwkyDHS6iCMBKCUT8kH5khNkhws=;
X-ME-Sender: <xms:19_-auYU93aqc95kivI2MPdsWXz22GpNQstvVrGWst0bzbR34d_23A>
 <xme:19_-aqXj_l-eovrKSgILCI6qZ9YRLZAbZdivsMg1WOpaDrsCiSt89PxhCskhqZZ8Y
 x0AV7XihoI3E79lhDpBZeX_YGCFyLVhhlwhk9wCGg8LtkGhPkA5b08>
X-ME-Received: <xmr:19_-akhzYihKxr0-hkXzPPOtJEKIwm-PdMG5Yr-OWeIiQqNZUqt7JYvBomO4sY_TjhFhA5bOrDybf_txt2ExZyg9DA>
X-ME-Proxy-Cause: dmFkZTEQhxo9ViB0OCTboLOlvqVMtsCUzFkRHIeWnYdXLzJBJCajDab5jRBJ0JXNsH+1c1
 lgpAipp/0X/VviB8ICMZbf4ifFrtM2JeOdbMkcaBULfw5VOUPShGt9Lqf9jcmDdck4hrE0
 tg/8NcuiJFUbfEOS4a5EYbEPMmoPzDIUQL/lnos5TQADkoiK7/zrvi3Nw9sBZgJzWDVux8
 y0+C/XiHaChegMHGDiPnB5EfJXkOLAVYPhu3HRqvDx8W4BbamRi0c3G+Bed9+PUiKqlUo4
 3jUsQXMib9TTpSza2WX0idg9pc16c+I4pEbfoF0H7h55MzKyHleL2pjFsrv8Y2xwTZkJtZ
 YLQg9oFO/Bc4TTSof6KgT0A7GlrUsqV+5X7gk6+MoVbif1ActUxoWNVIxBcyAD4m3FRyZX
 cghmSdl9tI3lgtiI3Jf2o3wTIrYAQ4kEDtJ45Z9waPZuysnHmEpqtUV7hTd9w2yboqlDN3
 wfXigzqlUyBHAE2wV1iwjA1rgdcl0XILBBtYg1dDXxLx5voRKPZjc88Xdi312aKBtNqAGT
 OXWczGG1HMz+IqdX2p/lNLX0LHCLqSbzB3Uevw1mqdF2CWZv3wDsVTndzPicWuDWmIdBBr
 5o83gkhbsFAH/UlPEwlMTjsQfmr09mE1Ia2TNFNy1CUXrl45/PB+7OO0AqXg
X-ME-Proxy: <xmx:19_-agsHT1Oqia5VgySLGNBaXl3xrF5RrWz5bYPb9cT_6FaQNl6FpA>
 <xmx:19_-al484clyqWqzZ0qUDfgBEVHdu1lLCGQf-FVWFOgvTtoGE3grYg>
 <xmx:19_-asOXuF9fO3GJNyDj4lp5wAHkJ74dYi_WKbOJC_mb_qqWDwkg0g>
 <xmx:19_-ajufKwLRVMlKddTn_Lw_iDRNqo5bo6rgaae10tjiKjM1IQ5xyA>
 <xmx:19_-ak-yjlEDJSVQWbP4PC60apbXvtAUmR0rELvJI_iOKojK7LMPTKX->
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:39:01 -0500 (EST)
Date: Thu, 19 Nov 2026 11:38:43 +0000
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 2/3] hw/nvme: bound zrwa flush by the write area and zone
 write boundary
Message-ID: <20261119123843.4-foss@defmacro.it>
In-Reply-To: <20261118-fix-4520-v1-2-dfa182213376@samsung.com>
References: <20261118-fix-4520-v1-0-dfa182213376@samsung.com>
 <20261118-fix-4520-v1-2-dfa182213376@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0
X-Mailer: neolore
X-OriginalDate: 2026-11-19T12:38:43+01:00
Received-SPF: pass client-ip=103.168.172.157; envelope-from=foss@defmacro.it;
 helo=fhigh-a6-smtp.messagingengine.com
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



On Wed, 18 Nov 2026 13:45:35 +0100, Klaus Jensen <its@irrelevant.dk> wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> nvme_zone_mgmt_send_zrwa_flush incorrectly accepts a flush up to and
> including one LBA past the zone random write area. Fix the comparison.
>
> Additionally, there is no check that the last LBA to be flushed falls
> within the zone boundary (i.e., the *capacity* of the zone). That is, if
> a zone has a small capacity than size, the write pointer can be pushed
> past it. Fix with a check on the zone write boundary.
>
> Cc: qemu-stable@nongnu.org
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
> Fixes: e321b4cdc2dd ("hw/nvme: add support for zoned random write area")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 16860ccd9520..35e2c57851ae 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4279,7 +4279,8 @@ static uint16_t nvme_zone_mgmt_send_zrwa_flush(NvmeCtrl *n, NvmeZone *zone,
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>  
> -    if (elba < wp || elba > wp + ns->zns.zrwas) {
> +    if (elba < wp || elba >= wp + ns->zns.zrwas ||
> +        elba >= nvme_zone_wr_boundary(zone)) {
>          return NVME_ZONE_BOUNDARY_ERROR | NVME_DNR;
>      }
>  
>
> -- 
> 2.53.0
>
>
>

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>


