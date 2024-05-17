Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F361EC25B78
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 10:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7uRI-0003zu-K9; Fri, 17 May 2024 06:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7uRE-0003zP-Rq
 for qemu-devel@nongnu.org; Fri, 17 May 2024 06:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7uR9-0000H3-Cr
 for qemu-devel@nongnu.org; Fri, 17 May 2024 06:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715940218;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7sBsgB/H0VLijoLNteug9byfoQutYBrdqIsIblxGFtU=;
 b=fhqqOxpqRsPo7H80XAHeXVNwNOrEw57eVxrMeKsnxety7Hscr4qkp7gPKGJYSagoKUeXFx
 +gEVUMSmMZaZNGf0jclz66ezLrxEtiRqAgzIyE52wfainygZF1F2JxInhzyNUGXt3Huk5/
 xMekjGMMXARPdGpCMeOH1+Wz24brWto=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-ciGL2dEgOZCeExd6J8pbMg-1; Fri,
 17 May 2024 06:03:35 -0400
X-MC-Unique: ciGL2dEgOZCeExd6J8pbMg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA267380212D;
 Fri, 17 May 2024 10:03:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBE9640C5B6;
 Fri, 17 May 2024 10:03:31 +0000 (UTC)
Date: Fri, 17 May 2024 11:03:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/3] docs: introduce dedicated page about code
 provenance / sign-off
Message-ID: <ZkcrcX5A4KEI0Ll7@redhat.com>
References: <20240516162230.937047-1-berrange@redhat.com>
 <20240516162230.937047-2-berrange@redhat.com>
 <CAFEAcA9ocOiZ5E0WSCKoR3nL+qf4LF-AQ6_4HpF9xfipAJhbog@mail.gmail.com>
 <20240516133334-mutt-send-email-mst@kernel.org>
 <CAFEAcA8bYowZnE8B5JivSecSRyZLwo0i3cx1tywOMLNd190Kow@mail.gmail.com>
 <7d4e8342-05ac-474d-81cb-e1b4386363ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d4e8342-05ac-474d-81cb-e1b4386363ce@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 17, 2024 at 07:05:05AM +0200, Thomas Huth wrote:
> On 16/05/2024 19.43, Peter Maydell wrote:
> > On Thu, 16 May 2024 at 18:34, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > > On Thu, May 16, 2024 at 06:29:39PM +0100, Peter Maydell wrote:
> > > > On Thu, 16 May 2024 at 17:22, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > 
> > > > > Currently we have a short paragraph saying that patches must include
> > > > > a Signed-off-by line, and merely link to the kernel documentation.
> > > > > The linked kernel docs have a lot of content beyond the part about
> > > > > sign-off an thus are misleading/distracting to QEMU contributors.
> > > > 
> > > > Thanks for this -- I've felt for ages that it was a bit awkward
> > > > that we didn't have a good place to link people to for the fuller
> > > > explanation of this.
> > > > 
> > > > > This introduces a dedicated 'code-provenance' page in QEMU talking
> > > > > about why we require sign-off, explaining the other tags we commonly
> > > > > use, and what to do in some edge cases.
> > > > 
> > > > The version of the kernel SubmittingPatches we used to link to
> > > > includes the text "sorry, no pseudonyms or anonymous contributions".
> > > > This new documentation doesn't say anything either way about
> > > > our approach to pseudonyms. I think we should probably say
> > > > something, but I don't know if we have an in-practice consensus
> > > > there, so maybe we should approach that as a separate change on
> > > > top of this patch.
> > > 
> > > 
> > > Well given we referred to kernel previously then I guess that's
> > > the concensus, no?
> > 
> > AIUI the kernel devs have changed their point of view on the
> > pseudonym question, so it's a question of whether we were
> > deliberately referring to that specific revision of the kernel's
> > practice because we agreed with it or just by chance...
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
> > 
> > is where the kernel changed to saying merely "no anonymous
> > contributions", dropping the 'pseudonyms' part.
> 
> FWIW, we had a clear statement in our document in the past:
> 
> https://gitlab.com/qemu-project/qemu/-/commit/ca127fe96ddb827f3ea153610c1e8f6e374708e2#9620a1442f724c9d8bfd5408e4611ba1839fcb8a_315_321
> 
> Quoting: "Please use your real name to sign a patch (not an alias or acronym)."
> 
> But it got lost in that rework, I assume by accident?

Yeah, probably an oversight.

> So IMHO we had a consensus once to not allow anonymous contributions. I'm in
> favor of adding such a sentence back here now.

That text has been in the submitting-a-patch file since day 1, but that
content was originally a copy of the old wiki page, and the wiki edits
never had any formal peer review, so we should be wary of claiming too
much about a consensus.

Going back in history we can see the specific wording arrived with
this change:

  https://wiki.qemu.org/index.php?title=Contribute%2FSubmitAPatch&type=revision&diff=2173&oldid=2094

This may have been an informally held opinion amongst at least some
of those in the community at the time, but don't recall there was a
specific debate about the allowance of psuedonyms, etc.



I have traditionally been in favour of requiring real names, which I
had pretty much interpreted to imply a person's legal name. That was
mostly because I was following what I (apparently incorrectly) thought
was the kernel's intent in this respect.

Looking at the kernel commit above, I have sympathy with the view that
interpreting "real name" too strictly as a "legal name" is exclusionary.

Thus I'd be in favour of following the kernels' clarified intent, which
broadly aligns with the CNCF explanatory text, that "real name" can be
loosely interpreted to be "a commonly known identity in the community".

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


