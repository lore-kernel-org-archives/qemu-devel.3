Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248D9C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTLyk-0007sW-1O; Fri, 26 Jan 2024 08:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTLyZ-0007q6-WC
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:10:35 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTLyU-0002SY-QG
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:10:29 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5101f2dfdadso704656e87.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706274625; x=1706879425; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hoO6tml5eWUmWBMdeAGmX1HUNBzWvp5NWspmqAq4K6Y=;
 b=hJMt0Kb2kjeBUEgc1t2AucXNlE3REup5lkHyRPFo4stdBOuKwCl01LHy/JShcMEUpq
 +yQO0QgSJZ8o57OThSJjLTDeJStkTnZIef4OUqnzB2vWe8mn32zqUiuJJ3Dj8UrbpxPw
 CPBBl5z4/coC8ZiFPm3LyllubkUnYEwoTLviuUsz1kleVEs0me/bnLYE989BCHBPcwPA
 BHb8XH0KFczfjsGHBQn2zJWE+V7vBwnVH+H//loHbcd10VEXIF4QSVOcJxYBVYvry2gM
 NozOce/xftcFkb0y83KzIMjqH5NyDMP7OS9VMBmKc6VA7R8MwoPci93rmGyBYpYxI2eq
 GZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706274625; x=1706879425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hoO6tml5eWUmWBMdeAGmX1HUNBzWvp5NWspmqAq4K6Y=;
 b=w8R0tQVboBP1md+VjAzl+WUEW6KbrDd6ETuxGYpvhLA2a6HtvzYUadKwsna36oUM/E
 AyKYed/HBgVdTNEh4+VI4Kc/1bqcwQqiD/UIc3L6Sdzbos5IWaMcXnre2u48zTrDF4PV
 e1ChU7cZ3Zq64Ura0i+5k9DCbMBcO9Py9Ifyg2jitSD8y9OuKKpySrw41vBB7DB+SzSr
 hcKDCQTL0r5JZhTLcIfwPnwlWEI7Ko4IST8Sw/04mgexNvbW931lW8Hh5WGr8nZuYACW
 Vkg21ShKQvkueksdL4dXhuzQPB4UcltTeXvXl6ufuCPF7lX2NBgkmroThMfLG0JUwzx+
 TfXQ==
X-Gm-Message-State: AOJu0YyAuKCXpv1TJn5DhTf5NP3d1/JQ91iPdTcamp0ZKmhzwdXrJDb7
 Zm/kDL6InZBkw1JWOv+Z9B/z9VEMgsH1YdbFqP/g1kBLgEugwnIRhDtXBr1IGHAa8x6Tq+qsK3m
 m2RSYuHNH/geuyqrkvaqnCfPlgvse0ObS3r+i/upTP8mzzBUu
X-Google-Smtp-Source: AGHT+IEKg2K5nTk8TbbhcHKcEJj3twSaPEOsy04q1xq9gbZ8E4gwwi/AQtHDbW+Krkdpyxlj8t1OwnGGzC2uYRMmHKw=
X-Received: by 2002:a2e:9797:0:b0:2cc:d4cd:18a3 with SMTP id
 y23-20020a2e9797000000b002ccd4cd18a3mr943748lji.89.1706274624949; Fri, 26 Jan
 2024 05:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20240126062744.265588-1-armbru@redhat.com>
In-Reply-To: <20240126062744.265588-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 13:10:14 +0000
Message-ID: <CAFEAcA85Z2Mhzx55k0SOSn38CM1urDrWOXLLNyovj5V1dRSx5Q@mail.gmail.com>
Subject: Re: [PULL 0/8] QAPI patches patches for 2024-01-26
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Fri, 26 Jan 2024 at 06:27, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 5bab95dc74d43bbb28c6a96d24c810a664432057:
>
>   Merge tag 'pull-request-2024-01-24' of https://gitlab.com/thuth/qemu into staging (2024-01-25 12:33:42 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-01-26
>
> for you to fetch changes up to 37507c14a6f562036fce98453de3e869b9c0684f:
>
>   qapi: Fix malformed "Since:" section tags (again) (2024-01-26 07:04:54 +0100)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2024-01-26
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

