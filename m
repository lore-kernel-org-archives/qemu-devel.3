Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AC8CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO56-0002bk-7X; Sat, 30 Aug 2025 12:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkCE-0003sm-OH
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:30:14 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkC9-0007Ig-Q3
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:30:14 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3c8fe6bd1a2so427539f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756416607; x=1757021407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BTAPLx+XRUCUScXigpuM6gWrdFLKAeOfwI7pBonX9Ew=;
 b=GPWsqayP85t3AKWbwH1v6s43nEpRujVy8C81prpldxoi2BM49hSAFbgsat0BX2rl2h
 Z1hF46TgOTcPQgGvZa41YoPiAGTCwS/IeRnvnr/T6F9JeHtrz6/1Ak9HTkQ7IztbeQfI
 kHqhMP6bcdYkowyji6/eqEgrg2yvuluT2gXQGZS3jLPt1BpSv0V23KJFQr4sdh7b2fyV
 A7XkeVV75bbsY1cD70ChPy4sp+VNIYfAdP1Ptjemu2c3xDAO1/5L6Ypi2eo4s2C6iV+0
 bWPJTKx2zND3i0Us2C86bdBgHdDyoxGc01k6IeJ9O+1gfbyYPi/5cgU052Hoe5tgMMcj
 eZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756416607; x=1757021407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BTAPLx+XRUCUScXigpuM6gWrdFLKAeOfwI7pBonX9Ew=;
 b=btB9tmlBcJ2Rkf4/tlCENaGjzwrUwzHd2JQvYNoaF/60QnTQAiOQZ5jjApmu2LY6sb
 RSZRPlGyTQOv9qW5VG3dufVtyWEc0+dkqZQTnPds+O0Y8KltrWHgS1axuPnjcDbDqGO3
 Ndp9O3TTjv/CvbeIMWibt8fTYeWHQKzi3tvmrRcCScBsHDBq3OczaxFjIUKL6cLGoatE
 mi+LrlpiXXwKXISN6NCWmyC6VpIp31/6dUk90r99EzL/KkMNxuVKZigPXLRP0TUs9OI6
 hBDw14/+x0+yBHliWpdKhcx65/lINMjIbtv//eVtiIhpKLM0x+2p+sHimYnLit4lpVyI
 tGvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUipdlMxh8t/kkdedjjxJc1MXyHACdiV86eGRpEkluTn1dsf63rxAp1Qh50wwkj1OlmRKYEj+KBlFXB@nongnu.org
X-Gm-Message-State: AOJu0Yw0EOXchZAQuNXUrTm2hkVy4FL5IoeP2RUg5gOLc7H9dHff3rTz
 EsEDN6Lv127flqQGi9JE6g0LapbBPoVS/qf2hJH5h4LMgIyh9JjSRCmwaDobhEQDPU83eWpSfwN
 p4OJ9
X-Gm-Gg: ASbGncu+yQdqCKu5JtbUSKdN7H9sTJ0lknm1lmXJQFHxSz7peTkG4iLBTOXhsp3tQjp
 TkjIsQAX7eE7/DLZckghuase/ludiQrhKSX/Cp2jSz2xuwd/e+3aesjUzJvFsphRcsS9CoZIoTe
 16d8ae2tSqu8P7Opl/IgZteJoNcph87rL2zMoED1eAISFa9jQMHGBXHReQscLvTBIYrnTj6eL58
 g0f2I3x5r2J6ZR+D+Ep9YAsBiT8YeAkvPHf443lQ3jAsUdoD7bYS02cSey8bW+RnSJkESXTyMUc
 d/jCZHZkPV57Hp5Cx/JYsJV3vMXyDG8t0JEb+nNSCAojpmQ5jsS+mhlh8kvgxf8OeeqSa9WV47M
 W0jP8hqZNAC67mJlZPXDPqO6rMMbcn8rDrFhrxbAPyk/bMfVw/8Ky8pmwKytpQNMZgQ==
X-Google-Smtp-Source: AGHT+IFN1TchzTZyzbUIFy7pnUTMKMLUULDNUOBRBjMFQYOoQIme5v8yFE7l+b7Da91NdzVrMtvi2w==
X-Received: by 2002:a5d:5f81:0:b0:3ce:f0a5:d586 with SMTP id
 ffacd0b85a97d-3cef0a5dc84mr1006297f8f.1.1756416606989; 
 Thu, 28 Aug 2025 14:30:06 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm91440305e9.13.2025.08.28.14.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 14:30:06 -0700 (PDT)
Message-ID: <12c7bcb9-5d56-41c6-b680-8e1e49926312@linaro.org>
Date: Thu, 28 Aug 2025 23:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/arm: Remove iwmmxt helper functions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250828140422.3271703-1-peter.maydell@linaro.org>
 <20250828140422.3271703-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250828140422.3271703-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 28/8/25 16:04, Peter Maydell wrote:
> Remove the iwmmxt helper functions which are no longer called now
> that we have removed the associated translate.c handling.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper.h        |  95 -----
>   target/arm/tcg/iwmmxt_helper.c | 672 ---------------------------------
>   target/arm/tcg/meson.build     |   2 -
>   3 files changed, 769 deletions(-)
>   delete mode 100644 target/arm/tcg/iwmmxt_helper.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


