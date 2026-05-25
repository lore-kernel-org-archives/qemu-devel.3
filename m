Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00580CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 22:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRduD-0000i4-Hk; Mon, 25 May 2026 18:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRduA-0000hr-Sp
 for qemu-devel@nongnu.org; Mon, 25 May 2026 18:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRdu9-0007fB-2M
 for qemu-devel@nongnu.org; Mon, 25 May 2026 18:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779748572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OEFE6iAnqL+p9fQdf0yHV95agKq4p/0mfYdVoRnODbU=;
 b=XZfORn4049Y5hf1gZdFtCuzV1YuAoGCg5sGWcXxEG1/hh63aAPGFCxl8eQ/2lg8CJcjiVC
 JjRjbjZ7qsUUb+ejZgtuzWnl2FdQVs8+6/Zf1HjfY03FHySkMuls9SOq/VKyQRjizHTQKO
 zM1kmyjqfllaBYXfiENLDvpBwYT1IQU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-fHt66sdnMXui3hoXeOT07g-1; Mon, 25 May 2026 18:36:10 -0400
X-MC-Unique: fHt66sdnMXui3hoXeOT07g-1
X-Mimecast-MFC-AGG-ID: fHt66sdnMXui3hoXeOT07g_1779748569
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49043386b3fso32001165e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 15:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779748569; x=1780353369; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OEFE6iAnqL+p9fQdf0yHV95agKq4p/0mfYdVoRnODbU=;
 b=LvBXCfxdxlo3GOG8wynW3urYG7YLtg8g+74+R/Lcv6QlCGL/wM2DV+My9/S/6Rl3mI
 GGgPpz2ma73y3HN6BE+aJb68SIEa5I6OcLFMRIRPR0NBd1L84TxyLR3ZzgvMmEOecIJL
 Rkb2ci8ZErtzi8irIazvT7ub2D6ISXstLiczh4k0HbV47V1YByJ/Aekh2MCRVIQoZ7lt
 R42Xh/aamf6Eu26g59Oj7AF2qug6IQWV5V4KJnWWLfj3YzmHbAXeGtMtG64tygUt7QxL
 8oXfmSFf9oKU3upPLx+6SzKwDwK+Cdtm57Vwhqzn3YBnqaFiqnZol633wByNDOhQy71K
 lBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779748569; x=1780353369;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OEFE6iAnqL+p9fQdf0yHV95agKq4p/0mfYdVoRnODbU=;
 b=dTYaIXUg087tUdcXOjsQ+CKB+qZ2W2a7p+x5yKBUNnIC0Y5+bWYiadb6U/IJJBIG9y
 6tceELaO4DRt2II68eyGnFRjEl6vC3JslqILVRP8K/PTwpAGjSxJpf+41iZ8dr/u7H2A
 E5SguDm8hRFB1dRg9ZyumvSHZOVSAilyf5WxWUcRRVXRIl8LBtooQc5MSozyhnmY2nlO
 m2u+dB+jXd2MWAaXtLp6ghs+JtzPhYNVU/A1rhxdxI6SiQhblkFgD591LwjseMVomVOa
 MI1O7U3f8eoR9vxiKWiski6XC2pZIxIzR485qbDJ40k9dz9c4BQrvDWQNIgmMTwxpfAG
 6ntQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+XvcDpf+xX4R61HPqrAGQb7XafCxDjFLxs1BsX/DtGovnce9K8JnBvMJfCRVUroGWGk+5q/K4Awqe@nongnu.org
X-Gm-Message-State: AOJu0YzQPw3dEFXktdwhBDbzoaqLkHyxRONAya2PtajVsb+1E7NIdbbU
 IZZy71M3/BGiwoIiIO4c3+enWFqu5XNIZoAavUPRUxe1elJPoFmLj7vyaZ0xQlwV9wcW208PD0m
 AeEcPOKVPiVcgRP96pao9KIb+TgFawFtHGhX6jTVloDd6om4vo7L1g/gg
X-Gm-Gg: Acq92OHKSGWuUNoa0JdckGhKymx2an/3s0WxdAdLBK433DZGqAV4U+ag/MCCr1tO9Sj
 6Y9v+9jy+MdGixD7r1kWenDXwY2F23NzO2LcqDyTZi+9g7+WPVziiadtAEaoDQoZWWxkS9apKFZ
 BBxeUE/WMk19V/Zr3Z8pZlH6ngcCCV6G6btst+H4n87hNyX8irusKbpA2Be+j/bKzPSvfvt4bd5
 8WIRXWBvM0PRu/UpkalUUO7wT8iHXpN3+n1iAG1S9ZriateuX0/K8Pso5YhZRXXP2q7talmn42U
 FbIwbBkcnK6QaK3Rm+ZLWq9oyWtNdnYJGkpRwAjfWpchAILZdp++nspkI14PS1cOddcDvY719WC
 VrcygtbQ8D24E+ryZDAxVFQtNFfZD5oJE5bCuVrG1yr6onXvHelIl
X-Received: by 2002:a05:600c:3106:b0:490:6889:1ff with SMTP id
 5b1f17b1804b1-4906889025dmr67812575e9.28.1779748569089; 
 Mon, 25 May 2026 15:36:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3106:b0:490:6889:1ff with SMTP id
 5b1f17b1804b1-4906889025dmr67812235e9.28.1779748568607; 
 Mon, 25 May 2026 15:36:08 -0700 (PDT)
Received: from redhat.com (bzq-79-177-147-143.red.bezeqint.net.
 [79.177.147.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490428e6d68sm96189915e9.22.2026.05.25.15.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:36:08 -0700 (PDT)
Date: Mon, 25 May 2026 18:36:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260525183441-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CANCZdfrn61yr5k=3=E_zE11dw3j2vVsg0PPn0PZ7RAa2agM8kQ@mail.gmail.com>
 <CAJSP0QUmh4RLFUg9-5Uky36Tjhr_cLkrE2VAC8K_MdSY9p0WZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QUmh4RLFUg9-5Uky36Tjhr_cLkrE2VAC8K_MdSY9p0WZw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 25, 2026 at 03:44:02PM -0400, Stefan Hajnoczi wrote:
> On Mon, May 25, 2026 at 1:17 PM Warner Losh <imp@bsdimp.com> wrote:
> > On Mon, May 25, 2026 at 10:34 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> On 5/24/26 14:42, Michael S. Tsirkin wrote:
> >> >       How contributors could comply with DCO terms (b) or (c) for the output of AI
> >> >       content generators commonly available today is unclear.  The QEMU project is
> >> >       not willing or able to accept the legal risks of non-compliance.
> >> >
> >> > But, since this was written, Red Hat's Richard Fontana and Chris Wright
> >> > published this piece:
> >> > https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
> >> >
> >> > Saying, in particular
> >> >       We understand this concern, but the DCO has never
> >> >       been interpreted to require that every line of a contribution must be
> >> >       the personal creative expression of the contributor or another human
> >> >       developer.
> >> This is not the objection or the worry; rather the question is, what if
> >> the contribution is a creative expression of someone that could claim
> >> copyright in it.  In fact, looking at the Linux policy...
> >>
> >>    Signed-off-by and Developer Certificate of Origin
> >>    =================================================
> >>
> >>    AI agents MUST NOT add Signed-off-by tags. Only humans can legally
> >>    certify the Developer Certificate of Origin (DCO). The human submitter
> >>    is responsible for:
> >>
> >>    * Reviewing all AI-generated code
> >>    * Ensuring compliance with licensing requirements
> >>    * Adding their own Signed-off-by tag to certify the DCO
> >>    * Taking full responsibility for the contribution
> >>
> >> ... the question is how humans can actually do the second step.  The
> >> piece you posted above says: "with disclosure and human attentiveness –
> >> and oversight – aided where possible by tools that check for code
> >> similarity, AI-assisted contributions can be entirely compatible with
> >> the spirit of the DCO".
> >
> >
> > The code produced by AI agents has no copyright. You can incorporate
> > public domain code into your work and have the absolute right to license
> > it (see all the Diseny movies). The notion that LLMs wholesale copy originates
> > from the earliest days of Copilot and turned out were contrived. No recent
> > evidence shows that plagiarism is a concern. To the extent that I modify
> > public domain code, I have a copyright that I can choose to license
> > however I want (and the SOB says it's compatible).
> 
> There is an active field of research on memorization and the status is
> that LLMs do memorize. A paper from 2026
> (https://arxiv.org/pdf/2601.02671) shows that production models can
> output significant chunks of Harry Potter, although the research
> deliberately extracts training inputs rather than doing so
> accidentally. I am sharing this because I don't think it's correct to
> say that concerns about models outputting copyrighted code are
> outdated.

But the concern is with them doing it *accidentally*.
Because willful infringement was always possible.
And that does not seem to be happening.


> I do think that the risk for coding use cases is low as long as LLMs
> are used sensibly. If not, legal cases would have popped up by now.
> 
> The example of ext4 for OpenBSD (https://lwn.net/Articles/1064541/)
> comes to mind as a case where LLMs were used in a risky way and
> maintainers decided to reject the code. Even though the output of AI
> has no copyright, when there is no suitably-licensed information to
> generate the code from, then it is risky to assume AI generated code
> is free from copyright, license, patent, etc effects.
> 
> As long as we keep the usual practices around intellectual property in
> mind when merging code, then I think the risk of copyright issues is
> low and not a blocker for accepting AI generated contributions.
> 
> Stefan


