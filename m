Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1E606A339
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUWoJ-0005lw-Uo; Fri, 20 Nov 2026 17:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUWo7-0005j0-5J
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:10:11 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUWo5-0005le-Bb
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:10:10 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 179C760EB1C;
 Fri, 20 Nov 2026 23:10:08 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 4b3MGVbY_972; Fri, 20 Nov 2026 23:10:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E00EE60EB15; Fri, 20 Nov 2026 23:10:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DE47B13C290;
 Fri, 20 Nov 2026 23:10:05 +0100 (CET)
Date: Fri, 20 Nov 2026 23:10:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>
Subject: Re: [RFC PATCH-for-11.2? v4 06/14] hw/scsi: Move shared LSI/NCR
 definitions to lsi_scsi.h
In-Reply-To: <20261120171235.61325-7-philmd@oss.qualcomm.com>
Message-ID: <c793f759-94f9-65cf-972e-affd81b74c83@eik.bme.hu>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
 <20261120171235.61325-7-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1583701940-1795212605=:80696"
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1583701940-1795212605=:80696
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 20 Nov 2026, Philippe Mathieu-Daudé wrote:
> From: Keith Monahan <keith@techtravels.org>
>
> Move common defines and structures of the lsi53c895a driver to
> lsi_scsi.h so that the 53c710 driver can share them.
>
> Pure code movement, no functional change: nothing is renamed and the
> lsi53c895a device is unchanged.
>
> Licence: the moved code comes from lsi53c895a.c, which is licensed under
> the LGPL (Copyright (c) 2006 CodeSourcery, written by Paul Brook), so
> the new header keeps that licence (SPDX LGPL-2.1-or-later) rather than
> the preferred GPL-2.0-or-later; it is not relicensed.
>
> Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Keith Monahan <keith@techtravels.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
> AI-used-for: Patch series decomposition (commit splitting and ordering)
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
--3866299591-1583701940-1795212605=:80696--

