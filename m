Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C55606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wO8/YwE0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOPqX-0004NS-BI; Tue, 03 Nov 2026 20:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOPqV-0004ND-G4
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 20:31:23 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOPqT-0001GB-Tp
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 20:31:23 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2e9995ce866so1256295ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 17:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793755880; x=1794360680; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LQURYfG3Jw5iSE8D4WaiLoFYLx87VLtPZk+vP6HrCEY=;
 b=wO8/YwE09gMwJsakIcmkviFJ3uIEl/UIOnCiZ1E0PlCz1WKAmq4u4TdWUKK5x+XYrz
 szXyxK/MogVWD4mIg3HizPM0WUtxnz0IKLQDQIX6hmz1dgZ1FacLLhnajiIhg73GLGPD
 co/aokiPZRP5S9lcX53sx4eYo+5b6EWGz3u/AyFS8iO25PK3+UCexpz+LQW0YwUaPIc1
 ZXH2JxsVAoBsTYGD307466yABYt3XG5ccjHFhwQS2sjJCciJ9/fy/hR5P/yxn62UaBLq
 0IsLWFP7EVIOyQaeSNFHyHYH9+9dW1/nqqOrb3LVd9mP17XniDh/ElUClNSVhL2UBKZp
 EFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793755880; x=1794360680;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LQURYfG3Jw5iSE8D4WaiLoFYLx87VLtPZk+vP6HrCEY=;
 b=rqbmYYqVS9EYtjCIrDb0VOuokrmfRduY1h+r5w/HAhkenASs9dvr/ljVG7ecNyTLfL
 9sO72IzMwY2gcV6xYbQys9rip30rjTBya06+3Wjg2EQkBdrohZLUxtMvpnJjW7lGGNC5
 Q4ngjWstWuL1hBaUhZg4pnKy+xY/eEbBNypwQJXNzwqZ/gqEqqFjnMFJXvU6F8TTUcG8
 ip1RD9UIqBc50qYLLXQnjfCMgb7YGS2WSMXHYnvi8IRBRImqL586a9j6xiaVKw9KgTCO
 PL1ud1UPrC/DUpXJ8Rx65y7nqXGWgF7wAPf4OFcHQIAHuYlO7GVfnXVvMrb+OpAg0ogw
 vtXA==
X-Forwarded-Encrypted: i=1;
 AKwUvByGWNNigfYxkDh9+fWIEIZLV2UJC5hw1lxagMb7BfSY9REe00O13LbXy8RFKBBqd//tZzWedQHVZ9YR@nongnu.org
X-Gm-Message-State: APuU4Z+Sli4XBbM840kC42ACDvYCU07Y3ycyOF9C8gYK7UOi9a06qtjA
 9LkIQNKoUm8u9u+Zd2WBNHHcotc+N5J6R5/6F/QfeRNAeIuC6hojx16l1nFtgyEN4q8=
X-Gm-Gg: AYBFou2vuG4ufMPjdnipNoBvYlypB7gqBPo+GeGvEEkMOZkwAdDnhJR8rnjOP+xKe7S
 8Kg1WjgJQUxKni6TJqPrZT/oKougIU6BemL6gi9gY2J6RPLLwLA18FJA8uCBeujCxx9gW/8KnEu
 1btQXFiOQuOpCv1aw8rRakqejCOLvceUfRE/5k27D//fOt2IUtSFR9AXA+IR6uvUNo24qzmpjcz
 r4V5Vi9LF0CZfrRr+bcpjChpaCLyXxYofeWqalHCZGh77/+AFN/bU3MWFbky0EdWctD2UVHvCJY
 bvjV8GqIUGtw7z5M2RTsQjaGIBXtc41P2VYG2ApgOf1SsHRqlAEq60+rVyGQ9n7Z9t23yge8Ja4
 VsBuNrPQft3UA1DXZ118C0ncJ/bliYdS+rFejhWs38Cwq/exw6cBUZnbSdCj4gVJa5dW2h+7vQY
 mJZF3e1dAd9JxQ+J1ZIzQXNeVra5hqd56iirkDikxRBeHd3bNRP7cmvJpL2LUZZGZcHmPplKqtV
 QNxA9L+hD2Pob5oriVhoFdbrLu6/SI0Yefs2iKYOrZzcj37plk0/YOQF5QPlnMXlu/L90p31pLb
 JjB5rxGqEo9PDXxdQHoJk7zgm99eXSDLlHoLPsES6ouJc8BbevGpKRzakmNVsUu1Q5f9/W3i/PH
 jmADEx4V/be/+Fn8=
X-Received: by 2002:a17:902:ea02:b0:2dd:7646:35cd with SMTP id
 d9443c01a7336-2eb3633227dmr139057305ad.0.1793755880260; 
 Tue, 03 Nov 2026 17:31:20 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed08bd5845sm780335ad.2.2026.11.03.17.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 17:31:19 -0800 (PST)
Message-ID: <3cc94ff2-ada6-4a00-9604-0e6fd8c84d72@linaro.org>
Date: Tue, 3 Nov 2026 17:31:18 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for 11.2 0/3] misc fixes (checkpatch, gdb tests, x86 icount)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20261103172431.1180482-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261103172431.1180482-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 09:24, Alex Bennée wrote:
> The following changes since commit a3565937b39779d4e3704298095f566e7559ad53:
> 
>    Merge tag 'misc-fixes-pull-request' ofhttps://gitlab.com/berrange/qemu into staging (2026-11-02 21:44:22 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-11.2-misc-fixes-031126-1
> 
> for you to fetch changes up to f2e3e3bd30842d75211ad20dea6605c8b3c49899:
> 
>    tests/functional: fix call to common_tuxrun_gdb (2026-11-03 16:51:19 +0000)
> 
> ----------------------------------------------------------------
> a couple of last minutes fixes:
> 
>    - make checkpatch validate fixes against upstream branch
>    - terminate block on x86 RDMSR
>    - fix common_tuxrun_gdb call on s390x

Applied, thanks.

r~

