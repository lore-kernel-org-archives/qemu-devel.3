Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B75C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqgr-0005JB-SU; Tue, 28 Jan 2025 13:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqgW-00055d-VR
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:51:50 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqgV-0000AX-G0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:51:40 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee51f8c47dso8451082a91.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738090297; x=1738695097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UCAXlB0zAtZfC9l8cKOWbthazlIyGF/TXymTGJpOxxk=;
 b=n8clZEuWJWwwXlCK5O03zch9B4fcD9vssqMQbsvH2GX7vA8YwNEXUbHtF0AHj2g5TA
 OB7XtYav84JizavgTR1PjU/racu2Nj4TAv19O+caNJav+bGSfhXcgWmL3+vhwjmoFq1O
 eUMyo7jLvXG6efmgEckOMrRNlFD2o2k/h7FHF9iNk6uSQjHCoI6gEdBP6CrBIIqNmCrc
 Vpk7He2bcHmT679REt/CS6UGegoVfoy2CHe8OHS2LojqJJp0Li4M2CzznxgjKXuyK2eE
 L/EXbPLfqRdrP+SiV6NHaiSTIebpYDGK7i/FbRTgQRVqi/1PAGABQAMieUQFJaxzpJUq
 FEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738090297; x=1738695097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UCAXlB0zAtZfC9l8cKOWbthazlIyGF/TXymTGJpOxxk=;
 b=A1dwdi9/GaiMV6luKvEnh944CZgjFkykWwqNFVe+qcy/oBTrCDwiQCQQU2UgN2mIjw
 3DIF7RMR2cvPVxj7iaUjPRBOxhobUn3Ad2sEnul8CsmjUAn8OR1dhUugHsT4FtEAaTzq
 aqHRZ0XuMVvljN4qiMxw5/OrVjDU+JZ+nA/J2q8ACCarj5iWZuq+UHb2QIUFMCaqqaTi
 mWKs+EtjVzn7IUoRLlo4TFsv8mDVOOOClmA1KXJN9TIv2cxShg4Qi4HzyxmbSEKMs79h
 86cpsfgMi5q2baviB33LxtNakzwgmpLy7tzErkUjNRRlbLW75fpWU+QHi3wu+rEzsNWo
 I2QQ==
X-Gm-Message-State: AOJu0Yyx4dGmVmfJH755tWX0Y4SDjCX4Xmnc64N12oonDslrM+OtvBRp
 pPnUf77sRuikdTVn4hWgTqZspyoaa1gCmk5iOIdjJcKP1vtVDebkxSYzLBrIvJqfYopI0QrpR3s
 1
X-Gm-Gg: ASbGncvVX8uJd1aGCB9mSjJpXcA4lQS7e6/zr5OIGVDAiXKitWwlffl5yFLWBqfBlE/
 J21Y224+p3sIcLO2wSh8yopvq1tHvPcoIEgNktYzS/p2rPMTDJ6zy2n2Fs8aqrjM+g2NbK4iwF3
 TLKW2e6/K7yANLAEW4NKQoQj4rzYMY8Tb7pkfp3t0oxo3gaXIr3mIZ6j2yHaXMgDXbto7mnPuKn
 1Autkkad+YikFIHRtxMKAsqWwlFmJg87PjRKvES+3j7SHRy/gvUYX+b78YntrVl2f7Zcg64zkXz
 iFit+RRwt1GhtelY5iJtIHEL3jlctbmADM43iGolnnCKPKDgsedAbZfEcQ==
X-Google-Smtp-Source: AGHT+IFxnasCyKGdvYujMxOothH3k4vc6y64GWmhm2sqQPMTYIeYVErrWz1HHlMMkO/qHpnWDu3S1g==
X-Received: by 2002:a17:90b:258b:b0:2ee:fd53:2b17 with SMTP id
 98e67ed59e1d1-2f83ac836d0mr71610a91.29.1738090297237; 
 Tue, 28 Jan 2025 10:51:37 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa55ed7sm9680000a91.13.2025.01.28.10.51.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:51:36 -0800 (PST)
Message-ID: <c078eb47-6ce4-403e-9378-e1b53570bdcc@linaro.org>
Date: Tue, 28 Jan 2025 10:51:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] hw/sd/omap_mmc: Convert remaining 'struct
 omap_mmc_s' uses to OMAPMMCState
To: qemu-devel@nongnu.org
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128104519.3981448-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 1/28/25 02:45, Peter Maydell wrote:
> Mechanically convert the remaining uses of 'struct omap_mmc_s' to
> 'OMAPMMCState'.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |  2 +-
>   hw/sd/omap_mmc.c      | 20 ++++++++++----------
>   2 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

