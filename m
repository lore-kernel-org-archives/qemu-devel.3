Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E61AC27C53
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 02:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHaUG-0004C9-EP; Wed, 12 Jun 2024 22:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sHaUE-0004Bq-Lb
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 22:46:50 -0400
Received: from 59-120-53-16.hinet-ip.hinet.net ([59.120.53.16]
 helo=mail.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sHaUB-0004EF-74
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 22:46:49 -0400
Received: from ethan84-VirtualBox (10.0.12.12) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 Jun 2024
 10:46:33 +0800
Date: Thu, 13 Jun 2024 10:46:32 +0800
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>
Subject: Re: [RFC PATCH] memory: Introduce memory region fetch operation
Message-ID: <ZmpdiB2blfm63fU1@ethan84-VirtualBox>
References: <20240612090132.3522566-1-ethan84@andestech.com>
 <CAFEAcA9W1EN7eO+qa6s9a870s8Zm-mD3T0mxRUY5hjY_-ZE4bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9W1EN7eO+qa6s9a870s8Zm-mD3T0mxRUY5hjY_-ZE4bQ@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.12]
Received-SPF: pass client-ip=59.120.53.16; envelope-from=ethan84@andestech.com;
 helo=mail.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 12, 2024 at 01:43:41PM +0100, Peter Maydell wrote:
> 
> On Wed, 12 Jun 2024 at 10:02, Ethan Chen via <qemu-devel@nongnu.org> wrote:
> >
> > Allow the memory region to have different behaviors for read and fetch
> > operations.
> >
> > For example RISCV IOPMP will raise interrupt when cpu try to fetch a
> > non-excutable region.
> 
> It actually raises an interrupt rather than it being a permissions fault?

Device can return bus error, interrupt or success with fabricated data.

> 
> > If fetch operation of a memory region is not implemented, it still uses the
> > read operation for fetch.
> 
> This patch should probably be part of the series with the device that
> needs it.

I will add this patch to IOPMP patch series.

Thanks,
Ethan

