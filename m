Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3BBC31D97
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKr2-0004cn-Ep; Thu, 04 Jul 2024 07:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sPKqo-0004QL-Bh
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:42:10 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sPKqj-00059g-6w
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:42:09 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c8e7553c9eso411665a91.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 04:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720093323; x=1720698123;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s0r1c2vDYSN5zwEwYThkjHFvk3tw7FIlFQWI0GiJGWE=;
 b=GfYxR1QDYLcqbj6Q9ku+1Lz/lG9qU1shjipok/nzYvAuOHAPpTRQHzFMM6OAqOHeM+
 /pUfLh5j93pFOf4/K6AJvEPKssHqSIiKpOLu+opjz2nHnn3XrwueYaQk3jl8zc+ixnEr
 y9rCfhuttpTvzAqUH6NKTJ4vJ7wi2cTDuln/howga6NXF3f1Ch5XKnFcBSQZyX97rGW2
 /fZV+MG8dMJPPagBxoJ1PBRRzZKPF6ZT8hV2N/qeDYdAWlVIDud3i+NGeP1XupHam9CK
 B8d/g+t0fhxHYJsLebh78heJvkP7riujkaYmhWJAnxDMVoK0OH1hh0rXbbGTShC7zJmG
 MD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720093323; x=1720698123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s0r1c2vDYSN5zwEwYThkjHFvk3tw7FIlFQWI0GiJGWE=;
 b=MgwU5d6Ye3cwN28nLD5aBzpq4JMXEN1+b5dOHwx5tQ0QefJ4gDQDMpqr0rpJN6aKQg
 fYF1H6CLUWyZsjVDy+s7i0y6555tt7t7+uV/aTZoQwF6rsCHjlpI/wp7GXqXbspGexYz
 xvtGw4GlZWJeCD5T7/FIbi1ZevEgIPemheWZDjdcgZ2fbsHR43yu4rAm/O90dbFsK4U5
 OlrgZ7lSlQiQZUfdYP34CgtBK+q0KJMfSK+rnd3G5im+mugxp1jygtkwMqJMJZM9wd5P
 9+2pBv9c+63NbEwUb1lDrY21ek2AnZOInzFtXSfRppVUo5Jx0PMu6G/EQs2R3jYPTZNF
 Uxrg==
X-Gm-Message-State: AOJu0YzGE7qgze07lMwEfeHLpSfJmh1hdI/JpwfM2HYdXfMH3Ap84icJ
 6BdgYEuNQHtTGLc1clC3HH63vM6s18YFkOLr9IQNOn93Tu+xvNXm0dxtdARLOlc=
X-Google-Smtp-Source: AGHT+IFGhTge/LyDoKTX1iX+WalhgPX+K7v8929QUpK7phSgO644hfcPrQF92XHkviqeNUXq1JWNbQ==
X-Received: by 2002:a17:90b:395:b0:2c9:88af:300c with SMTP id
 98e67ed59e1d1-2c99c5516e9mr1025603a91.18.1720093323426; 
 Thu, 04 Jul 2024 04:42:03 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99aa8d0b2sm1276165a91.48.2024.07.04.04.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 04:42:03 -0700 (PDT)
Message-ID: <66ae8c4e-c5cc-4db1-8706-8afa3e1a3448@daynix.com>
Date: Thu, 4 Jul 2024 20:41:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] tests/qtest: Delete previous boot file
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-13-750bb0946dbd@daynix.com>
 <ca242297-58c3-42ff-a62d-f93eb076d046@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ca242297-58c3-42ff-a62d-f93eb076d046@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/07/02 16:31, Thomas Huth wrote:
> On 27/06/2024 15.37, Akihiko Odaki wrote:
>> A test run may create boot files several times. Delete the previous boot
>> file before creating a new one.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   tests/qtest/migration-test.c | 18 +++++++++++-------
>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index b7e3406471a6..5c0d669b6df3 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -129,12 +129,23 @@ static char *bootpath;
>>   #include "tests/migration/aarch64/a-b-kernel.h"
>>   #include "tests/migration/s390x/a-b-bios.h"
>> +static void bootfile_delete(void)
>> +{
>> +    unlink(bootpath);
>> +    g_free(bootpath);
>> +    bootpath = NULL;
>> +}
>> +
>>   static void bootfile_create(char *dir, bool suspend_me)
>>   {
>>       const char *arch = qtest_get_arch();
>>       unsigned char *content;
>>       size_t len;
>> +    if (bootpath) {
>> +        bootfile_delete();
>> +    }
>> +
>>       bootpath = g_strdup_printf("%s/bootsect", dir);
>>       if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>>           /* the assembled x86 boot sector should be exactly one 
>> sector large */
>> @@ -164,13 +175,6 @@ static void bootfile_create(char *dir, bool 
>> suspend_me)
>>       fclose(bootfile);
>>   }
>> -static void bootfile_delete(void)
>> -{
>> -    unlink(bootpath);
>> -    g_free(bootpath);
>> -    bootpath = NULL;
>> -}
>> -
>>   /*
>>    * Wait for some output in the serial output file,
>>    * we get an 'A' followed by an endless string of 'B's
>>
> 
> I think the better fix would be to call bootfile_create() only once from 
> main() since we don't have to create the bootfile multiple times, do we?

The suspend_me parameter depends on test cases so probably we actually 
need to recreate in such cases.

Regards,
Akihiko Odaki

