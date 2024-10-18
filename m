Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE548D2FFFA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1p7J-00044s-EH; Fri, 18 Oct 2024 11:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1p7H-00044b-QX
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:42:15 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1p7D-00010T-Sm
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:42:14 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c94dd7e1c0so2850855a12.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729266129; x=1729870929; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m21PZad2rLJLTKcO9mA/D+REAZ1vjk35GaRaPiKNmj4=;
 b=VJsULgu3RtX6uT7v0+2ImzG5jWinyen7j1/fOwkvedPcoC97dg8YsHw7reLJP4IIe3
 p2tlKqa24lUQq7O7ShUoHBbA6BHjb8w/veb3BcvnZGpyCpNMJJJvDR2g43e18n8vv2m5
 heKFsyvIFfAP6/+R7lYdXw3tYD2kTanOczfjNhEaE1Xj/ei0e1sZfMA8oa79StrtnyaT
 vYlp5sZ8TIBK9Wsx7tddConuRtOMHXRVZQ1LzByPpwQdA6v0ucYZmd7sd9hhoC8xYPhw
 zbEr9vbg4dHOtXNK34BPUU77GIcioLTVIF75izybKY/jErLJCe2jNO6D/7Zl3RnDnNtk
 CXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729266129; x=1729870929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m21PZad2rLJLTKcO9mA/D+REAZ1vjk35GaRaPiKNmj4=;
 b=X69DDrWka4UAR5OX1OB2gh4KO3Y8EGP+X4XxMkRPHgZxWM4yl6j/bRoRVVFL2aSQJ0
 vu301JZ7nIXQjseXPsb79jUAFWmAIN+URpvWJywKPoxmmnV+7JDPDBFUbeg/mJVGUhXF
 PTiNbSD4KKkS8Sd8qWYSMaADOAr0oGs7D5c6trLBaD6VPF9pAqNcZGBjerpDVwQYQroi
 9qAoAFcNY8f9afhzOUym5jZBMx+LOWr9kQ/Y8+7t+B1jx44sOc8KOfVAVpkmzRCBsrdz
 hK+Y1M8fAXRCRhTZ3ltEZi/u4Y/rFRktUk8FCPc8ZbyS/TwBrZYcI/pd2u8i2/f8HDNZ
 lpVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyVBkvlbZqrzVx2IW2QaLwbdQxBzKazZ9SPrTMo6lgS0xxEH98qqaVfcrfX/qDNJBLllQdHv4VPnuB@nongnu.org
X-Gm-Message-State: AOJu0YybFdHRr56b4bWzWEt7n3rlRxz+6La/A9dgJegNfdFaqN9GMDKp
 rsDVVYzDABvJYra+K4EUKe9Zs/eOCGdHtF30ymm9AMcOb6EVkhKpshbAK6BGbhYJY8try40RVnF
 CaTCeXoofmawLeZtAOgNPrj5TdhMxVZVUMVdXNg==
X-Google-Smtp-Source: AGHT+IFuLLwvIDrP4XbdWJg78Pgv3gv/5c2TyddvTYt7E+ReihDkGz9gNx/VqLFwLGYiLOPpCzaOgCXI/yqPEL/XXpI=
X-Received: by 2002:a05:6402:26ce:b0:5c9:87a0:4fcc with SMTP id
 4fb4d7f45d1cf-5ca0ac62747mr2093839a12.16.1729266129425; Fri, 18 Oct 2024
 08:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241007171700.1594342-1-titusr@google.com>
In-Reply-To: <20241007171700.1594342-1-titusr@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 16:41:58 +0100
Message-ID: <CAFEAcA-YKnQT4QUrqSgJR1_XOo-xVOCR+4Um0xxP-sZdopgHHA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: add Quanta GSZ bmc machine
To: Titus Rwantare <titusr@google.com>
Cc: minyard@acm.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 venture@google.com, wuhaotsh@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 7 Oct 2024 at 18:17, Titus Rwantare <titusr@google.com> wrote:
>
> This patch adds the quanta-gsz-bmc target, a current Google machine of
> the day. This machine will be used as a platform to enable features such
> as the PECI bmc interface, and Intel eSPI virtual wire interface in
> QEMU.
>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---

Nothing obviously wrong-looking here, but I am assuming
somebody who knows the hardware will review this.

For a new machine type, you should add something to docs/
for it. (See also
https://patchew.org/QEMU/20241018141332.942844-1-peter.maydell@linaro.org/
which is a series I just posted today that expands out
the "*-bmc" wildcards previously used in the doc titles
for these boards.)

thanks
-- PMM

