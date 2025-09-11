Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B2DCAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 09:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwdUc-0004y8-9l; Thu, 11 Sep 2025 05:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwdUZ-0004pV-A5
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 05:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwdUT-00008j-KJ
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 05:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757582471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G6LOG5shaxqsug3q02nt/u9bpLCOQq2UtK7lHmPc/V8=;
 b=JFt6+L3mNMVT3RvNaG5dSMp81za72YxAetlu3U4jqXVb9zT0Nj2xxjKEAxLSN+YD69ZmyO
 Kt21J4aqYPnBl4Sz27abu202MaQ1Xskx56CmEBTKutNiD4cauam3l7tDEoz/kuGOcsgLss
 uMzEyIELnUT/4YH9xJDWIYPpGcMeo0g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654--SEutTRcMk6GJVJawthXSA-1; Thu, 11 Sep 2025 05:21:10 -0400
X-MC-Unique: -SEutTRcMk6GJVJawthXSA-1
X-Mimecast-MFC-AGG-ID: -SEutTRcMk6GJVJawthXSA_1757582469
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45cb612d362so2963105e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 02:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757582469; x=1758187269;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G6LOG5shaxqsug3q02nt/u9bpLCOQq2UtK7lHmPc/V8=;
 b=RA9xd2NzdO69khoWKH5HoHtlTutxSKEJ/bDXhEc8GLWrEgs+tOkSsQCUCn2/NAe7gZ
 h+EO6jmgx6cBSZBbFYxoYiMXM5+JQ1do07PG5MRfaFawhUUW4t6vgWjtRPpkmwCgvxq4
 wNXPgDktZ6kBIcoAF2TfcUN1zJjzkLdXvXmIJqKvv+fJYAC8cPV0IZLo3qUhE6uWxJQV
 RMyLtN7KBVrmoUHsOUhLDsADkrgBFL0QEA+QxBn7Kpm5eHPPW6cZKDBCUrVQBBBU/v5+
 fix4fGYJeznTC78R6COTjkrmLylpqeGfen3Oj3bDqpM4ycSov2RPK50TOWYtX+rrm3O7
 mYKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgHOQ+t3OykJ8Xoc3Lg4icgMte2AbUtrDvvykWPPDNio7NYL4qGlJkAtxNzihxD3RoZwN1VVQwC5Ss@nongnu.org
X-Gm-Message-State: AOJu0YwDagQmPt0cpYlhiUUO8yrxVyb80XbsoJPmSsTptoAQUC1PZXHL
 KK6Em66aEt3WlVzJ5X2VgVjAFDNmADnVnIEUmKHNKrXeawVoZohF1kOmPft20tqlWMip/CamyNn
 85xsxpaCvOvsXP5pb/HH/nOndCzgixd5u/y1bhvSfn4QhNGlC/f/chlR6
X-Gm-Gg: ASbGncvOBW5CmrOkqC/KebjsJZMm7tiqAdxcldMnE3c2NiWlLTCv7fGaqQ8WxbQbc0C
 k1bK82KpOEaXVMj3U1S7L58f9jQ3C4QKx39VzzJQ9J7/M81qri5+u5jdbJaQIfAerng+y7Sm/q8
 VjfTMiNZyEXE2rkIM/1jbZyBdZ+wIgUwwK996zDo3Ef6wA98F89nYjA/Vqi5GxQyO+p1kRjFGMn
 QjC9Z39/u2ZJBuuE1ZfgMzc0+ZlZ2lZV87k53PKmpQMZdyKlwGPCny8VaDaxQwWAs12et6XYtni
 M1Gq6KOSjlXjbxJ2Pui/li82stwBfKxTdv0Tw4/0fSg8sDFXTvL7UDtZCkOGzKcbzLuFsAZ1Jz1
 snbxxlg==
X-Received: by 2002:a05:600c:3b83:b0:45d:e326:96fb with SMTP id
 5b1f17b1804b1-45de3269948mr161794625e9.30.1757582468699; 
 Thu, 11 Sep 2025 02:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHavDATIBe1wRjy6dSrbdIASpviJdY2tVpJGpAA8EKsNfLYUhdVqrb8mGokzo7e9BnrXVyCLQ==
X-Received: by 2002:a05:600c:3b83:b0:45d:e326:96fb with SMTP id
 5b1f17b1804b1-45de3269948mr161794315e9.30.1757582468226; 
 Thu, 11 Sep 2025 02:21:08 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037c3ee8sm16513145e9.18.2025.09.11.02.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 02:21:07 -0700 (PDT)
Message-ID: <44a367bd-5242-4ddc-ad3e-b3dc718f549b@redhat.com>
Date: Thu, 11 Sep 2025 11:21:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] tests/functional: add tests for SCLP event CPI
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250812123124.382696-1-shalini@linux.ibm.com>
 <79a95a4349a8e97f65717139857432741701d489.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <79a95a4349a8e97f65717139857432741701d489.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/09/2025 11.05, Nina Schoetterl-Glausch wrote:
> On Tue, 2025-08-12 at 14:31 +0200, Shalini Chellathurai Saroja wrote:
>> Add tests for SCLP event type Control-Program Identification
>> (CPI) to s390x CCW virtio tests.
>>
>> Please note that these tests are skipped as the guest OS does not
>> trigger the SCLP event type CPI when the command
>> 'echo 1 > /sys/firmware/cpi/set' is executed in the guest. I
>> believe that the guest OS must to be updated to support the SCLP
>> event type CPI.
>>
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/test_s390x_ccw_virtio.py | 24 +++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/tests/functional/test_s390x_ccw_virtio.py b/tests/functional/test_s390x_ccw_virtio.py
>> index 453711aa0f..c14379cbaa 100755
>> --- a/tests/functional/test_s390x_ccw_virtio.py
>> +++ b/tests/functional/test_s390x_ccw_virtio.py
> 
> Is this the best file to put it?
> It seems mostly to be about device testing.

It's meant as generic testing of the s390-virtio-ccw machine. Of course, the 
CPI testing could also be done in a separate file, but that means that you 
have to go through booting of the guest there again ... so I'd rather prefer 
to keep it here, so we only have to boot the guest once.

  Thomas


