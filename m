Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE5606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=BK/WP96t;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DJKZhwQ/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0Qr-0007TE-I3; Thu, 19 Nov 2026 06:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xU0Qn-0007Ru-ME
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:35:57 -0500
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xU0Qf-0001N7-7S
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:35:51 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AB6CB1400186
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 06:35:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 19 Nov 2026 06:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1795088147; x=
 1795174547; bh=gvCJxJUkIAGMkNV0ScjyOqAgWpl2WoX6E+aiAFOBLJM=; b=B
 K/WP96teml8/YrLVRyFFawDTkIWX3QZ2MXq91kRED83OFln87+yxA2pb6jmmKZeC
 5EaqzkqsK57tsDDHhBhky+wykvFhIbUJ1kP9H9pf3o3L1oeIBLW7uu99Q8MODsmm
 l5adBHlmcRTYVQXoaG4PF1LXWYvLS7HW4CwSD4a1fFlpyoj6dDM7lPSJYwwlkbIP
 SC1Zh2K4XMJZuIqwdbDEcLVmvQH78weKt8OrZnTd5/k98y8IAlCjNj02f8xfhjns
 FLIVZ/q8Ez3hkJ/EdSzw1XqeT1lgXVQw9SzqLWDbmVPCH21LtCMH3GDTr6nwtbuI
 bkGjpzTlqDG426AvifhbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:mime-version:references:reply-to
 :subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1795088147; x=1795174547; bh=gvCJxJUkIAGMk
 NV0ScjyOqAgWpl2WoX6E+aiAFOBLJM=; b=DJKZhwQ/hWBY2WxfErXpgVBZ84oBa
 nbMt+jLeHuUq/b6KwFy6Dn6/0ljKgteES1cgElbvydDJab8cCk9/2y2aDqiWnR6A
 MRfnMylFowivyjkg6zPrGAi1B5SYTf860VX4ZF6XRxAsWBm9mdTBtwm83yFzhIio
 BAvy9rGj9/LOJZfad7hE8qTzhBjpcHQc5H851umrFXBfk5QUrzWyFU6v/+TEm4Mg
 zo5kiern9XN485A5XRhroVJ8//KzAnsB4OILCx15f2Phn2Pg8Np4OPrUIn2w/XdT
 tBH7FNv9CAkq4BZ3CX829ek3WvO3ob+Bbi3I0tbCk5vbmdPXwRiOb0Z4Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088147; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:CPl9DfVkGIpTeYxws1vjSGePrhO1IA91zEE0pyDN6nevmxX
 mplB8MoR133CX5bWivmBTH/vnnIFP6FYvlQAjd7PHmcKN4RHg3o7n8m3EvFRH6Vm
 vHeOiKkGwR+GT4f00jJnX+K0RNuXo3n39lFymFW8nzEuZDL1/3fnUDf41sw1F0go
 0VLqMsr0AutMddoKhNT8QicAes+wC/VFc79q4lLwNAFiZjGAwTEjRLvGEXSyLFLX
 gwMDTwMB65T/M6SNs1XCmQc4Cj2UMzaDXj8367Nio+UdpxPHSxVyuotz/6YNUiEt
 vu9PNo1A8Mf20Qkov64N4qfoYkUmNRzPqxDBqkQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:l3uATaI8hozZdedRtPCiLB8+0iA17XkoN15ws9L39rQ=:e427LcqOP/kxsEoY4gVrawdyg0+PZGcr0PdTrG59uwU=;
X-ME-Sender: <xms:E9_-aku4PQlqAfU3PULJrNCMkJffaJ5i35DOvVXxUY08zv85mc35_A>
 <xme:E9_-aqYz-1V0dXyVGnBi1KkTiLgOxJ_pe0DzGzk9N97qc4NQ1rqdX6gMsoGsu4OcS
 HmdGFfxCdbcGucJCi-nJl8qsAy2XjHt8Q_28G2AMnt_qMK2fjqItBNm>
X-ME-Received: <xmr:E9_-arVpnTOCuVCf9AW_k6cZTmR0mcN5G_YqQ1ngWy2PczWGzST6gw0SsgZpmGRsd-g1TeiF1Z8meGRDqmV71Cz4cw>
X-ME-Proxy-Cause: dmFkZTEQhxo9ViB0OCTboLOlvqVMtsCUzFkRHIeWnYdXLzJBJCajDab5jRBJ0JXNsH+1c1
 lgpAipp/0X/VviB8ICMZbf4ifFrtM2JeOdbMkcaBULfw5VOUPShGt9Lqf9jcmDdck4hrE0
 tg/8NcuiJFUbfEOS4a5EYbEPMmoPzDIUQL/lnos5TQADkoiK7/zrvi3Nw9sBZgJzWDVux8
 y0+C/XiHaChegMHGDiPnB5EfJXkOLAVYPhu3HRqvDx8W4BbamRi0c3G+Bed9+PUiKqlUo4
 3jUsQXMib9TTpSza2WX0idg9pc16c+I4pEbfoF0H7h55MzKyHleL2pjFsrv8Y2xwTZkJF4
 LC2qR+ltgNQLxgvZrnj4QgzgJRBuzjKvjTOo617Vja4q5pNsa+dihWSP7rfYoBW3+037se
 p8/k2QuqgiacG0dQr1TtAQfQnKOue5Mibz79QMfzi+Bw9jgueLLDBpPuLrki9XVCHwVRf9
 YJIeGGZSYDL4VEay/aisjsPPELuTS5wNIuYZmdpDBE3ylYKvLOhV68hjYlNrszCZovb0u9
 P2oC+h/RFIeMa6T4lEnb6c/2RKkDfVcWNnDPPP0pHqfnwSZNfGi7fUNjOp5lFZ0fESAvaK
 Ztp2ko5vsgesSnBZIqnB4bGK1xSRfY48nqAaSWduP39NW00/ZYbyyHGmG4pQ
X-ME-Proxy: <xmx:E9_-anThS8d579YNFKxA_iYvnsq8JQjAbLERI2LPY-AKn4I8ALIWWg>
 <xmx:E9_-ahORkL84nrw2TZKsG0gPruCnF5j__6CvOW7LCinn0tE5VvGQXA>
 <xmx:E9_-atRGVo56-dN3FjzszDCLV9FdmNOyKxETT04QT5rUrG_bWqIIyQ>
 <xmx:E9_-anhvRKgV2N-AzSbv1ugc1XAwFMYifowtknaKt5PV3atfevV04A>
 <xmx:E9_-ahwx8FCV1XsqKF60YlXeTd2lnG6Ufba-jIl21egwoICW0ldwPY63>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:35:45 -0500 (EST)
Date: Thu, 19 Nov 2026 11:35:29 +0000
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 3/3] hw/nvme: advance zone write pointer only once the
 write is committed
Message-ID: <20261119123529.2-foss@defmacro.it>
In-Reply-To: <20261118-fix-4520-v1-3-dfa182213376@samsung.com>
References: <20261118-fix-4520-v1-0-dfa182213376@samsung.com>
 <20261118-fix-4520-v1-3-dfa182213376@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0
X-Mailer: neolore
X-OriginalDate: 2026-11-19T12:35:29+01:00
Received-SPF: pass client-ip=103.168.172.157; envelope-from=foss@defmacro.it;
 helo=fhigh-a6-smtp.messagingengine.com
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



On Wed, 18 Nov 2026 13:45:36 +0100, Klaus Jensen <its@irrelevant.dk> wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> nvme_do_write stages the updated zone write pointer before data is
> mapped. If that fails, the write pointer update is already staged and
> subsequent writes will be rejected if attempted at the original
> position.
>
> Move the staging down.
>
> Cc: qemu-stable@nongnu.org
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
> Fixes: 975b64665048 ("hw/block/nvme: refactor zone resource management")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 35e2c57851ae..5755aad1fa72 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -3800,7 +3800,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
>      uint64_t data_size = nvme_l2b(ns, nlb);
>      uint64_t mapped_size = data_size;
>      uint64_t data_offset;
> -    NvmeZone *zone;
> +    NvmeZone *zone = NULL;
>      NvmeZonedResult *res = (NvmeZonedResult *)&req->cqe;
>      BlockBackend *blk = ns->blkconf.blk;
>      uint16_t status;
> @@ -3893,10 +3893,6 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
>          if (status) {
>              goto invalid;
>          }
> -
> -        if (!(zone->d.za & NVME_ZA_ZRWA_VALID)) {
> -            zone->w_ptr += nlb;
> -        }
>      } else if (ns->endgrp && ns->endgrp->fdp.enabled) {
>          nvme_do_write_fdp(n, req, slba, nlb);
>      }
> @@ -3904,7 +3900,13 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
>      data_offset = nvme_l2b(ns, slba);
>  
>      if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
> -        return nvme_dif_rw(n, req);
> +        status = nvme_dif_rw(n, req);
> +
> +        if (status != NVME_NO_COMPLETE) {
> +            return status;
> +        }
> +
> +        goto out;
>      }
>  
>      if (!wrz) {
> @@ -3922,6 +3924,11 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
>                                             req);
>      }
>  
> +out:
> +    if (ns->params.zoned && !(zone->d.za & NVME_ZA_ZRWA_VALID)) {
> +        zone->w_ptr += nlb;
> +    }
> +
>      return NVME_NO_COMPLETE;
>  
>  invalid:
>
> -- 
> 2.53.0
>
>
>

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>


