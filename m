Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE6CC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8Pv-0005lf-Tn; Mon, 03 Jun 2024 10:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE8Pt-0005lJ-Ec
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:12:05 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE8Pr-0000pI-E4
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:12:05 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57a32b0211aso3895061a12.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717423918; x=1718028718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DlSUWfEVLvtJdjyRCcCPS1n94AQWY9Us2l2aMVIJj7Y=;
 b=SzMNJx8KSWQlogLtdH66hLxHIocYgiCThTzJuf8Gw/q+a1NVbbYlDuSDvy7mMgc1Ye
 Z3znz+k7356hZZssvQVzR5Ke70/ldPg5MgkK4TQDfafcFvwoGmsNhbCAMFD4xm2g3NKz
 z/g633F3SkTGgbmvsNI3GYYNjmiRGwXq+MKyJRPTjlKaeSTR3pguBeEvNeIfwj8d0LF+
 SZrJnsmWeBeftxGrlp3ag5IjbKQGPtMC9hO3miouJRBADAcVqPyI7NsC2ONfwhQJIwoW
 tQ6I+vAqxWe3Xsd/YAm6XSU4KTGLo+3Y0sa7/Am9YaeJ9ZqJqp2FR88k2H2FOeRpCLxc
 ZLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717423918; x=1718028718;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DlSUWfEVLvtJdjyRCcCPS1n94AQWY9Us2l2aMVIJj7Y=;
 b=JGGjiR50q7w79XgcU1XgboEIgOH6lI8Dq98Gdw1e3AKexoYIa6kbT+wG7J1GuhoDUc
 8rwEGcgF2YNakwZp86e2LTqOmsOPKF0iQrQgH3/wCqDKMeOs+pEhIHduUp0aREuv+d2z
 /VJT0ye0NvHDeUb/vmbf+aD6TOBVoIrYTfa2v4zzgrdoBzBy9du/vUJ7hfJL5mE9Wmh7
 M3BwTBjIsDgVWrtGwE+iSMhjl4AYjCy+8W6ecyippxCPd0louUoDA1u6d0gBiioU8zSt
 pkkJUp5h7ILi2WGrR8jc9z/G2r1vbOvYsPrb/As8bs1GGq31QsxS/pstEcnsiBrfuu/6
 Dkuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGaf23DRcTijqxxPWvuuWeShEUEcag1S6lqUVEnT6bTxZSvHXX5o1RAzV1jWTRxIg+mKYhsYVJ6yjYYc8dNP8dgQxkiNU=
X-Gm-Message-State: AOJu0YzPpUzjv6KuTptRzH6w7QgNBp3+JmrvTmzJmIyi/pYx50kIKSTw
 kbCAMVznDC2H5QcAAGC+RXraNtOd9DvK/YhKpgksRhHhDbsM8iJFfmud81qdXUA=
X-Google-Smtp-Source: AGHT+IGdr5CBYOZFF6Lat26v/7tlPWLGgyXS6UBb1RiZVlrTdk8rnBJQ5k0EYqfvZ4PIW3CG1qkc9A==
X-Received: by 2002:a50:bac6:0:b0:572:6846:b899 with SMTP id
 4fb4d7f45d1cf-57a3658b28fmr5068095a12.41.1717423917639; 
 Mon, 03 Jun 2024 07:11:57 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a61b4e36dsm1653858a12.75.2024.06.03.07.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 07:11:57 -0700 (PDT)
Message-ID: <750b1cd7-6b16-464d-8229-46a4b5f4e022@linaro.org>
Date: Mon, 3 Jun 2024 16:11:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] plugins: remove special casing for cpu->realized
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Reinoud Zandijk
 <reinoud@netbsd.org>, kvm@vger.kernel.org,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-5-alex.bennee@linaro.org>
 <0a76250f-db5b-4c94-941a-cbec1f2e1db6@linaro.org>
Content-Language: en-US
In-Reply-To: <0a76250f-db5b-4c94-941a-cbec1f2e1db6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/6/24 13:31, Philippe Mathieu-Daudé wrote:
> On 30/5/24 21:42, Alex Bennée wrote:
>> Now the condition variable is initialised early on we don't need to go
>> through hoops to avoid calling async_run_on_cpu.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   plugins/core.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/plugins/core.c b/plugins/core.c
>> index 0726bc7f25..badede28cf 100644
>> --- a/plugins/core.c
>> +++ b/plugins/core.c
>> @@ -65,11 +65,7 @@ static void plugin_cpu_update__locked(gpointer k, 
>> gpointer v, gpointer udata)
>>       CPUState *cpu = container_of(k, CPUState, cpu_index);
>>       run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
>> -    if (DEVICE(cpu)->realized) {
> 
> We could assert() this to protect future refactors.

(No we can't because vCPU can still be unrealized at this point).

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> -        async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
>> -    } else {
>> -        plugin_cpu_update__async(cpu, mask);
>> -    }
>> +    async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
>>   }
>>   void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
> 


