Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA98E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 16:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZtuq-00013n-5p; Sun, 28 Dec 2025 11:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vZtug-000133-3k; Sun, 28 Dec 2025 11:46:39 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vZtue-0005U8-6W; Sun, 28 Dec 2025 11:46:37 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 49872596A0A;
 Sun, 28 Dec 2025 17:46:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 8DvPubEfB2K8; Sun, 28 Dec 2025 17:46:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4368F5969FF; Sun, 28 Dec 2025 17:46:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 411145969FD;
 Sun, 28 Dec 2025 17:46:26 +0100 (CET)
Date: Sun, 28 Dec 2025 17:46:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 David Hildenbrand <david@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, Alexander Graf <agraf@csgraf.de>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Jason Wang <jasowang@redhat.com>, 
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 2/3] system/memory: Extract 'qemu/memory_ldst_unaligned.h'
 header
In-Reply-To: <20251228161837.12413-3-philmd@linaro.org>
Message-ID: <ffcf5368-9b35-d1c8-16ba-6b517e056469@eik.bme.hu>
References: <20251228161837.12413-1-philmd@linaro.org>
 <20251228161837.12413-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1953544996-1766940386=:15422"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1953544996-1766940386=:15422
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 28 Dec 2025, Philippe Mathieu-Daudé wrote:
> Unaligned memcpy API is buried within 'qemu/bswap.h',
> supposed to be related to endianness swapping. Extract
> to a new header to clarify.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> include/qemu/bswap.h                 | 62 +------------------------
> include/qemu/memory_ldst_unaligned.h | 67 ++++++++++++++++++++++++++++
> accel/tcg/translator.c               |  1 +
> hw/display/ati_2d.c                  |  1 +
> hw/display/sm501.c                   |  2 +-
> hw/remote/vfio-user-obj.c            |  1 +
> hw/vmapple/virtio-blk.c              |  1 +
> net/checksum.c                       |  1 +
> ui/vnc-enc-tight.c                   |  1 +
> util/bufferiszero.c                  |  2 +-
> 10 files changed, 76 insertions(+), 63 deletions(-)
> create mode 100644 include/qemu/memory_ldst_unaligned.h
>
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index b77ea955de5..e8b944988c3 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -1,6 +1,7 @@
> #ifndef BSWAP_H
> #define BSWAP_H
>
> +#include "qemu/memory_ldst_unaligned.h"

If it's included here do users need to also include it separately or if so 
should some of those users lose bswap.h include now instead of including 
both this header and bswap.h? I think it's simpler to only include it here 
and let users get it through bswap.h unless you review and remove now 
unnecessary bswap.h includes from places that only need this hearder but 
I don't know if that's worth the effort.

Regards,
BALATON Zoltan
--3866299591-1953544996-1766940386=:15422--

