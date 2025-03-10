Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A57C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZKf-0007Yo-IZ; Mon, 10 Mar 2025 05:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trZKe-0007YX-5e
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:21:56 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trZKZ-0006W9-LQ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:21:55 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso3324735276.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741598509; x=1742203309; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a9kXDjFxTemfhCDsR7y7sBVjDH2Rsj9X0LFfEidaQ7o=;
 b=Md3GEjDkubWis43B4n2ybqs1B8efDlJtspgaTPTJjxrMQ+RAvBquTgAl7Nj/cuy+US
 v2y8cOMACWwtG9V/vQbfJa3cWzpxpNucnKKSX9cDyZ4SXeoDZPoNt5j9r++VWk1I6bnY
 1U3AutyXBAw7Iix1Rfy0OvROqtuSBgQOdGIutgEssgCvj1SyW0YzhQlZMvHsQ5AarrKe
 5jYyWWi6BqYJwkLO8A8UkpN7qMA2h1/JlaR81Z5m1ttKfneAFmhFK+m8ecHmDqU9+JSY
 ljeTImFVZcwkcRlbxUG6hkMaFjmLjpk6JID1nKAH77JNnQtg8SBFEs0M0kFFpPFXTbHH
 y3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741598509; x=1742203309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a9kXDjFxTemfhCDsR7y7sBVjDH2Rsj9X0LFfEidaQ7o=;
 b=PafO6nQgqQCNXrPpqwFWNsEv3dyerjLj5mvhPAg9QhMBd1Wf6yF3Y5bAhpzAU5707f
 b9gTr37KYdCWXbDYmdVi3BUwweXR981T6o0d2mOstK4aMTJ3GF6GPQmt8h/oKUuNx/Ng
 0HcfXwMsgo8oIGR/Mv4hBHj3v9Cz3J5MkBmHztlUsWzQ3dXgPv5UpNcRzFkd49j7AgNo
 zg7aJGjpYyNQqx1Q8GtDz08iGpJa5Coh6E4pTHZyKwa87K1sTzl1qRLM8ZHlIBG8eK8z
 DkWiwdbYv1+WKrMv9wCPn4OrV2OmkoBDDnJpWFrKsJMqDFHQ5LyVbb72aOgxfE2w6CRh
 FMTQ==
X-Gm-Message-State: AOJu0YycRTz02K1+JB2uFAt6Xt9czvEmBDt7u5HmUjJ7FZFUqnjb4CTC
 KFUPu567f7LhFxFqwrcyHCWc2PAzT4n9ozs7kVj/0Ff3/Yg/D4lsU/g/b+1wdragRXhnq52tY3U
 alTOnekgbjHcP7oolDzByFa6SU82NnFp3LDbhSQ==
X-Gm-Gg: ASbGncuCwTqQdQ7l0p+BwUgcuF7gj32p/UAbFu4Ec2vtDNbYBSVjYcZoFjDtD94zzJr
 mdAGnWbjsMUf6gb5YHQYZjuRk0GN++shmPfoWj/P+2jZStwPPu3ggie9CbKNZRLHhexbkFwUt2N
 aKRIh8L0aCyAvV8kYQpZ6MtGnbCiQ=
X-Google-Smtp-Source: AGHT+IGghKX1xMXFfNOEB7W6IqN3zKNeLBfL9w4xJWR+pG5Z7/FKpWtHodrz5Ukdm8PWHiw7Gq1izMUxm4eFHWF1UNU=
X-Received: by 2002:a05:6902:1201:b0:e57:87b3:d2e0 with SMTP id
 3f1490d57ef6-e635c10191cmr18229782276.3.1741598509109; Mon, 10 Mar 2025
 02:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250129082045.1319203-1-pbonzini@redhat.com>
In-Reply-To: <20250129082045.1319203-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Mar 2025 09:21:37 +0000
X-Gm-Features: AQ5f1Jq5stmSoKjijHUzDxEGedI2RntT7xSQFoiE5r9bRwQ9oollASvgtL5Tm7w
Message-ID: <CAFEAcA9=G4sdXrxWcmq9wMqu1-ZRNxObQD3hmnFauYwiQr_8YQ@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci: include full Rust backtraces in test runs
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 29 Jan 2025 at 08:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitlab-ci.d/buildtest-template.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
> index 39da7698b09..4cc19239319 100644
> --- a/.gitlab-ci.d/buildtest-template.yml
> +++ b/.gitlab-ci.d/buildtest-template.yml
> @@ -63,6 +63,7 @@
>    stage: test
>    image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
>    script:
> +    - export RUST_BACKTRACE=1
>      - source scripts/ci/gitlab-ci-section
>      - section_start buildenv "Setting up to run tests"
>      - scripts/git-submodule.sh update roms/SLOF
> --

This will only add the rust backtraces when the tests
are run from the CI logs, not when you locally run
"make check" or similar. There's probably a better place
to put this...

-- PMM

