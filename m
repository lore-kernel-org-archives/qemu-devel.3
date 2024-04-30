Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C9DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1pmt-00034z-6w; Tue, 30 Apr 2024 11:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1pmd-00032i-91
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:52:44 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1pma-0001l9-1g
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:52:41 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f3f6aa1437so2493824b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714492358; x=1715097158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W12sfmv8gxhlt1g8Cv3EESwS9HoYCUXqf0OMXsOXpjc=;
 b=P3+IPWI3CS4lPpfLD8vaoCzKF5JGANiEIh/KjS+8jQhN7IT20OR2k+7mfJSeX3/p4W
 GKs4qntSVe4XYvYmgXGs3pgRqVAixwstbGq8VJq83yQmIHmCcYtvPAxyG3QmaZGugN9j
 Zbd+bsaln9dU4bY0hMa8Ng6pUeMLxt8pQRtEFIfJvTEfoX2I3WPXfdAVaVRXZYd0CnsL
 ozodYDYRkVY2uU0bj7bWDJx07QzrBUzcK/hqYTmEuqhd1su1ib5+oT3YZrCRrQZjHWtF
 R8ISp58WjnPgA+M+NImG6r0PkP5UgYnrwwEgcEeatEpkCysxvcfcire8A2dFVtYj7CqP
 8IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714492358; x=1715097158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W12sfmv8gxhlt1g8Cv3EESwS9HoYCUXqf0OMXsOXpjc=;
 b=fRFNfKvLjK4vv2vUsgVnkQeiAd/j09KDyKv0gxB1PUngpa2EhbZ5/AaftAJZLa7ZwU
 nPClHih7XMcrhbAqIyCP46pFRpqAJqZ5YtTYNQK7YelIu32NLlgyM+TUskOuUdV1FIA3
 o5Ma3bdh+TpfRR6Ntr7sl+j+6qGsEmz/90tjDF+VOSO2Az1RAtKfanX42QeYUYxmZaJK
 gqTyQoDXzY6sE0t+GTfoPnRoJDZZiMLNtqG64IUuQsS6AIpb/vsG5wKpbPLpXTysktgu
 kP8iDV0E0VKWQldwTibZWZGLI3hWw8QWyaec9C12aPs0y/YpA7GCB3x8J+/xkf/WPStU
 6DBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQpa/BIiz4UPf2YDidx+yABYJR3MDerxJ8hGxnciBRe0OX0BVf3H+2nkgT9e3vbxiEFWFWM7/DTUogFj/IW6BudsvsizE=
X-Gm-Message-State: AOJu0Yw8IBTqmjFbeVHCsA0u/CqMekbBG5UhngS2tN5WQmfB80dCZPWG
 XpYhm3XTuHPXg/RmUJrl0kdX/4BlJUk3NUHjfZHCXZkiOEfYbHq4Cfc/aVo9Dtk=
X-Google-Smtp-Source: AGHT+IEZQTQ8ikqbySVwOLxc77bNKNT1Z18tFpltA08PCcXV0TjYNPdTHeqSN6TYtvobpY6RSa5i9A==
X-Received: by 2002:a05:6a20:de89:b0:1aa:5fb4:87ff with SMTP id
 la9-20020a056a20de8900b001aa5fb487ffmr208183pzb.14.1714492358424; 
 Tue, 30 Apr 2024 08:52:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 dq5-20020a056a020f8500b005dc49afed53sm8265794pgb.55.2024.04.30.08.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 08:52:38 -0700 (PDT)
Message-ID: <29135846-744f-471b-9e21-ec5a6309bacc@linaro.org>
Date: Tue, 30 Apr 2024 08:52:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Hexagon: add PC alignment check and exception
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org
Cc: bcain@quicinc.com, sidneym@quicinc.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, Laurent Vivier <laurent@vivier.eu>
References: <5c90567ec28723865e144f386b36f5b676b7a5d3.1714486874.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5c90567ec28723865e144f386b36f5b676b7a5d3.1714486874.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/30/24 07:25, Matheus Tavares Bernardino wrote:
> +void test_multi_cof(void)
> +{
> +    asm volatile(
> +        "p0 = cmp.eq(r0, r0)\n"
> +        "{\n"
> +        "    if (p0) jump test_multi_cof_unaligned\n"
> +        "    jump 1f\n"
> +        "}\n"
> +        "1: nop\n"
> +        : : : "p0");
> +}

I will say you could just add the label to the end of the asm here, like

	.byte 0
test_multi_cof_unaligned:

rather than use a separate source file.


r~

