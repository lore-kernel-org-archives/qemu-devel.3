Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A7FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeKN-0003gt-V9; Mon, 26 Feb 2024 11:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeKH-0003Ku-3m
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:59:37 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeKF-0008RI-Ca
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:59:36 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-564372fb762so4818320a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966774; x=1709571574; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ya2shY/nt43apiK8vLwsK44nVhf72rHSHbc3EW7QxoM=;
 b=uh4JLBgp4EMdmecZp/vWx8wkAGrpZ3ru98zyJY11jTq2JQwResr7CXxCpqcs1LeRc8
 pru7kCNI6aefHJ1y55OchttfUvY8UFlnh48Ht4KwYsCZl3Y1Rl02DpdiPxVdtCqjs/mk
 GthIPUeQT9Sz8RMialgTZUqjeDbFIPYlHTNwPS4WNwlXOouZIrOtmBaqaoYn0bZ+L3S9
 BrHcLQrHhMlZRtXkGXyqXY1f1UXbAyEVRihaPhc7jfPbKSEggI00W5r+9FV4jXQnHghX
 9KbUXko3KEh5LKMCLm/+4CiBSK+qiLtr1AzWhSPLRmVgOL92JjDS78LDazOghkpvF0E3
 REmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966774; x=1709571574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ya2shY/nt43apiK8vLwsK44nVhf72rHSHbc3EW7QxoM=;
 b=FXZ+wY3kMLc18AZcHZeX9XsK8yq4hWlPn6KyhC4XQJXPPxKSSDdGCsQ7CRavzc2j+l
 TeJzQNXzrvwMSYVfNDleklyH/L1Qzxjk2TFNI5hK2j2DPQQQ3W4fl3Kq78VWtlCVG5q3
 /idUp4X+Tb9d18MnltkI+d7ewiUBihkbIEbXU+RmnlGISPN8IRqo9uVn5TGmOQq8nxVa
 sb5jk5YvhKpBWQLk6owpeRIw6XCYuYFVafEAm0gB25YsIog1cWCtAFN/kFueRGake707
 ZB4epMdGM77NVk9jx3Q91fj9VBZcvu603bb5Yl4lrY9Ra/+1kMNJw51JAwALiQIgytvF
 4aow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSjGNhDn7bTZ2XGfEW0rgf7iel0H0HU1WU+trXI2YVb4lq/BpAwtbwT8HI2CNBNxaUOWzclF1tfA+ItHz1C+a1k+vium0=
X-Gm-Message-State: AOJu0Yy5JzJwbW/Z0CYH4Hp/yrMzLp+hSjwi1ztMyZ9SuR9QXt7+jiPU
 Gq6hkTOD0+yHOu5YxUT7taoSoOb76cdRTEvaCA75WNTwUULrSmx4UJsxIYOOnPYR5PGBG9U/KWa
 d71IFofTFfGStDdAaML1+qyKoW0kFBYahgGMLIw==
X-Google-Smtp-Source: AGHT+IG05R9sNInXR+XwoTkQOKSNTG9Bt/v+D7JGfPg4DfxMiwMHv0RDaszErCWLoX51hMjhabbYtUxtSGfUj7Qu7TQ=
X-Received: by 2002:a05:6402:14d4:b0:565:dce3:66fd with SMTP id
 f20-20020a05640214d400b00565dce366fdmr2855039edx.23.1708966773731; Mon, 26
 Feb 2024 08:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
 <20240224-cocoa-v12-2-e89f70bdda71@daynix.com>
In-Reply-To: <20240224-cocoa-v12-2-e89f70bdda71@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:59:22 +0000
Message-ID: <CAFEAcA-C+T9vpx9KmPtFX-tkoujwQ3RdHX4UCShLpqUOuubgSg@mail.gmail.com>
Subject: Re: [PATCH v12 02/10] ui/cocoa: Immediately call [-QemuCocoaView
 handleMouseEvent:buttons:]
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sat, 24 Feb 2024 at 12:43, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Instead of using mouse_event variable to tell to handle a mouse event
> later, immediately call [-QemuCocoaView handleMouseEvent:buttons:].
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

