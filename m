Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF72C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 22:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSOUg-0007zK-3t; Fri, 12 Jul 2024 18:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sSOUd-0007xJ-AI
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 18:11:56 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sSOUW-0001ML-FX
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 18:11:52 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fb4fa1bb34so16711585ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 15:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720822301; x=1721427101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XeEkxSw7ekJebub3o4nSVsaiAChiBDF7Bg3PQOOSspU=;
 b=Mr8YH2y1LF5WGLQch+io9y/eoVfZH+exKtaZGRiVqtbAEbApOSw/2Ev5nd3fsywf7v
 9y5UJ/gHRyyoZSX88PVKqHzLNcxg4IiLn4wmJM7XWqvXf2zV2blUIfopPsUrjGOW5zIK
 u7IJnbE9p7POIHP1WS+GZ0ByZyQBB6XiBuk4KJgtgKpM1I6Cz/m/YvFgS9qqvvYvBQZO
 YQS0WPD8HsOQRDc+VXYjpnf4V1id1jthy6CBDx4+8AF/oZY3FHexmfrPdeMIATHUpBdu
 zR392L20vFEdmQyfxJVCqWyNCBJ9028yr7quXjv7opYnwIHQJHn0AE7tjhgTXX+U1tS/
 lAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720822301; x=1721427101;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XeEkxSw7ekJebub3o4nSVsaiAChiBDF7Bg3PQOOSspU=;
 b=dI/eCh3f+5VQLsJ0QKDIs2IsaPkzPbWQY3IlBYc6WqO13aiGzWrSgVSv6Dpv48xjuu
 /Sh3UQxMCjKz/NnZ/63R85tD0w7SSKOL9Iqoy06yUpnzB/sJ2l+Vcr0w0tMjPvJF1JTE
 XPbv8Fiqj+FT3zORClTMF1aAI8IGH/ODvQborrCNi3vySZcjWe2O/mb8vofQ55u34dIJ
 NK2Obr8+ThtmuYAGaUn91mG2GTaK/8ARrjV9rswvnaNP0hFFHfBx+oABEJSzD4lPRKg9
 pDGYN5pmCrKoNLDqdPhnnlGIWFjmvuJ5uN4EtqtXsMlwXkAv3OTYx8wmO8qfiETjDt07
 zisA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvNC28zCk2K5/cFcvbGcC1IbSpQpMi16F2zQtnCN6x1xkYJ3cpdg08nncXHZ7pltbqQ5+tS5kYT1Cs7nY1WZfErI4W/00=
X-Gm-Message-State: AOJu0Yw54iObRr3/D9VD9TPJD1EnjaVAbuiCLHq58r3Bw4ZO9TcM+o82
 SPcH+2ZcSY3r8VO2sz1Gq8AE9L2OA3ttsrMpHpYaJ2ikB0QbizAdKLGA7LXxRmk=
X-Google-Smtp-Source: AGHT+IF65JIyljFa6dNnXpeALoY3fOmMOXvE+J0JyWLbW38BZcdy2bCd0+OfKsYd19vPKhODLbR8CA==
X-Received: by 2002:a17:902:e5ce:b0:1f9:f3c6:ed37 with SMTP id
 d9443c01a7336-1fbb6cd19a0mr107945355ad.14.1720822300826; 
 Fri, 12 Jul 2024 15:11:40 -0700 (PDT)
Received: from ?IPV6:2607:fb90:c960:83bf:3dce:b9f2:e454:16c6?
 ([2607:fb90:c960:83bf:3dce:b9f2:e454:16c6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a290e2sm72072945ad.70.2024.07.12.15.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 15:11:40 -0700 (PDT)
Message-ID: <9b6aa7c2-cffa-4277-b5e9-f310fba93ef1@linaro.org>
Date: Fri, 12 Jul 2024 15:11:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v1 0/3] Xen queue
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org, edgar.iglesias@amd.com
References: <20240712110230.4098056-1-edgar.iglesias@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240712110230.4098056-1-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 7/12/24 04:02, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias"<edgar.iglesias@amd.com>
> 
> The following changes since commit 23901b2b721c0576007ab7580da8aa855d6042a9:
> 
>    Merge tag 'pull-target-arm-20240711' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-07-11 12:00:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/edgar.iglesias/qemu.git  tags/edgar/xen-queue-2024-07-12.for-upstream
> 
> for you to fetch changes up to 872cb9cced796e75d4f719c31d70ed5fd629efca:
> 
>    xen: mapcache: Fix unmapping of first entries in buckets (2024-07-12 00:17:36 +0200)
> 
> ----------------------------------------------------------------
> Edgars Xen queue.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

