Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F086DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 20:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGkaD-0003bG-5T; Wed, 05 Nov 2025 15:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilias.apalodimas@linaro.org>)
 id 1vGka9-0003aq-KN
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 15:58:17 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilias.apalodimas@linaro.org>)
 id 1vGka7-0001H3-K0
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 15:58:16 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63f94733d6cso255335d50.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 12:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762376293; x=1762981093; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8Nuj+YloYbxd/MPJzDOHP+XYQn6PrGqtXs47yrgkb8=;
 b=pHdYk+Op2Szsgh6HV/F7amj20o4ZaGj3ws3sv6COaoVUkF6QKs0mnYiFW/ur72CY6X
 YisYTcsNt4XyOUj7mWKUYTGbnL/XZ3+q2ouMkkBVq1X4aDC6R+V7Dxpdut8kHbW9fR/u
 aSsrmVmEEpF1XPweOvoS+YwZnQDhC/xfyGK9CG+ZGdnWCkVMsKYzi9nVDx8Bg18AqYPy
 Gn6wuGNlPchPNQth+yyllERZ963Y23CmRWSbaXCxuSLaCX15IXnPuIPc5/2IiA+ynU6F
 JJOzgIE4I09Av/1CbuuY443O/wzRfjzxhrvLJLgd6jFydnvASbQ1I/RGWFusk3j7T9vw
 xHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762376293; x=1762981093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A8Nuj+YloYbxd/MPJzDOHP+XYQn6PrGqtXs47yrgkb8=;
 b=W6LNvuSuqrQZBGr4n6Rqn8gVN9huvgIY9JIJfW/+vKqj1zz5mFB+k97+BEVxPZEVRZ
 /FbHUJtF0EP2uMvwfFfjXaigoUjJ/94T+LbCG/V65fYqhTikpSgtrRHjrPIap6YIGlPq
 q6TYxBikJCoKWU63Q7bjK8HqO3CuvhqyMJ8BcXLGpZ0YbfJZfXcIYGisybQqNwqIXDZR
 Yo1ocz1aXmar01htt/p9UqMdDYMdK08eWrTvV8GexXWDl7+GEFm1+yxouXQ2f0XJLdyT
 AR9bCXV6i8m1RUxsT3kzdl4Q4kLNnVExYuO7oQeHsWu3CKuXZ5xifeOw588iICYrqvKY
 aUNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULa/e2Ha/f3FZSWD/14N8juMSjmbscA9MhyBnn/2pU6NmVDfaz5m4oQ9U6wUSzP64ksbG+RsxJ0rK2@nongnu.org
X-Gm-Message-State: AOJu0Yw0309vVOdgZI5s3GTMJg2UK85twVZhcIe3SZd2HUaNsxlmcXRi
 KykoGlftER8f0ND6dC2Swqiqk4jttnsAPd2XSX/PofIkl+rDhDiamWTsfFousDXxvUu/0D3l/6t
 cVEu24+sdBFFmvfU0Aq1on/jaPVqmM3BAC941ZafFrw==
X-Gm-Gg: ASbGncvCBdvUvOqnFVNuZks7Z5uaUxSfk7IRtht3AoGtxhzPiFrK7rL3gzGXXSDVPa6
 Hqm2n2hhOOWyX7Y3dXV2UAk7r6WdRwYxlfB6LvlTkeQLmcY9Z68jrsR8n12rhXiVrJx0i2bj+fV
 Bl0zBFP1beEoMD22/rSUe/QZ3RV9CPte2sSvh/iWhkDH/Tcq5n06frnG27Lat+SWWyv4AH7ubhU
 VeXIAZ5DwPGb9iJqqIs34Q11TwlBqKSMypneNHZ2hPit/OwiN+KmCZmhs+YaduWFuqdIaeGYZGa
 NjiV0T60JTfXf3qMxDeJE7EN2hbU3FLHSsqC97/w2w==
X-Google-Smtp-Source: AGHT+IF/eB+4MmKrVHw7FHO0Zr+0A5OtE2m3ikF65UiKsEJM/MHBlzMMy99+Tu22TFsPWKq2F7UBaGz9T7XyrfqHznE=
X-Received: by 2002:a05:690c:30b:b0:786:1e02:6349 with SMTP id
 00721157ae682-786a41bfd6emr73457987b3.34.1762376293359; Wed, 05 Nov 2025
 12:58:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <8176d000-92cb-4c10-ab75-3e2d4dee4c29@linaro.org>
In-Reply-To: <8176d000-92cb-4c10-ab75-3e2d4dee4c29@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Nov 2025 22:57:37 +0200
X-Gm-Features: AWmQ_blQJEh0fKWbTm2c2CuKbiI5O0HNljt0mirW7myreij6HpeucM0xmpQIu1w
Message-ID: <CAC_iWjLwsmPck96zRHYt_gWZf-+8dz4N6bBwFr77_afjYnSfdg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] sd: Add RPMB emulation to eMMC model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, 
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Warner Losh <imp@bsdimp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=ilias.apalodimas@linaro.org; helo=mail-yx1-xb12b.google.com
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

If the patches haven't landed yet feel free to add my acked-by as well

On Wed, 5 Nov 2025 at 18:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 4/11/25 14:03, Jan Kiszka wrote:
>
> > This closes an old gap in system integration testing for the very
> > complex ARM firmware stacks by adding fairly advanced Replay Protected
> > Memory Block (RPMB) emulation to the eMMC device model. Key programming
> > and message authentication are working, so is the write counter. Known
> > users are happy with the result. What is missing, but not only for RPMB=
-
> > related registers, is state persistence across QEMU restarts. This is O=
K
> > at this stage for most test scenarios, though, and could still be added
> > later on.
>
>
> > Jan Kiszka (6):
> >    hw/sd/sdcard: Fix size check for backing block image
> >    hw/sd/sdcard: Allow user-instantiated eMMC
> >    hw/sd/sdcard: Add basic support for RPMB partition
> >    hw/sd/sdcard: Handle RPMB MAC field
> >    scripts: Add helper script to generate eMMC block device images
> >    docs: Add eMMC device model description
>
> FTR:
> Tested-by: C=C3=A9dric Le Goater <clg@redhat.com>
>
> and also for u-boot I got a late:
> Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

cheers
/Ilias

