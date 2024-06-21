Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E7EC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 12:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKcyy-00042q-Ko; Fri, 21 Jun 2024 08:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <macro@orcam.me.uk>) id 1sKcyf-0003jt-QZ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:02:50 -0400
Received: from angie.orcam.me.uk ([2001:4190:8020::34])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <macro@orcam.me.uk>) id 1sKcye-0004FV-1T
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:02:49 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 4141392009C; Fri, 21 Jun 2024 14:02:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id 3A86192009B;
 Fri, 21 Jun 2024 13:02:45 +0100 (BST)
Date: Fri, 21 Jun 2024 13:02:45 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: YunQiang Su <syq@debian.org>
cc: qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PATCH] mips: pass code of conditional trap
In-Reply-To: <CAKcpw6Vc9QkHWGxJmJwipaqEnGJZsPof7k25i9e1trtCTDVc=A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2406211258060.43454@angie.orcam.me.uk>
References: <20240620234633.74447-1-syq@debian.org>
 <alpine.DEB.2.21.2406210124020.43454@angie.orcam.me.uk>
 <CAKcpw6Vc9QkHWGxJmJwipaqEnGJZsPof7k25i9e1trtCTDVc=A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: none client-ip=2001:4190:8020::34;
 envelope-from=macro@orcam.me.uk; helo=angie.orcam.me.uk
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, 21 Jun 2024, YunQiang Su wrote:

> >  I haven't touched this stuff for ages, but AFAICT the code is already
> > passed where applicable via the environment for `do_tr_or_bp' to handle,
> > so I can't understand why your change is needed.
> >
> 
> The error_code in env is always zero, as we need to set it here.

 There is code to set it there already, so when submitting a fix you need 
to investigate why it doesn't work and describe in the change description.

> >  What problem are you trying to solve?
> >
> 
> See the talk in GCC mailing list about testsuite/ubsan/overflow-div-3.c
> Qemu emits SIGTRAP instead of SIGFPE, due to it didn't initialize the
> code of conditional trap to env.

 Self-contained information about the reproducer needs to be included in 
the change description.  A general statement such as "this and that does 
not work" or referring to another mailing list is not sufficient.

  Maciej

