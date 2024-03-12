Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C66C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1r6-0002rx-QH; Tue, 12 Mar 2024 09:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk1r0-0002pQ-Cb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:07:38 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk1qx-0004ri-GB
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:07:37 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5685d46b199so3015846a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 06:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710248854; x=1710853654; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DsIIMDBcFxqUBQCOVrRhaHwdFqJs6zI6tpPqUgoYu24=;
 b=Y5xnr5aMwEIgGa3qJT4L/nTlRBajb95SeyGfC/RCtPue85ndHn0B/E/rkCCbEN3TU2
 QeiEg+VLKQa14A/NI26hh0oMvvvVxQuU6wh2DJVZ+YqZa5MbwsipZQnOzhNxBM4KldQ0
 Btr8GYh8yrZKKoCmh3sNIAnXzjf4l8vQDhj73/J5x+0h6z6X+y5Z2NHaPmdyQVqUpokw
 8s5/7vcs1Y/6XCM7ThAexpaTpfVcC709IS0omBcqwFSk+XFgsu62VeUY5r+C6kHSgV4z
 lxPdJQK4DKngi7WFCc2A2xEyPxzK/JCnrkcp2nlgd2LEtD6fspSdaDDLAcaKnxMLZ8/p
 xO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710248854; x=1710853654;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DsIIMDBcFxqUBQCOVrRhaHwdFqJs6zI6tpPqUgoYu24=;
 b=E07XuYhNl6bPpTbJCIyH1r5BFY7IpFl0pimVHSTJitq5dwKcescZyGHYyDtFYUkhtS
 t7oHf8dB6V/lmAN2yFpI430tjf9zqzHijJXoT3UEq9yw8qaGTAWoLqnW45vI6kiv195s
 uUG8oPDdj6fY3zsK6yyl4+ERnyRzNt1S6IeKAUDfGQtCyIIHggyfM/3CfvN1Oppev6f7
 ev2xSYVBg7EuW9J63XzJ7Bs8UyUVoI5hjDzTGsfeR9vR23QOBm0CVOgZaR9RlyQtSTeh
 oxwyULomx96CeX5og31z6o9V2sZ8jQVa3v+m667niukN03gPwuBVwFkvvSzmnqKCUALx
 +98A==
X-Gm-Message-State: AOJu0YySTV39oTe6qNT7ZYRtFlBLFeE9xBuyuZwamyqbATfaM9qhor1z
 sOpu5D7iyzHhhZ0VBvu6/A4xxX5MbDnYqgc0HklnkBOyv/lrvMrfdrr61OnRr3HXgsBXeWkEJBs
 B97DJnEZllx3562YAr8g0Ac3TGjC4UXvrMuoSrO5U3DNlsDHk
X-Google-Smtp-Source: AGHT+IGg78vSG+7QWG5awzow6V5WzJIuIqPX0s9T/OyAsYU/VD6JA1QDvV0VBn0WJstLbY3Ne1pGXea7/UTpJXWtKss=
X-Received: by 2002:a50:8d42:0:b0:566:d27a:2ab5 with SMTP id
 t2-20020a508d42000000b00566d27a2ab5mr2569507edt.10.1710248853759; Tue, 12 Mar
 2024 06:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 13:07:22 +0000
Message-ID: <CAFEAcA_cU4Wot4=HXUurby8rHKJ9Xyvqu_rOXk2ATMmq5j=GUg@mail.gmail.com>
Subject: Re: [PULL 00/20] target-arm queue
To: qemu-devel@nongnu.org
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

On Mon, 11 Mar 2024 at 19:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:
>
>   Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240311
>
> for you to fetch changes up to 5dd6bfd90d01e0cb27c349157208e5e4ce883846:
>
>   docs: update copyright date to the year 2024 (2024-03-11 17:21:21 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * contrib/elf2dmp: Improve robustness to corrupt input files
>  * docs: update copyright date to the year 2024
>  * hw/arm: Deprecate various old Arm machine types
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

