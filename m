Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846EBE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQme-0002Re-5F; Wed, 24 Dec 2025 10:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQks-0001cZ-C5
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:26:27 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQkq-0005JJ-MM
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:26:26 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b7277324054so975023366b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589983; x=1767194783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LAkEwxF9EXdVeAaM6hljt9bGBYpVh3ZyNvESSYDxB7Y=;
 b=xGaLqZfiNZZ6uYlPIMVjYB+w/GU+ZlhUZbYJOsaC+7XRSxe2W6CMjgf1DlfL61aCh3
 2SWkH59hObVK9RG5wrZkINr+Wp3M3g4RF6NWvByZ2JBIyYZV96kTlpPkcWLZWPN3VLUJ
 a4/WKJTSvtYEqywO1zTRdkIW5vx/gYvA4sD0SK+q0hTm2soE90SfwFWrtMuHgK4XdXsO
 v7CkW7dIT/aryW/qHDFMep/h36G0KvwMTIUpQobVVYS2IyFT0Pdi3jzQHFQRZ8iqDWwf
 RdDogAAaxqAisIyEBQOUi7AXa1/3SC14jTD2mx9+CB/hZcbxgQL69WffKxDTcGXW9/ad
 zR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589983; x=1767194783;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LAkEwxF9EXdVeAaM6hljt9bGBYpVh3ZyNvESSYDxB7Y=;
 b=hwKsZQwdgayZP+pklAopneL70+xVuaKKKAua6zs1LFvkGihtzuXckH3dFYDuhzeu18
 jAOq5zqLR+usHPbm6BdSOwEEXyXnGwCHJKB59/FDc4ycTTDlzXyDnDi8JuSdO5kUv8nV
 PuA0U1gZIS/VfgOkW1gBxqZen8lvIQ0YcXFwjbGCQ/cHD1Kx/CoDI2ZwQrl9+0jgDhgg
 cxn6xjWIINBf0XGQIsFltYixN0gPMzox162DBwCdfAfl9I2E1iYnZiH+nfRi34BhZBrm
 F2KN8ITq5dXBkA4JeMpSNqG8xAhipTnmW5Mamlvo53WH+stcrHzwgSORF179g3ZLa+bQ
 cbxA==
X-Gm-Message-State: AOJu0Yz0OsM4I6VbTMF/fy0/1lvGk0RwKNxds3Z9yrrbX7AmXjp0VZaF
 yMDDVxrKzs27XE65XyxbHNzScZ3KdnhkdJw5vJQGknzs5IxB6XPonDp5K9fKIdS8kmw=
X-Gm-Gg: AY/fxX4jJs+JPQWSDQ3wgBUmXJInD2H6Gfs1ON6i/tkuOZEbo9mnxnfjjruQSMgZy+W
 YPx5Y4wMhH3nc9DitRsCx4XwCyXORo40p3n2yuFLkRWqyodDjAx9WgvpYQmGERMTnDwFLFkad4H
 Yd26BKo+YkUigDYPgEb45Y2e16G++XXk3r+c+3aM00pkcGxJrEm3zFldH2lH6d5lD28esZ9D2CA
 Cb1h70VsFH4tMZjNJGOne0nG8z4szR8it9Qpa0xWUkw23+Vlv49L/rgMKnWPTH0oWuR+Cv0hElG
 A3E1v/jNA4lAPWyHBf0JT7zEqPn9U45XkWKL+puRu1G4LiekzLhUPJcjj97TL878ZejUydawx4E
 KLrlj+9JYllX5gT5RBI5SPKCDvwy4ExmKzj4JL3eeZIdCK8ASHFhDwZeIxQAe19yh1tsHxFvmqH
 zr5aY6fALJRiva3loKyHu3tBngUtcq9HniSm27zmuNjW6y
X-Google-Smtp-Source: AGHT+IE6125JyIZh6r1sgR6SfwqAIWlZuKjKolNgKHBla6eHSFdlnIQmgVKATqubQx0nbDTGiojN/A==
X-Received: by 2002:a17:907:2d24:b0:b83:15cb:d4cf with SMTP id
 a640c23a62f3a-b8315cc014cmr156729466b.29.1766589983083; 
 Wed, 24 Dec 2025 07:26:23 -0800 (PST)
Received: from [10.156.6.66] (188.171.88.92.rev.sfr.net. [92.88.171.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de10dfsm1746123566b.36.2025.12.24.07.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Dec 2025 07:26:22 -0800 (PST)
Message-ID: <e36cb7e3-799e-4a3c-89c6-4b5242f57344@linaro.org>
Date: Wed, 24 Dec 2025 16:26:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] monitor/hmp: Merge hmp-cmds-target.c within hmp-cmds.c
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20251224133949.85136-1-philmd@linaro.org>
 <20251224133949.85136-7-philmd@linaro.org>
 <CAAjaMXauqeKDJ84LowukGMHcDy+kyB8Y_pDoBCr_kSNyguSRPA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAjaMXauqeKDJ84LowukGMHcDy+kyB8Y_pDoBCr_kSNyguSRPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 24/12/25 15:24, Manos Pitsidianakis wrote:
> On Wed, Dec 24, 2025 at 3:40 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> hmp-cmds-target.c is no more target specific, move its code
>> in hmp-cmds.c, which is built once for all system binaries.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   monitor/hmp-cmds-target.c | 383 --------------------------------------
>>   monitor/hmp-cmds.c        | 354 +++++++++++++++++++++++++++++++++++
>>   monitor/meson.build       |   2 +-
>>   3 files changed, 355 insertions(+), 384 deletions(-)
>>   delete mode 100644 monitor/hmp-cmds-target.c


>> diff --git a/monitor/meson.build b/monitor/meson.build
>> index a71523a1ce8..763fcaba6c5 100644
>> --- a/monitor/meson.build
>> +++ b/monitor/meson.build
>> @@ -9,4 +9,4 @@ system_ss.add(files(
>>   system_ss.add([spice_headers, files('qmp-cmds.c')])
>>
>>   specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
>> -               if_true: [files( 'hmp-cmds-target.c', 'hmp-target.c'), spice])
>> +  if_true: [files('hmp-target.c'), spice])
> 
> Nit: Indentation?

We usually don't use tabs in meson.build files, and indent as 2 spaces,
but I couldn't find any documented style enforcement :/

Paolo, Marc-André, any preference?

> 
> Otherwise
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks!

