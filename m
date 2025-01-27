Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C45C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcOmY-00024i-0p; Mon, 27 Jan 2025 08:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcOki-00014q-M1
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:02:14 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcOkh-00006r-1X
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:02:08 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e587cca1e47so998421276.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737982926; x=1738587726; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3uyBwHzj2AVHRnrzQUCsaSjF7zSPrzS8gQIbg7umwpQ=;
 b=WvQgMMpTD52Pmqrl2mr9ejSiQsd6m42ygTb+WZdoHo5hZmpH/HdIcNAPJBs5VFgypf
 V8N0+y7SAEq3Hq88YnN3pc8jjO+JPOFMeQPxICW0gDYFOqxYiytzbtRS9KUiJNqqCk6K
 PouKPWYZQLxA7r9UopjCQLp9cS5nGD39x+L2okvJrfY4PjNRHUu+yO0LRa8kXldPoZWe
 nSpyfreqt/wyhscMgqRHI89eKy8jtcomH47pJ+MOBpiVQ0nXD4pyKsRbSRWEpAmY8yT/
 A9smP3ewVJFFktk6oqRh4MNdY27bUajoguLQBX3xPvwkjjWJ8Tx4DqzRstaUEXf9Wmjd
 AEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737982926; x=1738587726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3uyBwHzj2AVHRnrzQUCsaSjF7zSPrzS8gQIbg7umwpQ=;
 b=piXKr0MOMOpJCsUGSHI7PAdPCuaNAHsqiLVCABxbKBm1YEp3EU+N5xS4AA3qppZzzw
 +oPzbQ4AEZc4N9LO2iLQL6aJ71bBH5VXOXDp5K8ufu1i7p9GoQCuST2elkIDVf/4WaEn
 BBpLcOGZU9Vz6aoW91/APIxI3s5g4u85V0dpmyQDZ2MdVkmJILG8ts/rwxVo4uey9oPe
 EGQAdVXTM7xG1XTkFbG32mi/AKghsyPP+PhSfyBPkLSkoPPbhV4H+qIFcS+B74wSmUxz
 HzUQ2He5Rw1/ADkygSRmGuDmpotUnD9pigi2ee58DDX8X9uOxNN0vuq3k/qJyM6XWhnh
 +MgQ==
X-Gm-Message-State: AOJu0Yy0d0AasTOlwKe1Z7I0TPCQjcjVHlwIbcRfVHDRsdQ6k2G6Br5w
 vvPPrTDmlqlgj9uGpZfZWR0Cd1+eq7Ff3ZyNIErBslQLgY1b26m9QT8Q7KZiO5zatpuaNJjMUGz
 HZ/sjHsxBuyFCxdwq6FFA0zR8e/XAFeapkHfmWg==
X-Gm-Gg: ASbGncsQQgfn66AMBBraJmwFqywzCi8AmBkQ+Lg1yTXc9iJg62N6grz2Jb7sRxnFwtO
 RrtmYC1U8VoGuO18fz7nFLaqEqKYidVB56MBvaGGAsN1ybceHtBT9q/cyLg+h+hw=
X-Google-Smtp-Source: AGHT+IHLaBM1qZzk85dBPYZpsLk0OEEyzuH3yZ8Grwzg+F93EvKRLTneH5dUHsNZm+Haw5HsAna+zcCm4Z9ZHBqz5Jg=
X-Received: by 2002:a05:6902:1791:b0:e57:327a:268 with SMTP id
 3f1490d57ef6-e57b105a86cmr28892743276.18.1737982925895; Mon, 27 Jan 2025
 05:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20250117191106.322363-1-kchamart@redhat.com>
 <20250117191106.322363-2-kchamart@redhat.com>
In-Reply-To: <20250117191106.322363-2-kchamart@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 13:01:54 +0000
X-Gm-Features: AWEUYZkC4M_jBwBZ3x7bZR6I8U6BFNGyxbmG1rgt8gCNeoiYNKK_JwjTIFf0fpc
Message-ID: <CAFEAcA9k-L+XHKEE0TMp+NZDNj1P-CVj2=y4Lk=n+O3F8t2-Fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs/cpu-features: Consistently use vCPU instead of
 VCPU
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org, 
 sebott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Fri, 17 Jan 2025 at 19:11, Kashyap Chamarthy <kchamart@redhat.com> wrote:
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  docs/system/arm/cpu-features.rst | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

