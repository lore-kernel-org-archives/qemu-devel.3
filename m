Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED8FC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 12:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOynq-0003dE-Gc; Wed, 03 Jul 2024 08:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOynb-0003ZM-Sh
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:09:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOynS-0004wv-Pz
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:09:23 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4255fa23f7bso37231145e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720008553; x=1720613353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V06lt4S1I/ODZ7NEo+FlXlQXX4attX79HE+3wkPLZhY=;
 b=G25DSGF2x6DNwHxCuce/9pSgVpm9WtmmCBlU7qRYt6lSReMBOO8RjSkiBMQDCfu3Hr
 7BJy0zjtgzymtzWsUKb7Y4S32FUd36yizhiAPtqGybXvdB8kIT1MBcPghiR5STzRguN3
 +6Qpi4KskyRXMSfKWh6oEB5xGmXOT8DB/Bwjca+JJvEBFaX49IcQXQnScIHugmyGmkEw
 FY9Epy7aUd6AkrR5x6Wv/knDQarjrmi7khTYjnEvPOEZd74gCGypi488wEgX82z6fRmG
 wlVsZFhSF/BN2WODLviaEwyY72LZQm0qyKEf0j/Ge3pXurCb5jbCqTml8sEhmZgWgGTi
 0VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720008553; x=1720613353;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V06lt4S1I/ODZ7NEo+FlXlQXX4attX79HE+3wkPLZhY=;
 b=bnPt3zoztG00eXq2amkjIdOojODl+91BrzgNqwy/VRX01fcPSZh5F4pv5kVMqyN3j6
 r0IPAM2ZzDYEOsVVd/HlBpmNNEhKip/jsN+C07eyqmUbx4DBKVinA/vjBDRem+uA/SJk
 lgMfiXEyKkAmLdTIy88WmGOeHoWRL8kAUfLVHlgNMbBu2CIdNehP0JfdphFJ5BmBdkQw
 Vmy8nVdwtc9WGiZrCZclJDjBoX2xzCJsdih34tv8JkjSRlEllmIRqifhS13JafXxU4eT
 4EWt2Nx5ajBMKsOQMM3oc5ysULKFv1mGn8Zy0o+JwPJOBWGG8ci7J0VhkwHPv6pjzS0l
 p3pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6F0TaNljQbQ0yaD1wCRU4Iav6ywpWS6M8AMZ0Z8zCfWB00qSRUt82HF/qY+H8SYFWL20r4EWIy7ZxiwX6YxHvfQKelH4=
X-Gm-Message-State: AOJu0YxM+D1gRaNyAhHcTCC1r6KqMcXqH6NDRwvFzZzGdst+kbrwes66
 0Q6yTanas85SJQ9vD4LBlrbIfFfdMt5KluPNpOF1Xx5aJrRLDLs1UajO2WZ3j2o=
X-Google-Smtp-Source: AGHT+IGgx4oSd/auaq0SZ6HiTHY13X8Q2s8/5mDn/uOtwX//k5AqrWpI5BnzG6mSj0iUBvgffNUdzw==
X-Received: by 2002:a05:600c:44c6:b0:424:a588:ff08 with SMTP id
 5b1f17b1804b1-4257a011192mr73955335e9.23.1720008553014; 
 Wed, 03 Jul 2024 05:09:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09890dsm237344155e9.36.2024.07.03.05.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 05:09:12 -0700 (PDT)
Message-ID: <a0aa44c2-f671-44c7-ba9c-d3e007de4fff@linaro.org>
Date: Wed, 3 Jul 2024 14:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/22] qga: centralize logic for disabling/enabling
 commands
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-17-berrange@redhat.com>
 <g1m2c.r93vk15jos2y@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <g1m2c.r93vk15jos2y@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 3/7/24 12:01, Manos Pitsidianakis wrote:
> Hello Daniel,
> 
> This cleanup seems like a good idea,
> 
> On Thu, 13 Jun 2024 18:44, "Daniel P. Berrangé" <berrange@redhat.com> 
> wrote:
>> It is confusing having many different pieces of code enabling and
>> disabling commands, and it is not clear that they all have the same
>> semantics, especially wrt prioritization of the block/allow lists.
>> The code attempted to prevent the user from setting both the block
>> and allow lists concurrently, however, the logic was flawed as it
>> checked settings in the configuration file  separately from the
>> command line arguments. Thus it was possible to set a block list
>> in the config file and an allow list via a command line argument.
>> The --dump-conf option also creates a configuration file with both
>> keys present, even if unset, which means it is creating a config
>> that cannot actually be loaded again.
>>
>> Centralizing the code in a single method "ga_apply_command_filters"
>> will provide a strong guarantee of consistency and clarify the
>> intended behaviour. With this there is no compelling technical
>> reason to prevent concurrent setting of both the allow and block
>> lists, so this flawed restriction is removed.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>> docs/interop/qemu-ga.rst |  14 +++++
>> qga/commands-posix.c     |   6 --
>> qga/commands-win32.c     |   6 --
>> qga/main.c               | 128 +++++++++++++++++----------------------
>> 4 files changed, 70 insertions(+), 84 deletions(-)


>> +static void ga_apply_command_filters(GAState *state)
> 
> Nit: inline?

No, consensus is today's compilers are smart enough to
notice inlining, developers shouldn't worry about this
anymore.

>> +{
>> +    qmp_for_each_command(&ga_commands, ga_apply_command_filters_iter, 
>> state);
>> +}


