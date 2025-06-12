Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289EFC7114A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 16:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPkQ5-0000Fy-Bh; Thu, 12 Jun 2025 12:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPkQ2-0000FV-UR
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 12:04:46 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPkQ1-00043E-90
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 12:04:46 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-70e40e3f316so8140027b3.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749744283; x=1750349083; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EefkG4AutVpnBM/hBmoXMzaEp175aj32Sbgg3k63XCY=;
 b=UtUK0LHvzs5ctOeOn27WWaMVk2mT75bZ/13ojAcqlwsY8M4y2aJmiC2xARYq4DfWVr
 0k+6ag6HDKRoP95JeDtpHWm2VWOtw1T7cxnmu/AsvLKVZKAoMaFHPCRCDThd3f24ym9F
 Lh8Epp2gVa9B/Je7+Cv6ogABbmggcA6D1FTey8bqVI6gKwMkR7Xs8QyCPTBQAIZqOFKw
 yMFNJMw6Cy7RwFBD2i6YnAEbFqYVoCfcWgfYWiYG3vCWWsxY/xLFN1vZe3BfBY7ZzlM8
 jxi7J0Zp5XcrGPFVghm9uDsHTgZG1CdOR46kGq0qOglYlqGhFyanMo+sc8O8NHBHL5Zt
 W7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749744283; x=1750349083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EefkG4AutVpnBM/hBmoXMzaEp175aj32Sbgg3k63XCY=;
 b=kjzy1LfpxbipuCVayRW7GJKeXm9KtMqFefIw4LPIBE8RpwjUenBK3jq1SknO/Gj+Ws
 qI+RHy4pjC8Ald8gpqB4BtvcxYRpYbmxOM4VRbKXIbZwkZny4YsFejNKrdLarcksh5Th
 a5hmL/l4qvXke3Gc9133p16qazIn4qhou7yRPSgMVwH/H6TBEcIpP2Xtu00+pEcUSWGo
 cu86YviQ3ZRD4zsvB4070jbJq6PncHjWdIDzey7pY6iz6QJ+L6i2RpsO8gv+yFE1Lv0J
 9c2rlhZn39uzs+V5QbKzRrJ5H3KtznDmblFbPmOs4KJDhP/G/VeMeXlUCZdMF5Wo4HiT
 su4w==
X-Gm-Message-State: AOJu0YwtZxhZ2BK6ndWOgpNG113s1UFcClX8Q59GaeeYq9A4GHwlSlzX
 9hLj0oOSiTF+RvlImDTxQDcsuWMIM9Df8HpmFyDmaKTINQEK+IjE7apwtUxLhNbCKsJfu8TOd5d
 4pjX44o/FljqRQS5ExCVSg/MZVOVnb6YEyyEwX+S6Kw==
X-Gm-Gg: ASbGnctS7b0k+ddFhEYUTdKTpzhVAK8zooENbP4058Jj31RD0gCvnBTDtMNtF5fujDU
 oTPFFd9k3M5zsha3RImJ6o0UmbEXGqfFAXrS6I55Sp0TY+NwEmQz/s4j9Ht/L6zat2T5iuPDW30
 jqF64VDMim6Esi9RKU0JtwvqqC4vAe9u1rqcs1x4Osp+BhF4XbIcgp8zE=
X-Google-Smtp-Source: AGHT+IG/sKTyln7/Rh9ZAyvgO3cTqV7x3+t7YPsMib12hMamHWC1vsfheBF6RN59okgSiPTyIy/EYdtm8QgDURCe6mQ=
X-Received: by 2002:a05:690c:46c6:b0:70e:7663:8bb4 with SMTP id
 00721157ae682-71161f3b72dmr6621557b3.25.1749744283371; Thu, 12 Jun 2025
 09:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jun 2025 17:04:32 +0100
X-Gm-Features: AX0GCFsVkhB-NNCIPuW5Ihp7pcwAXu-4Z1zJIMp9UK--qP27Z1yH3-eqLOzVB4c
Message-ID: <CAFEAcA9CuQWL2b63+XCe+vZCGR7hRSx8SkTR0LDa+Ra1Z5ur7w@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] arm/virt: CXL support via pxb_cxl
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, mst@redhat.com, 
 Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 12 Jun 2025 at 14:43, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> v15:
>   - Split the address map calculations and mmio setup into separate
>     functions in patch 2, allowing v14 patch 3 to be dropped as not
>     x86 and arm make the same calls.  Note I felt this was a sufficient
>     change to trigger dropping tags. (Zhijian Li)
>   - A few other minor tweaks.
>   - TLB issue mentioned in v14 now fixed upstream so dropped reference
>     in this cover letter.
>
> Thanks to Itaru Kitayama and Zhijian Li for testing + reviews.

Hi Jonathan -- I forget where we are on this. Do you think this
series is OK to go upstream at this point, or is there still
stuff you're iterating on here ?  (Put another way, should I
review it and consider queueing it?)

thanks
-- PMM

