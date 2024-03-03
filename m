Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACBDC5478C
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 02:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgbbc-0007NV-F4; Sat, 02 Mar 2024 21:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbba-0007NL-RW
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:29:34 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbbZ-0006LK-GC
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:29:34 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dccb2edc6dso29292665ad.3
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 18:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709432972; x=1710037772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FxXqwjJtpbmnAV/IFT7GVgo4sivrc6BBKEiD1P5vliQ=;
 b=UjW7NY1CcJrN9sIgdJ8XBf8AKSNtVMo9I/clRKq+YxCi3ckKShjqwK/R8xxyXuitA3
 iGKX0jBL/i5pjRaYvG3e2LwomMl15GbZ07WB/ou/3jC+a7Chr4Y2HWdZQkmArd9CWrPM
 NXmVub/bUJesWYXQFsCpcCpGCdUfwcdOEz/adBdywdCTUqTamqODazMaTnlzPq0qu6YF
 nWU21jc+UTyH+zTvaG07r7zYWAVSNsIb+Xef2/RrjrkH4kdPMOiV11qiOPvXBtGdVgWo
 jD/u4ERL/7JsQkCi8ap/Yh44dPgGvYs24hrepH2KbkAE9CsedkRQ3rAY1FFQju63uKSO
 GhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709432972; x=1710037772;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FxXqwjJtpbmnAV/IFT7GVgo4sivrc6BBKEiD1P5vliQ=;
 b=GrslZETakhurf30yBAn4P4Ii+knkDiZXzm+glY6mUNxOqgsPCZ1bIlRu/Tl3gml/V9
 Bbby6j6h80Lt5mEt9+AwvCrJiiS6fuHVQy5tsRjthN38QkJiwyiRBQvGiv5zn7qCGj+O
 mX1VYGh2tcS68Bbq5Nla+l/QNawLFd56V/M17zbbbghqNtckSNUuxI5wb/QyFdpM783l
 yMDD0p1e0QT7Ke37vbsXv+zb5CRaRy2aEcHzIYIPlq9sw06CEJVPQOcJh4uUdWo97TsD
 OnGscI0Z7380z/O0CMDpjl2VNf2sm58OjM1CFEYLjvb/4Hdgu/8LK5uTzoS4Z2vnSPXh
 fXSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8G7kasg/8lFenLIPtcUkIZ+elS6eg7t7ELO1qJYBH31eEcwiy2TiVU2A6BCrq5gsIt+/EnB2Nemd6lkK4waJEL/1HQ8U=
X-Gm-Message-State: AOJu0Yw8h24mrmAPjPcLY4awsrv6Jel+9pTETnv6ghorEJSdcUnNuqFy
 muBCWDd4MUSTXPg1CzObZnRe3TYhKd/Fx77BNRFs+x/SB5ZOuSlFgas+EsgpQn6weZC2oofazDZ
 V
X-Google-Smtp-Source: AGHT+IGvQsUD7OtXpR+2NuhFh7Dye3oGyNyWSXSMUh1uzekjmOVqGO8JnG2lWdxhNBoKv5USJczcAQ==
X-Received: by 2002:a17:903:1208:b0:1d8:f129:a0bc with SMTP id
 l8-20020a170903120800b001d8f129a0bcmr6227318plh.13.1709432972137; 
 Sat, 02 Mar 2024 18:29:32 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 p6-20020a170902b08600b001dc30f13e6asm5827636plr.137.2024.03.02.18.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Mar 2024 18:29:31 -0800 (PST)
Message-ID: <6d93f2d8-4262-4a38-ab6f-5aa312934406@linaro.org>
Date: Sat, 2 Mar 2024 16:29:30 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] pc-bios/README: Add information about hppa-firmware
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240302223524.24421-1-deller@kernel.org>
 <20240302223524.24421-5-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240302223524.24421-5-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/2/24 12:35, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   pc-bios/README | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

