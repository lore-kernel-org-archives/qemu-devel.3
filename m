Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E210ED5B84C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fSB-0002Jk-V2; Tue, 29 Oct 2024 02:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRt-0001v2-Id
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRl-0007Km-2u
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso35319955e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182275; x=1730787075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Sn7dnxFDpjbpR+864fGEqvnIzbs6s3UCPBypZxjA6c=;
 b=qBUddnoIEKghk5Xx7+K0X9XzlFNdTleKsdNOWVN+ozXQOkV6rygW4/njKMWWgKTW9D
 y5XbbTb4Cw0Qi3P7yGhuHLN9aPPDLt4tyOmAcOE7mXAgLeIcIEw73wgSMaIQksqTNEbj
 T0/0xvQUoAMp9kiiR9VSasMv/CT4zu6F/yCqdYrFzH4+OSlHZ4enQbntXcp6eyaNeNwD
 kGmBi83Bc9ZnDe11g/BjIvJU6tl0wx9PMl5ndDOHLXgI8X1ajkVcg7oDI2ltdbqICDXb
 miDVYHajAcI//p9wQ5d+Tg+SnQL3eoFIOxzXkFHMTMjfHXNqn45kypcI04A6403XAHbr
 L02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182275; x=1730787075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Sn7dnxFDpjbpR+864fGEqvnIzbs6s3UCPBypZxjA6c=;
 b=MUq6HGNutV5ZOrrkQFU0a84ZL6mrYl2a3q2fiHJ/dCis6llxTyP2kCQW7XIfagYR6S
 KvwK8LTgdKGBaqNmYYzhBqjfbCWKjn7u+NXhsfJWpjfn+Rz4iOaam3S/n+rpv+YIrvYK
 FrWOiJV5WnHdW6p9pvjf/lCa4qrp2YOruwDoSceXNl015L3cy2N3kOEkXfs6WINtY3CK
 6JDE7dW4llOXuFis3B9Gn/wBWD/iLTDwhWLDoQr+hABXtk4MRsYU+rkCOLV4mGNd01Qj
 6ZUT+p6UnE3WKQo8nL8ccG3OYDIK0CnGKkyDBXaVzjTks8BD3zka55gsTqPzzeu3O7KY
 SVJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtJxwr5L6yQ3e1jREnkVwVK8FJt5P7+nsCSetPlpWc4xx6/zQZ8GeYPjiDK1IC0JdhrUmMDvEYmSi5@nongnu.org
X-Gm-Message-State: AOJu0Yy8zLEmLp2yVUlJTElMbUWTAbiji+Qg/FLgpVLLr48TCCTyBIoh
 SRYpGWtLfvbyaODvgQCcA7I7JAodqs+J+4FWAl1kp6MBAAtymPWMPa/DKzjkbXM=
X-Google-Smtp-Source: AGHT+IFVfS6+7h55NBGwVYtCNaB0wCrswmGz1sjCdbGLYykZJBDTYvp/54aKNIKxi8MoU1nTnMn68g==
X-Received: by 2002:a05:600c:1c0e:b0:431:5226:1633 with SMTP id
 5b1f17b1804b1-431b5719562mr5656585e9.6.1730182275193; 
 Mon, 28 Oct 2024 23:11:15 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b566f11sm161756735e9.20.2024.10.28.23.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:11:14 -0700 (PDT)
Message-ID: <82df9519-6e76-4aff-aa51-070ea96c8ba5@linaro.org>
Date: Mon, 28 Oct 2024 12:26:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] target/openrisc: Explicitly set 2-NaN propagation
 rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
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
 <20241025141254.2141506-20-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/25/24 15:12, Peter Maydell wrote:
> Set the NaN propagation rule explicitly for the float_status word
> used in the openrisc target.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/openrisc/cpu.c          | 6 ++++++
>   fpu/softfloat-specialize.c.inc | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

