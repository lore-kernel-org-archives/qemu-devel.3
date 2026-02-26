Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A5AFD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjkv-0004oq-TR; Thu, 26 Feb 2026 17:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vvjkt-0004oV-AN
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:22:47 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vvjkq-00068W-Dw
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:22:46 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E84F95972DF;
 Thu, 26 Feb 2026 23:22:34 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id XFAdlrZg-mTT; Thu, 26 Feb 2026 23:22:32 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A80535969F6; Thu, 26 Feb 2026 23:22:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A5E6B5969E4;
 Thu, 26 Feb 2026 23:22:32 +0100 (CET)
Date: Thu, 26 Feb 2026 23:22:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 1/7] stubs: Merge physmem.c within ram-block.c
In-Reply-To: <20260226220226.20164-2-philmd@linaro.org>
Message-ID: <8a2872f3-dfbb-3fed-dd95-3cd474e3ca2b@eik.bme.hu>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1837863029-1772144552=:40301"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1837863029-1772144552=:40301
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 26 Feb 2026, Philippe Mathieu-Daudé wrote:
> physmem.c defines 2 stubs which are related to ram-block:
> qemu_ram_block_from_host() and qemu_ram_get_fd().
> Move them with the other ram-block stubs.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> stubs/physmem.c   | 13 -------------
> stubs/ram-block.c | 11 +++++++++++

Maybe should be the other way around moving what's in subs/ram-block.c to 
stubs/physmem.c considering the the functions these stub out are in 
system/physmem.c and there's no system/ram-block.c.

Regards,
BALATON Zoltan

> stubs/meson.build |  1 -
> 3 files changed, 11 insertions(+), 14 deletions(-)
> delete mode 100644 stubs/physmem.c
>
> diff --git a/stubs/physmem.c b/stubs/physmem.c
> deleted file mode 100644
> index 14667f2bd8f..00000000000
> --- a/stubs/physmem.c
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#include "qemu/osdep.h"
> -#include "system/ramblock.h"
> -
> -RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
> -                                   ram_addr_t *offset)
> -{
> -    return NULL;
> -}
> -
> -int qemu_ram_get_fd(RAMBlock *rb)
> -{
> -    return -1;
> -}
> diff --git a/stubs/ram-block.c b/stubs/ram-block.c
> index 8790a59593e..f0650b19ac6 100644
> --- a/stubs/ram-block.c
> +++ b/stubs/ram-block.c
> @@ -35,3 +35,14 @@ int ram_block_discard_disable(bool state)
> {
>     return 0;
> }
> +
> +RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
> +                                   ram_addr_t *offset)
> +{
> +    return NULL;
> +}
> +
> +int qemu_ram_get_fd(RAMBlock *rb)
> +{
> +    return -1;
> +}
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 8a07059500d..0171f531523 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -20,7 +20,6 @@ if have_block
>   stub_ss.add(files('get-vm-name.c'))
>   stub_ss.add(files('iothread-lock-block.c'))
>   stub_ss.add(files('migr-blocker.c'))
> -  stub_ss.add(files('physmem.c'))
>   stub_ss.add(files('ram-block.c'))
>   stub_ss.add(files('runstate-check.c'))
>   stub_ss.add(files('uuid.c'))
>
--3866299591-1837863029-1772144552=:40301--

