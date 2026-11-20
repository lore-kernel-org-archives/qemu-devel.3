Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7F606A6B9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUWyp-0000hL-8s; Fri, 20 Nov 2026 17:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUWyo-0000h5-10
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:21:14 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUWym-0006lO-Jq
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:21:13 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 13FD460E017;
 Fri, 20 Nov 2026 23:21:11 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id h_5cdemmNWKC; Fri, 20 Nov 2026 23:21:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D624760CCE7; Fri, 20 Nov 2026 23:21:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D00E113C28F;
 Fri, 20 Nov 2026 23:21:08 +0100 (CET)
Date: Fri, 20 Nov 2026 23:21:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>
Subject: Re: [RFC PATCH-for-11.2? v4 14/14] hw/scsi/ncr53c710: Bump the
 migration version
In-Reply-To: <20261120171235.61325-15-philmd@oss.qualcomm.com>
Message-ID: <6e5c81cb-e2ce-d98d-0307-469b274feed0@eik.bme.hu>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
 <20261120171235.61325-15-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-2056871034-1795213139=:80696"
Content-ID: <30d3b125-e920-0d62-f250-bb88dbb3a0a2@eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2056871034-1795213139=:80696
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <fda42578-7924-575e-e834-43b655795d86@eik.bme.hu>

On Fri, 20 Nov 2026, Philippe Mathieu-Daudé wrote:
> From: Keith Monahan <keith@techtravels.org>
>
> The migration format is incompatible with the model this replaces, so
> the ncr710 and lasi_ncr710 vmstate descriptions raise minimum_version_id
> in lockstep: an old stream is rejected rather than silently misparsed.
> sigp_pending_resume is a version 3 field: a deferred SIGP kick can be
> live across a migration point.
>
> Intermediate patches of this series do not preserve migration streams.

Should this be squashed in the patch that changes the VMState (i.e. patch 
7) or come right after it instead of at end of series? Also why 
there is version 3 when there are only two versions?

Regards,
BALATON Zoltan

> Signed-off-by: Keith Monahan <keith@techtravels.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
> AI-used-for: Patch series decomposition (commit splitting and ordering)
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
> hw/scsi/lasi_ncr710.c |  4 ++--
> hw/scsi/ncr53c710.c   | 11 ++++++++---
> 2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
> index c8a28cd987b8..62608d039c1e 100644
> --- a/hw/scsi/lasi_ncr710.c
> +++ b/hw/scsi/lasi_ncr710.c
> @@ -163,8 +163,8 @@ static const MemoryRegionOps lasi_ncr710_mmio_ops = {
>
> static const VMStateDescription vmstate_lasi_ncr710 = {
>     .name = "lasi-ncr710",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>     .fields = (const VMStateField[]) {
>         VMSTATE_STRUCT(ncr710, LasiNCR710State, 1, vmstate_ncr710, NCR710State),
>         VMSTATE_END_OF_LIST()
> diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
> index af26d26a05bb..4a37d011f229 100644
> --- a/hw/scsi/ncr53c710.c
> +++ b/hw/scsi/ncr53c710.c
> @@ -1674,8 +1674,9 @@ static int lsi_post_load(void *opaque, int version_id)
>
> const VMStateDescription vmstate_ncr710 = {
>     .name = "ncr710",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    /* minimum_version_id rejects streams from the earlier 53C710 model. */
> +    .version_id = 3,
> +    .minimum_version_id = 2,
>     .pre_save = lsi_pre_save,
>     .post_load = lsi_post_load,
>     .fields = (const VMStateField[]) {
> @@ -1689,7 +1690,11 @@ const VMStateDescription vmstate_ncr710 = {
>         VMSTATE_UINT32(select_tag, NCR710State),
>         VMSTATE_INT32(command_complete, NCR710State),
>         VMSTATE_BOOL(script_running, NCR710State),
> -        VMSTATE_BOOL(sigp_pending_resume, NCR710State),
> +        /*
> +         * Version 3+.  A deferred SIGP kick can be live across a migration
> +         * point.
> +         */
> +        VMSTATE_BOOL_V(sigp_pending_resume, NCR710State, 3),
>
>         VMSTATE_UINT8(scntl0, NCR710State),
>         VMSTATE_UINT8(scntl1, NCR710State),
>
--3866299591-2056871034-1795213139=:80696--

