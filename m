Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C14EC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 13:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXDv-00035r-OM; Thu, 01 Feb 2024 08:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXDt-00034x-EL
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:35:21 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXDr-0007tO-NJ
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:35:21 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2cf4fafa386so13157061fa.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 05:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706794517; x=1707399317; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=egtVNHdPlVSG5IaGePCFxxdaqS6UKSy81x3r0gBVD+g=;
 b=Aq1AzGU2njzqNp84ny7mZQYrMtdUaviBZJ3uOokP3koqoCB6XCaPkTBZwsXO6zJF4e
 U8lgZidcYbq4aNPs4c926TubpToLqlohweCY1eXWXsofm6CAAEvSf4Skoivuwy/0QtAM
 bUpONr0n/80iKwmB8H7Bx6Y4yVEuMGj5ZP2KIGM70WD308qMRdTSpBI8s25UOfyon6Bp
 vqguaFdM+vyL3QXd0ryHzxSMiU8TgnHF71jgT+BXJ2uIdP244HjODwdKKI16U12gdPUG
 osMiWeCY03ryt1OB2sPJggVr2/AcQEjS0V/9x3pE05sRI3amReDzrhIF8kN9VsVDi8+b
 1VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706794517; x=1707399317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=egtVNHdPlVSG5IaGePCFxxdaqS6UKSy81x3r0gBVD+g=;
 b=NoZdpQi1jhn6xCmtmoUBaxe7KDZWXLZUNkHyY6onPOkrZaXJ8XE1sQlEYIgcPeJfVb
 vUbvpRNfPrANWd+eIwDAhYA0FF/bRoC1AcE212SK88vcoxMuVep0um8O03FSCudWdz+F
 NQVK9VkwsAhChL7FrjMWIUajMKJVzN3SRGK2wFKbchWlnSo5bvdrvxUganb/49wJVFmV
 ZTfqoKpF9f43LV36vz3QslCA6rgx6CuA+BCin2713nlGVVCOu4gI3tH/zFm+AZmo7nEf
 N0n0dWuCr+zOXGI2bN8USjdkrVXC9n7r9+mZPAIcMr40QZlW13wcT042t/foLxgQdNnE
 mYSw==
X-Gm-Message-State: AOJu0YzLEqdOIVgTW8sOULRwkDgEgG2FtFHhEgLlekaPmepYUqnQs6k+
 CT73AfcOzG5OYA4AW/QxQ3Vs+LzRmeDCviq1/xNV1clPGPOCjdNQ22Z3qHGdvFkn4ksmpExGfGo
 xQ5ZtL/NFjCU7s/K4aZhxCGvquqXsvwmEoxgKpkzRsQTlmc1S
X-Google-Smtp-Source: AGHT+IGmr5R0hnGVaWkfaDPj6Y6XbKkl5gbksD+9gr7Si/nAn6y4s9yTWF7WZCTax6OjpfFfRIBGrAwUMkX9gm6YLZc=
X-Received: by 2002:a2e:a607:0:b0:2d0:73dd:d125 with SMTP id
 v7-20020a2ea607000000b002d073ddd125mr1378321ljp.3.1706794517489; Thu, 01 Feb
 2024 05:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20240122163607.459769-1-peter.maydell@linaro.org>
In-Reply-To: <20240122163607.459769-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 13:35:06 +0000
Message-ID: <CAFEAcA_GdUWy_UoTBUDc0zSj5WVWRCvu6QS0ZZ+GRnbFaJ_F4w@mail.gmail.com>
Subject: Re: [PATCH 0/2] system: Fix handling of '-serial none -serial
 something'
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bohdan Kostiv <bogdan.kostiv@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Mon, 22 Jan 2024 at 16:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> (This patchset fixes a bug reported by Bohdan Kostiv at
> https://lore.kernel.org/qemu-devel/CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com/
>  -- my patch 1 avoids a bug in his suggested change, and
> patch 2 is new, improving the documentation.)
>
> Currently if the user passes multiple -serial options on the command
> line, we mostly treat those as applying to the different serial
> devices in order, so that for example
>  -serial stdio -serial file:filename
> will connect the first serial port to stdio and the second to the
> named file.
>
> The exception to this is the '-serial none' serial device type.  This
> means "don't allocate this serial device", but a bug means that
> following -serial options are not correctly handled, so that
>  -serial none -serial stdio
> has the unexpected effect that stdio is connected to the first serial
> port, not the second.

I'll take this series via target-arm.next.

thanks
-- PMM

