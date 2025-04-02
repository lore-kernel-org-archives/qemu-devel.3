Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C318DC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 06:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzrqx-0003Ei-Qw; Wed, 02 Apr 2025 02:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tzrqu-0003E2-Tt
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 02:45:32 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tzrqt-0002Rp-0T
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 02:45:32 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224171d6826so102855535ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743576329; x=1744181129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=66le4xdRwCwExmc00i+ptfK0z39q5TMVnh7p70vuVso=;
 b=HVkJp6iQwxB7Gn1Evn1RSl+8i9oAVq5U/OtHw2SNLPyzr5D6hc0NwEsJYRVbgJUX6U
 skhUY2wgTChCeiMqd8bgNXhbXsAKgE2WYMje1FhyUZrMV0j7Tw3gHWEKm6Je+a93mB38
 cDMNVXoo49KVyiHAyvSfwYEpdPup8V7vN8sCJwDjCScaScaQgysp7ZT1fwefazsY26Wn
 yX3t0ENBPB+u3KQxTAziGSiaVcjJmSL4ig7zf4iHz2fiGlnsnY/jBCrmlsS2cB6XJ5JF
 /cS37w9hnuqrM53JDurhik1uqfIULA4n2+Gi/ySv5QQcIjsaGJpx40e/88pvYt7kicdS
 WRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743576329; x=1744181129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=66le4xdRwCwExmc00i+ptfK0z39q5TMVnh7p70vuVso=;
 b=o191OZEEUAdJ602jStlBkOJMJt85fS6DQL2bm4fazJRFyjjTBAL2tALjwMl0v9XkCb
 MhkRY/Te2CLNwO6+k5qpLH7X3ojoDJqz+wrqOCydrtfXk0/DVNlQrGo7WZHyI7Qou4bj
 IhSaygU/uWLfU9XYmoQS97TS2Ist53yjpBgNPX9+RlX2lxDY/wzjYE9MnnhDW0o5DDbc
 h930cqmKB58D1GLvfSFnrjZI0F1RGBYB6cWOG0ls91OqIiv5TsH4LlYKjTIKrZSSk2rt
 uI4XvD/TDb9HJcSmOrzfTBQTk+NoLUw9/pfHUypvBjK0qTmVglRERnis2b1pRRe0/1gH
 y3ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUds+o1Iubm23cUexzJ+nVzNZUqWCX4ReAaQtzDKp4PcN8QVveRHUKKYFyuOLxlSP4e56SgHri+Rxg6@nongnu.org
X-Gm-Message-State: AOJu0Yye0Y4eFIBp0MloV8XccpTJltdodTcNdzWHJQrRFMYJyctTv0AN
 a9JEabDcKTL9/pSfzyY/8i5tNepZIbVGl3ATdyVZkF6Tj01+fFWQs/niW6zuqKVvLGckDudNUiB
 A
X-Gm-Gg: ASbGncvDBLwy49BONqQoJNhLIEplajNwzHzfaSABnLRXHw1Ia3YZQN1dNrkz8zta7Wz
 0XSM0pL+oePsZlXtcpR05mzixXqGVcEHGsONohYSu95E2YMQHIK5IYMzsG+cXv+uGi94QY268/3
 Jv2bCfPtNSwCQ94hp6z7bHRp1jbe566P+EJV8n5T3P9YY5R55lSi0GMA+xeiVEvhQwgNCv32S20
 cfRizpe93DvohrqMCSaU0f/yyF5lJz1D4WNMGVCnldCQpUF9GeLHQpH60up18TuDnP4RIN/hd3s
 NTZaZDxOP7OVQfPnJjUkpgKC71HPIAaCtM56WP5+sqQhxNmRk2+NhjgY
X-Google-Smtp-Source: AGHT+IGWIIiPEtMmuMGcsq/JXtaCGksPCPmZl7932xTnw88h1313qv5TMCUJYakY+imWNuBCM1mgiw==
X-Received: by 2002:a05:6a20:9e49:b0:1f5:63f9:9eb4 with SMTP id
 adf61e73a8af0-2009f794eddmr28096469637.35.1743576329448; 
 Tue, 01 Apr 2025 23:45:29 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.46])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739710cd08dsm10090135b3a.160.2025.04.01.23.45.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 23:45:29 -0700 (PDT)
Message-ID: <82110326-644a-4b66-a8ea-ade303cfd467@linaro.org>
Date: Wed, 2 Apr 2025 03:45:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 4/5] hw/arm/virt-acpi: Do not advertise disabled
 GIC ITS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
 <20250331221239.87150-5-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250331221239.87150-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

Hi Phil,

On 3/31/25 19:12, Philippe Mathieu-Daudé wrote:
> GIC ITS can be disabled at runtime using '-M its=off',
> which sets VirtMachineState::its = false. Check this
> field to avoid advertising the ITS in the MADT table.
> 
> Reported-by: Udo Steinberg <udo@hypervisor.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2886
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt-acpi-build.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index fdc08b40883..b26f0ac8585 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -212,7 +212,7 @@ static bool its_enabled(VirtMachineState *vms)
>   {
>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>   
> -    return its_class_name() && !vmc->no_its;
> +    return its_class_name() && !vmc->no_its && vms->its;
>   }

Aside its_class_name() apparently being tautologic (please double check it):

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

