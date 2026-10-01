Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB6FCA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCPh8-0003aK-E2; Thu, 01 Oct 2026 18:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPh5-0003a6-S3; Thu, 01 Oct 2026 18:56:03 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPh3-0007R7-V3; Thu, 01 Oct 2026 18:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=UFkq2mn
 EZ2KElLPoHZSTvRTYIGqKaJf7qhl2nEx6GYjuSJz3zfIuZmKzLB09hMuuTgPWwtTGJSLVJ
 80xmRE4v+sP8yBR5+bE6dxMxuXF6Pw2wb6UzqW6WflQvDVOnd8G7vUdg/fkcYUjeIqCVZi
 p70jsmlSgKOlb4z86XFk+2Io7iW02HmNXJt1s3HxVAkbTGiX0mw5HL5/i0OtOY7pyQIuxc
 fZaSug29FHmWx1jifwM0XQ60fTt7bfQYfLLPzUGKNacsLK5l5i+ADMHBr/U9yaGwI/Xhzk
 rnPqXHecREF/YB0RV+LZyxyskOOWQ4/UPaSiEr6YiVc8znVdPBFGKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=D
 +MYmH2gNjJF78dS6+8McvaqbCDx7TXO68m+FMO6qmA=;
 h=references:in-reply-to:
 subject:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net; b=
 Zzma3ZT5bf1jtHFSExlcy91AN0ApX+pnmrCBSJfw78VHUNP6nqBi3HFPgvT97kPR3j8t3L
 BwS7TGJzr2Gr6RybLE8koEsZVotw0U0ilLyDljvksZYEw9uWcGwEKScQHybFKqpZrtUlPW
 X4pe7iq8SGaCT1tbLu9hOUpxDBwOhkH14SFf3qDu+umlLYncMeNv5HMJKidNg17ie3NSWt
 Wj2YlKMASo0XlDWNsm6HGzYMoRSyxM056BoaZTP5tfgCJ5YipF3Pz3/lwX29/lqWXjFPfG
 X5l0TIDbFzjRFk3BN+99tOwliOryL+nWfokgf8UhhmOHS73O0eIobWRDpdGoPw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=ZfdUW5Jb; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=GMlDHKO/;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=D+MYmH2g
 NjJF78dS6+8McvaqbCDx7TXO68m+FMO6qmA=; h=references:in-reply-to:
 subject:to:from:date; d=korins.ky;
 b=ZfdUW5JbliCE/4UZLJ1FeCQS3MzXx8N21
 vpsDDYJ8Lrr8+F7Mk2S90Y8/PwvWoGsqujnMYGvAey5LNYik6U5kar87mcj0RopL2Qzh07
 QtbMRkDLRgU4E+Cw+i5foAz7f6T4f+dr7KMpBnfY0bPez58S7zDsNvvVdIFqZRD0U4U1Mx
 BqHc7oWgLJdGszs7wQbEFzOEOKfy/NdYzk1bDqr0XuEyBgq5eTzLaVbwtpBJr+0IpYw0V9
 ib9k6u1i1cP1rgG2iKm2HIgTBySRYliX6E3iDi6f+lpa1Xy36Ev4LPYi/7PGKVrA/WU7ct
 IhpYlPU6D0CDLOmxj9EhQs+h1/67g==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=D+MYmH2gNjJF78dS6+8McvaqbCDx7TXO68m+FMO6qmA=; h=references:
 in-reply-to:subject:to:from:date; d=korins.ky; b=GMlDHKO/nZ/06mfCRzo4Q
 xCnF8RQRb4D592AnDcbZyxpe5ib12J0sqObc96XY9GonQ2XetGx7FTgkfG+cWgsDw==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id f33585b2
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 2 Oct 2026 00:55:55 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) id 8537968d;
 Fri, 2 Oct 2026 00:55:54 +0200 (CEST)
Date: Fri, 02 Oct 2026 00:55:54 +0200
Message-ID: <877bk1c9ol.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] ppc: Raise decrementer IRQ on zero write
In-Reply-To: <20261001143415.3f3b33fc-f8-amachhiw@linux.ibm.com>
References: <20260923230452.3765-1-kirill@korins.ky>
 <20260923230452.3765-3-kirill@korins.ky>
 <20261001143415.3f3b33fc-f8-amachhiw@linux.ibm.com>
User-Agent: Wanderlust
Mail-Followup-To: kirill@korins.ky, mark.cave-ayland@ilande.co.uk,
 rathc@linux.ibm.com, npiggin@gmail.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, anushree.mathur@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 01 Oct 2026 11:10:18 +0200,
Amit Machhiwal <amachhiw@linux.ibm.com> wrote:
> 
> On 2026/09/24 01:03 AM, Kirill A. Korinsky wrote:
> > From: "Kirill A. Korinsky" <kirill@korins.ky>
> > 
> > OpenBSD writes zero to an edge triggered decrementer, then enters idle
> > expecting its interrupt. QEMU defers the already due edge to a timer at
> > the current virtual time, leaving the guest stalled.
> > 
> > Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  hw/ppc/ppc.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > index b123b4cc1c..736a37d32b 100644
> > --- a/hw/ppc/ppc.c
> > +++ b/hw/ppc/ppc.c
> > @@ -885,10 +885,17 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
> >       * an edge interrupt, so raise it here too.
> >       */
> >      if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> > +        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
> 
> Thanks for the v2 — you got the guard right (PPC_DECR_ZERO_TRIGGERED in
> __cpu_ppc_store_decr), but the flag-setting landed in the wrong place.
> 
> >          ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
> >            && signed_decr >= 0)) {
> >          (*raise_excp)(cpu);
> >          return;
> > +    } else {
> > +        /*
> > +         * Classic 32-bit edge-triggered decrementer: zero write fires
> > +         * immediately
> > +         */
> > +        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
> 
> My suggestion was to set PPC_DECR_ZERO_TRIGGERED once at init time in
> cpu_ppc_tb_init().  In v2 it ended up inside the else block of
> __cpu_ppc_store_decr() instead.
> 
> That mutates tb_env->flags at runtime on every DEC write that does not
> immediately fire.  PPE42 goes through ppc_booke_timers_init() and gets
> PPC_DECR_UNDERFLOW_TRIGGERED but not PPC_DECR_ZERO_TRIGGERED.  The first time a
> guest writes a non-zero value to DEC on PPE42, this else block stamps
> PPC_DECR_ZERO_TRIGGERED onto tb_env->flags — from that point on, every zero
> write fires immediately, which contradicts the PPE42 architecture (commit
> 7197f6f7baf2).
> 
> The fix is the same two-liner I included in my v1 response:
>

Sorry, I had applied your diff manually and for some unknown for me reason
messed it up.

v3 will be sent shortly.

> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index b123b4cc1cce..6f99b61a2876 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
>       * an edge interrupt, so raise it here too.
>       */
>      if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> +        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
>          ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>            && signed_decr >= 0)) {
>          (*raise_excp)(cpu);
> @@ -1104,6 +1105,12 @@ void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq)
>      if (is_book3s_arch2x(env)) {
>          /* All Book3S 64bit CPUs implement level based DEC logic */
>          tb_env->flags |= PPC_DECR_UNDERFLOW_LEVEL;
> +    } else {
> +        /*
> +         * Classic 32-bit edge-triggered decrementer: zero write fires
> +         * immediately
> +         */
> +        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
>      }
>      /* Create new timer */
>      tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> 
> PPE42 never enters cpu_ppc_tb_init() — it uses ppc_booke_timers_init() — so it
> never gets PPC_DECR_ZERO_TRIGGERED and the new clause does not fire for it.  All
> 32-bit classic CPUs that go through cpu_ppc_tb_init() (7400, 750, 604, 7457)
> take the else branch and get the flag set statically at boot, which is the right
> place for it.
> 
> Thanks,
> Amit

-- 
wbr, Kirill

