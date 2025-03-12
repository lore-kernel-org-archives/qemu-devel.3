Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B30C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMyC-0007zB-8X; Wed, 12 Mar 2025 10:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsMxu-0007nP-Nv
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:21:48 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsMxt-0002cp-1K
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:21:46 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so412946666b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741789303; x=1742394103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NYzTjC7R17kJDAJ8n8JeL+/IDeVGC3Hb9zPxDhRy2Mg=;
 b=naDYfx6m+zyxU1Vt+tPT3190LZVcua4Yp2bHtlr3o8oDAdtXO9ezWxbkWTXoEbPnAC
 xrGNcE5DiZYdG4UcMMEMqDBk0X4Q61SZRYMnQQ7pvfX6JgFQo6XyPLEEeR4i/Q9qYp3P
 jbT+pfrV+lSx/plZJYenMBgUX3c0YNciDtlVeZ4DVRrwi6FIH+kK+Lk8AKxvHvJoV1L6
 twckeVBo4wMRew863cXy8d5jVxmGU3AtUk2pwVLYORzRA998pRvbWGWm3m/BRgzis1OV
 B8yE6QRc9GE66I91mo3sO0fgabz9WPZD5lbXS5Me0DGTlFwyaGCTCVC6SiJNPMP0jTs6
 DhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741789303; x=1742394103;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NYzTjC7R17kJDAJ8n8JeL+/IDeVGC3Hb9zPxDhRy2Mg=;
 b=vfJHp2DCu9aUtOLIF37dpAhDJM2JD5qxtfeIXj51urQyi4xo2OIz6bEO0lzV/ETmb7
 TXBXP4orfvVr0YGwX0CWT7zmR59qX8N9fGMwfCuiVbRTGGTAiOHs9sOib7L+snqCMgWl
 I2dezAEqWEyC42VDH3G5nbSryX74BwT+DQslOfz5BvmhEbwrfLsxbWLK8/3Fwx/Lv9sF
 xNPti8EqEYbiaAdwWlxc75EkLi0iahUi53v0I8UQGi/i1cE5oBCnevBkQaUZkst5s9nM
 hDHzIdcJ+t5b8f4eJuEqU0/mliPuP0bBDhHJ5PozSynV9+gqRHxZS6UlUeaTJhSncaZJ
 BQ5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLluSzHd29eRpqzbOYIuWpGbTYd4k04gYYRjW2VBILf2Idg+547spotEwaRPAm4AvJkNEOtkRXWpAl@nongnu.org
X-Gm-Message-State: AOJu0Yya1PJ3/rgZZS+WxTiSNgQPTXClj/AcrdEWPLEGNmXSSTZUlQQL
 BqT7jCMDSvcdTVPUZM5j6PVkxvoSQGHEA9LqmyQ1QV7Rd75sPF6gamttc2+pNh2H3YLRT0pJmNX
 uOG0=
X-Gm-Gg: ASbGncvUJDD6yDU4quIWLMyeNX1dfgkgS6c92socObhEz9lsJatw12FRXYPz6W4M8q/
 Tj8RIOMDmzzpyz7raFXgc8Ik8eOe/2vuWzS29PArQdCL3Wlu6BaTvAWtCeINTtSgGjKfq2+1T0c
 OLlowhGNVCPdkFMSFFOxbgxMCZiw8TKRtc217YryQQOFdXgq8gp6wyvKjAtR0M4Sl/tB3SXrW07
 6sWWcVEpdPa76FYsoPVnifgqvtL8iMuKQW+Nai1OCL6jh2RDu6kra8vn+Oy+U2ZbgbFTN7sjFz3
 nrfDcqHbgxa26IbgubC5QF8yyDjUOrcbybH+Q1OAqx/Wm8uRnZXR1gL6K3aRHQQ6hVKVwBh7w8u
 ok5GOUqMQ
X-Google-Smtp-Source: AGHT+IHzdc14fpIOW2Akf52kWsLT+MIFNg73Mt47RoMI4a6JyFiL6gncPaufswdVui5KwikKxL6LXA==
X-Received: by 2002:a05:600c:5493:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-43d01be65ebmr85541175e9.13.1741788813661; 
 Wed, 12 Mar 2025 07:13:33 -0700 (PDT)
Received: from [10.223.46.213] (216.165.185.81.rev.sfr.net. [81.185.165.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfe61sm21499603f8f.38.2025.03.12.07.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 07:13:33 -0700 (PDT)
Message-ID: <6856a17d-7028-4fb1-adb8-ddefa234fb63@linaro.org>
Date: Wed, 12 Mar 2025 15:13:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] target/i386: Replace MO_TE -> MO_LE
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20250312103818.370-1-philmd@linaro.org>
 <f2a9e4e3-79b9-478c-91a0-e8273d056296@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f2a9e4e3-79b9-478c-91a0-e8273d056296@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 12/3/25 13:52, Richard Henderson wrote:
> On 3/12/25 03:38, Philippe Mathieu-Daudé wrote:
>> The x86 architecture is only implemented as little-endian.
>> The MO_TE definition always expands to MO_LE.
>>
>> Replace:
>>   - MO_TEUQ -> MO_LE | MO_UQ
>>   - MO_TE   -> MO_LE
>>
>> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>> ---
>>   target/i386/tcg/emit.c.inc | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Is there a reason not to use MO_LEUQ?

No, I'll respin using it.

>  Anyway,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

