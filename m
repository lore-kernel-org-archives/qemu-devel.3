Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD9CCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApmw-00018n-Ov; Mon, 20 Oct 2025 09:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vApmt-00018X-Uz
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vApmo-0007pK-7j
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760966319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z/mYgo6xROM81jQ4fyZixkDen26GJl8FnAPHoYWsz+Y=;
 b=EJXz0xASkkhP1Fb2sGhJlAcqfCKczCLdLfECH5+eBXpNgVxRttMc8lFyZc9zvonZspOQw0
 IJwo/phNXfLw+TuBG9gLHwg9AjWsSSMzVbozEuhtIQyVw5Xi/L/PqnIJrf2wsDIKcFmIEm
 8JflQE+0I+RCcRZy2MPJ7iDJjer4cpE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-6LQxatICNYKEFrVcvyEcNg-1; Mon, 20 Oct 2025 09:18:37 -0400
X-MC-Unique: 6LQxatICNYKEFrVcvyEcNg-1
X-Mimecast-MFC-AGG-ID: 6LQxatICNYKEFrVcvyEcNg_1760966316
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-472ce95ed1dso9303515e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 06:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760966316; x=1761571116;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z/mYgo6xROM81jQ4fyZixkDen26GJl8FnAPHoYWsz+Y=;
 b=vXl2FXeI+f83TKFHCKdxMAB0mL0g+R5CsROcla3ZdQYZMYnXJT4PpUe8uQ+7ZlCNSf
 40ZzvMYvOH2kE8Ou8D0e2iATSkrU/Y2XgAfqHhj2hdIhnwhPrYr8OH9N8ImBhPyrcXPp
 rGb/ITBCGmCKZdZuiyZceohzxsoi3ov4pZIwMHJtLCwmlofhKwEyfrJ1GF6H8P6/mQEG
 lpxlfyMV8VBYAAjUNRSXkrUjOZ79u/g6Uy358Sfi0szd8uLPY8PB3omie/OCJ5CsZeYm
 R8DnYX7MqapA4eyddTikhyoEJHcgtIRB0riavSul6yqQKMlm2DiimYjFBGGFET/KfnYZ
 RN2w==
X-Gm-Message-State: AOJu0YztDW5+VdsEKQjvRPGe2LNakOmcpW7hzS6BaTM+xSnWLAOjn3av
 pDGdPvC0Bd9W95/uvDNIsBTzNShmyI/yhrMKjd/jgAEeahShMQrAo0v6Pkl3rkR3wmPSG1ct7u+
 WG3cSlt1vSGVFYG+nKJwUPtHG3Rdx7V5JgxDbwaInQEhY2teXsb8nA5sb
X-Gm-Gg: ASbGncsxG2dfzdy6DOy+3nNlOayGoejLWM1GO32DRx1ek+/HcAbq1y3ccgr9EHOpeUd
 u6iLdLuDo3ygw2jEn7PiwwoowSHDavFobmjIo2gupcCbR6XoLpt5C7pDyhuBqe0U3V0JiVlLP1+
 vTEu+QAKdTjstKrh9cZleSa3Gswd2X8dH2BKF1WhoWnSyIMQRSNB9WSXVjjkE2Qe7zBD32cHrox
 OaN9/qJXh/Bh4Ao0Qyhbtsiqqv439wML44M3KQxELsLnhtqEg4euCZ+r4D4ahi+w7jH9rA/BFCB
 bRrPGe72eZ1v0risqIQH33poIhzAYsyW8SvIkBCYzXPix1D13vdmU0cPEOJd6/pkDqP0+BF8xS7
 Ne1qzi0dOJjlNYJ21u8UdV/QPW7jid9qAYTOZ0N84
X-Received: by 2002:a05:6000:2c0a:b0:3e8:f67:894a with SMTP id
 ffacd0b85a97d-42704d8357dmr9512260f8f.5.1760966315817; 
 Mon, 20 Oct 2025 06:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/g0ptEJTrD488PZ2pSUDB3q83kEiZMByldaDfkzcJgfF4Wj29uE55wnT1T0dyU5pCEOemMg==
X-Received: by 2002:a05:6000:2c0a:b0:3e8:f67:894a with SMTP id
 ffacd0b85a97d-42704d8357dmr9512238f8f.5.1760966315387; 
 Mon, 20 Oct 2025 06:18:35 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-135.pools.arcor-ip.net.
 [47.64.114.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a797sm15365896f8f.27.2025.10.20.06.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 06:18:34 -0700 (PDT)
Message-ID: <22f12636-bfcf-47b6-9c61-9fd120bafdb4@redhat.com>
Date: Mon, 20 Oct 2025 15:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Decrease the size of the compiler cache
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251020085431.23968-1-thuth@redhat.com>
 <aPX-6dp65xXGtxja@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aPX-6dp65xXGtxja@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/10/2025 11.20, Daniel P. Berrangé wrote:
> On Mon, Oct 20, 2025 at 10:54:31AM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Uploading the cache from the runner takes a long time in the MSYS2
>> job, mostly due to the size of the compiler cache.
>> However, looking at runs with a non-initialized cache, and by doing
>> a "du -sh ." in the build directory, it seems like a build only
>> takes about 236 MiB of data, so the compiler cache with 500 MiB
>> certainly contains a lot of stale files. Thus decrease the size of
>> the ccache to a more reasonable value to speed up the MSYS2 job in
>> our CI (and add a "du -sh" at the end to have a reference for the
>> required cache size in the future).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   Looking at the latest runs in the CI, our recent attempt to decrease
>>   the cache size by cleaning the pacman cache did not help much:
>>   https://gitlab.com/qemu-project/qemu/-/jobs/11747329283
>>   ... that run contains the "pacman -Sc" command, but the "Saving cache
>>   for successful job" step at the end still takes close to 20 minutes.
>>   So we likely have to shrink the compiler cache, too. In this run here:
>>   https://gitlab.com/thuth/qemu/-/jobs/11770708859#L1769
>>   I added a "du -sh" and you can see that the build directory only
>>   takes 236 MB there. So a ccache with the size of 250M should be
>>   sufficient for the MSYS2 job.
> 
> FWIW, in my fork I see
> 
> Cacheable calls:   638 / 647 (98.61%)
>    Hits:            629 / 638 (98.59%)
>      Direct:        629 / 629 (100.0%)
>      Preprocessed:    0 / 629 ( 0.00%)
>    Misses:            9 / 638 ( 1.41%)
> Uncacheable calls:   9 / 647 ( 1.39%)
> Local storage:
>    Cache size (GB): 0.1 / 0.5 (29.54%)
>    Hits:            629 / 638 (98.59%)
>    Misses:            9 / 638 ( 1.41%)
> 
> IOW, even ~160 MB is sufficient for 99% cache hit, so 250 MB is
> about 2/3rds spare headroom.

Good point. So 250 MB will likely still waste time with unnecessary uploads.

Some few MBs headroom likely still make sense in case we compile more code 
in the future, so maybe we should use something like 180 MB for the cache size?

> If I look at the saving cache part in my fork job I see:
> 
>    msys64/var/cache: found 284 matching artifact files and directories
>    ccache: found 12825 matching artifact files and directories
> 
> while in QEMU job I see
> 
>    msys64/var/cache: found 342 matching artifact files and directories
>    ccache: found 46881 matching artifact files and directories
> 
> so the ccache usage is almost x4 bigger in terms of # of files, so
> that does likely account for a good portion of the time.
> 
> I'm surprised the msys64/var/cache is still bigger than my fork though,
> as I would have expected them to be basically the same.

That's weird, indeed. Maybe some other stale files from the past?

> I wonder if we shouldn't recursively list the msys64 cache as a debug
> aid ?

I agree, we likely should at least temporarily add that to debug the issue. 
Do you want to send a patch, or want me to do it?

>>   .gitlab-ci.d/windows.yml | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
>> index 6e1135d8b86..e2fef543899 100644
>> --- a/.gitlab-ci.d/windows.yml
>> +++ b/.gitlab-ci.d/windows.yml
>> @@ -94,7 +94,7 @@ msys2-64bit:
>>     - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
>>     - $env:CCACHE_BASEDIR = "$env:CI_PROJECT_DIR"
>>     - $env:CCACHE_DIR = "$env:CCACHE_BASEDIR/ccache"
>> -  - $env:CCACHE_MAXSIZE = "500M"
>> +  - $env:CCACHE_MAXSIZE = "250M"
>>     - $env:CCACHE_DEPEND = 1 # cache misses are too expensive with preprocessor mode
>>     - $env:CC = "ccache gcc"
>>     - mkdir build
>> @@ -103,5 +103,6 @@ msys2-64bit:
>>     - ..\msys64\usr\bin\bash -lc "../configure $CONFIGURE_ARGS"
>>     - ..\msys64\usr\bin\bash -lc "make -j$env:JOBS"
>>     - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
>> +  - ..\msys64\usr\bin\bash -lc "du -sh ."
> 
> Do we want to keep this in the final commit ?
>> We have ccache size printed, and we could do with msys64/var/cache
> size being printed at least.

Well, the cache can collect stale garbage, as you can currently see in the 
CI jobs of the qemu-project, but the build folder should give you a very 
clear picture of how many MiBs of object code are really necessary, so I'd 
prefer to keep it (at least for a while).

  Thomas


