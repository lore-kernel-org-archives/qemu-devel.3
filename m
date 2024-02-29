Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D180AC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfdAj-000383-JO; Thu, 29 Feb 2024 04:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfdAh-00037Z-ID
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:57:47 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfdAf-0004Eu-Om
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:57:47 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-565a3910f86so1083406a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 01:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709200662; x=1709805462; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HcmnGdz2NuyKzFcZW1UeRlUNOQiZYvNR34yXhVjWpQ=;
 b=UFCsl0+Ll707K4d10KID96uVZWfQQCaLajGGXRjOXxYEUBfv6i/d9Wzvkj3VwgtWvk
 8Gq05AcOprPWeZH0nmHmyCfBf+7rxHIThpr0Lm5vPTjRNmm1/wnJX+KH1cvXD7nLoSAm
 UcfuCJScdTGnvukr1zVYICAqpi9RaAY/oZkYCFRWVzRxxVkG0z9R5nF/7up/VH1t0GcH
 qu73PtYXrh5t3ECPWhRnUl95p5fy9YKgVkA+2phF0TlkMixOU1r2kJhCygf2bk30Lrg4
 RNhSmK5xSY/X9PecND5RbySTBz2ksbntmVw+O5s1ZC35ys9lfgEaRsvwuR6rNM5TkASw
 HmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709200662; x=1709805462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9HcmnGdz2NuyKzFcZW1UeRlUNOQiZYvNR34yXhVjWpQ=;
 b=JQEtJdqntqH1qgxET/LIibVvtZub3j4BnKcOa4UyAcWf6RDEEVqamLF4uCSKjcDxFM
 zIsVCjMOgeykz+eYH4vGM5THiifzx5dTx0I8SDFc5J/9sbPlm6Mp/iyJMGxvgrGTx3A/
 YeWxqCh/p1FNrXAiiwPK0ufqqIYva1+XDxyVS6KzLBo6atmSCcy00oMkQvAsDcp4sbA9
 cJMWg34HItAGjQNmf05lf7O76p7Qt13GVa9oUq7T4xy8OPu5PghXTmXeuhRkXyLLEH6E
 zTm6GMAmQLy6ntDB3PF/lJvYDFBsyqWrLgwdXfMWjDvo+/Q+CkqhJLF1EVzZPN9ZC8BR
 fy5w==
X-Gm-Message-State: AOJu0Yz/HCbk8cURIVSIiuFkFckfxC5q3NqmFubPBuk7RQJWLZORZJz6
 eLaJz0rdHT1ZFl+3nWESZFiqeOf7RSCo1Ue0WMSHUimqWyauapXLEDFkXjtOyVCe9eTGpBrsUox
 /jMxbNRfWakEn2O26clnsSSjETH+YQq8AYLtxeg==
X-Google-Smtp-Source: AGHT+IFmB46y2QTq9/K/5I3vAhsuJwVU+h8C0cUqB2gnBhy3XaDpExGfBYIi2IrKlcvbMDBjT0V+UTFyd/z31JL6nCA=
X-Received: by 2002:a50:c94a:0:b0:565:7ce5:abdb with SMTP id
 p10-20020a50c94a000000b005657ce5abdbmr1036562edh.10.1709200662305; Thu, 29
 Feb 2024 01:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20240227222417.929367-1-komlodi@google.com>
 <CAFEAcA-EnsmNkLuJb-dVZbT0+2TPJSw94eeEbx7JNiULsMKgUg@mail.gmail.com>
 <CAGDLtxu-+5-Bc+BGbZZPWfZOjdKJzNDkOz_BxJEmHNoNFnYpbA@mail.gmail.com>
In-Reply-To: <CAGDLtxu-+5-Bc+BGbZZPWfZOjdKJzNDkOz_BxJEmHNoNFnYpbA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Feb 2024 09:57:30 +0000
Message-ID: <CAFEAcA-kT8-=TtkTsS7QoYCV_GGLOY5zA0sXAFnP+ZFi+Lx4_A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] memattrs: target/arm: add user-defined and
 requester ID memattrs
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, roqueh@google.com, slongfield@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 29 Feb 2024 at 04:52, Joe Komlodi <komlodi@google.com> wrote:
> On Wed, Feb 28, 2024 at 6:21=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > So as far as I can see, this patchset defines a bunch of mechanism,
> > but no actual users: no device looks at these new memattrs, no board
> > code sets the properties. I don't really want to add this without
> > an upstream usecase for it.
>
> Yeah, I believe the current use-cases for this series are mostly downstre=
am.
> It's possible that there's an upstream device that might benefit from
> it, but I'm not aware of one.
>
> Is the concern the usefulness of the series, or the worry about it bit-ro=
tting?
> If it's the latter, would a qtest be alright to make sure it doesn't rot?

My main issues are:
 * it's hard to review design without the uses of the code
 * it's extra complexity and maintenance burden that we don't
   need (upstream): accepting the patches gives upstream extra
   work to deal with into the future with no benefit to us
 * dead code is code that typically we would remove
 * we end up with something we can't refactor or clean up
   or change because the only reason we have it is for code
   that we don't have any visibility into: effectively it
   becomes an API for us that we can't change, which is not
   something QEMU does except for specific well defined API
   surfaces (QMP, plugins, etc)

Our usual approach is "submit the patches that add the new core
feature/mechanism along with the patches that add the new
device/board/etc that uses it". Compare the recent patches
also from Google for the ITS and SMMU that try to add hooks
that aren't needed by anything in upstream QEMU:
https://patchew.org/QEMU/20240221171716.1260192-1-nabihestefan@google.com/2=
0240221171716.1260192-3-nabihestefan@google.com/
https://patchew.org/QEMU/20240221173325.1494895-1-nabihestefan@google.com/2=
0240221173325.1494895-3-nabihestefan@google.com/
-- we rejected those for the same reason.

thanks
-- PMM

