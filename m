Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5518C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 11:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sESXV-0000HM-Ny; Tue, 04 Jun 2024 07:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sESXS-0000Gq-2V
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 07:41:14 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sESXQ-0003RX-Ab
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 07:41:13 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-35dcff36522so843994f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717501270; x=1718106070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m6vTCYCJvaNbF1D26oKym21vHh+8IUhMStQEmKCMBUE=;
 b=uH2zznxQ3CUmUwsU/ALOnoyyWgBeR5xN5BBjzLfq2A9ggR+IXCMnrDP5ZzB98vr/ZJ
 h1LI3SAca7qYTa+f6XUtobVE+pGLQsEc1zFctSWamdruDuNsN/lOHZXIeTcPeaAFkiBc
 NjVLxKzYZm7MRT30whqX8VpUmtEI48DXGVQgzi95A9WDyz+/XYa6EtIR1QEtqk0TU5ke
 /z1jh+2Y66cNJb5THnijBB/JDJFbF5PGeDmyBX72q1AS6df+8bNbkI6Hc01zHfytXeuZ
 7BG8mSiBPGGOrtsFmX0gFzaCYhV7FQbT6TYoj2OeKKujMgCYNXdtQHrF6KRxoTo0osI6
 9Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717501270; x=1718106070;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m6vTCYCJvaNbF1D26oKym21vHh+8IUhMStQEmKCMBUE=;
 b=vB7B4i0Tuq6cU3pSWQb9rRFXnWXXN3VWzirWo4C5K0FtwQZ//Zm4l0o8TW5Rn1P/S/
 YoOsWEPiQHy2ayEY1sRrQmBC+GbkZ50dU2Au6s41zDe0ZHpwkW05mxL2LHqcnB1NgzBk
 RA/Ydn9hq15S3ZWlTfwGM6awMIPEoJWFyhl+kh9jUndOECk6dF9dj485rjDAYqWt6ucL
 bk0WrTzdfpwWDAHfcTGGFmu/XbqUbBiochB9Ja5SritG13dWYal79C2YWO8A9l2RRMT1
 Urwzia6oRcTu5nz4P0VIr7FUdk2Mlb4d6pEt6DBHYqpN/GE60YRhoLlz7Va+CWjH0b2m
 4CyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4kifYbxaH08HgklTB7hNUYixpEwkOhTuHWsijfIA5yRcaC0vlxF5/vscnZaqnxf3UMT7sO6mgeSptGNzKYrAvaXhirP8=
X-Gm-Message-State: AOJu0YyuBXDtcw5iXEhNCB6OWdemDHQUTMGysgYyZ16beXgXcgyaDvk0
 VAU9/OFQMqsXfZ3jajiswrk0JTfhi6a9qWfRzg/ZnDV/guRBdCaQn1oGhd8q/do=
X-Google-Smtp-Source: AGHT+IGqq99yz0iTiqVpHmqK7yrL2qL+JSeTf9F4SM+SDn0PgukqkBYYCdb7JaRPkqoAOa/YlxUAQQ==
X-Received: by 2002:adf:a35e:0:b0:355:32f:cc5b with SMTP id
 ffacd0b85a97d-35e0f2712a2mr8106314f8f.21.1717501269901; 
 Tue, 04 Jun 2024 04:41:09 -0700 (PDT)
Received: from [192.168.234.175] (103.red-88-29-104.staticip.rima-tde.net.
 [88.29.104.103]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35e563046c2sm6568120f8f.7.2024.06.04.04.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 04:41:09 -0700 (PDT)
Message-ID: <f5cbe4c9-c64f-452e-8c49-1c39d2d4221a@linaro.org>
Date: Tue, 4 Jun 2024 13:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/37] target/sparc: Fix do_dc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 26/5/24 21:42, Richard Henderson wrote:
> Apply DFPREG to compute the register number.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



