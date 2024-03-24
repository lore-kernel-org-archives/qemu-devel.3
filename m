Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2782BC47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 14:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roOd8-0008I2-22; Sun, 24 Mar 2024 10:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roOd6-0008Hj-OO
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 10:15:20 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roOd5-0007Qw-BI
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 10:15:20 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56c1374e212so57870a12.0
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711289716; x=1711894516; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3g/4ni0VR898VkfKvoUC7qc9ELXUxMoBhIEHyp1Qf80=;
 b=fPtmIg2cs2MMKzA0EkRqdMGozyk8+lB9wQLB2FGk6fdWojU2b5bybK523HMi+mQO2c
 0GAnWij8p8lMhTwZ2Oz1IzTsV1bItnjHY5gxF7RJI3ieYCnpEKrRMmUaf/wc37p9NisK
 u2FKlEc/IjW6IjhtJOj12Dn3uc5RMjcqWTREwO5jipUwbeegL5xDt31xQno7Uz5gPgcr
 fFz6zrSiuha0m6qy4sG1PxR518cZO1ubbvYuwegdvwaSD68SGAEsjHB1gYzOf2cnQzrP
 gzidytj8UILO+I0R21610mMsUazkPZzZ8Twzele+k86Bw4z+u07IdlZ3YJOf9VFvWDmn
 HHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711289716; x=1711894516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3g/4ni0VR898VkfKvoUC7qc9ELXUxMoBhIEHyp1Qf80=;
 b=LRgwUU4I1uV+CcqvIx4p6bLHui2Rhme3Q7xeTdpFJFV/h8pOF8L2KAwaDAHhSydIrr
 bC2DTj/UoM/ym08kTN9Q4sNd21sivk7H5mSJ5+EfMFCwM6xrtW5pufvmlch0l2ZLTMNK
 UKvpnij6GFzWwF7aiDynIj593EC0QcK840ufTmUTGqGF1tKQGWDwH8lj3VxsDWB1m96/
 6i6QkxisVTxOVLXwBMZguUadSgeJBVTKZZJVQEmEaGiJPsdU2ft6IMY/QZ1eEZm7BuXd
 AUljCROzvbpndwn+euHydFkan4fyBQmH9OU/Tn7ylykqWwg21YZPAmoDYQW8hSHHBoKU
 sbPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXbIReB87CzavzVpbPR2nUhhTgcS2cf//fCsdSBFGWm1IjrgTQDq+XfF2SCQxjflw7ZWZHKuxiUuIcKNa6fDrZHJGW8io=
X-Gm-Message-State: AOJu0Yy285r4sTseqH/yaZSj9CmiHGiIuzKfO5f7c0UPIRrMgIaf7OnY
 hT5XzEQ8yqx/GuAaEM3oDOiT/yL7QKuHcDEpwQh2Peb78jkvEYDJE3WviKumYrwQ4e7yCTyPtvb
 I5Y7cg20zDZvWceWqn+Zw/nO5nF21Rx+KnMoadw==
X-Google-Smtp-Source: AGHT+IGhxG9deBD5B5aqTGoF4AAo729qNVpzA/hdNPzskz6hVPRO1a4sm4Up4nVE081/fFj2TflLt3kTiN1L6bf0X3A=
X-Received: by 2002:a50:c307:0:b0:56b:d9b7:c127 with SMTP id
 a7-20020a50c307000000b0056bd9b7c127mr3617616edb.12.1711289715835; Sun, 24 Mar
 2024 07:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240323-fixes-v2-0-18651a2b0394@daynix.com>
 <20240323-fixes-v2-1-18651a2b0394@daynix.com>
In-Reply-To: <20240323-fixes-v2-1-18651a2b0394@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 Mar 2024 14:15:04 +0000
Message-ID: <CAFEAcA98QafF63JrDKG9Oy=C2QcbPn7iEx_BPnRJEQAt9Ws1sg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ui/cocoa: Fix aspect ratio
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Sat, 23 Mar 2024 at 06:20, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> [NSWindow setContentAspectRatio:] does not trigger window resize itself,
> so the wrong aspect ratio will persist if nothing resizes the window.
> Call [NSWindow setContentSize:] in such a case.
>
> Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

