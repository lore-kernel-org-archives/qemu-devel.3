Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45439C19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCW9-0005ga-UN; Wed, 26 Feb 2025 03:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnCVx-0005dZ-RC
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:11:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnCVv-00017L-Hz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740557489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xUWKorFTNCpdFZrn1XEvEXKA/5AvKUjVFvJMnnQL7oE=;
 b=iYFIlzeIEn4gIdNeT8YqhYJhfd+Gt4WcGYSXsrOIpu7TwFtaZEqNYaIUQ+Y/6exARuQrZd
 hSM84dCYm9KYFtxnT0wjyl//BmjuSTti5VaBQFyOHvuIF39BGwLL+4PYsurw38cJbkFSS7
 ChfnoatP0AdNMnXbTr6nDZ5TNigq+pk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-rurqZ5gGOBGck0onMbB5Eg-1; Wed, 26 Feb 2025 03:11:25 -0500
X-MC-Unique: rurqZ5gGOBGck0onMbB5Eg-1
X-Mimecast-MFC-AGG-ID: rurqZ5gGOBGck0onMbB5Eg_1740557484
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-390de58dc4eso12889f8f.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 00:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740557484; x=1741162284;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xUWKorFTNCpdFZrn1XEvEXKA/5AvKUjVFvJMnnQL7oE=;
 b=VAi7n2GO651jAKibMj6ANOde7gZgsYGqtEE5lJZSBMJ+Iwha1zXHsHiJOjyEFNKhlX
 Y791I34If+xaRSJsWlj4DgQo0Klu7sDhAUblY51IZhWF6zuqIdGH7XcT19Z8rZo5XuJk
 8f5YptSvRK3cFU9Q2i+Xkhk3vCh8M4Zovc6pE/Q4wsREXAMnuzZT0SauidltaWDj/aL9
 2/RAC1B+O3TrHRF90aiOCU68z/Z5d8b+VOXDmIW5yTsv/MD5vyc0zyTCSc7ZU/1h0vrU
 SpOBDvc+Ti5+rezYSunUuUrbhwc3OfmTQkWbkTGKI21IcfJlNzZhseISnwO8cSTGX3Nm
 bOFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH5AXTuS+DYzQG1j8Dlnx0Yz7D75qor9LNi3LUfIT1cN3QvxQZ/eSQTEePfqPZEADL6ePh3OF1olgq@nongnu.org
X-Gm-Message-State: AOJu0YxmIS4DGWTZjcnG7XMOVNEbtJQGe6hOrYRrBCQQNYamCX76gSfn
 QDMjYan13jrFjZ3k3PHaSwG0nzUhmTklq9h7pNHmzyQpefU8PNIDanMPLqvIbYn1JVOdaYwE9ep
 vu/RBBZy0n+ROCbxt1RZGP9w1uf22TSCJBWYKUttGEefGTlPcppf4
X-Gm-Gg: ASbGncsolc/O+yysT/403FaPbXu251SIc+y5tNIIENL+/xxwjPaAXiUFQ9KmUMv3xvU
 cDC0gDSYNPhP5JeFyqT36cBKkRo9q195nIwV0EKzdLt1Tj5TXc4de32IuPr2LSDtIma3K0aZhW5
 Neef1RNrk1m/j6NlivACNU5lIXVx1djD4HvE576FmvftMkKfNxt1c/HswcYupc3k1DvkKW4rEtK
 uKFdi8C7ppP9dZGxHiIDpTmoKfhMr8p7GVnm+xvji+oEmNYkfZHXzQis8qVuxXpJ99GKSdMtrDA
 TvdoK8hOjpTTVHJW90+NN4IR1rCw/NDFZm9MFSV0/ijnlLQ=
X-Received: by 2002:a05:6000:1f8f:b0:38c:5e03:5bb with SMTP id
 ffacd0b85a97d-390cc631b1bmr6142197f8f.41.1740557483757; 
 Wed, 26 Feb 2025 00:11:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzhXLV3r5G3Vo+NtYsa5FwQag0maN4Dgx/ejFe9NqoRI7zNnBxebvXogRkMDJ8xRKYaojZrQ==
X-Received: by 2002:a05:6000:1f8f:b0:38c:5e03:5bb with SMTP id
 ffacd0b85a97d-390cc631b1bmr6142171f8f.41.1740557483438; 
 Wed, 26 Feb 2025 00:11:23 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8667e0sm4768605f8f.10.2025.02.26.00.11.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 00:11:22 -0800 (PST)
Message-ID: <9500f130-c3b4-44c0-b51a-070429756a36@redhat.com>
Date: Wed, 26 Feb 2025 09:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Update the ppc64 pseries and pnv tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250226065401.197915-1-clg@redhat.com>
 <d61872e1-2eca-4af7-a135-96659ec5fb6e@redhat.com>
 <cb6e9bb4-5eee-4492-abe0-073ecf586267@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <cb6e9bb4-5eee-4492-abe0-073ecf586267@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 26/02/2025 08.54, Cédric Le Goater wrote:
> On 2/26/25 08:01, Thomas Huth wrote:
>> On 26/02/2025 07.54, Cédric Le Goater wrote:
>>> The tests are using a now archived Fedora29 release. Switch to the
>>> most recent Fedora41 release.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   tests/functional/test_ppc64_powernv.py | 6 +++---
>>>   tests/functional/test_ppc64_pseries.py | 6 +++---
>>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/ 
>>> test_ppc64_powernv.py
>>> index 685e2178ed78..a9da7905366e 100755
>>> --- a/tests/functional/test_ppc64_powernv.py
>>> +++ b/tests/functional/test_ppc64_powernv.py
>>> @@ -18,9 +18,9 @@ class powernvMachine(LinuxKernelTest):
>>>       good_message = 'VFS: Cannot open root device'
>>>       ASSET_KERNEL = Asset(
>>> -        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
>>> -         'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
>>> -        '383c2f5c23bc0d9d32680c3924d3fd7ee25cc5ef97091ac1aa5e1d853422fc5f')
>>> +        ('https://archives.fedoraproject.org/pub/fedora-secondary/'
>>> +         'releases/41/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
>>> +        'eca627adbe42437cacea169beeb4c3c12a5cfbca1a6b1ba5218d28139d2143c4')
>>
>> I think we should rather avoid the very latest and greatest Fedora URLs 
>> here... they will be invalid in a couple of months after Fedora 43 has 
>> been released. And if we keep switching the test assets all the time, this 
>> will make it more difficult to bisect regressions in the future.
>>
>>   Thomas
>>
> 
> So we should point to the latest archive (fedora38) then ?

Either that, or simply keep the f29 kernel ... what do we gain by switching 
to a newer one here? Is it testing more hardware?

  Thomas


