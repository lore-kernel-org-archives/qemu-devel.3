Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10F0C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz3c-000880-L6; Tue, 07 Jul 2026 02:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wgz3a-00086o-N0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:13:22 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wgz3Y-0000P3-GZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:13:22 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id CE30D240103
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 08:13:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1783404795;
 bh=H5GzUk8rjDpzZf7rbKzFBjZn9RzshrKB3GyNoSCAOK4=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=OD6PMW/TMptur4N6UiJtEvkyDawb4TTLEjL6Nbi3MR+Gx62OsI2esZjRCP0AQBzG4
 YXtMDj+JYq1gaaflNh4s2gm6v2PJ5CIwPuK0NaFxMBLpmGsyRPerWP3615DlDIeA74
 EOMNOR4e/7rpkzV/6EkaOUdecifLr+ijLbh1lesWZNQZplV9X9dAj0UdoOAf1DuE8s
 FPHLFTG6jthw6ixtu+5KPKc/W6R+9nLj66O+riewoN7JlHor64rAPSMAhxJyKB8Vya
 vSfRbS4Sm5Gb3Y7pEpA7XnOGfmd7a7kf6VMvwffO0mNPWtgGk27NCagUgKrJqecm8k
 DOu07XcpvDDaA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gvWB26Pgnz6tvm;
 Tue,  7 Jul 2026 08:13:14 +0200 (CEST)
Date: Tue, 07 Jul 2026 06:13:15 +0000
From: Thomas Huth <th.huth+qemu@posteo.eu>
To: Ganesh Harshan <ganeshredcobra@gmail.com>
Cc: philmd@mailo.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/functional: use QMP to query available machines
Message-ID: <20260707081314.575a2dd0@tpx1>
In-Reply-To: <20260703212111.69d835d8@tpx1>
References: <20260625165310.54113-1-ganeshredcobra@gmail.com>
 <20260703212111.69d835d8@tpx1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth+qemu@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Am Fri, 3 Jul 2026 21:21:11 +0200
schrieb Thomas Huth <th.huth+qemu@posteo.eu>:

> Am Thu, 25 Jun 2026 12:53:10 -0400
> schrieb Ganesh Harshan <ganeshredcobra@gmail.com>:
> 
> > Replace parsing of "qemu -M help" in set_machine() with
> > QMP "query-machines".
> > 
> > The previous approach relied on parsing human-readable CLI
> > output and substring matching, which is fragile and prone to
> > incorrect matches. It is also sensitive to output format changes.
> > 
> > Use QMP instead to retrieve structured machine information,
> > ensuring accurate matching and better maintainability.
> > 
> > Cache the result at the class level to avoid repeated QEMU
> > startup overhead.
> > 
> > Signed-off-by: Ganesh Harshan <ganeshredcobra@gmail.com>
> > ---
> >  tests/functional/qemu_test/testcase.py | 32 +++++++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 6 deletions(-)  
> 
>  Hi Ganesh,
> 
> seems like a bunch of tests are failing when I include this patch in my
> source tree:
> 
> 283/327 qemu:func-thorough+func-riscv64-thorough+thorough / func-riscv64-tuxrun               TIMEOUT         120.01s   killed by signal 15 SIGTERM
> 286/327 qemu:func-thorough+func-mipsel-thorough+thorough / func-mipsel-tuxrun                 TIMEOUT          90.01s   killed by signal 15 SIGTERM
> 289/327 qemu:func-thorough+func-mips-thorough+thorough / func-mips-tuxrun                     TIMEOUT          90.01s   killed by signal 15 SIGTERM
> 294/327 qemu:func-thorough+func-ppc64-thorough+thorough / func-ppc64-e500                     TIMEOUT          90.01s   killed by signal 15 SIGTERM
> 326/327 qemu:func-thorough+func-ppc-thorough+thorough / func-ppc-tuxrun                       TIMEOUT          90.01s   killed by signal 15 SIGTERM
> 327/327 qemu:func-thorough+func-xtensa-thorough+thorough / func-xtensa-lx60                   TIMEOUT          90.01s   killed by signal 15 SIGTERM
> 
> Are these working for you? Could you please have a look?
> 
> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> > index eaec1bea13..5920d6a784 100644
> > --- a/tests/functional/qemu_test/testcase.py
> > +++ b/tests/functional/qemu_test/testcase.py
> > @@ -314,14 +314,34 @@ def setUp(self):  
> ...
> > +        if machinename not in self._machines:
> >              self.skipTest('no support for machine ' + machinename)
> > +
> >          self.machine = machinename
> > +        self.vm.set_machine(machinename)  
> 
> The last line was not there before, why is it required now?

I noticed that the tests work fine again when I drop that line. So I'll go
ahead and pick up this patch without this line.

 Thomas

