Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10CAC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZmO4-00056L-6p; Thu, 10 Jul 2025 04:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZmO2-00054g-2F
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:12:10 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZmNr-0006L5-Jq
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:12:07 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e82314f9a51so594641276.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752135116; x=1752739916; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2s/Zqafw8AcoBzgRuZ54ScgDx0pAEPd4KULnehzKxBg=;
 b=E7M7mvRq+Dw0H+3zISFaE0lH2DDj9wIL/E4gyxU/cmzllF0SA4RcvQaYwF8N4/muyB
 BDr1xVSOyIsHieqfm2q1smheqJDyHwYao/xvFE3oBP64YihhSN41abKi5X7cr8SJq0t/
 DpmUVD76T3TjLq8yAkGarlNIswiYazZAoI9GVlt6UbUxnNh/JWGKREDC/eDZMdAjg+1K
 WL02+8ttMyN45hwjsoVoKurkAL1X8mn084g1aXp0QHPtqPQGvZ3Msg7rjvIqTl/E3Pwr
 0BZwVr+ip46Z0/WlOuc1jV/P19bjLaC/a1Sk+63F/E+JE5MevL7yQy/AGItu51PtWEbr
 yswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752135116; x=1752739916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2s/Zqafw8AcoBzgRuZ54ScgDx0pAEPd4KULnehzKxBg=;
 b=Ab0OhABpOJ/49AhvoR6U/LZIuiFIrRzTDB2y5e5Qj4BP0/0XJ9d7xI3RBRMtAVEYV2
 FZWWLfj0W9WGKiQecWXCunFx9yUwqkq1CmndvjLx+x7W2FUjFzkmH/43LwKGCmxwU4KM
 vfS/gayUprvSrM4qp/c7dgzyawO2DqVBZrnYi0iUSElheYTgjy+tFjZRqlpcGxLbvetK
 kWJFR0qZdq9d18xg7JiLOZbMdQpk/zrBu2p+RQv1LxXaVxwFstsJaV2o9lUpvtAJSIgV
 ykaOY04p197OxIC1AejdP12jFCX3UZgexckMLBhvPrKayM0E0wmepU+OltdIyyybPTzw
 v0Sg==
X-Gm-Message-State: AOJu0Yxe7jWHB7NV/xLz2YdveYJsxHIT9cP4wPaMtOQo3YT+86dO56Cp
 8jBi6C8TA9xlYly5AbwvdBh0xxptJkkvleQnALju50BRZYI4eZ3ZsYbm0vYSSOQ68VQqCGbRF3l
 GzvZNUfdRppMU/t5FayqWrhW5dqkhqhtxTwAjohsCSQ==
X-Gm-Gg: ASbGncvcHa4nexSeVleqO+56J4umNUFD5qCcr7f++NLYH3baaV8fA7UDMaQG8ypyPkx
 B2RzGunQN+Ipx0K11Kt/I/vJzIocrpNtcr1vebvX0MWgiGggZ+dY5Sq7vkbNUYDrvC2fHPQYVVK
 2fgAHN/V3b++WMt1R8fnfPxsVLt9Zl6hTiPrq+SrgEJlF7
X-Google-Smtp-Source: AGHT+IFP+d3kfFlfXU34Hul8KsHFBVCuvpuCpVKWMgez/2tubk87UqxG1pqPRadEPQ4pauRTaUj/kTpukXVQAtDyNlU=
X-Received: by 2002:a05:690c:87:b0:70d:ecdd:9bd1 with SMTP id
 00721157ae682-717b198ef8emr84285357b3.24.1752135116592; Thu, 10 Jul 2025
 01:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250703104110.992379-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250703104110.992379-1-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 09:11:44 +0100
X-Gm-Features: Ac12FXwPnQQnWUTVs71FmnCoarOVLcrYujDLpcY0gASudkRZRuyeu7_DF9hc4Qg
Message-ID: <CAFEAcA9gDM87t0RXWPdu5bi1WxcMcpRiYEcnqjzhdUiys=E0gA@mail.gmail.com>
Subject: Re: [PATCH qemu v17 0/5] arm/virt: CXL support via pxb_cxl
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, 
 Eric Auger <eric.auger@redhat.com>, mst@redhat.com,
 Zhijian Li <lizhijian@fujitsu.com>, 
 Itaru Kitayama <itaru.kitayama@linux.dev>, linuxarm@huawei.com,
 linux-cxl@vger.kernel.org, 
 qemu-arm@nongnu.org, Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 3 Jul 2025 at 11:41, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> v17: Thanks to Eric for review
> - Add a comment to the high memory map to reduce the chance of nasty
>   surprises in the future as similar to device_memory, the CXL
>   Fixed Memory Windows are of variable size as so can't be represented
>   by explicit entries in the map.
> - Updated a couple of patch descriptions to provide answers to questions
>   Eric raised.
>



Applied to target-arm.next, thanks.

-- PMM

