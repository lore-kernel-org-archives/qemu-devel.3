Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DC3D3E773
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8RBy-0003kp-2k; Tue, 05 Nov 2024 16:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8RBw-0003kS-R1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:34:25 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8RBv-0001Lw-3Y
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:34:24 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so385780a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 13:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730842461; x=1731447261; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a2UF9CfmA/HFCzdb1nGi0p6naEWaeC1BDE0s44fAk40=;
 b=EJUuBruPVNJZbtd/hbcA6pusaGFs0pvZseOVAORbOHI1xzf8CTsaeKbemNL2GMw4Xi
 zmbab9/usP2xJ50M3cHderHTffnyDCs/lnkpwAs2Wp1JagjKvsQybT5W/gHApYPJfc/n
 UjvBgmJGvIt9n8MQ852fiMx6fx9XSPzTyR8ogGyXLNauqrpyK6o6C9fWvkefcP4aJVOp
 9cEB7FCFJ1J76tpAEKo5XuFUm4eTQEDW0zq8iSqU58wF55uOK3+dyA0CQOXlUuJt3uGa
 ta8/ELqtHkkm6onpxyZnC5xX68ffJkOr2vwvfC3dF9NnRLXbhWrd3an+MMH9vq9AI10n
 3agA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730842461; x=1731447261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a2UF9CfmA/HFCzdb1nGi0p6naEWaeC1BDE0s44fAk40=;
 b=fwkz62nscCk+Dw2OOeVQ/IXrmIS0zLozgILBXrgje7aP7IF030o6Ek/+wYvCT9OmD2
 tK53sLkeLAZ1ryEpkik3joc0ecGjrs1lDcOx7hA96XWemUWyePMVPS2R7AKB76OCvOe7
 41QprekC1OKTGIGHo425l69zNe7CcF0oW7zSC7gF/9AGseeDnDZtWwODJr1oidxLQATr
 oUcI7PTbZQC8gCnzfg9f3qerkfbkpWV3DLxnu3JghmYhQ6YICFnq5aT/L97Da0T3JDG9
 TgUC6fnOhu6lRv35x1uhBlb0ibESmYkZY87arLxDCUTJU6sqTdWVizVBDlOn/wWuLA2G
 AphQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa94U5qU6HXt88Za/D4mP1ouHPxmnNjSlKRVD76eW06pgHf9900Nys9xJvl74pWPz2zm2fAs/HxC5X@nongnu.org
X-Gm-Message-State: AOJu0YyoNWv4go6ADzHuTOYvrtCGUVNRnbIv2OVxNq0/pIwHroWfc7rX
 OUYWAF9h2Xy4ADtVOLtLcaTjHEhqsJMqrEMM++rNDg95F04YKXX3ayxAAnlZWanQm0HXFKFnhfD
 Ab+Nigu65KIpxMvYPYePWsT5K0FZjN3LW4rc53UX7oaX3+CiO9mU=
X-Google-Smtp-Source: AGHT+IHoTkg8MnRAOn4rVESOVcoOBjOJN1BNaSmG7RxHzAbTcXy6Q4M0BqxPCzS/1B5qaxiGH5X3CPREfs3Bud2Ak3o=
X-Received: by 2002:a05:6402:430c:b0:5c9:46a7:527 with SMTP id
 4fb4d7f45d1cf-5cef554cc86mr308508a12.17.1730842461305; Tue, 05 Nov 2024
 13:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20241024063507.1585765-1-clg@redhat.com>
 <20241024063507.1585765-11-clg@redhat.com>
 <CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com>
 <91c2ac92-66b2-45c8-b4fe-e8f8587b0e9c@linux.ibm.com>
 <CAFEAcA84hhWu2ouirfDPbCpq_=QLQxAf3k47h0Pij8iEnOVj+A@mail.gmail.com>
 <2491bc60-9a0b-486a-8f6d-2c4c94332756@linux.ibm.com>
 <CAFEAcA85g2nX3MU5RzmBvAHT8Kis1JHhiEaBvnFFbEQkG+0OxQ@mail.gmail.com>
 <e6c33df3-49e9-4b8a-b7cb-d38c2ebee3be@linux.ibm.com>
 <CAFEAcA9La7y1Z2-nMnJDyC_p+z-3c0EnDzEE=w5LTYtRnXPT1g@mail.gmail.com>
 <1a1d29b3-c14c-42a9-93ad-c773e3b265df@linux.ibm.com>
In-Reply-To: <1a1d29b3-c14c-42a9-93ad-c773e3b265df@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 21:34:10 +0000
Message-ID: <CAFEAcA_awJURkAhyhz88iEyfe7BU-ApeHB8XZ5EeThoKFh3p5w@mail.gmail.com>
Subject: Re: [PULL 10/17] tests/functional: Convert most Aspeed machine tests
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, lena.voytek@canonical.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 5 Nov 2024 at 20:12, Stefan Berger <stefanb@linux.ibm.com> wrote:
> On 11/5/24 2:54 PM, Peter Maydell wrote:
> > On Tue, 5 Nov 2024 at 18:36, Stefan Berger <stefanb@linux.ibm.com> wrote:
> > Anyway, the thing here is that we run swtpm like this:
> >
> >   swtpm socket -d  --tpm2 --tpmstate dir=/path/to/somewhere --ctrl
> > type=unixio,path=/path/to/socket
> >
> > where we use command line arguments to tell it where to
> > put the tpmstate and the socket.
> >
> > Either:
> >   (1) there are places where it's not valid for us to tell swtpm to
> > put the tpmstate or to put the control socket
> >   (2) it's valid to put those anywhere we like
> >
> > If (1), then swtpm should give a clear error message that we've
> > given it an invalid argument (and its manpage should say what
> > the restrictions are)
>
> There are no restrictions on the swtpm level when it comes to paths.

> > If (2), then apparmor should not be rejecting this usage
>
> AppArmor file restrictions are all path based. We have support for home
> directory and /tmp, but were missing /var/tmp. So, please.
>
>  > > One of swtpm or apparmor must be wrong here and I think it should
> > be fixed. In particular, having the failure mode be "something
>
> As stated, we were going to fix the AppArmor path in the swtpm Ubuntu
> package.

But AIUI the solution you've proposed is to add the user
temp directory -- abstractions/user-tmp looks like it
adds permissions for $HOME/tmp, /var/tmp and /tmp/. None
of those will fix the failure we ran into, because we're not
using any of those tmp directories. We use a directory
that's a subdirectory of wherever the user put the build
directory, which can be anywhere the user has permissions for.

That's why I'm confused -- as far as I can see the only
way to make swtpm work the way its documentation says it
should work is to for apparmor to permit anything
(or at least to permit anything that matches the file paths
the user handed swtmp, if it can do that).

Or if you want to say "this has to be in one of these
handful of authorised /tmp/ directories", then it should
say that in the manpage and check that at init time, not fail
near-silently much later. At the moment the docs and the
distro-integration of swtmp disagree, and the effect for
somebody trying to use it is very confusing.

thanks
-- PMM

