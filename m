Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F28BC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 00:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP9TE-0002qD-0n; Tue, 10 Jun 2025 20:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uP9T9-0002ph-Bh; Tue, 10 Jun 2025 20:37:31 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uP9T7-0007sT-Vx; Tue, 10 Jun 2025 20:37:31 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 31B1A55C1B9;
 Wed, 11 Jun 2025 02:37:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id q54VDriHUkH2; Wed, 11 Jun 2025 02:37:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4016D55C171; Wed, 11 Jun 2025 02:37:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3E1B4745683;
 Wed, 11 Jun 2025 02:37:26 +0200 (CEST)
Date: Wed, 11 Jun 2025 02:37:26 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 3/5] scripts/meson-buildoptions: Sort coroutine_backend
 choices lexicographically
In-Reply-To: <20250610204131.2862-4-shentey@gmail.com>
Message-ID: <9c873c0c-67ba-7f47-b7eb-316a62b09f0f@eik.bme.hu>
References: <20250610204131.2862-1-shentey@gmail.com>
 <20250610204131.2862-4-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 10 Jun 2025, Bernhard Beschow wrote:
> When changing meson_options.txt, this script gets updated automatically by QEMU
> tooling which sorts the choices lexicographically. Fix this in preparation of
> the ext patch.

Typo: next patch

> Fixes: ccc403ed5844 ("meson: Add wasm build in build scripts")
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> scripts/meson-buildoptions.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index f09ef9604f..73e0770f42 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -80,7 +80,7 @@ meson_options_help() {
>   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
>   printf "%s\n" '                           [NORMAL]'
>   printf "%s\n" '  --with-coroutine=CHOICE  coroutine backend to use (choices:'
> -  printf "%s\n" '                           auto/sigaltstack/ucontext/windows/wasm)'
> +  printf "%s\n" '                           auto/sigaltstack/ucontext/wasm/windows)'
>   printf "%s\n" '  --with-pkgversion=VALUE  use specified string as sub-version of the'
>   printf "%s\n" '                           package'
>   printf "%s\n" '  --with-suffix=VALUE      Suffix for QEMU data/modules/config directories'
>

