Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FB3C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJD-0000P8-ID; Tue, 23 Jul 2024 16:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIz-0007kC-UH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIy-0004Fv-BR
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-427edcc207cso10658475e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767215; x=1722372015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KbkX52ekRPk5W/W0NKH90zpqvSGWBSTGGJPnQ3abQCE=;
 b=rkiFJK/FzS8nUBxchOJVaiqwEGmpyerRoiV8BFNlA0mv/iZvoKHnpECS7i/yJtU0bN
 +t5sTVqyBPBQixlaXSAmcHoClVkWxKHC+WTgJIShiJM2mbVyxyuI3WBBK109oCwLHw5H
 Z9eSqfdNqLeuqa8C4c5dQbos8S0mTSCuaBKd84UeM062zMKa6hcS1q7/HYtnkYDSY+XO
 8JavNRepU6Db74EtpFKRYnXg3fHOtM8894Tx7xjeYTxss6Y0mRO3p2+Ok2ou2rt/KhH4
 /B7nJRLl36RwukrOi+Vd4f6aGos+niqAO61Lsvv5F0t6GSvpeB4UG13Ve4abjp31v7Cv
 IsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767215; x=1722372015;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KbkX52ekRPk5W/W0NKH90zpqvSGWBSTGGJPnQ3abQCE=;
 b=EFlybZzgxh3GqDqSfaf2joXZU2ITCdkSw4ZUFULHzESaT8YzeQ0St56LerRcYd8uLg
 gpGMbWBASwCNkQaUS8l/AymrlpoCPRWM9PX3YyGwVu3GlgqG3wFz3DWirLYhLOjG/GU+
 1xj2JDcYFfyeswfbA5AJbCDpvFbSVzis4J4YS1Cz+05abpJ7tbH2Hb8VGK4w0HLA6euY
 VpBELdUwXGQLnx5jmNtqt/3S5/IsuhXY9XxPjzGFbqwiJdTq2osC9CfKPYfFFGs2EY5d
 pkoGYl4E7nbF3eeGkVoiJQXDjmNsOaaVT4K3jVoaqQzgqm5mPXOJTpAiQwoSYO9k8nN0
 klBA==
X-Gm-Message-State: AOJu0Yw1JxjKWIKHkLYJcUa8Vxit6QAOkB3yld4OqnqUZpJgVx0q18D4
 jqITdRoTZLpq00AiwjzkXKRIfPnv7jvh9m/NqIZ6//DMNnO8DLyxFy/YpqZtu7gWYTAVrrU1XkU
 8OP8=
X-Google-Smtp-Source: AGHT+IFajflU+efMeCKJU+4Yl6L3hDWPXs2bR5JQ/MK/AQNbpGEZEafPw1lH/fA0uO15M2yn+d7Cnw==
X-Received: by 2002:a05:600c:3556:b0:426:64a2:5375 with SMTP id
 5b1f17b1804b1-427f954e976mr128235e9.1.1721767214773; 
 Tue, 23 Jul 2024 13:40:14 -0700 (PDT)
Received: from [192.168.69.100] (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr.
 [176.184.50.4]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f937e9dfsm526735e9.16.2024.07.23.13.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 13:40:14 -0700 (PDT)
Message-ID: <3b2eed1f-906e-4abe-a12c-cce3adc3218c@linaro.org>
Date: Tue, 23 Jul 2024 22:40:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/goldfish: Use DMA memory API
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240723181850.46000-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723181850.46000-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 23/7/24 20:18, Philippe Mathieu-Daudé wrote:
> Rather than using address_space_rw(..., 0 or 1),
> use the simpler DMA memory API which expand to
> the same code. This allows removing a cast on
> the 'buf' variable which is really const. Since
> 'buf' is only used in the CMD_READ_BUFFER case,
> we can reduce its scope.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/goldfish_tty.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Thanks for the quick reviews, patch queued.

