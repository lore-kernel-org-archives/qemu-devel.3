Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF98DC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0McT-0003z4-Jp; Thu, 03 Apr 2025 11:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0McH-0003yX-UH
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:36:29 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0McF-0004vo-Mv
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:36:29 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so876532b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743694586; x=1744299386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aI2RoPNnDlPlolgRMT17FVD0EBcUujUKnB/TGWvAhvg=;
 b=qF5tTLUIhZq2K0J3GkWuHdhJPxUbNXhPHCqVTWDsK6C0UzXB+aWh31Ls6169DJ/B8R
 L6BR/XUWUB2kRN+3DugYQNHnEjhS73K3NZu2i0rYLI40xO5gi6QvUEp1mYHvpGutwaBd
 aOneUKFhy/y6v7qPta3z0otwRwJXy69tjsgpSdYB2UEEvb67CN8s6Zqwo1fpgXiAMXGv
 L+AALYIV81QNQLGBvhyq7W8smL2abHZdJjytBUQ3A6qf9yr9A7cd2Dqa5g+pS8Nej+X2
 Y0+Zoo4JkOjtAnptQ+21SC0mAn2yUp8zWHaaGwJ+h7KVX8WeU+dIUY4BlfoBavv4P1ZU
 g5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743694586; x=1744299386;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aI2RoPNnDlPlolgRMT17FVD0EBcUujUKnB/TGWvAhvg=;
 b=mOlnJiPafuFkrH5NBgBION6xQNAoDoCauS5ORiHrt89IRyyaEZx5dcPBilJvCMad7P
 P+/63OsWIAqzkdzabvLPmw/TNWCouR9F2Z3iL37R+YH3z1bGrwaeWO8SarH6WhSaFFxC
 1vrYKyDh9qAZi59CCr7/ArezZQF1QUqvBW7pUa1imxlKABhY8oLCSOWjvGuc4hSnhOb5
 mng2ONfvlO0W3hFDEdBUQJrOhCkrZagqK9su3yloLYaW+wZgKWFwnnfTj8WlmRgmJ6V2
 k/w05Ak86TQ6hO0j6THBloaI+5bGx/4rFCjpnjhbaC9DPOPsMT1cYEGZLsMeUzpOEkZL
 mNjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUgvHcOL79ikZ5Q8/wQBSuuNaPwSqyEDkRQwURWZ58op937E5bqD48QOhAwsrhHce0zBaqNkBKcuEQ@nongnu.org
X-Gm-Message-State: AOJu0Yzer4wE1VmWSrFZJtycQMIiDqYk6orSFwsTbafK2oG2gj1tomh1
 1NkBeNyLpwHOCIHN4C+ywCIROhDjoinrwaX6+ki/+qsrQ1OXO07mxY2UtypqwfmBLV6zJrZ+s8d
 C
X-Gm-Gg: ASbGncs2fX315l2JXsdBBPcHXe1/2hsSOD41K9RL0JTxLUTnP7IchAky+7jLUBVYXgo
 mV5UIqHxgvOExZiClskPonnq0cdb0CqMEDkKvw7Rvtas5shiWbsxJCgc8AUYQuouZmc+QYAlIj7
 inQPD+07FRbxSi8C+6czMdE6Tzpl/PYjwyqk+BYsxW3SuPltPxpE/Vyg8Qr2SCIvMno+vLOFE7t
 WwyjftbarGH/7QGrz+Q8Z/NFQveFYHcA8Jx60GyBtujw6v7qfkRJihzdPMlWPL4D+JbjI8KqK8Z
 VU4Rn1AI8YeKl2BKdD9yQYDcfwoxk0jXT/1z6HIRSGrew6upq3xzNT2jtMYWhJxlvFy2q3RGHAa
 RrafhOM4s
X-Google-Smtp-Source: AGHT+IHHsuCY/P7dP55Kng/gNpvZyKconc1RG51CRmBAW6HD8W+vcKySb4sCRtb1UB3swPI7tSmyhA==
X-Received: by 2002:a05:6a20:43a3:b0:1fd:f8dc:7c0e with SMTP id
 adf61e73a8af0-2009f5f725dmr33719522637.12.1743694585823; 
 Thu, 03 Apr 2025 08:36:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97d1c7esm1636043b3a.36.2025.04.03.08.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 08:36:25 -0700 (PDT)
Message-ID: <79abf14a-79ee-4829-a695-57bdacbb8b80@linaro.org>
Date: Thu, 3 Apr 2025 08:36:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 41/43] tcg: Factor mttcg_init() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250402212319.58349-1-philmd@linaro.org>
 <20250402212319.58349-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250402212319.58349-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/2/25 14:23, Philippe Mathieu-Daudé wrote:
> Keep MTTCG initialization code out of tcg_init_machine().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/tcg-all.c | 50 +++++++++++++++++++++++++--------------------
>   1 file changed, 28 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

