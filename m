Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DBDC5B543
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 20:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJIP3-0003hm-3h; Sun, 25 May 2025 16:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJIP0-0003hU-4J
 for qemu-devel@nongnu.org; Sun, 25 May 2025 16:57:02 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJIOw-00047U-6q
 for qemu-devel@nongnu.org; Sun, 25 May 2025 16:57:00 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 186F117F983
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:56:55 +0200 (CEST)
Received: (qmail 13325 invoked by uid 990); 25 May 2025 20:56:55 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 25 May 2025 22:56:54 +0200
From: Julian Ganz <neither@nut.email>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Julian Ganz <neither@nut.email>, Stafford Horne <shorne@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v5 14/25] target/openrisc: call plugin trap callbacks
Date: Sun, 25 May 2025 22:56:43 +0200
Message-ID: <20250525205645.4366-3-neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <083923f4-26d2-4132-8ab0-80c3b465c036@linaro.org>
References: <cover.1747666625.git.neither@nut.email>
 <37da15321ffd8f3aa41ad2dadd591cc1f179feb1.1747666625.git.neither@nut.email>
 <083923f4-26d2-4132-8ab0-80c3b465c036@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-2.955801) MIME_GOOD(-0.1)
 R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.555801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=FGB7yJgT/E2lEZ2JfNp1243mAN435+rTiq347/XUH7k=;
 b=xU2N5Z9Y0J8futkGTpsuWp6Y5SZ1K/QpZB89SUSLX+8RsCCkjYpzNUJe/NsEGeAtU/EOa4EnDY
 QQUVACsXHbC31cf2sONY1maIKUHNfZ5bB+ivhvQnrn3ELdezcwHUvEO90831Ha9Ai97aNrNstqRF
 3Qk7Cv0YnZmhyyyn2K2M9eTvWv7JUmupwq6HnpIfnU/YiejVeOmHB970LBPhsVMfENjaU3BTDL0j
 M4yclne7iev+D1/s1nTuNJB/Vcl2ClImQGmZTuTaGAxd/pYyJ5qWhwuuGCePQAawqRstfuOaDPgp
 cmyUwwEb6p1X13m2UFY9JdJgqSIOBw6fbG+SCOmtu2fexx4hPRSdYyGGjPPQi6wZAeesc4fzP04R
 J+q1ZkSA3z3qSDJHKbwFOKEBxUfSfRJQ7+dK0yi6fGCtaiZ56s771KedKLashqXBhxg7k94l4qyc
 J+Pi/kF7S2BYlrVPJSryt+NBDKyHyiy++HhvevlAv/287d4TDrBkmG4vzH0W+Mj2K3tvr9louebB
 9hwRheGlDcHd5qO6N3J84gg+sO/2FRyCOwGdt+LrWdgalUIAcUWx8XSthuhNeXa+vt8VnYMIaWrT
 RwGnaBwahnyEMCxFgKL6jFrgq/m/qJTJ+POiMVkLN/JxBGByF4uWI+PKOVlozq439Cs39b1quxE+
 M=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Richard,

> On 5/19/25 16:19, Julian Ganz wrote:
> > diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> > index 486823094c..08f0ed9b89 100644
> > --- a/target/openrisc/interrupt.c
> > +++ b/target/openrisc/interrupt.c
> > @@ -25,11 +25,13 @@
> >   #ifndef CONFIG_USER_ONLY
> >   #include "hw/loader.h"
> >   #endif
> > +#include "qemu/plugin.h"
> >   
> >   void openrisc_cpu_do_interrupt(CPUState *cs)
> >   {
> >       CPUOpenRISCState *env = cpu_env(cs);
> >       int exception = cs->exception_index;
> > +    uint64_t last_pc = env->pc;
> >   
> >       env->epcr = env->pc;
> >   
> > @@ -98,6 +100,17 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
> >           cpu_abort(cs, "Unhandled exception 0x%x\n", exception);
> >       }
> >   
> > +    switch (exception) {
> > +    case EXCP_RESET:
> 
> There are plenty of other EXCP_RESET uses that aren't marked as interrupt.
> Bug?

Mh... I might not have been perfectly consistent with resets. We do expect
plugins to be notified of resets already, so we probably don't want to trigger
exception or interrupt callbacks.

I'll check and adjust for the next series.

Regards,
Julian

