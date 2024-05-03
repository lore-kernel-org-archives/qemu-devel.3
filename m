Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D02C10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ucb-0008QS-Tf; Fri, 03 May 2024 11:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uca-0008BE-66
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:14:48 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2ucY-0007E7-4H
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:14:47 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34db9a38755so2907864f8f.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749284; x=1715354084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3j0xFl8oKFR8mdSxmKo8qchQMG5/VsIZgpcMfzHX9A0=;
 b=l1PuebJbvyJmYfgJbEuwnbr7J+apZBPRzuTnSTwTxhRwdptCsxO2oGStuXqRvmDV9c
 KEc9YHIPSpStC8OT+YRrwtm471kI+bM7r7j3i14fNtIJA3BqzYd1nJurFZH8eGbzj6TI
 0rYaytlXHZ/6IqbzVsTmX454kS32qSZD4aUJF++wTRvV4dwG/wCFG4ceXdhjkoKGamw0
 53CC2e0pjbDKD5cHVuryD4g8yhSguYq7IcTpF47SBoRDsYRM9wrEA+5/ddeADaiBHP7R
 wsdU5PEJN2LL6KJKarxTQKMCJ1FrWOSINokRraJcGb1tcAp3yvJYWgw+ymUUfb1aB/bG
 v7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749284; x=1715354084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3j0xFl8oKFR8mdSxmKo8qchQMG5/VsIZgpcMfzHX9A0=;
 b=s7FQ6VKf0k/asENObiBczPlwq6o/AirfzKL6aFdOngkTRj83th0Ab6lyUoVrtH8AZ7
 XR+1ZXdq0plN1Dm4NbiqnSCi3TEYMSyBLIBriYwqL/rmeFZyktPrF7pj1zSJnsJa+Pel
 FtKdKfL9SxTuLQD3B/Z2VVSOwm8Yio9bc7scNwJck4VVIbBlOrES4g9FvbUysvWSfpy8
 LuKvGpgE3hUD/uwH/Jt/wmjPyxxj7YZOjmilLxMlcZq3Hs+TF4oZD7wqH5gc+6KPAyoy
 IQkoGK0aG/Lrphm/UUl3fCNUnsuxDiyOUKDn7nzYWp+b4JNphUrrEUMD7fiPuaEkPb9Q
 Bf5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCURLIT5gaJbXIS1pIT+V3P0wHpbm4wcx9rQAUJb9y/whgfzRgyD8F2EsG7HIXnHjGmDok/WUL3kg+qczuUyH0gb0DFXf/g=
X-Gm-Message-State: AOJu0Yz7NNdxfOvsM0Xd2T+7TjYi5252Iz3xP9j3yiUFtylcB4l5JtgC
 H13EvgVxD9jb9P68hm5Onr05adEG7ZRsDztfCQoDMNS8QdZaLo5uwqLUjTylDX6BiYluZGtqz+g
 G
X-Google-Smtp-Source: AGHT+IEH4Z2Uzw+s7OUolJ0HOAVQh2CYKez0KX8mROomAgnAhU7hEJqg45Ai0f6LohJ0qP4DEoVr2Q==
X-Received: by 2002:adf:ef0d:0:b0:34c:6382:290c with SMTP id
 e13-20020adfef0d000000b0034c6382290cmr2878647wro.39.1714749284368; 
 Fri, 03 May 2024 08:14:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a5d4988000000b0034cceee9051sm3965883wrq.105.2024.05.03.08.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 08:14:43 -0700 (PDT)
Message-ID: <bd3d819b-2bf1-4451-8f34-75385b8b342a@linaro.org>
Date: Fri, 3 May 2024 17:14:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: ppc: disable sPAPR code if CONFIG_PSERIES is disabled
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240503134918.232633-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240503134918.232633-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 3/5/24 15:49, Paolo Bonzini wrote:
> target/ppc/kvm.c calls out to code in hw/ppc/spapr*.c; that code is
> not present and fails to link if CONFIG_PSERIES is not enabled.
> Adjust kvm.c to depend on CONFIG_PSERIES instead of TARGET_PPC64,
> and compile out anything that requires cap_papr, because only
> the pseries machine will call kvmppc_set_papr().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/ppc/kvm.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


