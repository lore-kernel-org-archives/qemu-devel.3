Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04424D10BE4
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4YZ7-0006wC-Mp; Sat, 26 Oct 2024 00:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YZ5-0006us-FJ
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:38:15 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YZ3-0000bl-Qg
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:38:14 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-72061bfec2dso470921b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729917492; x=1730522292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=znhjkPX5FWYjPyXShpOCq3fXxg1BafTOW0qy9nRGctA=;
 b=cAV0ppX3QloguIpCsidwJVhLPne7tk2AvonCclp8UvwltVpKni/wESr2v9eiLrFOOe
 orzqxSJN19ZAgXO9od0u62Cl9+uncAeqYduenbxWteysfcSlj11bbptzWUSMmuc3ayWw
 bYMrYC1/thPCkxOGy1wUbUWhmOEjhuR8s7WIXsjY/Wiqai1jSAEn4xZQ1mkvHs4Flz2g
 0Ltoa8feGKJjMTyoVAHz1O0eWGWF/IPifvllHViSgNYxa3JtmbmsWIrtEm1F9CX6Q5vd
 yqhZOUM3HKPpxh9XTtjkRH6B21v9AuVn4aWH4U5ayF10Se1LBitOJSOV7AgZC6lOayZG
 M4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729917492; x=1730522292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=znhjkPX5FWYjPyXShpOCq3fXxg1BafTOW0qy9nRGctA=;
 b=mnUFxk8fjdNXyTQvXaATxj4CQBvCBYkYKj1KXPdrAwmvvVevxKQ0ZMFQkS22dhHFGz
 QOVTXi695cCdln8Tkl6zvFd26eZ2d8r/uqE8qHFG/RflLUmfJUlq6FNQp1V2NEXwUKb0
 waak5CGu32mMGPIr8bfa2wjECFcAzW4QwV45kiMQeI6c3a4W/MsWCB1Qd4GzehOxiSsj
 bazQdp8EtVhjc+27q2qp227ywTvzBRPSSZeaeorjaT4W0YzjM0nE4BccBA23UGawRdGM
 IinBaKurOmxpr6t0qo8Pq12rUPy4Ob4U7dF8JRItgeg0LcCMqxm59I3Xwu16Y07CRlyI
 sXOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZTblbXO3lYpzF4emDpm0Zqtr7W+hbT5d1N2PgXzGqncXEDj+R+3DxRXq8spluMwqXl56T4VlutNdG@nongnu.org
X-Gm-Message-State: AOJu0Yy39/Z3eO1/jid2PUlWpc4qdPVNxr1QGXXanTjTHEEsm808RDPq
 zrVfRM/Rl9wc/UBx8KIxercj7Fe26RdJ4psXpvfAYnX4BqFcuvbyY914+BL6BXQTkqApp4xDkIf
 V
X-Google-Smtp-Source: AGHT+IHiEi98Ua8+20vzdPeL4TOKM+SayNL0dFSF2uXzHbYoDfZQdc+xfNN5SBhAtq0mIkiE+KhsAQ==
X-Received: by 2002:a05:6a00:1392:b0:71e:1201:636a with SMTP id
 d2e1a72fcca58-72062f4e63emr2822643b3a.1.1729917492346; 
 Fri, 25 Oct 2024 21:38:12 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8696bf2sm1945153a12.50.2024.10.25.21.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:38:11 -0700 (PDT)
Message-ID: <ddcef854-622f-4c74-8593-251d68dc4f61@linaro.org>
Date: Sat, 26 Oct 2024 01:38:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/21] target/xtensa: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-15-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025141254.2141506-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On 25/10/24 11:12, Peter Maydell wrote:
> Set the NaN propagation rule explicitly in xtensa_use_first_nan().
> 
> (When we convert the softfloat pickNaNMulAdd routine to also
> select a NaN propagation rule at runtime, we will be able to
> remove the use_first_nan flag because the propagation rules
> will handle everything.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/xtensa/fpu_helper.c     |  2 ++
>   fpu/softfloat-specialize.c.inc | 12 +-----------
>   2 files changed, 3 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


