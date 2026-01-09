Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A41BD1A61D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 13:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veCdU-0007CL-KQ; Fri, 09 Jan 2026 08:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1veCdO-0007By-VG; Fri, 09 Jan 2026 08:34:36 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1veCdK-0002b9-Uw; Fri, 09 Jan 2026 08:34:33 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E6D4A596AC4;
 Fri, 09 Jan 2026 14:34:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Tc9MATuwDAiJ; Fri,  9 Jan 2026 14:34:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E03CD596AC0; Fri, 09 Jan 2026 14:34:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DE088596AC2;
 Fri, 09 Jan 2026 14:34:26 +0100 (CET)
Date: Fri, 9 Jan 2026 14:34:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 3/4] system/memory: Extract 'qemu/ldst_unaligned.h'
 header
In-Reply-To: <20260109063504.71576-4-philmd@linaro.org>
Message-ID: <10516ca5-58d4-b1d7-94cf-5d42febb3496@eik.bme.hu>
References: <20260109063504.71576-1-philmd@linaro.org>
 <20260109063504.71576-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2065475457-1767965666=:55707"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2065475457-1767965666=:55707
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 9 Jan 2026, Philippe Mathieu-Daudé wrote:
> Unaligned memcpy API is buried within 'qemu/bswap.h',
> supposed to be related to endianness swapping. Extract
> to a new header to clarify.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> MAINTAINERS                   |  1 +
> include/qemu/bswap.h          | 62 +-------------------------------
> include/qemu/ldst_unaligned.h | 67 +++++++++++++++++++++++++++++++++++
> accel/tcg/translator.c        |  1 +
> hw/display/ati_2d.c           |  1 +
> hw/display/sm501.c            |  2 +-
> hw/remote/vfio-user-obj.c     |  1 +
> hw/vmapple/virtio-blk.c       |  1 +
> net/checksum.c                |  1 +
> ui/vnc-enc-tight.c            |  1 +
> util/bufferiszero.c           |  2 +-
> 11 files changed, 77 insertions(+), 63 deletions(-)
> create mode 100644 include/qemu/ldst_unaligned.h

Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
--3866299591-2065475457-1767965666=:55707--

