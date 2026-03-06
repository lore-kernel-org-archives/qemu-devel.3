Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB00FCC04D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZ4o-0005GC-1l; Fri, 06 Mar 2026 12:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZ4n-0005FO-0y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:35:01 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZ4l-00051P-Hz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:35:00 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82987437624so1207886b3a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772818498; x=1773423298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LZffydFpCQ8oX1deZ7Z+K6vD3hblkojF+uIgSi9+5bg=;
 b=F5X4XSf+9LIGQEKCW6Njo3UgrDS4jHQqaDjTXSaGztFS71PCJcHtuBgFfFYOlN+SKn
 dawv8QJK7i1Rm4ktudYkap+GSjlrOh57cxf6dcoNvIoyr5cXvPJIF5UPBZUf95sJg8Ri
 7mDYMOhHIRGuUot8KTFskPdi2Diezq54uXc+zJLPoLW0v7otp8o9Hk68oZxnAgQSk+Bx
 8nO6VdRVKvjWMMZDJ99k21DmiZggYyTuOjtn+3Y8JzNfeRBWaDZ1X+A+TZLgX88PYqIY
 K6SuBCabFDJysg7ZU1NiQS62S5+0fR1OEfcPOU72UmbiTPBSfqTLazoGIIjqABDXLNaC
 DaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772818498; x=1773423298;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LZffydFpCQ8oX1deZ7Z+K6vD3hblkojF+uIgSi9+5bg=;
 b=lJXYxypDuTpA+eKK9QjT78D5W1VOerwoUc1jbO2JEl6RC/CT8R58PvYMN4hdSMGko4
 k6n0/7emIlDgSnLbN2uigNE2TYNiqDZg+sjeggfdeRG5F8n9XujgztAB8tuZ4Yo7Lo3Y
 zAbdN6FXTJ8qtJKMTvT7+LEYBY6j71IT7geCEs1n3SfO6sGscAdZOuoERPej2LoQukYa
 cKdX5iyO9/0iIw/Ll28i6ZGeaPapkoOCcqC1TXApkvktYmQgbZJ9hniU7AMEs/yOi3Rr
 na0LpmXMHvPxdH+rCEkVZCB7TfMNecqDZORbGn2dpzG569brp1PCRVn5k7KWOD+a6TCm
 LgPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtI3GdqCICgibGhDeLDLeN4aPs25faldHTgLlSwJD2Ted3LJqWCz6WttCEKECaXyLKZkfGwkhqpqeO@nongnu.org
X-Gm-Message-State: AOJu0YxJMxhsCzd3BlRjD6pGXG/1XP6t3nyxWTACxsqgi3KTOkgEdESK
 NsdherktdZOI/XIxHN13R7Q6gZLXDjJ+dSYHVmqMmy45vbjddXfa1zwO65L21cltxzs=
X-Gm-Gg: ATEYQzynS2YbJvMZwc1WlngDFGfuNFRF70Kq6XNVmNWh1RGbEKjgwFe+LCTSrg5SE72
 A+YIRJWzwrrCMZ8XC4pCR4JoZ5kNH907Ym6TcXb0/XI3A1hFu8MGhrRSKTpDoYQOWR/koDeyw+C
 hg5yrHjmhjwRsI/4x+NKFe2DCQHdFFTKdVY4oF3hlzL5cP2//sZeP5YO+N/IDL15t8/Q3pRFObG
 LuY26JRsmCi4EgcR4EwllV/TMq2QduKOTAVn2f81uDvamz8+Ovavl4UwCaP1PD7PoPIyRULau4R
 HXsiSLByGOdctX6ErXXgSBZfwgiNdUKPKQHZxGR3ypsV3jNKAvM70PUGUaYzKoIq21Os264WBS8
 nZ6FIT7nLnrg7VLqTmVggqdEt1qLTu5T9XaHEW8/wYLEmbDg+d/FMKoGNVKOUf2AxWKyo2eeWvl
 +KAgAIyvoO8G2sl5Kd5QL8Sd8ybx7+LfRqMJ5nSQ4hA2t860VH9+jTsbl5nYX/OG8IzcA6
X-Received: by 2002:a05:6a00:418f:b0:822:69b2:7ed0 with SMTP id
 d2e1a72fcca58-829a29d2a52mr2440724b3a.6.1772818498185; 
 Fri, 06 Mar 2026 09:34:58 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a48de551sm2385053b3a.57.2026.03.06.09.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:34:57 -0800 (PST)
Message-ID: <0d6e2c8f-8014-4560-b032-8d25a1d05d84@linaro.org>
Date: Fri, 6 Mar 2026 09:34:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] tests/tcg/multiarch/linux-test: use portable
 alternative for dirent64
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-4-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260306161728.2657486-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 3/6/26 8:17 AM, Alex Bennée wrote:
> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> 
> dirent64 and readdir64 are glibc-specific and not portable to other
> C libraries such as musl. Define _FILE_OFFSET_BITS=64 instead, which
> portably instructs all libc implementations to use 64-bit file offsets,
> making readdir() and struct dirent equivalent to their 64-bit variants.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Message-ID: <af31d21c4d668cfb940ba4159f584fa6454c3d82.1772107448.git.matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/tcg/multiarch/linux/linux-test.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

