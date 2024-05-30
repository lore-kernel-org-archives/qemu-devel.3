Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4106C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaGS-0004yT-Q9; Thu, 30 May 2024 03:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCaGR-0004yH-GG
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCaGP-0000nP-BN
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717054312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bRO94YRkpkMHHuSH2ah+Y/bHpvnKTPaf0u9HPkg2ms=;
 b=J6jKjJMrVzK6+1TGMXLcMgYMiTBhdL9Ux8RepJG3GFxBrcnOp9nlegKEamOqNWD3H80FXD
 l9ajHlKq5raCYVD21RdTtvzAeIkcqaAvCsBFFNdTLEGbrxGXbfmHoEaB4hfwmKa5YL3IL4
 gP7NuXnkyLVnbH+mm9PBF2FfdtF9dBY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-zD3XsgAEMBGV_8Obh0U4IA-1; Thu, 30 May 2024 03:31:50 -0400
X-MC-Unique: zD3XsgAEMBGV_8Obh0U4IA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-354f31fbe0bso555078f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717054309; x=1717659109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bRO94YRkpkMHHuSH2ah+Y/bHpvnKTPaf0u9HPkg2ms=;
 b=h7LIh621W1TNGPpZc2OAhB0Pezx0Og0L6/TQjmbYht8wPulz5reehDfpNNbM9R0QnZ
 uIFiXV/adYRnFN5VF1atl4GXE4FAX9brhDhT7VDgOU2E3acshY2/fD0cR4jzFfJEqq0r
 n/qBJ4ST4HV/dSoIK3uzsnm1izd/Uz+A1Q4DdCfh8Okgde5DQJ678ircxQw+BezZN8zo
 eP4AzvNfQDQ/bhYe8zmH1V0UeyqjLJ3CVHxWz+gDu2jE5qsY8QipoAXsSE/g6ScGq7Sd
 JQ87AnOY++MtIKgeUCJVDpwHNog2Y4HgltZGCpPSvJsZ8nhIAq9gZB3PH0MccDygcmvX
 sJhA==
X-Gm-Message-State: AOJu0YwXF+ozgAziW0BU8XlFhPaZzI8kluf1jNt4+1umO19prGn75ViJ
 0SzuNESqeZ1bTqNhYhSFbgG727kqY7iAf5Nm9JWtaN7MHV5kUp+U5IMdOKgmYiHX/3utuExFDSl
 n7Me4VkI/5bUZk9Pr6IQ31CmcHaddMds9ut2LusXvMT5hSxg2IQBKABzkAlmHa77LUnGSEa6E+d
 biw+m+br+hUfflvU/SxdBXiVvWADg=
X-Received: by 2002:a05:6000:bca:b0:35a:9bce:4722 with SMTP id
 ffacd0b85a97d-35dc009a4c4mr827900f8f.30.1717054309051; 
 Thu, 30 May 2024 00:31:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfPKgzCxPakyOZI59TeVRH67z2xq2hbeeuestxtWSwLNSmU4J6U0OMZ+2oCNGMOyZ96SolA/8Mrzj78xHLfCQ=
X-Received: by 2002:a05:6000:bca:b0:35a:9bce:4722 with SMTP id
 ffacd0b85a97d-35dc009a4c4mr827882f8f.30.1717054308655; Thu, 30 May 2024
 00:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240529155548.5878-1-philmd@linaro.org>
 <20240529155548.5878-4-philmd@linaro.org>
 <CABgObfYmuvMq80Xz0ZBZQiHmKgoiSTVVqio8FmmpttT8rg64kA@mail.gmail.com>
 <7ce86375-779d-43d6-9871-7f9587c95ba6@linaro.org>
In-Reply-To: <7ce86375-779d-43d6-9871-7f9587c95ba6@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 30 May 2024 09:31:36 +0200
Message-ID: <CABgObfbvjG9bBgCwM-kL+YhjhMw1qLnQdQToCEkKW+V3trskoA@mail.gmail.com>
Subject: Re: [PATCH 3/3] semihosting: Restrict to TCG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 30, 2024 at 9:22=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 30/5/24 08:02, Paolo Bonzini wrote:
> > On Wed, May 29, 2024 at 5:56=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> wrote:
> >> It is pointless to build semihosting when TCG is not available.
> >
> > Why? I would have naively assumed that a suitable semihosting API
> > could be implemented by KVM. The justification (and thus the commit
> > message) needs to be different for each architecture if it's a matter
> > of instruction set or insufficient KVM userspace API.
>
> I wasn't sure where semihosting could be used so asked on IRC and
> Alex told me TCG only. Maybe the current implementation is TCG
> only, and I can reword. It certainly need some refactor to work
> on KVM, because currently semihosting end calling the TCG probe_access
> API, which I'm trying to restrict to TCG in order to ease linking
> multiple libtcg for the single binary (see
> https://lore.kernel.org/qemu-devel/20240529155918.6221-1-philmd@linaro.or=
g/).

Ok, that goes in the commit message though.

"Semihosting currently uses the TCG probe_access API. It is pointless
to have it in the binary when TCG isn't".

and in the first two patches:

"Semihosting currently uses the TCG probe_access API. To prepare for
encoding the TCG dependency in Kconfig, do not enable it unless TCG is
available".

But then, "select FOO if TCG" mean that it can be compiled out; so
perhaps "imply SEMIHOSTING if TCG" is better? Same for RISC-V's
"select ARM_COMPATIBLE_SEMIHOSTING if TCG".

Paolo

> > Paolo
> >
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> ---
> >>   semihosting/Kconfig | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/semihosting/Kconfig b/semihosting/Kconfig
> >> index eaf3a20ef5..fbe6ac87f9 100644
> >> --- a/semihosting/Kconfig
> >> +++ b/semihosting/Kconfig
> >> @@ -1,6 +1,7 @@
> >>
> >>   config SEMIHOSTING
> >>          bool
> >> +       depends on TCG
> >>
> >>   config ARM_COMPATIBLE_SEMIHOSTING
> >>          bool
> >> --
> >> 2.41.0
> >>
> >
>


