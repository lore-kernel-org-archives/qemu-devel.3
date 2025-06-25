Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8335C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 20:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUX04-0001Sm-VH; Wed, 25 Jun 2025 16:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uUWzz-0001SQ-VT
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uUWzy-0004S9-Ix
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750884337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJA6iAGsyfgmqzeMsz0wBLITzsqWR75NzkRkX6Q+dgw=;
 b=MynUTodx7MfVdp1Gbo8PqKop6v8fcJAKxD0FFBqX9WNBE+gCns8TEtHkT792/wltV34Kgp
 eVvUGC9E5kKi7EtT5xtIDMYeJNTfC7pwmjb2HRrL8kZaP6r9eQvMgsLZTBkvezO9Ubdfcy
 NMfwZRpbHYSx5RSRUg4zmwN60lDzTwU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-1CZSAhyAO6mkuUBvFhgH0Q-1; Wed, 25 Jun 2025 16:45:35 -0400
X-MC-Unique: 1CZSAhyAO6mkuUBvFhgH0Q-1
X-Mimecast-MFC-AGG-ID: 1CZSAhyAO6mkuUBvFhgH0Q_1750884334
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso1500735e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 13:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750884334; x=1751489134;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wJA6iAGsyfgmqzeMsz0wBLITzsqWR75NzkRkX6Q+dgw=;
 b=Gewa48/MmbjvrdBK/u432SI/SlZAIv9hryxP4W/yan5EgABBDMYgeP3LCcFK6BLHqi
 tBsEvWd90rppuYsFpgqkpRRKPoPyAAiamU1eQzXfno464bfeD8wxRk3AC15tro7o0FsH
 XBmZTm1ICse1r9+2IQbGu6ZHdv4rjU9Ve4yG6WHFLC+8r6YGPBcgMK0cjOqCC+t7QZ/1
 c828AYDq02q+VxuiCFxAXuayKmPoKFYrMFGg3zoTKsLXbQoWo+5ik0Iv60seV7w2pixV
 WiomlzCCV7nPteBJi0zi45LmfrByDca13NB4EXNEosfW+oFVAd6RmbkzRJcdSUcBF600
 45mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFPqOkYgk5D4q6JTn4ugiRGS1VBIqdxkKo6eGMA5dIr8Fm3i/PvdDClmxIVPGYUG19OZ4ufDuWuo9v@nongnu.org
X-Gm-Message-State: AOJu0Yy+CaQN77cVwzv1acZuLrr6z1DOneKyzG30LTLsx3cvNy9D4Hp/
 YuWFtJHe/2HRQh+lJlXNz09qQ70Suzogk3o/GY2YD4lggOZwJ0iECzq4fjCd8PipN/V6ozzhwd0
 a9Z2VEnQ+vYtRy3z/7VwjtdB6nqIkEzEVm6DHUY8A/w3teuJ4FqlUD7mj
X-Gm-Gg: ASbGncsRt2dbmL5qfsIE+OQzf3aEG4E1Q4UkpcA91G/cjyE73NdkBsfN+wF8OshyVEh
 tk9OcE6mb784seILTL0fAhk/nJB62ZeNXs9fXXZCSv/JLYHMcS7WmYWWnsWr5C0ZgIX701hBagw
 0qD5Wji5/h6QQK3k90AVnr9kJuxT5TdbEl8zUmGHXXWI3b13LZDI6yW2R+Q0VAG+dL2DLTOF+Ej
 KgFyAmMS6WvSaJsUbZtp3gyX3wr2M6m1P3DqcXjyKyYuoleUkVkBd39yzk4hodWlB1O/ZE9lyJe
 CpSQLIroCyf9t5fL
X-Received: by 2002:a05:600c:4684:b0:453:aca:4d08 with SMTP id
 5b1f17b1804b1-45388971b4bmr10708615e9.1.1750884333996; 
 Wed, 25 Jun 2025 13:45:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF87G0fhAyeHskPx+Z+xd5slyXjUXpe/Rs/kB9xuBb4ZkanctG4xHEbivIegfKvmdhKEVndMQ==
X-Received: by 2002:a05:600c:4684:b0:453:aca:4d08 with SMTP id
 5b1f17b1804b1-45388971b4bmr10708375e9.1.1750884333547; 
 Wed, 25 Jun 2025 13:45:33 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80ff8d9sm5532875f8f.70.2025.06.25.13.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 13:45:32 -0700 (PDT)
Date: Wed, 25 Jun 2025 16:45:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
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
Message-ID: <20250625164352-mutt-send-email-mst@kernel.org>
References: <20250616092241.212898-1-armbru@redhat.com>
 <20250616092241.212898-4-armbru@redhat.com>
 <20250625150941-mutt-send-email-mst@kernel.org>
 <aFxePYi6bzLQ8UvN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFxePYi6bzLQ8UvN@redhat.com>
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

On Wed, Jun 25, 2025 at 10:38:21PM +0200, Kevin Wolf wrote:
> Am 25.06.2025 um 21:16 hat Michael S. Tsirkin geschrieben:
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
> > 
> > 
> > Can we soften this to only apply to expressive code?
> > 
> > I feel a lot of cleanups would be enabled by this.
> 
> Hasn't refactoring been a (deterministically) solved problem long before
> LLMs became capable to do the same with a good enough probability?
> 
> Kevin

Interesting.  For example, I recently wanted to refector a bunch of bool
fields to bit flags.  Know of any tool that would do it without major
pain?

-- 
MST


