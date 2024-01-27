Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE85C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 12:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTiFy-0004Uw-Ba; Sat, 27 Jan 2024 07:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTiFw-0004UR-IV
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 07:57:56 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTiFu-0007k2-QJ
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 07:57:56 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55a45a453eeso2031514a12.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 04:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706360273; x=1706965073; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yn8R3cy5Wtt8RQQZsUIgIHunCiuYV+R0tlPr+SBOSsQ=;
 b=zY84QXLKKzmkF540Tzl0P6C6fn2mV1sb+p/yblPLfi9fFolwOGIbGlXUX3QJoIHZCd
 oEYYMzV8JPdtqGXlFJoVTcBhDwqb0OlQJcLJojtoo3V7wz7bsWO2Xj2DMDQQtG4T25KV
 CvRzzZoVYhgDJxT9NQ7nhazOzl+JMVL9EUxHfFSQYYlktf3mkudLUCndbKUrXqYr/P58
 MyYfZDiRLWc3pb+A7OTn7P5Z3Fk8K91B9fff4Q6nKmswnasTF2FGbjxQFlzazZcs3jii
 gdkrCVtQx9uqUJXUB0hjnfSF+mksrZ3YFr4RxXVS1BcoGVy0QQMy+EQ47MX+j1EZlsu0
 k0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706360273; x=1706965073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yn8R3cy5Wtt8RQQZsUIgIHunCiuYV+R0tlPr+SBOSsQ=;
 b=aG72xS8qjJ4UXXLs5kskiQ6fHe68cKJLFABZNBOVjThFgUcQtVJL1JPc4B72yv4bNh
 rpmHrizul0TlwesxYRO2mWn1kQwxa/VgP3kYNyC/y2G0i/WsL9UcQzHNBm8/NqzoLWUA
 c2bH6PC1/mAGz8BeC9zIhZAUE4y21gBBnm//VPYxHj0FFdkPbapDdnoP64u0EHTHiRot
 7bFL6JdS3vCIC3tKeFWRSt445YfWd3IKwC9CgOVy7zl4lPc5gPIduVKCrOqjeco7HnOV
 9XdIwsc9SqLf3s1h6E6Bq2YOPdu+6p+tsyp6k6aq6oX6gyTw04GFYV470WMN6sq8aQGv
 OlSg==
X-Gm-Message-State: AOJu0YzxCViNkTJ7Ii4jG0Oa9IqOgLAFPEVQNTCEBc/nsqiikIx/YOPW
 nVZv4/TpMIAgNYQheE3Nlkc34fMQKF4dTHPgB4uMQNPD7ew0oFE7VBq/6zSTnMB0C8+EFbAwYH+
 1oQUJa8N1WN1GyUMV3quOkjmPQBOLttdrTS7JrKp44GMnvm33
X-Google-Smtp-Source: AGHT+IGZzxtoN/azVAOG3HPxX0rJ5kbi8wan50fkQr5g8TsRVXcOV0fIri08pNx3n0a2q7mMBBIK0X4sJERmAtHG7ZA=
X-Received: by 2002:a05:6402:34cb:b0:55d:3ac8:b72 with SMTP id
 w11-20020a05640234cb00b0055d3ac80b72mr1511205edc.3.1706360272731; Sat, 27 Jan
 2024 04:57:52 -0800 (PST)
MIME-Version: 1.0
References: <7a25bd4ee1f8b06c7a51d20486aaa8bc8e1282ea.camel@amazon.co.uk>
 <CAFEAcA-LTRnJqVcu=4VpgqjBeoi_ugGRrYOnajCzn49r3ijacw@mail.gmail.com>
 <9c19c496699de2ff902a7c3df4bfa281cf98a444.camel@infradead.org>
In-Reply-To: <9c19c496699de2ff902a7c3df4bfa281cf98a444.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 27 Jan 2024 12:57:21 +0000
Message-ID: <CAFEAcA8dFcKun9Lxvpd7T9qc9uC1-TDotrAMmYFrAA8ee7cC0A@mail.gmail.com>
Subject: Re: [PATCH] doc/sphinx/hxtool.py: add optional label argument to SRST
 directive
To: David Woodhouse <dwmw2@infradead.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 27 Jan 2024 at 10:16, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Tue, 2023-12-12 at 15:04 +0000, Peter Maydell wrote:
> >
> > > --- a/docs/system/i386/xen.rst
> > > +++ b/docs/system/i386/xen.rst
> > > @@ -132,7 +132,7 @@ The example above provides the guest kernel command line after a separator
> > >   (" ``--`` ") on the Xen command line, and does not provide the guest kernel
> > >   with an actual initramfs, which would need to listed as a second multiboot
> > >   module. For more complicated alternatives, see the command line
> > > -documentation for the ``-initrd`` option.
> > > +:ref:`documentation <initrd-reference-label>` for the ``-initrd`` option.
> >
> > I think we should include the hxfile basename in the label name
> > we generate. We also don't need to say "label", it's implicitly a
> > label. Then when we refer to things we can say
> >    <qemu-options-initrd>
> >    <hmp-commands-screendump>
> >
> > and it's fairly readable what we're referring back to.
> >
> > (We could alternatively have the emitrefs option take an argument
> > for what to use in label names. I don't have a strong view on
> > which would be better.)
>
> Hm, wait... I did this as you suggest in v2 but can I also use this
> trick to eliminate the 'emitrefs' option altogether?
>
> Remember, the problem was that qemu-options.hx gets included *both*
> from invocation.rst and from qemu-manpage.rst, so the label gets
> emitted twice and is thus ambiguous. The 'emitrefs' option prevented it
> from being emitted, but is one more hoop to jump through for the next
> person who wants to use this facility. As I mentioned the 'emitrefs'
> flag in the documentation, the "if it needs documenting, FIX IT"
> instinct kicked in hard...
>
> What if we build the top-level filename into the label, e.g.
>   invocation-qemu-options-initrd
>
> Then we don't need 'emitrefs' at all.

Yeah, that seems like a reasonable approach too: the label name
gets a bit longer and clunkier but avoiding the need to have
to say specifically "emit labels like this" is nice.

-- PMM

