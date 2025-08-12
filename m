Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97421CA0EDC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 22:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulxPB-0000Mx-TI; Tue, 12 Aug 2025 18:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulxP9-0000Me-Vp
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 18:23:40 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulxP4-00074u-1j
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 18:23:39 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76bd9d723bfso5224707b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755037411; x=1755642211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ssKsX5grrzS3HLn1Q4WWkuO5kdMCEhMSjx646b3evhs=;
 b=ULtRZmQZLGG7revI5LQC0yAKZQ06OYeIxodAAK7uTWVgEj6cgz+SEOyGkROlGK2i27
 KHfDcQXCgDDQbrBSTmMdK8B9Ot/lFH3vtzijcTKGeUJSGTxkOx7bAaSIhzAhmxBRnUCn
 IIRLhw99pJ9kiGu5ZUUApGmiRy46TWGyUJS1otyyV3oVDmPG1/xD9p+IbHM3/XYis90s
 8xQjw9I+AeeuTcNLiIrUaR7sR82kqr1a/zukqe/lYKYhG8wUtmFZWGBElFRwY4xHl1og
 6jj874yuqMCEkVPKmCQMPYQ1LF5lWNztrnaNQsnrPlOYa0xolKmCmlVeFYH1EqhDTNhn
 /asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755037411; x=1755642211;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ssKsX5grrzS3HLn1Q4WWkuO5kdMCEhMSjx646b3evhs=;
 b=iHTjZ/0Da3nK4Ato2HPDdYEtDWYqdbS5UpMGFUmXO39g0yfmSLyK8D5/cURWQuVA1Q
 BybBFzLCZ5HfPcRCfXpRHteClimwLWp7PbB0+t1wiYsJo3mnthN+7VReUC1L7Mb26Hft
 py08rU8U/HCucr+tWzBFjABa8w87zH/GbyES7tDfzCUTxZHNs5yZkeCKnkohrq+4wmSz
 /aZDnjuB81npROhKBktlg2Kar9eZroV+dTv4P4OfGG4tVrqhbZUGcP2c87tlDWuCL8Xp
 R3D+Z12nZaWrAYbDdartXqmXps37WtSM4nzUOF8gadnOpEZt5F5NoNF/NhpcMKGsu4Cm
 m1oA==
X-Gm-Message-State: AOJu0YwMbjgXdQ/bPH+5KJHHWZhIZS/T4hOhltpAEaAY3oa9d1xvFjsD
 wikmI4azKv1zDJEjaofXjRwXFGiHMs7lzXNvfQBkbF0+ej+Ve5KRarc/oaHM9/SMHq3scbfx1eP
 TlzkMNys=
X-Gm-Gg: ASbGncvGKZPygE9kVpXWQh+utiNE4vQT6of9fiS3Q+IzptVDd5muYwczNd72a/1EerH
 jqQfIOjCH8h9UJAzivQu5oaBi9iIBy8av7FbL2tQQBaLhNgCCcfKZNoVX3aK4d/XfaZ4QOSgMph
 5lzEfDQn/bAzesgmeM5LMz11lMCDyXPLklIfextza0U5NCxpEHA3jNggklACWd9Ze5Ai/PYiVzZ
 6Nqd2R7rCyrheUJ7gJUnsfoSgyItbqgVOOhWLGFwlmvKyJdvrCNp2xyL6i6CS6TvcqSpRRlVd+/
 BK+PyvbiYvZdolWC0Yhync8TjOpKpX9HA45COwrLJEnMzHHdFkGGRzQiaenoFnitKhLd7s/9+w5
 nHIOYSgJg25g4/OPE08b/Ck+3+HawWqprcrGoyzBE
X-Google-Smtp-Source: AGHT+IGAFmfrZ3vgygLQn8clajsKtY+N4sYuNJaLyKQH2OStEoZfjMcMFYbzg6PW9ZJ9j1wKQul27g==
X-Received: by 2002:a05:6a20:244b:b0:21a:eabb:ab93 with SMTP id
 adf61e73a8af0-240a8a426c4mr1411282637.6.1755037410595; 
 Tue, 12 Aug 2025 15:23:30 -0700 (PDT)
Received: from [192.168.4.112] ([168.140.255.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f474sm29913417b3a.4.2025.08.12.15.23.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 15:23:30 -0700 (PDT)
Message-ID: <c2c2421c-7150-4154-ab18-7ae8dd0edb85@linaro.org>
Date: Wed, 13 Aug 2025 08:23:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/10] target/arm: Replace kvm_arm_pmu_supported by
 host_cpu_feature_supported
To: qemu-devel@nongnu.org
References: <20250812172823.86329-1-philmd@linaro.org>
 <20250812173131.86888-1-philmd@linaro.org>
 <20250812173131.86888-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250812173131.86888-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/13/25 03:31, Philippe Mathieu-Daudé wrote:
> Use the generic host_cpu_feature_supported() helper to
> check for the PMU feature support. This will allow to
> expand to non-KVM accelerators such HVF.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/kvm_arm.h  | 13 -------------
>   target/arm/cpu.c      |  6 ++++--
>   target/arm/kvm-stub.c |  5 -----
>   target/arm/kvm.c      |  9 ++-------
>   4 files changed, 6 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

