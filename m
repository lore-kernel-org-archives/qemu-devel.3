Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E880BC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfgM-0000wU-2d; Tue, 02 Jul 2024 11:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOfgK-0000vj-2Y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:44:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOfgH-0004fz-Sn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:44:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-424ad289949so31769735e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719935072; x=1720539872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NlxQXSZoT85mm2gHaHTGLn7lbEgSEbKZODT5yZdSUx4=;
 b=bThedOUkEj4jFXPV5s9kIZTAfOHNiK2RU1tUDtOfVYVYZTXFER5hn1CjGS5CC+1f3p
 BgSQ0e0/nUtsuZFuZHwltw7E0HD5Np6VYG8vGkXnLR5+37/wJkXGhmhA42RfXbBCuus0
 rTb5XRCX3tflA3bmAGQeQYUeKUYi1rOiAO+thoy3a5JR1SSLt7n0EEo3kcFTzMU3yVCG
 H+ceOXWLP7/ht/6dtM/fWvpBo+kE7DUW4RjyQgT4JWB7r73wP1vSjRVcPqcf6B6dJR7m
 f+sevsvFVF/mjvwetDN/xbxvs+D11h2x6kmDSEA67PHfNeQD4C43aDYuyQRMuYNMsEbU
 30iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935072; x=1720539872;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NlxQXSZoT85mm2gHaHTGLn7lbEgSEbKZODT5yZdSUx4=;
 b=VtK9ZvHLSATrIBUmsZ32QnlgZsO1ln33GoEN2UxeRdYobeTWbfFYT+NHIL7Le0V14w
 mUHOSmTsohK4ozMtyhJqz4LIYuxCpH5ffsFZerI315E/fa94mmLR5ipSmuz6DqmuM+av
 WRlA51bWwp+dZ+t4hEIUIjaBbo22CViSdZdvTUvBNMsG9kV6APCPOGINfeYBIAikCACS
 OIsHdzgW1xGBCBkIFb53BZwmWOucHFk+bFEyR6ACI1H/7NjBFGd0EOBxHLzJHgHG8dd3
 64TfNTSW/xuzKWh+rvcoOA83XJCEwnWDzigR/N4wFBsKgQk2HKdZqnwxf1D0sd9B2kSX
 Xq/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsx9CUzXQIyKlXBqzOZyF0XilbNp2VIUvhlCCPI20ajzoMnhEIaC6nJGt4hyAgZyr+gFlpWon/uqAIxFEXSIOGKlLjkyw=
X-Gm-Message-State: AOJu0YxjNal1V7tYuAh/i+Cy3DbeGrttC5tCyALjjOM5u2T+EmsCDgZo
 XW9jFLwYrdVWa+X8E1FbQxGIXYva9SUWiKiZr7rjdZTp9UGH0A1OobA9RbIexXKjy2SteOWV0iJ
 8
X-Google-Smtp-Source: AGHT+IF4czF15NZPD8KifwI3iu/ayVV1PFpInypBNymsqOeZlqwJ5XYr8a3DP5gEddnd+MutdYhoUA==
X-Received: by 2002:a05:600c:4205:b0:424:ac9c:71f9 with SMTP id
 5b1f17b1804b1-4257a0282eemr54146925e9.39.1719935071796; 
 Tue, 02 Jul 2024 08:44:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257d04c742sm120833475e9.7.2024.07.02.08.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 08:44:31 -0700 (PDT)
Message-ID: <42fbede9-89fa-469e-bec5-b3d414c4e42f@linaro.org>
Date: Tue, 2 Jul 2024 17:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/char/pl011: Avoid division-by-zero in
 pl011_get_baudrate()
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Zheyu Ma <zheyuma97@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240702152750.3017426-1-zheyuma97@gmail.com>
 <b72e40c9-c2de-487c-a9ad-a52c1f286d77@linaro.org>
Content-Language: en-US
In-Reply-To: <b72e40c9-c2de-487c-a9ad-a52c1f286d77@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/7/24 17:40, Philippe Mathieu-Daudé wrote:
> Hi Zheyu,
> 
> On 2/7/24 17:27, Zheyu Ma wrote:
>> In pl011_get_baudrate(), when we calculate the baudrate we can
>> accidentally divide by zero. This happens because although (as the
>> specification requires) we treat UARTIBRD = 0 as invalid, we aren't
>> correctly limiting UARTIBRD and UARTFBRD values to the 16-bit and 6-bit
>> ranges the hardware allows, and so some non-zero values of UARTIBRD can
>> result in a zero divisor.
>>
>> Enforce the correct register field widths on guest writes and on inbound
>> migration to avoid the division by zero.
>>
>> ASAN log:
>> ==2973125==ERROR: AddressSanitizer: FPE on unknown address 0x55f72629b348
>> (pc 0x55f72629b348 bp 0x7fffa24d0e00 sp 0x7fffa24d0d60 T0)
>>      #0 0x55f72629b348 in pl011_get_baudrate hw/char/pl011.c:255:17
>>      #1 0x55f726298d94 in pl011_trace_baudrate_change 
>> hw/char/pl011.c:260:33
>>      #2 0x55f726296fc8 in pl011_write hw/char/pl011.c:378:9
>>
>> Reproducer:
>> cat << EOF | qemu-system-aarch64 -display \
>> none -machine accel=qtest, -m 512M -machine realview-pb-a8 -qtest stdio
>> writeq 0x1000b024 0xf8000000
>> EOF
>>
>> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>> ---
>> Changes in v2:
>> - Enforce the correct register field widths on writes to both UARTIBRD
>>    and UARTFBRD registers.
>> - Mask UARTIBRD to 16 bits and UARTFBRD to 6 bits in the pl011_post_load
>>    function to prevent division by zero during inbound migration.
>> ---
>>   hw/char/pl011.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
>> index 8753b84a84..ba5f7cfbda 100644
>> --- a/hw/char/pl011.c
>> +++ b/hw/char/pl011.c
>> @@ -374,11 +374,11 @@ static void pl011_write(void *opaque, hwaddr 
>> offset,
>>           s->ilpr = value;
>>           break;
>>       case 9: /* UARTIBRD */
>> -        s->ibrd = value;
>> +        s->ibrd = value & 0xffff;
> 
> LGTM but could you add a definition instead of these magic values?
> 
> Similarly to the ones in the top if this file:
> 
>    /* Flag Register, UARTFR */
>    #define PL011_FLAG_RI   0x100
>    #define PL011_FLAG_TXFE 0x80
>    ...
> 
>    /* Integer Baud Rate Divider, UARTIBRD */
>    #define IBRD_MASK 0x3f
> 
>    /* Fractional Baud Rate Divider, UARTFBRD */
>    #define FBRD_MASK 0xffff
> 
> Then use these definitions :)

Since I have the patch, let's share it to save you some time:

-- >8 --
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 8753b84a84..7f9a85708e 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -87,6 +87,12 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, 
Chardev *chr)
  #define CR_DTR      (1 << 10)
  #define CR_LBE      (1 << 7)

+/* Integer Baud Rate Divider, UARTIBRD */
+#define IBRD_MASK 0x3f
+
+/* Fractional Baud Rate Divider, UARTFBRD */
+#define FBRD_MASK 0xffff
+
  static const unsigned char pl011_id_arm[8] =
    { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
  static const unsigned char pl011_id_luminary[8] =
@@ -374,11 +380,11 @@ static void pl011_write(void *opaque, hwaddr offset,
          s->ilpr = value;
          break;
      case 9: /* UARTIBRD */
-        s->ibrd = value;
+        s->ibrd = value & IBRD_MASK;
          pl011_trace_baudrate_change(s);
          break;
      case 10: /* UARTFBRD */
-        s->fbrd = value;
+        s->fbrd = value & FBRD_MASK;
          pl011_trace_baudrate_change(s);
          break;
      case 11: /* UARTLCR_H */
@@ -531,6 +537,9 @@ static int pl011_post_load(void *opaque, int version_id)
          s->read_pos = 0;
      }

+    s->ibrd &= IBRD_MASK;
+    s->fbrd &= FBRD_MASK;
+
      return 0;
  }

---


