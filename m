Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5978CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 15:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSzQM-00077h-Mt; Fri, 29 May 2026 11:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSzQI-00077M-F7
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSzQG-0006z5-L5
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780069614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cE1G+lxP4MYP+1ekTRbdVk4ftIVspH4RelFmqNYcIyM=;
 b=TxfcoeiEWnH2zvAuiozPo4eNBBpKjuaAWKZdiabs6XZ0xPVG1V8TyiDd+0KBve3AnTlimp
 NVXS7eZH++wfUjaIobxAeanBfWoI/MGEeBFs+Gw8P3J6yBvruJtrtTSGro4MqIoEdI3VYS
 6EFjyfHRLtLYLapCn8MhyNmvenHbgMc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-rapyiADLNpqJ-6z72i47SA-1; Fri, 29 May 2026 11:46:53 -0400
X-MC-Unique: rapyiADLNpqJ-6z72i47SA-1
X-Mimecast-MFC-AGG-ID: rapyiADLNpqJ-6z72i47SA_1780069612
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef5e38a18so204481f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780069612; x=1780674412; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cE1G+lxP4MYP+1ekTRbdVk4ftIVspH4RelFmqNYcIyM=;
 b=h3hs14cuq+2m4FCzDdH7os3kRMk0fbF1RPZ2okSoHLG6r4FhwqYro9sFLlB1q3g7fS
 EZs9jg4C831l92MelrW5i3uQx1r0MsOk0UoChFdTRy+suCD2Cs+f9Oqe83e619QPdMD+
 FHxKCIguz8itV9wvE5ojHJ+ZXxTG535d9Lpk/cqSVYH2EbqeE8FDAqT1hFR4LiRBJzgc
 pjbLik/aTvOdNLZGJGalE/mIRk7ywsiqH/05mpGrPS1YFR1O5yfZ+zLCM1yQJS3LjbFb
 jBLtB7/ydwVNoZgidYP7XL00Uvs3gsYk3KswtzVHfaxCrMPINro2J8HZzTk6iCVZR1JL
 4wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780069612; x=1780674412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cE1G+lxP4MYP+1ekTRbdVk4ftIVspH4RelFmqNYcIyM=;
 b=HffJmL9jIexvxMHWgzV3Mo7XIUNnURQHnxUBbKgm2l1bl2pOW+FhYZ+fv01GvgzdGI
 x1rlAnpA9U5aQA159bsnSGJqELOsfqAMbAT/Mgl69BSTYpDtdWzz+nrK32CigQy4F16z
 DtyO6qQWcgL1emYifWcE1nrIzQYclrLOMsQXGa2NKmSRpB6LkUNrq8EiGVVHuIP/KLzK
 47Nu8nN6FxVQ4Y8hGdWK8FrZbmHuvzdxKmnvDgWYh5ERPaRu4GxPT3gnCkRd7FVGBUWz
 XjJNYOEL4bN1m5oklaMCUVK2gqbnq0LIL+E/HvP9nUoO/ht7xjAPnrjwDjjvRpZgH3pd
 4mtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eQ+UyLt8hSG6AsHTszygY2iJ8iJ4+6FTh1XYDFsCqg/ijn6Z8xvmgkaZZVnM3oUpwiSr2ykD0W4kl@nongnu.org
X-Gm-Message-State: AOJu0YxoRT03mwmStgry1ldAORqI9oVHcSRNj1ggl8EDQ0nwYzt5a9jg
 H8D9KZ9zE7CjQXcfothrvCLkp4TV70gZrdRy6/YuHZrCVRVhn4lUEqUFQ9qekincItlPAOyC+O6
 x+sjXPqlRExfW/G2EDTNKYki0jtrzehv3eXS+ggbQAScr3PW8xVjUBMqE
X-Gm-Gg: Acq92OFAopYNBNtPADiWka67aMkIJ1OKOGaqvyVFemrHUCGdc5gYE1QUNuTcIyyxf61
 uJy29b4k9uaShT4YgnQ0qC8VK9Q+mddVo+Rdg2Q5Cz6iK7+TVIkYuU8fHwmJFrxs3SHAoD5nafB
 zl7z9mv7kYF7YYISPfYOBPkZTP+ftP//euHoBx2je9z7YG+/iVzL6oYJ6BZhUc1KFf5aXzBCw+/
 bcXwdC45tWeETMBEDmOhV2M8N2RbAUmcEIa+7RzzSMYhapSEapKrNk8m+LfsVwN6WeHjvRBkdFm
 seCtH23SH/HYup1ihJXNo1jzdaAQPuLAAVjSO+z2t++RReoCVPvgfW42rOpcm0SxgUUXE/qoSGP
 pvN/5LH/fyRZ7FtJ0z6O2mZzj1bFZmecP7KGo1ziE1hcIWcc/G9K8wA==
X-Received: by 2002:a5d:534f:0:b0:45a:dd7a:e33c with SMTP id
 ffacd0b85a97d-45ef6b94446mr536985f8f.33.1780069611609; 
 Fri, 29 May 2026 08:46:51 -0700 (PDT)
X-Received: by 2002:a5d:534f:0:b0:45a:dd7a:e33c with SMTP id
 ffacd0b85a97d-45ef6b94446mr536937f8f.33.1780069611082; 
 Fri, 29 May 2026 08:46:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34a0674sm4075341f8f.8.2026.05.29.08.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:46:50 -0700 (PDT)
Date: Fri, 29 May 2026 11:46:47 -0400
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
Message-ID: <20260529114114-mutt-send-email-mst@kernel.org>
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

I guess, the maintainer can judge that the code is unique and qemu
specific enough, and follows from what it is doing automatically enough,
that the chances it is accidentally copying something are nil?


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
> I'm least enthusiastic about here.

But I am very enthusiastic about less agrammatical english in both.
AI is super helpful for non native speakers.

> For changes to code, we have at
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


