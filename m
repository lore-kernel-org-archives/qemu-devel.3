Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE57C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 23:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1alW-0004xm-PZ; Mon, 29 Apr 2024 19:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1alU-0004xX-L3
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 19:50:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1alT-0001me-0S
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 19:50:32 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1eab16dcfd8so43761145ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 16:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714434629; x=1715039429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c4LQ8pQ55yal3w5LVcgzoj300Y4S1ggdaEAav5QLN5o=;
 b=Lg/DD5DOodDoSma1FrTLwheNvvhre1vB7DESoyMPnK1AL35xLeXnmT9P8MYajawrwp
 49VRUU0i6r4wlGz7i5kjGmT8OKmMf+l7dle0i1V6nJR9maEEU3XmF+MfbhYpHlC4wMOG
 EvWeO27wqf0EVCFvOeB3f3Pivv7AE4XG/EjgdL4pskTtMpoabrGX8zayFYMKqIynShxJ
 E8796mrVk2W3W86laZNTfMhMbAOCck1tvmwD5vIUxgrQoOg2AYT6/tLUJc2fF3AjjEFv
 VysuQJUhLvm7SoigBqYYJQqyeaugHidpRtH6XYWZcVRp7BvY0e1OJc0mDv8Rh8ecy3w5
 5MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714434629; x=1715039429;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c4LQ8pQ55yal3w5LVcgzoj300Y4S1ggdaEAav5QLN5o=;
 b=LuCDbXOnXYY3LGRQxcMxMrPvbEDql/rKaRhhci+NVwBVyCdqwyBj+fu5IbBAoS+4/O
 3bxIpABNUk3iHauqRuJndj2PE58fuClINd5fK+xcir4KbPSH4TTo9XxDOPOfcTgrNbKK
 HznNbuMFYm8GJq8GL1vaB50OZTOVv9SzojkBk7R1iFUF2OkslVHZD2nVgruz4hv124zQ
 ZQ4CknMWZJZrPnOXskXx3EUzbcGDPoUykMXVfcabb7MSmsC8RTpG+K+u1B4oD3jHeCBy
 LFVvjHq0W54Pg7dzwib2B5Al2kiwoDYO3lim22tA2hOEvwhNZ2FX8D8xZ2U42wLX21Vp
 QgwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpD80gSwXrsc0goFkWORv14DvxJQbSrhyZx1cRHRlt5W6eakr6lU1mNrByF61m5ZKUFEq/sAW96UBvXUXosWqkKvOviMQ=
X-Gm-Message-State: AOJu0YxIYgNInmqrz8gTrc85oY7Qay4ufT0BuKFmmP5SQ02tMoLAxts+
 B9CIqtaIAEzPpMsyOBZ+LoytYl9rmuu9SwW3/c/FX9//wNBYvulEjz4aUeAF5Ks=
X-Google-Smtp-Source: AGHT+IEu4OoTKhzulvn8GQuYrzTRBjKM3rXZoX27VE8vbhGECZtpnlgjrh+77sPs/24uztzlwcXskQ==
X-Received: by 2002:a17:902:ce84:b0:1ec:31f5:16d5 with SMTP id
 f4-20020a170902ce8400b001ec31f516d5mr776387plg.33.1714434628853; 
 Mon, 29 Apr 2024 16:50:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f54900b001ebd7bdaaffsm2467523plf.288.2024.04.29.16.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 16:50:28 -0700 (PDT)
Message-ID: <aa97b437-cfde-4eb3-bb9b-ba5d85616e79@linaro.org>
Date: Mon, 29 Apr 2024 16:50:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] accel/tcg: Restrict qemu_plugin_vcpu_exit_hook()
 to TCG plugins
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240429213050.55177-1-philmd@linaro.org>
 <20240429213050.55177-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429213050.55177-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/29/24 14:30, Philippe Mathieu-Daudé wrote:
> qemu_plugin_vcpu_exit_hook() is specific to TCG plugins,
> so must be restricted to it in cpu_common_unrealizefn(),
> similarly to how qemu_plugin_create_vcpu_state() is
> restricted in the cpu_common_realizefn() counterpart.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/core/cpu-common.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

