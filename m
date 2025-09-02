Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BFDCA1015
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 21:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utYzf-0001ij-RB; Tue, 02 Sep 2025 17:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1utYzY-0001hG-3M
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 17:56:40 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1utYzW-0006Kz-Hd
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 17:56:39 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5607a16639aso1240e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756850194; x=1757454994; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tah2V2riAE2Uqzf/WVMwVVg298L2YC/w51UexRMz0XY=;
 b=M7JixF6MZ7KOIIGU2MnGyW/dOJznv1C+L87FkoGhPId6RPiBEzsl969B4KFjCWtfeX
 FF85JMW5h/ZPdVe2QvjOuMIlwW1Z4/qa861+igqQc3Kyq6FTG+OkC8mZtQ9BvS8YbTvR
 Y3cNb4ugsDzENfw9M80I8m37p+vBYtinnlj3kizMylCNbgnPtRTSAWC7x6XcrZBoG+PM
 Xs5I/zXxe7PdcBOWcbPydznmOd9p5ILSFNMsh7yt8byqKK7mxbU4wUEl63IsxR+SgMhZ
 NPZSa5DKAYdpFqBNKEEnOajpNI/PRYUTADg4FHqQ7AAOUPUAi9W4JoSDltv3/cO3YTR6
 /aUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756850194; x=1757454994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tah2V2riAE2Uqzf/WVMwVVg298L2YC/w51UexRMz0XY=;
 b=m3jfJwisN1n4GCkGL0xH0v4+Uj8EcPz9bS+V+Q8eQ0TbiKpvWWMs2CjnMZX0abZZtJ
 yG220aaFnKFSz+dDDMibfCyjBmXTgVqIx1e7uuqlbKLPPqWokYx+aiFZcCPhlXZDsE0Z
 OHOSEmiINiEcFSk1LHk9zTq1579pyDzSN9N2zVT8Zi+zbuZYGriTaOIAqju4P/J07e4E
 lE+0uwn9CBpEnwE+NP31yKWPmJ4O28IRv9Tgpa7aiL5vLEo4Au4fVYHDFvp8SEGclGxf
 N5BZzqUaIkw8DJEyqYZCTkNImvChNj1/1nKWN5ZfxEiKhqMFxvxwSQIPzUgagf7h985o
 2Viw==
X-Gm-Message-State: AOJu0YwpqvYKU6wuju8Oxkvbh5YxBa826bxiHRPgigwPXftRV21GjiKr
 nUaqTkkx2Vj+6Go+3gRzZlJNXdqfsgImaabFuDD9sM5eD/O3mHHPWDoJciLNV1fc5GzRh+nGO3v
 bE6faEGVl5aKQyN/gy3w39fyMIVEDI3Rf0nu693Af
X-Gm-Gg: ASbGncuA8Bz3EAtmR43I6KQ5Sf7gdtewNz3M0zmrzCJk53bGrE1PuZx2utMBGGnU6Op
 EEgSD+CqRIBej4nbA+md+W5ykuT4sAv3su8e0yhameUdCD2JKfeeEhbhV5MeMu0s+8EbkzM3X9r
 woPBlQKJwpZgZCNqpbVxvk4cjkVJJb7JqWBkS/AwaDROvWZgophCKccVft9xb+htq1PLRjTrVJg
 +RcJ9+xgApurfvSzBUckHB7ExnskZHU13y1s8kQNKHL6MwVQJwpGHsZ7m+R5dSc/Q==
X-Google-Smtp-Source: AGHT+IEvE1lU4welKEar8+/jKqhBXu9NpWeN5jZrhcfEGxLctYIykYVql4WzHB3B5791H9a6bqN1vafou/PhCucYPUQ=
X-Received: by 2002:a05:6512:1050:b0:55f:6ac4:c3b2 with SMTP id
 2adb3069b0e04-55f6f26c598mr904864e87.0.1756850194343; Tue, 02 Sep 2025
 14:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250902215320.1455816-1-nabihestefan@google.com>
In-Reply-To: <20250902215320.1455816-1-nabihestefan@google.com>
From: Titus Rwantare <titusr@google.com>
Date: Tue, 2 Sep 2025 14:55:55 -0700
X-Gm-Features: Ac12FXxhw7sMDjxLLh-E_PB9K2k1eaPSHP0Frgx5V-6Eygn9TYlOs_K6EO7xDRs
Message-ID: <CAMvPwGoQ9QgwG_CZi+3CZbVp84AYj4aSbcwKnuisze477gcKOg@mail.gmail.com>
Subject: Re: [PATCH] hw/sensor: added MAX16600 device model
To: Nabih Estefan <nabihestefan@google.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, pbonzini@redhat.com, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 farosas@suse.de, lvivier@redhat.com, qemu-arm@nongnu.org, 
 Shengtan Mao <stmao@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=titusr@google.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, 2 Sept 2025, 14:53 Nabih Estefan, <nabihestefan@google.com> wrote:
>
> From: Shengtan Mao <stmao@google.com>
>
> Change-Id: I5947e071fc27fd0d01c2d365545a81fda8131d32

Please remove the Gerrit Change Id.

> Signed-off-by: Shengtan Mao <stmao@google.com>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>

