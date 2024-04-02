Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E71CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rragu-0006MY-CI; Tue, 02 Apr 2024 05:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrags-0006Lk-Q8
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:44:26 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrago-0008NM-Mu
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:44:26 -0400
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4161dae0c02so1053965e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 02:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712051047; x=1712655847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8WytRsArQJ8hz7HH1Kv7Q1OAMeEu9qZkBbvNo2US5oY=;
 b=IUdwdSisSgT32PYvYavzGRG2wC+pKzeH2d+At9om+uGOUCYURmdMZKt7EJnFFw6yvb
 V9yScbWxfEgyyWD88VtuXAzJN3NfhyYs2NcErcdstYFDahC8rlC+lp6tb5AvNq52kqAn
 OQuudL5vd2/xR5RjOQMWoeTBhtkGuFGVFF4qcF83ywJUFVVQtMuMFx1PkSB9UsV3PtSs
 q4JqkDQkItBssxx8vwbjLFihwx3vto5g4jyAtpVPAUrfa8UmYZsm2Wlllb9sEOwWCSF8
 C40HfHQzBM5MODvtz1bp2SUFIOGnaRkvXx11ousqhAah6oJw3FhP5CzSVVrKHi3y9C6i
 4bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712051047; x=1712655847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8WytRsArQJ8hz7HH1Kv7Q1OAMeEu9qZkBbvNo2US5oY=;
 b=bI837ffSKv1UwtcgyVajwkTjSl58XFtFDdLLjJJREyPLmHpx0dbGU14Lm743tQhd0K
 9gQKMSxWwBXKX73GXkP2uKdZKU4cfpOa3RbyXDhlRrJaXlWbVP1cAFC/iywZ+nxOPuAK
 WugqfGwBKE1XG50HPKgjGmD93biYjR8ju2FxYW1v1UWx3YG/o9Kx+KsCvwDC61zt123e
 hhfUx7xQ+dzzzmnVclzG1GjujeWsVhYVWSAUsz4cp9x1FQZ+BwLiQwu53pFi5wvHJWG5
 kQ78U02LqSjIABfY1zuPf+jm7lpCelBbbwVgngaAgHG3HX9/WRjZXj6n4q38i9YWQnNr
 bm6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3iAZYLClq1ybuwzxlHWlv5WfOaqJW1yxsVFyfwFb1tkDRQgPf1VNwuJr4qIHD+ARX8UQN9eehz5hzPVzcVkwN0RoOt0w=
X-Gm-Message-State: AOJu0YzoINdPKsbbGooUvft+/IJs6lVQyx8MsIhKoeqyiFhWjhxP79qQ
 N0lJZVasVT0nr5Unw3kvXgclL5qhmHd4K6HYg9DDZmwxg4ov1Rlr+AFC/e+LChDKow3n2clg5rG
 E/t8=
X-Google-Smtp-Source: AGHT+IHrWhp2AIRTBAduM19kZk51WdFQ9yd79/I4e3nIDaqxLmmfjDK4fj7vSdlNz9N/3/wnArWiyQ==
X-Received: by 2002:a05:600c:4a27:b0:415:6daf:c626 with SMTP id
 c39-20020a05600c4a2700b004156dafc626mr2767065wmp.21.1712051047367; 
 Tue, 02 Apr 2024 02:44:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a05600c4ed200b0041495d17992sm17336351wmq.34.2024.04.02.02.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 02:44:06 -0700 (PDT)
Message-ID: <b729fa0e-7058-4ae0-8adb-fdd9a3f724da@linaro.org>
Date: Tue, 2 Apr 2024 11:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] linux-user/syscall: do_setsockopt(): eliminate goto
 in switch for SO_SNDTIMEO
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240331100737.2724186-1-mjt@tls.msk.ru>
 <20240331100737.2724186-5-mjt@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240331100737.2724186-5-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.45; envelope-from=philmd@linaro.org;
 helo=mail-wm1-f45.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 31/3/24 12:07, Michael Tokarev wrote:
> There's identical code for SO_SNDTIMEO and SO_RCVTIMEO, currently
> implemented using an ugly goto into another switch case.  Eliminate
> that using arithmetic if, making code flow more natural.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   linux-user/syscall.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


