Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79519C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 17:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT36B-0005gX-OP; Thu, 25 Jan 2024 12:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT35m-0005TY-Ec
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:00:43 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT35j-0002bM-Ko
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:00:42 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e775695c6so67979485e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 09:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706202037; x=1706806837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4vKsLrcUBoXAb4uirZO/u3GS419YLSqlkq2P8mLu+PA=;
 b=CBxu+vB2Ih4haYqCPLjnoPpA+VC3VHIT8YzXHvYYvPAu/Zd4ZOq/gN+XyrVgCfLUaO
 vRAkRDuzhy49KnmVMuhAOnTUXAeYoebplaR96eB0oUC+2hHlH2+pvOZ4OPXHf20WHEO7
 ecKt8eNvQE+Q0xSjeXUDiL157ocBfPcJFElgJynhtntkd5v2EoJ9UEkIrENyBG5XE7lT
 PPqRBPqSRsHTkMQbdlqCNyNljssJkAn3/3OqpL6qlX0RWlB7iWMuoGYtE5KkTAln/Lxv
 21fkGsAJMUMRHwoFmqzIH1bCdRs3gupek4HvzkkRzhfoE+3YnBXQtU4WrOkiMdFWAFeT
 6NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706202037; x=1706806837;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4vKsLrcUBoXAb4uirZO/u3GS419YLSqlkq2P8mLu+PA=;
 b=pM6g2zDMJJ0lAkW/wntODkFKBUJjHFCfRIVY1K7Aop1iRyDvT42q3aSRW0sQ8Wealj
 ktFlGrrOYnVyXE/kto2u10yUINjkvJZOCoiD3eABz5yxoCsPCkfTTIM6Vew26TK20cv9
 nLQlfW/tQT4km0fsmWXNhvxobbD11F844iigKS0QcSkEADYp6exBoMNw1dSvKmUDrGUS
 MWJ/7k9XZZIe+asLqXJN5f0Mwo6ifoeYetFJMIKSteOQMeBk37v2WDP3awumo2o2+Xxu
 IKlr8MBy4sZdH4EMc6iYeAH3eel69/Ao/ez7hd8EhQvzjJtjuh5btDeugjpmAWpY2BZU
 gLXQ==
X-Gm-Message-State: AOJu0YxroAZbtBFz6oF6RtvQQq2oUpHHZeoC/Sxxfig5xo+JjlX/vPxj
 Ay6ZQJWro6We+vZQrJZI3eE2dTC+9c7NL2i1ADbmlrp0SSiB1lX7ZiG1XxQlGBM=
X-Google-Smtp-Source: AGHT+IGAXdMNfXpKhDjFXN2Q2Gox5eOQ9X9YrmLKTtvUoaQe6Vx3UUQyE6IyzqQ0Dc2neMNJxA0Ljw==
X-Received: by 2002:a5d:4101:0:b0:339:171f:aae5 with SMTP id
 l1-20020a5d4101000000b00339171faae5mr1010857wrp.120.1706202037288; 
 Thu, 25 Jan 2024 09:00:37 -0800 (PST)
Received: from [192.168.69.100] (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 l8-20020a5d5608000000b003392bcd6c48sm12913879wrv.79.2024.01.25.09.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 09:00:37 -0800 (PST)
Message-ID: <33a0191d-9e92-4cfe-8f08-2823354c5cda@linaro.org>
Date: Thu, 25 Jan 2024 18:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] cxl: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240125163408.1595135-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 25/1/24 17:34, Peter Maydell wrote:
> This commit was created with scripts/clean-includes.
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/cxl/cxl-events.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


