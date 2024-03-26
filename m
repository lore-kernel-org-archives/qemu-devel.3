Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967C0C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp67J-0006AZ-J6; Tue, 26 Mar 2024 08:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rp67A-00069N-1S
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:41:16 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rp677-0001w6-0v
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:41:14 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56c197d042fso2011482a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711456871; x=1712061671; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4CuG97nn0Q6Eeqa6id3xmKY4GdCXfpXLd8iOFU2gGvE=;
 b=CSuO54IjY7vkFSECCQvZoYTOaXJVL9NiQ+x79fb9QVRzkEKq5wQPZYG1Cy/TBTbX5L
 xXXBnz4irgwkKJ5UsyeboAdOPgJl9ZohlQX6IX5TS0O744a0rZKTNI3S23/NQQ0ZbgLc
 qKS8JTZC7MiSn90fIJfZDgp8PPqruY8+F6q4dby3jWp3ytTDyhYQDIYed+HCFjfdx+k3
 P8a8eI3hfhAJvqrYUQEKo+sCvxNidM2Py6zDoMYhtqK14cYbseMICI1qFxgYrW5+Jhxo
 QjCfSgBpgL+Zzd9YgyI1Jur49OUmLbrt04kJDSnQaaMOsE+yuJudCOtqgEGqdsUsgSpH
 RuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456871; x=1712061671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4CuG97nn0Q6Eeqa6id3xmKY4GdCXfpXLd8iOFU2gGvE=;
 b=uc4GLe85v/HIY1agPE+hynd57cask+ccus54UdmnJWIfmSZLn7oiBwsHY8CGwb67Df
 SDha6PQiRQAnht/hEBKRdFORpJAu1XBdNz0DaMplAi/CVD0amklNgIoI7AuY2yzGzSdt
 NTOVoFG8u4WLTELWBsGr89ZZn8wBym4kkDNydfmzmo2z3excNcVMdn7czjLZVGWDJ/CS
 9kKju49b/u5UkeH+p+ladBVO1CGG+9t5LwkGzwMu400eT9diaDBBAH1kOIvkD/Yn76po
 bWjynJr6tA14OI+2LDeYKlyRjL4W6PkvToinytQ15bkXjX491+SJGcFgphbsoXPot1Qc
 6Ibg==
X-Gm-Message-State: AOJu0Yx6oboZESOx2kfcbqnX5Mdhkr+IeL/uhgVjglh10NEkl5ipNW/M
 weYhAWa3TGzGdhaes5SbSSjsMbteloBT1BhX8YUQPaYssqTgr3VBCzvZSeQNSHhprj87Q/20a4m
 HmEtTMQr8mVvP8yROAMfdbcDRKDFi74Crcv7n+Gj8ongFz7bJ
X-Google-Smtp-Source: AGHT+IGk9qeCBd3qzgXINDPfPvszw7tpBSCG30t+pS8bOzcs8GNxnrtfvbTXVarH3nx3v9OkAlO1EQ4VGqViowBnt3U=
X-Received: by 2002:a50:9352:0:b0:56c:274a:31df with SMTP id
 n18-20020a509352000000b0056c274a31dfmr1545213eda.5.1711456871413; Tue, 26 Mar
 2024 05:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240326073420.738016-1-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Mar 2024 12:41:00 +0000
Message-ID: <CAFEAcA8j+WHFNbohrLJpYNy4=YF7NaFTGOkFf5rvPtife1tuHA@mail.gmail.com>
Subject: Re: [PULL 00/20] QAPI patches patches for 2024-03-26
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 26 Mar 2024 at 07:34, Markus Armbruster <armbru@redhat.com> wrote:
>
> This pull request does not touch code, only QAPI schema documentation
> comments and error-suppressing QAPI schema pragma
> documentation-exceptions.
>
> The following changes since commit 6a4180af9686830d88c387baab6d79563ce42a15:
>
>   Merge tag 'pull-request-2024-03-25' of https://gitlab.com/thuth/qemu into staging (2024-03-25 14:19:42 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-03-26
>
> for you to fetch changes up to 1a533ce986f52c35f324f5f4fff22cdc2619a47c:
>
>   qapi: document parameters of query-cpu-model-* QAPI commands (2024-03-26 06:36:08 +0100)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2024-03-26
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

