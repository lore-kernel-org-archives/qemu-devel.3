Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8D3C54E4A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 14:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riyAE-0001sj-AB; Sat, 09 Mar 2024 09:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riyAC-0001sZ-Fo
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 09:59:04 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riyAA-000287-Sr
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 09:59:04 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d382a78c38so34849161fa.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 06:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709996341; x=1710601141; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MUQMuURryrg2KG8fH7PIMcqoDO+ibKRgQeiWlNR7HyM=;
 b=Z++wjVeO/JPVhMpsKVW2A7Fk0ImkheR0c4XUETe80BYgekuQqyW0G+AkCWI4jzlb0d
 xrMRx5vTI9SuJtXJGgs111gqcK0sJTzPTNQ5MPtfWfYIJimlI4Tj2vhZS18jjkDmeIAO
 EZV4W8dPctoMrsgzUSaHUZBrdE233huZodnOeC1bazxyLXwYh96773HDJMGl41w155Q+
 F5xe+ewG4g+uXagGu80uG9oHKGEQuEMIOlSKKiwMR+BdvQUHUkw+e3q7RUdtmHH4ssIn
 vq/kDlpSNpzKj3I6G4bUt6erbOWILCOTzH9nJEQuulYR8qjbeB2pZGDU7lClHOoLynJk
 pBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709996341; x=1710601141;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MUQMuURryrg2KG8fH7PIMcqoDO+ibKRgQeiWlNR7HyM=;
 b=hFnFmFvV2F2ug8A+DbaTHaJ2AA8Vj8I0brLJYxUhFmAsou24f2fuXcUF2fDg9yhGJt
 OecVT0aiilOhcZ7BDsc4eycvgcKW0N3WbeDjGQ5/o1vUyDQBRMz2vcohmt/es269Ynfe
 07pwOcdhyNLd8FqJUk3vtPVqEhC8A7pBRotke5GZ47uVkBmNS0U6JPfNph2npEwd3L0S
 hLC4T7ufHbBAtvstTVhGLzUCGZ08fBEAIwL0V6Jqg9VjFuIq5ryffhhWZYDGOflSS6MA
 r8sijfsRXiM8+Lv6xkTSugs18w8D0zZN3oFrqFMNTOAciR03RzLis0BngItueA+MENqY
 /GuA==
X-Gm-Message-State: AOJu0YyBUHyAx9n90PbVUSXj8YZgxGyQm6CJE7aByXbkIMmo0afIdH6F
 P0mkdZFY2qkmBnjGtxiAESY4obDVHxO47xiCyILjCkWQRX/Jqo3/YT6999XyaUGTmLF1Pk//8Af
 9J51ZvnrC3gJHnX/TQuk0cDC9SxS568Q8S1MlmLgpfEqK5J1x
X-Google-Smtp-Source: AGHT+IFZjRu253mY44roJ6kRG7Lyb/H9cw7FKMlCWBbLTZ1LT5VxgYb/fzDxBQTmhIxt2U/5L2ou/Ch9CRLW7QyZj10=
X-Received: by 2002:a05:651c:1a12:b0:2d4:27b0:1712 with SMTP id
 by18-20020a05651c1a1200b002d427b01712mr1450217ljb.11.1709996341117; Sat, 09
 Mar 2024 06:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20240308155015.3637663-1-peter.maydell@linaro.org>
In-Reply-To: <20240308155015.3637663-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2024 14:58:50 +0000
Message-ID: <CAFEAcA-mCWWXkMY1h1R_fidM4DZ13vY-3zEvyZKUV7=rXj2RjA@mail.gmail.com>
Subject: Re: [PULL 00/14] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Fri, 8 Mar 2024 at 15:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a87:
>
>   Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-06 16:56:20 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240308
>
> for you to fetch changes up to bbf6c6dbead82292a20951eb1204442a6b838de9:
>
>   target/arm: Move v7m-related code from cpu32.c into a separate file (2024-03-08 14:45:03 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Implement FEAT_ECV
>  * STM32L4x5: Implement GPIO device
>  * Fix 32-bit SMOPA
>  * Refactor v7m related code from cpu32.c into its own file
>  * hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

