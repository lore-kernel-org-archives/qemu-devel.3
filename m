Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CB8EB28D6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 07:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voGdP-0007yl-0X; Fri, 06 Feb 2026 02:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voGdN-0007yL-AK
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:52:09 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voGdL-0004Ve-QT
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:52:09 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a9042df9a2so2455065ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 23:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770364326; x=1770969126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xNVGNEbT2bLf5rt/DoSurm2uSDnaYGJp5EIFXhqPFl4=;
 b=xq7/ejT+jwE0eq4ET95ilxHI5VDK0ZZp+OyLNwGxETAE6fbc8Egbcz7VGbdiWZG4Ta
 wxeuyALzn7sOTgFfXPmd+Vf8CCF27FVAHRP2YeGV8gzCSJ3C4sqEM+M8yapRqxR/h9aF
 /srnPgLO4X3Fd7VrYmdtptoQ1LrPlulHA22zqNZAgRrR35JYYu8zwi77I8JlVlzjnzvU
 J2HIw2ig8cYwAFqlKVBYx7sUn4AZzo4t0y5TDC/NZL9sQ4rtgtgKYvANLdtTEnnrM7UB
 jF1EIVV5HBVJeoLw+HdDbbLFmR0GR6B5uw283hyjMz2uBf5GZL1t2qDgEHT3Mey256P0
 K9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770364326; x=1770969126;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xNVGNEbT2bLf5rt/DoSurm2uSDnaYGJp5EIFXhqPFl4=;
 b=fGSJSpinu8QNrb+MuvoVetKqsZLYKZrqzcmf6GgegsE7rTZKpMPGlWCx9WPMOdNYwf
 Q3hHYXaLDzG2AlWu+0yBIC0bftruxuvH2QaCMNf3SfWqXznJWP9l+HxCUvrMxMpJyAC5
 nWBFIa8Ql4efzrA0QBu4brFxhkgYoE0PoiS4Utwld6FoLZfsmT9Cbi5sjfZ5EXg4yUmi
 8wd2pdkACrWG6rDAz3rnQ+HNGavVWQdvSg+Nh1w3tG0aECOXHSxupJHgtrarfLWNvHdV
 yMkg2IkRgjjtAWYDMwwceEzrqNBIzIuROamHgXW+5p4N+9/CRNcLGoFGHUcjoww9Ueqd
 xCaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlFGcE49O+kRNZzjs8xWhLS//wXWogi/uPdfb5K8jO6BI6F7/pTKqvBFyXZJ2E2Rj36RudfWKL7gPZ@nongnu.org
X-Gm-Message-State: AOJu0Yy38AjGvGTp7UdtyzgklvxqBagUEteZG3G3wD2GzuT15x67dLWu
 rN0OXWtHNARStD6hH2+716Zmm4RbC4QFeS5mCPDxAqWf3zyYkXYE18oO0nu7WBlzNI4=
X-Gm-Gg: AZuq6aIwY7AdXV7Asfi3dmcxubZSDbgYK8+Pv76BAaCUlNT0f9AevHHuz0cf/SUiA/a
 356/X1uTS8CRipHPgYSZ79/Kc/jbbxjybSaUBxR1IXFTFcJg83Kg8tUGB37G2mOlWTIDDyp+Rdu
 y9X8ljT2+VqY4F2y9ZNGl2MQy5NUsscUH6nqcdOWf2XLg52WkZfOLIMx4A2On8ecxgx6NwVVZT+
 b12VTqqMPTCWIX8ZksG7JpfA0X4/tldGfE/d2Mpkp+UJF9XLikShjutgAoJdWgeOuwN2EBVs/eg
 NQ9tQc8ybHf32h6gq2eHWPHDH2RI4gimAHo4eIhk54qtckNA18mVj4wqFqQuIiAwepB06r88iXs
 +jLv6d1twJpgJRMhu5oCR6MGqVW3dUHz0DMYeM7pkfBYu3s6lAwyGJEKL6KKlQWKfY55RwKC7vf
 j9dw39c0VVFSfQsl2xkDZ5eyEDNKSpD5xS+0FecCdCTXe2qR1tjNvh2hqp
X-Received: by 2002:a17:903:3bcb:b0:2a7:a9b8:ebae with SMTP id
 d9443c01a7336-2a951979e24mr20753165ad.58.1770364325975; 
 Thu, 05 Feb 2026 23:52:05 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9521b9f47sm14890555ad.53.2026.02.05.23.52.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 23:52:05 -0800 (PST)
Message-ID: <143b8d75-59aa-414c-b6cc-10018273e4f3@linaro.org>
Date: Thu, 5 Feb 2026 23:52:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Renaming targets
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
 <7645fcac-c4b2-4a9f-91c8-4990e9c92ef9@linaro.org>
 <5fd0062c-b474-4971-9a46-06af9ae4e0c7@linaro.org>
 <e1495603-4ac2-44bb-8b0d-74c45e5f2e66@linaro.org>
 <877bsr34au.fsf@pond.sub.org>
 <6ddad25a-192c-4b5a-80fc-b006436810a2@linaro.org>
 <878qd6xsrh.fsf_-_@pond.sub.org>
 <d293019a-218f-49d9-963d-6411c9b453a0@linaro.org>
 <87v7gawcd2.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87v7gawcd2.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/5/26 11:38 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 2/5/26 10:58 PM, Markus Armbruster wrote:
>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>
>>>> On 2/5/26 19:52, Markus Armbruster wrote:
> 
> [...]
> 
>>> Then SysEmuTarget has become misleading.
>>>
>>> We *can* fix that: QAPI type names are not part of the external
>>> interface by design.
>>
>> Do you mean it could be renamed to EmuTarget without any consequence?
> 
> Yes!
>

That's pretty good news. So yeah, it makes sense to extend it to 
represent all targets, including user ones.

>> It seemed to me that everything exported from the json files could
>> potentially be consumed by another entity (libvirt for instance).
> 
> No.  The QAPI schema ("the json files") is not meant for external
> consumption, and certainly not a stable interface.  The stable external
> interface is QMP introspection with query-qmp-schema.  I designed that
> command not to expose type names.  One of my smarter moves ;)
> 

😎
We can thank you, and you can thank yourself :)

Thanks,
Pierrick

