Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A8EFF60F7
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7VVD-0001A2-7A; Tue, 31 Mar 2026 05:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7VVA-00018K-VY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:35:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7VV9-0005eF-Gp
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:35:12 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so1585816f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774949710; x=1775554510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zZH9zxK23L1V71U/YBeaOMcuHE4W6JFpn5NY+B6XO2g=;
 b=DrmJskpA7b+fiUY28paeJeLTLewelHQ2pYWxPu3Sa212y/lxqP9XANhlaakiQlhTPk
 CZA9rftIMwfoCvXHQYwbCWkrUS70tksa8zR3f2OVCYzXhHY9AdCwDaDpGCdttdmJuv/o
 Oif900Xd5wHGmh1Fuq38bByOWYJF8QFX7ro7cFOuZKzzBCF6JXcZtFiILdq0ohLXvzUw
 Vn4CIUpoZIKHmlrjx3L3KY8PIN/V7grFSTEs1sWTmCLJHx2okvjczCjzMJZZrwEJIozc
 SyxRnIISzfpjqEO7OEUS9hXp4u6ivLkx+FQbo8OOUthQ1x7meF/c/JjQf9C5z/eQ9Z98
 VwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774949710; x=1775554510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zZH9zxK23L1V71U/YBeaOMcuHE4W6JFpn5NY+B6XO2g=;
 b=PHznlLrLyCuNRpYGSzEDX+QhjYeUGbXNFTmNCQ6NAzwANMsqiRE3+5A8vP3GSOqlhU
 Ltgcz/JE7+ft9lIPQDbWV7XJbidRNUpUKMv8oaLjQNQVjpBxvTe32EknOJAX9fGQa4F0
 BR8Ta3XarvDo5FVmX3M7jvL7zypbmasHR4WqzgammA1ydrIC0h5jtDhOzJauuY8zfQbF
 /sQPwVUrLiS6vI4vKRS6vIBqJ0tsg6Uj7SANtdVrkB6ULPho/ngt6MJuIjV+6ZVwOwxZ
 H5AH09LhIM1hT2I/p3tevhbqzuR7+x/1H20dJcwfJcCxoqPL68X5xqJAbJrprJ+yxHKu
 IKHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo8kHCuuZP5tQ47IjbWZwSnKz1uZYi8cl36H6qw8lsOJG/iEQP8sS37AM/0jn8f3afqMliM0aPWsjB@nongnu.org
X-Gm-Message-State: AOJu0YxSxgeMtx4DUDltr1v5VuJa9aZxkG+8w5Z4pgOXOobN0a7A3SyN
 0c2hafr6lpWSv3sw5puqzxZ8Y440bIdwxuwBv+qwvjmg/DmtTP7ixmdloWO0+gIFs078sxdEQAI
 YX85vFlE=
X-Gm-Gg: ATEYQzwkfwmXVdCONZN6FeobAhv3NTh6x/BeQ80Jq8ZhNqNm7k8IYa6Gf7/289phMyB
 ma1fvTdiQDlmIc7XfnLWiAmdfgKcrk9AfTAi/UIMaPCqkIfEOp3F10C0eVyRqMP8ejKEITxUBza
 NiFGwVZOC0WFRlzb7sljfoVasi9r5br3m/SsGaD6R6F9wpNJgd14ljaXtdtCF9H/xUoBwCO/7tz
 lATGZwqsSgxxtRm+YXxuXmCY9UusUVRMEJRbBc922qLRvSQBKssKahRw/YRdGc+rEokNvSUt1+9
 lW4qKWpi2Z77UWE+GLDPLYsbg+goQ+aX8YL6LoItDLoOcb5S9cSGgmQ9UMzZmiz0zrFcGJu2UZN
 tsfgdQyoo7m4U/s9Pf+hLJ1Vj2IH8/LfsTfm3bElKnqzSF4TNdyXpWHFymqZsNdlyL5EjHHwJpf
 VuA262g5bccqaGVXOKoU7DZ8iYIJ8ad2TkJLaCjL4W0QT1XQ1/Dg0djtKjWg==
X-Received: by 2002:a05:6000:2583:b0:43d:b0f:eb44 with SMTP id
 ffacd0b85a97d-43d0b0fef70mr3450287f8f.15.1774949709915; 
 Tue, 31 Mar 2026 02:35:09 -0700 (PDT)
Received: from [10.193.39.66] (43.149.216.82.rev.sfr.net. [82.216.149.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf24707f2sm27103968f8f.26.2026.03.31.02.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 02:35:09 -0700 (PDT)
Message-ID: <60cb50d1-aa42-431e-b3e4-76a2cf4f437a@linaro.org>
Date: Tue, 31 Mar 2026 11:35:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] hw/pci-host/astro: Update copyright and
 documentation link
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>
References: <20260330211859.19317-1-deller@kernel.org>
 <20260330211859.19317-2-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330211859.19317-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 30/3/26 23:18, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Update the link to the documentation, which was still pointing to the
> Wiki page. In the meantime the PA-RISC wiki was converted to a
> read-the-docs website.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/pci-host/astro.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

