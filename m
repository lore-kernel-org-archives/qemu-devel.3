Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0436FEB26F5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 18:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpsL6-0005W0-U5; Tue, 10 Feb 2026 13:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1vpsKm-0005Ub-UX; Tue, 10 Feb 2026 13:19:37 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1vpsKl-0003s8-OH; Tue, 10 Feb 2026 13:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=1bABdd10ofoeT6g8Hs37Al8fGiJDZRR4k2IUCNAmkwU=; b=LTesoVqd5Dgm3nXym2i3
 e1LbfqhgESSQqIBMZCf1ZjUrh/WPemjHru4ANgzqc5YutKva7KwkHgT4hlrUibz7eCiHNqoIcJYA4
 EWt81fxAGCEEIAnAQGIHbgrJHZwWXFqdyCSozgaopOV4sv7G7CQwS9ISEx3Y/klHPtPckgeDwWMPN
 qF5rUyQQRtmaOmIjv0x4DUl7LpLgS50JpqkxnTzmaxR02g4jaRdsjT162u46LvEdq3P9bBaKvfqp6
 zKMhC35QjhOLRqpIJwGAHJrDNu5CWMMtknj8LOLL0DrVSqLD4nBos2PxZ6BVqhMPnG4pgMWtiOz9A
 mLShRrLl5r9rDA==;
Date: Tue, 10 Feb 2026 19:19:28 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Damien Zammit <damien@zamaudio.com>,
 Paolo Bonzini <pbonzini@redhat.com>, bug-hurd@gnu.org,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 manolodemedici@gmail.com, peter.maydell@linaro.org,
 kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: Re: [PATCH v3 3/4 qemu] Exclude TPM ioctls definitions for the
 GNU/Hurd
Message-ID: <aYt2sI528aXvojvi@end>
Mail-Followup-To: Stefan Berger <stefanb@linux.ibm.com>,
 Damien Zammit <damien@zamaudio.com>,
 Paolo Bonzini <pbonzini@redhat.com>, bug-hurd@gnu.org,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 manolodemedici@gmail.com, peter.maydell@linaro.org,
 kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com,
 bugaevc@gmail.com
References: <20260130031954.1661880-1-damien@zamaudio.com>
 <20260130031954.1661880-4-damien@zamaudio.com>
 <ac182e8e-cd4f-467b-b6a8-31f03b70b3b9@redhat.com>
 <26b39a30-8ef0-4f68-af65-58a6718226a6@linux.ibm.com>
 <5d9dd511-117f-21a6-1e2e-eed22077aaa1@zamaudio.com>
 <fae6eb21-6ed4-41fb-ad6f-4ef44b2e7f44@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fae6eb21-6ed4-41fb-ad6f-4ef44b2e7f44@linux.ibm.com>
Organization: I am not organized
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

Hello,

Stefan Berger, le mar. 10 févr. 2026 12:58:24 -0500, a ecrit:
> On 2/7/26 11:03 PM, Damien Zammit wrote:
> > On 2/4/26 2:21 AM, Stefan Berger wrote:
> > > enum {
> > >        PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
> > >        PTM_INIT               = _IOWR('P', 1, ptm_init),
> > >        PTM_SHUTDOWN           = _IOR('P', 2, ptm_res),
> > 
> > No, this wont work because the _IOT__IOTBASE_* symbols are missing for
> > the tpm structs on GNU platform:
> 
> > 
> > In file included from /usr/include/x86_64-gnu/sys/ioctl.h:26,
> >                    from ../backends/tpm/tpm_ioctl.h:17,
> >                    from ../backends/tpm/tpm_emulator.c:39:
> > ../backends/tpm/tpm_ioctl.h:290:30: error: ‘_IOT__IOTBASE_ptm_cap’
> > undeclared here (not in a function)
> >     290 |     PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
> >         |                              ^~~~
> 
> I have it compile because I added this here (above):
> 
> #ifdef __gnu_hurd__
> #include <mach/x86_64/ioccom.h>
> #endif

This mach-ish ioccom.h is not the way ioctls are defined in the Hurd. I
have actually even dropped it from gnumach, since we don't actually use
this way of defining ioctls any more. _IOT macros for ptm_capt/init/res
really need to be defined for _IOR/WR to be usable.

Samuel

