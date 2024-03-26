Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A34C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 19:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpCkf-0006Vt-Dv; Tue, 26 Mar 2024 15:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpCkd-0006VJ-75
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:46:27 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpCkb-0000bI-Cf
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:46:26 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d47a92cfefso70992991fa.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 12:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711482383; x=1712087183; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B8QESpYEojoo59PXvmYrnHM+qnt7OTbFwWi4kTIC4Ns=;
 b=LGdE+tfR+q1QvOLZ4ukiRrht95FeSI1WQQoxq2g4fMyihNlIPrjlYSNSAIRzaQq9Lw
 mJiPIwLvpB76GwBpVO1+26f7xZF2BSj4Hx7HeTdclwQZeZZCFAUOzt32ri5OoI+8ycrn
 8d1TiJeOJ3IekrcgBoIxIz66dNLaUpKy5jXSRvFLYiSg8B7NHAG0sbiONRijT0TuMddC
 TZyJMfBQqstsjHRXku8Rk4xc++69RpS1utRDW/LE2b39uPIkzz+iJIA0o08TVrKhsWFP
 YFMRLOz6J41cJbBvI8RPRugdQeixe7zVQxKsBe7ZexvsU/+n+vuO9dJGZPv4Xq2Jm9fW
 x8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711482383; x=1712087183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B8QESpYEojoo59PXvmYrnHM+qnt7OTbFwWi4kTIC4Ns=;
 b=fyWk4oPc55iDgUvX5ImwY76+fcTVEg/5+zTIMef5O5IW9A2q02sRhYABsSxIUaMAwt
 tW+I+9KjaQkkpE68NtggEFxuKvTBCkxkNv9GhpbjF5nwxEL64sm7jcku/EVOfKVZq818
 4oCdRcntxK8ecrWEdC9sYKompU0NnnRa6/E4MI3Cd+HUM2ozVJymr51wP98hdG3L9Yt4
 bDEXYHjcJ2FpvrsqxNdabzVTfPlNQYHxUrF2Dgkwk51OFVtBnh55zfNjJN6yAFSDqAM/
 io8k7My2BZmbb/JKAi8je0tGVO7oPwQpZtTa1eAmFcntcijG4Vwi3Hd1v2avPfOWk0xb
 6wLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8maEZTZTv9Kzwfb05oGVcNG7oTgRPNcWx1dX+hPYlIQ6haXdKS8J4MZzcl6Pj62AC1StmN23ZF58aho0cmdDMOsXytu8=
X-Gm-Message-State: AOJu0YwHFJpSmv86Orj5yQ+aFMIZWmfbHxhHzhhIt8vKkPNMgByLMnYe
 rzBAnF9FQaZgFcve5cehCDm9aNJT+gjk6BH5+Rxu+9lsSvw5Fd7TFNiUkrJrqmVm8U3u4aRZTbn
 ehyE8wBnoZJP+VqSZxfsTUm+clLNoZz3T6iucGA==
X-Google-Smtp-Source: AGHT+IHLGlFi6DyiZYk7lRW2fb4XiacCBmWGutomZztse/2vhg+b5jKtvCuZTCy1CSWRY1/Zey2KLHqUyXwb0OdkSN0=
X-Received: by 2002:a2e:8349:0:b0:2d4:986b:b58b with SMTP id
 l9-20020a2e8349000000b002d4986bb58bmr400560ljh.35.1711482383341; Tue, 26 Mar
 2024 12:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240326135440.421609-1-kwolf@redhat.com>
In-Reply-To: <20240326135440.421609-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Mar 2024 19:46:12 +0000
Message-ID: <CAFEAcA-_RZO6d5E8BfmX0wC4yG3Kfzs1Go_WcLes5OmVm08eHw@mail.gmail.com>
Subject: Re: [PULL 0/6] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Tue, 26 Mar 2024 at 13:54, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 096ae430a7b5a704af4cd94dca7200d6cb069991:
>
>   Merge tag 'pull-qapi-2024-03-26' of https://repo.or.cz/qemu/armbru into staging (2024-03-26 09:50:21 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 12d7b3bbd3333cededd3b695501d8d247239d769:
>
>   iotests: add test for stream job with an unaligned prefetch read (2024-03-26 14:21:26 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - Fix crash with unaligned prefetch requests (e.g. in stream jobs)
> - vdpa-dev: Fix initialisation order to restore VDUSE compatibility
> - iotests fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

