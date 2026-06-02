Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA4FC5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUJhn-0003xZ-6z; Tue, 02 Jun 2026 03:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wUJhg-0003xJ-Es
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 03:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wUJhd-0002KB-Kv
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 03:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780385900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iqYjzpa2kvnJhq8SYlevgwmN+qvYj78/06ktmNrSLLc=;
 b=gSSmJooXsHJQtERx47cvnE+Orpvx8sjowoy3NkXiR+oHBEh1IMxsw+mrP7lJ8BM6/SuLSt
 CpGoAjN8C3Ylb/SkNqWrNeMk1hf13TtC4dZ9Y13nSpxd3RJWCwN9hD6oEAFEv6qSNDtK6S
 xyGuqfqAsC47vRvButi8T4X+z4ifYUM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-UP2yl1_kOgOtg12RHFXJ7g-1; Tue, 02 Jun 2026 03:38:19 -0400
X-MC-Unique: UP2yl1_kOgOtg12RHFXJ7g-1
X-Mimecast-MFC-AGG-ID: UP2yl1_kOgOtg12RHFXJ7g_1780385898
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ef9437b7aso1813045f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 00:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780385898; x=1780990698; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iqYjzpa2kvnJhq8SYlevgwmN+qvYj78/06ktmNrSLLc=;
 b=tLjyhCZqSx5mCgm0m5gBV9etC6fgeQwZ0Jld7EplqeNMlbZ1NW610d6iybEcB4vNOj
 UAosFpz+dSJ6lh1KWu+uRiw3HxI8THwmAU+kYmDJsmrlRK52S460ixhNOxdeAA8YLLv6
 6pTbjWWRQ1iy0zvLEYjmTfjS1jMx2jU4FvTx5C1J8q1rD7DbXqGvtSmos8DrVt3xTpru
 R3Tbw3U56zob5NYH+er6gylFxMlKaX9UWteSL7kXET8mkxwMIWoE23QtgMxfMMUUFr7k
 VcFFMqpF9ctYjZxveeI4uGlL2q90fb0k0m8sJ4uduYsO6sv4x2cqRI7m8x0Xru2uEJlm
 vFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780385898; x=1780990698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqYjzpa2kvnJhq8SYlevgwmN+qvYj78/06ktmNrSLLc=;
 b=dfH1EE/VrowtkNAizbPwVFA5mCUo3uoJCbeoISjA+lJ7Yw2oRddNrcb8dtQGwxYJ5q
 dI9p3xs6Vx0CXEdQqlw4VphZ/Xeu3N28RDt/zvm7baCtOeA3CjaUCWb6SOEW1TPkmUy0
 iXILCFBqgh9fN6mSYUhBkfdaowbsxpwj/NtujEiAQfBky+uqZeXZDttuap0gZ6Fw55YP
 N+MF2OvIneM2kIJWrk160p+yAuKmupH5lvtxTX+4yzevmz9/Y72H0vJboV6r/pX2eVFu
 YyF5Pnz6+hfxYR1NBA9LdZ6YYefmVHoKIdiMc9IUqiNCn4H31zWoJmZ/1t+xiYCtsiva
 aVgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8A+m9kw8iMcrXtXFojxOKdEJF3KzvX2+dAl4MIq7v/JDPjy8WfpGJ4JtXrGOuFjsrkH8qxzw6SfWqj@nongnu.org
X-Gm-Message-State: AOJu0YzZhxUOWFvGuyXKJiS8IpKYhQO0uNQnnDbIDRiGsPzAvZxCq4CY
 csafhnSIQ7PmvnWZ26fHCGfUre4rF4s/UH1a4FHKB1zOEx7vCLcBEjlP1UARaBDH2PdzAmTW6LS
 jS1xdyHtOzy8XTwLE31dNFYAg9CXw1nt9GQ2fs37aDsNcl/AWFD/E7omU
X-Gm-Gg: Acq92OH5NpQ5wusuy5Ax9MVqHittnKossd647KRru+WRXZUEQWlIY4OqBHFIscJC6GT
 IP8HylBXv+hh5flElcHuAz9uVc+m8/grkvgEsibhqKmL/pxSE6a6SwZVN0aCQF7/YSIIZxlMJFp
 ndHkqX9+sQiQX6xAIBeSEfzxP1QlFB82M9yMKNofMyhb3oVtmSGgxYhrRHH3m/PywInI9Lz0B49
 EcQfWgDPYXuVcqgGnSW7z670B+8jGjjPUpueFSicj6p3Gx/295adFvvfP7qXB2B+CKpsaj0wA4X
 fPAtbrj0PLhOPz3Qo9LsgFJgtb9vTPOXxR2pEht00qrjhUjAShISPtNzQNCZqHb3xxCB052j3Xw
 CJb/C6+i9I3nTJf8TjWDC0VXcb99CCP0o+dDfjM+0Dd/5/Z7C55FqIw==
X-Received: by 2002:a05:600c:1d07:b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-490a294e7d4mr250273795e9.24.1780385897601; 
 Tue, 02 Jun 2026 00:38:17 -0700 (PDT)
X-Received: by 2002:a05:600c:1d07:b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-490a294e7d4mr250273235e9.24.1780385897009; 
 Tue, 02 Jun 2026 00:38:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34bcc30sm30919271f8f.12.2026.06.02.00.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 00:38:16 -0700 (PDT)
Date: Tue, 2 Jun 2026 03:38:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260602033118-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <CAFEAcA_EWR_MjH1arCdi2y0saZ-Hc7zRAK97YTeEcesVRb9Rtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_EWR_MjH1arCdi2y0saZ-Hc7zRAK97YTeEcesVRb9Rtg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 29, 2026 at 04:34:45PM +0100, Peter Maydell wrote:
> On Fri, 29 May 2026 at 10:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > Until now QEMU's code provenance policy declined any contribution
> > believed to include or derive from AI-generated content.  A blanket ban
> > was easy to maintain while LLM output was rarely usable on its own, but
> > as the tools improved an absolute prohibition has become harder to
> > justify.
> >
> > The concern that motivated the policy is unchanged, and it is worth stating
> > precisely: the DCO is about whether the submitter has the legal right to
> > contribute the code, not about "creative expression".  While the status of
> > LLM output seems to be converging towards non-copyrightability, questions
> > around unintentional reproduction of copyrighted code are still open.
> > What has shifted is the balance of risk:
> >
> > - projects accepting AI-assisted content have not run into serious
> >   legal trouble so far, which suggests the probability of the risk
> >   materializing is not high;
> >
> > - other organizations, such as Red Hat[1], have assessed the risk as
> >   acceptable -- though a community of individual developers does not
> >   have the legal backing of a company, and even an unfounded dispute
> >   would be a long-lasting distraction from work on QEMU.
> >
> > Nevertheless, even Red Hat mentions that "the possibility of occasional
> > replication cannot be ignored".  In QEMU's view, attentiveness and
> > oversight are not a practical way to address this; yet as a copyleft
> > project, copyright and code provenance are of utmost importance to us.
> > Therefore, it remains prudent to only permit AI assistance where the
> > ramifications of copyright violations are at least easy to revert and
> > unlikely to spread: tests, documentation, mechanical changes, and small
> > bug fixes.  Core code that other things depend on, and that cannot
> > simply be thrown away once a problem is noticed long after the fact,
> > stays off-limits without prior agreement from a maintainer.
> 
> This all makes sense to me, except for the part where we allow
> a maintainer to say "actually it's OK". Where our justification
> for not wanting AI contributions rests on "it's too much burden
> on maintainers to have to deal with and review it", allowing an
> individual maintainer to say "I'm OK with that burden in this case
> or for this particular contribution" logically follows as a
> possible relaxation. But if as a project we want to limit the
> blast-radius if we find we have to rip out a hypothetical tainted
> contribution, shouldn't that mean that we hold that as a project-wide
> line, rather than leaving it up to the opinion of the individual
> maintainer ?

It's not clear it's practical anyway. So we limit contributions to 20+
lines, so what did we achieve? They accumulate over time.


> > Related to this, and already visible in the incredible uptick in
> > security reports, is the question of maintainer burnout and the shift in
> > effort from the author to the reviewer of the code.  AI lowers the cost of
> > producing a patch but does nothing to lower the cost of understanding and
> > reviewing one; if anything it raises it, since a reviewer can no longer
> > assume that the submitter has reasoned through every line.  The limits
> > above work just as much to keep the volume of review work sustainable.
> >
> > Revise the policy according to the above considerations, and introduce the
> > "AI-used-for:" trailer as a record of where AI was used.  The standard is
> > slightly different from the more usual "Assisted-by"; the intention is for
> > the metadata to provide more information for reviewers to judge the result.
> >
> > In any case, use of AI does not relax any other contribution requirement:
> > authors still comply with the DCO and take responsibility for the whole
> > patch via Signed-off-by.
> >
> > [Commit message largely based on
> >  https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
> >  Kevin Wolf. - Paolo]
> 
> > +**Documentation and code comments**
> > +  While AI can help draft text, it still requires significant human
> > +  oversight.  Pay attention to the organization and flow of the generated
> > +  text, and strictly fact-check all technical details as LLMs are prone
> > +  to being confidently wrong.
> 
> I think the application to documentation and comments is the part
> I'm least enthusiastic about here. For changes to code, we have at
> least some guardrails on the AI output, in the fact that it has to
> compile and to pass tests. For changes to documentation, the
> only guardrails are human eyeballs.
> 
> Also both comments and documentation ideally are a record of
> what we intended the behaviour to be. If an LLM is effectively
> autogenerating something documentation-shaped from the code we
> lose that.
> 
> -- PMM


