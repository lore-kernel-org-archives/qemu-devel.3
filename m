Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21600C3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5EH-0003bi-Ga; Mon, 05 May 2025 19:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5Db-0007tY-Aj
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:27:28 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5DY-0004Ox-HN
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:27:27 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30863b48553so5653306a91.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487642; x=1747092442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DColEmLeOznk74rz9KqevCsTLWb7uFfsWuQwws4WyvU=;
 b=WD+UuSvnpeLes2Iy/FTAKPcVXPmY6B6Nujutl+7G10AMO5UexrW13F/NwjyoKvWvEa
 uS7sZg2hJFamweRmhL7KkVhT7Eal4M4YH8eFlFMSNBY7BPDqCNkszqYYfrJ9D3myL+Be
 Il9V201ZS3VSANZzj9lAxI2UjoZWePPdbXa6FY4PvNYEW3chGCQsEWlf9mk006h393MY
 7+JTRqjngTcX7yMqylwF5qglYXhyJoqBAgGvfedEdS3XVmXsI8OrgMmJ7cQKBQqn+WV5
 SoDlE5JxlwKZkTKIAzry9/XnJvZHlFsa1fdujlO3BIbMA+w8DXj5CVTQeQzg2hlcGCGp
 R+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487642; x=1747092442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DColEmLeOznk74rz9KqevCsTLWb7uFfsWuQwws4WyvU=;
 b=VrMlLVQwRBGslKDYHBt243vfRaXXiIEB1Y0A8bTZ3aEStuy5eIlib5+39yWTP74c5P
 UnzgrO4FccN63gn0KgQK0z1CintHULn3KIdc/iF7dkDKCbQu+MbXwwWpJaNw2SdeYdD7
 Reo5gnC2kawpLv4Xta6AV+WdL14mXzlaECtxPTr3fgX519/2wvPSKQ9rB5g43LLpQPUd
 AGlcUUBMMOIc7TIHZBydDjYBMBId0ddEicG6xXbhi+F2SolUh+RG/nY5NsdkzyBIjMSM
 WpP/tx+yJ4v7uZFzZ2qUuKZvBq92sWbnkauF3FMoWSCBlSehKXhJ8UPJPwdRr4Kojw3Q
 v1JQ==
X-Gm-Message-State: AOJu0YxPnWL+XrIWp1tCuk+NzDqVM8lQM2DPxPTBqRcM2HAjH1dWhpuP
 9mWN5rVzWV/FqBzWwR4yQIO7BLffcFlOUVHEtaGenSwkSApiGIleO76T6xCef37jEmGe/r6Z/ci
 CxsU=
X-Gm-Gg: ASbGncsHfoksU5lTFQYEZGR25t0IuGd6PNFHoufdAWPTD5jJDNhbsK0fNdiS2lZiVzx
 HQIPH/u9Es369rxO7AGSRFnlA+bOGvjTiYLLtP82K2EMYQJTyNdA3tT2dTvigHYYD+WNMZdOlJq
 LdvRiciONlOjLyI1bg/vIDSMQ1z34aInMj80cyUrrxGx5r6XB5Arp+2lEM72+Z1+EGtJtuLVWM/
 FxM0cbfWGomijMe5jvwUN38jKtEGQtFP1VeUgXsA8oytb4WvbsI++2dWrrHoSLbU/medK6ytgfU
 x3GiWk+iFvzmzQ+go98ABHZaiYuwDfHnto4spQSjWrYilqc0KT0mYw==
X-Google-Smtp-Source: AGHT+IFgstfeaoCNVrbCHdFFeS0ZpKEX0NF2KwZsdipdG+8jwM/CES45trboYz2SF8VajkqqYc5+hw==
X-Received: by 2002:a17:90b:544e:b0:2fa:3174:e344 with SMTP id
 98e67ed59e1d1-30a7bb28833mr2046495a91.14.1746487642685; 
 Mon, 05 May 2025 16:27:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a4745f920sm9649121a91.8.2025.05.05.16.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 16:27:22 -0700 (PDT)
Message-ID: <c009277c-4777-4a80-94ed-922f40147700@linaro.org>
Date: Mon, 5 May 2025 16:27:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/50] single-binary: compile target/arm twice
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

Patches left for review:

- [PATCH v6 04/50] meson: apply target config for picking files from 
libsystem and libuser
- [PATCH v6 41/50] target/arm/tcg/vec_internal: use forward declaration 
for CPUARMState
- [PATCH v6 42/50] target/arm/tcg/crypto_helper: compile file once
- [PATCH v6 47/50] target/arm/helper: restrict define_tlb_insn_regs to 
system target
- [PATCH v6 50/50] target/arm/tcg/vfp_helper: compile file twice 
(system, user)

Regards,
Pierrick

