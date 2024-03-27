Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47422C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 15:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpVMB-0002wf-2m; Wed, 27 Mar 2024 11:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpVMA-0002wM-9b
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:38:26 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpVM8-0000eY-AZ
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:38:26 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5688eaf1165so9468209a12.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711553895; x=1712158695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gwn+mUFwKL0YnOadyJkEfzqkZ4KVxBgxXqoImdtJ3dw=;
 b=L+TgxBFv6o21UbWkPytFRiXBl5Bpkh1kNs6Q1VH3uCsXpjDNuGmdwwGQ0lPjU3KTpi
 cmSSRZC+Es5FyNAGOfsBucPMIRvqB3dI7IkCy4hNZYGKbt9Q5W8G3CCxbXgm+5Mgl8za
 tu3ewOEjSMOonpp7B/H7srVmqIwi6UVFg6QM/M9EC8bUnYZWqR3l1pMI3eMB67WVY90W
 Q6lkIhJt2sTKJvJDDIap3shlb3EzWWwuxid5lzy2dmc/BASGmNE5cvPuRXZcFvYNQwTG
 1cWJ2RKLSQTSep4qdXPCWW/BRmZqrfjFPBqO2cw69l6cH930HbYz3c0Fg3bjc/5Hj8Uq
 rMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711553895; x=1712158695;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gwn+mUFwKL0YnOadyJkEfzqkZ4KVxBgxXqoImdtJ3dw=;
 b=a9teQthcIBpE8k1lgpUPRNXu/9WDk41Jjof+d7x0I2uzyfufcmt7/9fmY6J87p9OZx
 IXX30ZR+U+7SUH7CfpxbzgoXn4n3+mqzmIqpdEW4fs4lObMWXX5HxKTTwNgQnAQJV3iw
 0PuMiDzB9+GtBPUZgK6b1Cd3zMjvRj9wh43WT+3k0te/tYAlqute+ebw5mzRu4ZGgC1K
 eis/UsIsrxUSrABoqKOdNkWWlFFLlC+D5ZOgbP2MTrMU5AbWQ7CrBT6hqUZIyHqIAR1N
 UtU94OJll6Dja2Zd9AjFmb/R0oFwuFvBo8qE6krBVgp6Rf9DjAy4DdQstHEeeCMy8hN9
 Hzgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWapPal+PftiNbEnDEZGGaSBlyJf91gfaxd+wYz2GL5yKZMyZGZ0qRK5o+jEXvY70vPtyKN+gBc6eRgkuI+JnSaENILqos=
X-Gm-Message-State: AOJu0YyUAxWbGR27hL7krBqu6mNhaffIzmlQCplBiLqSxpNXlcrq9WJw
 WwG9AvDFGCELM2vpxhUpGYC8GsKjJwSYkqt5whxBOVm0BMHceG1hhVh1fxlbcLk=
X-Google-Smtp-Source: AGHT+IEjTo/WTUTIiNIea5j1NfVkkAbYNZ71t6o8JbijhciDD4BVyGezcAKue4kb3VsOpllx5z/jCQ==
X-Received: by 2002:a50:ab15:0:b0:56b:a852:74b7 with SMTP id
 s21-20020a50ab15000000b0056ba85274b7mr145676edc.6.1711553895393; 
 Wed, 27 Mar 2024 08:38:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a056402018d00b0056c18b79cd3sm3043367edv.22.2024.03.27.08.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 08:38:14 -0700 (PDT)
Message-ID: <ba07096c-029c-4405-85df-005e89826242@linaro.org>
Date: Wed, 27 Mar 2024 16:38:13 +0100
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <LV8PR22MB455124393BD875586CBDBEE7E3342@LV8PR22MB4551.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 27/3/24 15:38, Aidan Leuck wrote:
> Hi Philippe,
> Thank you for your feedback I will get these issues addressed. I left one small comment on the QAPI schema JSON.
> 
> Aidan Leuck
> 
> -----Original Message-----
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Sent: Monday, March 25, 2024 11:51 AM
> To: Aidan Leuck <aidan_leuck@selinc.com>; qemu-devel@nongnu.org
> Cc: kkostiuk@redhat.com; berrange@redhat.com
> Subject: Re: [PATCH v3 2/2] Implement SSH commands in QEMU GA for Windows
> 
> [Caution - External]
> 
> On 22/3/24 18:46, aidan_leuck@selinc.com wrote:
>> From: Aidan Leuck <aidan_leuck@selinc.com>
>>
>> Signed-off-by: Aidan Leuck <aidan_leuck@selinc.com>
>> ---
>>    qga/commands-windows-ssh.c | 791
>> +++++++++++++++++++++++++++++++++++++
> 
> Huge file, I'm skipping it.
> 
>>    qga/commands-windows-ssh.h |  26 ++
>>    qga/meson.build            |   5 +-
>>    qga/qapi-schema.json       |  17 +-
>>    4 files changed, 828 insertions(+), 11 deletions(-)
>>    create mode 100644 qga/commands-windows-ssh.c
>>    create mode 100644 qga/commands-windows-ssh.h
> 
> 
>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json index
>> 9554b566a7..a64a6d91cf 100644
>> --- a/qga/qapi-schema.json
>> +++ b/qga/qapi-schema.json
>> @@ -1562,9 +1562,8 @@
>>    { 'struct': 'GuestAuthorizedKeys',
>>      'data': {
>>          'keys': ['str']
>> -  },
>> -  'if': 'CONFIG_POSIX' }
>> -
> 
> For Windows you have to check the CONFIG_WIN32 definition, so you want:
> 
> I don't think this is necessary, the QEMU guest agent is compiled for only POSIX and Windows. I don't see this pattern being used elsewhere in the qapi schema file. I would be interested in what the maintainers think?

$ git grep -w CONFIG_WIN32 qapi/
qapi/char.json:490:            { 'name': 'console', 'if': 'CONFIG_WIN32' },
qapi/char.json:663:                         'if': 'CONFIG_WIN32' },
qapi/misc.json:293:{ 'command': 'get-win32-socket', 'data': {'info': 
'str', 'fdname': 'str'}, 'if': 'CONFIG_WIN32' }

> 
>     'if': { 'any': [ 'CONFIG_POSIX',
>                      'CONFIG_WIN32' ] },
> 
>> +  }
>> +}
>>
>>    ##
>>    # @guest-ssh-get-authorized-keys:
>> @@ -1580,8 +1579,8 @@
>>    ##
>>    { 'command': 'guest-ssh-get-authorized-keys',
>>      'data': { 'username': 'str' },
>> -  'returns': 'GuestAuthorizedKeys',
>> -  'if': 'CONFIG_POSIX' }
>> +  'returns': 'GuestAuthorizedKeys'
>> +}
>>
>>    ##
>>    # @guest-ssh-add-authorized-keys:
>> @@ -1599,8 +1598,8 @@
>>    # Since: 5.2
>>    ##
>>    { 'command': 'guest-ssh-add-authorized-keys',
>> -  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' },
>> -  'if': 'CONFIG_POSIX' }
>> +  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' } }
>>
>>    ##
>>    # @guest-ssh-remove-authorized-keys:
>> @@ -1617,8 +1616,8 @@
>>    # Since: 5.2
>>    ##
>>    { 'command': 'guest-ssh-remove-authorized-keys',
>> -  'data': { 'username': 'str', 'keys': ['str'] },
>> -  'if': 'CONFIG_POSIX' }
>> +  'data': { 'username': 'str', 'keys': ['str'] } }
>>
>>    ##
>>    # @GuestDiskStats:
> 


