Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EF1C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQGB-0005UB-1e; Wed, 13 Mar 2024 11:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkQFx-0005Ff-Cv
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 11:11:01 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkQFu-0006f9-S4
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 11:11:00 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d46dd5f222so8417811fa.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710342656; x=1710947456; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uaXkTqI9EpAo9HeThMs5S2pqOUSLOb0LeiEjrTeuZg4=;
 b=t0jK0mOMA8R+32v4DGnOWQtAITokB0okQadi+qy9ASG4PDqntU8Mys33dOmpoYIPxW
 icrf1uBNRCVqnRgbhRWmBoIDbzh/8aRZ6YymFajaq4Nt+ivDjprXf5QqrKDV1yMz+gIS
 baqzPjPh/5IQNQQusj6Egw1BKL7JWUpr/qBZJHfwJJTRUfaxAHN1h76YPke5ESNGga4/
 HlU2P+wp8tMtdu2av8uIWIE71WcpV8p4CAgseoNTBcqXA8iVhb8De1tHtYgpzldShw5i
 O8myZUSSRFxsvKcqyAWfm1fWQ0tAD5P04LRWi0UFhrRh5ghBDtXMbX7URZy+X9JEIObx
 18uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710342656; x=1710947456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uaXkTqI9EpAo9HeThMs5S2pqOUSLOb0LeiEjrTeuZg4=;
 b=tEAQTqcGzAbYhYrWAbP4RN8JcD7VLL2CbMfmu8F3f6yNALDG2qiOZdnr1/sYXiPx49
 lH8wYhL7tev+m2U9UmmIYLHttys1KADW5N+afbfjXRWwzTtL9AM1zVYCISbOqH60FsqD
 AULxcMNasjz7meOJENbJ98mPZWF0MJVqkNbB/ZmoQDhbU2risjWpZoxiyjhelCbHSTWR
 qcSFJN8FdmGWROXnGrqJlNzUxOnS6/P/RNdHhDrqoWXNMYDyD9okLmC14krB/kITADUB
 aDslbC6ifamkpncHzlSBNLcyJ4vUDUylwhmBAnLFWBcBjWmJ16h+xabZFXwaHO+kcexY
 Ad9w==
X-Gm-Message-State: AOJu0Yxe3aC59awDS5aoePXuVXiQwoFrgMDr6ZN5DSXAkE7ZwYjsgRgg
 dxxfNsR/+j+29SLN9eFH+sNv3/IudtfePfhk2QJdKkCAl1tirendDR4xpk16f4TUQak21Yfcct6
 4+FXPPY/H/QaEoNkMJ3jJ0wyz7Z4RF27pLhS8Ew==
X-Google-Smtp-Source: AGHT+IFFiHSOT2HsxOzXBZ40h2MudHD+8DJ+DGj3iXy4o982atqu62l+igLAUYks8TDAoG4BiGqGiWbhy5SJXSRQ81s=
X-Received: by 2002:a2e:350d:0:b0:2d4:16a5:b361 with SMTP id
 z13-20020a2e350d000000b002d416a5b361mr2472179ljz.25.1710342655996; Wed, 13
 Mar 2024 08:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240312190144.433336-1-stefanha@redhat.com>
In-Reply-To: <20240312190144.433336-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Mar 2024 15:10:44 +0000
Message-ID: <CAFEAcA98gQQBhQJbA-i7G034hmb0vRgrcmgTxGGKGZcTxiiVDw@mail.gmail.com>
Subject: Re: [PULL 0/2] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Tue, 12 Mar 2024 at 19:04, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 8f3f329f5e0117bd1a23a79ab751f8a7d3471e4b:
>
>   Merge tag 'migration-20240311-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-03-12 11:35:41 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 2b608e16ca00017509fa2a211b7b49aacdedb760:
>
>   meson: generate .stp files for tools too (2024-03-12 14:52:07 -0400)
>
> ----------------------------------------------------------------
> Pull request
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

