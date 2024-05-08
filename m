Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42162C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 14:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hqZ-00052o-Si; Wed, 08 May 2024 10:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s4hqY-0004yp-Ai
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s4hqW-0000TW-CB
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715176834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=si9nm3AmbOJKXsX+fbPRPFE992Qm4DlAopUlu5SVrVU=;
 b=Z7jsu05RfXO6RnB+4JeAzMvLvJLTTQ2tQ+7VgmCLsc1mifh9rSfXq8RL3HqWwk0TCgLMha
 gnG2cbpmkE1aycv8EDkCh3/vfEKWb8b6WdFSNVC0cu2jkuVSnbfFKJF68D3WFQIDc1uhea
 5PJvhMwwtKRtu8M2jtSXCNWbHMkqKjM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-frsggikAM5aJjmfAKxDaLA-1; Wed, 08 May 2024 10:00:33 -0400
X-MC-Unique: frsggikAM5aJjmfAKxDaLA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41bd87bb458so32537195e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 07:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715176832; x=1715781632;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=si9nm3AmbOJKXsX+fbPRPFE992Qm4DlAopUlu5SVrVU=;
 b=HyIQ2KCuAJS33JfPRDVJQV+xoEA06a01+lLHknWW274XDpVtkVQvUDm9wrg3a4leCX
 befo/dEUhPBvclUjDoWqykNSsfbfy9HHfohpWlaMVSU7l+8+TOJPgg/7sOgfqyrs6Xxu
 pb0tgJi6MxWkYM7hFFM64Q3IUA4AbYlUd0M/ZZtyy6IZ/fwKHk/LvoJLLQJqMj9qqv1x
 OciSemYi8+CN4Wc+btqpflrEqdP1j8WEtstwKCl2ZfDRHLnjak+4KSotLDKJNbXCGeaU
 MzBqqf7261OuDtcn8XVanmuWNpljHbIoofzL9V6Ah1oMxjVA52RCXUyv7P0ZErfPineG
 e6EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVds7Zs00MyXA22kjQ20GiNCdhZIwfmV8RXcbQe5TmT4N7oM5dyCi+iIHiGQ5urg4vnXi4EsBcOgfKRzUsfu2duqvHpNrA=
X-Gm-Message-State: AOJu0Ywtx7OSpUQodS3hWUFF3YmkwrZr//5qTBZpQD2eTTQjN6JhWK1s
 KpTZTgdQP66nWO3skH9mzcyUApaHyRdUnJ++4J7JdXVUKyO/fD5vKMVgdPVZ3m/4/0mrhN5r2TE
 wJrxuFiIYm5MRwRTs5cGhDC66gdosFEiMLCl9QFVPIaCFLCNOIF3P
X-Received: by 2002:a05:600c:35d0:b0:41c:8754:8793 with SMTP id
 5b1f17b1804b1-41f71bcaceemr24655065e9.41.1715176831768; 
 Wed, 08 May 2024 07:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc078ssKt4q+TcQQwoFh+Sc/JgzdRgYCKJqrdSlkgzC7ydLL0q/2CVN08ttCVGUwyi69u5gQ==
X-Received: by 2002:a05:600c:35d0:b0:41c:8754:8793 with SMTP id
 5b1f17b1804b1-41f71bcaceemr24654745e9.41.1715176831190; 
 Wed, 08 May 2024 07:00:31 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c3b8500b0041b43d2d745sm2413985wms.7.2024.05.08.07.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 07:00:28 -0700 (PDT)
Message-ID: <4f662f6b-f972-4d07-954f-1a733d52b4e1@redhat.com>
Date: Wed, 8 May 2024 16:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qemu-options: Deprecate "-runas" and introduce
 "-run-with user=..." instead
To: Claudio Fontana <cfontana@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: devel@lists.libvirt.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20240506112058.51446-1-thuth@redhat.com>
 <b39ca716-65eb-463e-bf30-6a07413d5d91@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b39ca716-65eb-463e-bf30-6a07413d5d91@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/05/2024 15.20, Claudio Fontana wrote:
> On 5/6/24 13:20, Thomas Huth wrote:
>> The old "-runas" option has the disadvantage that it is not visible
>> in the QAPI schema, so it is not available via the normal introspection
>> mechanisms. We've recently introduced the "-run-with" option for exactly
>> this purpose, which is meant to handle the options that affect the
>> runtime behavior. Thus let's introduce a "user=..." parameter here now
>> and deprecate the old "-runas" option.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v2: Add missing part in qemu-options.hx as suggested by Philippe
>>
>>   docs/about/deprecated.rst |  6 ++++++
>>   system/vl.c               | 15 +++++++++++++++
>>   qemu-options.hx           | 15 +++++++++++----
>>   3 files changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 3310df3274..fe69e2d44c 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -61,6 +61,12 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
>>   marked deprecated since 9.0, users have to ensure that all the topology members
>>   described with -smp are supported by the target machine.
>>   
>> +``-runas`` (since 9.1)
>> +----------------------
>> +
>> +Use ``-run-with user=..`` instead.
>> +
>> +
>>   User-mode emulator command line arguments
>>   -----------------------------------------
>>   
>> diff --git a/system/vl.c b/system/vl.c
>> index 7756eac81e..b031427440 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -773,6 +773,10 @@ static QemuOptsList qemu_run_with_opts = {
>>               .name = "chroot",
>>               .type = QEMU_OPT_STRING,
>>           },
>> +        {
>> +            .name = "user",
>> +            .type = QEMU_OPT_STRING,
>> +        },
>>           { /* end of list */ }
>>       },
>>   };
>> @@ -3586,6 +3590,7 @@ void qemu_init(int argc, char **argv)
>>                   break;
>>   #if defined(CONFIG_POSIX)
>>               case QEMU_OPTION_runas:
>> +                warn_report("-runas is deprecated, use '-run-with user=...' instead");
>>                   if (!os_set_runas(optarg)) {
>>                       error_report("User \"%s\" doesn't exist"
>>                                    " (and is not <uid>:<gid>)",
>> @@ -3612,6 +3617,16 @@ void qemu_init(int argc, char **argv)
>>                   if (str) {
>>                       os_set_chroot(str);
>>                   }
>> +                str = qemu_opt_get(opts, "user");
>> +                if (str) {
>> +                    if (!os_set_runas(str)) {
>> +                        error_report("User \"%s\" doesn't exist"
>> +                                     " (and is not <uid>:<gid>)",
>> +                                     optarg);
>> +                        exit(1);
>> +                    }
>> +                }
>> +
>>                   break;
>>               }
>>   #endif /* CONFIG_POSIX */
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index cf61f6b863..3031479a15 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4824,7 +4824,8 @@ DEF("runas", HAS_ARG, QEMU_OPTION_runas, \
>>   SRST
>>   ``-runas user``
>>       Immediately before starting guest execution, drop root privileges,
>> -    switching to the specified user.
>> +    switching to the specified user. This option is deprecated, use
>> +    ``-run-with user=...`` instead.
>>   ERST
>>   
>>   DEF("prom-env", HAS_ARG, QEMU_OPTION_prom_env,
>> @@ -4990,13 +4991,15 @@ DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
>>   
>>   #ifdef CONFIG_POSIX
>>   DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
>> -    "-run-with [async-teardown=on|off][,chroot=dir]\n"
>> +    "-run-with [async-teardown=on|off][,chroot=dir][user=username|uid:gid]\n"
>>       "                Set miscellaneous QEMU process lifecycle options:\n"
>>       "                async-teardown=on enables asynchronous teardown (Linux only)\n"
>> -    "                chroot=dir chroot to dir just before starting the VM\n",
>> +    "                chroot=dir chroot to dir just before starting the VM\n"
>> +    "                user=username switch to the specified user before starting the VM\n"
>> +    "                user=uid:gid dito, but use specified user-ID and group-ID instead\n",
> 
> nit: ditto?

Thanks, I'll fix it!

  Thomas



