Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815FDCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 11:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8H2B-0003ia-4u; Mon, 13 Oct 2025 07:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8H29-0003hv-On
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:48:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8H24-0000Ek-I2
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760356082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=El6Lo5+KQzAEuFHaSqE66CR9JsPULndzj7SRtB5d3yI=;
 b=FlS8ED9vhRN86LeejpooMiPOmvwlgpxmqcrzv1m9ot6ug1BbEnnk5AZmXkVa9x45apgGaQ
 ME0KidE7Bb6+uyiiU6X0ZxK0u3lYGp3OCVM2YNcyF+4PW5Vg97e5rhdDxPqdAaZGffGNTF
 2LJlp1cigrdtdZyVxHQ7N6C6T45n4oc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-W561nT7yPB61v317b2glDA-1; Mon, 13 Oct 2025 07:48:00 -0400
X-MC-Unique: W561nT7yPB61v317b2glDA-1
X-Mimecast-MFC-AGG-ID: W561nT7yPB61v317b2glDA_1760356079
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ecdd80ea44so3311502f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 04:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760356079; x=1760960879;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=El6Lo5+KQzAEuFHaSqE66CR9JsPULndzj7SRtB5d3yI=;
 b=sYnP973d6Y0YtjEpqkFppE7ua4MKV1yCidAEHyKTh3yB2A+3G9sU2jjWJZukKbaHTG
 QhKYLlah/Dk2qNTuvedzvlC8oZecMng2qNgtby1Mnx/J6OvUbP21bRRkYBURN3ko3or0
 QIfdDwJInZUNTXJ33mqAsHNNEiBivhXOyZOTYq8rifwlBW5/Fftj/QKP8CxD1jtrPgUj
 lPXxYExNWT+GxgMUFa9W6CBz4v2Ngz+siXZcBKhw2V61JO2doW88BMUbpbkMCcKeGLns
 8AL/r9ge6AeRoEShTk89iGA9OuuIRH3pDF/z8fEF0xSEl7m6PZaosRATBlXCZ3Ei7tgC
 g4hw==
X-Gm-Message-State: AOJu0YyfamWtao7wcm3+/77AL4KF5WFbigbS7pS0AwIpPdi2KcZZW872
 ezd6iVpyEidTX529dKZqjOL4Z0WP8/Vp0xYgwo6fuTpakm3wHzCrvtCb/IFPMqCPiBAMT36P8U1
 Kn0BlSNH4GpcF4a54M+NTGKLe/DZkO9AylMGOk9o1joHtQ70ngXtDiZcI
X-Gm-Gg: ASbGncu4TlKJ9D8M9e3Bkhb6knLYEXtnUVvU75FNSLMJdJJRNHfMQplhabACyEVaTdT
 k0+bt498Dl3IMBUCSittpjA60B9zd+hFxAsJRz+S7egcC+I9lrfL3KwqeI2u7POu2m44DGoEWAK
 JTlMjIggy+4eKiasK/X9P7vI6aLW1c35P3f8yUlhbk6zKLPihxa6WvfN4MFr4BVZ3kqc6iPB+Ld
 olE4DDEu7nD0ch5APpMWEdbhHuuKB6V5Cscmaw/wkV6ENulEsHQTdSbVx8Wd2qnkt4FAnOoWdGp
 qpxXnH8nQDbo78XfGNy1OPoAdM38XZor7vCcr3r7mrwOJFMPF2rM6TzFGnCK7b1BxHw9BrVk068
 X6ycF
X-Received: by 2002:a05:6000:310b:b0:3d3:b30:4cf2 with SMTP id
 ffacd0b85a97d-4266e7beaa3mr12421457f8f.19.1760356079406; 
 Mon, 13 Oct 2025 04:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzyGEdN7c89Vcuc/pyIK143I5NukFL/rIwjPboU0JnGxRbFN2Skh32GA9GuVGfJygjghRDWA==
X-Received: by 2002:a05:6000:310b:b0:3d3:b30:4cf2 with SMTP id
 ffacd0b85a97d-4266e7beaa3mr12421442f8f.19.1760356078981; 
 Mon, 13 Oct 2025 04:47:58 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e82dfsm17908254f8f.52.2025.10.13.04.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 04:47:58 -0700 (PDT)
Message-ID: <2cc78a29-6df7-4cfa-86b8-6065869a8a85@redhat.com>
Date: Mon, 13 Oct 2025 13:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests: Evict stale files in the functional download
 cache after a while
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251010093244.807544-1-thuth@redhat.com>
 <20251010093244.807544-3-thuth@redhat.com> <aOjW8aJKxNtUf3Py@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aOjW8aJKxNtUf3Py@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/10/2025 11.50, Daniel P. Berrangé wrote:
> On Fri, Oct 10, 2025 at 11:32:43AM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The download cache of the functional tests is currently only growing.
>> But sometimes tests get removed or changed to use different assets,
>> thus we should clean up the stale old assets after a while when they
>> are not in use anymore. So add a script that looks at the time stamps
>> of the assets and removes them if they haven't been touched for more
>> than half of a year. Since there might also be some assets around that
>> have been added to the cache before we added the time stamp files,
>> assume a default time stamp that is close to the creation date of this
>> patch, so that we don't delete these files too early.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   MAINTAINERS                       |  1 +
>>   scripts/clean_functional_cache.py | 47 +++++++++++++++++++++++++++++++
>>   tests/Makefile.include            |  1 +
>>   3 files changed, 49 insertions(+)
>>   create mode 100755 scripts/clean_functional_cache.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 84cfd85e1fa..4c468d45337 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4398,6 +4398,7 @@ M: Thomas Huth <thuth@redhat.com>
>>   R: Philippe Mathieu-Daudé <philmd@linaro.org>
>>   R: Daniel P. Berrange <berrange@redhat.com>
>>   F: docs/devel/testing/functional.rst
>> +F: scripts/clean_functional_cache.py
>>   F: tests/functional/qemu_test/
>>   
>>   Windows Hosted Continuous Integration
>> diff --git a/scripts/clean_functional_cache.py b/scripts/clean_functional_cache.py
>> new file mode 100755
>> index 00000000000..e5c4d1acaf3
>> --- /dev/null
>> +++ b/scripts/clean_functional_cache.py
>> @@ -0,0 +1,47 @@
>> +#!/usr/bin/env python3
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +"""Delete stale assets from the download cache of the functional tests"""
>> +
>> +import os
>> +import stat
>> +import sys
>> +import time
>> +from pathlib import Path
>> +
>> +
>> +cache_dir_env = os.getenv('QEMU_TEST_CACHE_DIR')
>> +if cache_dir_env:
>> +    cache_dir = Path(cache_dir_env, "download")
>> +else:
>> +    cache_dir = Path(Path("~").expanduser(), ".cache", "qemu", "download")
> 
> This creates a Path object but then doesn't take advantage of
> any of its functionality, calling os. functions still....

Ok, you got me, looks like I'm still a python ignorant after one year of 
hacking the functional testing framework ;-) Thanks for the hints how to do 
it better!

>> +    try:
>> +        with open(filename + ".stamp", "r", encoding='utf-8') as fh:
>> +            timestamp = int(fh.read())
> 
>     timestamp = file.read_text()

Hmm, but "file" points to the asset, not to the .stamp file, doesn't it?

>> +    except FileNotFoundError:
>> +        # Assume it's an old file that was already in the cache before we
>> +        # added the code for evicting stale assets. Use the release date
>> +        # of QEMU v10.1 as a default timestamp.
>> +        timestamp = time.mktime((2025, 8, 26, 0, 0, 0, 0, 0, 0))
> 
> The prev patch will make the precache task create the .stamp for all
> files that are currently in use by the current branch. So the only
> thing this does is to prevent us deleting cached files that might
> still be needed by a different branch. There will be few of them,
> so if we prematurely delete a handful that's not a big deal. If we
> switch to checking mtime, this except won't even exist.

When hunting regressions that have been introduced recently, I often have to 
do bisecting on revisions from the previous 1 or 2 QEMU releases, so I'd 
prefer keeping the assets of the last few months, even if they have been 
removed from the master branch in a very recent commit.

  Thomas


