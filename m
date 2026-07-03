Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE1DC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfjRy-0000HP-07; Fri, 03 Jul 2026 15:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wfjRw-0000HH-6v
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 15:21:20 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wfjRu-00065A-66
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 15:21:19 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 4CCE2240101
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2026 21:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1783106473;
 bh=rPS5i05yelkAp3sh2/8wcUbUsfLQ1xK7XkqmCF+E7CE=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=UJgravfRXeE5i3e8me02504xMHFoxSpdlWyAmF3+VBicbwMSNvWpjP1qk9GlqBSEq
 PeYAfNY4WhVFuVVtokeTPdnMjl0OW7xiC4IAtgXaPFukRdpInXlDUfCO6PkjI6a5jf
 e0YIBh4Tse18ifPr/M7kXHaBUkCaNO5Z0asfX2Q2E4V2HBLCxPL110pcK2Z6p+gfnQ
 OO9iA7RmbH5yH4ihtODdpGQ6CvceA7ao+70b3Q4FCu8aVD4gLaSJBn1/wCwY3vQsWu
 XsfwD5+3otuM1e99VuQFSBcATHpbo/M61Lz9MwR++k57DCVL8aSSVYKN4jbgcE4iSe
 BViiBfc/67ewA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gsNs40xSFz9rxB;
 Fri,  3 Jul 2026 21:21:12 +0200 (CEST)
Date: Fri, 03 Jul 2026 19:21:13 +0000
From: Thomas Huth <th.huth+qemu@posteo.eu>
To: Ganesh Harshan <ganeshredcobra@gmail.com>
Cc: philmd@mailo.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/functional: use QMP to query available machines
Message-ID: <20260703212111.69d835d8@tpx1>
In-Reply-To: <20260625165310.54113-1-ganeshredcobra@gmail.com>
References: <20260625165310.54113-1-ganeshredcobra@gmail.com>
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

Am Thu, 25 Jun 2026 12:53:10 -0400
schrieb Ganesh Harshan <ganeshredcobra@gmail.com>:

> Replace parsing of "qemu -M help" in set_machine() with
> QMP "query-machines".
> 
> The previous approach relied on parsing human-readable CLI
> output and substring matching, which is fragile and prone to
> incorrect matches. It is also sensitive to output format changes.
> 
> Use QMP instead to retrieve structured machine information,
> ensuring accurate matching and better maintainability.
> 
> Cache the result at the class level to avoid repeated QEMU
> startup overhead.
> 
> Signed-off-by: Ganesh Harshan <ganeshredcobra@gmail.com>
> ---
>  tests/functional/qemu_test/testcase.py | 32 +++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 6 deletions(-)

 Hi Ganesh,

seems like a bunch of tests are failing when I include this patch in my
source tree:

283/327 qemu:func-thorough+func-riscv64-thorough+thorough / func-riscv64-tuxrun               TIMEOUT         120.01s   killed by signal 15 SIGTERM
286/327 qemu:func-thorough+func-mipsel-thorough+thorough / func-mipsel-tuxrun                 TIMEOUT          90.01s   killed by signal 15 SIGTERM
289/327 qemu:func-thorough+func-mips-thorough+thorough / func-mips-tuxrun                     TIMEOUT          90.01s   killed by signal 15 SIGTERM
294/327 qemu:func-thorough+func-ppc64-thorough+thorough / func-ppc64-e500                     TIMEOUT          90.01s   killed by signal 15 SIGTERM
326/327 qemu:func-thorough+func-ppc-thorough+thorough / func-ppc-tuxrun                       TIMEOUT          90.01s   killed by signal 15 SIGTERM
327/327 qemu:func-thorough+func-xtensa-thorough+thorough / func-xtensa-lx60                   TIMEOUT          90.01s   killed by signal 15 SIGTERM

Are these working for you? Could you please have a look?

> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index eaec1bea13..5920d6a784 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -314,14 +314,34 @@ def setUp(self):
...
> +        if machinename not in self._machines:
>              self.skipTest('no support for machine ' + machinename)
> +
>          self.machine = machinename
> +        self.vm.set_machine(machinename)

The last line was not there before, why is it required now?

 Thomas


>      def require_accelerator(self, accelerator):
>          """

