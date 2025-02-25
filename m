Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C05C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 17:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmyQv-0006Gl-2P; Tue, 25 Feb 2025 12:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1tmyQh-0006ES-Js
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:09:13 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1tmyQa-0002qv-Ek
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1740503338; bh=l4JP5th9g145iEpWQLMTjmwRHP7Mtsq0YD+kn4LEmJs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gAvy06kjmD0k7CyFIbeYHHL1GfdgNceXoJMRmYS/slJ1g1C0USyAiGvkeUT+0tylz
 6p0DE4IrSSkNmtkilfYPVGjZTxNtLJuK8bEvGWOkc8pnizMBInyWVROkAeTqc8uSqz
 IuM3m4BeMqMXBeg7yWjc0EzPpdOKSDxyFrmB/Z/s=
Date: Tue, 25 Feb 2025 07:41:06 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] linux-user/riscv: Disable unsupported SA_RESTORER
Message-ID: <020224cc-1b24-4124-926e-26643c528c90@t-8ch.de>
References: <20250202-riscv-sa-restorer-v1-1-6f4bf814a1dd@t-8ch.de>
 <CAKmqyKMeK8uAdkL+DNWODMnSiBMUQh_jkwe5ryn=q1pqZmnHMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMeK8uAdkL+DNWODMnSiBMUQh_jkwe5ryn=q1pqZmnHMA@mail.gmail.com>
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Alistair,

On 2025-02-24 14:10:19+1000, Alistair Francis wrote:
> On Mon, Feb 3, 2025 at 8:58 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > Linux on riscv does not support SA_RESTORER.
> > Currently QEMU thinks there is a field 'sa_restorer' in the middle of
> > 'struct sigaction' which does not actually exist.
> > This leads to corrupted data and out-of-bounds accesses.
> >
> > Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> 
> Thanks!
> 
> Applied to riscv-to-apply.next

Thanks, however this got superseded by Andreas Schwab's better
"linux-user: Move TARGET_SA_RESTORER out of generic/signal.h".

Could you drop it again?

[0] https://lore.kernel.org/qemu-devel/mvmed060xc9.fsf@suse.de/

