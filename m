Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D457C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk6Wb-0004uY-1X; Tue, 12 Mar 2024 14:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk6WV-0004qH-Ow
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:06:49 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk6WU-0004Dx-6Z
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:06:47 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-513173e8191so6186555e87.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710266803; x=1710871603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xR5iGUQZiCoR8k2pSi0KOW7ASeWFuNA9cHveRST8/e8=;
 b=FnazQzBcj56hv9Iz8Ya85ajgHriYyG2Kb3epCRKQIIcMMQIE8yWi6NtWJX5L7t/iv9
 JXhcUoqhM+FqYNf1uyJ9/gjyNLf53KSwoUxZmviElKSk56p2Oi6Wme6QAsPxINBlB4SY
 SLVWjboMplwOsNhfehcXGePyiD8pYLRBPm0NNMikTh2SLvcf9gopuJSe190EPmL2q3Tc
 nAKwsayusUkjeOFLbOzaeNxvDzjVwtD+xPgwMWUsz7SVPKkrNnM1mUs6LqJ2tZsRia4n
 Xv+W3F7tOIxiISihwVq6xRCMFWxRyMwMSevF/NiBhwzagpjXrcX7bHIU5EYSwAGU61Rl
 l0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710266803; x=1710871603;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xR5iGUQZiCoR8k2pSi0KOW7ASeWFuNA9cHveRST8/e8=;
 b=tC1VTpBVIgPVDZqVRXLIQFiiwnX3zzZc15Q0AKW+XvlcTShQhaUhjvoGbGt03z72/t
 JuEEqLkyavtrdsFP0cI4g3QDbSLTtaZMPmh8be01a0LL8K+tRYBhZvdsb65aLgrPenmB
 il9i9kHR1BLak6WbGrUm5LstpX/H9cFE4tg1/+dzkWGik0rMDlXLN9c2F7jQsO87FKFm
 1OXL7b36nhJKlFhlExZxwBQluNRIMclEGaw8072FswbdzbKa4JH+c5VVI4yGcp8BuJ72
 xtKs88N6NPDIgOHc5kKPB9+4LTXXF1Y2YVEqBv5sdPe/P8NxoxVbFDZ/zBQdVciW8K00
 7PWg==
X-Gm-Message-State: AOJu0YwQxRBjynCWHVWOzEVXcUVOA0vD8mPU5k55saPstBlX70/8mezu
 zCwSiCtSWmxtEDbYe1pfhnuOrf+13MXMxBTWsWDvtlNITy75S6YcvSLplfJcnas=
X-Google-Smtp-Source: AGHT+IGlEBG40OBhYaUrcYn7hzV7aIkFm7Gb8sYx514Q95Jbzc32qkiM+I91vty2BOw9gju8nB1Z9w==
X-Received: by 2002:ac2:4da7:0:b0:513:b062:98bf with SMTP id
 h7-20020ac24da7000000b00513b06298bfmr535934lfe.20.1710266802251; 
 Tue, 12 Mar 2024 11:06:42 -0700 (PDT)
Received: from [192.168.122.175] (93.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.93]) by smtp.gmail.com with ESMTPSA id
 f6-20020a05600c154600b004131ae36ac4sm15361917wmg.20.2024.03.12.11.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 11:06:41 -0700 (PDT)
Message-ID: <4b17e2fa-3b6c-4c7e-a888-661d1bf1324b@linaro.org>
Date: Tue, 12 Mar 2024 18:51:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] qapi: Correct error message for 'vcpu_dirty_limit'
 parameter
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
 <20240312141343.3168265-9-armbru@redhat.com> <ZfB0Oq7SSQgiqbz5@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZfB0Oq7SSQgiqbz5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 12/3/24 16:26, Zhao Liu wrote:
> On Tue, Mar 12, 2024 at 03:13:41PM +0100, Markus Armbruster wrote:
>> Date: Tue, 12 Mar 2024 15:13:41 +0100
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: [PATCH 08/10] qapi: Correct error message for 'vcpu_dirty_limit'
>>   parameter
>>
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> QERR_INVALID_PARAMETER_VALUE is defined as:
>>
>>    #define QERR_INVALID_PARAMETER_VALUE \
>>        "Parameter '%s' expects %s"
>>
>> The current error is formatted as:
>>
>>    "Parameter 'vcpu_dirty_limit' expects is invalid, it must greater then 1 MB/s"
>>
>> Replace by:
>>
>>    "Parameter 'vcpu_dirty_limit' is invalid, it must greater than 1 MB/s"
> 
> Is there a grammar error here? Maybe
> 
> s/it must greater/it must be greater/

Oops indeed!

> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   migration/options.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/migration/options.c b/migration/options.c
>> index 40eb930940..c5115f1b5c 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -1264,9 +1264,8 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>>   
>>       if (params->has_vcpu_dirty_limit &&
>>           (params->vcpu_dirty_limit < 1)) {
>> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>> -                   "vcpu_dirty_limit",
>> -                   "is invalid, it must greater then 1 MB/s");
>> +        error_setg(errp, "Parameter 'vcpu_dirty_limit' is invalid,"
>> +                         " it must greater than 1 MB/s");

So s/it must greater/it must be greater/ :)

>>           return false;
>>       }
>>
> 
> Otherwise,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 


