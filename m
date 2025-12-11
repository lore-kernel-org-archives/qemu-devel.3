Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DDDD4335B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 22:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTp33-0007s8-4r; Thu, 11 Dec 2025 17:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTp31-0007pE-Cm
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 17:22:07 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTp2z-0003gZ-Rj
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 17:22:07 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3ec31d2b7f8so262415fac.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 14:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765491724; x=1766096524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CroIQCSrnvcIuJo+zUoaVtD7bfMXjoulnnG9XNpwM3o=;
 b=nLHCCbLqEADaROAJSed8N4CKV+MiYrgGp3Ff5UqlpytgLUuUzuY97YGqqPIaoiKZ8H
 r0RcdJPIBYX4WzujjJ5CqAkRe72yjlYoPvjhzw0ZrPK+7eWHePXBOSXZbKnQawBNUTJL
 zP0gbdwzOcrTBGuN0MyRguI/I0F8+iil02zyHnob7q+C/zDhigYJO7MDlSCaU3ZN2Xpj
 UBen/LhlULtxMFSW/kByLci7+UiBBkhkRN8BDCX8eiktBwGpiJGb8wOMnr1p/HeOsHQH
 HN5yg3q7uZwxI0mrWukvpOc8RWM9jWXbIU8vrGl/qIAZImxCpQP+JaFXfaMJuwaIqc7T
 XJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765491724; x=1766096524;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CroIQCSrnvcIuJo+zUoaVtD7bfMXjoulnnG9XNpwM3o=;
 b=iWXEEzE8N0CpytdNO7RrwQYiESdP7VpCwlgIitxeBLn6svA8TpHzr4F2xNzhj1ywD5
 sAYLwWgWLTz51K30qz+PW1CSdvqMfZI5dQM703S1bHLTQnHx3doQsYgFDDVdXU/XFmZc
 aPGoHECQvHkULdFObcreJlilDSsVYdIPpDRNct0aBfX2/GiEqK38taNs7XsHmXlWk1HW
 wkjmcNm7LP2mplZsBONHjHAXJo6vX5aTBgEbgCnCJrsN0tIpaceDOP2FEGFww8QDJLaF
 LWw0nTvgH82VgnHndutST0Qqazvs3xmrPDaLsB8prKT9XKSD9xh2fISUGFUPeoOqRDOX
 TqYw==
X-Gm-Message-State: AOJu0YzdnOuqQHxCu4ISjx8hYZ2c3gFbRVO9JVXecuMgZ9cXu9Y2gQCB
 5Evbb+ilQLAVBvjmfS5vbAE7w4DAte2mj5EBXlpbiEBnbSYEtXdlkDmGs8Zz+9HWujY=
X-Gm-Gg: AY/fxX57/e+8bXi/RKgMhwLqb3vEu4cpKbvYYc+gE/VMrO4W9evERZc7wUmMY6d5JXZ
 l5SQ2xZgDn8k94cjLVHnQ/C38OGXLBxr9W2WLHDuAByuWporYrpMwYzYzqaz7biukHsZapxubi6
 HV03Wt13Wr8M/esOWbbtt869GUakxoUVwKy8dgTfk7Ru4gZ2cJevbL/mQT/EDPQiP2xH/53yuOw
 7OZ01rjKFerXnQ+KUfoTddHzdIEaI9HwO36LVKy6w7P2E8i2UpRWKXlPlQcEVBP2sd+PC6wdBp/
 c4v+4LGLsnS+mHNr7D8NbmhM5OeYH8HhabcUa8YlCCp/7Ass3zyDZke4RAzHF1S1qjD5259s1d5
 33CYI8qeZTVWjtGGNt6buJzPryZNv38+BP1oATmTVMiAmecVwGtcRGB6hk9wXIuOriJqFdQSEVB
 7IVfraPptA4sV80okQB80NMtY+OI+EoQf1INhR+7BcEtkjGCf+LqKBBn21Ssf8o/TB
X-Google-Smtp-Source: AGHT+IHGlANlgg4bSTa/Cj1VbQFG/pRgfTIoE6MCTCjhg3rGRxEbaykEaLePMvaiRdawYvDujR6vqA==
X-Received: by 2002:a05:6870:219b:b0:3f5:4172:13 with SMTP id
 586e51a60fabf-3f5f8cdcc66mr66799fac.56.1765491724405; 
 Thu, 11 Dec 2025 14:22:04 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d5149058sm2442828fac.18.2025.12.11.14.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 14:22:04 -0800 (PST)
Message-ID: <755aed45-4ebf-4828-817a-ebe6106ea2ad@linaro.org>
Date: Thu, 11 Dec 2025 16:22:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] target/i386/tcg: fix check for invalid VSIB
 instruction
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-2-pbonzini@redhat.com>
 <bbca9504-2b47-4aa0-8cc0-be17b3db85d0@linaro.org>
 <CABgObfb7xNov4tW1m1Yru+-p55zGW_3jsNXyzL68_NjY0XnMtA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CABgObfb7xNov4tW1m1Yru+-p55zGW_3jsNXyzL68_NjY0XnMtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 12/11/25 14:28, Paolo Bonzini wrote:
> On Thu, Dec 11, 2025 at 4:47 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 12/10/25 07:16, Paolo Bonzini wrote:
>>> VSIB instructions (VEX class 12) must not have an address prefix.
>>> Checking s->aflag == MO_16 is not enough because in 64-bit mode
>>> the address prefix changes aflag to MO_32.  Add a specific check
>>> bit instead.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>    target/i386/tcg/decode-new.h     |  3 +++
>>>    target/i386/tcg/decode-new.c.inc | 27 +++++++++++++--------------
>>>    2 files changed, 16 insertions(+), 14 deletions(-)
>>
>> Where do you see this?  I think this is wrong.
> 
> Yes, I was confused by the comment and by QEMU's incorrect decoding logic:
> 
>          if (CODE32(s) && !VM86(s)) {
> 
> which should be changed to
> 
>         if (PE(s) && !VM86(s)) {

I can't find the language for that.  Can you point me at it?

> And by the way, this also means that we need either separate helpers
> for 32- and 64-bit addresses, or a mask argument.

Of course.


r~

