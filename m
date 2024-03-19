Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DEEC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 10:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmWfZ-0000Dv-56; Tue, 19 Mar 2024 06:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmWeh-00005x-CH
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 06:25:17 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmWeX-0007Uu-K9
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 06:25:15 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso6176939a12.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 03:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710843903; x=1711448703; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JcWL9HzOk0hHfXTPf/ZytE7f4oSowyXgZ1xBSNSM2GQ=;
 b=CwJyOZjFt5Ovks/ia5CvhozJNN83rNGnWzS4J3ePFVOtDR/qzM2f6BHO5l2zFqGtro
 bGeHgEFuaSwzTTpP4RM4y1HmIVlCZCfjfjaixRJ7QhvCKM8KE539X/knK1lXrp7xT9PM
 kM8x/P2oFRbSUVyrJ/9XSrtzPu7Z+l5dY8JjtCQZjSenTI3wxJf9Eo5j96cIa18tlkjm
 eagSHqxCHjnmN/KMJo0Ymo06NZriDjPWpl/YbnsO/BWFemxnRjTjXjukADgxevyjn2PY
 QtvzabdbFXOQOBjQ0ygYw+nGxNIH1MmHsdqOMO9huZv6nRRKojcUDPbiIFgy/IoILDFH
 iMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710843903; x=1711448703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JcWL9HzOk0hHfXTPf/ZytE7f4oSowyXgZ1xBSNSM2GQ=;
 b=B9Y7igwom8otUuqYrqNaZXME7tZPjfjKp71qrsUrSmGvyakYHd5VW2oNSX64nKpp5K
 +vKePf0PC7sN3E+04O1jgcCmBd0/FPgUyvOu7mq3h/3p1Vl78NOpUg8EuNX/hRfMRmsr
 mcbTJEj9sApJHuZ9w/3907pUFi6l9+t+iGf2LsFHi+6Vla377AyZCSPtJnDB8o6lIeCU
 Z9w4h9geOwJ3TxXkpj2jxgf+lpbB7fT9RXRUX+t5PqM86DgC8FqNOPz/Zjq9sCwAIG1S
 bdotP3t5L3AUXMCijmylvA5vELLHaVZOQpXQYKkGGrxLnY6dIAUkLJ1GGjSkZkzlXkbA
 PAfg==
X-Gm-Message-State: AOJu0YxsFdaJ1D5helJJl+IKpO9Sd2o66Ygwx5XJrGIOSMAzcrAOo2av
 Escg+U4XlFKbitCNzxtmQsXvNf2qIhCAwwRngR0s+97o9bHLNZdj66AB+jkmN/ZfNYL8K6wx8Lv
 +Ej7eR++axJaPPj59p9D+ojVOXJYUw1Z0VrfvpA==
X-Google-Smtp-Source: AGHT+IFkpbDOWFcnleqVS8pyLMPatLGBjwbouDCnVZzFEBs2n9Nv9JTx27xNvj7u6qYgsKwEc+x+K850c/yo5Tdspy4=
X-Received: by 2002:a05:6402:3715:b0:568:9d31:2a75 with SMTP id
 ek21-20020a056402371500b005689d312a75mr1534372edb.4.1710843903403; Tue, 19
 Mar 2024 03:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240318213550.155573-1-davydov-max@yandex-team.ru>
In-Reply-To: <20240318213550.155573-1-davydov-max@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 10:24:52 +0000
Message-ID: <CAFEAcA9Kcowzuy84SeBqi9zQv6e9Ojo57Wknw2BON2NKms=JcA@mail.gmail.com>
Subject: Re: [PULL v2 0/4] machine development tool
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com, 
 philmd@linaro.org, armbru@redhat.com, peterx@redhat.com, farosas@suse.de, 
 pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 18 Mar 2024 at 21:36, Maksim Davydov <davydov-max@yandex-team.ru> wrote:
>
> The following changes since commit ba49d760eb04630e7b15f423ebecf6c871b8f77b:
>
>   Merge tag 'pull-maintainer-final-130324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-13 15:12:14 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/davydov-max/qemu.git tags/pull-compare-mt-2024-03-19
>
> for you to fetch changes up to e12b89f71ba5b93877b6a3adc379a6369d0c9bab:
>
>   scripts: add script to compare compatibility properties (2024-03-19 00:13:54 +0300)
>
> ----------------------------------------------------------------
> Please note. This is the first pull request from me.
> My public GPG key is available here
> https://keys.openpgp.org/vks/v1/by-fingerprint/CDB5BEEF8837142579F5CDFE8E927E10F72F78D4
>
> ----------------------------------------------------------------
> scripts: add a new script for machine development
>

I said I wanted this to go via some other sub-maintainer's tree.
Please don't keep submitting direct pull requests for it.
QEMU's development flow does not generally involve people
directly submitting pull requests for patches they have written.

thanks
-- PMM

