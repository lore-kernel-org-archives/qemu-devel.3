Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4FDC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 16:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpW2M-0001Za-36; Wed, 27 Mar 2024 12:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpW2K-0001ZP-3A
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:22:00 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpW2I-0002n6-5V
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:21:59 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-513e14b2bd9so8337162e87.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 09:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711556516; x=1712161316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ObErb2qEXgj4jZCyI+Dn2/vo8Ij3FjndmPOuCaPHb8=;
 b=JtuKqp4jAb79V8tScJBHj2c5j3IqOOoizUu9jeWmfIAll8sIlgqfJwH/ii8LV9Y+Ff
 M7/6QkPgsyj3VpJIq2XIa6zvmz1RLadl8tPxTjd7M77X4SEpHfnDpB8TFx7KiAQ8zIdA
 Y7FV9fExg+wR3COm5SfSH6xBvNoruemC7r28dXBvuNNkyovBIlP81ql+NhsbAkUD9oD8
 4flLj3h/Dak9NXcOMSX3TzclMEoYKw7pTPbs5fRpkJvaFCV8y0Qbm52JQ1vPDBGkL9+k
 EUUCDkkSqoeGt62VB40GiuXEDiFT/nsz0o+PecjlGmZtJ7GXLIoDCLovI3d6IklO+BdV
 Sgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711556516; x=1712161316;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ObErb2qEXgj4jZCyI+Dn2/vo8Ij3FjndmPOuCaPHb8=;
 b=vRBe60EOVspJPi1kWm/OvohID2oEWEjLSPeoc/DVRucHTrsJgytojrX+v2rrmPrk8s
 NdnNQfGQJs+sk4zNAz+xZN98NiWyHmEmsDy688xYi11nW1+Kh0vIiwz6xVTHEDKzYVZ7
 zMPvE3/RTbAF7+LYSiHm7tGSXsRPPRXyB2Nonb2pK5vQTQSZDAlgQtkYrgwttQQQwDAp
 mq8LULhVH45fF3QX9FQ/K316fEubZ+rh3duE86Th+zQGJuc5o2lMR0yDxSpXCIFT6qnt
 Hn4fm/Q0CxfIf3i9qlAZCdvX21EPh/zrDbgdgORt9UPziXM84DSwyEVUN0ExJIeOAkuy
 OywQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmHEHerENCXjbFzHUJ52AhkbkyjlqaGDb1trfHipwhYWGQlD57QR0TkWdFXRzgPH0M5leLw/T91WZsG7doZWovE1QT3sU=
X-Gm-Message-State: AOJu0YwzONaqDlCGYBQuV4yEP7NLQmmmp97iMpOuMwWaBt1OKFFgYbLy
 sx2w7V8PY6L6nZhZZfHFx0eaTnUo9gQpqeIhSTvLADu4S+WS8dqBVk66FG+2izM=
X-Google-Smtp-Source: AGHT+IFpIcC6JlifgX3+5u58q8SxGR0T1fpBCzTdafH4SRXUCwSjLPjA1nDOcpn2J7/XLQe9tRNrVQ==
X-Received: by 2002:a05:6512:e98:b0:515:baee:584a with SMTP id
 bi24-20020a0565120e9800b00515baee584amr3992011lfb.40.1711556516083; 
 Wed, 27 Mar 2024 09:21:56 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a056402148600b0056c1cee7a37sm2691110edv.67.2024.03.27.09.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 09:21:55 -0700 (PDT)
Message-ID: <e8f340d9-ce1d-4b73-91e8-405d139fd3b4@linaro.org>
Date: Wed, 27 Mar 2024 17:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Implement SSH commands in QEMU GA for Windows
To: Aidan Leuck <aidan_leuck@selinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: "kkostiuk@redhat.com" <kkostiuk@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20240322174637.499113-1-aidan_leuck@selinc.com>
 <20240322174637.499113-3-aidan_leuck@selinc.com>
 <330d90fc-e5ff-4b7d-a01f-5587274a5f2a@linaro.org>
 <LV8PR22MB455124393BD875586CBDBEE7E3342@LV8PR22MB4551.namprd22.prod.outlook.com>
 <ba07096c-029c-4405-85df-005e89826242@linaro.org>
 <LV8PR22MB4551451CC99AA21DE5562241E3342@LV8PR22MB4551.namprd22.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <LV8PR22MB4551451CC99AA21DE5562241E3342@LV8PR22MB4551.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

On 27/3/24 16:54, Aidan Leuck wrote:

>> On 22/3/24 18:46, aidan_leuck@selinc.com wrote:
>>> From: Aidan Leuck <aidan_leuck@selinc.com>
>>>
>>> Signed-off-by: Aidan Leuck <aidan_leuck@selinc.com>
>>> ---
>>>     qga/commands-windows-ssh.c | 791
>>> +++++++++++++++++++++++++++++++++++++
>>
>> Huge file, I'm skipping it.
>>
>>>     qga/commands-windows-ssh.h |  26 ++
>>>     qga/meson.build            |   5 +-
>>>     qga/qapi-schema.json       |  17 +-
>>>     4 files changed, 828 insertions(+), 11 deletions(-)
>>>     create mode 100644 qga/commands-windows-ssh.c
>>>     create mode 100644 qga/commands-windows-ssh.h
>>
>>
>>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json index
>>> 9554b566a7..a64a6d91cf 100644
>>> --- a/qga/qapi-schema.json
>>> +++ b/qga/qapi-schema.json
>>> @@ -1562,9 +1562,8 @@
>>>     { 'struct': 'GuestAuthorizedKeys',
>>>       'data': {
>>>           'keys': ['str']
>>> -  },
>>> -  'if': 'CONFIG_POSIX' }
>>> -
>>
>> For Windows you have to check the CONFIG_WIN32 definition, so you want:
>>
>> I don't think this is necessary, the QEMU guest agent is compiled for only POSIX and Windows. I don't see this pattern being used elsewhere in the qapi schema file. I would be interested in what the maintainers think?
> 
> $ git grep -w CONFIG_WIN32 qapi/
> qapi/char.json:490:            { 'name': 'console', 'if': 'CONFIG_WIN32' },
> qapi/char.json:663:                         'if': 'CONFIG_WIN32' },
> qapi/misc.json:293:{ 'command': 'get-win32-socket', 'data': {'info':
> 'str', 'fdname': 'str'}, 'if': 'CONFIG_WIN32' }
> 
>>
>>      'if': { 'any': [ 'CONFIG_POSIX',
>>                       'CONFIG_WIN32' ] },
>>
>>> +  }
>>> +}
>>>
>>>     ##
>>>     # @guest-ssh-get-authorized-keys:
>>> @@ -1580,8 +1579,8 @@
>>>     ##
>>>     { 'command': 'guest-ssh-get-authorized-keys',
>>>       'data': { 'username': 'str' },
>>> -  'returns': 'GuestAuthorizedKeys',
>>> -  'if': 'CONFIG_POSIX' }
>>> +  'returns': 'GuestAuthorizedKeys'
>>> +}
>>>
>>>     ##
>>>     # @guest-ssh-add-authorized-keys:
>>> @@ -1599,8 +1598,8 @@
>>>     # Since: 5.2
>>>     ##
>>>     { 'command': 'guest-ssh-add-authorized-keys',
>>> -  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' },
>>> -  'if': 'CONFIG_POSIX' }
>>> +  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' } }
>>>
>>>     ##
>>>     # @guest-ssh-remove-authorized-keys:
>>> @@ -1617,8 +1616,8 @@
>>>     # Since: 5.2
>>>     ##
>>>     { 'command': 'guest-ssh-remove-authorized-keys',
>>> -  'data': { 'username': 'str', 'keys': ['str'] },
>>> -  'if': 'CONFIG_POSIX' }
>>> +  'data': { 'username': 'str', 'keys': ['str'] } }
>>>
>>>     ##
>>>     # @GuestDiskStats:
>>
> Hi Philippe, thank you for getting back to me so quickly. Looking at the grep you gave me seems to confirm what I was saying if I am not mistaken? It looks like CONFIG_WIN32 and CONFIG_POSIX if conditionals are only used when you need to enable a command on one operating system and not the other. I do believe that your code snippet is correct it is just overly verbose. The QGA has both windows and SSH implementations and looking at the guest agent QAPI file when a command supports both POSIX and Windows the if gate is removed. I am happy to discuss this further if you have more concerns.

Well, as you said, up to the maintainers.

Regards,

Phil.

