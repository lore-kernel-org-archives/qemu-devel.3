Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C1CC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 21:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgA74-0000qF-Na; Fri, 01 Mar 2024 16:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgA72-0000pu-1s
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:08:12 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgA70-0004Cy-Mt
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:08:11 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e5a232fe80so1463819b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 13:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709327288; x=1709932088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TGz4UVDmEifkdLH9N4nbvPrzT6XDUxPriUpEC0rx4Q4=;
 b=Wv1hIg5r+dgD6unnbEnaf8+hSwU+iQ03uZVRbOCz9H23XSJ2fJV/RkcpjfqXIWZnAE
 tjrUypU4ZoDBlrakR8cCq7Fzfppatb9SiKWivVACs1LvyCG1ZaMKmL07uzk6ivS97wS/
 DEw7YzoYuZs1uC9R00JWkj+89W6w1q18bGPt4PpXHJTMb9S0z2OrpvwbKbHCzQeAyYYT
 w8Xaf9v6pkx31/UelrILBdLXUvuYpnbwKYdwXzeMKieKX8QtX2fXr+7Exa0398GAEBbh
 8BkMxCrw+ejUbaVe99tWXBRZTdaYYnt2sIhJXPVFIR4WDiESDl3I8Jlqw7o5JnRRo2go
 LHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709327288; x=1709932088;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TGz4UVDmEifkdLH9N4nbvPrzT6XDUxPriUpEC0rx4Q4=;
 b=Fv9w0LvxFKNkqAz19ZGHDICSisftxeyj1O1vdgAfDsWscYEBDoiN1zLFUI0clgilw/
 k4cVGcFyFSAAHJlJFn6Bbq5RdK1RHYmmxORSLeVqpHAJgzHeA2RbCkTwuE1DDwMH856Z
 y3Bh+jV5gAdXXMQdBQVCsi7izGJYOdcx3TOmDd6+nykYqMNL2yQqBuGgv0BVQj3WDfzh
 HqUWhPfb5mk01Qh8jGQrrVB9ab1zWrvqbytd41KHs+9d+9UGSIHVMtvynoO5jCbzia+l
 fKWDc3R4XLEXNq9e0+lchhOGBxBvN0DSt9i2V4oJVEezhZzgHWpyC4+iSWVaIs5+jIk+
 KE5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSZmaePL4q7A/pnPSB63yBfxgB78IpoGAHWlsT1hozVDv2cySy4ALFV0XXnqVe3mpJ9U2dCe3iW2x9E/t+abhqXAGotQw=
X-Gm-Message-State: AOJu0YzSQ8VIA8Fb9zDoRtKysHFTFKigkaxagqIlowJ4/L16ciwqKhDR
 jyYEP2wJeWYsvTWDzGJLS4K89KlMof71lDh/KAUQ1PUDMRgWS6I/hCAEcprndrY=
X-Google-Smtp-Source: AGHT+IGVG9m5JYefEr5eI6APdXzPvGeyJBaK7NFl78lMJLK68y7RYSmgseft5YLHPWZRGxIOevvFpQ==
X-Received: by 2002:a05:6a00:b46:b0:6e5:3434:d5e0 with SMTP id
 p6-20020a056a000b4600b006e53434d5e0mr4040467pfo.2.1709327288118; 
 Fri, 01 Mar 2024 13:08:08 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 d18-20020a056a00199200b006e56c8f572esm3496205pfl.141.2024.03.01.13.08.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 13:08:07 -0800 (PST)
Message-ID: <3f093460-91db-482e-8b58-3aa71f6d8e03@linaro.org>
Date: Fri, 1 Mar 2024 11:08:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] target/arm: Timer _EL02 registers UNDEF for E2H == 0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240301183219.2424889-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 3/1/24 08:32, Peter Maydell wrote:
> The timer _EL02 registers should UNDEF for invalid accesses from EL2
> or EL3 when HCR_EL2.E2H == 0, not take a cp access trap.  We were
> delivering the exception to EL2 with the wrong syndrome.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

