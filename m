Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9EEC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 16:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZviA-0002FQ-5C; Tue, 13 Feb 2024 11:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZvi4-0002Bf-VR
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:32:40 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZvi2-0005TV-N7
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:32:39 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33b66883de9so3189549f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 08:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707841957; x=1708446757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4cdNstmc8vSbFQqZ+QIlOSp9QrHWOJ1pctG8XOlTt1M=;
 b=XKd5JiAas9JbLR7hgmU5K38mTTl4O7vg+SPAJLP5+ixB59m6vePYNdgT2Ha3Lb6jbg
 2FM6qkflw1FQVkW5euk88wl+8DAxOa2zcTION5l8YfQ4SLH2G0YMcmOA3fktBlsw+TTn
 Yimj4YiSXw/Q0aj8fbW2mcTOn4kRx4UwQ2bgJLC9K5+AmIM/4mmELsmujoSs6ehKrspc
 BlFmDvDKNJbugCy9H/bU4o0M33DQ6aS2CL9YyAsuVIMZbN/stsmKNYkYFEf0GKgufFFt
 TdUcg2Hf2eJc+ZTXD7eGtBSW2RcP0OWxPHm1L18afhZ+QH2McFEApeEqn2P20uuNKgA2
 ue3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707841957; x=1708446757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4cdNstmc8vSbFQqZ+QIlOSp9QrHWOJ1pctG8XOlTt1M=;
 b=th29XE25b3HrIWgXR4j87XwWmzTLv8DoluK6LRKfR2FuBDDiahbOF06jaj705LynK2
 VGUt/qo+WF8Xs/JCCxrkVtNcgCmQ4f9pSvH3bIqWXg7ENSnBEpW+gOIHmNBdxH7Md9JM
 r/R0kC/L2he1M3kP2t1jXk5jSLjPIVwsFyyB18lIFfoDNePuUIKZNZYebB6Icfi9h0w+
 Z1uJvmTxuLroRPlWs0vbcRSxqYmL2Q9zUymszlNxDyDPuE18+GtOLOv2/anyrbHdWvwj
 3n/LeqQcFHyjE7I5BpSwbPF3/v1ytd9+NubuTV2a1k9wfNvW1B6owb4+4NLwheD04dL1
 BINg==
X-Gm-Message-State: AOJu0YzLzh3Esp5KS1mcjr4P1dJSqOu2GdWb0UK0Zy5fOuj9SA4Supyh
 /YhDXmRfV/7LqKQTPHriAjttaorZegMTdIpQAQ9U4MhKlWcBr6pLzkpL1xylXzIKKmJCiiZxa0S
 f
X-Google-Smtp-Source: AGHT+IGzJ1/QEGjwPGtFmQiWlHGgZgdOsUAUZaF0Of4bbiYIKuhYm7Hf05nfF1uoz3qdlMxs1EW6RQ==
X-Received: by 2002:adf:a3cb:0:b0:33b:4b08:65d6 with SMTP id
 m11-20020adfa3cb000000b0033b4b0865d6mr6781637wrb.51.1707841956754; 
 Tue, 13 Feb 2024 08:32:36 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWzagmSLT5WKPTB6NZDxzENFZwAKbZhhtt6LbglguXE8Kn/5aELoYFNOwDSQqhA1DtUUAdvAtAL57m5/n3llaMVD+EV/s6edaZmH00/48U7gTx2HXzF/k8t/iqjaOKqsMa4YPRO77U0VXG/7zdeaTZpIYRrEni2D/RReoNs3qYenISoKTHiv8rQjre80NAfYHHFDfPMMtU/xdn7W1c4rwR57MNdrRCIHSVaC/TMhAMadsi3TnxDrT6gJcfsasvPrtOI8+pqX7BKcwEHsO1UCKZsXuoIz05T1WsXjN8WF3xgiqLDhlTGLdP/Zn4jEwSRssYgjZ4=
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a5d58d0000000b0033afe816977sm9887821wrf.66.2024.02.13.08.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 08:32:36 -0800 (PST)
Message-ID: <2e230b9f-728c-4c25-b58a-a1a9f8dae62e@linaro.org>
Date: Tue, 13 Feb 2024 17:32:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] target/mips: Remove I6500 CPU definition
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20240209090513.9401-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 9/2/24 10:05, Philippe Mathieu-Daudé wrote:
> Alternative to:
> https://lore.kernel.org/qemu-devel/20240209085347.8446-1-philmd@linaro.org/
> If the I6500 can not be tested or its support is incomplete,
> there is no point in wasting energy maintaining it.
> 
> Philippe Mathieu-Daudé (11):
>    target/mips: Remove helpers accessing SAAR registers
>    hw/misc/mips: Reduce itc_reconfigure() scope
>    target/mips: Remove MIPSITUState::itu field
>    target/mips: Remove CPUMIPSState::saarp field
>    hw/misc/mips_itu: Remove MIPSITUState::cpu0 field
>    hw/misc/mips_itu: Remove MIPSITUState::saar field
>    target/mips: Remove CPUMIPSState::CP0_SAAR[2] field
>    target/mips: Remove helpers accessing SAARI register
>    target/mips: Remove CPUMIPSState::CP0_SAARI field
>    target/mips: Remove the unused DisasContext::saar field

Patches 1-10 queued (without removing the I6500 CPU).

