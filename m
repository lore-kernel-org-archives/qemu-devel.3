Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03978FEA839
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 09:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Kwy-0001oF-Rr; Wed, 25 Mar 2026 05:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Kwx-0001nj-BV
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 05:54:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Kwv-00068a-UX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 05:54:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso3326005f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 02:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774432492; x=1775037292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HM1F/rvL+8KHdfyd6SSP7D/TKs/zH3ofyYeFYdVTmlc=;
 b=k0oe7g4FE5mMCutMfdK1JT25W2VqX8Ty1NS5UycRlo45HjCh/LEpqOQxUX9Cwbe/HB
 C80GC6V2axnNmX0AR48I55+hUxssYCf95QbBAtVTACqqkYhHpCFkASa45j4Tp3efufSG
 BD2AF4hZb2ngKb+lXJnsB0bOsCoXPjWKNogJB/ByBiYzgYbOT86wFjwKNTswe++Zvi50
 vQz22zhibfd8tV9bmKGLoIVGmYyt6JByx0rP+PdZmC8UzwdgQzlAIMr4crVgZVeZqoks
 KoIN9QmbF6hYJZH0VVQESm8DR0AAsqnz2KEFuSditC343Y3sht3tV8MBIRBryIpgZiFF
 CGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774432492; x=1775037292;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HM1F/rvL+8KHdfyd6SSP7D/TKs/zH3ofyYeFYdVTmlc=;
 b=mNsqXRoSl/q68iO248Or2Y97DV6XWbjqTXJtigSjVSRlFxiNYjsVzYWyB5dhDYYGCh
 Cr3VpSER0tZef73ieZbnYLM0L633mfzVez2cFEIqXK53zWh132Yt2IbwCSQlyn/rBLSt
 dWiLinXrp7R9XkyoErWuQSXqczfLyrNYcdsM9IpLcv0dcuAsmdBWVL/v0C5Elvk8ryya
 Skoz9UXXC7V6e3nPMOx0HZetkDtu3qQv/SGZTmYdQUjBEOLzWfHNyD2Ir7yYAHC8roNW
 1L6hIYASvGOnRNdi0J5M0dD1pCdHZr1/UjJaGAHO9XHH+gUEkai4B/sQWxU+/qkp/haB
 K+JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv9SmT7/akvAvGlvrGo4UkBa674SQMIfyDMuZSpi1whzOGr6aVy3jvtNDC0awJ+kugzmZj5s6MxGNs@nongnu.org
X-Gm-Message-State: AOJu0YyfM2ILEV8iZKZaErK/5r0cpVAd41KAv41wsPo5rAtu8Jl11tvG
 ZUqaSy8vPRxe7I+VP0fZd2G4WdBYB1UPJeX4x02Q6h0pBGWmyf2DRwvUG3xnSezbU5k=
X-Gm-Gg: ATEYQzzpFEx8KmYL64nx0ytLjNP8Ao94iOL+vKtYRZPZW8tN/gMfHOlCIFioQqZlnPM
 SLBCzrFolBhzoVfCownRCopPtAaOjGoMiYHpyRvW+TSZ3730bH1x97tGYQJG1NE1w9OPYGTL/DQ
 jQHIoDmvNTfry0hrj472C5rve+F8l4ozm6x5A+oI6nTpn3Sq7kjbPh8R4KEl9xe2XZP03CGBY2N
 MMWKXoqbmYwVL9qk7MsUJ9I6N/AhNBhvI4Htix9pQ/tWWHzRKdC4/Tq0mmwsOQkYgwbWTrgujo5
 dMxOi6SL7syy65RXbD7k9RulI69AmXnwg0ohQG6KYurqNcOjvcPL50kFxO/ceszHfZwy4oxUqtD
 4Lfa6Y9Ay9lT73eajNpV7069lJLeRGIVixPRau6tYPDptJU43lIoMhcaKfEet43s3X2NwAK+Lx1
 pcaFSQMmhA3UOI/ijdiJ26qhSIPodQbI4+HuPvlLf8t0tUOAG86AB+KDfamQur63oe1w==
X-Received: by 2002:a5d:5607:0:b0:43b:8f38:3b88 with SMTP id
 ffacd0b85a97d-43b8f383bf7mr1020345f8f.25.1774432491926; 
 Wed, 25 Mar 2026 02:54:51 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470f902sm48761476f8f.28.2026.03.25.02.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 02:54:51 -0700 (PDT)
Message-ID: <447a220e-3058-44e8-ad77-fd4edc793baf@linaro.org>
Date: Wed, 25 Mar 2026 10:54:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 3/7] vmapple: declare it as an AArch64-compatible
 machine
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
References: <20260324204855.29759-1-mohamed@unpredictable.fr>
 <20260324204855.29759-4-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260324204855.29759-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 24/3/26 21:48, Mohamed Mediouni wrote:
> .interfaces = aarch64_machine_interfaces is expected for
> AArch64 machines now. Consider vmapple as an AArch64-only
> machine
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/vmapple/vmapple.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

