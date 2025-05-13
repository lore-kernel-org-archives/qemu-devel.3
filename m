Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E21DC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEnXV-0003XS-4B; Tue, 13 May 2025 07:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEnXT-0003X0-3z
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:11:11 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEnXR-0006HO-F8
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:11:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a0b9c371d8so4577621f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 04:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747134667; x=1747739467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uPizfffkU8JzMmZu7DY8z1FV+eTyhK/hMoi/gn9xyyc=;
 b=ryTV+ANPOoUaZyz9pZY6rSYK3SaG0D/6c0YfRZUgqs+i5tIWace96NORK16oZtHrNX
 +7PDoZd+gZL6K2oZyncF//z+eqRbCYwoVFnZN7K7qJeMcq3zLYuPQJgytHcqxsMoLSIi
 T9JxS5aGk9gS2wXW7qIAaWkHOtJy3Aw1IMNeD5GulgpsV+Dibtozyqy7eI9RMlLfcTc1
 4lcHULtYSDVU/jGhU33jUDGEF5fPxoISu2T56d3yWa8scw8BAQ8t/kIHIvx5ACsxvhix
 b8dE2HT9iYtQDpPiYkQGbnBbwanxCCT639XXINCN/vGdRaEy3GdNskYc0rl5Vsw19oNQ
 cXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747134667; x=1747739467;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uPizfffkU8JzMmZu7DY8z1FV+eTyhK/hMoi/gn9xyyc=;
 b=G4YMR6JqBbt7cGf+FWFBt+IIJQDbBM10wh2GDm+BdgcE7qV2RZJQ8dhVHi9okeb2zx
 TM5IrXUbAMytcvunxslA6zkCoJid1OQ4N1JQBl8g1cGU6JDwbvqVz9gCGMPDIJ+SJ8SN
 Edsk6xMsirz875cEpt+4S/RCVmuUoEDJNIEIx1LNlVMkl5Wio/pY/P3a9t1wyaZaTKtn
 1HfeR+T50Cp1oTc2brMmTF/xvGbSG66VtcUqfU13AhwHYSy0uocQh3ZC/zgKG+Yns5gV
 by4xR4Axzl5LCgYpQV1xlb8bC49JtY/K+NMT9UODOBWD/kj589CtJYJ6lV7NKGhxFB7M
 Mv4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/UWtINPwpUQ4eYvWTG87rsbFM+EZ7wSQ+uzK7ebr+1rK3UFCKPYXT9en34A3xTu9xZpsD8QLNXtf3@nongnu.org
X-Gm-Message-State: AOJu0YwgoY8x8SG5TlCIxV6hagZQ4SbRg3OCNOg1vgmlLGC6BdgqAUEJ
 mJgChozVmTMdU2Pjn/a+KwYGH4xAfUZNRCqyr8KjmIZv4p16+m3YsoLJ4xDv16hgNaQw8V+kG6a
 fVWAEY855
X-Gm-Gg: ASbGncvreoA/KpsAZGpd0Ug1nslW6vSV8NPetBM7V/j6NAchV0wKafGX65MdAZtYqNf
 RIN6imZO3gB7tk/RF0Xuef5RpwJjXImsfRW8FWdYwodo60cOZuUIdA4Nv2RV13Zaolb9AKyD75y
 Cz6Z/yYpAFLTR6r7TfBcXuNfPIRDHbOaen3RvvfcD95ztMVTxASgajD2rQgUVKCIa9U8mjQql/P
 ktrjV4OVtmKX2Y4aDtXi3qF/akcHz28zR3dG1wO2HAxP/bPFT4HUzA6jfcSIz90Aiy+Bh6J3npF
 w8LO4k/bxyj91154kucmDSl5iZPPAQHGpsBYBx7i3Lyl2h7WeitoxvExdFJrCKkwgiBjU0I4RKb
 dRqeuv2DDtJGK
X-Google-Smtp-Source: AGHT+IEY6yJEWVtK2PgZ/g2xPgF+cVhdQLtZgGxTJGkH+w/0DpUDtrEtE+wwwas5RpRk5deLPuv78A==
X-Received: by 2002:a05:6000:40dd:b0:3a2:3c51:7c1c with SMTP id
 ffacd0b85a97d-3a23c5180dfmr3615615f8f.50.1747134667112; 
 Tue, 13 May 2025 04:11:07 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c804sm16036945f8f.95.2025.05.13.04.11.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 04:11:06 -0700 (PDT)
Message-ID: <caf9f1e2-fe92-48bb-92d9-17e5a5f61476@linaro.org>
Date: Tue, 13 May 2025 12:11:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ui/vnc.c: replace big endian flag with byte order
 value
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250513100819.1179249-1-berrange@redhat.com>
 <20250513100819.1179249-2-berrange@redhat.com>
 <6c9f7141-8b2e-4b58-9ade-134a7289cff6@linaro.org>
Content-Language: en-US
In-Reply-To: <6c9f7141-8b2e-4b58-9ade-134a7289cff6@linaro.org>
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

On 13/5/25 13:08, Philippe Mathieu-Daudé wrote:
> On 13/5/25 12:08, Daniel P. Berrangé wrote:
>> From: Daniel P. Berrangé <berrange@redhat.com>
>>
>> It will make it easier to do certain comparisons in future if we
>> store G_BIG_ENDIAN/G_LITTLE_ENDIAN directly, instead of a boolean
>> flag.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   ui/vnc-enc-tight.c | 2 +-
>>   ui/vnc-enc-zrle.c  | 2 +-
>>   ui/vnc-jobs.c      | 2 +-
>>   ui/vnc.c           | 6 +++---
>>   ui/vnc.h           | 2 +-
>>   5 files changed, 7 insertions(+), 7 deletions(-)
> 
> 
>> diff --git a/ui/vnc.h b/ui/vnc.h
>> index acc53a2cc1..f2a627dcdf 100644
>> --- a/ui/vnc.h
>> +++ b/ui/vnc.h
>> @@ -323,7 +323,7 @@ struct VncState
>>       VncWritePixels *write_pixels;
>>       PixelFormat client_pf;
>>       pixman_format_code_t client_format;
>> -    bool client_be;
>> +    int client_bo; /* G_LITTLE_ENDIAN or G_BIG_ENDIAN */

'bo' = 'big order'?

Maybe 'client_endian' or even 'client_endianness'?

> 
> At least we don't care about G_PDP_ENDIAN ;)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


