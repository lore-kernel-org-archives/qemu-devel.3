Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905ADCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 09:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v79iJ-0004kT-Cy; Fri, 10 Oct 2025 05:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v79iH-0004kE-E4
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 05:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v79i9-0005y1-Pi
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 05:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760089609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b34lR1ofo8c1Qfx6Y9g7z6Fbr/HCV4kVIb20Y8j2NSw=;
 b=M9jXqJzyEV3kF79+eE1Br/Idn81qi4JHR1AsaNbnnCVazx/ywPJOlvgse/bDO+V2jgtRof
 VMwncmMkWBDA5IMBuyacIU0pnc9iuim6/oGsL6PP4Gh806/FNZRhuSiPP9i5ODVHQs5vBP
 VfvbUrrI6ystfcaOmz4OgoDbPQi+/kE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-jtQfIYWpPp2OE6dGlJfzsQ-1; Fri, 10 Oct 2025 05:46:48 -0400
X-MC-Unique: jtQfIYWpPp2OE6dGlJfzsQ-1
X-Mimecast-MFC-AGG-ID: jtQfIYWpPp2OE6dGlJfzsQ_1760089608
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b504dd6dbf1so162256966b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 02:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760089607; x=1760694407;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b34lR1ofo8c1Qfx6Y9g7z6Fbr/HCV4kVIb20Y8j2NSw=;
 b=W3RYh9T65f1VNxMlQ/pkPVtnNSdOezmnuKJbGKPlzPi38V1NtAyF0BgtXPUTIEMDvq
 A2EsRmn9MLeFdHIR9Tk6HjePG/8jWqORGOIRXB/mdsrt0IEUF9fs0zo/J6DSeIs6imAz
 ajJLYhNbDwzmDEmUKU7o01bUwejflprdNmopCNOorllTdKbYjI1hmbYg//q4VQhupV6D
 O5Ub+2j+DlHWnNA8eJxTq0eugFMRkYP86OVW15Wpw78g+pq+GKVByRIIvzWvOJHjbsXQ
 kX9AqT6UMWjeMjAoVAUE34y6+4ynVThrfq8Ikuae5VyI2nniEM1NdF/34bTML0kDbM96
 LD1A==
X-Gm-Message-State: AOJu0YxHKX7RVSpJ8VHDEQnHPFSuWnvek595iJvMZq43vhffaSdc6aEM
 N23prytAAUy0l1JvdaXgmtc9BIHpipDrfTq1On0EktRQopqpGAAYGa2CxhUSxE6QTG/L8BOuwxw
 EYdz4qHxBRLW+eU2L1hC+695Dw94HTwP4M/K8hHx789tE4MKPfrqkYrDep9LxGtyW
X-Gm-Gg: ASbGncsMJfj9KHwW6UsA/2VR9FWzj/+9eyarelm1EiRLqoHmMCZJonIdqDTCPQhEkTg
 sk8YVHeOOroqQ4K8IbtsmtStZa6ueaeJpLK0KHJXLJOfnZ8a0WOERC/o2R3+E2b+mtAqWGgCuI9
 nzciFoZ0v82zDXhBJJEL2xhTcbmULL7/BfnlodTF5J9Zt5TPck3fn9q+y2ZBirHGmmX9+Ebi3Jp
 YJVvMUN6ScHwjnWbVwABihvCGmU26XNaFkzNPrZrS9Z1N3V+kmrs71njPy+X9lbMOy35ax/J9Al
 +LFpLxEjTeGATVsF7X8HIfN1hOIvNOio8fiZ0Pr6Se4T6HOvf14yrZdreVyFBfdAYovMBNHbkW+
 M0rvC
X-Received: by 2002:a17:906:abc4:b0:b46:1db9:cb76 with SMTP id
 a640c23a62f3a-b50aba9f7aemr932670066b.39.1760089607523; 
 Fri, 10 Oct 2025 02:46:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRbQsF2vBsWZS56qcuOClV1x3+hsyovEARoJ1Au+REjzjXs1/mgRgWUfrBmFOCjLbI3lpCJQ==
X-Received: by 2002:a17:906:abc4:b0:b46:1db9:cb76 with SMTP id
 a640c23a62f3a-b50aba9f7aemr932662966b.39.1760089605947; 
 Fri, 10 Oct 2025 02:46:45 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d61d04dfsm191082766b.22.2025.10.10.02.46.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 02:46:45 -0700 (PDT)
Message-ID: <906535c5-515d-4960-b633-63b137f5f635@redhat.com>
Date: Fri, 10 Oct 2025 11:46:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: Set current time stamp of assets
 when using them
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251010093244.807544-1-thuth@redhat.com>
 <20251010093244.807544-2-thuth@redhat.com> <aOjUPd5pu1C0sDaf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aOjUPd5pu1C0sDaf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/10/2025 11.39, Daniel P. Berrangé wrote:
> On Fri, Oct 10, 2025 at 11:32:42AM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> We are going to remove obsolete assets from the cache, so keep
>> the time stamps of the assets that we use up-to-date to have a way
>> to detect stale assets later.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/qemu_test/asset.py | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
>> index 2971a989d1e..251953ed99f 100644
>> --- a/tests/functional/qemu_test/asset.py
>> +++ b/tests/functional/qemu_test/asset.py
>> @@ -10,6 +10,7 @@
>>   import os
>>   import stat
>>   import sys
>> +import time
>>   import unittest
>>   import urllib.request
>>   from time import sleep
>> @@ -113,6 +114,11 @@ def _wait_for_other_download(self, tmp_cache_file):
>>           self.log.debug("Time out while waiting for %s!", tmp_cache_file)
>>           raise
>>   
>> +    def _save_time_stamp(self):
>> +        with open(self.cache_file.with_suffix(".stamp"), 'w',
>> +                  encoding='utf-8') as fh:
>> +            fh.write(f"{int(time.time())}")
> 
> Rather than creating a parallel timestamp file, it feels like we could
> just call  'os.utime(self.cache_file)' which will set atime + mtime
> to the current timestamp, which we can check later with os.stat().

That was my first idea, too (sorry, I should maybe have mentioned it in the 
patch description), but it does not work: In the gitlab CI runners, the 
files get re-initialized from the runners cache each time the functional 
test job is started, so the atime and mtime is always close to the the 
current date there --> we would never expire files in the gitlab CI that way.

  Thomas


