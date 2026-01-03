Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78327FC6160
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 18:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc6e3-00035K-HM; Sat, 03 Jan 2026 13:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vc6e1-0002zx-7d
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:46:33 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vc6dz-0000UL-1M
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:46:32 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-430f9ffd4e8so328751f8f.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 10:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767465985; x=1768070785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9aKRDqX9b22BgeOeuor8pXZ4jQNv+kP0PybtucIWRNY=;
 b=PzCTt01mEpp0NHrPHKoIAq43/RYTnHt6IR2XpUHyEysgrm2eZeZXMka8MynlOYHIIb
 SGi4jB7ClYpDk45xRx5V25ryO8CzxzjchjuUffU8ftIkDriim8cbfh+SRY15RPv4G+7X
 6pCMvyCYd1b0aao0591IbyTrPYQYaPYQzKDjRjJ7m85f4Ykel/tunFCMZG+2Zf1AFn7n
 XUEMUHNTPJeAWX49pHGCEGKW7mZ+FXmEunt9Yux4nrXp00QoUltiAPCJjId/Y0L8Tfga
 PzcrauzbeIt+RXdpYDbE2WQ+MSuzmeLcQOQeLR0ur9UpdpYJhuXQJqc1MeUsfsPfZyHS
 ONqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767465985; x=1768070785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9aKRDqX9b22BgeOeuor8pXZ4jQNv+kP0PybtucIWRNY=;
 b=id6CwKNZfvYU+032a83N1JDE4FlVP2qjX0PBEvDwCnRAuvM5lrp8oleO6qVehhRwt1
 jmfGW6LJNEEf9X7M2qpbtUnK8wcb2ivxjrl0xjDUEr/8e/oowsES0bgbXQSGTU+v67Ht
 NTDLLsB6i1uiZr76GdPrLT5DWntjfVlk1b36RqxxbqcwzRzA6lKeWoxUqY/oJT9+F7yk
 R1OMNyIC48UxiD/51rIXHQs9jda5ptNGIE8U5yCvVNtxVWC6mRmDajPyH+r8qYOIX0Gi
 1BdH+r981YScwUjfbGh49pu2CDo9WkPRo47ROBBrvaxtueORH+U3Gqmsmns8WQTZxpfi
 JuIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtNHLEBm9LzwD49yq26z5p+o/MA9bMv5rTWn9outp7wxmqpXvisjL53wHcM7JAbDgZ39hTNjUJwDPT@nongnu.org
X-Gm-Message-State: AOJu0YwM0W9ZZobbQc1lWP1k6q6P6gnNNjCwP9X8ElS+aWlRj5WX/lwJ
 zsoDHLvcxm+3AWQprjRWXlp6zbCfmbCFf75dncVSqOT7Gwl6UyIKslLfA6Ar91fKCJU=
X-Gm-Gg: AY/fxX5lbdTTKzc2irvzheU5Pa3tC226QM8OBqDEB3hN0udEPGpiN+fO6mXUjrHVlbW
 qok46JLL7dTzz3IJ45zA7q4g1X6QACfa21d0ek9DowDcYe4d2NOkbs3sXMtHJt5sLSGzEbWoxNf
 NRBMgr9kmK1iz49BgvkWOhXrPBTCEcBlfIChtB3p/1M/e6L8acR4ojAr/OcOoUzuG2mURHSFqTv
 yPnEung+roHnKOMTFQXDOjwJkxbbZRsWERi3D8dttg/+sUVFun0WFxnSheYzgFJsbyStfJbngnR
 zBKMOP8gUDS7ZsUxZhpVi8nKDYn2x19UYWD2mHQq98UWoi61BPdNI0tB5Zd20gV5z83PAIYHFMd
 /YeLeT09EKNRbLgTRxQvOkRvc0ykdlxXylm8h4bnXE6C/7U+j5pFVETEzrX05iIW5SVkgCRvas8
 jz8NT4OdkN2sC203UT/W7d2LA6Td77/4rHYU6/kO6yPTFMSZlDaKJ2oQ==
X-Google-Smtp-Source: AGHT+IEy8cGUQ2K97JVU1C9nZCDI/CeY9MBC21wDoGRpUSMj+2gpFgwmGp4VyYshPz/8Y9oVMc8DFQ==
X-Received: by 2002:a05:6000:188e:b0:430:ffdb:e9bd with SMTP id
 ffacd0b85a97d-432aa3f83e2mr4909739f8f.10.1767465984803; 
 Sat, 03 Jan 2026 10:46:24 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1aef7sm90881502f8f.7.2026.01.03.10.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jan 2026 10:46:24 -0800 (PST)
Message-ID: <5a147bb9-62c7-4144-8b0d-27a2be582f27@linaro.org>
Date: Sat, 3 Jan 2026 19:46:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: Widen MemLog::width to 32 bits
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com
References: <20251221142232.22738-1-anjo@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251221142232.22738-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 21/12/25 15:22, Anton Johansson via wrote:
> MemLog::width is a uint8_t value mapped to a TCGv (32 bit), the only
> reason this currently works is because MemLog::width is padded to 32
> bits.  Widen the field to uint32_t and fix the size of the TCGv
> operations as well.  Use uint8_t when passing around the
> field as an immediate to retain previous truncation behaviour.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hexagon/cpu.h       | 2 +-
>   target/hexagon/op_helper.h | 4 ++--
>   target/hexagon/translate.h | 2 +-
>   target/hexagon/genptr.c    | 6 +++---
>   target/hexagon/op_helper.c | 4 ++--
>   target/hexagon/translate.c | 4 ++--
>   6 files changed, 11 insertions(+), 11 deletions(-)


> diff --git a/target/hexagon/op_helper.h b/target/hexagon/op_helper.h
> index 66119cf3d4..ff65a94d57 100644
> --- a/target/hexagon/op_helper.h
> +++ b/target/hexagon/op_helper.h
> @@ -20,8 +20,8 @@
>   
>   /* Misc functions */
>   void log_store64(CPUHexagonState *env, target_ulong addr,
> -                 int64_t val, int width, int slot);
> +                 int64_t val, uint8_t width, int slot);
>   void log_store32(CPUHexagonState *env, target_ulong addr,
> -                 target_ulong val, int width, int slot);
> +                 target_ulong val, uint8_t width, int slot);

With the rationale of this commit, I'm not really keen on using
a uint8_t to truncate. Can we use a uint32_t but assert for a
valid range, or do an explicit truncation?

