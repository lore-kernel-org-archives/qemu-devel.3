Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400EBC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 17:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKLD0-0001nl-Cg; Thu, 20 Jun 2024 13:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKLCw-0001du-VX
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:04:23 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKLCv-0002IS-3a
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:04:22 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7041e39a5beso939625b3a.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718903059; x=1719507859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hob8cmTF6KTnQfL59r2fa3FyswISqsN1fLLoj9QasO8=;
 b=FrI8Zpq2s3+U5LLoy8rFWO9KmZg/Ycso/AXl5xQUddb4GjKKcroCKCUuoksKaHBCMB
 7XOttPZh8t9uz3ZxLw3dyqb5wglK+Td57Vw3RNkNd056IAXPOzdpLsasuaKNzjgp1bWa
 wRhc3EDjOpN5CkJVMqe/5grwoT0O5Y8VOduj8gUUuvETZF9vE+MF1iiYhWymVUCcJ3Pd
 fwywRLjmPri3G4PDf8QZCTQvH25xGVKgfc5B5S4mTuzmrhdzI0Awik3qNwppu5mmhsDm
 Nw5qMidgqT87IFqA+4jWWSyZ7olggNznTq2LETunfu8GcwpXtNtYXQLjk+JPsfQR8oXg
 NVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718903059; x=1719507859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hob8cmTF6KTnQfL59r2fa3FyswISqsN1fLLoj9QasO8=;
 b=auBjcl83I2EX3/tr9uTNvXkRAFBjf+lpu4Ac2f6ViMofMzXpYvqYg5NVJHyZ6G6DCZ
 fi8ZMr3JEe05my172p4OwQYWOTreC8bPHRIj/x1q1v10LWt58QNRyPhVltfqDZcaVwa7
 UC0fRvYOje8sheTJY18pclVrOS8KEJCS35Y4xc3PiaRvRctlmjkBtSVQPY64ajkCjVhT
 rqSW62hsbgpmt0vGtk0Xw7yr+vhpjqXXCuvHLEWGO0ejq5itJbgocA0wo0O5mPzlVCKY
 wnAQ1GBZ8ZgwdQ8cpWpipb9UNXU4B48u/B5bAfkTFZ60IU79wbqbT//qYFW6jtjCOXHw
 hxmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwZVpf4HHxzAoUKCZQk7/acapLeyCcbiGxHUlvMqysWP7ln7OBjHEvukyVLH+IBgblSX67gJKQgFycvDWwLnWleyz0bbM=
X-Gm-Message-State: AOJu0YxnMdP56J8GdzAeWFFrk8LQ1zPW5smUaVG1TLwYK06W3xOnaiTT
 znufwjV+CdrMS+lbv7Vjj0X4y6HXh8bAbnBRdUD3QwhsXMO00ANuVo0AFeUfzEZAlCECvMEFF6t
 y
X-Google-Smtp-Source: AGHT+IHwKdcBXI8I2jEPppMjRPHB+S/NlC+OBfDMkSlynDT6KHT3etU6Q4wGfy+6Sz7iOLWUHhZf4Q==
X-Received: by 2002:a05:6a20:3002:b0:1b8:9933:14d7 with SMTP id
 adf61e73a8af0-1bcbb655bc5mr5725314637.43.1718903058313; 
 Thu, 20 Jun 2024 10:04:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb8d7f9sm12512159b3a.194.2024.06.20.10.04.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 10:04:17 -0700 (PDT)
Message-ID: <e7e16cae-cc7f-4b70-ba9a-10cd0aedc98f@linaro.org>
Date: Thu, 20 Jun 2024 10:04:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] meson: remove dead optimization option
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 amonakov@ispras.ru
References: <20240620130254.415699-1-pbonzini@redhat.com>
 <20240620130254.415699-6-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240620130254.415699-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/20/24 06:02, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   meson.build       | 13 -------------
>   meson_options.txt |  2 --
>   2 files changed, 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

