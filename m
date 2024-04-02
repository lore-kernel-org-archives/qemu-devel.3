Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC1ECD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcYv-0000k8-VC; Tue, 02 Apr 2024 07:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcYc-0000av-8N
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:44:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcYZ-0005y5-Hf
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:44:01 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-415515178ceso24522995e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712058218; x=1712663018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D3sp7fW4wohPX0c2eRi7YBAVfGPS8rtp+XNRh/h3JFw=;
 b=nt3d04anSyIgWVl6LVGzVWSTz34vbKp+0Q9G4cmRCDeKdOirC5+OUDoa7vW7SP2Lhx
 4lTOQSdaqlYhS42Yn87b7Lb7JYjIIt8QBhwbAuFlOvrmJIhVhlI75OqK4Lf0uMYy8F1+
 JVnVv0NbDum96ME6VIJ0TJf5e3ehKyUwX5/P83ezCDNRFVtd3aOp8jEMW9JmLcOuSrXp
 xc1Q8Rz2GHvUz+lNvCV9DYhD5Ibk3V7OXFDMsIMPXFb+OlVCN9gUVQ/8ssrEk4LgvRL1
 1xlcblm1wduI2H+IWf4rYiWSrw2JCTdMwdiFxwutGwMiznN2meF4QdJAQA5IgXEz98JL
 6GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712058218; x=1712663018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D3sp7fW4wohPX0c2eRi7YBAVfGPS8rtp+XNRh/h3JFw=;
 b=NEPbjBh8asBF1z4oiUtcNYrFLMDEauN5oVwgRS6n7ZbfwJslU5jxg/Aslc4L7pV+4C
 lIxn5p+OxqEvsSJwGrzZSMy4G6AebsOXS5QOEh9e8/3fjqB19uR1VmT7yrZlPR3qz5YE
 ULoRtmPdQIEXgswODQ2SGj67bG1Mmv9CHveopHptyEr/Id0sppOW6VrUNqz7p7ERzXpU
 nyUK8Bun4K7p6/hdIIYoNP4jhd2Wxu6UZwSBJUadcPDOZ9ZztevwzysZoqjubNmXyepw
 LZWhpDgJXkJam6GYApiALlvonyeTnyI74xHA20lzs9Y03PwXQ/BUYM3jiDZTe72rHVlU
 UEtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIpCyAC1dylUxEVGOs/aHAwztBH1ZXl5GCQ3nPVkhix9j1QvVZTFZVODkgYaL8O0A4Fsp69/WjPRpbYtKvdug8DjmvR5g=
X-Gm-Message-State: AOJu0YywveTO9Wn2T6jJQLD/0T2Yjn+7ToZQHTnN7S6nY24vvyKKJGkX
 7p+8ADrhwfZezNCnk8IgU9yBigbRfR3LKzaH7aFXqz7EX45MRDF0NBMhkzQ6INE=
X-Google-Smtp-Source: AGHT+IEW0WRoHUFK/7G2oIoi8ZCzXbxH7wIUMcjzYG4mmhPvbwCwH30Dpc30e08EjlgdeM/sduLtkQ==
X-Received: by 2002:a05:600c:570b:b0:415:5413:cecc with SMTP id
 jv11-20020a05600c570b00b004155413ceccmr7875934wmb.18.1712058218015; 
 Tue, 02 Apr 2024 04:43:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a05600c1d8200b004156daeee90sm3435183wms.4.2024.04.02.04.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 04:43:37 -0700 (PDT)
Message-ID: <9d64b14b-3c4e-41bb-b79d-1ee5d4df3eac@linaro.org>
Date: Tue, 2 Apr 2024 13:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 3/4] vga: adjust dirty memory region if pel
 panning is active
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Helge Konetzka <hk@zapateado.de>
References: <20240402113408.18048-1-pbonzini@redhat.com>
 <20240402113408.18048-4-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240402113408.18048-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 2/4/24 13:34, Paolo Bonzini wrote:
> When pel panning is active, one more byte is read from each of the VGA
> memory planes.  This has to be accounted in the computation of region_end,
> otherwise vga_draw_graphic() fails an assertion:
> 
> qemu-system-i386: ../system/physmem.c:946: cpu_physical_memory_snapshot_get_dirty: Assertion `start + length <= snap->end' failed.
> 
> Reported-by: Helge Konetzka <hk@zapateado.de>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2244
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/display/vga.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


