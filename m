Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9645C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqX1i-00068r-UI; Fri, 07 Mar 2025 07:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqX1W-000654-D5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:41:56 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqX1S-0006kg-EM
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:41:53 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so913120f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 04:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741351308; x=1741956108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ePKOWhU5xNMVZjnFn4kdCnaARO5o6Jx746CnhEu7hQY=;
 b=YC7ztA5ChVLQtGHikBEv/9kg40Fk8rtKxn9PFZjVhMfsnNMfImUgI0WZ6KTUfbm4JA
 IT/5Ge5HfkJ9eGGE4W3EhUFSGXAmC5YQh+obxBKeLbS144Xx4nJB6xXBBuvbL4sRrOmW
 3uXyFEug9BrIRybk2WnE2L8DCnsMgK42qcIG5fbpnzXOtLv7dpUnfGB5SrkZlUuzxJsN
 eVGZgxYzyWb6y39+IPv0qjBxB6O26SEPxN8VEI6HkuYgKTeysJBwNsHeSePzHt6po9FZ
 qoc2sX+C4FeF+LxLv+7jZOsunM7KK0wirQq4O8sKpoPeh6CsF/9Ba7ZmXK2AgydKKUb1
 bFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741351308; x=1741956108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ePKOWhU5xNMVZjnFn4kdCnaARO5o6Jx746CnhEu7hQY=;
 b=nx4e4cfwd98PmV+3Ga6vcC0/Pr5zuQ0hGvKl9ro9sLO6TWk/S7NpuQjdkGukPjbwY+
 wGfuE4HeFkmAWp8xqUiI+ol0N5dRZOSd82pLpX/262VOLyez2uhVjG1kN2UNY5QMIdJN
 1XR1jk0cNfTd82iiw65rt5a6FnSciqeNkWwnrKA5JABAOijQFkI5f/qImK1YLVhCBxm3
 cY5Q+oY4pephz9fTi/8gFeaQi7lDBwLLlCBqHHeikUZ8zy5DAFuzaNb9w5B3mzIU2qFc
 Z13K5Y8v600Rq0ibR2tXbmwGgBVH2aLqgY+Wz9OX/1VT0BFMN9g3fTyLsm7nZ5J6iJRK
 oAPA==
X-Gm-Message-State: AOJu0YxdyH/ijuPhnH7rDy6zPyqW4lKSxWH01gi0N7NCWKQnx1PSgh0x
 jchX4AW8pfDyqtoUmUaSo0NoH2c2MABjktzAGGffNOmtH9qio8quOBOEQcNERnyq076vJupzbTh
 7KR4=
X-Gm-Gg: ASbGncvr3urVm02RiqfK06yW6jhWviyyaH7GlN4Iu3JB7IbJfai9z6YEF+UBU2RqqTk
 Zj6b7c9Dt2zPeb/VxTd07EPRwEgTYHeD6vTH8hlU+BKqRTFZS+/4A/HrdqIN1jl65L26qKbWdi+
 WRTKIk+tFVAA1d7SamelsTyqRyMkcYpDcQFSJzqEYAxK6ytrGNmT3al94fVo3ixzGKBgdzDZJX3
 M0so4iNlSHRl02/Ya2jkv1itsDk3DlEPlfTlO0PvLEU/nS02PkYMTW7T7/Z29UPcVs4O326D3Mw
 FHSxECa8a/cWXMutJeUcSt7kPvHkgwX2S0/HstUfXM1EIKgJfOmiXhWwxaB/ES7Fq8U8LYv/vGR
 m25tDqFBgGvwY
X-Google-Smtp-Source: AGHT+IEZxOa55+XAdiiZxWBMDlqPJAkdWH4LPRarony5xxWVPSeIuihWtTVCbD4g+RaVE4uS4vzaZA==
X-Received: by 2002:a5d:64e2:0:b0:391:253b:4049 with SMTP id
 ffacd0b85a97d-39132d8c572mr2368646f8f.33.1741351308499; 
 Fri, 07 Mar 2025 04:41:48 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfbb4sm5361644f8f.30.2025.03.07.04.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 04:41:47 -0800 (PST)
Message-ID: <c0b7aa04-6172-4403-808f-b6ad2bc91840@linaro.org>
Date: Fri, 7 Mar 2025 13:41:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/41] hw/acpi/ghes: Make ghes_record_cper_errors() static
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20250305012157.96463-1-philmd@linaro.org>
 <20250305012157.96463-12-philmd@linaro.org> <20250306233632.5b22e382@foz.lan>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250306233632.5b22e382@foz.lan>
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

Hi Mauro,

On 6/3/25 23:36, Mauro Carvalho Chehab wrote:
> Em Wed,  5 Mar 2025 02:21:26 +0100
> Philippe Mathieu-Daudé <philmd@linaro.org> escreveu:
> 
>> From: Gavin Shan <gshan@redhat.com>
>>
>> acpi_ghes_memory_errors() is the only caller, no need to expose
>> the function. Besides, the last 'return' in this function isn't
>> necessary and remove it.
>>
>> No functional changes intended.
> 
> Please revert this patch, as ghes_record_cper_errors() was written
> to be used for error injection. As agreed last year with some ACPI
> maintainers, we ended splitting the error injection series on two parts
> to make easier for people to review it.
> 
> The followup series:
> 
> 	https://lore.kernel.org/qemu-devel/cover.1740903110.git.mchehab+huawei@kernel.org/
> 
> Need this function to be not static, as this will be used by a
> QMP caller.
> 
> The usage itself is on this patch:
> 
> 	https://lore.kernel.org/qemu-devel/6ef8d6a3f42e3347ed6fd3d1fc29ab5ff2a070df.1740903110.git.mchehab+huawei@kernel.org/
> 
> but this one causes conflict since patch 01 of the series.

As of this commit this method isn't used elsewhere in the tree,
so the reversion has to happen in the series using it, if it
eventually lands. Otherwise it is too costly to maintain
incomplete features.

Regards,

Phil.

