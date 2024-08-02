Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB98C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZutI-0007MY-9e; Fri, 02 Aug 2024 12:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZutD-00074J-LV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:12:25 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZutB-0000bs-Jb
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:12:23 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5ab2baf13d9so11507736a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722615137; x=1723219937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w6lMpd/mk58x+BP/eh1vbRB8wIq5F4cRw0VBvVfXlKg=;
 b=r2EQdMsoU5FADnNlWzbifgsWeqkGxfsE7k4o0EBpChUJDAIjwnNiTmE7PvAafpv2Lv
 MCfnc74/vr2GavdHL2r5jSsJgbPAoHp8t1n86IUE2b7SOoHVNrFsPipiKH7LW52WsUP6
 R220pa5arpy5A+yNVKyqv2FMa1xpSpQxU+iJn2h+q7T4waJBDXQJhL8Y2igDXFx1S6Eh
 rqMrcTuZAyvblAsSWuNHRT9oWG7EdpxkMFoyGJPt4cAOMNHjiH3QgQgSKFMrTLIt9AP6
 KHKLzbZKCmqz0UatS7AW7WjkuRBLLGjEby3UqGe7tjrFlbb7p64eRsD6IaGaU2mQA3e9
 DO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722615137; x=1723219937;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6lMpd/mk58x+BP/eh1vbRB8wIq5F4cRw0VBvVfXlKg=;
 b=Zzv9mmGdwHEhLsmSWWwgp62/2BEvEJxdo/NPm4eSzyEIoT9fwjZp1R+Kqi12y+uXgD
 z7izgXgRGQO4ZOwtphnF2ZHWfdWT2K9JfcDyJZMnCzp6r2OOVAmlSQbtWvJ2Z549lgEK
 nfHOefxJ5MY5d3Ze0cst1L8qrLYNoV7wYC8/S2/0KeWoicq/23frM4BxXms10k/iD0zO
 lwGPoTK4ok4ZlxxRRxEzRNW2KMRuAOlk6jdeOFDt9XkDcioj3D6f8dHkSpTYPaavMme8
 kJ3Ou+OI3joMroYpWc/VPL4vK2UwqVkt5CPY6lax/10tDPRtZYslh9uEXaOg1Zdgp3qQ
 nV0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGSAYqWeH/CU0rI4hXUBQLhwVqnaNq09roJPCWlYBWPlPKlH5C4myVX1277YZ47E9RG7c4NrxU9qU32L3hcVExnhH69es=
X-Gm-Message-State: AOJu0YzAatCTuvlEKoawjTUkNcBqq1+vbpJKSweKh031qrESERIAj8Lw
 3A7JrYo9akqFZdwzQtrwJoB4BIhP8gNw5gnoqsuNSgw4+g/q42L8g1i29wAS5Ig=
X-Google-Smtp-Source: AGHT+IGzyU8l374ALhTybXTojUIf4nWgyeBdLVj9DYAXasbnb5SJPsb8qz/5CFLmLZnnQmYOUWZ5Jg==
X-Received: by 2002:a05:6402:549:b0:5a1:5dce:3427 with SMTP id
 4fb4d7f45d1cf-5b7f56fe9d4mr3177960a12.23.1722615136442; 
 Fri, 02 Aug 2024 09:12:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83960f101sm1279359a12.20.2024.08.02.09.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 09:12:16 -0700 (PDT)
Message-ID: <7fba140f-ed8f-4faf-8887-6bbac9d6a447@linaro.org>
Date: Fri, 2 Aug 2024 18:12:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/24] tests/functional: Convert the acpi-bits test
 into a standalone test
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-23-berrange@redhat.com>
 <37b06e6c-ed74-4782-8a47-5205d81e0a00@linaro.org>
Content-Language: en-US
In-Reply-To: <37b06e6c-ed74-4782-8a47-5205d81e0a00@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 2/8/24 18:10, Philippe Mathieu-Daudé wrote:
> On 30/7/24 19:03, Daniel P. Berrangé wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Mostly a straight-forward conversion. Looks like we can simply drop
>> the avocado datadrainer stuff when not using the avocado framework
>> anymore.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   .../acpi-bits/bits-config/bits-cfg.txt        |  0
>>   .../acpi-bits/bits-tests/smbios.py2           |  0
>>   .../acpi-bits/bits-tests/smilatency.py2       |  0
>>   .../acpi-bits/bits-tests/testacpi.py2         |  0
>>   .../acpi-bits/bits-tests/testcpuid.py2        |  0
>>   tests/functional/meson.build                  |  2 +
>>   .../test_acpi_bits.py}                        | 81 ++++++++++---------
>>   7 files changed, 43 insertions(+), 40 deletions(-)
>>   rename tests/{avocado => 
>> functional}/acpi-bits/bits-config/bits-cfg.txt (100%)
>>   rename tests/{avocado => functional}/acpi-bits/bits-tests/smbios.py2 
>> (100%)
>>   rename tests/{avocado => 
>> functional}/acpi-bits/bits-tests/smilatency.py2 (100%)
>>   rename tests/{avocado => 
>> functional}/acpi-bits/bits-tests/testacpi.py2 (100%)
>>   rename tests/{avocado => 
>> functional}/acpi-bits/bits-tests/testcpuid.py2 (100%)
>>   rename tests/{avocado/acpi-bits.py => functional/test_acpi_bits.py} 
>> (86%)
>>   mode change 100644 => 100755
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

(missing MAINTAINERS update)

