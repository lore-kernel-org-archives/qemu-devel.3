Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0486CD5B874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRS-0001Xi-3D; Tue, 29 Oct 2024 02:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRH-0001QL-Tg
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRF-0007BI-29
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so48548275e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182243; x=1730787043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k8fHzV/f1hnDLxHZZKnInt/EtNNRU39WIf5id+i+9CM=;
 b=pRbdlVHR8w2foK9ZS4kZpt93Ct4NSm4p/RkkGSbx8bagCL2G8N1KpTYPUC6oqbvl2+
 Pkuq1czs3Wn9Z9uKLHWbQ/4uG0X3Wc9iQ+e3JlYm5G0LMKHaQvjy9cCIV9mRnKBNV9GX
 DDJFjz53lTSbYjDfCYdfS6+bClG6EC+1CIQE3wsMAqj/MfIFWjU2EGQ2QG5V9thNTBjv
 pSwmdKp5ZOtO4KBCVkF5Myc6jFyrfX5S4P1+hap32C0KtEeNgHHFfeFvrXQuo9xqbmFY
 8enP0JaMOaX9ZqwWNIEb3MQxXMbPFKzT0aLidR2pIc/VwryT+YigyQQ/PassuP4L+pgE
 y6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182243; x=1730787043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k8fHzV/f1hnDLxHZZKnInt/EtNNRU39WIf5id+i+9CM=;
 b=NAZKRBqah3O7Dig8xSS5KxgpGoQCaIZ1D5SY0jq+l7QHdbkXY4biEOfC5dVz65j6PF
 wEX+U6iGYad5x4RqBlv6Tz2a1mZuBrXQhVViam2fEyTVX4qqWL46Yk0HzMzMn2RJV7CI
 tqVENR+Eyc/YcOZGCYhfS/3SVSX2PgSxUVBHQ9VG+EQraRupumc6LRcLh/k/g9Pdc3xM
 FbAbYHeZAnsplX9Po+V5g6u6xQYwy2owOkPec97/M7QYpvlvPfnlLVG2zo7T7Cp4XzmT
 ROCT3lI53R3m+YfN4UK59OIhNxorRA21Z9u0SjEUEeRiyjmPLZxMyRvYPXz4fJT6l+Jt
 nzww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvEm6frubLBbXYQwv5uID3aetsPdViq0gXyoKX5bn4/2abLyvA1nv9pMf0v7Ac+3g0DKVIDw5h35Vw@nongnu.org
X-Gm-Message-State: AOJu0YxFap5Gci5ISgyP2Sovi3Q+ukrQOgMBnV1AAaPOZoQIHkSSqGak
 eAVyoyoiYVNqLXgp4cY3311znexFHfY0bLA4g6o31UvGFWktPp3Aruh/F4GduIA=
X-Google-Smtp-Source: AGHT+IEC7ve4M7PIBcVep8RqsgKORn95Q7oWzbKVPhXEGueQDzHNr/uXBnkdWwabPuAMZNZUQzjmhw==
X-Received: by 2002:a05:600c:350b:b0:431:44fe:fd9a with SMTP id
 5b1f17b1804b1-4319acb8a7cmr88621115e9.19.1730182242752; 
 Mon, 28 Oct 2024 23:10:42 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b55f5e1sm165298915e9.14.2024.10.28.23.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:10:42 -0700 (PDT)
Message-ID: <9eb4fbf0-b641-4d80-9eae-72ac24e2a8d4@linaro.org>
Date: Mon, 28 Oct 2024 12:16:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/21] target/ppc: Explicitly set 2-NaN propagation rule
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
 <20241025141254.2141506-9-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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
> Set the 2-NaN propagation rule explicitly in env->fp_status
> and env->vec_status.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> ---
> As an aside, it looks a bit suspicious that we set
> tininess_before_rounding on fp_status but not vec_status...

Indeed.


r~

