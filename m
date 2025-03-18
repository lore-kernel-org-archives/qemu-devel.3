Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2785CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufJj-0004Ce-5e; Tue, 18 Mar 2025 18:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tufJU-0004Aq-PE
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:21:34 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tufJI-0004cb-N4
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:21:26 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-226185948ffso53935175ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742336476; x=1742941276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oMWyKhFjYGpE1Bc3+5PVG/lcM9O7ug1FTKJVkXkKJkQ=;
 b=p3XSMZx4gxAG8HPxLiKQSA/+aCR5stTBMZMwXc4FPhH9U4BsjFX9sgkkv5Bwaffc96
 JJHkGQUQtcKCPYF/g6ygJU4Np2nJCFaqiwNyYJWAXXGzDUM/D1rB7LidfRrwB3tqhI6P
 f9KxMwWKUQ34rcVgwuYTdUUT7yAEOqaFX3NE8HdRJk4fwHJcU2XuyXE2+gq6wwXEpFWT
 w6alISF0yY5w9fCYvYrNCQeB9qnMlCPSrh4WDD5fnCCTqb5KkwO436Bn5J85NraMtfS8
 ORC0xOhZaGbuCFJXC06qBmsU3m8d/lfldAYsarWwcjsl5ZJCRYWIKmp0HK6EMVQTsqfl
 FP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742336476; x=1742941276;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oMWyKhFjYGpE1Bc3+5PVG/lcM9O7ug1FTKJVkXkKJkQ=;
 b=GaHlMq5J4VwdlJhW/MG4zBIzBhKek9voep+yVIqtB5iw+cbhy/B5JwO18E9A57dpZ1
 6LRgc00IzaO4GE158cZR1fRy+q0PC4toyx96E2kNpiyNfoXKUt3lJBxmiltmB0Zjq61S
 zI4vW+N6x7AIdrTlZLzoQUWiTcBSdtZ9P1awjaDhhUqoAG5eqw8qQr6xXyoDu7d7OXXz
 9XN4Jp1ouWa+Rb1/u26qUXQXlKGXyQdj8KfaQqbw0UwxRb9c9N/BBMk/arZ9Uosxie5Z
 bfy0bKWqB/2E9ER/sj7k7ANqvFYTDzzRQUF7BfuAkqjLn4lqh3SY66+D2W4nWWP8AGxu
 a4Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhzFCAl4qDscZ+A0SO24DVeaOVDJBzwPd6NzcgRkb7B4lGA3xgHV0reSpwdiSfuZu5PxvANO5S97pi@nongnu.org
X-Gm-Message-State: AOJu0YzNNf+1+/VYLM0wJNavTCs1niy0/hkmBsR3hLQ1j6wAAbC6YuSc
 Sj0d+POsIStTPwOW/u1uELNzG93loSDo0rg6Q0kXyPHZFuvOslLTCY+/brqzYvw=
X-Gm-Gg: ASbGncvoW7QE2bVVv1OhVGOSR8QQB8u8RbC9zFVqNiFC8llZEnWq7XxZAWFjLz6/q+y
 +T2XsZaZqKpk3V0rndx7UORlUHFDzvtW2Erp14webWV/98ZpPJm+0n07IzzbUEmoGHvS2zl9w+0
 By9nIuDQpsXv0jlFuhtl9vmbXWXjBqlTNg4aziXgYbOkZY1nQATRYariTWiS5W+QPVzVzdPtbr4
 s7hFxoBcOj3DYayeILZBzJAzuOaz86h0XrM71FaJbYcqro7Ii67bLiK4UQpFkUIJKkBF3OyntBk
 Ocd9o4veTdFDJTDlgVwYaKX5I4hsG6jpgsN/J9TEdVPzlpEUF/Z45HL9eC7rVeNN2BL1j8Ert/5
 +ndk/J3o7
X-Google-Smtp-Source: AGHT+IHyyJCsiABK+wwwJ/lgyfO1ls36ZQt3JXsVmvsivUDUtxpenS401D2LRtb8OdsmEgQFuXJjhg==
X-Received: by 2002:a05:6a00:13a7:b0:730:9801:d3e2 with SMTP id
 d2e1a72fcca58-7376d5fee6emr654299b3a.8.1742336475698; 
 Tue, 18 Mar 2025 15:21:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711559269sm10478181b3a.65.2025.03.18.15.21.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:21:15 -0700 (PDT)
Message-ID: <0c6f23d5-d220-4fa7-957e-8721f1aa732f@linaro.org>
Date: Tue, 18 Mar 2025 15:21:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] exec/cpu-all: allow to include specific cpu
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-5-pierrick.bouvier@linaro.org>
 <35c90e78-2c2c-4bbb-9996-4031c9eef08a@linaro.org>
 <7202c9e9-1002-4cdc-9ce4-64785aac5de4@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7202c9e9-1002-4cdc-9ce4-64785aac5de4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/18/25 15:16, Pierrick Bouvier wrote:
>> This doesn't make any sense to me.  CPU_INCLUDE is defined within the very file that
>> you're trying to include by avoiding "cpu.h".
>>
> 
> Every target/X/cpu.h includes cpu-all.h, which includes "cpu.h" itself, relying on per 
> target include path set by build system.

So, another solution would be to fix the silly include loop?


r~

