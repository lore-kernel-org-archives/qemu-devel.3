Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32128C83010
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 09:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjbFe-0001u3-GS; Thu, 29 Aug 2024 05:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjbFc-0001tZ-IZ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:15:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjbFa-0003qw-Sh
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:15:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2020ac89cabso4226155ad.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724922929; x=1725527729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mbhrDfHokLZpWXOaeHBRFzapBWJSS9HKHYnPCRTrK44=;
 b=PfjZPHn5ktJ2BTEJDvX0z1WEUX8Ys9uAzpBHVip9+3UIT1tHf2e7B0mU88y/sCuC+u
 i371khWNs2sm4rlcQZiY9IlzVuye2H+bFMxayzBfJpkS0JkyPgxUJf2GwqS/iveFZObu
 A4auUtclLEms/L9NiAly6ozlrl43S4tcsTJO95mLxbnIng3krpSzbhn5ayJxCHlQylzk
 bEL0TXx+kZ43F4ztwgJMZIW1aL5CTGKUs3/9UIvUn0qzO/PFM/YwTmMXBiA2ySm0eb3D
 Vvl27Ja5cBpqTW2Gvy9B7DUDTW8Ul0+/P7Km/g51qA6AYPksIqfPDJx+2qqDMNyba07O
 j21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724922929; x=1725527729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mbhrDfHokLZpWXOaeHBRFzapBWJSS9HKHYnPCRTrK44=;
 b=oF9TEVrblnI3F3aIih5xE9uSy+na8smlbFwdIVhmwXBXek+prfG1FwORuzppC5PYcy
 E6ZJmpepUkb7EFl7dbE4Cx/aFKjEykKAsVf2IMJ9t62lxHEkL0lBriyPx9E1t16DrmIq
 pnyBBTSfm4WDXJKWDQblwvrr3Hdr/zZJ+2mg+Ld7gdCau0IPZ3I5jgg8yBFw9iP2THD3
 kNjUfZEeJ8a6ffZdq8qd1o21bAP5MQCdxFvrcRyh6i6LqdfsdJz86+eMH1HzSXXmzMYm
 lRmJLR87sX54NUMLPd5ssDaAQUtNnSY/tMFFa+5Ktdkp8pn3U3aIf6LW8bBzBMw5H+On
 OIlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP9/5DEm1cIlx4iRpHf/IBZ5624/++9dvkzyD6Pi14f72WWshPGlK92LCNuU9Aha1q8huyizwzYWT5@nongnu.org
X-Gm-Message-State: AOJu0YwN2o++25j8iyY2AlPNIBl3wC2xD2XtOEPtS5xQPyKh4M7rwpw3
 2v7OHIizUWXcZs+RvlOCj+zO7Gn7QZbFqmFUq6jsDtTcICqBMU0XVpgYn3GKRVM=
X-Google-Smtp-Source: AGHT+IG4RoHYlpKKvh3IeRPlZoG/lbNkYI7IfRe3ozNKN+wW2cIAY6MRYSsRmbJgToJGfrNfM4V3RQ==
X-Received: by 2002:a17:902:dac3:b0:202:4042:8520 with SMTP id
 d9443c01a7336-2050c3a50f7mr23727635ad.37.1724922928900; 
 Thu, 29 Aug 2024 02:15:28 -0700 (PDT)
Received: from ?IPV6:2001:8004:2738:227a:3acd:cb9c:3ac7:770b?
 ([2001:8004:2738:227a:3acd:cb9c:3ac7:770b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-205152b11cfsm7430875ad.1.2024.08.29.02.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 02:15:27 -0700 (PDT)
Message-ID: <af78346b-a825-40f8-b7b5-df7f392cd2c8@linaro.org>
Date: Thu, 29 Aug 2024 19:15:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] linux-user/syscall.c remove explicit mentions of LFS
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20240829075242.511534-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240829075242.511534-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 8/29/24 17:52, Michael Tokarev wrote:
> Michael Tokarev (2):
>    linux-user/syscall.c: drop 64 suffix from flock64 &Co
>    linux-user/syscall.c: eliminate other explicit LFS usages

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

