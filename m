Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B9F109B464
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YqH-00031X-55; Tue, 31 Mar 2026 09:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YqG-000315-2l
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:09:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YqE-0002yV-MQ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:09:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48702d51cd0so67705515e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962549; x=1775567349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r3RlM+rF08wt8XxG2ghB/PfaAJTiOR551k3R5vp7FNY=;
 b=xW5KJf5QNXUnd5aHVk4/eREvSTTo2qO0G6RSNcQlRN1agUduvbxs0XO/liNnMta6TH
 hf/Jy0suAwTR99WTw80yBbagRDL+Nxe+kW6IAJvSpPhSJDIBfP86M/r1n+eUmaC4/uOc
 MN7dvQWRufjNSlnxxX8ngYi//ehijJ7Z8bQcTMFc3Ptfj3qGJrzeDKvrYJqVOOLGbN5v
 nPkivAG2J1n8JKdU0UcoUV6Fq2HmYGW7+H7NIBBJvaNzJHW2LraHYX+TRgdgx2F+ofTI
 WxaK/Gh9awVM6Tru9z0iWO+JDf43rzGH3aRpobUz15YDQKMR46NzIgf+NWeRxClKAb8E
 lSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962549; x=1775567349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r3RlM+rF08wt8XxG2ghB/PfaAJTiOR551k3R5vp7FNY=;
 b=R59QpGxjh+MHe16oKOWyGoFBAwMBr9/XgbnxZUXVk1OwfyT1HEMiHl1CZn68gxG8Rr
 UXxGmDwzhSDPMjL7Yxo1Ye3lZHZfaStAkvuOxEt6JNTwlbYhSViUAQQoRnqMhzQSF3Cp
 seOmg9XbhSLPS5tP/qvw9BO6HRl9XLJuFGntXlisZPNmdZkHkEJu4/xbp901PuMNKQyp
 yIyy/VbGTPhqVyLYP1aehQnBGJfvitT4I/yDbKCOPSvbCL990ySwOIaKcEYuHqc4oLNM
 eu68NSLr48dU0KwK2aPVNGLKfRPkQNh2zGebES94zJtvKjn844azouChzXHgBlFYu+mR
 nyPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/AY6R3qZTEKITLfucfJP930z+D5A1Kj+XzGVyqMq3zJ87zmaKu8Ae4C0EOXJq/0vRVId45lYZqEyR@nongnu.org
X-Gm-Message-State: AOJu0YypYHguNgo7MZqw1VGRWgq33tgEiQieQahLqO9TAX2fhn6V7p0d
 gAxtPNSlcBBuso3exNGVPrn+dMepVw4wQ8n2WTHdQGkjVLhfpZ8mEu0mm9fAmvFMQjs=
X-Gm-Gg: ATEYQzwArZulOVmrvMrH+wYLkPlZZ1n/aO8bGdG83Nl6kRsu5G6GWOoBEzcqyKPzi8L
 li7jKqOyv02W/gB6hvjwmWxXGuMlrPKKlBuwFW7t+KlR5bycNMA8QaW/mccj6dObin4xthPVq/P
 ZUpawXiJYFeKXi5WlLKZPWDVM0fpLLK9kOO5gplZY9z1aGR9me5WnBWMMazp7/CoG9NRqwE7zCh
 JAmsPudnt4oDDKw6x74EovIejndgcyYsmbBPNhrwcUUGBzV1wB1mWDtMKxnKAhlTnCEQZ4HaH5r
 jwm5ZaCGB79K1AHDSYJ8dWJkYj9EAbpFa0zJ74fD3gr7ajGBTzKKf5MCFbgrflbQfhIfPCT0/iv
 Rh0LhAJiV4FHkOT4OPYMC/pNVa/huAv8oep674uXqPtL8cevI3aYo6D0nnxNiRlHHkEVTUOybad
 kGkh7IvLXR2iJ4v55+ZzodpOIPIxbXX68/lwPluvtZgQBO/9hMd/E17ADdMq83PRy2Std3
X-Received: by 2002:a05:600c:8b51:b0:485:40c6:f507 with SMTP id
 5b1f17b1804b1-48727f1f47cmr336366035e9.30.1774962549094; 
 Tue, 31 Mar 2026 06:09:09 -0700 (PDT)
Received: from [10.193.39.66] (43.149.216.82.rev.sfr.net. [82.216.149.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887aacb8d0sm17782045e9.3.2026.03.31.06.09.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 06:09:08 -0700 (PDT)
Message-ID: <1122d60a-c7f9-466d-ab2b-c7bac6c66245@linaro.org>
Date: Tue, 31 Mar 2026 15:09:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ati-vga Coverity fixes
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>, Peter Maydell <peter.maydell@linaro.org>
References: <cover.1774904832.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1774904832.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/3/26 23:09, BALATON Zoltan wrote:
> Small patches to address Coverity warnings.
> 
> BALATON Zoltan (2):
>    ati-vga: Silence warning about operator precedence
>    ati-vga: Add upper limit to x-linear-aper-size property

Queued via hw-misc tree, thanks.

