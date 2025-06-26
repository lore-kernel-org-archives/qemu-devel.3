Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADCAC77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUi8I-00080C-5a; Thu, 26 Jun 2025 04:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uUi8G-0007zx-Tf
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uUi8E-0003iF-3j
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750927131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4PEygfHxfDSZpsy7Lu3Yd1Neh1sSGMFdbsMXjcm0czM=;
 b=d0PMPoFzczSMQhWIpkcABOX3cxMv7u0WS7ZSfIlE0iMXXlits9nvHShgdYzMKwyAvAuYx8
 Ypx/wew99NMMGGD4ztXoaM/5kLYKcWxKR+TFBoXT+VScKjYwI/xRZ9Caglel1Yz5wUSE+d
 IhuHv4TMIjp9hetJcMJf3a0x4xl4G48=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-QD0Htm1qNWCrm0XtR00rvQ-1; Thu, 26 Jun 2025 04:38:49 -0400
X-MC-Unique: QD0Htm1qNWCrm0XtR00rvQ-1
X-Mimecast-MFC-AGG-ID: QD0Htm1qNWCrm0XtR00rvQ_1750927128
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a5281ba3a4so288449f8f.0
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 01:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750927128; x=1751531928;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4PEygfHxfDSZpsy7Lu3Yd1Neh1sSGMFdbsMXjcm0czM=;
 b=VKKARItFfgbgDIsCcetnAseUinHckA4CtSrCmSjfscNNnyfRaLGqkq+PFuYNvvQUf2
 4ZZIRbhZ0YjYF7YdsaeeEKjt9H49LVj3NNfsIFZugA/IAmvk82L554TKB9vB80em4WqT
 PCxjphUb0ObnhTOWAtmOc/OqankQ5GHHaGeyTiHB7PGDlGQpQ3uyyAMesvqnMtUtbo8N
 knp6vkw9EAwVwY+UPxKB/x5KLu2GhMVGgknup3+pHmz+0pZMEHqxwCUZ4BouOjzpW0t6
 I6E6S64T14vw+pAJwO15LOxo8P4/MR6kuw88oZ60D2KFcSDLLzId1LYo0hjNIJV82ODp
 Qp5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCURUVKoadpnxpFwMfpofFE4T/54L7cAPstZIq7xPuqB363Drt8n0/lNZWrj/dyLUmhNPAbZThas96+o@nongnu.org
X-Gm-Message-State: AOJu0Yzb3xNRDdDZuvzc4cqq5sluKj6zsfylb9km6JxCohAj0T9hQJDk
 ZehFHu3WUPdar8Gls+JN9BHqusLhx2NynHGCMx9hNGfnb8dygkVML/y3rtNAgtVOWTDNOYLDjzo
 fsSZlbSFEiqJ7piU3mRXXa71FyZvh7F/c5E9mQAQ2l6XrXV+uCubYEgGS
X-Gm-Gg: ASbGncscA9nsxAjK6zHEgUZ3mHCuMi1JMmdu6NwEbR5Nv9i7INcQdrLulDeHCVC4C9m
 6OGFNqsBT4i5EHRe/HlUJ/FKjm+2lG/pMhnNemcBKEnbsFerirVkPh3ODQAVEeT7PuihEoTeaSd
 bKx7ACyYnibXR8jlsRBMXts66SH+nm1gP0SI5ju0HNh5XYwDSopPYeKQ1kjkRFylNeIxDmGx26c
 6zQvpzLjdi0uUMMPSTL0NIjE0XHQydlsjIGy0hx661hvDd9k03j7WY1jTkmgJG/ZFPhD6Lq6R1z
 D/2/bdO7JuQcODJE
X-Received: by 2002:a05:6000:658:b0:3a5:7991:ff6 with SMTP id
 ffacd0b85a97d-3a6ed61f7cbmr4886645f8f.1.1750927128337; 
 Thu, 26 Jun 2025 01:38:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLq2eg+uaH1zIC6cLvvvBY959Ka42xbzwOLEsML8Bec4nNNnFF/mTpfFIceoDRVt+MU85G1A==
X-Received: by 2002:a05:6000:658:b0:3a5:7991:ff6 with SMTP id
 ffacd0b85a97d-3a6ed61f7cbmr4886603f8f.1.1750927127837; 
 Thu, 26 Jun 2025 01:38:47 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e805d5f4sm6526805f8f.27.2025.06.26.01.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 01:38:47 -0700 (PDT)
Date: Thu, 26 Jun 2025 04:38:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 3/3] docs: define policy forbidding use of AI code
 generators
Message-ID: <20250626042340-mutt-send-email-mst@kernel.org>
References: <20250616092241.212898-1-armbru@redhat.com>
 <20250616092241.212898-4-armbru@redhat.com>
 <20250625150941-mutt-send-email-mst@kernel.org>
 <aFxePYi6bzLQ8UvN@redhat.com>
 <CAJSP0QXG_QD+ZWsRgpxSNyXYBooMkfX+gSOOFE8XWghv1E-htw@mail.gmail.com>
 <20250625164902-mutt-send-email-mst@kernel.org>
 <aF0CTtZfBHFpolZM@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aF0CTtZfBHFpolZM@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jun 26, 2025 at 09:18:22AM +0100, Daniel P. Berrangé wrote:
> On Wed, Jun 25, 2025 at 04:49:17PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jun 25, 2025 at 04:47:06PM -0400, Stefan Hajnoczi wrote:
> > > On Wed, Jun 25, 2025 at 4:39 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > > >
> > > > Am 25.06.2025 um 21:16 hat Michael S. Tsirkin geschrieben:
> > > > > On Mon, Jun 16, 2025 at 11:22:41AM +0200, Markus Armbruster wrote:
> > > > > > From: Daniel P. Berrangé <berrange@redhat.com>
> > > > > >
> > > > > > There has been an explosion of interest in so called AI code
> > > > > > generators. Thus far though, this is has not been matched by a broadly
> > > > > > accepted legal interpretation of the licensing implications for code
> > > > > > generator outputs. While the vendors may claim there is no problem and
> > > > > > a free choice of license is possible, they have an inherent conflict
> > > > > > of interest in promoting this interpretation. More broadly there is,
> > > > > > as yet, no broad consensus on the licensing implications of code
> > > > > > generators trained on inputs under a wide variety of licenses
> > > > > >
> > > > > > The DCO requires contributors to assert they have the right to
> > > > > > contribute under the designated project license. Given the lack of
> > > > > > consensus on the licensing of AI code generator output, it is not
> > > > > > considered credible to assert compliance with the DCO clause (b) or (c)
> > > > > > where a patch includes such generated code.
> > > > > >
> > > > > > This patch thus defines a policy that the QEMU project will currently
> > > > > > not accept contributions where use of AI code generators is either
> > > > > > known, or suspected.
> > > > > >
> > > > > > These are early days of AI-assisted software development. The legal
> > > > > > questions will be resolved eventually. The tools will mature, and we
> > > > > > can expect some to become safely usable in free software projects.
> > > > > > The policy we set now must be for today, and be open to revision. It's
> > > > > > best to start strict and safe, then relax.
> > > > > >
> > > > > > Meanwhile requests for exceptions can also be considered on a case by
> > > > > > case basis.
> > > > > >
> > > > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > > > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > > > > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > > > >
> > > > > Sorry about only reacting now, was AFK.
> > > > >
> > > > > So one usecase that to me seems entirely valid, is refactoring.
> > > > >
> > > > > For example, change a function prototype, or a structure,
> > > > > and have an LLM update all callers.
> > > > >
> > > > > The only part of the patch that is expressive is the
> > > > > actual change, the rest is a technicality and has IMHO nothing to do with
> > > > > copyright. LLMs can just do it with no hassle.
> > > > >
> > > > >
> > > > > Can we soften this to only apply to expressive code?
> > > > >
> > > > > I feel a lot of cleanups would be enabled by this.
> > > >
> > > > Hasn't refactoring been a (deterministically) solved problem long before
> > > > LLMs became capable to do the same with a good enough probability?
> > > 
> > > It's easier to describe a desired refactoring to an LLM in natural
> > > language than to figure out the regexes, semantic patches, etc needed
> > > for traditional refactoring tools.
> > > 
> > > Also, LLMs can perform higher level refactorings that might not be
> > > supported by traditional tools. Things like "split this interface into
> > > callbacks that take a Foo * argument and implement the callbacks for
> > > both a.c and b.c".
> > > 
> > > I think what Daniel mentioned is a good guide: if it's something that
> > > you think it copyrightable, then avoid it.
> > 
> > Right. Let's put that in the doc?
> 
> In terms of mitigating risk I think it is better to avoid saying that
> explicitly, and be seen to actively encourage acceptance of AI generated
> code. The boundary between copyrightable and non-copyrightable code is
> always pretty fuzzy and a matter of differing opinions.
> 
> With regards,
> Daniel

Well fuzzy is not what this doc does...

-- 
MST


