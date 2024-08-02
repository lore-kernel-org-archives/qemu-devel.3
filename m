Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D15C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 09:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZovQ-0007DE-1l; Fri, 02 Aug 2024 05:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZovN-00075L-LE
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 05:50:14 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZovM-0001WI-4R
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 05:50:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fc5549788eso63654135ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722592211; x=1723197011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iL8zIXOgW+JeIC4273pCkQw1ENrYCzK7uuoMXuKFmLA=;
 b=DRkdSo+ZAveQ1o+ZLErpXNs/SDZD5zvB4VRFZdRaT/Rgn/qEPL2+6T+GsuvFyHzxvB
 z3aBXLHEWQ4Ibkzvk3L/6SDjzJKt76+2xDmdoaD2f67dFEyXQrTpVF5EXpYe2Lh4Qt1y
 5XB+2o2Qt4f+sD6qM6j0pIa1wwfWvned8WGeTG3qnKXAD5OHH2TGwPIIk5sdXx8cxKGT
 5/unQLKFY9v0MkjGMIGOfNHQ89KcxuLiHJpnaxTRnefFHfKCNwTCu+f7It0aNwpgBm15
 V9HYZeR/46QPnQI0ghR5e5W6kTuPcnpMEasyaGbl4NKs4e+2Sj+RwyJnCwwDAYwbcs2h
 AbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722592211; x=1723197011;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iL8zIXOgW+JeIC4273pCkQw1ENrYCzK7uuoMXuKFmLA=;
 b=Ciyffd70ZIwyULOYJNXi71JGVsmX7KqFWSd0kDkOBpm0p9aGXgR42IZdHhzesUhIJ5
 wDgXToe6nsGNb9EpYfTlyLbSZLVohatLtz99ZHLP3uvauS7PJQni0ktSI8rBOkr3p0HX
 T++BRJglGJqsOBQDj4dMIHpPNnRWSxHNBQ0AawTb6ee4CQCEFu7QZAXXpuV7yWJ6xgmt
 Lvk/Jt/HWb3OwNUjzu3sMMO71X7SRW2dn5Pn2w+8apjmXT/Btjt/4ZkNmzWLYixKTvFp
 1Xivv+Mif4kaF+eS7FuM709phWr/kzXDH6kqIXu8mSWEmUNMCxGTsxi5R5JlMV6Kx+87
 0Xlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlppPZ8ymAoCddo4Vb+kmzvH4PhH4FMuLGrEsHvkdnjElrZOwc4kZLdib5iltGiHZlgBaLaE5QLD8m1KZE1Y71waCyNb8=
X-Gm-Message-State: AOJu0YxXHQ3iMzntql2coDjz12DK3FTfxt3JN/iz2Se7sVc7JqiVzMIb
 RpSZwTjnCaZQfYXoPPKDvDRmEYop9VGOSsmelOoxn+hojR2GxtcR6NRzna48aqr9S+PBEls4hKl
 Pwqg85w==
X-Google-Smtp-Source: AGHT+IFkz1K+asSWPBEDXz/dhX2JtciaIegI6JNvPl15cM4HRmcLvctd3TtAKbP0IcxZc24HBlw1zg==
X-Received: by 2002:a05:6a21:789c:b0:1c4:a67d:3b24 with SMTP id
 adf61e73a8af0-1c6995cbc34mr4213753637.25.1722592210507; 
 Fri, 02 Aug 2024 02:50:10 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905c86esm13112625ad.168.2024.08.02.02.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 02:50:09 -0700 (PDT)
Message-ID: <403570be-bbea-4165-b0c4-b7c5dfdf1a80@linaro.org>
Date: Fri, 2 Aug 2024 19:50:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: arm: Fix hvf_sysreg_read_cp() call
To: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240802-hvf-v1-1-e2c0292037e5@daynix.com>
 <CAFEAcA_-bfGnQRc6cjp8Ej3WKTJGkKfELzv5j3Zc-2vyNHm9ng@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_-bfGnQRc6cjp8Ej3WKTJGkKfELzv5j3Zc-2vyNHm9ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/2/24 18:44, Peter Maydell wrote:
> On Fri, 2 Aug 2024 at 09:37, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Commit 05b8d7249109 ("hvf: arm: Do not advance PC when raising an
>> exception") changed val from uint64_t to a pointer to uint64_t in
>> hvf_sysreg_read(), but didn't change its hvf_sysreg_read_cp() call.
>>
>> Fixes: 05b8d7249109 ("hvf: arm: Do not advance PC when raising an exception")
>> Reported-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Richard: I'm not going to be back at work til next Thursday:
> feel free to grab this and apply directly to fix the cirrus
> build.

Will do, thanks for the heads up.


r~

