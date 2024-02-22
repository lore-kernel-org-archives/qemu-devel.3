Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7299CC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 16:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCFi-0006d3-SZ; Thu, 22 Feb 2024 11:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCFg-0006Tc-DX
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:48:52 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdCFe-0003Qo-RA
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:48:52 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-563d56ee65cso8960070a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 08:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708620529; x=1709225329; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VFIlmJCbDnFinLumDjFt01pOa6/Jgd8SLcb4okc2pdA=;
 b=PsdV0+p3Of+cVZxDQ+efYuCvB3xsM+emQ5V/TY14wDuAtTIjACpkDshAU1G1brWqS9
 fe/nPPMb1v08D5Rog32QszK73v0gYUmcqyBV99Y1d4l8VwpT6j/HeOCwpdDbAMTEev2D
 YDhf1beR1JNN6GBCXutCVJ9eVZCTD+GttrijCWiTAxuTR1xKefkXYwfWltu7GHlH5X4D
 D2wQ6gafqGnGK55YkMYUSlA/LE7//k8ugvaxQlMQ5z1CXSYfEAdauHnebIZbOyf+WdOu
 hC5jwDljhoAzHyEFi+IGMlwbZS8p9k4fozxJky7TU/lr6AXxLu0JWcSpGJv8qwCa0ihI
 vvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708620529; x=1709225329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VFIlmJCbDnFinLumDjFt01pOa6/Jgd8SLcb4okc2pdA=;
 b=DG86kG99OkNGXqLTvsNZMP1tP0eMQdeCsBAzVfjZvTCRYzvCEUbvbjfftrV5TTROv8
 qxmXxo1IuwBT/8oj0P34UfBG72L9UfqjpXOQ0ComxAYeIO2rtcUnjOhlEYevefDZsFsO
 01AaJacKZTnsR801eBabo2wICdYDQ7jtCX9Rgin5F5n/0d7vsydNjUdRUAtY9eJi81G3
 FMBYojpO0afyvuf/o2NOqg+CxOoBrWI3nE/2JwdZy+fr3rfEZYyicjz4wEz8Oj81EGZM
 ThsJ9ypBo7sFuXcMYfj2CttCUGR71LYeA0GzqcA/CHlHy5SuoC35VHvZJBBfYYrhQ1n0
 XbIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhLAfc+F292Cs7r4d76smteRVNH5UiBUh/pjTC15JNSt3ESYLgHHTYg0C1imn5B7qZl9aIiH3Iir3m5wSI4cbhu2Wp0EE=
X-Gm-Message-State: AOJu0Yx0cOpy+dyOPobHiS5mNjCnu3U6JPIjs5PE1jcXOnrmNhODfRm2
 Si2HPfnLPqeKtmNdMhUq9d9IRr7fJ0T3EtfHhPr4g56RkJo1M9nBSKmXWNu1tDljGosb4WOUsqA
 ZuXZqcV52baODtCe7Jjab8dfTHPv3IE6dtLdq4AgwxVd8AV2f
X-Google-Smtp-Source: AGHT+IH7NSeGDQpOqusitAVCPPOL1vypFq298j3L1iQ27F+UHmmHzCSmZeOd1rwaiPrJ61s7c1tzr98vobcAzBEfTqo=
X-Received: by 2002:aa7:d84d:0:b0:563:eca6:7345 with SMTP id
 f13-20020aa7d84d000000b00563eca67345mr12983107eds.9.1708620529281; Thu, 22
 Feb 2024 08:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
 <20240217-cocoa-v11-2-0a17a7e534d4@daynix.com>
In-Reply-To: <20240217-cocoa-v11-2-0a17a7e534d4@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 16:48:38 +0000
Message-ID: <CAFEAcA9PJVSiWEyDTfdUiXFAOGuHKppLtJxAxkukGgbe-YR9+w@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] ui/cocoa: Scale with NSView instead of Core
 Graphics
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sat, 17 Feb 2024 at 11:19, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Core Graphics is not accelerated and slow.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

