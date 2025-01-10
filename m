Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B938E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEkk-00088e-11; Fri, 10 Jan 2025 08:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWEkh-00088R-IA
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:08:39 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWEkf-0003HY-A7
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:08:39 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e54d268bc3dso3624869276.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736514516; x=1737119316; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dvMymsQDCmbiL2ljnVLLXPAHCyPr4uUkfzMu4kftXew=;
 b=WirNppGLO7PAkJTPKvf8Y02io8FPFlHD2Am2TEl2z90Fu/2hMAz/Ap8Jdc2MEDbL7r
 hoXzfBumK/ahEt+/f23UIneR4R6frssfxVbOlBCVz6JjTk0esc35cSQhZDb3Qyng07al
 7NgNgi+sfsZ26juHJzAygMBRMb5+gMti9fItugahrU8Xx+NUNfJY1uOo+6Rh0hEe2gX5
 xUJgr6SZNxyjphiushLeBRDowI+F29MLRGvwtP+gHxW17hLMo95LHRCvnXFxKsoFFYp4
 q6eZ7yisMQ/ABDbcUkjRimIYANV9FKSLZIA+bvbU/h43q60khT6c3zg5jnhn/0ixH1H+
 svEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736514516; x=1737119316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dvMymsQDCmbiL2ljnVLLXPAHCyPr4uUkfzMu4kftXew=;
 b=MmrRo6me1CKmIKXYzdLimu/qQOPmqi7zH1iaCDOfZkIFtJG8EliI46uToMo4BXHkTg
 1BEz0Ngg5clIpYB/gBK3q4E6tPFJ6yJM5ykN/+BjsaeCqxeX9AiDWZ5777FJfsrytppQ
 HS+8L8/blpmCWlI9e+atIFnT6nLLYrvUqAfiNjT2tNSfW7C61eGNqIjNhSq6K8tvVh9P
 PqQAbY+Epl4pwmOahu84jvBLr8Uk4AoT/9UrfD2WMdjUkx8I/N7KMxcYxA7bYS/bRR4y
 ClkASoN+4cKFm9L9Ad+umCd6BCkZn/9AYP1ngtZxdHVpuFZKHi11L1ustCpTVEiNsUHj
 eMFQ==
X-Gm-Message-State: AOJu0YwWRMYofU5rRZOJ1KKiO0UHbj1PhfvSrw1Gc/GvGPG/NgvOjMti
 pkt4bAp3zay8IkMWoJG/T0gEqKvIyXXwCIpYTKkBDGckJxHoIRqgYdVhUt3QYPWJdOrifgN8iXK
 egpunBIPvq0MtwUlgM077wNp8/aROFso57jnbgQ==
X-Gm-Gg: ASbGnctLtKRVUv9RNbIrbXon0/KJuCc779XXtyKZmbbTaPJUWABGz4Z0NbFlIY+XnyR
 DfPE72jjzWFEnUfnkxriv9DmBIPAPvY5JFI1ymnk=
X-Google-Smtp-Source: AGHT+IHVXdOKq2ULJgyFmbHi3zmm1x+fIn+1ZQg57oShwypFsg69QertiBWGO3swwJlLsWxu1w1Vi+s5LlDd0CzakAI=
X-Received: by 2002:a05:690c:f12:b0:6ef:698a:1f02 with SMTP id
 00721157ae682-6f5312afc4cmr89042227b3.32.1736514515715; Fri, 10 Jan 2025
 05:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20241217174442.3914177-1-peter.maydell@linaro.org>
 <0f9d4f78-88dc-46da-b987-2929758b5d6f@linaro.org>
 <CAFEAcA_7qAMb4id01vEyYh4aeCtTYx7eDK43Sadj60T8JEf6sA@mail.gmail.com>
In-Reply-To: <CAFEAcA_7qAMb4id01vEyYh4aeCtTYx7eDK43Sadj60T8JEf6sA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 13:08:24 +0000
X-Gm-Features: AbW1kvYA7C5dnJsK3wLGSKQ89VT6Tws64oJ3kYVWoGGmsQAXaCMLbUCbdiV3rpw
Message-ID: <CAFEAcA9JjKKY0BBbphOPNWJ42GwU5a7ehPBQkLSFhdYcutk3KQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Move minor arithmetic helpers out of helper.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Tue, 17 Dec 2024 at 18:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 17 Dec 2024 at 18:17, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 12/17/24 11:44, Peter Maydell wrote:
> > > helper.c includes some small TCG helper functions used for mostly
> > > arithmetic instructions.  These are TCG only and there's no need for
> > > them to be in the large and unwieldy helper.c.  Move them out to
> > > their own source file in the tcg/ subdirectory, together with the
> > > op_addsub.h multiply-included template header that they use.
> > >
> > > (Ironically, this means that helper.c no longer contains
> > > any TCG helper function definitions at all.)
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > One last tiny cleanup for the end of the year...this is a pure
> > > code movement, with no changes.
> >
> > Because of pure code movement,
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >
> > Ideally op_addsub.h would become tcg/op_addsub.h.inc too.
>
> Yeah, I did think about that but decided to be lazy :-)

I changed my mind on this one over the Christmas break:
since we're moving op_addsub.h it's better to move it directly
to the filename that we want. It should be op_addsub.c.inc,
though, not .h.inc.

-- PMM

