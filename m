Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8427EC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA2pQ-0005n6-6o; Thu, 23 May 2024 03:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA2pL-0005m5-Jq
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:25:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA2pJ-0008Fj-Lc
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:25:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4202ca70289so50163765e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716449124; x=1717053924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Amvt3yr1U7bxERPPllnATmCIhAcJ2fZugetDsd/ty+U=;
 b=mtwADiM/7jH+6OQkPODFMOHtG0SL5AKHh2xk06I71oj2hde4VXbghZAN+BdkUrCnBX
 FVyn0P0lQrGSvGjvDkDSnd2fFwINLwg2qAwwdbuZdwDb/FpG5Ahii2t+kHGgw0HuLFAo
 CrBbeDUQ0Yh9q9SKkWdQ0oyfgHukxlCfDVV7DBflUmrPjT0OG6Y3a0F6QLTJmKXyXlVJ
 9XQMkPEghv5i1QsmN0MPmC8MqUFXSevsQVaEeYPJ7RUSoICLreU1KB4hYnH5RtlN+Wc8
 jgegMTx9owUa6K5vnslB3Rcjvaldv5tVpI9IhKdl/EFdhnOL8k2JWUILI6ns9kJdNnN/
 04zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716449124; x=1717053924;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Amvt3yr1U7bxERPPllnATmCIhAcJ2fZugetDsd/ty+U=;
 b=l8H4KOx7fcWGpSjMsyF+PYm4HFIBldT45rrfdymEDM4n4K18IGk38R412/phugP3cS
 4AlGN1EP6Kb1GlRMb7yXebXB/MxgjColSTJrC/etOvNQWmDOdaiPy9ghIL6aXaJvUaQ6
 9sZD21ZSpHimoAV9FBIQbzQT2zhQLXUg7G9g5Z0c8QZSkaTc5MHYFTHXyeNeJ7IrqQtF
 7LeqYFI6UkZ5lJP4DAzqEJODEA5ZKVhn9xBvqRJ2vJ6w7p+RUwtZTv1UgAWLtyS8UJkY
 8R1gTR0kxWMYRxeuuKPYQ3/FROBTDldilVhTuelmtGunEcr8u+UIW7Ffm1c7yY2Jhu5i
 V8hg==
X-Gm-Message-State: AOJu0YwRlBrCthd1XJhDKp3eto30eRwXjj8Q30q5ED89CbMm0lIDm3pl
 3/oPqlq1mr2gMZRwQ0n3Lm+FvJD3OZLFRV8W+wwNFY6k8Ci+2cIz03WFvSIhoKM8+okKl10r6/o
 R
X-Google-Smtp-Source: AGHT+IG2S3FrgjLyUmPFveqKUeXM44RCurIbEqxSBrYiKk2mcKlcpCHQT92vb/CQ5I2s7NjnXhMFGQ==
X-Received: by 2002:a05:600c:2245:b0:419:f31e:267c with SMTP id
 5b1f17b1804b1-420fd2d9b5dmr29982175e9.7.1716449124112; 
 Thu, 23 May 2024 00:25:24 -0700 (PDT)
Received: from meli-email.org (adsl-73.37.6.3.tellas.gr. [37.6.3.73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fa95a3sm16442575e9.36.2024.05.23.00.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 00:25:23 -0700 (PDT)
Date: Thu, 23 May 2024 10:25:10 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/4] MAINTAINERS: drop usb maintainership
User-Agent: meli 0.8.5
References: <20240516120344.531521-1-kraxel@redhat.com>
 <20240516120344.531521-3-kraxel@redhat.com>
In-Reply-To: <20240516120344.531521-3-kraxel@redhat.com>
Message-ID: <dxgma.fy4ytr0mcmb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

On Thu, 16 May 2024 15:03, Gerd Hoffmann <kraxel@redhat.com> wrote:
>Remove myself from usb entries.
>Flip status to "Orphan" for entries which have nobody else listed.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> MAINTAINERS | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 7f52e2912fc3..d81376f84746 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -2140,8 +2140,7 @@ F: tests/qtest/fuzz-sdcard-test.c
> F: tests/qtest/sdhci-test.c
> 
> USB
>-M: Gerd Hoffmann <kraxel@redhat.com>
>-S: Odd Fixes
>+S: Orphan
> F: hw/usb/*
> F: stubs/usb-dev-stub.c
> F: tests/qtest/usb-*-test.c
>@@ -2150,7 +2149,6 @@ F: include/hw/usb.h
> F: include/hw/usb/
> 
> USB (serial adapter)
>-R: Gerd Hoffmann <kraxel@redhat.com>
> M: Samuel Thibault <samuel.thibault@ens-lyon.org>
> S: Maintained
> F: hw/usb/dev-serial.c
>-- 
>2.45.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

