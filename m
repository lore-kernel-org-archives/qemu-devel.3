Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C8C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 05:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhjRm-0004PZ-U8; Wed, 06 Mar 2024 00:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhjRf-0004PK-PI
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 00:04:01 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhjRe-0004pH-4a
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 00:03:59 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso4764066a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 21:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709701436; x=1710306236;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vLOgOufL1xXlPTRAz4seRIZEhhSd5N/oK3LE59hce98=;
 b=R6R+B1rrRYSDkBgWMR3kj+cdmF/Pjgn2swIlpYDC35ggwx4H7ISWjo+88wluWpdpC+
 fHLc6EkzZWN8RuYE6XPRtrOB7MH8Jv6EprfIrUj93W1zRMvIr2g9l1OTE4C1U1pioqL0
 I4+VcH/RTA8X8x+FNr+ghKXpzeGXQQXYTMKn3lUVdBUGMwRIgBQRKoMk1IqAOnLMyJYP
 hDR9DjRvyTjsv7FIjqpxz9PpFA7tRk6J6WcbFtUO82m6er2qIvfnG9lz+9wAfo2Gal6w
 k84wZgkuvLxWsre8Chkzo0yvwTXk0W0zbZ3IACLmwq2eWdBMrDQSASd/6yaqFrVET9QE
 h0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709701436; x=1710306236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vLOgOufL1xXlPTRAz4seRIZEhhSd5N/oK3LE59hce98=;
 b=ZAjTGSJti6nunXiWCN3CfLnuMVo5cEGeNah8Pb0MOckjY3j5BalzNpCIX5IsThiaiz
 bcF+u6ODEmYnxRpQOhbFAAAyy+/qWprrXlpIZazCLt0UprBW7qzM+8cUjv//5oX4ImPo
 gz+I96sROU5JqRvgk9FElbKUqzs6cpbyWFq35zEk+ElAfriL8z0orkhVg1qxhvR24jyL
 RLy4fAR2/4wZUxieFs7mqiZRnGrgz+9TSSPgeu9jQjN+0ojLDI0DZkspL2sN/7XH0NHA
 NOwchlT1WYpyZPWC4o0nqnwICbm4EDejTW0SEqSCf8IWFSdqEwjSVRXFazD5oJs2/uUZ
 7Rkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtcPbOOIUuCtg0PvzD+va10Jo5yxVYKM87RREHnj45/tfwB6ZmgKveO+bVj0jwi/5NgjsZM6KmXspB32M4+dRJ070fn8k=
X-Gm-Message-State: AOJu0Yw/3LwtgQgCY5tj9fwpwpsNCN9uQJgES5bKuJWPrNQsLdx4lomE
 iKgDwGVkvK+k4ZSuwRU2DQLNQmy/694VFnaK9UYYOpA0t30BzcwZiJgEUlGqJnw=
X-Google-Smtp-Source: AGHT+IEF0/zTjgA/4y0pkgsb+qKg2nYtfRrW4JdKKa8/LLiD6xvZ6EQYLfojO3CWY5MPVW41Nletrg==
X-Received: by 2002:a05:6a20:d48c:b0:1a1:4757:927e with SMTP id
 im12-20020a056a20d48c00b001a14757927emr4696292pzb.33.1709701435997; 
 Tue, 05 Mar 2024 21:03:55 -0800 (PST)
Received: from [157.82.206.27] ([157.82.206.27])
 by smtp.gmail.com with ESMTPSA id
 du6-20020a056a002b4600b006e5933a0da9sm9837504pfb.165.2024.03.05.21.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 21:03:55 -0800 (PST)
Message-ID: <e36f5302-1d0e-4ecd-a69b-8791cbb84e0e@daynix.com>
Date: Wed, 6 Mar 2024 14:03:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] contrib/elf2dmp: Build only for little endian
 host
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
 <20240305-elf2dmp-v2-11-86ff2163ad32@daynix.com>
 <CAFEAcA8LoGjtzeh9DYurbb_xEOuKzYMPWG=3ucOkNVvdVTd_=g@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA8LoGjtzeh9DYurbb_xEOuKzYMPWG=3ucOkNVvdVTd_=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
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

On 2024/03/05 22:33, Peter Maydell wrote:
> On Tue, 5 Mar 2024 at 07:37, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> elf2dmp assumes little endian host in many places.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   contrib/elf2dmp/meson.build | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/elf2dmp/meson.build b/contrib/elf2dmp/meson.build
>> index 6707d43c4fa5..046569861f7a 100644
>> --- a/contrib/elf2dmp/meson.build
>> +++ b/contrib/elf2dmp/meson.build
>> @@ -1,4 +1,4 @@
>> -if curl.found()
>> +if curl.found() and host_machine.endian() == 'little'
>>     executable('elf2dmp', files('main.c', 'addrspace.c', 'download.c', 'pdb.c', 'qemu_elf.c'), genh,
>>                dependencies: [glib, curl],
>>                install: true)
> 
> If it assumes a little-endian host that is a bug and we
> should fix it, not just disable building the tool on
> big-endian systems.

I will accept if someone submits a proper fix in the future, but I'm not 
going to put effort on that. This is the best thing I can offer for now.

Regards,
Akihiko Odaki

