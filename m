Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198CBD68BCB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBz4R-00032i-TP; Fri, 15 Nov 2024 11:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBz4Q-00030Y-Dq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:21:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBz4O-00075G-Tq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731687672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5d4ZW/1khEORUqNcZh+/l4+qJk78QD1wOJBCDuAiY50=;
 b=W6c8lbIm1Rq7PmX7CT1SwnV+EWMrAnmmSgrbotON8yEjokHEBWrubFptwavaNjKPlwF95K
 R8WR6untXO9CR8sSw0eli2Yso+PcXau1HJoTMNG6A/bVnBZZxnurGK7M/FXzWf4aaxm36Q
 UknCasUsz5bU+TZbXJGp/vH46mvXyKU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-7ARoP2apNoa-ID6VKZx2-A-1; Fri, 15 Nov 2024 11:21:10 -0500
X-MC-Unique: 7ARoP2apNoa-ID6VKZx2-A-1
X-Mimecast-MFC-AGG-ID: 7ARoP2apNoa-ID6VKZx2-A
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539fb5677c9so2179673e87.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731687669; x=1732292469;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5d4ZW/1khEORUqNcZh+/l4+qJk78QD1wOJBCDuAiY50=;
 b=ozcH9d5Bb8NEcstBewCZ4CvaMWcV2LW80fN3G1RndPh8AiWVRy+1AHN5DyFc7CJLwn
 g2xHeEZc5bLw33LywNXmAAMxpmgrO7qq440lvDUkQgiOU6TScdfHgEyVza/Bpt8tAnT+
 yBiJtTWYEeRshbx7I5MDM8bIxvoYuQAQRGPQQM8CsIe+j/kyrPUW7fKlQK/58dKiyckx
 u65sHHB4bvyHw+6AwnHgfAZiDcDJpPHZhluq5sZSmzeODGltnDtJb0k8mWpW6/BGyOC0
 uyC2OVKemeXLbNMnLXNH/wE+2UInlo6jgm2lKyi6sbyII/CVHFD/dq5UhQfhuKf7d48R
 kgLw==
X-Gm-Message-State: AOJu0YyQZVqGwuNwgIsEZ09ZjKSAuxguui+Sdfcj+Kp08tEcpYu9Amcu
 zMvwPHsGeJQGQgFlzAqD6LgvPsNPs9FUcXd+CCJSSB5Qq533L1AnYp5tBdMbLaRfhMKfuWyNrIY
 BE8R1YoedYqePt0uQlkxz2IgJP6Z5UHcv66/86ppjCPC0ERrG1tEP
X-Received: by 2002:a05:6512:b83:b0:539:f9b9:e6d2 with SMTP id
 2adb3069b0e04-53dab3b126amr2110260e87.35.1731687669299; 
 Fri, 15 Nov 2024 08:21:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFya5HAHYaAOACMYUDbyGMwjdgmYu4HaB64klMuyz1Or6hH8oVR4n6EZazSE/k+5g2QSNaaCg==
X-Received: by 2002:a05:6512:b83:b0:539:f9b9:e6d2 with SMTP id
 2adb3069b0e04-53dab3b126amr2110237e87.35.1731687668902; 
 Fri, 15 Nov 2024 08:21:08 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432dac1fbf9sm59381275e9.41.2024.11.15.08.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 08:21:08 -0800 (PST)
Message-ID: <483152fa-78a1-4e65-bec3-e7fb31b96929@redhat.com>
Date: Fri, 15 Nov 2024 17:21:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] hw/core/cpu: Pass CPUArchState to set/get_pc()
 handlers
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-9-philmd@linaro.org>
 <CAFEAcA8X8zp7oXKjiVOL_uCGdM8r00jW6S1efkm-M6f4fEuGdg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8X8zp7oXKjiVOL_uCGdM8r00jW6S1efkm-M6f4fEuGdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/15/24 16:54, Peter Maydell wrote:
> On Fri, 15 Nov 2024 at 15:22, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> CPUClass set_pc() and get_pc() handlers are target specific.
>> Rather than passing a generic CPUState and forcing QOM casts,
>> we can directly pass the target CPUArchState, simplifying.
> 
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index db8a6fbc6e..70f5f8c3bf 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -160,8 +160,8 @@ struct CPUClass {
>>       int64_t (*get_arch_id)(CPUState *cpu);
>>       bool (*cpu_persistent_status)(CPUState *cpu);
>>       bool (*cpu_enabled_status)(CPUState *cpu);
>> -    void (*set_pc)(CPUState *cpu, vaddr value);
>> -    vaddr (*get_pc)(CPUState *cpu);
>> +    void (*set_pc)(CPUArchState *env, vaddr value);
>> +    vaddr (*get_pc)(CPUArchState *env);
>>       int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
>>       int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
>>       vaddr (*gdb_adjust_breakpoint)(CPUState *cpu, vaddr addr);
> 
> This is effectively the table of methods for the CPUClass
> class. I think that methods on class A should take a pointer to the
> object of that type, not to something else.

Yeah, the diffstat is enticing but I agree.  It's particularly confusing 
because there isn't a single type called CPUArchState*, it's different 
depending on which target/ subdirectory you're compiling. In a 
multi-target binary it'd have to be void*, and then you get back the casts.


Paolo


