Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2506FC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 12:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAuG-0007Sf-If; Wed, 14 May 2025 08:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uFAtz-0007FE-JF; Wed, 14 May 2025 08:07:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uFAtt-0001nr-ED; Wed, 14 May 2025 08:07:58 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1E58755CA52;
 Wed, 14 May 2025 14:07:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 4xPEvpM3PMFO; Wed, 14 May 2025 14:07:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1543B55C0CE; Wed, 14 May 2025 14:07:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 138B0745682;
 Wed, 14 May 2025 14:07:41 +0200 (CEST)
Date: Wed, 14 May 2025 14:07:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Zhao Liu <zhao1.liu@intel.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 4/9] hw/char/sh_serial: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
In-Reply-To: <20250514084957.2221975-5-zhao1.liu@intel.com>
Message-ID: <f8d5d5ac-9b79-ab87-6fd7-ac7bf025c3e7@eik.bme.hu>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-5-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-350596010-1747224461=:15654"
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

--3866299591-350596010-1747224461=:15654
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 14 May 2025, Zhao Liu wrote:
> The QOM type of SHSerialState is declared by OBJECT_DECLARE_SIMPLE_TYPE,
> which means it doesn't need the class!
>
> Therefore, use OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES to implement

Patch uses OBJECT_DEFINE_SIMPLE_TYPE not 
OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES so change commit message to 
match the patch.

Regards,
BALATON Zoltan

> the type, then there's no need for class definition.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> hw/char/sh_serial.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
> index 6abd80386fb4..8ccc2234ba4d 100644
> --- a/hw/char/sh_serial.c
> +++ b/hw/char/sh_serial.c
> @@ -78,9 +78,7 @@ struct SHSerialState {
>     qemu_irq bri;
> };
>
> -typedef struct {} SHSerialStateClass;
> -
> -OBJECT_DEFINE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)
> +OBJECT_DEFINE_SIMPLE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)
>
> static void sh_serial_clear_fifo(SHSerialState *s)
> {
>
--3866299591-350596010-1747224461=:15654--

