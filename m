Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1193C36009
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVMo-00081x-3D; Tue, 17 Sep 2024 06:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqVMm-0007yn-91
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:23:28 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqVMk-0004jq-NJ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:23:28 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5367ae52a01so4740390e87.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 03:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726568604; x=1727173404; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1VepKD5AHEkXWgFp2Tf2s1/T3c5CzElQVbAc95xRRNw=;
 b=C5FU50y2ymLpfrJmFU+0gW2bL6pdCP1XAtGJN9Mvn8PAnQSnlX8QWgKHx0PRAF9Ilf
 RDsh7HycKNsV0akGJTA2acJXBQ3qd8gqy9su54yedNYuRKyze+4wsTdWkHyw6s+vedx+
 Q1R5GwpsvQ5j5XU2ylJo78KpalGSQre7v167nAN1D8bDSONFiU2VoujJ1UZFC9IOvLRz
 34uzL+hvm7WsGgSb5xfl/d8DeJL6BBorm5Y5E3SW5CwfnqdfbvAKl/HyB8jvVtx2W+AJ
 LUZxADNMS5IYsIjc5H9PiFent317rIELdcAcxUHqLAUuQrxtm9TZA+z3w8lioMIZ5tJX
 fgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726568604; x=1727173404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1VepKD5AHEkXWgFp2Tf2s1/T3c5CzElQVbAc95xRRNw=;
 b=e8ah4fs+nAyTckNwF6jqcLzIrmRXrBf+JjgJS6cLATkt5bLPRgfWeDYyDTRRsVT8kX
 TefpS7ioh2Bv3eJ4JsGYrXtGp1Gq1QyktGatfDuRZ0TzFH57O7aJtOV4Y4qZdr+X18O9
 SiHbi29MLNg9N4hqZ5XbnVexVi5WmH5eb11w/wOcuCTwi2Mchsw75tSL9o272wC4Toyc
 3SCrxZxrQR+P65JryZL7e1PsMYxqnVcX/oHtolEtwM1ojyg5Jd3SKDtw9mYHJOG1VzdU
 5knvxlEa7LhZ8My8NxmGlQAmMnE4afXMe9E0Bp6I+RJ8xU3XoeomZVufHtnPblLH9AQB
 t5lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHAQ6linMrCsIOwCqKeuzD8taPtQ6qAyh8cCKJ6VsmDy40HR2LEdlN2i5wMWud0XUHw0PRGLiD9ZZy@nongnu.org
X-Gm-Message-State: AOJu0YyaCF8xIE6nUXhOm+wbF5tXk/4cW2xarXaphgjQ3shsfcZUrFHT
 MsFmRc/gzRqpHPGSD1yuvj4jF9YguUF6wp7YZJvRRyop5WG3KE5uemXXKOkXhtOF6Zy8oLdUZtG
 imcsYfvEtgAL/J1R5OEYo+62k6fOZ0hcUJl8zwQ==
X-Google-Smtp-Source: AGHT+IHjggBhB+TylOGLSEpqKrqz4C/ZRQ+dKVd5pOXk8O2raD6q8eQBMKsniGHjmAPKNOzBRnnIfky7/mHuW//KlQY=
X-Received: by 2002:a05:6512:3ca5:b0:535:6cde:5c4d with SMTP id
 2adb3069b0e04-5367feb9b81mr8731694e87.3.1726568604429; Tue, 17 Sep 2024
 03:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240915125725.33099-1-ines.varhol@telecom-paris.fr>
 <10b98c97-ff2a-430f-ab76-66cc5948b0f8@tls.msk.ru>
 <CAFEAcA_xsqUbCcgstwJWmF2uUWJGskZ04r6dNkiNpQPYbrMg2w@mail.gmail.com>
 <9732ed11-ed5f-4b2a-99bb-7de629148d95@tls.msk.ru>
In-Reply-To: <9732ed11-ed5f-4b2a-99bb-7de629148d95@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2024 11:23:13 +0100
Message-ID: <CAFEAcA_wjfCyxCtNn_UuEU2q6pGgzWUepxiEb3Mnebu=0cvNZA@mail.gmail.com>
Subject: Re: [PATCH] hw/display: Fix mirrored output in dm163
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Tue, 17 Sept 2024 at 10:54, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 17.09.2024 12:39, Peter Maydell wrote:
>
> >> This is an interesting device, I wonder if it is used by anyone?
> >
> > The device is used by the Arm b-l475e-iot01a board.
>
> I mean if it is actually used in practice, - there's just 1 commit
> for this file - it's addition in Apr this year, and that's all.
> If the image is inverted, I wonder how it worked and no one
> noticed :)

This is a fairly new board, and the authors are gradually
adding its devices.

-- PMM

