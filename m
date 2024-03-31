Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D37CD128A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 15:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqxKZ-0000MJ-Hy; Sun, 31 Mar 2024 11:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rqxKY-0000M9-JX
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 11:42:46 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rqxKW-0003Cn-Ux
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 11:42:46 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d687da75c4so32913021fa.0
 for <qemu-devel@nongnu.org>; Sun, 31 Mar 2024 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711899763; x=1712504563; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c3SKwGw8bm5NQ9HgW/VEEFH7yGmpfqFYtDxinxGMWqQ=;
 b=WwCi1lsvJW5RfPyJiCFRGWKTBcbakSP5tiBGdfl/GmcQEEQEtMo5qe2qNX96uWhj5m
 HfSlzyFipdJx/ZIUC5/xrsBAhQIVm03UpD4Kz/ksM57tx7+Y5+BzjgQg6dTRG7lKsrz1
 E60G+CDo0LPtm2z+Kx2fBz67RxpcxRVfQWaJfdDLl/9kgWY4c7pc9w+OW56AVy8w6QQa
 ZCyqgpIxCnFRo8GlOB+XHUifkQtfeFPXREPYK7SMht0zcLxqX8XW3Bjz3YXBVEMlxMHu
 /G54pxUma9PjAX939d5UPN39MD7hWnY9GdgmzVNsemVZcdSHFWL6OBTrQHp7B5ZJ/XIH
 fRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711899763; x=1712504563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c3SKwGw8bm5NQ9HgW/VEEFH7yGmpfqFYtDxinxGMWqQ=;
 b=ZxNDPeb/Mne7wE3JevS5arnAplji5MxYSr+6rsfbzjGaTzeXnw5gZe/aLZzcAyDWdB
 vDTCGghx5mLqG91+WaiezLCH8G8GuwyM8at1BFsJrHQkhK+SDp8DLj+5XfRwfA5WVf9C
 yAiXoDKnANJXsE+YMTewpi6z/2aV+VJ0TnX29UAJHemnX+mgquRHQC/QxFYi9qi1r8mK
 F4VcN8x9yyksLRVQW4C3b4OqV/6SufrcQVxiJC3COFJ+nb4hxm2X1MGdqbTDodmzy5yu
 EmzGRcW/BNMlx2gnRCPzlt46Wto3lfqHU929rxhzaU44vdQA3IpUcC22h6c96UJ4+qQO
 zW8w==
X-Gm-Message-State: AOJu0YzyV8/s/4wmRG7tSebTJd/mRGtG5XXJ1Dz10zsHsoEkzsh5YpcS
 QurtFOzA+98JERFLjna9G2KhOmIz5KwCfBPRc1GGykJqNV97yTXbV/g8ifhZOFJxKmSL9n0so2Z
 phMtgOehMSwYc/65NfchuAoI+xLE9rv5rDm+zfQ==
X-Google-Smtp-Source: AGHT+IGL2FqiJZHcmCZ4xY5poxX426cUhz0/hlYFDZVD4+GkfAXK5QOfR8AhRyPJ3Xqx1NFcE7sF6SR+y5hKi37/JqA=
X-Received: by 2002:a2e:a60c:0:b0:2d4:b061:da01 with SMTP id
 v12-20020a2ea60c000000b002d4b061da01mr3549026ljp.19.1711899763017; Sun, 31
 Mar 2024 08:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240329071100.31376-1-jasowang@redhat.com>
In-Reply-To: <20240329071100.31376-1-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 31 Mar 2024 16:42:32 +0100
Message-ID: <CAFEAcA_6bEAiGNO_txqNe6uR9NGdFQ8dsPd6g0U2PEiTkYHmVw@mail.gmail.com>
Subject: Re: [PULL 0/5] Net patches
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

On Fri, 29 Mar 2024 at 07:11, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 5012e522aca161be5c141596c66e5cc6082538a9:
>
>   Update version for v9.0.0-rc1 release (2024-03-26 19:46:55 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to d9b33018a0da51eddceb48c42345cfb351065f3e:
>
>   Revert "tap: setting error appropriately when calling net_init_tap_one()" (2024-03-29 14:59:07 +0800)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

