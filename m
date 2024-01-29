Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7D8C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 17:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUVL7-0001RV-2f; Mon, 29 Jan 2024 12:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUVL5-0001QF-Ud
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:22:31 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUVL4-0003CG-6n
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:22:31 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so877059a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 09:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706548948; x=1707153748; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vdx245a1vgE4AGunjQpjIS/RiPaYsU1U/uhLXNcAFeU=;
 b=FLGgsTCfqvEFtcRng+ABU0WEIjZSk75wuMGCAE2fANE3Ma2x71p7hlJly6kuP9dV1j
 h2PC/6AMhj3NAVKH629d1SEfZJvWGxd8+jFFDMM6trYiTqbSGraEORUVQFT20arEkFex
 uybTZHZB348YNd3q8CYbpewTmnINcsDRtM8oIuNP/scPxZFKBKJcz6UCWUzvOu+bSLYb
 ESWvhAvXdSuBiULcEQTtrH/x+wDtaHZj3mRL1r3UMlLue5p7B6fk19V84eo/JSqM8SuO
 LH404gYnYihHWjEmBYDY2v4Z093zeitZL1xN5xw2LpUC/g4u7OPRIDmt3VVwxdGmYgH/
 nwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706548948; x=1707153748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vdx245a1vgE4AGunjQpjIS/RiPaYsU1U/uhLXNcAFeU=;
 b=MR0oydX2KiJhpnHTHnShy9CcgtVYBvQGho3hOogoDp3bk/f0Oq1FooMIMib3iyxa0l
 /3Fuc2zLRYEyLx1H0A8efKz5A7Oufa5lBWi4viG1HLUzdOk526dTmxA91EVSmg92JAdg
 7jBUkvJglR3dhkgduoe+PBUiUPL24sQlyhCxC/ysjaEbAHd1Q7vJYQDNMLuWNRCnGadI
 P4I692EFyNVpRzRPRVwsyYwfuFN67gvPaYxAdZT1QT67mwoj3HesiyN98JXNA8GFdVH/
 mJmT6cPi8R0XOEXMMEeg7ExLhV9Pcmxivi2BVO7fZhSbeJeMPSIEbJFTFchqHfEqM72H
 +qOQ==
X-Gm-Message-State: AOJu0YzUuFFB385LJ6CIuPPxWT1F4c93LzttWqm2EqLt4yuHvVn45zDK
 /BFWD/YiCw53HjHRhaFq1VJP05uKbSEIVQ+KVYAPWXUCk80RlG1qn5JTyMHG5ZplTHw/K5f9F53
 3/0ALlhR4syB+eZMqcrc67tJrbmMUaldPrSYr7w==
X-Google-Smtp-Source: AGHT+IEabPcbPV+hO8NqC9m/wpsd09fBp/iJiZwAXi0qdVvK0ILkLjdN5GbES/hQ7KQJ1OYbtKt+5ph/QHSjIeXCAF4=
X-Received: by 2002:a05:6402:b05:b0:55f:4bc:a747 with SMTP id
 bm5-20020a0564020b0500b0055f04bca747mr1920108edb.1.1706548948446; Mon, 29 Jan
 2024 09:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20240129030405.177100-1-peterx@redhat.com>
In-Reply-To: <20240129030405.177100-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2024 17:22:17 +0000
Message-ID: <CAFEAcA-xqCJRiOXaWL54UxDtijZizv3zS03AGH4o-Jc07VC=KQ@mail.gmail.com>
Subject: Re: [PULL 00/14] Migration 20240126 patches
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 29 Jan 2024 at 03:04, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> The following changes since commit 7a1dc45af581d2b643cdbf33c01fd96271616fbd:
>
>   Merge tag 'pull-target-arm-20240126' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-01-26 18:16:35 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20240126-pull-request
>
> for you to fetch changes up to 57fd4b4e10756448acd6c90ce041ba8dc9313efc:
>
>   Make 'uri' optional for migrate QAPI (2024-01-29 11:02:12 +0800)
>
> ----------------------------------------------------------------
> Migration Pull
>
> [dropped fabiano's patch on modifying cpu model for arm migration tests for
>  now]
>
> - Fabiano's patchset to fix migration state references in BHs
> - Fabiano's new 'n-1' migration test for CI
> - Het's fix on making "uri" optional in QMP migrate cmd
> - Markus's HMP leak fix reported by Coverity
> - Paolo's cleanup on uffd to replace u64 usage
> - Peter's small migration cleanup series all over the places
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

