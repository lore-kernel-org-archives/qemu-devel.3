Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2905D75E5D
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 20:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFJ8l-00034l-PZ; Sun, 24 Nov 2024 15:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFJ8j-00034a-Jw
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 15:23:29 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFJ8h-0000gz-Q0
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 15:23:29 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315abed18aso33437995e9.2
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 12:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732479806; x=1733084606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZV6K6VqLj+LOkOKwyTQOzednhffXQInyWmrCLlYyySs=;
 b=mLGFhotEih2w/ZU7MnGSqjLPRBwZPBSMHy2dAfGLP41hcdPBl7e1GuTeO5yp0gpH8u
 9zdikyAyMyfQ4kUJN8UDsRnEC1mpoxb2ItcreIU+lM7vx56zmUWYLYV/UM1rpS97mRTu
 /03zltWCc+EHteuNUeQvQwtpK9ou7QrabrVhpcJxoVmzo+mcxmXVQzACebvDNO4bLZtg
 PJOSIkxHQmmxXYRoNupGXAxQ00Sj27wyDoY8xgU1/b9of1j1rX8vi6DwgpRnvYF5bPjV
 vvHsFpppl6YQcETTb96xzF9SUEzEno77FPAzTVAjTQFTNqlcIYr8a3vzEgtx2ywhjO0h
 TotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732479806; x=1733084606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZV6K6VqLj+LOkOKwyTQOzednhffXQInyWmrCLlYyySs=;
 b=C8vRcApPyle2gNBfA0kct1xhZweyHjHdmPRax5mc00fMl96yRc3kfr6OzrMTeBOAuE
 1WK59eLPdmifMeBlN8xLHXHwlvlGLj+y+zrCSe1fnOfzpWg7iqMKa/uiu7CSjy5uUeEF
 cBoR2p1xNugaRFQRSg67RvSMTaDAPKAem0JvDhakGIuS+cDQKIFt/wvLYCFbBiztdk/b
 zrkpuk3USXGYruwsYDladGA9LVgGMqmIcEtqqDPL28YA/NVLnuNtmbr0W/3f5NGh5Fw3
 fJwOwDhT7xqeI9b2+pP+9oDS+TP80oaL9F8XXmSWzEm65woZQED7SSziO4VsAUDPWPDY
 Q4FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM/r7mHlkz7g5/q1TwZu6A3W8eO4wJluzsB2Y5htn4I4TS6+4jrQ9fzKFubFW9n75idn83coPOPNxw@nongnu.org
X-Gm-Message-State: AOJu0YyDiJqRJJBaY7tecKwuUN0IOvYPw47x5hcndLDGVi54EMprZn66
 JrXpBxih54n3Tev4DZGLq784ocdyY2XqOfbYYsULo7xRu0GNBqhFyEeSaeiuyPA=
X-Gm-Gg: ASbGnctotk+O6kOjE2qZKvxmXV8R1K+72zjt0KKcFpDMy9O55whosNYjSm+a6X9GZRG
 g4XDAhP5W+89Bym2065p8akQLu6b6Mr9Z49R2HUrs6knQFdoruF7TC59CTuYZJLaSme1o1KCeCr
 MzqY7mcWzNiNuyOQVy0zkQKi4R8XBcrHd60G4vDR52j2LfyFAg1Y/aCLVOss0SkFIRut1rStdvd
 t7hqMkZtedxBCauBF/4nC7tt9rHfcC6NQnAWX5Ltw2sJJVCHwSQQLoPLmFEiUj4xQ==
X-Google-Smtp-Source: AGHT+IHFoyZ+s+85pvKN/GaRpQTGaY/MHO5A2753bO/EbTAZcQyUwzdxwIIwEPDvFQcwwe63b5sXmQ==
X-Received: by 2002:a05:600c:3b12:b0:432:d875:c298 with SMTP id
 5b1f17b1804b1-433ce426968mr88949445e9.14.1732479805696; 
 Sun, 24 Nov 2024 12:23:25 -0800 (PST)
Received: from [10.150.212.240] ([95.173.222.38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4348e272094sm58146565e9.7.2024.11.24.12.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Nov 2024 12:23:25 -0800 (PST)
Message-ID: <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
Date: Sun, 24 Nov 2024 12:23:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
To: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x331.google.com
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

On 11/24/24 04:10, Paolo Bonzini wrote:
> On 11/24/24 01:21, Pierrick Bouvier wrote:
>> After thinking about it, a simple, exhaustive and reliable way to find
>> this type information is the debug (dwarf) info.
>> By compiling qemu binaries with --enable-debug, and extracting info
>> using llvm-dwarfdump plus a custom filter [4], we can obtain a text
>> representation of all structures QEMU uses.
> 
> Yes, this is a good idea.
> 
>> As there is a lot of repetition between all qemu binaries, the reduced
>> list of structs concerned is [6]:
>> +name:ArduinoMachineClass size:0x0198
>> +name:ARMCacheAttrs size:0x04
>> +name:ARMVAParameters size:0x04
>> +name:AspeedMachineClass size:0x01d0
>> +name:_GIOChannel size:0x70
> 
> This one unfortunately shows why the global change is wrong.  The size
> of _GIOChannel must match between glib and QEMU, otherwise you have an
> ABI mismatch.
> 

In the codebase, we always use this type as an opaque type (through 
pointer, using library functions to interact with it and never use it's 
size). So the fact we see a different layout is *not* an issue for QEMU. 
I don't see it as a counter example that this does not work.

> In other words, the global default _must_ be -mms-bitfields, because all
> other libraries (and also Windows itself, though you didn't find any
> occurrences) are built with MSVC ABI compatibility.  Bitfields are
> relatively rare, and therefore you only found one occurrence; however,
> this is a constraint that we cannot get rid of.
> 

-mms-bitfields is already the (silent) gcc default on windows, to mimic 
MSVC behaviour. Yes, it would be preferable to use this default and 
gcc_struct attribute, but right now, it does not work with clang. So the 
whole point is to accept a compromise for this.
We can even apply this selectively when clang is detected in case QEMU 
community is scared changing this default would break existing code.

I don't understand the strong pushback against clang support on windows. 
Because of a "theoretical" problem, that was proved here we don't have 
currently, we are stuck with gcc_struct attribute. This is currently 
blocking clang, and I don't see the point about that.
If clang supports gcc_struct attribute in the future, we can always 
decide to revert this change, and use it again. Meanwhile (1 month? 1 
year? 5 years?), we are just blocking progress support for the sake of 
blocking it.
The risk of this approach is that MSYS2, and Google folks using clang-cl 
will simply move forward and remove this restriction, even if the 
upstream community does not agree. Closing eyes and say "not supported" 
is not the best way to move forward.

> However, your script lets you do the opposite experiment: remove
> gcc_struct QEMU_PACKED and check if anything changes, i.e. whether there
> are any QEMU_PACKED structs that do rely on the gcc_struct attribute.
> If there are any, then it should be possible to change the definition
> and fix them.
> 

It does not only remove gcc_struct attribute, it replaces it with an 
option that does the same thing globally for all packed structs.

I did the experiment with gcc only, simply to have an easier diff 
because code layout stays the same, while clang would order symbols 
differently.

> Thanks,
> 
> Paolo
> 

Thanks,
Pierrick

