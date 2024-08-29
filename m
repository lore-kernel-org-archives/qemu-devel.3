Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66540C87FD6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 20:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjlWE-0003jp-Rs; Thu, 29 Aug 2024 16:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sjlWE-0003jE-43
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 16:13:22 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sjlWB-0005dc-UN
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 16:13:21 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7cd76b56e59so405758a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724962397; x=1725567197; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PzD9lQNuXy6an1b4OC2PVoq5wfLs8kUlGW/HVN/KQ0w=;
 b=zD3Njx/6Tr71ab50Q93FtE3ID5jV8jMII80D+WrinD8WiTLw06qcA0U+itO8iReMu9
 zp9pip2DUrQ2zctJb0EzVykIAkc+nc5h2n7XOmDY9EEom5pHqdgmBhJjHwuQVTLql1Qh
 T5+AI2uA1/Vtvu+/ThcUcfSeRvwQgh28YRJtIrHyLUqaxJfgyfHbf/VDxyw35gRf4fjW
 O1rClBr8hObdQtbEXaVTH6aWv9RPoxsNVyUjEWa2n0W+9S2UQigcKC0TvmRMqo0ffYrs
 M7oqhTbT54JatZ9qpVdSvmHcDpOyB/+8KGpTMvQ/xtN9FSkTw7De19/+N49gRXNe66Lb
 CVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724962397; x=1725567197;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PzD9lQNuXy6an1b4OC2PVoq5wfLs8kUlGW/HVN/KQ0w=;
 b=diANR2FDH5oF0kaHDML8+S6ZXwhu3M1/IYpWZ8rc6RaWZpg/VbnXFWIcyLM8v/6x9t
 hrzAP5LXE/fCj10zbl0jtj43r4RyV9g3p1EVDNCs/OL0cK/ZJlkDcPJ3CsmCTc+EJ1WK
 a8mlsh+f38XSUcIVJeZBbPk12AbCW/Z/wpl/2qisRVbSzJrAfKrVomB6z7j6Z+V9rrr6
 25mGpSWRE0UO3igWtMTnzauDzHtl1rpScl363/sfwfRG8gvBHdOKHKgjt/chJVYlrjVt
 eMbKnwrkQXUxB/Wca9EpqskV0raqZ410HplbZE9hYNzf+O5blfNg779Qq9ifIBjXyfj0
 eDmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0xHLYjDQ+FJq6HyhuDnwmEEvEi8a2oT0C6pExE0rP0AqJDkGksix14memj1oZcDXohAeh688k/8Y7@nongnu.org
X-Gm-Message-State: AOJu0YxHc0IuYqosZJCNmcf8MVLtSkbPYvjeJT8mY0mHOCxFtIharJ6H
 xm/ufGEdFDhUMOwcztGQMApHyjW1E/rsGDQUBm+y+594Xf5c4X8Ql8jWmdZZN+s=
X-Google-Smtp-Source: AGHT+IHfxFCuB+M9rVINceOvoLrv4GKFrSt2N+eXh7oBiO00BKUn7JwqIj17ugHJl79qDDcTwdXJXg==
X-Received: by 2002:a17:90b:4acd:b0:2d3:d691:6d3e with SMTP id
 98e67ed59e1d1-2d85639213dmr4108710a91.30.1724962397456; 
 Thu, 29 Aug 2024 13:13:17 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b400:bb79:4bdf:de43:1f6c:1151?
 ([2804:7f0:b400:bb79:4bdf:de43:1f6c:1151])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8446f3bd4sm4615602a91.53.2024.08.29.13.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 13:13:16 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] tests/tcg/aarch64: Extend MTE gdbstub tests to
 system mode
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240825145208.46774-1-gustavo.romero@linaro.org>
 <20240825145208.46774-5-gustavo.romero@linaro.org>
 <64200fe4-b824-4903-b5f5-fc48c9e00945@linaro.org>
 <69229d7b-15d5-feda-ee4b-1c48992297f3@linaro.org>
 <2c2813aa-5671-7705-7170-d3e8e25d2f7b@linaro.org>
 <65e4c975-83f9-4d9b-a8aa-37d9543afac7@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <f5b66bb8-bf39-40f6-e641-64ddcfd6ac13@linaro.org>
Date: Thu, 29 Aug 2024 17:13:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <65e4c975-83f9-4d9b-a8aa-37d9543afac7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.084,
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

Hi Richard,

On 8/28/24 9:43 PM, Richard Henderson wrote:
> On 8/28/24 04:01, Gustavo Romero wrote:
>>   SECTIONS
>>   {
>> -    /* virt machine, RAM starts at 1gb */
>> +    /* Skip first 1 GiB on virt machine: RAM starts at 1 GiB. */
>>       . = (1 << 30);
> 
> Better is to use
> 
> MEMORY {
>    RAM (rwx) : ORIGIN = 1 << 30, LENGTH = 16M
> }
> 
> (or whatever minimum length seems reasonable).
> 
> Since there is only one memory region, it will be used by default and no further markup is required.
> 
>> +    /* Align text to first 2 MiB. */
>> +    . = ALIGN(0 * 2M);
> 
> This is pointless, of course: ALIGN(0) does nothing.
> 
>> @@ -19,12 +21,12 @@ SECTIONS
>>           *(.bss)
>>       }
>>       /*
>> -     * Align the MTE page to the next 2mb boundary (i.e., the third 2mb chunk
>> -     * starting from 1gb) by setting the address for symbol 'mte_page', which is
>> -     * used in boot.S to setup the PTE and in the mte.S test as the address that
>> -     * the MTE instructions operate on.
>> +     * Align the MTE page to the next 2 MiB boundary (i.e., the third 2 MiB
>> +     * chunk starting from 1 GiB) by setting the address for symbol 'mte_page',
>> +     * which is used in boot.S to setup the PTE and in the mte.S test as the
>> +     * address that the MTE instructions operate on.
>>        */
>> -    mte_page = ALIGN(1 << 22);
>> +    mte_page = ALIGN(2 * 2M);
> 
> This does not do what you think it does.
> It aligns to the next 4M boundary, not the next 2M boundary.

I see now. This works because by chance ALIGN(2M) == ALIGN(4M).

So, using the 'M' suffix, I understand this is correct (and works):

(diff against the my patch)

index 46f1092522..823d47f7e7 100644
--- a/tests/tcg/aarch64/system/kernel.ld
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -11,7 +11,7 @@ SECTIONS
          *(.rodata)
      }
      /* align r/w section to next 2mb */
-    . = ALIGN(1 << 21);
+    . = ALIGN(2M);
      .data : {
          *(.data)
      }
@@ -24,7 +24,7 @@ SECTIONS
       * used in boot.S to setup the PTE and in the mte.S test as the address that
       * the MTE instructions operate on.
       */
-    mte_page = ALIGN(1 << 22);
+    mte_page = ALIGN(2M);
      /DISCARD/ : {
          *(.ARM.attributes)
      }

   1 .text         00001e60  0000000040001000  0000000040001000  00011000  2**12
   4 .data         00012000  0000000040200000  0000000040200000  00020000  2**12
0000000040400000 g       .data	0000000000000000 mte_page


I was not able to make the MEMORY command work. I tried:

index 46f1092522..dc39518a16 100644
--- a/tests/tcg/aarch64/system/kernel.ld
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -1,9 +1,13 @@
  ENTRY(__start)
  
+MEMORY
+{
+    ram (rwx) : ORIGIN = 1 << 30, LENGTH = 16M
+}
+
  SECTIONS
  {
      /* virt machine, RAM starts at 1gb */
-    . = (1 << 30);
      .text : {
          *(.text)
      }
@@ -11,7 +15,7 @@ SECTIONS
          *(.rodata)
      }
      /* align r/w section to next 2mb */
-    . = ALIGN(1 << 21);
+    . = ALIGN(2M);
      .data : {
          *(.data)
      }
@@ -24,7 +28,7 @@ SECTIONS
       * used in boot.S to setup the PTE and in the mte.S test as the address that
       * the MTE instructions operate on.
       */
-    mte_page = ALIGN(1 << 22);
+    mte_page = ((1 << 30) + 4M);
      /DISCARD/ : {
          *(.ARM.attributes)
      }

But it didn't work because data section is placed in the wrong place:

   1 .text         00001e60  0000000040001000  0000000040001000  00011000  2**12
   4 .data         00012000  0000000040003000  0000000040003000  00013000  2**12
0000000040400000 g       *ABS*	0000000000000000 mte_page

Do you know why?

I also had to use 'mte_page = ((1 << 30) + 4M);' for the mte_page symbol because
the current location (.) seems to reset to zero for the sections, hence if I do:

+    mte_page = ALIGN(2M);

I get:

0000000040200000 g       .data	0000000000000000 mte_page


Cheers,
Gustavo

