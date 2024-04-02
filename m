Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEAECD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrclU-0005rb-8n; Tue, 02 Apr 2024 07:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrclE-0005lU-HV
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:57:07 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrckY-0000JF-KP
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:57:03 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33eee0258abso2660863f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712058979; x=1712663779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ewqx4Uvl/oBCmoJvyI88W/pOXqfPrSBf5ZBQ4gQFf+E=;
 b=cWFq8BtRGWXfvEXC6y133nholPtA33YNusJAVMK7myDXkKTFtvcFPblpFYgutHsoK3
 r2bTVm+xwVR8UAFVN9i0471ilDPsYmt5LJW2XK0kKp8hAhkjEYFjwTL3bMzv2+HD2eRM
 zS/u5dmZfQEHCkzqAmt9P+AAM5ml//wQko2DZBzDyf+O1lk/WU0BZMgeyEAGspzvyQtj
 W3aTHrJBWH/cA1lX7pLX9rOIFgzPklWF6I6cAsBj64kzbDu9hc8VRGd11R8v+vYIlHCE
 7GwWduWSbgXUQUcB+buVHaR/Y7Tftvo5iD1fFcEaaPgq7Rti9z0u1W9VJ2NrbFS/a/Fj
 T/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712058979; x=1712663779;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ewqx4Uvl/oBCmoJvyI88W/pOXqfPrSBf5ZBQ4gQFf+E=;
 b=Am36URHKUVcCAO42jTteYTjqDUmbZBFPh7qerNSFEmfQ++0ayjrfksTCkX67jas89s
 fZxJswd0vQl4DYF1j3haqcw7GLpHbg8IJ0zJRa/1JTYWdtyETtcKCCZ/BxtHALDvN3/2
 YDGcJ7fHWm39jsAS+rddSXI7Qcs7bcNbI3NUPrncyAg8POpkZxoP15pLeXAkszh2rmz+
 oeZCCdBclKte01AXzFlSTI6r+I+D2ANHk/uvSu8gu13biCco4hKsI41Up484TtNZuKY/
 1ZbWbVNCGJoAAST7ZUb9GEr4YbmJfOtT66pWUVoYe7WJOlBrO1RTTitpeYyBmiAVIiO6
 ht2A==
X-Gm-Message-State: AOJu0YycqC50c7DXYu7KXArmJ30MGrXPrqz5pIlWm+1Jft0S8FiWZTqk
 PCdy6CJ0vbACuOo9+jXtQSUCjW3nUnJDT9mXtO4+8Cc7ABDJmKzMOYOvP3mJQVg=
X-Google-Smtp-Source: AGHT+IFyTmzqfyXOD3jT0/gGjHMU7FhVvXx6cPPz4UxJnhPUDcwUPOZWHsNDD9SX6crfwSHQxngL2g==
X-Received: by 2002:a5d:6b46:0:b0:33e:34b7:895f with SMTP id
 x6-20020a5d6b46000000b0033e34b7895fmr8005368wrw.24.1712058979497; 
 Tue, 02 Apr 2024 04:56:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a05600003ca00b00341c563aacbsm14260816wrg.1.2024.04.02.04.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 04:56:19 -0700 (PDT)
Message-ID: <f4a2a317-d910-4034-8f39-3731b941e36e@linaro.org>
Date: Tue, 2 Apr 2024 13:56:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scripts/checkpatch: Avoid author email mangled by
 qemu-trivial@
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Stefan Weil <sw@weilnetz.de>
References: <20240402113015.66280-1-philmd@linaro.org>
 <20240402113015.66280-2-philmd@linaro.org>
 <CAFEAcA8iCdNOdnrqY+7yupUvxQQfCLh17WRHZ6zFhVQrB4CXgg@mail.gmail.com>
 <8dd44a53-f16d-4fc1-bc08-fcd1af5e57a4@linaro.org>
Content-Language: en-US
In-Reply-To: <8dd44a53-f16d-4fc1-bc08-fcd1af5e57a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 2/4/24 13:53, Philippe Mathieu-Daudé wrote:
> On 2/4/24 13:52, Peter Maydell wrote:
>> On Tue, 2 Apr 2024 at 12:30, Philippe Mathieu-Daudé 
>> <philmd@linaro.org> wrote:
>>>
>>> Commit f5177798d8 ("scripts: report on author emails
>>> that are mangled by the mailing list") added a check
>>> for qemu-devel@ list, complete with qemu-trivial@.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   scripts/checkpatch.pl | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> index 7026895074..4fe4cfd631 100755
>>> --- a/scripts/checkpatch.pl
>>> +++ b/scripts/checkpatch.pl
>>> @@ -1573,7 +1573,7 @@ sub process {
>>>                          $is_patch = 1;
>>>                  }
>>>
>>> -               if ($line =~ /^(Author|From): .* via 
>>> .*<qemu-devel\@nongnu.org>/) {
>>> +               if ($line =~ /^(Author|From): .* via 
>>> .*<qemu-(devel|trivial)\@nongnu\.org>/) {
>>
>> I recommend checking against qemu-.* rather than trying
>> to capture explicitly all the suffixes we have. (For instance
>> there's a line in mailmap for a commit that was attributed
>> to qemu-block@, which this change still wouldn't catch.)
> 
> Oh, good point.

And also qemu-ppc@nongnu.org:

commit 5cbd51a5a58098444ffa246ece2013849be04299
Author: BALATON Zoltan via <qemu-ppc@nongnu.org>
Date:   Sun Jan 3 02:09:33 2021 +0100


