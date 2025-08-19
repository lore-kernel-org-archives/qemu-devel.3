Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EC8CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNg5-0003uk-NR; Tue, 19 Aug 2025 10:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uoNfr-0003sF-Q0
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:50:56 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uoNfp-0001FU-UE
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:50:55 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B77744ED6;
 Tue, 19 Aug 2025 14:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ACDC4CEF1;
 Tue, 19 Aug 2025 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755615042;
 bh=nemCbHVs3d5D+LHnW8dsgpTScZqXcysbNz3ZcH4ZiJU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r2DN9TX/fLzzmE7lChG0i1Ev0l4AbW44L5U5la872+hOaRaf4xlinJgoXjSZZ60QU
 O3ZN4tAQoiFXXd+sHNom325LZP60bOLoI1vAt0fZnwC7BXRRndv8LHXsBfByAxxN0j
 FGtSSi62QqQS0/GepYz4nbGVDeDTznUvTdM4KUUFO6YXG40CZ/28XZ771mX33eHImw
 PSe25aSndLUy/tu3RIKVy4bEQnasMN7U52SqY19ZH/GZlDbMz8mRHFbXlmwaPsNx+3
 jd+knuFTgtTmGDCqs6WNAfDEdIS7jvxxeFYDYpZtaQ92LlYYxJcX6DNi45cGe9oA3N
 pzJNzg4Az0sxw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1uoNfc-00000007Jwx-0bb1; Tue, 19 Aug 2025 16:50:40 +0200
Date: Tue, 19 Aug 2025 16:50:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] scripts/kernel-doc: Avoid new Perl precedence warning
Message-ID: <fkiugi4fnnew3m344qyeanvq4zsqthhbiysyslqeh5kzcp75gl@mpwgcsnzjrx7>
References: <20250819115648.2125709-1-peter.maydell@linaro.org>
 <aKRp22i5RhqZKGkt@redhat.com>
 <CAFEAcA_qj1dSgMTy4n6eAGrubMNSuModFS0_jBRGqVz7yJ28eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_qj1dSgMTy4n6eAGrubMNSuModFS0_jBRGqVz7yJ28eA@mail.gmail.com>
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 19, 2025 at 01:16:25PM +0100, Peter Maydell wrote:
> On Tue, 19 Aug 2025 at 13:11, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Aug 19, 2025 at 12:56:48PM +0100, Peter Maydell wrote:
> > > Newer versions of Perl (5.41.x and up) emit a warning for code in
> > > kernel-doc:
> > >  Possible precedence problem between ! and pattern match (m//) at /scripts/kernel-doc line 1597.
> > >
> > > This is because the code does:
> > >             if (!$param =~ /\w\.\.\.$/) {
> > >
> > > In Perl, the !  operator has higher precedence than the =~
> > > pattern-match binding, so the effect of this condition is to first
> > > logically-negate the string $param into a true-or-false value and
> > > then try to pattern match it against the regex, which in this case
> > > will always fail.  This is almost certainly not what the author
> > > intended.
> > >
> > > In the new Python version of kernel-doc in the Linux kernel,
> > > the equivalent code is written:
> > >
> > >             if KernRe(r'\w\.\.\.$').search(param):
> > >                 # For named variable parameters of the form `x...`,
> > >                 # remove the dots
> > >                 param = param[:-3]
> > >             else:
> > >                 # Handles unnamed variable parameters
> > >                 param = "..."
> > >
> > > which is a more sensible way of writing the behaviour you would
> > > get if you put in brackets to make the regex match first and
> > > then negate the result.
> > >
> > > Take this as the intended behaviour, and update the Perl to match.
> > >
> > > For QEMU, this produces no change in output, presumably because we
> > > never used the "unnamed variable parameters" syntax.
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > This obviously will clash with the "import the python script"
> > > patchseries, but I figured it was worth providing the minimal
> > > fix for the benefit of stable backports.
> > >
> > > The kernel's copy of kernel-doc.pl still has this bug.
> > > ---
> > >  scripts/kernel-doc | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> > > index fec83f53eda..117ec8fcd1f 100755
> > > --- a/scripts/kernel-doc
> > > +++ b/scripts/kernel-doc
> > > @@ -1594,13 +1594,12 @@ sub push_parameter($$$$$) {
> > >
> > >       if ($type eq "" && $param =~ /\.\.\.$/)
> > >       {
> > > -         if (!$param =~ /\w\.\.\.$/) {
> >
> > I think it would be possible to change this only line to
> > collapse the ! and =~ into the !~ operator:
> >
> >     if ($param !~ /\w\.\.\.$/) {
> 
> Yes, it would, but then the code would be:
> 
>  if ($param !~ /\w\.\.\.$/) {
>      stuff...
>  } elsif (param =~ /\w\.\.\.$/){
>      other stuff...
>  }

Yes, the intention there is to negate the regular expression match, e.g. 
either ~(expr) or $param !~ regex would equally work.

> where we check the condition twice rather than using "else".
> So I favoured:
>  * "if C then {A} else {B}" is faster and more obvious as a way to say
>    "do A or B depending on C" than "if !C {B} elsif C {A}".
>  * match the logic that the Python script uses
> 
> over "smallest possible change to resolve the warning".

True, but, on the other hand, this will get replaced at the next merge
window, so, it won't do much difference betwenn picking the smalllest
change or the if/then/else variant.

The Python version uses if/then/else:

        if dtype == "" and param.endswith("..."):
            if KernRe(r'\w\.\.\.$').search(param):
                # For named variable parameters of the form `x...`,
                # remove the dots
                param = param[:-3]
            else:
                # Handles unnamed variable parameters
                param = "..."

So, either way:
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> 
> thanks
> -- PMM

-- 
Thanks,
Mauro

