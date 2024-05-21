Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4973AC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 14:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9QZ5-0007ew-12; Tue, 21 May 2024 10:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9QZ3-0007eI-Mw
 for qemu-devel@nongnu.org; Tue, 21 May 2024 10:34:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9QZ2-0001ml-6C
 for qemu-devel@nongnu.org; Tue, 21 May 2024 10:34:05 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1eeb1a4c10aso1963015ad.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716302042; x=1716906842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1raY6DegR7L8dxIzzsbo8b9EerfvgO0p2AcYjbVUunY=;
 b=tHOgyvW6Q5FeVQndpzTetPqCBs/7jc5dk8WP9+9bo51vbMvjiBlnQc2XuT1xzPVoQE
 6xk5Iuc99PZtVImE2OFAAq6jzSLgLso+bmQh0E/UGL7x3fQnnJ9Cov0ZuRSvWn4mESTn
 jJtTdC3aQ4dldYFL4znawKVNoKCuBndzHUq6I98/r/X9GuVgvhda1WKUL/Udw5/A5+9z
 7Jsrf/qioyT8TicWwi5YWKGdRBEhlL3Tkdc+JHo4DTt7S0o1IDQg3YUZgIId8mVGWEum
 DhK7+EoF9B5iUeP0oNG0jOw1u0VUCVSPXzgMo9Z4AZS2tyHm6SseJysC7OFOMOBDcln6
 4bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716302042; x=1716906842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1raY6DegR7L8dxIzzsbo8b9EerfvgO0p2AcYjbVUunY=;
 b=AMMcAOIzBtSyPxcTeMIt/F7yDdwr3Oxm9xfLKUYcsOV9/EECUSrz94cIm5SfDVE3rq
 ewIN3ezKB9x9Gr/3xnQjaF4K4F1i2nfRot1NHDhJRk/yqVqXUdB+j50nD+EZ5eKvI2N1
 LhouaeQGIXpk0jvNu8zx9vwvFtAtis+EKaBXCFFoWbvMwiVYES7cw0g57967bCkX/1Il
 gNa3/0inEyPi7wXR1KhOeaahctOP/oD1HxezveXD5x8Jv0VnR6kVkJcztKPxJ0wKh+LH
 oV1GJD4JF22NIq8ck8xbg/sWImb0MOl1dWe8/grDY+mfWt6hnVOsL2B2cSxCqNjqSrlQ
 s9Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO34T+9jprWp0uhgnHVWFb4aPN7wI75Q6pkwsywyVePIPjCyLLyu6u9XiBT2Qcdsb98uhWrQo2esuXxt3uOSqlrjGLZ6c=
X-Gm-Message-State: AOJu0YzHqW8j97N+ZJ/DCFuRqfMO2WPkiq3p2YNZhlGopuEhQvdsUa5/
 lM4mCAkLxFKJ9As3wwIxJjToAGTdPMtJOAfJwK5hbg85TrLSsdEkyhbNnmtq36Q=
X-Google-Smtp-Source: AGHT+IGsYJ1r5Oga33V2eSRG2FfU8pMnSRYYrHh1Uh6HqgGku9B2US11Me0n/ixM63FlRND4JU9zZg==
X-Received: by 2002:a17:902:d584:b0:1f2:f50d:b4e0 with SMTP id
 d9443c01a7336-1f2f50db86amr84199865ad.25.1716302041985; 
 Tue, 21 May 2024 07:34:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c2567absm221276455ad.297.2024.05.21.07.34.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 07:34:01 -0700 (PDT)
Message-ID: <ea128bc6-c5c8-47d6-be4a-a4e306499e31@linaro.org>
Date: Tue, 21 May 2024 07:33:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/target-arm: Re-alphabetize board list
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240520141421.1895138-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240520141421.1895138-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 5/20/24 07:14, Peter Maydell wrote:
> The board list in target-arm.rst is supposed to be in alphabetical
> order by the title text of each file (which is not the same as
> alphabetical order by filename).  A few items had got out of order;
> correct them.
> 
> The entry for
> "Facebook Yosemite v3.5 Platform and CraterLake Server (fby35)"
> remains out-of-order, because this is not its own file
> but is currently part of the aspeed.rst file.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/system/target-arm.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

