Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017BEC54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfi6h-00081A-Sv; Thu, 29 Feb 2024 10:13:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfi6f-00080Q-OR
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:13:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfi6d-00017s-0R
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709219632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QvjcG7KZUodmzJCNAxhgQUbZqmF7Ym8DC/WMmuWofkU=;
 b=LqXmHgeYtaZqFX0u+OjZm1UeyK4dUY6KkEukZKNBcBIxW2oecNUWsDJ11uhKqzDnC6SThI
 2Mt8k2xHdrxr31OWutpKkpEMhWiClqXmGX1KiX2rRqB67Ry+LxtxOXWgfe4ORnNwNiiQw+
 mcecIEih1qHfkzX+6Ky5V/JcJO8P5Dg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-etyrX-YHP9OIHC90G6tCMg-1; Thu, 29 Feb 2024 10:13:48 -0500
X-MC-Unique: etyrX-YHP9OIHC90G6tCMg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6903ea40d25so9355526d6.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 07:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709219628; x=1709824428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QvjcG7KZUodmzJCNAxhgQUbZqmF7Ym8DC/WMmuWofkU=;
 b=vCPbSeBh7lLw7kWlrFC4hDgzizWVImcTTvbHAkyw9bIXPBnoBp0GsxZjQWGHc+QIt7
 veLjpwqJr4MmWUmd9xU0DSAzjXufDQtEPcCKN46LC7xnWtnI2KsuFSO32COScV6RzDT8
 7t/NElQtYFAARt81kB+K1uiNEQqGqfD787IRYc0QweToJDgdALWmcjal+Rs5GvTutHxS
 itUgXYAC8Vegd2ed1iPM5YP8MtcQhexXY//0D90WZURghv5k5uRX6GTs4Z7BX+zwHzKr
 ZxJ3/8o6ldhYShpUIQb7j22Rx/G9nKc1sG6E0RHZhZy8js2Res/aa2gPJtF2rOOBAqKs
 Bl9g==
X-Gm-Message-State: AOJu0Yz3xxThZdbRUWkIiKmutXjdPUtCmOhtQzGs9uLPHmJcTrruAn53
 K7QKCo3K/9cWXPoebl3AHbM44ZYAfMiPxIoYKUo7zAVQY5qXT8iyf/G9Recymn5anAxrDvUlqxg
 G6GAaaSwEXL9GCwag2Mm0UZI483LtsC1EXLKYElmGiFBoxUNqBL7l
X-Received: by 2002:a0c:ca83:0:b0:68f:e19a:7633 with SMTP id
 a3-20020a0cca83000000b0068fe19a7633mr2454198qvk.50.1709219628035; 
 Thu, 29 Feb 2024 07:13:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiRe7j6tZTAzrlJgnA96ikj2K/cdR6sxxZ3Bo6LzsVMnkP50mdz966O0yVX3QqYkL9UnxEDQ==
X-Received: by 2002:a0c:ca83:0:b0:68f:e19a:7633 with SMTP id
 a3-20020a0cca83000000b0068fe19a7633mr2454182qvk.50.1709219627784; 
 Thu, 29 Feb 2024 07:13:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 pj4-20020a0562144b0400b006904a076f01sm542460qvb.114.2024.02.29.07.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 07:13:46 -0800 (PST)
Message-ID: <e08c2a88-a5db-4766-bf69-6ffd23a67e0c@redhat.com>
Date: Thu, 29 Feb 2024 16:13:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/21] migration: Fix migration termination
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-12-clg@redhat.com> <ZeAXbNy22xq4_SPm@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZeAXbNy22xq4_SPm@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/29/24 06:34, Peter Xu wrote:
> On Tue, Feb 27, 2024 at 07:03:35PM +0100, Cédric Le Goater wrote:
>> Handle migration termination when in SETUP state. This can happen if
>> qemu_savevm_state_setup() fails.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   migration/migration.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index c1a62b696f62c0d5aca0505e58bc4dc0ff561fde..63294417ff9cae868ad8a167094a795fc30e4da0 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -3161,6 +3161,8 @@ static void migration_iteration_finish(MigrationState *s)
>>               }
>>           }
>>           break;
>> +    case MIGRATION_STATUS_SETUP:
>> +        break;
>>   
>>       default:
>>           /* Should not reach here, but if so, forgive the VM. */
>> @@ -3192,6 +3194,8 @@ static void bg_migration_iteration_finish(MigrationState *s)
>>       case MIGRATION_STATUS_CANCELLED:
>>       case MIGRATION_STATUS_CANCELLING:
>>           break;
>> +    case MIGRATION_STATUS_SETUP:
>> +        break;
>>   
>>       default:
>>           /* Should not reach here, but if so, forgive the VM. */
> 
> Would this cause "query-migrate" to keep reporting "SETUP" even if setup()
> failed?
> 
> IIUC we may need to set state to FAILED when setup() failed.  If so, this
> patch might not be needed.

Oh yes. you are right. I will see how that can be done.

Thanks for the feedback.

C.



