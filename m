Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC119C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 12:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGe5f-00006e-Pj; Mon, 10 Jun 2024 08:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGe5c-00005p-Ns
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 08:25:33 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGe5Z-0006XF-Em
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 08:25:31 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6269885572so944314566b.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718022327; x=1718627127; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Eq3w4yME0O1jAdNW/jpjg0o+JmuZ3WFbHzjkXW5Jx4k=;
 b=Yb9XGufVYtyKcrv4EN6E4zTBGfz+Khgm3ZA8HK8746I95GyH105aWzITjzydR9yDKM
 eFrhFnVdWpIwpWJ+IeNeJF5tsQjQyLhYFAiysjkelGu3KBRPOuJQUhvLytVjyXd/BBYf
 6YepZg4TXsz9X87fnYOOJAKENn3xYMr6T+XUUAbsVfLBW0a6m+6fzwfX5mb6rPHvitNt
 czOBnnceK3D6W8QZPuwFPfQfwrIoSkjEVVXdOqL6Nhhv7cd6AMNlGUmiNq2gwjJ/h3jz
 3+RjovGtt1elQp46StEq/oEZAsEg9nkuqv7R4EAiVzeQn1IpjzPIW31DkpOtQhpnCzEY
 /kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718022327; x=1718627127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eq3w4yME0O1jAdNW/jpjg0o+JmuZ3WFbHzjkXW5Jx4k=;
 b=miaJJMfLWaNnA28lihRRZ2v2dtw/m7pBRXF3SzVwYNRTX1/sPuh/w38uvAt3lny6sT
 g+OU03KI/8DL/YeUoA70iPDqi/M2BPJM1GXBQucY8Kh2CiDe9TIsgbYgHZdG67bRAXp7
 k8N3YvVn+SAC0aLGY0sP7fnQyzN1BisojEfZFWPfHgdxIbq/nstIb9kveHtB8R8fXsjm
 ocJ5K/QzjnwLaDbMlUc0bSPPKk/IgyVguGtsUgxqjz869xt9znSX7qUwUPyNbU8R+c6+
 m2OfbL+paPohZLtt/H/nW+Lpu+0LsvDFWYBQ1U9kGm1XfewzDcjIWxPvlDGvvgMtMsv0
 K+nA==
X-Gm-Message-State: AOJu0YyzWz96Uq4ssG3CbDqDVCegIG0jb8tKU+nLMYpmtcww0Y9uY+gF
 /0zluOTNFfFdV5qZflyJCxVjN5JzDeBv2WYf16dJIDjKzD7DGaxqFw7GecQ2A0QwhTxNCtw+zOs
 niSGEaMuH8F6bis1IEnF7X1WcKoTupSNvifF+vfqY/BIVvhO3
X-Google-Smtp-Source: AGHT+IG2o4KvidVJ8BYnYQmO74fW6p4IuUlt0NFsqG5NAVZ91eJUc+fm45BgVu0hDSoz7NDiJYcH6sqns1bri3Kzrwg=
X-Received: by 2002:a17:907:84c:b0:a65:2b64:f84a with SMTP id
 a640c23a62f3a-a6c7650a2f4mr1229562566b.25.1718022327231; Mon, 10 Jun 2024
 05:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240604145934.1230583-1-peter.maydell@linaro.org>
In-Reply-To: <20240604145934.1230583-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2024 13:25:15 +0100
Message-ID: <CAFEAcA8D-33hFsw2T40ygkjsFDj7a7=v8iupskkrptzZ-L5vqA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] scrips/coverity-scan: COMPONENTS.md updates
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Tue, 4 Jun 2024 at 15:59, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Since commit 83aa1baa069c we have been running the build for Coverity
> Scan as a Gitlab CI job, rather than the old setup where it was run
> on a local developer's machine.  This is working well, but the
> absolute paths of files are different for the Gitlab CI job, which
> means that the regexes we use to identify Coverity components no
> longer work. With Gitlab CI builds the file paths are of the form
>  /builds/qemu-project/qemu/accel/kvm/kvm-all.c
>
> rather than the old
>  /qemu/accel/kvm/kvm-all.c
>
> and our regexes all don't match.
>
> The main aim of this series is to fix that, which is what patch 1 does.
>
> Patches 2-5 are minor updates where we were missing files in some
> components because we hadn't updated them when we moved things around
> or added new files. They're worth doing now since handling patch 1
> will require a manual deletion of all components in the coverity
> web GUI and re-adding them. (There is, alas, no automated API for this.)

I'll take this via target-arm.next and do the web GUI update
at some point too.

thanks
-- PMM

