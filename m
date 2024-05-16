Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF754C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7f24-0001Q3-VP; Thu, 16 May 2024 13:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s7f22-0001Pc-9i
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s7f20-0004Kl-Q2
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715881000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rshi+ppyHw2+wQZVyTCmfQZsIcRXmSGlqWh7Diiwba0=;
 b=PZxBE/AGWYH9Sa+8Xvb1e0g/zQb6QI+0W93SyLp8ej1R3jjNfRLzTm8vnGjkhm+iEa5UmH
 hs3WGlvRYcimK9jY+p7QmCMLNcl/JYBOd5ExC4ZndOHVPSyB0g9qat85bOB+xtlSfNHN+F
 p+4/ua147vQMwj7TjDpgxq5MHAdFnLY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-LnDymrg4NJiUlaGJfW4tzA-1; Thu, 16 May 2024 13:36:37 -0400
X-MC-Unique: LnDymrg4NJiUlaGJfW4tzA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2e41bd70238so77595361fa.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715880995; x=1716485795;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rshi+ppyHw2+wQZVyTCmfQZsIcRXmSGlqWh7Diiwba0=;
 b=NGccwo4M053Skwm1pQLlTfQ6C0IaqHgMSAlc+CrLQAmckqTY2qHaW3MHMC8w1Mq8jY
 GzEB8oMPKhODaB4hF/Wf4vUPEyf0iTtSGpJwY35VGBmYhPRZX2eItAEcx12dYGgp6Li7
 Aj5rymrs6xYrISP9hQsX8nLs5eJSdHGkNE6f9/X4n7AgtJLAmjSqDS984UCBhF6p4Pxq
 zAqREoViVj0dydTwH22y1OPWNNLFZNq4iqQfHTnVhzWEFByvfeNP4yGAglbLr467p1nM
 Fdq5ykUG1z4Q3bDr0HDLwUCMI7ZypX0gebi0gHwCkaWGhYldoAXoN2G2lz8rOSHZVm51
 l1dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVLlfKEqeDqepGfzCaVB/lpf47envxutXGznaECxF2Efpp03rSSeulOMrkAWTvIxPxR1rRQ/4psdt+XmWpOJQdjGpYzl4=
X-Gm-Message-State: AOJu0YyqNd2dTpEiYfimY78QlcEC/CrO2OQwhXSZxxIGZDHvKt9vUQGA
 or44YvwjfpZJH+NcDGYHBfgGPpm5w8gp8HXsqiVlqlVrV1dpdyWcG4auJukuyJke5Um43kWQo6Z
 2CDQCMXXeIJgKnlXCLPvwIKB2d15dff07S/5Z56Jri+GjCAbaKrtqzsvRk+s5
X-Received: by 2002:a2e:87cc:0:b0:2da:b59c:a94b with SMTP id
 38308e7fff4ca-2e51ff4d654mr126575851fa.25.1715880995509; 
 Thu, 16 May 2024 10:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGimSjArBctO8b73o4h80xKfRerIFG4i/ktoei1ziJLB+ewmPOlMbzJ23cLYRvkBhqhLgoqqw==
X-Received: by 2002:a2e:87cc:0:b0:2da:b59c:a94b with SMTP id
 38308e7fff4ca-2e51ff4d654mr126575651fa.25.1715880994895; 
 Thu, 16 May 2024 10:36:34 -0700 (PDT)
Received: from redhat.com ([2.52.2.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee92bcsm275745985e9.36.2024.05.16.10.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 10:36:33 -0700 (PDT)
Date: Thu, 16 May 2024 13:36:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 0/3] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20240516133541-mutt-send-email-mst@kernel.org>
References: <20240516162230.937047-1-berrange@redhat.com>
 <20240516131141-mutt-send-email-mst@kernel.org>
 <CAFEAcA_ZhSvaZtwooZXfM2=acypm=uCvVFroPOy5E2BbKtGRKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_ZhSvaZtwooZXfM2=acypm=uCvVFroPOy5E2BbKtGRKA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 16, 2024 at 06:34:13PM +0100, Peter Maydell wrote:
> On Thu, 16 May 2024 at 18:20, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, May 16, 2024 at 05:22:27PM +0100, Daniel P. Berrangé wrote:
> > > AFAICT at its current state of (im)maturity the question of licensing
> > > of AI code generator output does not have a broadly accepted / settled
> > > legal position. This is an inherant bias/self-interest from the vendors
> > > promoting their usage, who tend to minimize/dismiss the legal questions.
> > > >From my POV, this puts such tools in a position of elevated legal risk.
> > >
> > > Given the fuzziness over the legal position of generated code from
> > > such tools, I don't consider it credible (today) for a contributor
> > > to assert compliance with the DCO terms (b) or (c) (which is a stated
> > > pre-requisite for QEMU accepting patches) when a patch includes (or is
> > > derived from) AI generated code.
> > >
> > > By implication, I think that QEMU must (for now) explicitly decline
> > > to (knowingly) accept AI generated code.
> > >
> > > Perhaps a few years down the line the legal uncertainty will have
> > > reduced and we can re-evaluate this policy.
> 
> > At this junction, the code generated by these tools is of such
> > quality that I really won't expect it to pass even cursory code
> > review.
> 
> I disagree, I think that in at least some cases they can
> produce code that would pass our quality bar, especially with
> human supervision and editing after the fact. If the problem
> was merely "LLMs tend to produce lousy output" then we wouldn't
> need to write anything new -- we already have a process for
> dealing with bad patches, which is to say we do code review and
> suggest changes or simply reject the patches. What we *don't* have
> any process to handle is the legal uncertainties that Dan outlines
> above.
> 
> -- PMM


Maybe I'm bad at prompting ;)

-- 
MST


