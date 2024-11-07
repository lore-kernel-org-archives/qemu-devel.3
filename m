Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B65ED5AE75
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 09:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ypT-0000iM-LC; Thu, 07 Nov 2024 04:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8ypR-0000hn-GZ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:29:25 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8ypP-0000T4-Pl
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:29:25 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso6386405e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 01:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730971759; x=1731576559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HQsppEOwcAXIELgXkg7wouYMnqnAPS7rl3YfFuwv3gM=;
 b=TfviJWGjvVZEe0397IX61JNFVGFUDxoZi6WBtUeqkv4SdibGzxpM27TKtK6AOq0I95
 bAnU8E9WcX9OciCF/GhHrd1qCqCWxuFfu07psv+q/lskUiA6k+LtBiP8u+/kenFrMjes
 z8o/tz+p7YmMrDNqVd1rfyZGPBKBDuN8mY3C1MKhXOrGczW1nuRVBqtlR449ap3EkXgq
 GPlbOuuoJPbSMQff/+ZbwQKQ/UkLcndJGpQRXpgi+vXH9UVkafL3M+MbACwe7fIi+XHQ
 zBdxhqAljl1VG31oPSAYHTZvM8Gzv3EaTn1ODSRrLcnUDqp/Hu/tBz9qhOwCWZdypCBv
 rkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730971759; x=1731576559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HQsppEOwcAXIELgXkg7wouYMnqnAPS7rl3YfFuwv3gM=;
 b=ejiwA/p34fbjPG9ss2BfwfGs+V1MVxNDBpmRnGj6q6UqK+pnpFvhWjwMTS4sk3RjKK
 GV407TzEAv+psZhoCrQidRb5hZV0T3f0yKrstxklsXGfo2a5sZ/ZYJAEDvjMcZ1Syu9L
 oS8Uz1bYy4YtxfHo5GTTWiY2QkUQifI2O4Wzk71k0qyKVQOAs0wRt7Bts3Ag7MAB3yoG
 W44i8DGiZGz99Fynaa15mkcttqpzif8SoZCwsvL/F8PbRDw9Reloj/iU+Jy8OKLNtU7+
 bwr7eR4Vz1qBUlvByojkTX3s/2Qj7fL6JECltV59+1vkQvjRC7giyqSYzISD2gcllMU+
 eu3g==
X-Gm-Message-State: AOJu0Yw28W3UwglUGqU8j//S7kvIMdEy8yaMuTvybBhRMPqpCz9OPGst
 KXdQHpUGFWBTaKfCxaX1/+LRKf5qGiFL3mM+fBRdZnkW/8HXsPkLp5w22iDO8Xw=
X-Google-Smtp-Source: AGHT+IG2puM7TkZ1q+DCfHgFHdeIkE8xzR8Xd2Kp6gsiUKJH33GIr1T3c4P3lh/bjiL2KbHpdZ+r5A==
X-Received: by 2002:a05:6000:2c8:b0:37c:d1bc:2666 with SMTP id
 ffacd0b85a97d-381c7a472f7mr21554261f8f.4.1730971759496; 
 Thu, 07 Nov 2024 01:29:19 -0800 (PST)
Received: from [172.16.23.118] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda03e42sm1200606f8f.89.2024.11.07.01.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 01:29:18 -0800 (PST)
Message-ID: <87228a75-eeea-496c-a414-03eed9b4fc94@linaro.org>
Date: Thu, 7 Nov 2024 09:29:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user: Add option to run `execve`d programs through QEMU
To: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com, laurent@vivier.eu
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
 <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
 <CAFUsyfKkmSid=LVTbG+WHZA_=MAGdf+TU5vGtNE1GGx8WDheOQ@mail.gmail.com>
 <CAFUsyfKfM-X_qGN4Dy8DhES7zRi66s6yVZ3+_KmNM4f2GhBG+Q@mail.gmail.com>
 <f21fe153-6239-4c93-bf60-994976a9dbea@linaro.org>
 <CAFUsyfLhPkSMrm50RAAvir2-WoRS4_jbtZf1WWR_WZvm=BOr6g@mail.gmail.com>
 <e63cd5f6-8387-4c39-98e4-5e1c180934bc@linaro.org>
 <CAFUsyf+8sJLX+qqzPEj1E1QPQpoP4n56uU5U9aksq8JEx_52gA@mail.gmail.com>
 <CAFUsyf+xVXamR+5gtu62vFXjYScrJu0Arvhk62QXYa359UCHsg@mail.gmail.com>
 <d23ea679-9c21-44da-86cf-ae97d0214b86@linaro.org>
 <CAFUsyfL=QfvtMb6TiWVa2cEyeYQobh_3zfYpnPEb7bq6FH1k1A@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFUsyfL=QfvtMb6TiWVa2cEyeYQobh_3zfYpnPEb7bq6FH1k1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

On 11/6/24 21:30, Noah Goldstein wrote:
> On Wed, Nov 6, 2024 at 3:10 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/6/24 18:13, Noah Goldstein wrote:
>>> Question about impl regarding handling of `-execfd` with/without a program name.
>>>
>>> 1) `-execfd` + program name ie: `qemu -execfd <some_fd> ls -a`.
>>> 2) `-execfd` without program name i.e: `qemu -execfd <some_fd> -a`.
>>>
>>> Do you want to allow both of these? If you want to allow (1), what should
>>> we use for `argv[0]`/`exec_path`. The program pass ("ls") or
>>> `readlink(<some_fd>)`?
>>
>> The canonical response is, examine the kernel source.
>> We're not implementing this in a vacuum, you're replicating execveat(2).
>>
>> I suspect the answer is (1), to be compared with
>>
>>       syscall(__NR_execveat, some_fd, "", &["ls", "-a"], env, AT_EMPTY_PATH);
> 
> Err, I think the reference for '-execfd' is `fexecve`:
> https://man7.org/linux/man-pages/man3/fexecve.3.html

No, fexecve(3) is a glibc function which (nowadays) uses the execveat(2) syscall that we 
want to emulate.

> Which doesn't take a path...

... corresponding to the "" and AT_EMPTY_PATH above.

> So I guess we just interpret the "ls" as argv[0] but not as "exec_path".

But your conclusion is correct.


r~

