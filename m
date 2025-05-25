Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1CEC54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 20:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJIP3-0003hi-4U; Sun, 25 May 2025 16:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJIOy-0003hA-AB
 for qemu-devel@nongnu.org; Sun, 25 May 2025 16:57:01 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJIOv-00047T-T1
 for qemu-devel@nongnu.org; Sun, 25 May 2025 16:56:59 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id C742B17F9A1
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:56:54 +0200 (CEST)
Received: (qmail 13308 invoked by uid 990); 25 May 2025 20:56:54 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 25 May 2025 22:56:54 +0200
From: Julian Ganz <neither@nut.email>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 03/25] plugins: add hooks for new discontinuity related
 callbacks
Date: Sun, 25 May 2025 22:56:42 +0200
Message-ID: <20250525205645.4366-2-neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <25151025-e2df-460c-8d54-431ce8cb2b88@linaro.org>
References: <cover.1747666625.git.neither@nut.email>
 <70c5a0d487731b08e803240061a97bfc110bfbcb.1747666625.git.neither@nut.email>
 <25151025-e2df-460c-8d54-431ce8cb2b88@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.999998)
 MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.099998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=WJ6SL6ZJxApFLdMYNkjbjhhojWCQG/DET7po3wEPf6o=;
 b=m1gu3VWaOEpzAcuPr02pvhnN+pJsEk/VxNWb7Iids1EBgan+Hhr/stq9COV0hYSMAbJFKWsgeY
 PiRwo24RNKmkpuDiZiqPh3y0QZsi8weaK/hf2SJT49rMn7SVTNayKk97G2tadXUPowfSbAMBMZV6
 +Eq4F1rYVw2UJUhdfuzPjpBEHIgk4OX9fbalm/iAHapk0vC1RB3x+WOP+y685M0n2l7Etxf3lasV
 RKeCwklbY/iZcvwHdl1Ch9MQskpf6Iv3gqe0FkEG6p+aw1uGZmf1mmIqF4/k3UdGoDQR1P+aC960
 vPs/OGGEQ5pNPxi5D6dvXeKHEDB3snxkqJBvcAjQM7ObOUFvKvL/E9mvpZQINYQFKJImIyAXaGIP
 On3N3CBkxWNmv0/djRFayPgeKYCqxc5fzGToFCWnEsQeo6wN8F914U7AAbXQoO3tDNS2k4P451pv
 rjFbXwWTB9uztI4FBpuFkk05Y79GWnpcJJDTAEaob/l67v9bQvDn5SMMyBswNoX7t6FjBjyDtLfM
 UHRG89C1hVi1p2AYrYl7BzbAUuDQkSaIMnTe0CEATro3fwwFNrC43x2QQR2MXHW3VubpTMREazx3
 PvX1/WUzwKRoVpXKThONm2RHhTVOzGXL002j+oqArCyP9FZIZ+64Cx2GnFMuxLeh+LnLXzZIjI5B
 0=
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

Richard Henderson wrote:
> On 5/19/25 16:19, Julian Ganz wrote:
> > diff --git a/plugins/core.c b/plugins/core.c
> > index dc1f5cb4d8..f07813d588 100644
> > --- a/plugins/core.c
> > +++ b/plugins/core.c
> > @@ -104,6 +104,44 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
> >       }
> >   }
> >   
> > +/*
> > + * Disable CFI checks.
> > + * The callback function has been loaded from an external library so we do not
> > + * have type information
> > + */
> > +QEMU_DISABLE_CFI
> > +static void plugin_vcpu_cb__discon(CPUState *cpu,
> > +                                   enum qemu_plugin_discon_type type,
> > +                                   uint64_t from)
> > +{
> > +    struct qemu_plugin_cb *cb, *next;
> > +    enum qemu_plugin_event ev;
> > +    uint64_t to = cpu->cc->get_pc(cpu);
> 
> Maybe cleaner to pass in @to.  It's readily available in the callers.

We originally did do that. However, we tried to reduce the noise we have at the
hook calling site to a minimum. And for some targets we would need to consult
get_pc anyway because the PC computation... takes more than one line.

I can still add the parameter. But especially given your latest sugestion of
altering the do_interrupt interface this may not be worth it.

Regards,
Julian

