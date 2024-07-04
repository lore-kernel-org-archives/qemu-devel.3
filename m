Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81754C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKDu-0006fe-Ai; Thu, 04 Jul 2024 07:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPKDs-0006dD-J9
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:01:56 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPKDq-00079h-1b
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:01:56 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7523f0870cso57314166b.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 04:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720090909; x=1720695709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8IRujJa0YGI2skihfxnvtYi7CNPp9baETM0WneDoFTg=;
 b=ORzSgrTwKYBJD+wVLN2LC8G+AIMrvbN/k3+r/faA8oVQn4Boh5btDA/SWFd9Z0BCb4
 ID6Tv1Rfo+0NxnTY5Kn6gL2GTEcmlFTvPWt+82gHp3FyARU1NLXAcL+7pQsBrL+RFsY2
 l3/qhVENTlJEstJAoFDoNF/SB20/GoeqN2LAjYIK9oPrWQkkLlLc9hxQHgMWrOfB6D2T
 DggngLs9yYqkw4PO5mCQjJa/9lU6t6NfjAc4ctqmt5i3KFIwHTTI+av/Sa9nRIRcdBXL
 NW0ShtwitL4EY4qW8vip5WhpoLucHW56u21nLQlRK2kE9SJuVHcwILwMzKDSZ1XzZmGS
 UeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720090909; x=1720695709;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8IRujJa0YGI2skihfxnvtYi7CNPp9baETM0WneDoFTg=;
 b=tuRPL9/cf0HBfhw3y7EOursYoClZ0/zNLpUnqnI0bsyNwNKbRhU2i7hldmyGWGu7nJ
 cyKf3Nj4nDcA6za2X77u6YvuPPsJkc0lmlcThgH1/NZ+WjiWG0TyW6qnhkzgKOc0Oie8
 rw5BYIDBuQxeWJlPgMgMW8lfmTz4QZh4khgPCiU8g+uxuOmORDuZE7YRktp/HKQADwLs
 nuE/Wjadt+8o3AbKaTYLQ+P/Zovg7jjth5xtcRBAkJFSftJ9GKzy8IlmtgQrwLgLVavF
 ijfAjz7AmPlrX/PD2/SRbBwCX4glva7zQ6be4wIyGFQGaCPwAePtUanJJWr0T0pKdDMX
 ZovQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUQUbU5LXv4yn/23uiuAKw/NRoB0iyOD6iDU/6gObHuB/m2pGfsOybRev7x8DgpJm7FUnNUdk/fwSRmiY95tBxbvRi71g=
X-Gm-Message-State: AOJu0YwxpvH81vIqs5jkqCfIiAQlkevsM57DiDnKgqEiAog9EUetLVWq
 bRD5E6UzyfWEaBfb9rwBNk/NiORMb2czbr4WiH3KPyfkt+I4fjHkp31ESlsAXFw=
X-Google-Smtp-Source: AGHT+IGbkAybDoAeJIH0ZRHO2Tm4kdR9mUpmFuysZneFEk9Z6MlVxmFa7Nzx1+sEx+wRWFMmKiACcw==
X-Received: by 2002:a17:907:3f8e:b0:a6e:f7ee:b1fa with SMTP id
 a640c23a62f3a-a77ba7225d4mr93028766b.72.1720090908342; 
 Thu, 04 Jul 2024 04:01:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b84f7sm587442066b.224.2024.07.04.04.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 04:01:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E86855F839;
 Thu,  4 Jul 2024 12:01:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>,  qemu-devel@nongnu.org,
 ajones@ventanamicro.com,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/2] system/vl.c: parse all -accel options
In-Reply-To: <CABgObfZzVN+CuCpYOpLqYERht_ipk4Xv_oydWi59WytyQtddsA@mail.gmail.com>
 (Paolo Bonzini's message of "Mon, 1 Jul 2024 18:43:40 +0200")
References: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
 <20240701133038.1489043-3-dbarboza@ventanamicro.com>
 <5e0c57ef-d06d-4cdc-8d5b-3adec8263c5f@linaro.org>
 <CABgObfZzVN+CuCpYOpLqYERht_ipk4Xv_oydWi59WytyQtddsA@mail.gmail.com>
Date: Thu, 04 Jul 2024 12:01:46 +0100
Message-ID: <87a5ixo1yd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Mon, Jul 1, 2024 at 4:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org> wrote:
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> In principle, a Reviewed-by tag is just stating that you don't know of
> any issues that would prevent the patch being included. However, as a
> frequent participant to the project, your Reviewed-by tag carries some
> weight and, to some extent, it is also a statement that you understand
> the area being modified.  A Reviewed-by from an experienced
> contributor may even imply that you could take the patch in one of
> your pull requests. (*) That makes it even more important to
> understand the area.

I think you are attaching a little too much weight to a r-b tag here as
no one was suggesting the patch go in via a different tree. Ultimately
the maintainer can always NACK a reviewed patch.=20

> I would expect that anyone with an understanding of command line
> parsing would know 1) what -accel kvm -accel tcg does, and 2) what
> .merge_lists does; and this would be enough to flag an issue
> preventing the patch from being included.

Maybe more useful would be re-wording the comment:

  /* Merge multiple uses of option into a single list? */

to be explicit about its behaviour.=20

> To be clear, I don't expect reviews to be perfect. But in this case
> I'm speaking up because the patch is literally a one line declarative
> change, and the only way to say "I've reviewed it" is by understanding
> the deeper effects of that line.

I think that's a fairly subjective requirement for something that
generally we can always use more of. I encourage people to review all
around the code base to get familiar with new sub-systems. I don't think
we should be dissuading people from exploring outside their silos. That
simple one liners can trip people up says more about the code than the
reviewer.

I sympathise with Philippe here who's current brief takes him around our
large and interconnected code base more than most.

>
> Also, I think it's fair that the submitter didn't spot the problem;
> it's okay to send out broken patches, that's part of the learning
> experience. :)
>
> Paolo
>
> (*) as opposed to Acked-by, where your review probably has been more
> conceptual than technical, and that you don't really want to take the
> patch in a pull request.
>
>
> Paolo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

