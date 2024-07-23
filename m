Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8CBC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 01:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3wr-0005IN-1c; Mon, 22 Jul 2024 21:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW3wp-0005F2-GV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:04:11 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW3wk-00084c-JX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:04:11 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-78aeee1068aso148472a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721696643; x=1722301443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M9Jepm4/txH3Vn+yfotJrT47ME8cKpqiDJMuGOJpXX0=;
 b=m9Wx9a4NGjJ59ltIqmM0/vgunB5TVEl7PR71HFiyKhLgj+257toBA4cISDKiJXkhSE
 zDtQ3yoaqyh1eac8Prl/z1lQYWCLmQ410rbFUvv1PoseZKUALpVZgjTfzNobdGfsLdZs
 HKnSLemZeI0nA0ZrkIdE9iafJUmwAWwLxxebObRlT0XUGN1OKeasC8y5zLFm72fbz6xb
 tuEAA8KmL95zHVCJP7Ve6EoHHp48+rw2LKTwY+1AKvrfCcaGlvBT28TJarpxta9sm8Jd
 ZD+L7bpJWRJtu7gWc31ND7t8Q9TiWJPM+mvbJjSCNbFXJkJa80ctuvMVt/L0z7oBVDVI
 e0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721696643; x=1722301443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M9Jepm4/txH3Vn+yfotJrT47ME8cKpqiDJMuGOJpXX0=;
 b=bt/SICS2kzt6yEJeWroQeixVptzzwTQNTJWDaTGzewsJ7kUaGMgUM2auL5y3ygCJ88
 msYtWbuSgv0tOOPW0BSW/knQC37y+wBh5M2HrQQ5iWHyC1M9U0kTjtsixwucRROqGfZ9
 TNmAnMXD/IQje769zg5KgeAr3uo3V/UiR3QdU4g8hynfIMGhcSDb9InrR/WhBFf+Jl9x
 ago2Y7cnC0unP+IhYgWYRMp9fw4MttwGEHt8wdg9Cn86KhjgeOTqC7GPLDL4Z2NAxGLd
 HZlJPzP9ey/s/mJ+AjjDYvHQZPdJYn/ly0P15NfzBD79ScRt9D8I3/z9get4t/99/reJ
 L39Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4cfhhapbIvjOgY7mALt0osepo+UsvrWKIG8uCVYr/JlW0XoCD+oU56jTS+Yo5HOCkcTp9sscHq+kIheT06Chfnj1fBj0=
X-Gm-Message-State: AOJu0Yz3LW5/IwA/BJkeiSfJuuNpoTWnmygpms2AoUXXMC1PIKKmSN6i
 IUdIxYaC+uUL+kLp4jWzqdf3j8Bw6m1glb39HzA7UukYkv1UZkGqerIymZwCWvI=
X-Google-Smtp-Source: AGHT+IHR0mam2LB5qOAOWWBdxSp/MUSzIPAOMX3gV9GxktVEwXlIU1k8uZBNg6Ox/YHpyLWtHYRD5Q==
X-Received: by 2002:a05:6a21:385:b0:1c3:cfc2:2b1f with SMTP id
 adf61e73a8af0-1c44f934a35mr1651517637.37.1721696643014; 
 Mon, 22 Jul 2024 18:04:03 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f486648sm61737305ad.282.2024.07.22.18.03.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 18:04:02 -0700 (PDT)
Message-ID: <c5585673-f0c7-4da7-8dea-d87701ccfb0d@linaro.org>
Date: Tue, 23 Jul 2024 11:03:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] bsd-user: Simplify the implementation of execve
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Doug Rabson <dfr@rabson.org>
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-10-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722214313.89503-10-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/23/24 07:43, Warner Losh wrote:
> From: Doug Rabson<dfr@rabson.org>
> 
> This removes the logic which prepends the emulator to each call to
> execve and fexecve. This is not necessary with the existing
> imgact_binmisc support and it avoids the need to install the emulator
> binary into jail environments when using 'binmiscctl --pre-open'.
> 
> Signed-off-by: Doug Rabson<dfr@rabson.org>
> Reviewed-by: Warner Losh<imp@bsdimp.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-proc.c | 118 +------------------------------------
>   bsd-user/main.c            |  18 ------
>   2 files changed, 3 insertions(+), 133 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

