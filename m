Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEC1C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0he-00071F-0i; Mon, 05 May 2025 14:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC0hb-0006wF-TS
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:38:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC0ha-0005dk-5B
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:38:07 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22e331215dbso1306145ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746470284; x=1747075084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RwYDd4RfhGaF/Wo06IyJthgZAfsIBE7MtgTVTQlqvLA=;
 b=G4bN7r0xAI6WVWnr8IC6gFOat2lSyTRFD8QDlaqhRTCG/T0eUe6HhXEHGGjrqaAQsq
 S3lf6DmbAcrVk5u9NBpWFh5dHzKJ7bKONLAGyGf9loEd9gYfjiyWGrJftash8fjXCR6N
 5rx3A2LuuE7NSR3vn73EDDPDN/Fu3VVzMQhQ/kY4MZTb0QAkXt2JRL0NeQcSdMSXj+O8
 nzE5PdwC1eTbBtMhAo0uXcs9lhpohJLgc+/AopvwJIqe2kESaqD6drLJZ18djjsuRe5m
 ZxJJJThl7TglFJcaSC6KupW6AUwlDwhaECfMCHLVEDFa2hN3YOYykTN7oP66qGbQ3EuC
 pUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746470284; x=1747075084;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RwYDd4RfhGaF/Wo06IyJthgZAfsIBE7MtgTVTQlqvLA=;
 b=VghkS5IRTyG/koi3fqj2fVYITEHC00Yi41Ozfu/NKaT9UmAybQ0H0pOW9xrQnFVCyf
 /dE1bAPdK9spEiM/Cv9XhnwqsBigQ6kTKjo2C920DyuFKbuCAo+YcTQD2XmvorGR5vMB
 b7xbbmo+XYXC2gftMaFjprXV2UOThq4ZwVdjw5wdssp1dY2ne2O/Ek1kfQvYsoNz/YBs
 Wa31TSOde/ySuoei2lJ8PL1FKjiNZ73fAz4U0BV+6ib4pCGskKg7I8sS4/a07mD97Bre
 t04mpCq4EYP7oRDfSQtmpnSZzRC7rtXaxiFCqPnl132VKpjiuRSPUl9L9Qmu6ShS2HeV
 p8JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt1qn9nnO70A3qU3rLx48/6s80eWu4XGZaKofGZCIhlrHpZcrV8JeZxlNpWqM2pNDCaDP2yn2NlvAb@nongnu.org
X-Gm-Message-State: AOJu0Yy0naspH2wEYFfrxVwDcZeNKGkY5R/6d7ehIs6DOekUNlutivm1
 OxV04IInQ+MJAI+rdLs0WIJxIJyFPZVktr4iXuAbs1bYoNkvUKhakb59xPAXQKo=
X-Gm-Gg: ASbGncvByXhD2iqnv5xVJ8BRtP0d53W6e5bsOES5EGwxzGermTGO/ZfIQRPzqj4wjOs
 F6XKt29MMVpSFMYALZYYV2UMaC3s32ojsNOgd7A8Bq3IaS5Y269E2dcKofjIn02obF2tbL57Xd/
 lBNYzXa+Cnkb3G0b5RgClgLYmJcIoXrAzy1ON6t8qaqZifEQB57EvKMIRhBgh7c+16WDruiFA0d
 s8Vz/RH9GpuwKHfDERFXyp5Z+uLeCCmPCDVRjAStP2pgH+XLKEm4olL2LsXwxbsY7a940Y06oRb
 aZ+mDoflluIaZKpGhzexw+5OqNC+gn3oH84wuLLmn4cE879Sx9BuViYb6CzyIvSa
X-Google-Smtp-Source: AGHT+IHSCj6ho5NZbU6RnDbPmPsi2o/RSDYxs4tShAHE0kZUhd/TIDJiPd6vgJRtvzRbj4twnWAPEw==
X-Received: by 2002:a17:903:1ce:b0:223:517a:d4ed with SMTP id
 d9443c01a7336-22e3279fc6cmr6808815ad.15.1746470283962; 
 Mon, 05 May 2025 11:38:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e998bsm58599915ad.67.2025.05.05.11.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:38:03 -0700 (PDT)
Message-ID: <0a765d57-0c9a-4732-b560-203f03f903e9@linaro.org>
Date: Mon, 5 May 2025 11:38:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user: add option to enable plugins
Content-Language: en-US
To: Kyle Evans <kevans@FreeBSD.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 alex.bennee@linaro.org
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
 <0a39e805-eb75-4b88-b316-189acad38efa@linaro.org>
 <a7cc7e54-b84d-44e1-8c75-df39b44dd28f@FreeBSD.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a7cc7e54-b84d-44e1-8c75-df39b44dd28f@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/28/25 3:57 PM, Kyle Evans wrote:
> On 4/28/25 14:36, Pierrick Bouvier wrote:
>> On 3/31/25 4:42 PM, Pierrick Bouvier wrote:
>>> Nothing prevent plugins to be enabled on this platform for user
>>> binaries, only the option in the driver is missing.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    bsd-user/main.c | 12 ++++++++++++
>>>    1 file changed, 12 insertions(+)
>>>
>>> diff --git a/bsd-user/main.c b/bsd-user/main.c
>>> index fdb160bed0f..329bd1acc02 100644
>>> --- a/bsd-user/main.c
>>> +++ b/bsd-user/main.c
>>> @@ -175,6 +175,9 @@ static void usage(void)
>>>               "-strace           log system calls\n"
>>>               "-trace            [[enable=]<pattern>][,events=<file>]
>>> [,file=<file>]\n"
>>>               "                  specify tracing options\n"
>>> +#ifdef CONFIG_PLUGIN
>>> +           "-plugin           [file=]<file>[,<argname>=<argvalue>]\n"
>>> +#endif
>>>               "\n"
>>>               "Environment variables:\n"
>>>               "QEMU_STRACE       Print system calls and arguments
>>> similar to the\n"
>>> @@ -225,6 +228,8 @@ static void init_task_state(TaskState *ts)
>>>        };
>>>    }
>>> +static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
>>> +
>>>    void gemu_log(const char *fmt, ...)
>>>    {
>>>        va_list ap;
>>> @@ -307,6 +312,7 @@ int main(int argc, char **argv)
>>>        cpu_model = NULL;
>>>        qemu_add_opts(&qemu_trace_opts);
>>> +    qemu_plugin_add_opts();
>>>        optind = 1;
>>>        for (;;) {
>>> @@ -399,6 +405,11 @@ int main(int argc, char **argv)
>>>                do_strace = 1;
>>>            } else if (!strcmp(r, "trace")) {
>>>                trace_opt_parse(optarg);
>>> +#ifdef CONFIG_PLUGIN
>>> +        } else if (!strcmp(r, "plugin")) {
>>> +            r = argv[optind++];
>>> +            qemu_plugin_opt_parse(r, &plugins);
>>> +#endif
>>>            } else if (!strcmp(r, "0")) {
>>>                argv0 = argv[optind++];
>>>            } else {
>>> @@ -433,6 +444,7 @@ int main(int argc, char **argv)
>>>            exit(1);
>>>        }
>>>        trace_init_file();
>>> +    qemu_plugin_load_list(&plugins, &error_fatal);
>>>        /* Zero out regs */
>>>        memset(regs, 0, sizeof(struct target_pt_regs));
>>
>> Gentle ping on this series.
>> As we didn't have any feedback from BSD side, could we consider to
>> enable this upstream?
>>
> 
> Sorry- I have no strong opinion on plugins, but the diff looks
> incredibly reasonable and non-invasive.  I'm not really seeing any
> reason we'd object, but I don't personally feel qualified to review this
> (except as a basic human C linter- I can't imagine the added calls
> breaking anything we rely on).
> 

@Alex, would you be open to enable this, as it concerns plugins?

> Thanks,
> 
> Kyle Evans


