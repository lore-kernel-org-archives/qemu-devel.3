Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D84C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWbB-000829-Vr; Mon, 26 Feb 2024 03:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1reWbA-00081s-Ds
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:44:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1reWb7-0008I7-SI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708937068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DyoCVd1Ywjhoxv5w3cLMTrD5JvpmEIF2qFqVN/J1mD8=;
 b=dzLhUEQnNClziN4XcCSNYHomEq1s+0wJDGkmMpSAOtA8CG3HQKoOXNSm0hx81MQx/g4A9Z
 pwKxMgMe7DqWFIk4doLCoiSrtikdvVNHIIk01FzgEhWDbXVpJ5lCHlkYHQXGw0O8dFO4cc
 NO+3P/xpHYqvIjrKNlgdjpN4LG6vDkw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-b4-6MNg1NCOexdBLxAP71A-1; Mon, 26 Feb 2024 03:44:27 -0500
X-MC-Unique: b4-6MNg1NCOexdBLxAP71A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-69009cbf840so7864176d6.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708937067; x=1709541867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DyoCVd1Ywjhoxv5w3cLMTrD5JvpmEIF2qFqVN/J1mD8=;
 b=B8iDiU0AqA4ChndTlb79pj8mxkabujGy0UtZDt61SOh0+WCfwuPg9yDf8ceeajycZ/
 /VZFUvGFA5S9ERq7qZSi6zaPNlWATI0K/TWV3hXM11ZFdZJcPm9pn6jgWg1Is+iAJd9R
 eMw91J7yDA+NeaheO/FJGLfJaiS0Vnw7vk26RFWOa9hXXGbSLDq7eCN/mSlXTKD3iB2B
 vE7uydzgcrVpvHzgs8Af2NZZ3LRT50d0lJvuaSGXbKQfMskkzbz8ScopmGgjfpnE40YI
 XHLYvrFjmMSbKL/UEEDob/RPL++57QM5PvGu1Nl/ixdIpA7maHLVAXtMi6m54L3uGSPf
 BQbg==
X-Gm-Message-State: AOJu0YyAPh92hH4D28KgvbiywKG97c5aSZD5CUTBrr7ASYG3nUs5P0zl
 2P5PPWichNa/CkBGLXffrcmrdM6uMifxizicljT0p9yGXJSshFBBdrUqSKEkzL/6YZsb+tFDSxH
 CrMT0r9gqFHXovc8pc6IagDomow6aaruXBATxDHM/HS6elc+MxX4q
X-Received: by 2002:a05:6214:27ca:b0:68f:e43d:a253 with SMTP id
 ge10-20020a05621427ca00b0068fe43da253mr8253843qvb.2.1708937066788; 
 Mon, 26 Feb 2024 00:44:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDwsnsdG5dyzIuBCPN/tdM1q+vK7fRBcoWKd0Q1lzKFk9XoM18Jryt4Vcj4ZTPUv5Q78I2Hg==
X-Received: by 2002:a05:6214:27ca:b0:68f:e43d:a253 with SMTP id
 ge10-20020a05621427ca00b0068fe43da253mr8253832qvb.2.1708937066528; 
 Mon, 26 Feb 2024 00:44:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l7-20020ad44247000000b0068f128fc550sm2659101qvq.131.2024.02.26.00.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 00:44:26 -0800 (PST)
Message-ID: <e3173995-1aab-4d19-b5c8-9cf3998cbb50@redhat.com>
Date: Mon, 26 Feb 2024 09:44:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/14] migration: Fix return-path thread exit
Content-Language: en-US, fr
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-15-clg@redhat.com> <87v86zaxtv.fsf@suse.de>
 <50ca9637-bc18-4002-abc3-52c1bb834038@redhat.com> <87mss2pywv.fsf@suse.de>
 <2b7d3773-3cc0-41b1-8dc8-0aff90107771@redhat.com> <87sf1s8g81.fsf@suse.de>
 <ZdgfnWJNYeiNYeGN@x1n> <87cysn9sy9.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87cysn9sy9.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 2/23/24 15:05, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Fri, Feb 16, 2024 at 02:35:26PM -0300, Fabiano Rosas wrote:
>>> Cédric Le Goater <clg@redhat.com> writes:
>>>
>>>> Hello Fabiano
>>>>
>>>> On 2/14/24 21:35, Fabiano Rosas wrote:
>>>>> Cédric Le Goater <clg@redhat.com> writes:
>>>>>
>>>>>> Hello Fabiano
>>>>>>
>>>>>> On 2/8/24 14:29, Fabiano Rosas wrote:
>>>>>>> Cédric Le Goater <clg@redhat.com> writes:
>>>>>>>
>>>>>>>> In case of error, close_return_path_on_source() can perform a shutdown
>>>>>>>> to exit the return-path thread.  However, in migrate_fd_cleanup(),
>>>>>>>> 'to_dst_file' is closed before calling close_return_path_on_source()
>>>>>>>> and the shutdown fails, leaving the source and destination waiting for
>>>>>>>> an event to occur.
>>>>>>>
>>>>>>> Hi, Cédric
>>>>>>>
>>>>>>> Are you sure this is not caused by patch 13?
>>>>>>
>>>>>> It happens with upstream QEMU without any patch.
>>>>>
>>>>> I might have taken that "shutdown fails" in the commit message too
>>>>> literaly. Anyway, I have a proposed solution:
>>>>>
>>>>> -->8--
>>>>>   From 729aa7b5b7f130f756d41649fdd0862bd2e90430 Mon Sep 17 00:00:00 2001
>>>>> From: Fabiano Rosas <farosas@suse.de>
>>>>> Date: Wed, 14 Feb 2024 16:45:43 -0300
>>>>> Subject: [PATCH] migration: Join the return path thread before releasing
>>>>>    to_dst_file
>>>>> MIME-Version: 1.0
>>>>> Content-Type: text/plain; charset=UTF-8
>>>>> Content-Transfer-Encoding: 8bit
>>>>>
>>>>> The return path thread might hang at a blocking system call. Before
>>>>> joining the thread we might need to issue a shutdown() on the socket
>>>>> file descriptor to release it. To determine whether the shutdown() is
>>>>> necessary we look at the QEMUFile error.
>>>>>
>>>>> Make sure we only clean up the QEMUFile after the return path has been
>>>>> waited for.
>>>>
>>>> Yes. That's the important part.
>>>>
>>>>> This fixes a hang when qemu_savevm_state_setup() produced an error
>>>>> that was detected by migration_detect_error(). That skips
>>>>> migration_completion() so close_return_path_on_source() would get
>>>>> stuck waiting for the RP thread to terminate.
>>>>>
>>>>> At migrate_fd_cleanup() I'm keeping the relative order of joining the
>>>>> migration thread and the return path just in case.
>>>>
>>>> That doesn't look necessary.
>>>
>>> Indeed. But I don't trust the migration code, it's full of undocumented
>>> dependencies like that.
>>>
>>>> What was the reason to join the migration thread only when
>>>> s->to_dst_file is valid ?
>>>
>>> I didn't find any explicit reason looking through the history. It seems
>>> we used to rely on to_dst_file before migration_thread_running was
>>> introduced.
>>>
>>> I wouldn't mind keeping that 'if' there.
>>>
>>> Let's see what Peter thinks about it.
>>
>> Frankly I don't have a strong opinion on current patch 14 or the new
>> proposal, but it seems we reached a consensus.
>>
>> Fabiano, would you repost with a formal patch, with the proper tags?
> 
> Yes, I'll post it soon.
> 
>>
>> One thing I am still not sure is whether we should still have patch 13
>> altogether? Please see my other reply on whether it's possible to have
>> migrate_get_error() == true but qemu_file_get_error() == false.
> 
> I'll include it then.

Thanks for taking over.

I have included :

  [PATCH] migration: Join the return path thread before releasing to_dst_file

in my series and dropped 13-14. I hope to send a follow up on :

   https://lore.kernel.org/qemu-devel/20240207133347.1115903-1-clg@redhat.com/

before we reach soft freeze. It's growing quite a lot.

C.


