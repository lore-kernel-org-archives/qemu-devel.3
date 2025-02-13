Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376B7C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 15:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibRM-0004Jj-Bw; Thu, 13 Feb 2025 10:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tibRE-0004Iz-Mk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:47:41 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tibRD-0003I1-5C
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:47:40 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dd011ff8bso809041f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 07:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739461657; x=1740066457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o3cBWVRDqQuqhljAlXbDb5YU3H2Azsad4KQReWnuDjc=;
 b=jTnpq8imvRv03BUus4CpCxIt3T4N0sT4CMBUnZ9ELio/o7ZgayQk5zF01iNzcVdDOX
 qNs2HTqT0XZFh6T28hNjuvwROUHX2klK4b5H+4ikb9tHVC+8CCvoEoM+uT+SpzdV1zIY
 bU1rtROezpRZnKsa1EJRamiEjNwuGMF9whphzQexJP2yucbqW25Ye0yECEdehr2qu4mN
 F+8osIHsY65whkX4ZlVYYcba+GXfr+g3BVjUPMUXsgo0+aKpQ9IUXd/Cu+858YVNnB2d
 8uefc8jkDxol029xyQUP6YW/3PRU2j4xMYVG5KwHDTB8ePLmX0naBxNo4iMfno+5Zosj
 oFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739461657; x=1740066457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o3cBWVRDqQuqhljAlXbDb5YU3H2Azsad4KQReWnuDjc=;
 b=cOwDFH6Mj4NYnjGhfkXjTrbgwFTNjLRfx9192sPAzoPrztH3c+rmEcsjW4N5skWocy
 7OHh+AtPO79Hj65fGTRf6rXsTPCMk6JHO88dVI21krzO61y2TbpRFxTaPQXVIRmNNhnR
 0xLkGedhZzUfgBgkY7s9uA3G9Tu5JAYvvhKuK7Ra/2PwrtDBJPacjdn1RFsMkz8DbbIF
 DnqXLLRnzLbXXeufFVExsR3WAaYdDJlpQibULeOVR67rOI/g03E/qUtIuIX7RxovyuCW
 5MxR1rzxn5frphxICyTnPkRUxNtqzOtOmxdDa3IAw7oyOkATtAD+Bjp2hTVb+OC6DpOX
 CxKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB4c258+HsDTfcfNV+iVlUhfttmEscdM8xlJ0iBVvQMbuCfhCgdb0LpA6+L6Xi/1kjHey7DFeKLCDj@nongnu.org
X-Gm-Message-State: AOJu0Yyt24monIa7NXTaynpeORMKoy/EhKxklNTyHY6lUmWCoPYDuiC2
 N99CzmBF7dSI09PtOKDUGAMppwmMo4udQCeaP72LzNyHnCWh6q6Z3YB/E343s9lOFDX/zSg/4tO
 OFyU=
X-Gm-Gg: ASbGnctzgrZAS34PtNrSXkuFl1S9KKGwbqX6iuivrLMjyBRnmru3B4RlC+jlHHYcUsN
 HjmozB6y5QIt3/YDMoZ6xO3XTwKFGGVPP19NwgJUafh/gEHfcPQWlT8Eivt0vGPD5fnPDd14DFO
 Tflsr1vLd1X0pKAPbXR6x4Std9OdwgFavuNyIVafdcj24Xv7KAs/uLrv5UhYwr6gwefb540mFXc
 as42Rz6tObYpu5SVeF1ff7aEQ1idbEA7HDS2YEu563HruMV7INmtQu0fhdIYpZVpbUhx+hYXIA9
 uU67mWZa6bvrW/qlqNB+4EmxM5njKw+lwl3G3u52tOEXh6qfvafuOZ+44bdrT8Kq9JRw4IykKQ=
 =
X-Google-Smtp-Source: AGHT+IEUF3oTlmX+VN4F8LvqZvdI4NFqFJAJRREDzdGgHpd8rDSS7iXf5oXs0eCDMmCtjupdeshqGg==
X-Received: by 2002:a05:6000:4027:b0:38d:e15e:17e1 with SMTP id
 ffacd0b85a97d-38dea258b69mr8004982f8f.10.1739461657100; 
 Thu, 13 Feb 2025 07:47:37 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259fe1efsm2230059f8f.97.2025.02.13.07.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 07:47:36 -0800 (PST)
Message-ID: <6fd859e3-459f-4413-aff1-aca60831cb49@linaro.org>
Date: Thu, 13 Feb 2025 16:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] tcg/loongarch64: Use 'z' constraint
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
 <20250212034617.1079324-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212034617.1079324-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 12/2/25 04:46, Richard Henderson wrote:
> Replace target-specific 'Z' with generic 'z'.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target-con-set.h | 15 ++++++-------
>   tcg/loongarch64/tcg-target-con-str.h |  1 -
>   tcg/loongarch64/tcg-target.c.inc     | 32 ++++++++++++----------------
>   3 files changed, 21 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


