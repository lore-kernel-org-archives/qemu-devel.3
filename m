Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9267C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ser8v-0000be-P9; Fri, 16 Aug 2024 03:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ser8o-0000am-G2
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:12:54 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ser8l-0002qJ-9z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:12:54 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db2315d7ceso977352b6e.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723792369; x=1724397169;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jigtei6XCaddcBjmFpknakT1Few+oxg9HzxwH3JBL5A=;
 b=g0rBsAc+0N7/kRcLS+x/U0gz6a76WywmwZV7S1JGXD0/YaKvFtA1UkMctURd3TK7vq
 xiGeyOBy6cC+C/fa74ny68Nc2x9XPiDOhEPeMeHooH6x/wFPhVA+zS9gss2A1sS5nl0Y
 UPNoEPa5DRjYKHL/lH1+ZdFh2poNrYBTJeupPEUFCtwgDqP1vu5adyg9veMx8UmXpTxK
 aEhoQBnpR9bGZWKiw1PgsyFJkryBtDuOyXDJZKtxUX1N0iRYfW4fQXoXn6Ni5LUus/eA
 GmThIV3oiWWGH7rbnWY4HmExC0rcTag9cVCgJQoQ0SwCP3l252TeAHs62sWHQJnqW0P+
 //Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723792369; x=1724397169;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jigtei6XCaddcBjmFpknakT1Few+oxg9HzxwH3JBL5A=;
 b=CZdZP8L/XD7c64zfcP1ns/f+uvVbI6mHRlLPEvbIw0qgaNIrKGdifwdMAcfji/DhgE
 KAF9egj8HCnQuPHep5uNdzOtJaLwTh0jg3BbqTQ6v59+YzFayvtPMBs75yQdRfYj+2FZ
 yqxozEWE/3BUIK7LgqwQtL/Y8FMqJEkQoBQMkOlaZqWi/ATHbqKDFuDbCjsEcgxyIweT
 40GGcYzAKxTL5Sa8BPVWgtO6bYPXk46lkYq0tPjj3wVAsvf7xSfIlnQ0GFUaqBPC0YiZ
 WeG60YgKooDMp4zJDOvcbaCH7VExzuvER1h+dfd8X6FNtLl+BMjAYUqBFqgF/8GG9XiH
 Xa5g==
X-Gm-Message-State: AOJu0Yw50z0lsigC2/WNGlHIcoA35JiHt0ykzNHxOm6IOuFdxO3Xew/S
 vxBvZXgUF5rr9wGFbDOzOLpTTU/yzSxSsbdhit2I2k+K7uxZb8K9B/6WekaH+5A=
X-Google-Smtp-Source: AGHT+IHLNxcoWYY7Nvbdi/xMuhDfQwDCccpKpnIuFQpR5gp6szv3ihYt3c9p2RKo/tAtNSZUBMpdQg==
X-Received: by 2002:a05:6808:1588:b0:3db:284d:976c with SMTP id
 5614622812f47-3dd3acf8891mr1650249b6e.11.1723792369267; 
 Fri, 16 Aug 2024 00:12:49 -0700 (PDT)
Received: from [157.82.207.214] ([157.82.207.214])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6b636b07fsm2333596a12.86.2024.08.16.00.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 00:12:48 -0700 (PDT)
Message-ID: <337e647e-3edf-475c-8e37-de3d28b30340@daynix.com>
Date: Fri, 16 Aug 2024 16:12:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] meson: Use -fno-sanitize=function when available
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240816-function-v3-1-32ff225e550e@daynix.com>
 <3d417232-ba66-4781-8278-a6a31987b54c@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <3d417232-ba66-4781-8278-a6a31987b54c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/08/16 16:03, Thomas Huth wrote:
> On 16/08/2024 08.22, Akihiko Odaki wrote:
>> Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
>> -fno-sanitize=function in the clang-system job") adds
>> -fno-sanitize=function for the CI but doesn't add the flag in the
>> other context. Add it to meson.build for such. It is not removed from
>> .gitlab-ci.d/buildtest.yml because -fno-sanitize=function in meson.build
>> does not affect --extra-cflags due to argument ordering.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> Changes in v3:
>> - I was not properly dropping the change of .gitlab-ci.d/buildtest.yml
>>    but only updated the message. v3 fixes this. (Thomas Huth)
>> - Link to v2: 
>> https://lore.kernel.org/r/20240729-function-v2-1-2401ab18b30b@daynix.com
>>
>> Changes in v2:
>> - Dropped the change of: .gitlab-ci.d/buildtest.yml
>> - Link to v1: 
>> https://lore.kernel.org/r/20240714-function-v1-1-cc2acb4171ba@daynix.com
>> ---
>>   meson.build | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 5613b62a4f42..a4169c572ba9 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -609,6 +609,7 @@ if host_os != 'openbsd' and \
>>   endif
>>   qemu_common_flags += cc.get_supported_arguments(hardening_flags)
>> +qemu_common_flags += 
>> cc.get_supported_arguments('-fno-sanitize=function')
> 
> As I mentioned in my last mail: I think it would make sense to move this 
> at the end of the "if get_option('tsan')" block in meson.build, since 
> this apparently only fixes the use of "--enable-sanitizers", and cannot 
> fix the "--extra-cflags" that a user might have specified?

Sorry, I missed it. It cannot fix --extra-cflags, but it should be able 
to fix compiler flags specified by compiler distributor.

Regards,
Akihiko Odaki

