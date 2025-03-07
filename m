Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC563C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 10:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqV6U-0000hE-Pe; Fri, 07 Mar 2025 05:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqV6S-0000ec-Vr
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:38:53 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqV6O-0005G1-1S
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:38:52 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e6182c6d52aso1182392276.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 02:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741343926; x=1741948726; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2S45mMQG5i5dCFX1vfpddj1zixqpdZpVPdwlY8cA5/E=;
 b=UtMjTWVNWXsGZh0yk7LKXmjUJpFC5BSYHWjNP/6FwAKpMIFKWoyWo7Tjiik+NVB6Wd
 zks8RIpHk85HpNPtwiCfmId2+iAgzgO8bc/1NA2W8CXMF3G/knFwnMMLFS+dgWYjmjoC
 NlMZsLmQKXfNlSLbuTnQtZAQiEAT7o35TLm2NYNg1Hrf4Z7+0Gj7alTD8D8yDHG1QpQr
 bS2q9mp40nKqY5d1DQ9k3PWfcueG0dGRN/vucp9m3jec0T46EO6Fvb8n8aCD7MvL6+Es
 gtBS+Quf+8cb+6tkYilpv6jPz9Lb60A3pGJl4knt0CoWES976a+pusscXB/7FaY+7ozn
 yGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741343926; x=1741948726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2S45mMQG5i5dCFX1vfpddj1zixqpdZpVPdwlY8cA5/E=;
 b=NJIBmQKhPNX2rBy+THIABjIOM3Ds9AvYbUMmFWw2WThzTpKUdb4Vw5wdq24NUr55Ps
 syliOjC3sMU/JTEA2+YhTtrl5DO26T432HsJs19Dq00rJ+aW3GP9dkq2FBqIncjxS1+Y
 FbME+hGphRp5Jg9wmPVxwvFN12/7eg5VQ53xjX/r+nwpp06M2942D9GTeMsq/7I9Cjxz
 mWk+Xl0Edep7jxg7MnwjiWlGNRRoDAk3MjtJy8UFTtIgC9+5ahattq+mcWbOkplHknMQ
 qCpmK1mQQb+6AXnssPIvLeHVt495aHVtpvj9rBdxpl2KIhexsceoTuXbTcZU6SPGdAdO
 iIjw==
X-Gm-Message-State: AOJu0Yy9uqFmZ/TgiP/nYqgq3lg+yrnEGplXNd8jrEjO6fMQl5I1KIKA
 kmt07JmvOcHxOxrIZ6VwnUVgsAF+2AC7VMy+8YxM6rwvqqAIAQcVgiizN8KMZW3+de3JnzpEtkn
 RaVsfJq+RA3HpoZhSnsI02PAVMLTcbXTil/5X/E9+MeivqnND
X-Gm-Gg: ASbGnctjMThEBtLDtTPrm3QrZscCMx1Mll/okloyJ6vnExO1MJzsMnPuUz6tVJrYIUR
 oRvvOVy9vsQJ7DHsLkJMy7cOTw6TO+quFnVAVR4EurbsYAthXXit798h+wzf/L+g5mHqXyNIy5j
 N/ZzpdPZGru/iDcqc9u7qA9pbLFpI=
X-Google-Smtp-Source: AGHT+IFKk5iP/+84qKGIvXDri124A5IcjfaBg+SXEtA2faAvBokyTTNDL06ksFL/Qs/TzD86xqvc5cJWpU/EEAYYbnc=
X-Received: by 2002:a05:6902:2082:b0:e5d:e3b1:486f with SMTP id
 3f1490d57ef6-e635c1c4097mr3693432276.30.1741343926296; Fri, 07 Mar 2025
 02:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20250213142613.151308-1-peter.maydell@linaro.org>
 <CAFEAcA86t=uc_XZd0s1yOFsop68XN2HK7c5MUJNfn7kcDoMsxQ@mail.gmail.com>
In-Reply-To: <CAFEAcA86t=uc_XZd0s1yOFsop68XN2HK7c5MUJNfn7kcDoMsxQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 10:38:35 +0000
X-Gm-Features: AQ5f1JoPg17I_iveZ3Db-l-R_YeTT4LBdbBvgoWtECD5kGlnuCSux-KOj36lIsE
Message-ID: <CAFEAcA8CWFsxK6u0gg_pwCokGmzHe0=TRyf=9560APLX1DezMA@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/i386: Emulate ftz and denormal flag bits
 correctly
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping^2 for pickup of reviewed patches.

thanks
-- PMM

On Mon, 24 Feb 2025 at 14:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Ping? Would an i386 maintainer like to pick these up?
>
> thanks
> -- PMM
>
> On Thu, 13 Feb 2025 at 14:26, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > This is a set of four patches to target/i386 which use the core
> > fpu functionality we just landed for Arm FEAT_AFP to correct
> > the emulation of some corner cases of x86 floating point:
> >  * when we are flushing denormal outputs to zero, this should
> >    be done after rounding, not before
> >  * the MXCSR.DE and FPUS.DE bits indicate when a denormal input
> >    was not flushed and was used in an fp operation; we previously
> >    weren't implementing these semantics
> >
> > All four patches have been reviewed by RTH. Testing is a bit
> > light (make check-tcg and make check-functional), because AFAIK
> > there is no freely available comprehensive FP testsuite for x86,
> > and risu doesn't support x86 currently so I can't do the same kind
> > of random-instruction-testing I could for Arm.
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (4):
> >   target/i386: Detect flush-to-zero after rounding
> >   target/i386: Use correct type for get_float_exception_flags() values
> >   target/i386: Wire up MXCSR.DE and FPUS.DE correctly
> >   tests/tcg/x86_64/fma: add test for exact-denormal output
> >
> >  target/i386/ops_sse.h        |  16 +++---
> >  target/i386/tcg/fpu_helper.c | 101 +++++++++++++++++------------------
> >  tests/tcg/x86_64/fma.c       |  17 ++++--
> >  3 files changed, 68 insertions(+), 66 deletions(-)
> >
> > --
> > 2.43.0

