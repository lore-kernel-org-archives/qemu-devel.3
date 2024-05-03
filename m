Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A346C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2xdF-0005AF-G0; Fri, 03 May 2024 14:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xdD-00059x-Jq
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:27:39 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xdB-0002vb-QX
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:27:39 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-572adaa172cso2821084a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 11:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714760856; x=1715365656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CGEK1F/+mtRXRolzkSTZrt75Cw/aGqSrGEIwsZDVegg=;
 b=RxAxxsC+DlevQIbXJZI33WdC8cwLXNDdfkQ4C5aaZy1wE5tiVuImuAm4Ia7H1ImI6D
 BncPur4gEyy8O8FQM6HZMJsdalEMoNF8/N3axAkpODxGzOYKMnvYF7jzdk4hT4l+xwIo
 0YPLrRue7DuCvmPQbC77QbEvc+bqFY1L4mPfoPB2G4Z94whDkpadZcPKFaGGyOzk5HUc
 4V6jJP262dXZ5pu2QHNZGsULhjVuAINsjVOKzpXW5eCO4DS8Mter5pZuV2gfNHdRNx71
 +UUaGvpcZSJYiVJKp9vJP0KCXDkGb3SioMr1/Ur8Ih4Hx/uR1YD6CdSqPFKTG0Nl0u2P
 xSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714760856; x=1715365656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CGEK1F/+mtRXRolzkSTZrt75Cw/aGqSrGEIwsZDVegg=;
 b=Je2tbTVKxTOyOYOg+E1zivdL+/KwfO74uuc1qNd8WBhnEPE85iDptCycn2bntCjZSw
 +1nBydAKsWMgkyRCJ5VKVdQ8IQ+9ltRpEUZtbUi7x2fMdyEBtns3I98YymaaCFUAuVpT
 3+ZCD1ML/Zk3fMp/Xc1Rli1Xy8wqe7du4e2FeXwI5pKaxxmFbKQkzLnll32FjIdlrpa1
 jQ7T6iB2nXIDiRM3UH5zOWA1HPEW4ahuqi0fIz0dnLJFUS+8OIaBq1o6KZgUFhx1/MD2
 3KsKas44VvXpjCfC2Uvhw4KiDzNgrx8zzyhxUo5zZtpcX1UAMZ+m/qKJNwgKvRArBeiY
 byJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjzt2dPMhg9GTZq59758NQE4CRBacrvBJPRUMpXKf/UfC7SzbpfTwKUzK8N2yxaEh3/BrO8jnBCatCPr7cNO9A8WC9nH4=
X-Gm-Message-State: AOJu0YxAfEhdCyqo244C+eO1wwdQLZbmLDg96Ztwi18MM1Ia8fm0/AE2
 d55Ig9PS0oeDLJAF2av5sY0FWgW052/EQ2/UdUdC+nym63e8rHd5sVRHKNK1Oww=
X-Google-Smtp-Source: AGHT+IFjUCwBQzI0eM5HidszasjcG0iZ13cQMPvMyFRFz1rbVzrhwQ6e6UmoH5gec2+JqOdrnckZ7Q==
X-Received: by 2002:a50:9fe7:0:b0:570:5e98:64b7 with SMTP id
 c94-20020a509fe7000000b005705e9864b7mr3009501edf.17.1714760855877; 
 Fri, 03 May 2024 11:27:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 cq27-20020a056402221b00b005727eb1ed6asm1938018edb.68.2024.05.03.11.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 11:27:35 -0700 (PDT)
Message-ID: <b8d61172-a881-4a53-b649-39bff421f757@linaro.org>
Date: Fri, 3 May 2024 20:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] target/sparc: Fix FPMERGE
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240502165528.244004-1-richard.henderson@linaro.org>
 <20240502165528.244004-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502165528.244004-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 2/5/24 18:55, Richard Henderson wrote:
> This instruction has f32 inputs, which changes the decode
> of the register numbers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  2 +-
>   target/sparc/translate.c  |  2 +-
>   target/sparc/vis_helper.c | 27 ++++++++++++++-------------
>   3 files changed, 16 insertions(+), 15 deletions(-)

Looking at the manual, this call for a gvec implementation.
But then I realized this is v2 and v1 already has it :P

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


