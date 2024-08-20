Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C49C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 10:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgMC2-0006nC-UB; Tue, 20 Aug 2024 06:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgMC1-0006mc-Ru
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:34:25 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgMC0-0004re-D7
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:34:25 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5bebd3b7c22so7330951a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724150063; x=1724754863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0YqUTCUewhxqm9Vd9YujwXB2EaIHbrLOEvegFMLTQmw=;
 b=URsu9VSwDOUgsjVSUgy4wURuATzlEMDMPAE/IadtURx4dpu3ixZVGvMjAh3xad/ztC
 A2H7rWMPQdRBkfqwQvOZuFo1BDRNxrK7Jd1lwTfO2ADkBJAn1MsQ/EMdNprw9QDmEeXT
 Z2CgMWNE6YwLWZz7glCq7F2B4X4slT5rKQY7LdfdiG7ymVIY/RYcNuiO6BRyFKOeC/7o
 nyEmfpTkCcHOW6kryvW75w+w+BI9cKk9921SsGWG7PJN9VCmXTRpqAjtTNglkgw9BI34
 B7w4d8k/Gt5aL8h8+AbOvYEuoRJrjiS78r1Qj9qoEc//GV76dlecy3nIFEBK7j1hlnF9
 4T/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724150063; x=1724754863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0YqUTCUewhxqm9Vd9YujwXB2EaIHbrLOEvegFMLTQmw=;
 b=tcn57XMpBfGLkOD+GjcC3+ChxqBELL2dRk/LOcdvWQVXq2mtHi3a5dvT9Cevp6JJ/+
 xOODoYR+1NcsYu/r/nknS/Q/CmdgjjtMGhYRvbgj6OuJ+2irfc/CcnAsz1atxMbmSzcG
 xdDRg1XxnC7XRLAEk7NiOEnuuFy+ecKBNBHkxikq4XOb0vRhliVdAy0N7q1H95GJf0td
 DeP9xTkLSXx9qU84OQxZOSySZsZSvt+CuKtTRK+Hv586UzKEjlWdvwY68EJBTB1psfwE
 VxuTwE43PW7sPYxjUxpoHrcr81V17QJZKx0nmBc4lInjhRv+QykTaViss/L315lPnHBK
 Blfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/RNaRW0abXa1z5Hpx6QgWVpz+nllAwlzyQ2QaCIpGyuO8aeILtlmm9cwX1tz/aJmjRiRbqcPNPbIp@nongnu.org
X-Gm-Message-State: AOJu0Yz41lvbhzxnFvXmp6thRiOBp6UN8cyvb3ptug9JifNU5KCMFBsD
 AsGVXCZR9ZEtuoefZYWXy+Nn8ziazEuSVWyfqb5kuQYINa4vswYsrr4+vWYI/2o=
X-Google-Smtp-Source: AGHT+IHnoNZfGnyZ+dRCHKfo4IvJqiu0lKI1DuKpY+9AQtViyhibyQM+prJEX1G9id/lBzyroB4rmw==
X-Received: by 2002:a05:6402:35c4:b0:5be:ddd8:e3ea with SMTP id
 4fb4d7f45d1cf-5bf0ac38b08mr2739240a12.9.1724150062526; 
 Tue, 20 Aug 2024 03:34:22 -0700 (PDT)
Received: from [192.168.223.175] (84.21.205.77.rev.sfr.net. [77.205.21.84])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbde3eedsm6545947a12.22.2024.08.20.03.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 03:34:22 -0700 (PDT)
Message-ID: <55f5a246-b16f-4cd3-b503-b9b37e7f835d@linaro.org>
Date: Tue, 20 Aug 2024 12:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] *-user: Handle short reads in mmap_h_gt_g
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, imp@bsdimp.com
References: <20240820050848.165253-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240820050848.165253-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 20/8/24 07:08, Richard Henderson wrote:

> Richard Henderson (2):
>    linux-user: Handle short reads in mmap_h_gt_g
>    bsd-user: Handle short reads in mmap_h_gt_g

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




