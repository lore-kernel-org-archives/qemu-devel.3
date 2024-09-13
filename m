Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A89EEE26C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 12:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp5MW-000323-NJ; Fri, 13 Sep 2024 08:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp5MU-00030l-Qs
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 08:25:18 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp5MT-0003wg-4G
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 08:25:18 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f75c205e4aso24793241fa.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 05:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726230311; x=1726835111; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6wqeetyEiXBOR9gJSjYJRNUU9bHV+6i2vasausbAYk=;
 b=f8X1tpqK28PSu0l9qq4WCttsp1VKuzGfLUXh54O9g4TSLhc36wTTvuc+Z3dAONELSM
 lll5YcY7WX6CWCMdFWYJsPci//BprOqN9Ca1oQ9lCFgLL1znTBfbwWmHABJZKNd109Hp
 rsrywWYONqWD50ntyX61DjvP5mB8r7K0WKvB6ITsR8zKckJ+YQx+hipKMAClpDzb0YWE
 JXe+1mtBeV6q3ZnIO1umj6cAekhbJWTFY0XSsLD4f0MoHsLHev4T9906jraSGy8aBMVE
 qcOPmXyN1TwU2QZzdLZ5A/b1X7266tq+irxsW96OvMIKiBMN4A46bXWGSmHl29eVk/Xh
 5CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726230311; x=1726835111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y6wqeetyEiXBOR9gJSjYJRNUU9bHV+6i2vasausbAYk=;
 b=pC/Z7Bd1GvY91pkyoOSPF4xhijyqQvzd4/jIe8tR0LUVC1cxPVMhexqP5O7FnGUP2W
 qZ3mvMkBuPUwUjnKgQVS2THFISotpGvaBPR2qUR3+YwDOqrU8bYK4JcrrX/CdlkAONFq
 W0aWnzcfMU+/cExOYDTa/oZCW1iL21J3H8CUYS0TzcFq1I+PvPcbCrCZOvr6QWzvyE5i
 WlCKl5O5S2rRPcB6muMSuAZxhAIbD2G2g8CW8B0aGHH1lwVRJ505y9GERbWrJURdKce4
 offLGqyNLgN29DBwHpJM4GvYFfYappFCXY5P+3X4o29VA+Ps74gNeCR2U/i7H31i57jX
 5F9g==
X-Gm-Message-State: AOJu0Yw3OwAmD6e7ia3jmWHnhlKdo0Q+85PAZdhExDUjMLblL05/18b2
 h0/aBsfYUydHtrNrfi0WSgB7Co45QlltJKPcfTEEiq19V74vyjpwb3eEJkT/oRzMcFDEyCQibCF
 /F2AqydfMFvX0B/2LyhQxGy+pVE0KDxnTj3dGUFGwh5ZknYXH
X-Google-Smtp-Source: AGHT+IEMVkNZ9gaJ/1glpVS5cIBqc2oaCqEqq6haWvHtL918ebsrDW+OU4OsW9INPzSWMf0Kf+EhoRZXHkaeBK3sT/o=
X-Received: by 2002:a2e:a7ca:0:b0:2f0:25dc:1894 with SMTP id
 38308e7fff4ca-2f787daf4bamr38613181fa.2.1726230311246; Fri, 13 Sep 2024
 05:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240912151003.2045031-1-peter.maydell@linaro.org>
In-Reply-To: <20240912151003.2045031-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 13:24:59 +0100
Message-ID: <CAFEAcA-ZuE4B1frfnkpS6yxu_YiTastZ9S_b=4_8zGigRtDeNg@mail.gmail.com>
Subject: Re: [PATCH v2] .gitlab-ci.d/crossbuilds.yml: Force 'make check'
 single-threaded for cross-i686-tci
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Thu, 12 Sept 2024 at 16:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The cross-i686-tci CI job is persistently flaky with various tests
> hitting timeouts.  One theory for why this is happening is that we're
> running too many tests in parallel and so sometimes a test gets
> starved of CPU and isn't able to complete within the timeout.
>
> (The environment this CI job runs in seems to cause us to default
> to a parallelism of 9 in the main CI.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> If this works we might be able to wind this up to -j2 or -j3,
> and/or consider whether other CI jobs need something similar.

I gave this a try, but unfortunately the result seems to be
that the whole job times out:
https://gitlab.com/qemu-project/qemu/-/jobs/7818441897

Maybe we could try a compromise of -j3 or thereabouts...

-- PMM

