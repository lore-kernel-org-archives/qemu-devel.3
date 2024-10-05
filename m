Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA167CF8868
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtI7-0001Ml-CH; Fri, 04 Oct 2024 21:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtI4-0001ME-Bn
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:09:00 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtI1-00041F-U8
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:08:59 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20b7eb9e81eso31836615ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728090536; x=1728695336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JT8niUKf5ZQQb/sDnw5AOXKsfuV1koKxYes1dLv3pRA=;
 b=jNyc4a+YBMAlHt9wES50fxf9GbqAsLeKQChzDbRNo6Jl2SOeUUYhgHOBKotu9CqrA5
 h+1S9cahAJtd1NAw+9A1Px1BPba6A97kwRQEjtLmYMZBWiV7W1APR+S5xUX/MvJkOZyZ
 USy+T93DQwTfuGn9cVdb/UT7z+W2OysQR8aOfWYhs1gd7LwLEPB29zbZhEuEHy94QxCf
 NVJ3iDvTr+GEOE3CIlno2tImIq0r8f0ViPtcZDlBQsxHeXMYpO1/BtyjYzdWdlGFRR3+
 3QLnHcAXOACq7oI1Oxd6d8Svnxn/Opx4ji9hwg6Inf5CFw1ppUbWyvtR2Sg1Miid10Yk
 Xpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728090536; x=1728695336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JT8niUKf5ZQQb/sDnw5AOXKsfuV1koKxYes1dLv3pRA=;
 b=o4fYXMlp8c+u9hSP5D44b1xTUrjPU8ieygkEx1Q2S8m06aCKUi1qahK/700Bzsxi2a
 DljLFCfcXE1Q+sv4EYLLF7z7C6ARg4n9aZghk3UmPGHCR4wC8sTlkXUp0Uf8N88E3t0A
 tGlA7XVfOn68J7hXd3ezRyGxhbiHB5pYqJCVYmOYb1Yn+80iYPDxcYxBuGukZ5CVxDNN
 M8VVFmTTQ0rYYkM9p/v7VLDlrY5pNoi+0t+OY7WsI7T1wPzaIMDNwU56c+93oWG9QdJY
 3+KDFTg+aAB5TudCkjvFQdQIpgyZLECzjSCg3YkXOYjrqZYeCGPQFBW/Up4wrx02hQDg
 Zevg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYSSQcnExFH9Phg6tmOPk5Y60+UM6PClmnRS/hwWQgOgNX/KwrJvTbmLWc8OwjmSqkSegZT6Oenoli@nongnu.org
X-Gm-Message-State: AOJu0Yz1WLD+WwpUpQV8fKZa0RKB8GuuN/TWEvb2a1VSPhN/Vvw9mPZE
 DPvjxe2o5vmuKDRNgqkWKKUjPbV6J/3GJaNnNpua53PAwC2d25uxn2OSgIAC4x4=
X-Google-Smtp-Source: AGHT+IFUZ9/dfCBLUmh3WECQTSDBzo5BxE9eC/GQzfeWujdZwis03IdAMlPEV3WwoAiCqHBf90xoaw==
X-Received: by 2002:a17:902:e84d:b0:20b:b26e:c149 with SMTP id
 d9443c01a7336-20bfe01d3c9mr65298225ad.29.1728090536249; 
 Fri, 04 Oct 2024 18:08:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1393a15fsm4297935ad.121.2024.10.04.18.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:08:55 -0700 (PDT)
Message-ID: <219b1d8d-66e9-4228-924e-fa273e4f9d19@linaro.org>
Date: Fri, 4 Oct 2024 18:08:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/25] target/hexagon: Replace ldtul_p() -> ldl_p()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
> The Hexagon target is only built for 64-bit.

32-bit, which confuses the reading of the patch.  :-)

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

