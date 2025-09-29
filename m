Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52119CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 10:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Az3-0003ML-GU; Mon, 29 Sep 2025 06:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Ayy-0003LY-9v
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 06:19:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Ayo-0005mP-6c
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 06:19:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso4269330f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 03:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759141166; x=1759745966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ojC7pbcwHe/70BDPWcSTPZqjjzTdqnEx953xoTJcGw=;
 b=SZ3wTMdHsoQGQtS0P8llXpi4GgcObthJ1P0XkeMV1hvqJ9sxyS9E/rHDCtTBvj2oUC
 fswPRA8PCaeEKBhHt/jo8v+b4WOW79vkMlsBLOKQeOdWIOXoQzrYDpZ+slwO1Sr8z57T
 ONG2cZNqy7hJ7gGkEB81g0EHP17X16XVBIQgS3F1+DOHjcWrlZSRH3kAkeJgulvyaj5Y
 ai344KR8RgBGjZT8SBgDUNo5i2j2f8ASr9sor8w1Ruy+lPDPUCssE492U/K36ji8Je1d
 oOzRIYN8x5/wDmVk/0ozHyvHEVofnhFGlzb/nALuYVYfiXjVatiwBIDystlToZBGflp7
 BxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759141166; x=1759745966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ojC7pbcwHe/70BDPWcSTPZqjjzTdqnEx953xoTJcGw=;
 b=R400C8yDROQGaYC5AJZ0ne91Ot+yfUPxFdE5IqtVpJULomLBVhfMoFN4bxEdV1aLt1
 2axYsiDYeKctUkPS/Mbf7RvkQlU3WaaBeUuEWgbr/dREUTrPg3Q/4DKLB19MZF3sqsVX
 56YKTPwVwaiw/hDEoad9VKryF6Df8X3pi6xU+uhxmmgs3iwFjmEli0YU+4szTDA/wo0f
 E3hhktW7sVX9+ImMqCsysOMA+VDuLxc+l2vtwg6quVQMAxnJg4CPVcSU//lzaD/nF4Fa
 g4z6hKNlPGKCeWcE4BqHUpQkK4nhzP5lHUrlgRkmDo4fdM8KvHxvlawGt7TyhwIuoMby
 VEMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpuat2+J+T/9NyzrPCGqLTEPXxLP+LzzBKdN3lQPHvYtKtNQTip5x5gkcdyE4rfE80rgv4W9qw1tOS@nongnu.org
X-Gm-Message-State: AOJu0Yw7hiOZAy5YbPW1ySSgWRS70R/zQwmLL9ibvhW5ffnNXDWQ5zVX
 Dymom59tFx0bZEcOUxwH+LOfVyR1GJWDWwOc8dmoQ8ahOHRUrXRpueu7AfNHeFaVp6U=
X-Gm-Gg: ASbGncvFhIr3qK69ACGVLtabq4xZZlJ0+Lcv+Ed3c7b38nBDX3XlGH18II/2aDMeMaj
 iQUDNSCB5sfEESKInTNEJWZP/1QXOOT6VKTKUWs3Hm6FZL/K4U6w+vAMERS0XueusWgc01qGPjG
 8ZQSRS6Bl1mHooavkJh6kIlrKbniKBYnxSQgRcS+czi08lgIpE+cD8wTBjtGzyI+frYIhB9RBDO
 G8vW8U+NN7K/QFzbUftVBwzrCMh8kM6012sUS8eKfZFueWoZNExQM6Z4ZYgaXRJKbUuhFW0UmtH
 voE526OdmwNVYhS22Zpne2hJq/yJkR6JGP/TJeZFsjcwGmWhun7Gu1/USjbbPWiIi7iJiGMn0Ep
 bkJ040UWnxwtpdZFoHbDBLiJjs5Nhh/HcsrjIFobV/QSuElXW07HyVUYrJbdt7RgyfA==
X-Google-Smtp-Source: AGHT+IHhU0vhkddRZw/spzXsikHttjBwHk4rq7KPbo06+qdZ/Awp6aVMcwgje3rhvluOR3Wt/kvJcQ==
X-Received: by 2002:a05:6000:1acb:b0:3ec:d740:a72b with SMTP id
 ffacd0b85a97d-40e4c9859e7mr15213900f8f.42.1759141165733; 
 Mon, 29 Sep 2025 03:19:25 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb71esm17637341f8f.1.2025.09.29.03.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 03:19:25 -0700 (PDT)
Message-ID: <dfad3af6-15a7-4913-8cd2-556c32e537eb@linaro.org>
Date: Mon, 29 Sep 2025 12:19:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Register API leaks fixes
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250917114450.175892-1-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Luc,

On 17/9/25 13:44, Luc Michel wrote:
> Based-on: 20250912100059.103997-1-luc.michel@amd.com ([PATCH v5 00/47] AMD Versal Gen 2 support)


> Note: this series is based on my Versal 2 series. It modifies the CRL
> device during the register API refactoring. It can easily be rebased on
> master if needed.

Couldn't apply locally:

$ b4 shazam -t 20250912100059.103997-1-luc.michel@amd.com
[...]
$ b4 shazam -t 20250917114450.175892-1-luc.michel@amd.com
Applying: hw/core/register: remove the REGISTER device type
Patch failed at 0001 hw/core/register: remove the REGISTER device type
error: patch failed: hw/core/register.c:317
error: hw/core/register.c: patch does not apply

If it isn't too much work, I'd appreciate a v2 based on master
so I can include in my next hw-misc pull request.

Thanks,

Phil.

