Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C09606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UNtzzrwX;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U5kL9XnV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWc5d-0002Q9-Pk; Thu, 26 Nov 2026 11:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xWc5c-0002Py-Iu
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 11:12:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xWc5a-0004dY-JP
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 11:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795709569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/5Aeyct3AmaIG3azlVekD6PC5lETH3x7aRyou8KXkDU=;
 b=UNtzzrwXajHzCXyHCwlsf4GT7QyVwzRbcBRGgd8739AdslOy/d5iVMPgIbUE57sNRimIVw
 kN8x674rBN8p/iCbyKCRu2xDVv3AqpaV5vk6pYP+ZYAFuB+3jS2tZiSuJSlBtG6Zg3cUNc
 xcWeoUC88nPu3IIlEe48MWv1mPcl6aU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-_fEs6DQxOJ2EILmt3RiY1A-1; Thu, 26 Nov 2026 16:12:46 +0000
X-MC-Unique: _fEs6DQxOJ2EILmt3RiY1A-1
X-Mimecast-MFC-AGG-ID: _fEs6DQxOJ2EILmt3RiY1A_1795709565
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a204f135ffso37537645e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 08:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795709565; x=1796314365; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/5Aeyct3AmaIG3azlVekD6PC5lETH3x7aRyou8KXkDU=;
 b=U5kL9XnVE2kspbwsaKilgk/GVgo8oGpH8PDx1W+dYnECSFQVYDstbNzevaGEwmPxIo
 sfM2LVXK74bnibwjOq1c4kH/b/DUyEA2fLdrYVkifBsRZ0GZMMYte/HQoZH4fi66OO3R
 joyYa9BpgfBm3WkxkeVIn+OJX8NfCruJEr93n/XOHnLeThDSdAZ4TGAVKGFdHy1zIkC+
 FD5JmZfvQXowBc2D05qZ8C7fAKuKxyR+jZpPmj5D5sIqKAy93WG6l46/+BladjsHul/y
 bpDaZEcmE7d0EKFXnQ3a8QWuevYHJJ44iLFNwcnJgG/+ThSus+Vis1RGHOlk96z/2L0X
 SZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795709565; x=1796314365;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/5Aeyct3AmaIG3azlVekD6PC5lETH3x7aRyou8KXkDU=;
 b=cJtH/MfgN93l8YT1gCp/b2bsfjZSK9aKc7Flqr2aDzEC3+N94SdLnnmjfVQnEMhk29
 oHxCgfDStJfNsk9rxtKe3QPjAbyXPvj1TNWAF0QLJ8J3xrrmMmnzooQHcBHgJ644mDnF
 d+5yf18OAxg2uL0qeJLZB/Pc8/c3DarPBTB9KD1X/eJojLGb2rBQaFaK6uOk8kyO4TPR
 DKoYrkjtH2nXnDZ/VjVZnbQkUECaV98kE//qhP5nBnGCYOPHVoFKdIpWcKImP/FQ3s8r
 4zEwd1UQCQePKP/v3sAC0oXs2v31sFXFhb/i6OkpVjUdHYjsAAhPAkcP2OKzdS0rxmS+
 d5Eg==
X-Forwarded-Encrypted: i=1;
 AL+hErFTdHCv1VKFtyroMkVHDDR+y4pedUOUS0SM/NVkiMiL7q3xHkwwg4iMDNiJv19nlWvtq56ReTVUEDOL@nongnu.org
X-Gm-Message-State: APuU4Z/9CluD2T1AXbKl53UNME12OV87HQ6dxec1dI8NhpmCYYJJB/HL
 J2/1x9BwSXEiRNpYw3EJqc3NGHwc+aHWz1pPfq7xY0ZTjgS+6zcri9g1MrzDlPpYunsTqp5ZttJ
 XhyY/JFm4jeIi2OjjSXavIK/LB2RR+2mmSE8EgHju5GWdaBCkCz28bUXT
X-Gm-Gg: AZFdTZccM/6Il9SyFCmbeBba+LYj2qL/IhJG+Eu3OLDBrApdhl+VIxD2K92eO+SSrdy
 0ZRo2kkc6I3C+gGy7AiUOSKwDa9dlPFtaHwy39C0aAE4WCV2/yMqi7I9Wa1bwvatYyZNEKeehuv
 s9ahxbtsI+mAUbw8L4TxQythNpKgk7uaNAnWAvLSxGSMJ+5D95Odbpll8JbLj1mtI4sk+zXTg2Q
 g4bRY2PyGJuIyqYqZ/scCzIyxdOUxQJYgM+Qd90bVg6B87DXqNdG47/E/EPgkns2VsWOb19zZ6D
 52ka8paZ6Mxc9MSaHF6g0/3gcYaHKYUzIxxlVUWzZ9b4qS6Dc9EGILRh6MZ3tHaCQAHW1OVEIeI
 jiuYTFZsSQisvRt5sXJDzPTL11iYXCuwHmAzR7CYPfLhTUw==
X-Received: by 2002:a05:600c:4e02:b0:4bb:5d39:95fa with SMTP id
 5b1f17b1804b1-4bb88811c82mr422023415e9.12.1795709565462; 
 Thu, 26 Nov 2026 08:12:45 -0800 (PST)
X-Received: by 2002:a05:600c:4e02:b0:4bb:5d39:95fa with SMTP id
 5b1f17b1804b1-4bb88811c82mr422022835e9.12.1795709564917; 
 Thu, 26 Nov 2026 08:12:44 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906d6a13sm339005545e9.3.2026.11.26.08.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 08:12:43 -0800 (PST)
Message-ID: <45e19ebc-3a11-4a53-b284-75665e5c0b05@redhat.com>
Date: Thu, 26 Nov 2026 17:12:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Increase the timeout of the
 device-introspect-test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
References: <20261026092313.480889-1-thuth@redhat.com>
 <87fqxs67ut.fsf@draig.linaro.org>
 <ffdb16f1-7a5a-487e-a9d6-74767ee399b8@redhat.com>
 <87y0bk4hf5.fsf@draig.linaro.org> <at95EXMAwxM8soAK@redhat.com>
 <at99ZdsGkAs7Hlyk@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <at99ZdsGkAs7Hlyk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 26.10.26 um 17:18 schrieb Daniel P. Berrangé:
> On Mon, Oct 26, 2026 at 04:00:17PM +0000, Daniel P. Berrangé wrote:
>> On Mon, Oct 26, 2026 at 03:20:46PM +0000, Alex Bennée wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> On 26/10/2026 12.04, Alex Bennée wrote:
>>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>>
>>>>>> I'm occasionally seeing timeouts of the device-introspect-test for
>>>>>> the aarch64 target when running "make check SPEED=thorough" - looks
>>>>>> like the 720 seconds aren't enough anymore nowadays. Add 2 more
>>>>>> minutes to give some more headroom.
>>>>> What is taking so long, I can run all the introspect builds in under
>>>>> 10
>>>>> seconds:
>>>>>     ➜  time ./run meson test --suite qtest "*device-introspect*"
>>>>
>>>> You've got to run the tests in slow/thorough mode:
>>>>
>>>> G_TEST_SLOW=1 time ./run meson test --suite qtest "*device-introspect*"
>>>>
>>>> otherwise a lot of the tests will be skipped and the tests will finish
>>>> fast.
>>>
>>>    env G_TEST_SLOW=1 QTEST_QEMU_BINARY=./qemu-system-aarch64 ./run time strace -e trace=read,write,recvfrom,sendto -c /home/alex/lsrc/qemu.git/builds/testing/tests/qtest/device-introspect-test --tap -k
>>>    ...
>>>    # slow test /aarch64/device/introspect/concrete/nodefaults/raspi0 executed in 30.19 secs
>>>    # End of nodefaults tests
>>>    # End of concrete tests
>>>    # End of introspect tests
>>>    # End of device tests
>>>    # End of aarch64 tests
>>>    % time     seconds  usecs/call     calls    errors syscall
>>>    ------ ----------- ----------- --------- --------- ----------------
>>>     99.61  793.101303           1 420646079           recvfrom
>>>      0.28    2.229951           3    619529           sendto
>>>      0.11    0.840259           4    179705           write
>>>      0.00    0.000000           0        14           read
>>>    ------ ----------- ----------- --------- --------- ----------------
>>>    100.00  796.171513           1 421445327           total
>>>    926.31user 3944.47system 1:28:16elapsed 91%CPU (0avgtext+0avgdata 1132064maxresident)k
>>>    43824inputs+0outputs (324major+7978563minor)pagefaults 0swaps
>>>
>>> So it looks like the majority of the runtime is just ploughing through
>>> 420M unix socket calls introspecting the same large set of non user
>>> creatable devices for every machine type. This will just get bigger and
>>> bigger every new device or machine we add.
>>
>> NB, you use G_TEST_SLOW so it iterates over all machines, the
>> default behaviour is just to test 'none' machine only, but....
>>
>> ...urgh, our JSON client parser reads data off the wire 1 byte
>> at a time....
>>
>> recvfrom(6, "{", 1, 0, NULL, NULL)      = 1
>> recvfrom(6, "\"", 1, 0, NULL, NULL)     = 1
>> recvfrom(6, "Q", 1, 0, NULL, NULL)      = 1
>> recvfrom(6, "M", 1, 0, NULL, NULL)      = 1
>> recvfrom(6, "P", 1, 0, NULL, NULL)      = 1
...
>> I fear this test suite is perhaps just exposing a scalability problem
>> of our JSON parser. I wonder how much quicker could it be if it read
>> data in chunks ....
> 
> To answer my own question - the problem is in tests/qtest/libqmp.c
> and fixing it cuts 35% off the normal execution time, and 99% off
> the executuion time under strace, with syscalls dropping from 8.6
> million to 9 thousand, for a single machine.
...
> libqmp.c has no global state to pass around, just a raw FD, so
> a real fix would have to wrap the FD in a "QTestQMPClient" struct
> to allow parallel usage.
I think I found another way to fix the issue, without doing a big 
refactoring: We can use MSG_PEEK to read the data without removing it from 
the socket queue, and then only consume the bytes that we really handled at 
the end:

  https://lore.kernel.org/qemu-devel/20261126160743.276957-1-thuth@redhat.com/

That should hopefully fix the timeout problems at least for a while.

  Thomas


