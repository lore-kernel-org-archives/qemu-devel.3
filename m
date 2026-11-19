Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC521606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=F44WDjlj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=be8v+/Dq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU02I-0005x5-P2; Thu, 19 Nov 2026 06:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xU02H-0005wi-Gi
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:10:37 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xU02D-0006TO-Un
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:10:37 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 5B1A3EC0908
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 06:10:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 19 Nov 2026 06:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1795086632; x=
 1795173032; bh=fM0dA5zGBy4mTTFWrG8U0ZRHXkHPtcZ1l1q/+z9lKcM=; b=F
 44WDjljbKBrbGoRZlog0PL87W2ql4Q/noGcowXOmo/nTC9J+T5abbFHEAevT/4SQ
 W2sSrAJfCWn/9ogOjkBJ2dmocM2rth+QSvhHHsyYHtPfCEzDBI9WKD3Y4x55SStA
 jrnjpw16f7QswN8Je6RjPdo+XkSF978jDy/SW8A+CwGjHAd7c4cwMuzfAEGGWvpg
 dcjiJWipqzoVBkB+ROYHpsJ0xVDkjqUzEj3Q36qdM6/3Pi0Pv/BJCLTkzcTD/dz6
 friEScIl/F6SIviEodVE7TL73NVFpSS3I03ilWcxttPe1srJpg10prc8431phEDp
 flzQCcKqmhIZuVDTFOsuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:mime-version:references:reply-to
 :subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1795086632; x=1795173032; bh=fM0dA5zGBy4mT
 TFWrG8U0ZRHXkHPtcZ1l1q/+z9lKcM=; b=be8v+/DqTqbifAzcezVqo7F5Q5mbR
 rnjjM5k6f1UxxcbaVcIlDoi8q692e08pDu/tlOYQM10DBfRn4fvh99ONs0qyufs7
 onD8xpacNn3IKANdzbDkwR/bqqDEm32w0ITX7FFDYtBXW1aIQZqGwoQhk2dtSaFN
 cxW37V3LRjZl1xQNuyXK4t/S2/AbvseZOaVialSmLtfLXhkN8eZbNR+c4zCuW51g
 B/aFQ3ibxzopk3yFiwIk7LkMLZZHXAXmhn8tkEABSnIYGB0C0MICa4reFxlbIJ9u
 c0cXbBimj1VytDxMXvEuKxcrea3JqzouW4pnuDCPF9PNukhfpkx3S794g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795086632; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:Dv0epgqMCs1LjX8arnARrO7+yEvmbPKE4u/Hw9th7lSqPRj
 UL0wrn12gZj9fnCtioQf8ZIUdm6l/n3SxGq8YUfmxVFTTzuu4duS0guwq6EcwY2R
 FRV8uArSbRfnvG+O5KaRulBmdToMfMg6yqMNGYGFKWm4vK4RvarL8RjvbtEO5UPj
 /nUX4852NUMxDYgBQJtEMuK6S/A6yOB0hEkGVUXh5LHg0vYpYahOKRj3xXfeAr5u
 m8mfxep/b2pdff2M51y2ZVYGkVsVhgY1gv8aCfPvfWawjmGPpPTksIuAkinyNq9D
 cNYZr4/WQ/C2qMA0KVM956LhHQzzj43p/jT0T7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:6t9FnAJRSe0m31TshcQG0ApfWk5dsfPbTCoS78pl+IA=:RyakNX6TsySNqfnX7UnPAQ1CVXhI8GqnWo8pdBVPjaU=;
X-ME-Sender: <xms:J9n-avZGZyZu1SCDAaPJGW8LGAuCwHySaRFoW36XPQDj17DqLR-DrQ>
 <xme:J9n-anWUfua2rsreX5zjNe70aj-FWKmIl92uIMZOR1pJyrTdnOO_W8KeeHg76jbjS
 P55jzsSky8wMT9uuH0r2qxa0TT-XOQRGi1RYCwc9qLApzV7A87Bhgyy>
X-ME-Received: <xmr:J9n-atibW4Wv8knK3kaClHGAdJdUd90VMwfznSiBq78Ax6EhjYEx5H-yig>
X-ME-Proxy-Cause: dmFkZTFqJljLHcXlkxWvGW9tdcpU28A/RmQYAJ1qQlNEGx2CEdHzlgQTcZmS9HMNMEFGeY
 +jEMn1GvHvErVZCvmJrD/6RJ3SLRHS3io+aXmC0eyyhqX0PZyYkHkuOnC0UvFxkabKrZTe
 OBT65pWCwiJT75VODyS+PzrDFi4oEEcaNklWb0eG+0jG2upbVKvK7d4ldcy9vJUkR0+Hhb
 syTYY6wirTD2N79uDsuaX2aFPeox7e1ffJynWPQ2Fp8w1bhZqp6VP1fZrFzNVtIkH4ote7
 BK+4TU1kC7WiRlfCnGXbF7xc0KUV6CvZjaTuQk8ThFlC9eNTK7KqvakuEU2nCp4097d4ig
 fbeDh8SaXeFEw1lAc00D/+SpVI8BjnV6DPFBnDyUnhkK9rPWIwOlKVKMDqzCb85QjmU25b
 ZMKWsJbWZTgm6N43Vn9BPE81i7tQnURXJWPK2SWp9FD3SJuxcPOicMotP10rFTx8e3xanU
 ped2K+XkJSa/uC+4S1oeDVCrc2RwPndSn0T0a2fOOCA6uE7K8NB1gsUFcqEb+262uGkflo
 IFyCMDZ2W4uKonAd0RSNeyzRJuwNTMRZN8I23SVEErYRqIoLacLGIiBtN5BO+zoe0AvjS0
 DwYOTvvLW6ittMnoExZKwEDqpTMebTc/hvMqrGGLfs4m9WzO0oSsqS33dGAA
X-ME-Proxy: <xmx:J9n-aluslgh52vIsaItWOwwySDp4QVxk3TtneDgiBiwEJULFzKZAPQ>
 <xmx:J9n-am5_qB1dMAPHdv_uglArWT6PBunpazcV215odyKioh8-BUPCqA>
 <xmx:J9n-apOFkMTx6XfW_lrbZKdYsGvRoy7XJ6A1POd_ngELLUP9N-Gbog>
 <xmx:J9n-asvAhI0U0uKsi6zKJ4T6GxA_U9T1XIvwB2gAxNFQ6eXj8PTpRw>
 <xmx:KNn-at-o2GquKV-2qN1QhEe7WyTKG4au01kaDFqjXzsXTZ2QxXgRlAhe>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:10:29 -0500 (EST)
Date: Thu, 19 Nov 2026 11:09:56 +0000
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 1/3] hw/nvme: fix open zone zrwa allocation
Message-ID: <20261119120956.0-foss@defmacro.it>
In-Reply-To: <20261118-fix-4520-v1-1-dfa182213376@samsung.com>
References: <20261118-fix-4520-v1-0-dfa182213376@samsung.com>
 <20261118-fix-4520-v1-1-dfa182213376@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0
X-Mailer: neolore
X-OriginalDate: 2026-11-19T12:09:56+01:00
Received-SPF: pass client-ip=103.168.172.149; envelope-from=foss@defmacro.it;
 helo=fout-a6-smtp.messagingengine.com
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



On Wed, 18 Nov 2026 13:45:34 +0100, Klaus Jensen <its@irrelevant.dk> wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> nvme_zrm_open_flags incorrectly allocates a ZRWA resource regardless of
> the zone state. A ZRWA resource shall only be allocated if
>
>     a) there are available ZRWA resources; and
>     b) the zone is empty.
>
> Fix the state machine and error out early.
>
> Cc: qemu-stable@nongnu.org
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
> Fixes: e321b4cdc2dd ("hw/nvme: add support for zoned random write area")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 5e8788a257da..16860ccd9520 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -2038,10 +2038,19 @@ enum {
>  static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
>                                      NvmeZone *zone, int flags)
>  {
> +    NvmeZoneState state = nvme_get_zone_state(zone);
> +
> +    bool zrwaa =
> +        (flags & NVME_ZRM_ZRWA) && !(zone->d.za & NVME_ZA_ZRWA_VALID);
> +
>      int act = 0;
>      uint16_t status;
>  
> -    switch (nvme_get_zone_state(zone)) {
> +    if (zrwaa && state != NVME_ZONE_STATE_EMPTY) {
> +        return NVME_INVALID_ZONE_OP | NVME_DNR;
> +    }
> +
> +    switch (state) {
>      case NVME_ZONE_STATE_EMPTY:
>          act = 1;
>  
> @@ -2051,8 +2060,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
>          if (n->params.auto_transition_zones) {
>              nvme_zrm_auto_transition_zone(ns);
>          }
> -        status = nvme_zns_check_resources(ns, act, 1,
> -                                          (flags & NVME_ZRM_ZRWA) ? 1 : 0);
> +        status = nvme_zns_check_resources(ns, act, 1, zrwaa);
>          if (status) {
>              return status;
>          }
> @@ -2080,7 +2088,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
>          /* fallthrough */
>  
>      case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> -        if (flags & NVME_ZRM_ZRWA) {
> +        if (zrwaa) {
>              ns->zns.numzrwa--;
>  
>              zone->d.za |= NVME_ZA_ZRWA_VALID;
>
> -- 
> 2.53.0
>
>
>

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>


