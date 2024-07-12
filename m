Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC98AC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEov-0003CK-EU; Fri, 12 Jul 2024 07:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sSEot-00037B-UW
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:52:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sSEor-0002V4-VN
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720785129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QD/T5AiTtirQNRRpwBtNYVPckntg4yM0Bk+X+fTXiOY=;
 b=ZAk/y2u6QjXVCsJkBxuuBfBy9Aw3Y6sVcxTpIDQmpiY2hV+FB8lYWXjgWmuAmBj7Ios1yt
 LT5J/u3mfen2YwZ12mukNr6w22ctVcZ4QO26IlZ6dsUlUt5G9Y25ZuPRx2S1SjVJBRHBQ7
 /Ov9l3r6n71aA5E+FnaZHbNHA69TANw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-D-_3b77ZPbW8hMDUbuzkGw-1; Fri, 12 Jul 2024 07:52:07 -0400
X-MC-Unique: D-_3b77ZPbW8hMDUbuzkGw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52e969d34a9so2172763e87.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 04:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785126; x=1721389926;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QD/T5AiTtirQNRRpwBtNYVPckntg4yM0Bk+X+fTXiOY=;
 b=MCQwHwroIFtoQl7Pmuxk3lcWXq2wKHCB9iEDbRg0va4bcZymGmkZWXY4O2/HEzA+wC
 ze6P0z/IFkbNinC2pHyLIXFsBia/4kzQpg1ltRDpHtiUHWCEWvy4Lqh1JArLLmgt3F/Y
 2p6lIVNTYJ68yy9xtbKQ0WI7KX296VwM9g6SodskrBFUNi20LqkpTUIRa+9uEuEfG7cR
 Bypc5+oHC5B3Mts5v1ODMuTIPtTppP8S6a09YTCtUoZDK/FbGQnWGsRrcFWpG707mPJn
 O0TMpocKGxFqccADpg4iiFe09EexCnODWtvfh9GMRJnQ4zie+mEk6z0I/m6RMDqAutZO
 WZ3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+hzhIXoSVbD/oLqE6Iyn6JlT7/ICb404AszvNNyGPN5Z9Mdni86/QNhYEwz1NodsTtQGT1W1e4IVZil17vDkU7dOUQt0=
X-Gm-Message-State: AOJu0YxUnsPRjXQxrZmxcVhL/x41D2lv5uvgsnEuVqZ6F2NgJrU/1nwj
 ydNkLatgBDQ6dB8gtuUgaOOhcX2rtiieo9jLDZIpjbKU4eOb56JAQozgxDBlf+1EX5omhGZARIo
 mfIvQZLFQgOMUH02bXYixo66uDFUMfm0p/b/Od7sNAmRTUjlfJNze
X-Received: by 2002:a05:6512:10ce:b0:52c:e091:66e4 with SMTP id
 2adb3069b0e04-52eb99d2898mr10263306e87.44.1720785126198; 
 Fri, 12 Jul 2024 04:52:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9C9gbJGtnMPnZ+g8VChJGMHKNvlH/4EPBe3gmeB8REQXeq0JrgC+SYuGagmUjyivWIb7gNA==
X-Received: by 2002:a05:6512:10ce:b0:52c:e091:66e4 with SMTP id
 2adb3069b0e04-52eb99d2898mr10263284e87.44.1720785125800; 
 Fri, 12 Jul 2024 04:52:05 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-50-229.web.vodafone.de.
 [109.43.50.229]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7ff243sm340691766b.128.2024.07.12.04.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 04:52:05 -0700 (PDT)
Message-ID: <04471abc-34c3-4e49-89ea-1a61f828c535@redhat.com>
Date: Fri, 12 Jul 2024 13:52:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/8] tests/pytest: Add a function for extracting files
 from an archive
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-8-thuth@redhat.com> <ZpDz20mo-OWVOjI3@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZpDz20mo-OWVOjI3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/07/2024 11.14, Daniel P. Berrangé wrote:
> On Thu, Jul 11, 2024 at 01:55:45PM +0200, Thomas Huth wrote:
>> Some Avocado-based tests use the "archive" module from avocado.utils
>> to extract files from an archive. To be able to use these tests
>> without Avocado, we have to provide our own function for extracting
>> files. Fortunately, there is already the tarfile module that will
>> provide us with this functionality, so let's just add a nice wrapper
>> function around that.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/pytest/qemu_pytest/utils.py | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 tests/pytest/qemu_pytest/utils.py
>>
>> diff --git a/tests/pytest/qemu_pytest/utils.py b/tests/pytest/qemu_pytest/utils.py
>> new file mode 100644
>> index 0000000000..4eb5e5d5e5
>> --- /dev/null
>> +++ b/tests/pytest/qemu_pytest/utils.py
>> @@ -0,0 +1,21 @@
>> +# Utilities for python-based QEMU tests
>> +#
>> +# Copyright 2024 Red Hat, Inc.
>> +#
>> +# Authors:
>> +#  Thomas Huth <thuth@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +import tarfile
>> +
>> +def archive_extract(archive, dest_dir, member=None):
>> +    with tarfile.open(archive) as tf:
>> +        if hasattr(tarfile, 'data_filter'):
> 
> Not convinced this is still needed. The python docs don't say anything
> about 'data_filter' being introduced after 3.0, so can likely
> assume it always exists.

According to https://docs.python.org/3/library/tarfile.html :

"Extraction filters were added to Python 3.12, but may be backported to 
older versions as security updates. To check whether the feature is 
available, use e.g. hasattr(tarfile, 'data_filter') rather than checking the 
Python version."

And it seems to be missing in Python 3.7, indeed:

  https://docs.python.org/3.7/library/tarfile.html

So as long as we still support this old version, I think I've got to keep 
this check.

  Thomas



