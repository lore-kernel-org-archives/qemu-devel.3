Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3210BCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RSU-0007xU-Mq; Thu, 16 Oct 2025 13:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RSS-0007xH-K4
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:08:08 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RSK-0003DG-UP
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:08:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7800ff158d5so976549b3a.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760634476; x=1761239276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mzbO6qxXTSLN2VfEZ7sgVqVzDYN015Du6ppqHnVvYSo=;
 b=DRXYJhLts6pQgIWra1GSFIW5VaTQItoQM3/7fG0FXbPtENJe+YjVPS6f/Nf5tdwrwl
 Ipv4eb8Nnb7vmKvmdiC2hsrV22+fwWCctjRgPU4EcS8d15vPrxafkHlB95JEgKUUL+/F
 CHK2Mbtm6SnPBG2/S9W0m4CfHXC8fWDBcGmWt0oq7S75q/aWZQgxe/b0om5SYuC2oqZs
 3iehZYOTyzPuAlX97fsLNCFsvB1zn0XLQiIgpVvAwFbUsYy+29JTcGO5ng9y4clySpNk
 8xf70YW/D/nBPlvoGF+IVpkTzTNOlMKGBkwV0VLaFKf4ZzTsXiL5x3P3vCYHbWviMHA+
 +crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760634476; x=1761239276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mzbO6qxXTSLN2VfEZ7sgVqVzDYN015Du6ppqHnVvYSo=;
 b=ZpjynECdHhGzfuX6yiU/0X0tvf+L/o+7zXaIeNGOMrlLGz97ABFSmXtzvUg2TX1L/H
 uP52Uz63KG/7W/BjcCBFdmeRRky6xaLaN7f7nvJ+5x5qm9cB9X1G/Jr4GmEkcGSVyGTS
 VdNkdTdU1mLjGDMvS77jEr1qak2v4+aPiYAu06zr8OYmEjyH8zBNSXWtKGY3Ps7YklCO
 LZ2R9uTLuLRS9Qejs3dxYfOrAahZhkGYvScIm/JHZL3BYJVS0wRBCjltgZ89vqdcihDr
 ykc85GIYUqaeEAGENG7rjZG3GAO+/Ouws4hqg3fc3cqatCQ32gRYmIfe48wfdF/f5FC1
 nPVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiv2tltUJ1NAOKdT+yU/DCW6HJoiCCBspB+dkosC2hw1bONtM5+ltxy+0ufi4JcthdBwTBKBUOJeoD@nongnu.org
X-Gm-Message-State: AOJu0YxrZ6abfrPNuI2UVhFiWU6O1x1BxhGvetuPfLMW93CPsgTHY4Xg
 yEgLU2/8Ht5i2Bt9wEukAqvhE1CNxz3gPGjvTyNA13o6agGEQqnjrdlqQzmrTSTmbBI=
X-Gm-Gg: ASbGncvjxkYaU0CseW92pDPbBCrxGnKcLTUDshuHJDNCpUabI7ND0MjMNUPtRUD+5dI
 7EEoCUfbUk3iaxc0BLD5P/t/jD6NLpX9G+n0Sc0wdg9R0MBw0PU/pVegmZ4xZBlBDwvltCk2mdV
 J1Z+E5cBm2mdjhHlxks+o8sWJFphj+YT9kk4hhYT5wQJ7L15baHhnbs1Vo11/N3DBx6HXpN4R6y
 3eJ7/TQuHGIS0kRzXbiH8VmVISa7fMh0gnaYG38Ih1AQJ2RrygQOhXpDEylhluZ5z++zl0jR2bg
 5FcA5f8A9Lk4xOgu7u0/nsyAzUiBAcUyryS0WVW332eHJZS5VtXPco0YWrJ3b1RGFNNTkjzSCY1
 jwkFw09lS0A+80WgICKoPArgbipPnc0mkgTLAol1mmF3M1SyuYY0ZbeAkbXH3CTQyrHz1A099RG
 P2BER6880u1P0Y6JSGkbdEwsA=
X-Google-Smtp-Source: AGHT+IEz4yyVpPHAHnaSdwY5OhhzkZ+c1o6Qi6CcgXGWF688z8Ud9rib7Lcs7Z3hHBFsvf4idG26UQ==
X-Received: by 2002:a05:6a21:6da1:b0:262:da1c:3bfb with SMTP id
 adf61e73a8af0-334a84854b9mr821530637.7.1760634476213; 
 Thu, 16 Oct 2025 10:07:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a31e443e9sm1825218a12.16.2025.10.16.10.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 10:07:55 -0700 (PDT)
Message-ID: <0d421108-0a63-464d-82de-071ccbc61919@linaro.org>
Date: Thu, 16 Oct 2025 10:07:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/24] target/arm/kvm: add constants for new PSCI
 versions
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Sebastian Ott <sebott@redhat.com>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-2-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251016165520.62532-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 10/16/25 9:54 AM, Mohamed Mediouni wrote:
> From: Sebastian Ott <sebott@redhat.com>
> 
> Add constants for PSCI version 1_2 and 1_3.
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>   target/arm/kvm-consts.h | 2 ++
>   1 file changed, 2 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


