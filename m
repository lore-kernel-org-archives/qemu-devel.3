Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88072C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 14:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGgAh-0001hU-Ea; Mon, 10 Jun 2024 10:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgAf-0001h8-TQ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:38:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgAe-0000Id-8b
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:38:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42108856c33so33418645e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718030329; x=1718635129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8T4BMrgO9Himn5e/NN5RW8KrrQ99iahQ06VjN4PaWTQ=;
 b=hxBI86PDeuBN/rQ9zZKLMqmC6ACUbNuzE7l6hW+a6+/jvsK0qcIXyTFxzx2bdaQDWV
 ywfvW/e7lFSUcgAixPQSV+iV9nDXu656p4bYBseQY6AEWdNKhCAy3lpQYvcm8iME8DQj
 kfH+I3rJpn2gxNFjTkX53XmWHsvdfvf/Z9DAaD7pzt5lVRY7apKoR0TUe8IA9/a1amgA
 BkdKfLEtDZ4NvPI6AG/k6lVwdOHAMW+vwisi4bm6uuPB+pqN1ak43I1ZBtyTBVvXCG6I
 3YYiyYQg8JDaMDsPJMYQ7ovqCps9OiarT7o0uoIh3WyKHEooOGz3/zQfUeeqcPwLNCw+
 pwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718030329; x=1718635129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8T4BMrgO9Himn5e/NN5RW8KrrQ99iahQ06VjN4PaWTQ=;
 b=WDnk/YYfZDGMU3zmgl805EUvlJIUNF07br4UnW9buYuh2oHvoGn63xrL4ap4vAUOib
 vukokYE7K3GsYVkYisEGDz2K6x0SDwjGqkSA2d6ykh+jJ4UJZxB1E2v0nmK9QCxkyZNk
 sZfQj5QB4h5Dhhxso4izAAolciHx80OT5fHSYwr84oSWJsB9WDzvy6Ui7mZuC4CQx93Y
 q5a1UeMGO4jhO7LwJ9UP/bfUuzdUtzep88OuFpv5TYkz8Z80LgsqR8HiWkSmlKEYv9Ri
 sMa/JQSnO2ovX/OcW9khQ3+rt6DqFW1b3ILfzmlgG3eXwGGPFYpJ5ynwkVrmszWcsbLE
 Vmaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoPTQMTGzgAcbOQH4UuSiPKU1yY9lRi13HS6owf+JNFEPwm4EfSdDwRSI47VyfAWdEJVBfxe1pE/z8SBxfAp5WWJbAtkY=
X-Gm-Message-State: AOJu0YxKzWF+aabI6eTmmAVrqchgag8LQi/PjwTnmbNvscMjX7/8W5cJ
 lSfdE525onfM2NwVi6eq0FNoNmnXWttMQ+KuV6HezdtxpkLqWuECW4neSj7ccxg=
X-Google-Smtp-Source: AGHT+IFUpB5zuI8t9K8hEoPJEuLqZohLqTFlZlHMiePzlQBx1lasT/a4UFESCgWDN3fHpPLgFhHAvw==
X-Received: by 2002:adf:fa45:0:b0:35f:b45:97b4 with SMTP id
 ffacd0b85a97d-35f0b45b1c7mr7768875f8f.20.1718030328726; 
 Mon, 10 Jun 2024 07:38:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42183c08f49sm50126885e9.6.2024.06.10.07.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 07:38:47 -0700 (PDT)
Message-ID: <f4812da5-8c1c-454b-b571-35bba37b8098@linaro.org>
Date: Mon, 10 Jun 2024 16:38:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tests/qtest/libqtest: add qtest_has_cpu() api
To: Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Reviewed-by_=3A_Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org
References: <20240610132123.6381-1-anisinha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240610132123.6381-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Ani,

On 10/6/24 15:21, Ani Sinha wrote:
> Added a new test api qtest_has_cpu() in order to check availability of some
> cpu models in the current QEMU binary. The specific architecture of the QEMU
> binary is selected using the QTEST_QEMU_BINARY environment variable. This api
> would be useful to run tests against some older cpu models after checking if
> QEMU actually supported these models.
> 
> CC: thuth@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/libqtest.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>   tests/qtest/libqtest.h |  8 ++++
>   2 files changed, 91 insertions(+)

Since "CPU" commonly refers to a CPU state, I suggest renaming as:

> +struct CpuInfo {

CpuModel

> +static struct CpuInfo *qtest_get_cpus(void)

qtest_get_cpu_models()

> +bool qtest_has_cpu(const char *cpu)

qtest_has_cpu_model()

Regards,

Phil.

