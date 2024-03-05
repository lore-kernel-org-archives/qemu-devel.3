Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76642C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPgC-0003vX-NA; Tue, 05 Mar 2024 02:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhPg4-0003ts-Tn
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:57:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhPg3-0001QX-CI
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709625450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=blwuxRXXP1vjiV78CmEhhv+sOqcOQHTqno/L0xH72oA=;
 b=Vu71UNnt64KZ8Fh2OUZOs39zIdXlVoTBtU9Fh3i2T40OoalpwfGwzx4hzcnBsS9iNFozI5
 4p2UPQqxeQ5i3rsUWDx+Se5Vy0IRtbLsKyLcEXK5s8qzWhNy5Mpd2tlcH6KMYLRrXbpP0O
 40kJ4prRi6u0LuRHDnqgjKd64sk4/l0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-NywL334TOpGZQo8b8qjDEQ-1; Tue, 05 Mar 2024 02:57:28 -0500
X-MC-Unique: NywL334TOpGZQo8b8qjDEQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-788228e459dso267827085a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709625448; x=1710230248;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=blwuxRXXP1vjiV78CmEhhv+sOqcOQHTqno/L0xH72oA=;
 b=MrlCdtT5BUMbofX+e4zUy4kRhA9OjmW81FIwyUT6aFJkxyDyt5mOmdNhydyBdaGJdq
 sYqnNpPh4hEIMJ9SCIqT/v8VA6Tn61q6kWDZQcDaAKQ24LiwUVw9uFwpN/AxhZiwzCwx
 2U7Kkn2Gt+VKo6qMWJf9VkO+WqGVzNz2SPwzuNOsvGZmM6GVGG0nlzeW7772Oq3HSabH
 AhBl2huPVxJQ1jBeh5q3nXzSDTRRF6LqnQYMq93bCIkiYZEDMyVCaygViXy8JA5Lw6wy
 chomKFf2rahqj+RwjBe0lLP5rOh2Q9vSENe8PhKt3kYV+tHpjvqFkcdQyvh+sAwGeW1P
 mfUw==
X-Gm-Message-State: AOJu0YyHRuAHUNxCkTlZS0bUXW18WVvcszLp6myYYeUkPMgFSI1oiTA4
 MIgGX9xKimvnNTjtlwey9A34TOEQPeJAffB1n2ifkOS1lbmB4ZbVEbV/jNRvzq1L4HbkHwpFNFN
 3kOeBsvIXmQh0BHYbJbavruLJHmhqbguFq4Gvzc2B+HNwzzjGxfvh
X-Received: by 2002:a05:620a:31a9:b0:788:2901:cbd8 with SMTP id
 bi41-20020a05620a31a900b007882901cbd8mr1321570qkb.28.1709625448424; 
 Mon, 04 Mar 2024 23:57:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEkayZt5UKg4nnc6oqYfcHFbmmbrXsJKdBbzPYU/GMlISgmdFZ5zAnp5icvOc/kck9s6o5RA==
X-Received: by 2002:a05:620a:31a9:b0:788:2901:cbd8 with SMTP id
 bi41-20020a05620a31a900b007882901cbd8mr1321552qkb.28.1709625448082; 
 Mon, 04 Mar 2024 23:57:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a05620a035900b007883184574esm904481qkm.98.2024.03.04.23.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:57:27 -0800 (PST)
Message-ID: <633c0f28-e7f6-4b84-85f6-4157bab0e883@redhat.com>
Date: Tue, 5 Mar 2024 08:57:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/26] migration: Move cleanup after after error
 reporting in qemu_savevm_state_setup()
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-11-clg@redhat.com> <ZeaSVc8hOOPReF60@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZeaSVc8hOOPReF60@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/5/24 04:32, Peter Xu wrote:
> On Mon, Mar 04, 2024 at 01:28:28PM +0100, Cédric Le Goater wrote:
>> This will help preserving the error set by .save_setup() handlers.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> IIUC this is about the next patch.  I got fully confused before reading
> into the next one.  IMHO we can squash it into where it's used.

That's where the change was initially ... I thought extracting it in its
own patch would clarify. Oh well nevermind, I will put it back and add
a comment in the commit log.

Thanks,

C.



> 
> Thanks,
> 
>> ---
>>   migration/savevm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 31ce9391d49c825d4ec835e26ac0246e192783a0..e400706e61e06d2d1d03a11aed14f30a243833f2 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1740,10 +1740,10 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>>           qemu_savevm_state_complete_precopy(f, false, false);
>>           ret = qemu_file_get_error(f);
>>       }
>> -    qemu_savevm_state_cleanup();
>>       if (ret != 0) {
>>           error_setg_errno(errp, -ret, "Error while writing VM state");
>>       }
>> +    qemu_savevm_state_cleanup();
>>   
>>       if (ret != 0) {
>>           status = MIGRATION_STATUS_FAILED;
>> -- 
>> 2.44.0
>>
>>
> 


