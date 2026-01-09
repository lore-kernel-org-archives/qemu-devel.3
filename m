Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAE7D1A623
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 13:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veCqg-00018U-24; Fri, 09 Jan 2026 08:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1veCqd-000189-Kg; Fri, 09 Jan 2026 08:48:15 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1veCqb-0006Io-59; Fri, 09 Jan 2026 08:48:15 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2BA9F596AC4;
 Fri, 09 Jan 2026 14:48:09 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 1GBFnTWJ0BNH; Fri,  9 Jan 2026 14:48:07 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1C372596AC0; Fri, 09 Jan 2026 14:48:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1A287596ABD;
 Fri, 09 Jan 2026 14:48:07 +0100 (CET)
Date: Fri, 9 Jan 2026 14:48:07 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, Alexander Graf <agraf@csgraf.de>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 4/4] system/memory: Rename unaligned load/store API
In-Reply-To: <20260109063504.71576-5-philmd@linaro.org>
Message-ID: <f36ff8f3-98a5-8f8c-c6c7-069130e5a64c@eik.bme.hu>
References: <20260109063504.71576-1-philmd@linaro.org>
 <20260109063504.71576-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-232431866-1767966388=:55707"
Content-ID: <25dc31bb-7aff-29ac-9cf4-21377acb69de@eik.bme.hu>
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

--3866299591-232431866-1767966388=:55707
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <141c39c4-17da-addc-10a7-90ad8ea2c2b3@eik.bme.hu>

On Fri, 9 Jan 2026, Philippe Mathieu-Daudé wrote:
> Rename the API methods using the explicit 'unaligned'
> description instead of 'he' which stands for 'host
> endianness'.

I still think it would be easier to add a comment somewhere (or in 
documentation) that host endian stands for no swap just use what the host 
uses (that also explains what be|le will swap relative to) and then not 
rename any of these. The le|be variants are also based he so do you rename 
those to lduw_le_unaligned_p too? This gets unwieldy. If you want to get 
rid of he at any rate then maybe just drop it and make the host endian 
variants lduw_p without any endian notation but I see no problem keeping 
he and save the curn. Probably you only want to get rid of target endian 
or native endian and could leave the rest?

Regards,
BALATON Zoltan

> Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> docs/devel/loads-stores.rst    | 19 +++++++++----------
> include/qemu/bswap.h           | 34 +++++++++++++++++-----------------
> include/qemu/ldst_unaligned.h  | 16 ++++++++--------
> accel/tcg/translator.c         |  6 +++---
> hw/display/ati_2d.c            |  2 +-
> hw/display/sm501.c             | 19 +++++++++++--------
> hw/remote/vfio-user-obj.c      |  4 ++--
> hw/vmapple/virtio-blk.c        |  2 +-
> net/checksum.c                 |  6 +++---
> system/memory.c                |  4 ++--
> system/physmem.c               |  8 ++++----
> ui/vnc-enc-tight.c             |  2 +-
> util/bufferiszero.c            |  6 +++---
> accel/tcg/ldst_atomicity.c.inc | 10 +++++-----
> 14 files changed, 70 insertions(+), 68 deletions(-)
--3866299591-232431866-1767966388=:55707--

