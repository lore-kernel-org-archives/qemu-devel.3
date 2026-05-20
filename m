Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3501CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkO2-00070o-1d; Wed, 20 May 2026 13:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkO0-00070f-GX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:07:12 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkNw-0006sq-BX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:07:12 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-83ef1d17904so5121855b3a.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779296827; x=1779901627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oa6gXKzaUxdwVFbXfUc377IX/7ZI8ebIrG3jmpClP9k=;
 b=X3ek8MZk1YxnByPlCjxQzxfc28ZOL8up3uZ4q2dMfe+pHnfW6kR6uQL8/OfI40c6yY
 ar9idjjdYRo6Wa8SlmIU1/XJtoIczXxN/ZB+azCUQcIgueeM+x1j+fjS3iBSL384XwGN
 7cltcOmv7OgX07W9WM7Ctwk4lk3rmFxGNmIUVDNHbZ55VM0LJ+HQJk53WQZ3I7LwLwqP
 DdvBOaZm9Q22Muo4h2HuED9l2qDo8YdC1mXpyv6TB0b6KGvLXXDobbzX8hJYCfLTGdHz
 a5lpG6G94LxV3Kd4Fc5u7V5pj6/hNJtViwobKOa3teNvzamFi+5rXZxiyL9H1dQiONKf
 wXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779296827; x=1779901627;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oa6gXKzaUxdwVFbXfUc377IX/7ZI8ebIrG3jmpClP9k=;
 b=STc+wQlSnEflrTIIo/EF2s9ywjnYqrNhfI24YMGpAA4eJjQ9o1CCOVAJjBWCouYRCa
 9wlrRsKlUsVwwHv2CajAH7kZIPFdvIWDfcpgcIYaU/MH8E7bq0ORPPiNLgb3BxbipRdv
 Bm4CAC5slhPXgXqBgDkYn1H1EnKBNCel+rUKU4hmUWTqUNg7aGo5StoSCNv0sXOYxyLF
 SdstTYCd7937HRTA8XQvZ4aghbM1LXkUbOpFEmZCqxLjTRmDFpjXXWsfL/+U3eE3Xpno
 vqwC5TyyvenEgfENUnYNIebmEOry/KQFO3XQe61XJx4K3Ysv+TuVK0qI3mZoAAch1D26
 aFjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UoLnga/hX8ozI0Hys1yQB/Pq0sUPlW48Uy/UqyDL5iFg6Qwz1rcpUmB1KlthurPyuSiPVqPo7ijG7@nongnu.org
X-Gm-Message-State: AOJu0YzZPXCgB7eZFiSXIjemGiiyLjDKIntQIMR5cL519ycnI3EKkJwb
 2hc5HahHaTra/sQTeow8yfFWlHilPEU2XRQtqVGxzF+KJOZBGoKASDi+Hyj8QcSfFyM=
X-Gm-Gg: Acq92OFByk2w8SgZXNYyOknCOH/swovCbcCpEGqdMzJt1o7lR2d5mTSxtkFKaqVoJ9F
 L0sM36t5Lsk6wJlGYPNoPYiu9j6ryhuGlyRmrmAeEZ/urqMF+kipmsD/bs0m2juUBQZiuHRoiZk
 r5r5gYsCf6OLtUXFaRe0scTummHr/EMJsySaKSsmqR2wRLL27zOmpu4mALT1Ig3+mjC+X81Vvnv
 LHYfpduouTSrklJz+jVAN0s8EEH3BAVy2ZCzTTtqyW/CpEuVPWD2svRIPhxej5E+UU80ZQYA//k
 mP10etFSa5zi6soNeRwaK62u4sbDyi2eXyMYEWBGR64R1adoJrlkzhbflO1RfbuVBDiGYuQ45Df
 VxMAJrN2noH0vH2lVSwAn4+0wS9ZvPOKs3Jq6vsZwc9IXFJ3IqzWFJmASdVYQvs4BMUjtMZ5UFF
 fLYmXsz/W0ZlJvYi0MW0GEQsNVgkLkkcwjn+Ok
X-Received: by 2002:a05:6a00:1908:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-83f33cb2c40mr25627674b3a.13.1779296826883; 
 Wed, 20 May 2026 10:07:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c7c008sm20758469b3a.46.2026.05.20.10.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:07:06 -0700 (PDT)
Message-ID: <bd64d8c4-d955-426e-9a86-b8b514878f60@linaro.org>
Date: Wed, 20 May 2026 10:07:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/2] tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>
References: <20260520125139.13352-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260520125139.13352-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 5/20/26 05:51, Philippe Mathieu-Daudé wrote:
> Respin of Richard patch split to ease review.
> 
> Richard Henderson (2):
>    tcg: Massage fold_multiply2()
>    tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
> 
>   tcg/optimize.c | 90 +++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 59 insertions(+), 31 deletions(-)
> 

Ok, queued.


r~

