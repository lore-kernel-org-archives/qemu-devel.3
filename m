Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAACCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwzA-0000d3-Cp; Fri, 29 May 2026 09:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSwz7-0000cs-6R
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSwz5-0003E4-NJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780060242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0sVLvxdDMeDK+4it8vX7x1KFv8jI6Gnq5gDrBHrDJU=;
 b=ZRTa/bOBEByi0Uzi7xbl8SOomyYJasmeoLP3SeQC7AZEsQTzkqnfWChA+ZZORrzTEbFoSb
 WonksfhtK62TzUY0jkzHQ8U+6bO/2u+Nwz1msyRR7b2VE8wAv7THtJoCl/UYRHNMCMKfbB
 wSuc28o5NFgkstebWX7d4zD+OFyFGUg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Ngq0crCEMUOKODTogElLmg-1; Fri, 29 May 2026 09:10:39 -0400
X-MC-Unique: Ngq0crCEMUOKODTogElLmg-1
X-Mimecast-MFC-AGG-ID: Ngq0crCEMUOKODTogElLmg_1780060239
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49051422d55so68989535e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780060238; x=1780665038; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T0sVLvxdDMeDK+4it8vX7x1KFv8jI6Gnq5gDrBHrDJU=;
 b=d3ftVmkhdYmMsSqJGrR2ZPs7QipHFGc3PDGtf94Bn8oM/sDxweoss7Vb7lGfqG1mut
 haJnYgos9MJNOEEt/jSeAS/hOSpWWQfS+CP4RIOckxK0Q1HDwdAuvBprt2XpDepwQ9ey
 fRsIMvqpYnzfsV+Hbk4y35VdAWFuyHkWatfNo61Ef3X2AOeAPZPVHbURZ+NRCIEOXX/O
 pwgRKfG+DCNq/96KBZqougaKj8P7rcNYXx6zxlWVi+Cs6/F7t2y7lZgPJ4zm3ohUfhmo
 sDoq7FUKUItwLmchUT568n92zGs5zw6qu6Jn5PL2Qi1W0TDaP8hcor8DusrVwk5ZR+0k
 VFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780060238; x=1780665038;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T0sVLvxdDMeDK+4it8vX7x1KFv8jI6Gnq5gDrBHrDJU=;
 b=QkRfqAA6eNF8hsDhCHUzid/6jsAr+Wv8elzOIfHUaN7sd230sGHCm4CQxrSTHJHFTH
 gpplnq7nsag+8uAeb1H0haogGJUBmgaU3HpmsFNLptVkqWRT0phiQ1vzvrnHrB63agq4
 WiSaERfq8KYLvdRcKqh7UGtGwTsRz1zi9ODZPnD9uVFhzzlkjmalln1O4+nWIc+VsXV6
 r78s5BAwvpwbE+4LfGsgZl9mf+AKKYoR/PkhASXfhnAncEoz6cr9445cj/3sLGv+gZGz
 zXgd4NDzdpTSc/JrvsB7bJMU+hvXobp5XCsUxJI8Te9KKl/qZdORcgFKoDhMicuUYzcZ
 Ib0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GqRGElRtd2pYH3bPq0zOL1FiVeP+S0N9U2wN6dFlTSbxOxzIQOjQGnpPdlETbgsGtGa5IMOifyyfK@nongnu.org
X-Gm-Message-State: AOJu0YyOvxf7xJpibbXA7TuiizVNz3SEWMk0mBEmWY5++xxdjD0RS169
 kefD05sn5gtI9Yr1tckmLJyTXCD/XRmzXFP0f5KbR5MTAFzMAh1S95HaMKz0CBU4dT6yj0wK/r1
 4T47if/cIdvCB6hg9bo5Xf9e/0+jdz2S3S14J6DQ2AV7Sdj45v1pq1pJh
X-Gm-Gg: Acq92OEFrrlNExiAPYoNY2eH7JDL1j+HEymJqA+J0O7mHwiHTvHGZqbkWxLR0gFsuq5
 Ulmz/mP3PboFT4OBPoClAPYqHQzuL7DtRpFElQhc85rarjbumwusj2q2by6kIXByxNdh3sLJweT
 M5z4+sM3J39dx7P6LR9/mber9Ii/B6x3pIDyrtK0ZTGDIpi7sHem5a5PXRbt5ENmS/6pAyttdZb
 LzfPuoiOy+hHh5OwStz7UExFjid3anrCyQ9S4imw+zgHWebJ8aLcisT6xcE0JghC6Lo2feh8/ji
 m2jHMUI6avoOKUCaxIRa6Vgp7OU2udlQMam+uNsG/Al6zEjgO0bDro58yPScWhk9H/TxASAabs4
 a99rVX2hqzNlOOQJu1/QPvpE0L1Ny+KdvRPuSSwGnF+sJwCOfbHQwZA==
X-Received: by 2002:a05:600c:8b2e:b0:489:1c1f:35f1 with SMTP id
 5b1f17b1804b1-4909c06ff31mr51444985e9.4.1780060238429; 
 Fri, 29 May 2026 06:10:38 -0700 (PDT)
X-Received: by 2002:a05:600c:8b2e:b0:489:1c1f:35f1 with SMTP id
 5b1f17b1804b1-4909c06ff31mr51444205e9.4.1780060237763; 
 Fri, 29 May 2026 06:10:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0b896csm34751715e9.1.2026.05.29.06.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 06:10:37 -0700 (PDT)
Date: Fri, 29 May 2026 09:10:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260529090830-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <87eciuph5o.fsf@draig.linaro.org>
 <224a940c-2f6e-4d5f-8c91-0107d19b82b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <224a940c-2f6e-4d5f-8c91-0107d19b82b2@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 29, 2026 at 03:06:54PM +0200, Paolo Bonzini wrote:
> On 5/29/26 13:52, Alex Bennée wrote:
> > > -  **Current QEMU project policy is to DECLINE any contributions which are
> > > -  believed to include or derive from AI generated content. This includes
> > > -  ChatGPT, Claude, Copilot, Llama and similar tools.**
> > > +   Please read the below policy before using AI to contribute code or
> > > +   documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
> > > +   Llama, and similar tools.**
> > 
> > Stray **, also extra space after QEMU.
> 
> Will fix the stars (extra space is intentional, though it shows my age. I
> still find that it reads better on monospace fonts to have two spaces at the
> end of the sentence).
> 
> > > +**Mechanical changes**
> > > +  If you can use a deterministic tool, it is preferred that you use
> > 
> > deterministic tool or script,?
> 
> Sure.
> 
> > In my v2 I added:
> > 
> >    AI tools **should not be used to write commit messages**. The act of
> >    summarising and explaining the reasoning for the changes is an
> >    important demonstration of the human authors understanding of the
> >    commit.
> 
> While I didn't include this, v2 links to the "how to write a commit message"
> paragraph elsewhere in the documentation.  I don't want it to look like
> people can't even ask for copy-editing of commit messages.
> Paolo


And maybe "It is ok to ask an AI tool to correct grammar and spelling in
your text, as long as you are not asking it to write it".


