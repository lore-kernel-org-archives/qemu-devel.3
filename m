Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED7DCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 12:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESDm-0007Qh-CR; Thu, 30 Oct 2025 08:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vESDj-0007QR-Ke
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vESDX-0001ZL-Eq
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761829027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jU5Wki8AIYfQomUxVle6GXYRqDBYassJ5K909zj9XU8=;
 b=CrkPIslDujxe8vhFSYrLqNPDKOZ8AC6mwKiMfJkUe9xg3hEec/ynaKH7WTN6OarU+RY5KL
 VX9oD0v0CtX+ZuI5CtxFliufthsw+y4vLw7VPPGusI7z0JW0hcyJ9DDsu39xhV6gkqQuEC
 QPyeBkXPncV6iJuAfv0VEd/mcEVaFrc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-O3cHxm1_PMaFBfxCCDHFpA-1; Thu,
 30 Oct 2025 08:57:04 -0400
X-MC-Unique: O3cHxm1_PMaFBfxCCDHFpA-1
X-Mimecast-MFC-AGG-ID: O3cHxm1_PMaFBfxCCDHFpA_1761829023
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 028891954B17; Thu, 30 Oct 2025 12:57:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF93C19560A2; Thu, 30 Oct 2025 12:57:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2F2BC1800080; Thu, 30 Oct 2025 13:56:58 +0100 (CET)
Date: Thu, 30 Oct 2025 13:56:58 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: NaNa Liu <nanliu@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 qemu-devel@nongnu.org, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: Re: [PATCH] docs/devel: Correct uefi-vars-x64 device name
Message-ID: <4xp5ewcaie4pbq4qlutrp7577sduwuo2di225lw3ijaqpukbnt@jhwxoo767jff>
References: <20250922065714.93081-1-nanliu@redhat.com>
 <CAFEAcA8pLFu6eOK5N+E97qo5PCp3OW3BRfYNSEL7=YQS6+eh2g@mail.gmail.com>
 <fcf01a1c-3503-4397-a41b-d453ca2b7df9@tls.msk.ru>
 <CAFEAcA_BR4VEsZrq1eq19E6iguk49W=Fx2OKQvkvTZ7_6Pd0KA@mail.gmail.com>
 <CANUVZAznv1aP5DH6pHEQBZGxczkoNVQfKR5oOV7eTyrk4rVrpQ@mail.gmail.com>
 <CAFEAcA8mC-VbD-29=7XLMiEQ0yhdKAaHzxWyKt5NXmUsjHgmBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8mC-VbD-29=7XLMiEQ0yhdKAaHzxWyKt5NXmUsjHgmBA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Oct 30, 2025 at 10:34:24AM +0000, Peter Maydell wrote:
> On Thu, 30 Oct 2025 at 05:47, NaNa Liu <nanliu@redhat.com> wrote:
> 
> The device name being "uefi-vars-x64" is unfortunate, but we
> can't change that. We should be consistent about how we talk
> about the architecture name in general when our hands are not
> tied by compatibility problems.

Well, UEFI has the habit of having their own architecture
names, which is where this comes from ...

  i386 -> ia32
  x86_64 -> x64
  aarch64 -> aa64

Luckily they stopped doing so, new architectures like riscv
and loongarch kept their name in the UEFI universe, so going
forward this confusion should at least not become worse than
it already is.

take care,
  Gerd


