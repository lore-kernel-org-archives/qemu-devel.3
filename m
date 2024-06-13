Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D8CC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgGv-0006ee-VD; Thu, 13 Jun 2024 04:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHgGu-0006dt-Qq
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:57:28 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHgGt-0000HK-5m
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:57:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4217a96de38so6592665e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718269045; x=1718873845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O/Oay0j96x/9xQhPy6qZtNnk5WwDamzkfYnPefMdxU4=;
 b=BdFKmTvSWlgp+5Rra3BLrTfiCZfj0m5pcUzMQzBw4EOauTtYIzRoIzL1CA0HR/lSiY
 DtsDjPScJPIJ2q8VNWNuMq43ErACZJt/sJgqK+0yGtTHwzjx+wDhOWjC0I3SO0AUHVf8
 dJe/5tVTxeLWLy4ZdjyNMXDx+/ec7gLc/QvFDnk32rql2MBUPgQ4a0l2KBNJsp8NrFlF
 GcT5gFlOkj1jjUgrgUXDP01pmutHPuJJwOAt6/3q7JI471zsm89qzBDVyKWuCuOk68t6
 zyp9CxbaVroFRe5ki/NzUlf7jiXPB/gFeyykWrMl9naui609OSYriGNXTW+EiWIscM3/
 4EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718269045; x=1718873845;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O/Oay0j96x/9xQhPy6qZtNnk5WwDamzkfYnPefMdxU4=;
 b=fRwJpH+49suo3qXUi25xeyCoe10Wny14XJobEf3EjnYtrlqCcJ2hYuCwzfmM6MVE1J
 aKlm8eP6o/92qTKzngGl2In7hmsi2GAAVO6tj9opfpdSi1NI+fX9lySKrEfmLh4dxbwo
 93vY4tDpoFIP5BwV3ynHfpDzyZr7lbuY3lZsn+4gEqEv8OHZorL4jiZ8ev9HJ3ZrDmhP
 EdlxZotSEijitSNBGUGQ6WpNPkDDM9/8KPijLZ1l7wzLEE2ir7huU4uxIidlljehzhPp
 GrUHXs5IPNsm22xhAeplbR/mIAiPwWqsj98GHlBpCoDNOvEtXgW7fy2e98uDgPe75qV9
 z07Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUACpQHrhXrRbSPSxPgCtCwdPuLhyrXoxXfV05spYxYc7RWRXIVzvFp99TvKDwvreYI65ktVDIgJGblcHUDZl8AL380R2o=
X-Gm-Message-State: AOJu0Yx0Hlb9AcK21FTRcrK4xBS8vmVb0QM9u91QxYxwik868ar0FskP
 2hFUAh5szUMBnd3zhud+yfrvfTPp/6vpcsgB8K7cWfY0z0T4WVHpLWn89vGkUzA=
X-Google-Smtp-Source: AGHT+IHqQKUydYMvnGx+8GuVXjDzbY5BbQSW9D4GkL9kXgAEi3BIQ6dHiOFa9P8ziL+HL52DDW4cpg==
X-Received: by 2002:a05:600c:310a:b0:422:5b78:1c8f with SMTP id
 5b1f17b1804b1-422863a8b77mr33946525e9.8.1718269045561; 
 Thu, 13 Jun 2024 01:57:25 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286fe8fb8sm53929895e9.11.2024.06.13.01.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 01:57:24 -0700 (PDT)
Message-ID: <c4d36875-c70d-4e2c-b3a8-c50459c9db0f@linaro.org>
Date: Thu, 13 Jun 2024 10:57:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] plugins: add time control API
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-9-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240612153508.1532940-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 12/6/24 17:35, Alex Bennée wrote:
> Expose the ability to control time through the plugin API. Only one
> plugin can control time so it has to request control when loaded.
> There are probably more corner cases to catch here.
> 
> From: Alex Bennée <alex.bennee@linaro.org>

Some of your patches include this dubious From: header, maybe strip?

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> [AJB: tweaked user-mode handling]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20240530220610.1245424-6-pierrick.bouvier@linaro.org>
> 
> ---
> plugins/next
>    - make qemu_plugin_update_ns a NOP in user-mode
> ---
>   include/qemu/qemu-plugin.h   | 25 +++++++++++++++++++++++++
>   plugins/api.c                | 35 +++++++++++++++++++++++++++++++++++
>   plugins/qemu-plugins.symbols |  2 ++
>   3 files changed, 62 insertions(+)


