Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3762C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 20:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vifFl-0008D1-SK; Wed, 21 Jan 2026 15:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vifFj-00086A-Pt
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 15:56:35 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vifFi-00069S-5l
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 15:56:35 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43596062728so898997f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769028992; x=1769633792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lSA15z/Nl5qWYFsmnzBm+hk2glG8fJOLNEnjanNuSIs=;
 b=uCfRkc+/f9aGkNpJyiDF774Lzq302yJh3DianyjhU/5lw2/+chQIyXY0zOLTByAMKk
 FwB0wfWWKy0u/CIbgPLQo0QJFot5E5A/aHk1r5Nnfvo6AQ6aMP87rjBFJzZQcioo10AS
 KryrsUeqCXTX0CtRMU7Mp7cpB9QdkR6UbRoFFLKRleprB99+x9LLwhTlMoQ2gICxzcs0
 SE2d/A8uaufz1iSMf9UEyt/iE3LZok1VGPpHUJTPMnsOkOko5n2Rigf1uNrX87WTi537
 +XD8FJT0NUoXg+VSgONN42xekxYt7oU7AJn3vQawToaEB/TfkmWtzy2av+D0bKfL60o8
 E3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769028992; x=1769633792;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lSA15z/Nl5qWYFsmnzBm+hk2glG8fJOLNEnjanNuSIs=;
 b=sMA9xgmC7kD0skQ/qY4neYfqUWu6ADXz+YS3aUaooksKryHceMOloMQrTWRMORuoIA
 5MRhLcsWeWd6Ie7kwCKicYeqyeyBil6w0uX/MhJoGWa/zmsC20u03NnkgAVhc2gZH2s3
 SK4xV+7tYSUnHTyBwZ6o/8vg7ftVrRAX62xIkz9LUpIFscHCcXnTlYxYDRM/3tPgeLZn
 JvzBFkCUs8JiOYWOHsUE4yVk5bVqjCY91OqOUDGVYd+v3km8PozNsh/oSR2cN0x8qFwf
 HfCkgG4DwjQfEsYuySGL3XjOi5VUKCmCG6zslkPBdFH7HU0+Cvsed1y/49MFd3gBed2b
 IbtQ==
X-Gm-Message-State: AOJu0YxtJvNdWHwPYxddLO4aZEGw8W71U2am4JRN+ahN/JAY5yTgCqz/
 gR+ieSRLqNJjOH22jcqNTpPM/VNZRjbufy1GU4MuCBBbZZCn4C3Jw4seZVsSM0Ds4LtXiIYjBZZ
 om9XdNKY=
X-Gm-Gg: AZuq6aKoiH5tmvA+Ck1HQojTiyimu6cUHn2ZLIZaCvbWVwHDq3T9sl7SLZxAQ0gxI9Y
 xtHgclcS2erzYSz4ib/GpayHigDeyiwKGpQKoalYbHsKiKt/7jjy8T4IQXHioS9RHR1NdQqPO9x
 FV8pJWIgsvnaZq8u+F6GIOP8f9ifbaU/aaiflHVCTAuw2QmpDwTTtPfjow1MLFhqEa9p8QTnEfJ
 RxuhP4vn850XNXdL9GK0RC58CTdV6TsoyQdHmf4FwktBt2KrcNrdZ0YVNJtXnsxI9kaT80yZ+NI
 c4vUbZweDAEAtdCgsTyTa2Hrhe18TtbjUlh5RmYSkhvbaxIM4ZZqyiltd6yQvAJs4M62TNCYriM
 y8Te1LSPb0UsVHu0ms1/xB/BoGSfNlzAT1biUZ9dVxERd2/x0RUaKo26rJW61+8Fp2pp3FOvs5e
 OuKdlMJT3b2r5ejQan5OPC1yAyPJfV4WKkl+WQlKZpD2QtzTFAciYH7WZhkmJjOWZU
X-Received: by 2002:a05:6000:2681:b0:430:f2ee:b21f with SMTP id
 ffacd0b85a97d-435a5f8428fmr1397158f8f.22.1769028991920; 
 Wed, 21 Jan 2026 12:56:31 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921f6esm38889773f8f.4.2026.01.21.12.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 12:56:31 -0800 (PST)
Message-ID: <7e1cf239-64d8-416e-bc1f-5b078dafc858@linaro.org>
Date: Wed, 21 Jan 2026 21:56:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/18] system/memory: Clean ups around
 address_space_ldst() endian variants
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/1/26 20:34, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (18):
>    bswap: Include missing 'qemu/bswap.h' header
>    bswap: Use 'qemu/bswap.h' instead of 'qemu/host-utils.h'
>    bswap: Remove unnecessary 'qemu/bswap.h'
>    system/memory: Introduce ldm_p() and stm_p() load/store helpers
>    system/memory: Define address_space_ldst[W] endian variants via
>      template
>    system/memory: Define address_space_ldst[L] endian variants via
>      template
>    system/memory: Define address_space_ldst[Q] endian variants via
>      template
>    system/memory: Factor address_space_ldst[M]_internal() helper out
>    system/memory: Pass device_endian argument as MemOp bit
>    system/memory: Use ldm_p() and stm_p() helpers
>    system/memory: Directly call address_space_ldst[M]_internal() helper
>    system: Allow restricting the legacy ld/st_phys() 'native-endian' API
>    system: Allow restricting legacy address_space_ldst() native-endian
>      API
>    system: Allow restricting the legacy cpu_ld/st() 'native-endian' API
>    system: Allow restricting the legacy translator_ld() 'native-endian'
>      API
>    system: Allow restricting the legacy tswap() 'native-endian' API
>    system: Allow restricting the legacy MO_TE* 'native-endian'
>      definitions
>    system: Allow restricting the legacy DEVICE_NATIVE_ENDIAN definition

Series queued, thanks.

