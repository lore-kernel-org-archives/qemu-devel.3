Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05281606A32F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=HjGgPEal;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=P27jj+sU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeS0-0007hL-Fq; Wed, 18 Nov 2026 07:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xTeRv-0007gL-1y
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:07:40 -0500
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xTeRs-0005nY-M4
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:07:38 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 8BB93EC0A81
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 07:07:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 07:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1795003653; x=
 1795090053; bh=QGK3yFjb86UDIrnJSu2aaOGuc3yLH0Edalds1xfGulU=; b=H
 jGgPEaliLj3di5zCmbikRiMADuDDncPQMGltZ/esdyXaeRGyUOiOmP0jHxX6TUTP
 8+YsWoTArA9ZrSvCoiuE3MWlpserzllHCKHkqVmtjm0E/vti/youYKGVBLcrJNmL
 dMWbd2oKd4OtrK6qizSezXT2jqZcjH0E5mB39eekO/m5WAIkix8Zjhiw6YBFfVNC
 ZgjaoyVFqHyXg5Z6Rh9kzFhWnO1ROTjItDZM1FJE2746RouIqfeNBygXpC/l56A+
 W0yQgkR7GOJgZiqlKwfeRR1fiKilspsT9Er+9z1a4nLsQCMAQz+wmc8m+kx+1QA0
 jTQYjdF+YAGB1FUgQI2qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:mime-version:references:reply-to
 :subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1795003653; x=1795090053; bh=QGK3yFjb86UDI
 rnJSu2aaOGuc3yLH0Edalds1xfGulU=; b=P27jj+sUcMpkc3mmyuFPfhYG+e/Gq
 jTDItJgaq0Txtlj331d4iwTOiV6GW9wlpRP0dQpkg2iKS1huGDoJnXkxEcdlffba
 VIXmeCj6+K97N1dhwPV8RCKBksVCTpdzqYlosbVxD3unDAvAEJG9BrEj7lKdZSOg
 Co3X0NbjkvIdYEPA7hLNyziUvUYNtvv+jFs3yDFVvb5z74Q6dkl5P0L5hclc3Dnw
 m+eSS0eaRwFaeMum1I94S/HRVESCOyQx4dZZf8lzf/lr/d0hjeQyV1ReGxPBUKL9
 dYbzNX+75xIpAU/LenmLZh3lR965LCwPJNcC0xxvEZX0jCcKWhvzKUYqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795003653; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:S1/AwhUra8i7bkIETR6o+lnH0l2EUt5aoioGSE340yW0uqK
 SG/su93ki3kRWs2XuFvFukmr1jV1Lk/P73zmeJTtdq4kWB1UnzSfy0/JcM6R1vKF
 hzkG4TSebLVlsY8MzYFZxPlz3fVqtvPG7zoxaF+IymQm02WxX27U42JYA5p+5x5/
 GuBmIc0ymuUmKrbFWzWWkANwORN+wrPczrA6Rb4sPHFSc288g9xTSmi+p9w83oOm
 MaD8maFCl5RLRQTYGVe5UAM9mGAwnqCI4Kq4rgDKxuBtS3zrTFmkiOiLHTvVlO3L
 Hn3/ekvPpvl7y0nU74/dHr1DmX1PeD9PvWSmDDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:OyyNYpQMjb6XYNQuVxUSwcabc7p3DVt/FcpNNCGLHv8=:6GuhKgk2Csj8PqQgpWKTkv+KwB9wYu0NIXTw6iLZ25I=;
X-ME-Sender: <xms:BJX9al1loPE892I5yPCElLX2EKEDvv5dws0T8MzHFuM7xm0VoiKw7A>
 <xme:BJX9alAQFRjEM-_o_tBxaqMDvTKBddsKs3ihhUlggDAe-h0IefK9OB8IwP46iZVk2
 xOHqZjL7E2ajTL3qykpCbdnXh-Z0v8wHyZdcIknN-6uP7HoMVskfn2d>
X-ME-Received: <xmr:BJX9ahcame1Rxcr8_fjF7Q7c1l5ovQpwr3Nes76QjCMtWrOOQgz47WMQmft9>
X-ME-Proxy-Cause: dmFkZTEbsc86BTA28W01370b2FvKgBu4fjE+KU7OZ28j64yJq0ft5niUDmer1cCsfo929g
 zvzZ1NkdASZ5iscEbtecuYyNC7MhHXxuMOgyKFAV/rEHAH0LsadrF7DwyTwwm8beF8GeN8
 eSlpKMRfhtDwOO9dyiMoZmRJP4jk5U1Vi4NXWFZ3oZsbhjtqY5A6hBvze17+cYjUP7cK+a
 tTO6KLSY4+87Ch1vkAzXRo0qJ/TbZOkBX+tbKlYP1Pquf6ybRBcBCV4zLmv1KgWrIwamvP
 pqgsE/LsxyxDKeVqaeyxZ9g6nqVnagrkoVAHIkwWXpl0ogJQSME/xuBnuw3IVpwyqbdoVm
 DfKj72bQ8wGllKZ1YD2Z9BnZcVk/Bew2c69eTFM3hiFpfaTigS3Bg49NXSpos0+2EwDcyA
 7S3sMCP6yrV0RhlAdLMzESDVa40oGn1R+HszmYdDantK0cvEsEBZhAqAQFEqfT9RzxgnF5
 VC8NPc6dayZiPs/hZq/g0IWVsQCROVnk+lPJbeXQbs5kmy9h/G5oMSDhCDqVX6Y9VHoauL
 pVMc0z4jOI4haa9vPdA6OgQH7+ntGdFxzYtQZymo7nT1Lvc18WkkCuDRy9tJBH1c0YgFk/
 nvI3++ci0z2WcQcuSoVXBjFeVsU5+gcgwRP/QeugrWrGrbzu2A92y61FRt2g
X-ME-Proxy: <xmx:BJX9ai4HRq4uJqSgGi9UxgmnfyQjTl49zRRMNofYNkQuhj6vmdgbqQ>
 <xmx:BJX9akW9b-lIF_ojpqk1E1oVeLcm1kOmRCfgSleRcuYOvvtJLsMK_A>
 <xmx:BJX9ah4EKf65YHt1noz5CdXeyx12GYpMgolY6v1h0i9WNBoOLcgZJg>
 <xmx:BJX9avqDR0e8FCHTXCF_ToYbuLki3vmiL0a4N-n1FVGBbQDnaD83uQ>
 <xmx:BZX9aj7xKAU6cN5Z21M7ypIvnfGh2N1In4BsZwQPeoW_XHvEFA4DNpDJ>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:07:31 -0500 (EST)
Date: Wed, 18 Nov 2026 12:07:08 +0000
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/nvme: fix zone descriptor extension allocation overflow
Message-ID: <20261118130708.0-foss@defmacro.it>
In-Reply-To: <20261117-fix-4730-v1-1-1a3d813ed0f0@samsung.com>
References: <20261117-fix-4730-v1-1-1a3d813ed0f0@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0
X-Mailer: neolore
X-OriginalDate: 2026-11-18T13:07:08+01:00
Received-SPF: pass client-ip=103.168.172.145; envelope-from=foss@defmacro.it;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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



On Tue, 17 Nov 2026 08:53:11 +0100, Klaus Jensen <its@irrelevant.dk> wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> nvme_ns_zoned_init_state sizes the zone descriptor extension array
> with 32-bit arithmetic. A large enough zone extension size and number of
> zones will wrap, causing either null pointer deref on Set Zone
> Descriptor Extension or an out-of-bounds write.
>
> nvme_get_zd_extension has the same problem.
>
> Fix the initialization by using g_malloc0_n and compute the per-zone
> offset using 64-bit arithmetic.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 1a9290ade33a ("hw/block/nvme: Support Zone Descriptor Extensions")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4730
> Reported-by: Karl Mehltretter
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ns.c   | 4 ++--
>  hw/nvme/nvme.h | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index 37d45bb4d533..b18fcab43b44 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -314,8 +314,8 @@ static void nvme_ns_zoned_init_state(NvmeNamespace *ns)
>  
>      ns->zone_array = g_new0(NvmeZone, ns->num_zones);
>      if (ns->params.zd_extension_size) {
> -        ns->zd_extensions = g_malloc0(ns->params.zd_extension_size *
> -                                      ns->num_zones);
> +        ns->zd_extensions = g_malloc0_n(ns->num_zones,
> +                                        ns->params.zd_extension_size);
>      }
>  
>      QTAILQ_INIT(&ns->exp_open_zones);
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index a4b2c01a2cc4..1bfe85c10de0 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -363,7 +363,8 @@ static inline bool nvme_wp_is_valid(NvmeZone *zone)
>  static inline uint8_t *nvme_get_zd_extension(NvmeNamespace *ns,
>                                               uint32_t zone_idx)
>  {
> -    return &ns->zd_extensions[zone_idx * ns->params.zd_extension_size];
> +    return ns->zd_extensions + (uint64_t)zone_idx *
> +        ns->params.zd_extension_size;
>  }
>  
>  static inline void nvme_aor_inc_open(NvmeNamespace *ns)
>
> ---
> base-commit: 97c88c61d45dee6e1f9bc160a338048189846d28
> change-id: 20261117-fix-4730-fe5e4d60673a
>
> Best regards,
> --  
> Klaus Jensen <k.jensen@samsung.com>
>
>
>

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>


