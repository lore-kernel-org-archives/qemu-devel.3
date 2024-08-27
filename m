Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D89C54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 12:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sivJM-0001eQ-2n; Tue, 27 Aug 2024 08:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sivJJ-0001dt-DS
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sivJH-0007c5-UP
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724761710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NBBSboV3lgfNvqybX9imB3QXNXC2gVPIDNZxk0AXLG8=;
 b=L59tKnG/YO4PX8wtpqd5fvit84+X7u+yRat0DNzweXz7vTB7os4w7lX05AXa6rqE5GH52w
 Fg2zPTSRrL4jeBScmzdP9UDFEiw5dQotzFUNy6XtZ/0gvqLX3YXfC4fz+DGOLxU7dFAjZV
 xNg1nbBNMRKvZdtmMqgiAI/wlFMJGew=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-A3jA0P3pNJ2qucobihv7Xw-1; Tue, 27 Aug 2024 08:28:27 -0400
X-MC-Unique: A3jA0P3pNJ2qucobihv7Xw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37189fc2977so3062600f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 05:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724761706; x=1725366506;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NBBSboV3lgfNvqybX9imB3QXNXC2gVPIDNZxk0AXLG8=;
 b=iwefk8N4LBt1cPx4K6D7ks7HWvUrwBM3UrTFtTnv2FfDBCHVtL5cQioZI5VQw6NXVW
 NEASdc6f7Ey4aE+wEQRUEFNHaMPUQawc8fv9OY21j56ZNO3EVVqKmkKuu8le0jmLmZ8A
 zPCAywLvLhVlvr5ND9Olle7KnYMAVdf2y6tnRtxNfDkP5TAfbuaQ3JZfUHQe1Wp/ol7P
 DuJ27ftXAeZXH1kssI5jkYNtAzA9DGXD5NjeJe9cd5Dv1MMcCgxZn6P+0islEM47GoCv
 wZqviqq8AupS4yAcHsdErIMloMSXpTS71eSgU9E+yB6qpCxlOSaLO5NattlIhfG98w1D
 tASw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQb+wSZFRGpgpMGQTpd9q+ej5T6t0p76MHX4zRY6Zu2z2Qmr5cVY4MRNA2AG45IAWzbIicdJDzIfQ/@nongnu.org
X-Gm-Message-State: AOJu0YxYpzjz21plYylYWlWSCZNByjzhaVX/JWltkRnn564LYlR+TBWO
 68HQsAx2GuQrZYe7/hTb0448s1eCkIgE1TUfPtFptwwZiunCxsLAC8oFPa6MTMvAVIJAxS01F0I
 Oj2Ya/1Gf2bdCCbvR5PVVzFLWSwT8C/8oI8Hpagb0JwHeaTxKlPrwdsAnpeTE
X-Received: by 2002:adf:f40e:0:b0:36b:c126:fe6d with SMTP id
 ffacd0b85a97d-37311864ee2mr8845388f8f.24.1724761706407; 
 Tue, 27 Aug 2024 05:28:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdY7V/86jTWZDFEqgYTSMgVTsWW9yswKPX/MJB7pE5nkHFMjto87ZirfIL5jjUF8YQYePkgw==
X-Received: by 2002:adf:f40e:0:b0:36b:c126:fe6d with SMTP id
 ffacd0b85a97d-37311864ee2mr8845368f8f.24.1724761705855; 
 Tue, 27 Aug 2024 05:28:25 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-179-35.web.vodafone.de.
 [109.43.179.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308110436sm13033659f8f.11.2024.08.27.05.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 05:28:25 -0700 (PDT)
Message-ID: <5c834589-8666-43d5-8e89-40a36bac8916@redhat.com>
Date: Tue, 27 Aug 2024 14:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] tests/functional: Convert mips64el Fuloong2e
 avocado test (2/2)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <chenhuacai@kernel.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240824160829.27655-1-philmd@linaro.org>
 <20240824160829.27655-3-philmd@linaro.org>
 <e840b528-c48b-4b5e-9b2b-c7c0a0473ce7@redhat.com>
 <2f484cff-e227-47e3-b570-40e1945cee63@linaro.org>
 <2f741de8-84b5-4bdf-98a6-568139dfbfb9@redhat.com>
 <9910ebc8-b7c4-4505-a987-3a5e308fb3d1@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9910ebc8-b7c4-4505-a987-3a5e308fb3d1@linaro.org>
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

On 27/08/2024 11.16, Philippe Mathieu-Daudé wrote:
> On 27/8/24 07:27, Thomas Huth wrote:
>> On 26/08/2024 22.59, Philippe Mathieu-Daudé wrote:
>>> On 26/8/24 11:10, Thomas Huth wrote:
>>>> On 24/08/2024 18.08, Philippe Mathieu-Daudé wrote:
>>>>> Straight forward conversion. Update the SHA1 hashes to
>>>>> SHA256 hashes since SHA1 should not be used anymore nowadays.
>>>>>
>>>>> Add extract_from_deb() method in qemu_test.utils package.
>>>>
>>>> Should we maybe rather copy the whole LinuxKernelTest class into a new 
>>>> file in the qemu_tests folder, so that all the related tests can simply 
>>>> inherit from that class? That way we would also get the 
>>>> KERNEL_COMMON_COMMAND_LINE handling for free in all the tests that we 
>>>> convert. What do you think?
>>>
>>> Except that variable, I'm not sure what can be reused. Most tests
>>> are trivial. Maybe I'll realize after converting a few more :)
>>
>> Apart from that variable and the extract_from_* functions, that class is
> 
> I don't see extract_from_deb() and extract_from_rpm() being specific
> to a LinuxKernelTest class, IMO they belong to .utils with other
> helpers such archive_extract().

.deb and .rpm are quite specific to Linux distros, so IMHO it's fine to keep 
them in the LinuxKernelTest class.

> I haven't added extract_from_rpm() there since I'd need to convert
> a test using it to be able to test it, but it is planned.
> 
> Similarly image_pow2ceil_expand(), pow2ceil() and file_truncate()
> are generic, not restricted to Linux console tests.

Agreed, these seem to be very generic functions that should reside in utils 
instead.

  Thomas


