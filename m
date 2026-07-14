Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E30AC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdBu-0004L4-RV; Tue, 14 Jul 2026 09:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjdBs-0004Bk-Tc
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 09:28:53 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjdBq-0001yk-Le
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 09:28:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=MUE7KzN
 4Z/MBpe4zb7NUmuWgjNx3ldsLb7YodHpJccPUm2vI9jNNMmtWOpi5mEZthQUsKq1QFmGuD
 tg91roIAJ5WaC/BsKx8MYZEoPLBBeBVXP4AEAuioxoTzI/XKvwEwvk1PsyWQ9M41DkMs1V
 uHlT42EO5X8JNp95oPi8TLomv/lfRCHv5mASRABhVUUXXpUsUvHbXZWPmTaKM3eyK+7z0q
 RP3mUM82m2fmTX88NcjCrSg7QMziCpxUCLo03+kJyvtY8VTwd2lc3I9vk/N1PoIxjCU9oV
 G0940yncGVQDmSgbIFKRwIJ9MyB2h1CQvqyGe1WhUTnFbEOO/aVX9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=1
 6CT9Z5KhaPsddIa9FN9tHlEEYXy9qu99RgX0wTgnMU=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=yc+hmReZwtKK/Tm0khOItMw69Rv2tQlk1uR9SNhFg4rAroU+DCsqUOQeIozltd+YjCtR
 dWTv9mjHj+L8agN3sWG6qi7dH2ZfDxldfsG4OzUA9NRbZZY5Hxqfz7Ndsqyy+BEdoPmRGK
 xb/bbiRdfEJ4X0XaQ+9kQccC0ZMQQeKF6MB+fOVLIAFkkXyldQTu2PqJWXtC7UMhmXNiNf
 Xub0eIg07HcB7nq6u/E1JAJ8cPXPPB61EByx4rrYUK7SEVg1ewmdS2Nnr5XPb50BCL8V86
 kb4XeIyEfdHGbcpVSk15DtlF2aBePXTykGdyslA9Jbww87/chtTK2fxMjQCoKVAA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=dtq4wGl2; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=Dxy9kuKx;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=16CT9Z5K
 haPsddIa9FN9tHlEEYXy9qu99RgX0wTgnMU=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=dtq4wGl2RTW6bFiOepcoHeQ8g0eV+M
 OAfvYHkIMuXZhxkeIKXZ9rCC+AL4cMEJ4mQIgY5Ja3TauyT6/jrKX+IssscmDR3wW7DlTY
 3j7aarUoRz9+RNehVCcdIfptJQXOt6JVGj6h5uLeko0ar+UJHVNoXIHKRHm/uOxNNvMBb8
 WAzvBu7lR1+QWRGeKGdKpPbgzLJrt7x/wrjfK1pbVY9Ef23Q4A3qIGZa/wRJuVvR2kzYnj
 uuDwqZPYpc2tIRR9NjAJabzEOtDgz5411rgBQvaTkbd7/5rC/BIJhuyRZmtD/Mvsu8Spsq
 nM0e6hzSmOyVc8fq+J796tt/XuF1l8Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=16CT9Z5KhaPsddIa9FN9tHlEEYXy9qu99RgX0wTgnMU=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=Dxy9kuKxGw754YhVwY
 JEg+N7QbPN2pK9w9uFfVsCOOfb/cjxYxAFHI18V0M4G6gmQbiOwaFnzuIUGCm4JYhiAg==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id cace64f7
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 14 Jul 2026 15:28:40 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) with ESMTP id f740e86c;
 Tue, 14 Jul 2026 15:28:39 +0200 (CEST)
Date: Tue, 14 Jul 2026 15:28:39 +0200
Message-ID: <87cxwpn1iw.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/9] hw/usb/xhci: reassert pending busy interrupts
In-Reply-To: <4d6a6a94-49d7-4a37-a590-bf2a3105b994@oss.qualcomm.com>
References: <20260713112004.4956-1-kirill@korins.ky>
 <20260713112004.4956-2-kirill@korins.ky>
 <4d6a6a94-49d7-4a37-a590-bf2a3105b994@oss.qualcomm.com>
User-Agent: Wanderlust
Mail-Followup-To: philmd@oss.qualcomm.com, qemu-devel@nongnu.org,
 Kirill A. Korinsky <kirill@korins.ky>
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

On Tue, 14 Jul 2026 12:01:36 +0200,
Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> 
> Hi Kirill,
> 
> On 13/7/26 13:16, Kirill A. Korinsky wrote:
> > xhci_intr_raise() returned early whenever ERDP.EHB was set; that also
> > skipped IRQ assertion after the guest cleared IMAN.IP while leaving the
> > event handler busy bit asserted.
> > 
> > Track the previous IMAN.IP state and suppress only duplicate raises;
> > when ERDP.EHB remains set after IMAN.IP is cleared, assert the IRQ again
> > so the guest can observe the pending event.
> > 
> > Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> > ---
> >   hw/usb/hcd-xhci.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> > index 2cdab3ba0e..ce06d52c36 100644
> > --- a/hw/usb/hcd-xhci.c
> > +++ b/hw/usb/hcd-xhci.c
> > @@ -577,12 +577,13 @@ static void xhci_intr_update(XHCIState *xhci, int v)
> >   static void xhci_intr_raise(XHCIState *xhci, int v)
> >   {
> >       bool pending = (xhci->intr[v].erdp_low & ERDP_EHB);
> > +    bool was_raised = (xhci->intr[v].iman & IMAN_IP);
> 
> Per your description we are missing to clear ERDP_EHB?
> 
> @@ -592,6 +592,7 @@ static void xhci_intr_raise(XHCIState *xhci, int v)
>      }
>      if (xhci->intr_raise) {
>          if (xhci->intr_raise(xhci, v, true)) {
> +            xhci->intr[v].erdp_low &= ~ERDP_EHB;
>              xhci->intr[v].iman &= ~IMAN_IP;
>          }
>      }
> 

What seems a real fix for that may be a real root cause.

My test is simple: I boot OpenBSD/octeon in my machine with USB disk, and
inside machine, via SSH, run cvs checkout of ports with -Q option (no
output). It produces ~200k files and works for about 30 minutes.

Without my or your diff the cvs process stuck in biowait, I can use any IO
at all, ls is blocked.

But network and things like ps works well.

And enough input from serial console usually wake up machines.

So far I had reverted my hack and replaced by yours fix, and it survives two
checkout without an issues.

I'll drop that patch from my series.

-- 
wbr, Kirill

