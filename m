Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D183C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgYu-0001hA-Bh; Thu, 29 Feb 2024 08:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfgYp-0001gj-1o
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:34:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfgYn-0007xX-Jx
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709213692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SFQQ8w1spVd62vbY4/5U8qHsMT56nqDaW1rgsbR5gU=;
 b=VeRYzYbN8jliaeQSX1dd/r5DHb0VXDn0FWwDdmPsGxCP51vF5WVJdKbzBBN3pxoBGnub1v
 wbrtTkYEa5BCMKrAoUYKY+QPOrmNTEGu2Hm5wNhU4dDC4U4OtxBOmYpVuF0DhTJSbyMQfU
 78JcnkqLWWzTdFjVA30E9ZhT7Hi4nEQ=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-aPOQPYtzO3aOYagqbJ7q2w-1; Thu, 29 Feb 2024 08:34:51 -0500
X-MC-Unique: aPOQPYtzO3aOYagqbJ7q2w-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7ce706ba435so405633241.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 05:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709213690; x=1709818490;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4SFQQ8w1spVd62vbY4/5U8qHsMT56nqDaW1rgsbR5gU=;
 b=Dspt4c/3oqvOPrfJVJf0LV7oVHLoKzpYW5dt9K3uMMU0/0ncd1s1E/2sNVzsa2u07n
 wBYLYF3RKPPN4IykOYEpd/dLJaLM0BRRs32OrYdJPBY0taRZCL1obkasaRfxm/OmqpGT
 wqqkxBvcyz89Z2xg3E5SdCrmIvaBNgOqam2ZcK4aTTA0iZHNPWy/Heeums8cr+xXGKQX
 z10H92c4SRyr/+xLIH9B/C8fsObVzetKI2d8pnz6p1ME8+zqzZCSS4ZoTdu+t/eheHpl
 5Jj2grpy0W/sJ6TuJK7cvUM19A84fhZ5QuV6Hcwdw0HDMz8Q2OtVRmaKGrBIC8VANfFY
 CDWQ==
X-Gm-Message-State: AOJu0Yw90BfRd9SK162B9Gf54o90vcnt9d2jpUXdFLSjTk0B37f38/47
 0A+rXuivxbvu03Kc4qFtKEBX1DIG5CHiXcAEWJVenDLe1PH3m/BBdC9VXlk4GClCI5HR+TFnCio
 l5fwvt7M+yZssrUgStZdQPQmFECKuJbAmAKhDpAOOtjOgEKd07tEo
X-Received: by 2002:a05:6102:508c:b0:472:5960:9e9b with SMTP id
 bl12-20020a056102508c00b0047259609e9bmr2160004vsb.29.1709213690582; 
 Thu, 29 Feb 2024 05:34:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+hVbRlB+7ofyQFY8JtVGLNRxXcUgD17o0CWG6D+Yl4wG+kGBGJID3HI8cR9Fn8qoen1wQIw==
X-Received: by 2002:a05:6102:508c:b0:472:5960:9e9b with SMTP id
 bl12-20020a056102508c00b0047259609e9bmr2159980vsb.29.1709213690315; 
 Thu, 29 Feb 2024 05:34:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ia21-20020a0561024b1500b0047065173094sm224148vsb.1.2024.02.29.05.34.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 05:34:49 -0800 (PST)
Message-ID: <356b2acd-cdbd-4517-a4e0-624f9b9484cc@redhat.com>
Date: Thu, 29 Feb 2024 14:34:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/21] migration: Add Error** argument to .save_setup()
 handler
Content-Language: en-US, fr
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-7-clg@redhat.com> <87zfvj3hnd.fsf@pond.sub.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87zfvj3hnd.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

On 2/29/24 07:32, Markus Armbruster wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> The purpose is to record a potential error in the migration stream if
>> qemu_savevm_state_setup() fails. Most of the current .save_setup()
>> handlers can be modified to use the Error argument instead of managing
>> their own and calling locally error_report(). The following patches
>> will introduce such changes for VFIO first.
>>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Cc: John Snow <jsnow@redhat.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
> 
> [...]
> 
>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>> index c483b62a9b5f71772639fc180bdad15ecb6711cb..c934df424a555d83d2198f5ddfc0cbe0ea98e9ec 100644
>> --- a/hw/s390x/s390-stattrib.c
>> +++ b/hw/s390x/s390-stattrib.c
>> @@ -166,7 +166,7 @@ static int cmma_load(QEMUFile *f, void *opaque, int version_id)
>>       return ret;
>>   }
>>   
>> -static int cmma_save_setup(QEMUFile *f, void *opaque)
>> +static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       S390StAttribState *sas = S390_STATTRIB(opaque);
>>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>         int res;
>         /*
>          * Signal that we want to start a migration, thus needing PGSTE dirty
>          * tracking.
>          */
>         res = sac->set_migrationmode(sas, 1);
>         if (res) {
>             return res;
> 
> I believe this is a failure return.
> 
> Anti-pattern: fail without setting an error.  There might be more
> elsewhere in the series.
> 
> qapi/error.h's big comment:
> 
>   * - On success, the function should not touch *errp.  On failure, it
>   *   should set a new error, e.g. with error_setg(errp, ...), or
>   *   propagate an existing one, e.g. with error_propagate(errp, ...).
>   *
>   * - Whenever practical, also return a value that indicates success /
>   *   failure.  This can make the error checking more concise, and can
>   *   avoid useless error object creation and destruction.  Note that
>   *   we still have many functions returning void.  We recommend
>   *   • bool-valued functions return true on success / false on failure,
>   *   • pointer-valued functions return non-null / null pointer, and
>   *   • integer-valued functions return non-negative / negative.
> 
>         }
>         qemu_put_be64(f, STATTR_FLAG_EOS);
>         return 0;
>     }
> 
> When adding Error **errp to a function, you must also add code to set an
> error on failure to every failure path.  Adding it in a later patch in
> the same series can be okay, but I'd add a TODO comment to the function
> then, and mention it in the commit message.

Indeed. I will check the other changes.

> Questions?

Perfectly clear.

Thanks,

C.



