Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12BBC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s18zo-0001nB-Ke; Sun, 28 Apr 2024 14:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s18zm-0001mY-Qx
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:11:27 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s18zl-000765-8A
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:11:26 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1eac92f7c74so27651055ad.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714327881; x=1714932681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yIrnjO/B8q0HO5EXMIKL5C25Kz4a/nZg+FPlbPEYZXo=;
 b=TdqgEuMOlnKb1BPe7u28DXXlhZ7kTc3LQl94X4J8frKQ7l81ypGJRa9489hyPxSL9C
 E+OhJZq0/G+4dg6ipfmqQSP0BKBCZAEpq+xNUbI7oXwG3oVwN4HmifPyef9uW6JGSsqv
 Tu2idoALfQ6Kf213l+urn7tJFnRc9FoR6wvH4d3yKsUWltnyk4jeovpEuLDHpINxh/DY
 eFkijeHtiWqPgZfJ9THgexsfJf84rUR9J1gArXmPVXzWQg0ALBOiVImZ4BbhWTE4kaeQ
 RQBTBa9h3dqv7Um5DNxl94o/28XbTkNWhS8djxNDhA8Aabl5IZMzmDlPxAteRvxWsjiD
 YOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714327881; x=1714932681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yIrnjO/B8q0HO5EXMIKL5C25Kz4a/nZg+FPlbPEYZXo=;
 b=UMkgQeTd7puZnctwRcaxRiaLKsSYye7uZcnb1lduCOq9iTumNklHn8gxCoy0x5qLPF
 Twl6f7ZMtSHwe2K3UsKrRlWUSlfasCpt0htCDD6PYUwbK6c6QZA6xZoY/XNSuhVbhpEn
 7aBFCYf+sJNkczhc8bIr7B+cFxGiZB3BjTFZNwrDw1WWm+EOolEslTbG9o0f4mCPfo4o
 qQvV+QaiML5FgHcGxG/sremAlPo/ttVYA/hOdwxVfk4S9bsnWT5cnGN8CVbPrZh816ib
 Lw5NJbHjb0Qz0UjRB1zf1EWgmulec+zKntiS5ntlgzn912XUcEaulzxOCUGG4pc6jkqx
 2Ncg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8eKeabSanWDBtqBZOs8zlD6HS0yQIUDTKzb5ibXZkJG1Eb44St35rYmlXqRpU7NN9z/s0Utoc4OxJManFnHlJALmxrik=
X-Gm-Message-State: AOJu0YwNKXs2iaYtgfMSstTiSc53RylwtHs6lNt40BmQQy4EP3NsJL99
 p5hRf7m1vJ2AqU7J6W7XcsuLsH9xsmkhsSLFhxnK6qylvPTCwchqrg4tGCyYrqE=
X-Google-Smtp-Source: AGHT+IFRjjyI7OrHGnZFoovrRwL9dvAz9Z7ESdm7EF3g7lh5iciw5B5FieyYpceInrXDDlBnMNV8pA==
X-Received: by 2002:a17:903:2342:b0:1eb:4c98:8b15 with SMTP id
 c2-20020a170903234200b001eb4c988b15mr5892057plh.61.1714327881589; 
 Sun, 28 Apr 2024 11:11:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a170902654f00b001dd0d0d26a4sm3986436pln.147.2024.04.28.11.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:11:20 -0700 (PDT)
Message-ID: <0c7cd5ed-2256-4f6e-8d71-5a77c3c46252@linaro.org>
Date: Sun, 28 Apr 2024 11:11:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/i386: Simplify get_memio_eip()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-2-philmd@linaro.org>
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

On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
> The single call to get_memio_eip(), in cpu_report_tpr_access(),
> is protected by a check on tcg_enabled(). Since the call only
> exists when CONFIG_TCG is defined, we can slightly simplify.

Nack, that's not how things work.

By wrapping the whole function in an ifdef, the symbol isn't defined without CONFIG_TCG, 
which means the if (0) { } block cannot compile.


r~

