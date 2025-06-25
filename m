Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E072FC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 20:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUWJu-0007jz-24; Wed, 25 Jun 2025 16:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uUWJr-0007iS-Tz
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uUWJp-0002VU-6H
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750881722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSTz2ihEH8ZYBwdzOVb+zbX3CJN+GiTbo87yKMig9Eo=;
 b=Ly4k0ZdQr8mOiLGo8gE0lqu/e98U6FVeoPAWR5y2Gt/VWMW0UKPdXaeeGk1jRaYBb5oL9h
 MjrzvwjzbR11vID49VkqVbfrmjeuigUvIa1Bsa/0NhArEEe/w/Y1TPSsa+kllLeNEwIH4j
 lvVWPSu0RT/3pwyYT2OTwmNihmsYMYI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-TYOhv7fFP1uXvFHQnhzjPQ-1; Wed, 25 Jun 2025 16:02:00 -0400
X-MC-Unique: TYOhv7fFP1uXvFHQnhzjPQ-1
X-Mimecast-MFC-AGG-ID: TYOhv7fFP1uXvFHQnhzjPQ_1750881719
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4535ee06160so963635e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 13:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750881719; x=1751486519;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kSTz2ihEH8ZYBwdzOVb+zbX3CJN+GiTbo87yKMig9Eo=;
 b=AoiKH0xpz00bLHUMwsSPClDcCcKzHurtcM1ygsbW61v//rny2QoNETJSD0GznMFJG7
 zumgnyYUspfhQMNVwQanHowc7zLETEWG2UsFUZeON1gzY1YVUzpGDlA9VVxpnOCgY6Oi
 tCXHG72pqIAq8KZdBRg586vWPd7USucaKUxrKzYhcrGDyEazHvHkVu9wtNQYjZEkTaja
 Sq8C6tiAEGtPJmNRly7lcrppmRmMw+zQqWxlwiLFKg5cFaUXkyZWze/ymvzaJomd/pbA
 Gheqye1KdcKb4yEo/3/DfUS3O8phAuvpY4whtYkGSncXEMuamOXDgoNRSGugaT2NO89E
 2fJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdbmrG74Tj30sMOrV3Xa0CVT4NkWF3QV7DwmwcZWDKQ75brcRzysT7oe5pE93aZVZ27RfZzTA+/Nrv@nongnu.org
X-Gm-Message-State: AOJu0YxacUUNFoA74EH47+8YyYqqTpzammtaFJomy6sDD0GPk4NCssBa
 eIbvmSJaP/GHUNZmWdk8q62WJKrhUFQQSRM0xP8IVqyz3Z/m9gAuSTXoDH69au/Z3N5EUB5YFRt
 0xVrYJK9ZUI/M7TZN/hdk6oJFDMbjF/imcNnN1h9fUZK083R3/C+DxSnX
X-Gm-Gg: ASbGnct6wbCYA4xPXD+vGlRI6w/AIuEoxeaEMV2v9AayHJqMIk13bMKtNILHLH03zPd
 al68GrnLR2lEBc7wCqiejyGTt8gfNMddxqT3nkM5MXdvZTXJoVs6BljWNSsimW6InFzwtIjsl1Y
 918vSqusjjUYKWTt02eSc3mQi+5rIHeKE1mRQ8Y1pUvXiG3bER9VL84JBG4lqp4FIvKgaKJmo5m
 /cLvTQd7wROGmA1uzCQUP/nTFclra8LsOTSF+Rthg1YC0QVJU21fSJoGw5n7c0QyxcTuwAPAj6+
 QV/CbiurJqkidhJn
X-Received: by 2002:a05:6000:178e:b0:3a5:3e47:8af5 with SMTP id
 ffacd0b85a97d-3a6ed637801mr3979918f8f.27.1750881719264; 
 Wed, 25 Jun 2025 13:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgcXA7xqz4SegqYPGi1F84iyo28hHtowjSDQd+5AV9gY3WEoX3IstNKCQbZ5Ms+fm9iCnzvw==
X-Received: by 2002:a05:6000:178e:b0:3a5:3e47:8af5 with SMTP id
 ffacd0b85a97d-3a6ed637801mr3979861f8f.27.1750881718696; 
 Wed, 25 Jun 2025 13:01:58 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538236694esm29399865e9.28.2025.06.25.13.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 13:01:58 -0700 (PDT)
Date: Wed, 25 Jun 2025 16:01:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 3/3] docs: define policy forbidding use of AI code
 generators
Message-ID: <20250625155910-mutt-send-email-mst@kernel.org>
References: <20250616092241.212898-1-armbru@redhat.com>
 <20250616092241.212898-4-armbru@redhat.com>
 <20250625150941-mutt-send-email-mst@kernel.org>
 <aFxRUFIfuDdRYA2m@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFxRUFIfuDdRYA2m@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Jun 25, 2025 at 08:46:54PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jun 25, 2025 at 03:16:52PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 16, 2025 at 11:22:41AM +0200, Markus Armbruster wrote:
> > > From: Daniel P. Berrangé <berrange@redhat.com>
> > > 
> > > There has been an explosion of interest in so called AI code
> > > generators. Thus far though, this is has not been matched by a broadly
> > > accepted legal interpretation of the licensing implications for code
> > > generator outputs. While the vendors may claim there is no problem and
> > > a free choice of license is possible, they have an inherent conflict
> > > of interest in promoting this interpretation. More broadly there is,
> > > as yet, no broad consensus on the licensing implications of code
> > > generators trained on inputs under a wide variety of licenses
> > > 
> > > The DCO requires contributors to assert they have the right to
> > > contribute under the designated project license. Given the lack of
> > > consensus on the licensing of AI code generator output, it is not
> > > considered credible to assert compliance with the DCO clause (b) or (c)
> > > where a patch includes such generated code.
> > > 
> > > This patch thus defines a policy that the QEMU project will currently
> > > not accept contributions where use of AI code generators is either
> > > known, or suspected.
> > > 
> > > These are early days of AI-assisted software development. The legal
> > > questions will be resolved eventually. The tools will mature, and we
> > > can expect some to become safely usable in free software projects.
> > > The policy we set now must be for today, and be open to revision. It's
> > > best to start strict and safe, then relax.
> > > 
> > > Meanwhile requests for exceptions can also be considered on a case by
> > > case basis.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > 
> > Sorry about only reacting now, was AFK.
> > 
> > So one usecase that to me seems entirely valid, is refactoring.
> > 
> > For example, change a function prototype, or a structure,
> > and have an LLM update all callers.
> > 
> > The only part of the patch that is expressive is the
> > actual change, the rest is a technicality and has IMHO nothing to do with
> > copyright. LLMs can just do it with no hassle.
> 
> Well the policy is defined in terms of requirements to comply with
> the DCO, and that implicitly indicates that the code in question
> is eligible for copyright protection to begin with.
> 
> IOW, if a change is such that it is not considered eligible for
> copyright protection, then you can take the view that it is trivially
> DCO compliant, whether you wrote the code, an arbitrary 3rd party
> wrote the code, or whether an AI wrote the code. 

Exactly. I agree! However the patch states:

+The QEMU project thus requires that contributors refrain from using AI content
+generators on patches intended to be submitted to the project, and will
+decline any contribution if use of AI is either known or suspected.

and makes no exception for non copyrighteable parts of the patch.

Or do I misunderstand?


> > Can we soften this to only apply to expressive code?
> > 
> > I feel a lot of cleanups would be enabled by this.
> 
> Trying to detail every possible scenario is impractical and would
> make the document too onerous for people to read, remember & apply.
> It is better to leave it up to the contributor to decide whether a
> change is non-copyrightable, than to try to draw that line crudely
> in text. Even for refactoring that line will be fuzzy and contextual,
> so not a scenario where we should say any use of AI for reactoring
> is OK, as that will lull contributors into having a false sense of
> acceptibility, rather than being aware of need to question it. 

Agree again! What worries me is that the patch as posted here does
not make contributors question anything. It just flatly forbids using "AI
content generators".

-- 
MST


